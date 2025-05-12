# Custom Zsh Themes

This repository contains a collection of custom themes for Zsh (Z Shell). Zsh themes allow you to customize the appearance of your terminal prompt, including colors, symbols, and information displayed.

## Available Themes

*   **yonko.zsh-theme**: A theme inspired by the Yonko from One Piece.

## Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/zsh-themes.git ~/.zsh/themes/custom-zsh-themes
    ```
    (Replace `your-username` with your actual GitHub username if you fork this repository, or use the appropriate clone URL.)

2.  **Activate a theme:**
    To use one of the themes, you need to set the `ZSH_THEME` variable in your `.zshrc` file. For example, to use the `yonko` theme:
    ```bash
    echo 'ZSH_THEME="custom-zsh-themes/yonko"' >> ~/.zshrc
    ```
    Make sure the path `custom-zsh-themes/yonko` correctly points to where you cloned the `yonko.zsh-theme` file. If you cloned it directly into your oh-my-zsh custom themes directory, it might be simpler.

    Alternatively, you can source the theme file directly in your `.zshrc`:
    ```bash
    echo 'source ~/.zsh/themes/custom-zsh-themes/yonko.zsh-theme' >> ~/.zshrc
    ```

3.  **Apply changes:**
    Open a new terminal window or source your `.zshrc` file:
    ```bash
    source ~/.zshrc
    ```

## Using the `install.sh` script

This repository also includes an `install.sh` script that can help automate the installation of the themes.

To use the script:
1.  Make it executable:
    ```bash
    chmod +x install.sh
    ```
2.  Run the script:
    ```bash
    ./install.sh
    ```
    The script will guide you through the installation process.

## Contributing

Feel free to contribute your own themes or improvements!
