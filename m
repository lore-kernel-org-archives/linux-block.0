Return-Path: <hch@lst.de>
Date: Wed, 17 Oct 2018 09:26:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 1/3] myrb: Add Mylex RAID controller (block interface)
Message-ID: <20181017072606.GF23407@lst.de>
References: <20181012071548.129113-1-hare@suse.de> <20181012071548.129113-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181012071548.129113-2-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 99d366cb0e9f..1efbd175411a 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -922,10 +922,12 @@
>  #define PCI_DEVICE_ID_PICOPOWER_PT86C523BBP	0x8002
>  
>  #define PCI_VENDOR_ID_MYLEX		0x1069
> +#define PCI_SUBVENDOR_ID_MYLEX		0x1069

Vendor and subvendor its are the same.  Just use PCI_VENDOR_ID_MYLEX
where you;d want to use PCI_SUBVENDOR_ID_MYLEX.

>  #define PCI_DEVICE_ID_MYLEX_DAC960_P	0x0001
>  #define PCI_DEVICE_ID_MYLEX_DAC960_PD	0x0002
>  #define PCI_DEVICE_ID_MYLEX_DAC960_PG	0x0010
>  #define PCI_DEVICE_ID_MYLEX_DAC960_LA	0x0020
> +#define PCI_SUBDEVICE_ID_MYLEX_DAC960_LA 0x0020

Same here, in addition to the fact that we really don't
want single use PCI IDs in pci_ids.h.

Bonous points for just using the numeric values in the driver, and
adding another patch to remove them from pci_ids.h.

Otherwise looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
