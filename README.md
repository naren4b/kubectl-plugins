# kubectl-plugins

A personal collection of custom `kubectl` plugins. Each plugin is placed on `$PATH` and auto-discovered by kubectl.

## Installation

Copy any plugin to a directory on your `$PATH`:

```bash
chmod +x <plugin-file>
sudo cp <plugin-file> /usr/local/bin/
```

---

## Plugins

### `kubectl all-images`

**File:** `kubectl-all-images.sh` | **Language:** Bash

Lists all container images running across pods, grouped and deduplicated.

**Usage:**

```bash
# Current namespace (uses current kubeconfig context)
kubectl all-images

# All namespaces
kubectl all-images -A

# Specific namespace
kubectl all-images -n <namespace>
```

**Output format:** `<namespace>  <image>  [<image2> ...]`

---

### `kubectl argo tree`

**File:** `kubectl-argo-tree` | **Language:** Python 3 (stdlib only)

Prints an ArgoCD Application hierarchy as a colored tree, starting from the root app down to all descendants. Highlights the target app with `★` and color-codes sync/health status.

**Usage:**

```bash
kubectl argo tree <app-name> [flags]
```

**Flags:**

| Flag | Default | Description |
|------|---------|-------------|
| `-n, --namespace` | `argocd` | ArgoCD namespace |
| `--focus` | off | Show only the ancestor path + target's subtree (hides sibling branches) |
| `--no-color` | off | Disable ANSI color output |

**Examples:**

```bash
# Show full hierarchy tree for an app
kubectl argo tree my-argocd-app

# Show only the ancestor path and the app's own subtree
kubectl argo tree my-argocd-app --focus

# Custom namespace, no color (useful for piping/logging)
kubectl argo tree my-argocd-app -n argocd --no-color
```

**Node format:**

```
<name> (<app-level>)  <sync-status>/<health-status>
```

- **Sync:** `Synced` (green), `OutOfSync` (yellow)
- **Health:** `Healthy` (green), `Progressing` (yellow), `Degraded`/`Missing` (red)

**Requirements:** `kubectl` in `$PATH` with access to `applications.argoproj.io` resources in the ArgoCD namespace.

---

## Plugin Inventory

| Plugin | Command | Language | Purpose |
|--------|---------|----------|---------|
| `kubectl-all-images.sh` | `kubectl all-images` | Bash | List container images across pods |
| `kubectl-argo-tree` | `kubectl argo tree` | Python 3 | ArgoCD application hierarchy tree |
