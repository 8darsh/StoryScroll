//
//  SignInViewController.swift
//  StoryScroll
//
//  Created by Adarsh Singh on 03/10/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
class SignInViewController: UIViewController {
    
    @IBOutlet weak var signInButton: GIDSignInButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if GIDSignIn.sharedInstance.hasPreviousSignIn(){
            let vc = self.storyboard?.instantiateViewController(identifier: "TabBarViewController") as! TabBarViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if GIDSignIn.sharedInstance.hasPreviousSignIn(){
            let vc = self.storyboard?.instantiateViewController(identifier: "TabBarViewController") as! TabBarViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            let vc = self.storyboard?.instantiateViewController(identifier: "TabBarViewController") as! TabBarViewController
            self.navigationController?.pushViewController(vc, animated: true)
          guard error == nil else {
        return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            // ...
              return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { result, error in

             
            }
        }
    }
    
    


}
