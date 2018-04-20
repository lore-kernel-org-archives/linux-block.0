Return-Path: <jgross@suse.com>
Subject: Re: [PATCH 2/3] xen netback: add fault injection facility
To: Stanislav Kinsburskii <staskins@amazon.com>
Cc: jakub.kicinski@netronome.com, hpa@zytor.com, mcroce@redhat.com,
 tglx@linutronix.de, ggarcia@abra.uab.cat, daniel@iogearbox.net,
 x86@kernel.org, mingo@redhat.com, xen-devel@lists.xenproject.org,
 axboe@kernel.dk, konrad.wilk@oracle.com, amir.jer.levy@intel.com,
 paul.durrant@citrix.com, stefanha@redhat.com, dsa@cumulusnetworks.com,
 boris.ostrovsky@oracle.com, linux-block@vger.kernel.org,
 wei.liu2@citrix.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, dwmw@amazon.co.uk, roger.pau@citrix.com
References: <20180420104603.17823.31095.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
 <20180420104731.17823.97617.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <e33c055c-5a5a-2329-7a2e-faf715bb95fc@suse.com>
Date: Fri, 20 Apr 2018 13:25:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180420104731.17823.97617.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 20/04/18 12:47, Stanislav Kinsburskii wrote:
> This patch adds wrapper helpers around generic Xen fault inject facility.
> The major reason is to keep all the module fault injection directories
> in a dedicated subdirectory instead of Xen fault inject root.
> 
> IOW, when using these helpers, per-device and named by device name fault
> injection control directories will appear under the following directory:
> - /sys/kernel/debug/xen/fault_inject/xen-netback/
> instead of:
> - /sys/kernel/debug/xen/fault_inject/
> 
> Signed-off-by: Stanislav Kinsburskii <staskins@amazon.com>
> CC: Wei Liu <wei.liu2@citrix.com>
> CC: Paul Durrant <paul.durrant@citrix.com>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: Matteo Croce <mcroce@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Daniel Borkmann <daniel@iogearbox.net>
> CC: Gerard Garcia <ggarcia@deic.uab.cat>
> CC: David Ahern <dsa@cumulusnetworks.com>
> CC: Juergen Gross <jgross@suse.com>
> CC: Amir Levy <amir.jer.levy@intel.com>
> CC: Jakub Kicinski <jakub.kicinski@netronome.com>
> CC: linux-kernel@vger.kernel.org
> CC: netdev@vger.kernel.org
> CC: xen-devel@lists.xenproject.org
> CC: Stanislav Kinsburskii <staskins@amazon.com>
> CC: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  drivers/net/Kconfig                  |    8 ++
>  drivers/net/xen-netback/Makefile     |    1 
>  drivers/net/xen-netback/common.h     |    3 +
>  drivers/net/xen-netback/netback.c    |    3 +
>  drivers/net/xen-netback/netback_fi.c |  119 ++++++++++++++++++++++++++++++++++
>  drivers/net/xen-netback/netback_fi.h |   35 ++++++++++
>  drivers/net/xen-netback/xenbus.c     |    6 ++
>  7 files changed, 175 insertions(+)
>  create mode 100644 drivers/net/xen-netback/netback_fi.c
>  create mode 100644 drivers/net/xen-netback/netback_fi.h
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 8918466..5cc9acd 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -465,6 +465,14 @@ config XEN_NETDEV_BACKEND
>  	  compile this driver as a module, chose M here: the module
>  	  will be called xen-netback.
>  
> +config XEN_NETDEV_BACKEND_FAULT_INJECTION
> +	  bool "Xen net-device backend driver fault injection"
> +	  depends on XEN_NETDEV_BACKEND
> +	  depends on XEN_FAULT_INJECTION
> +	  default n
> +	  help
> +	    Allow to inject errors to Xen backend network driver
> +
>  config VMXNET3
>  	tristate "VMware VMXNET3 ethernet driver"
>  	depends on PCI && INET
> diff --git a/drivers/net/xen-netback/Makefile b/drivers/net/xen-netback/Makefile
> index d49798a..28abcdc 100644
> --- a/drivers/net/xen-netback/Makefile
> +++ b/drivers/net/xen-netback/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_XEN_NETDEV_BACKEND) := xen-netback.o
>  
>  xen-netback-y := netback.o xenbus.o interface.o hash.o rx.o
> +xen-netback-$(CONFIG_XEN_NETDEV_BACKEND_FAULT_INJECTION) += netback_fi.o
> diff --git a/drivers/net/xen-netback/common.h b/drivers/net/xen-netback/common.h
> index a46a1e9..30d676d 100644
> --- a/drivers/net/xen-netback/common.h
> +++ b/drivers/net/xen-netback/common.h
> @@ -286,6 +286,9 @@ struct xenvif {
>  
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *xenvif_dbg_root;
> +#ifdef CONFIG_XEN_NETDEV_BACKEND_FAULT_INJECTION
> +	void *fi_info;
> +#endif
>  #endif
>  
>  	struct xen_netif_ctrl_back_ring ctrl;
> diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
> index a27daa2..ecc416e 100644
> --- a/drivers/net/xen-netback/netback.c
> +++ b/drivers/net/xen-netback/netback.c
> @@ -33,6 +33,7 @@
>   */
>  
>  #include "common.h"
> +#include "netback_fi.h"
>  
>  #include <linux/kthread.h>
>  #include <linux/if_vlan.h>
> @@ -1649,6 +1650,7 @@ static int __init netback_init(void)
>  			PTR_ERR(xen_netback_dbg_root));
>  #endif /* CONFIG_DEBUG_FS */
>  
> +	(void) xen_netbk_fi_init();

