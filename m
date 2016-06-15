Return-Path: <keith.busch@intel.com>
Date: Wed, 15 Jun 2016 15:16:03 -0400
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	Armen Baloyan <armenx.baloyan@intel.com>,
	Jay Freyensee <james.p.freyensee@intel.com>,
	Ming Lin <ming.l@ssi.samsung.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 6/8] nvme-fabrics: add a generic NVMe over Fabrics library
Message-ID: <20160615191603.GC1919@localhost.localdomain>
References: <1465829128-22993-1-git-send-email-hch@lst.de>
 <1465829128-22993-7-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465829128-22993-7-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 13, 2016 at 04:45:26PM +0200, Christoph Hellwig wrote:
> @@ -107,10 +108,19 @@ struct nvme_ctrl {
>  	u8 event_limit;
>  	u8 vwc;
>  	u32 vs;
> +	u32 sgls;
>  	bool subsystem;
>  	unsigned long quirks;
>  	struct work_struct scan_work;
>  	struct work_struct async_event_work;
> +
> +	/* Fabrics only */
> +	u16 sqsize;
> +	u32 ioccsz;
> +	u32 iorcsz;
> +	u16 icdoff;
> +	u16 maxcmd;
> +	struct nvmf_ctrl_options *opts;
>  };

The pci only stuff goes in 'struct nvme_dev' and embeds 'struct
nvme_ctrl', but fabrics gets to use nvme_ctrl directly?

If we need transport specifics for anything, like you have during
nvme_init_identify, I think we should add function callbacks to
nvme_ctrl_ops to set up those specifics, then we don't need 'is_fabrics'
checks.
