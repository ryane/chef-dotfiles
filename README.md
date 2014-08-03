dotfiles Cookbook
=================
This cookbook installs the dotfiles from https://github.com/ryane/dotfiles

Requirements
------------
#### packages
- `git` - dotfiles needs git.

Attributes
----------
#### dotfiles::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Example</th>
  </tr>
  <tr>
    <td><tt>['dotfiles']['user']</tt></td>
    <td>String</td>
    <td>the user you are installing dotfiles for</td>
    <td><tt>vagrant</tt></td>
  </tr>
  <tr>
    <td><tt>['dotfiles']['group']</tt></td>
    <td>String</td>
    <td>the group</td>
    <td><tt>vagrant</tt></td>
  </tr>
</table>

Usage
-----
#### dotfiles::default

Just include `dotfiles` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[dotfiles]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Ryan Eschinger