This is the only usage of xen_netbk_fi_init(). Why don't you make it
return void from the beginning?

>  	return 0;
>  
>  failed_init:
> @@ -1659,6 +1661,7 @@ module_init(netback_init);
>  
>  static void __exit netback_fini(void)
>  {
> +	xen_netbk_fi_fini();
>  #ifdef CONFIG_DEBUG_FS
>  	if (!IS_ERR_OR_NULL(xen_netback_dbg_root))
>  		debugfs_remove_recursive(xen_netback_dbg_root);
> diff --git a/drivers/net/xen-netback/netback_fi.c b/drivers/net/xen-netback/netback_fi.c
> new file mode 100644
> index 0000000..47541d0
> --- /dev/null
> +++ b/drivers/net/xen-netback/netback_fi.c
> @@ -0,0 +1,119 @@
> +/*
> + * Fault injection interface for Xen backend network driver
> + *
> + * Copyright 2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation; or, when distributed
> + * separately from the Linux kernel or incorporated into other
> + * software packages, subject to the following license:

SPDX again.

> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this source file (the "Software"), to deal in the Software without
> + * restriction, including without limitation the rights to use, copy, modify,
> + * merge, publish, distribute, sublicense, and/or sell copies of the Software,
> + * and to permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
> + * IN THE SOFTWARE.
> + */
> +
> +#include "common.h"
> +
> +#include <linux/debugfs.h>
> +
> +#include <xen/fault_inject.h>
> +#include "netback_fi.h"
> +
> +static struct dentry *vif_fi_dir;
> +
> +static const char *xenvif_fi_names[] = {
> +};
> +
> +struct xenvif_fi {
> +	struct dentry *dir;
> +	struct xen_fi *faults[XENVIF_FI_MAX];
> +};
> +
> +int xen_netbk_fi_init(void)
> +{
> +	vif_fi_dir = xen_fi_dir_create("xen-netback");
> +	if (!vif_fi_dir)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +void xen_netbk_fi_fini(void)
> +{
> +	debugfs_remove_recursive(vif_fi_dir);
> +}
> +
> +void xenvif_fi_fini(struct xenvif *vif)
> +{
> +	struct xenvif_fi *vfi = vif->fi_info;
> +	int fi;
> +
> +	if (!vif->fi_info)
> +		return;
> +
> +	vif->fi_info = NULL;
> +
> +	for (fi = 0; fi < XENVIF_FI_MAX; fi++)
> +		xen_fi_del(vfi->faults[fi]);
> +	debugfs_remove_recursive(vfi->dir);
> +	kfree(vfi);
> +}
> +
> +int xenvif_fi_init(struct xenvif *vif)
> +{
> +	struct dentry *parent;
> +	struct xenvif_fi *vfi;
> +	int fi, err = -ENOMEM;
> +
> +	parent = vif_fi_dir;
> +	if (!parent)
> +		return -ENOMEM;
> +
> +	vfi = kmalloc(sizeof(*vfi), GFP_KERNEL);
> +	if (!vfi)
> +		return -ENOMEM;
> +
> +	vfi->dir = debugfs_create_dir(vif->dev->name, parent);
> +	if (!vfi->dir)
> +		goto err_dir;
> +
> +	for (fi = 0; fi < XENVIF_FI_MAX; fi++) {
> +		vfi->faults[fi] = xen_fi_dir_add(vfi->dir,
> +				xenvif_fi_names[fi]);

How does this work? xenvif_fi_names[] is an empty array and this is the
only reference to it. Who is allocating the memory for that array?

> +		if (!vfi->faults[fi])
> +			goto err_fault;
> +	}
> +
> +	vif->fi_info = vfi;
> +	return 0;
> +
> +err_fault:
> +	for (; fi > 0; fi--)
> +		xen_fi_del(vfi->faults[fi]);

What about vfi->faults[0] ?

> +	debugfs_remove_recursive(vfi->dir);
> +err_dir:
> +	kfree(vfi);
> +	return err;
> +}
> +
> +bool xenvif_should_fail(struct xenvif *vif, xenvif_fi_t type)
> +{
> +	struct xenvif_fi *vfi = vif->fi_info;
> +
> +	return xen_should_fail(vfi->faults[type]);
> +}
> diff --git a/drivers/net/xen-netback/netback_fi.h b/drivers/net/xen-netback/netback_fi.h
> new file mode 100644
> index 0000000..895c6a6
> --- /dev/null
> +++ b/drivers/net/xen-netback/netback_fi.h
> @@ -0,0 +1,35 @@
> +#ifndef _XEN_NETBACK_FI_H
> +#define _XEN_NETBACK_FI_H
> +
> +struct xen_fi;

Why?

> +
> +typedef enum {
> +	XENVIF_FI_MAX
> +} xenvif_fi_t;

It would have helped if you had added some users of the stuff you are
adding here. This enum just looks weird this way.

> +
> +#ifdef CONFIG_XEN_NETDEV_BACKEND_FAULT_INJECTION
> +
> +int xen_netbk_fi_init(void);
> +void xen_netbk_fi_fini(void);
> +
> +void xenvif_fi_fini(struct xenvif *vif);
> +int xenvif_fi_init(struct xenvif *vif);
> +
> +bool xenvif_should_fail(struct xenvif *vif, xenvif_fi_t type);
> +
> +#else
> +
> +static inline int xen_netbk_fi_init(void) { return 0; }
> +static inline void xen_netbk_fi_fini(void) { }
> +
> +static inline void xenvif_fi_fini(struct xenvif *vif) { }
> +static inline int xenvif_fi_init(struct xenvif *vif) { return 0; }
> +
> +static inline bool xenvif_should_fail(struct xenvif *vif, xenvif_fi_t type)
> +{
> +	return false;
> +}
> +
> +#endif /* CONFIG_XEN_NETDEV_BACKEND_FAULT_INJECTION */
> +
> +#endif /* _XEN_NETBACK_FI_H */
> diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
> index e1aef25..c775ee0 100644
> --- a/drivers/net/xen-netback/xenbus.c
> +++ b/drivers/net/xen-netback/xenbus.c
> @@ -21,6 +21,7 @@
>  #include "common.h"
>  #include <linux/vmalloc.h>
>  #include <linux/rtnetlink.h>
> +#include "netback_fi.h"
>  
>  struct backend_info {
>  	struct xenbus_device *dev;
> @@ -502,6 +503,7 @@ static void backend_disconnect(struct backend_info *be)
>  #ifdef CONFIG_DEBUG_FS
>  		xenvif_debugfs_delif(vif);
>  #endif /* CONFIG_DEBUG_FS */
> +		xenvif_fi_fini(vif);
>  		xenvif_disconnect_data(vif);
>  
>  		/* At this point some of the handlers may still be active
> @@ -1024,6 +1026,10 @@ static void connect(struct backend_info *be)
>  		}
>  	}
>  
> +	err = xenvif_fi_init(be->vif);
> +	if (err)
> +		goto err;
> +
>  #ifdef CONFIG_DEBUG_FS
>  	xenvif_debugfs_addif(be->vif);
>  #endif /* CONFIG_DEBUG_FS */
>

Without any user of that infrastructure I really can't say whether I
want this.


Juergen
