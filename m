Return-Path: <prvs=6441587ed=wei.liu2@citrix.com>
Date: Mon, 23 Apr 2018 10:58:59 +0100
From: Wei Liu <wei.liu2@citrix.com>
To: Stanislav Kinsburskii <staskins@amazon.com>
CC: <jakub.kicinski@netronome.com>, <hpa@zytor.com>, <mcroce@redhat.com>,
	<tglx@linutronix.de>, <ggarcia@abra.uab.cat>, <daniel@iogearbox.net>,
	<x86@kernel.org>, <mingo@redhat.com>, <xen-devel@lists.xenproject.org>,
	<axboe@kernel.dk>, <konrad.wilk@oracle.com>, <amir.jer.levy@intel.com>,
	<paul.durrant@citrix.com>, <stefanha@redhat.com>, <dsa@cumulusnetworks.com>,
	<boris.ostrovsky@oracle.com>, <jgross@suse.com>,
	<linux-block@vger.kernel.org>, <wei.liu2@citrix.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<davem@davemloft.net>, <dwmw@amazon.co.uk>, <roger.pau@citrix.com>
Subject: Re: [PATCH 2/3] xen netback: add fault injection facility
Message-ID: <20180423095859.vdi7f7r267urodlx@citrix.com>
References: <20180420104603.17823.31095.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
 <20180420104731.17823.97617.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20180420104731.17823.97617.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
Return-Path: wei.liu2@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 20, 2018 at 10:47:31AM +0000, Stanislav Kinsburskii wrote:
>  
>  #include <linux/kthread.h>
>  #include <linux/if_vlan.h>
> @@ -1649,6 +1650,7 @@ static int __init netback_init(void)
>  			PTR_ERR(xen_netback_dbg_root));
>  #endif /* CONFIG_DEBUG_FS */
>  
> +	(void) xen_netbk_fi_init();

If you care about the return value, please propagate it to
netback_init's caller. Otherwise you can just make the function return
void.

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
> +		if (!vfi->faults[fi])
> +			goto err_fault;
> +	}
> +
> +	vif->fi_info = vfi;
> +	return 0;
> +
> +err_fault:
> +	for (; fi > 0; fi--)

fi >= 0

Wei.
