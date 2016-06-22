Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bl2on0082.outbound.protection.outlook.com ([65.55.169.82]:2320
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751782AbcFVGUQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 22 Jun 2016 02:20:16 -0400
Subject: Re: [PATCH v4 3/5] um: track 'parent' device in a local variable
To: Dan Williams <dan.j.williams@intel.com>,
	"axboe@fb.com" <axboe@fb.com>
References: <146654196111.34694.7735150373057824399.stgit@dwillia2-desk3.amr.corp.intel.com>
 <146654197737.34694.9376917839573236856.stgit@dwillia2-desk3.amr.corp.intel.com>
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"Richard Weinberger" <richard@nod.at>,
	Jeff Dike <jdike@addtoit.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hch@lst.de" <hch@lst.de>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <a5024a02-adfb-c027-7a40-417cc10911af@sandisk.com>
Date: Wed, 22 Jun 2016 08:20:04 +0200
MIME-Version: 1.0
In-Reply-To: <146654197737.34694.9376917839573236856.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/21/2016 10:47 PM, Dan Williams wrote:
> In preparation for the removal of 'driverfs_dev' from 'struct gendisk'
> use a local variable to track the parented vs un-parented case in
> ubd_disk_register().
>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Reported-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/um/drivers/ubd_kern.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index ef6b4d960bad..8ec7b4112f55 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -801,6 +801,7 @@ static void ubd_device_release(struct device *dev)
>  static int ubd_disk_register(int major, u64 size, int unit,
>  			     struct gendisk **disk_out)
>  {
> +	struct device *dev = NULL;
>  	struct gendisk *disk;
>
>  	disk = alloc_disk(1 << UBD_SHIFT);
> @@ -823,12 +824,12 @@ static int ubd_disk_register(int major, u64 size, int unit,
>  		ubd_devs[unit].pdev.dev.release = ubd_device_release;
>  		dev_set_drvdata(&ubd_devs[unit].pdev.dev, &ubd_devs[unit]);
>  		platform_device_register(&ubd_devs[unit].pdev);
> -		disk->driverfs_dev = &ubd_devs[unit].pdev.dev;
> +		dev = &ubd_devs[unit].pdev.dev;
>  	}
>
>  	disk->private_data = &ubd_devs[unit];
>  	disk->queue = ubd_devs[unit].queue;
> -	add_disk(disk);
> +	device_add_disk(dev, disk);
>
>  	*disk_out = disk;
>  	return 0;

Hello Dan,

The Reported-by tag is intended to give people credit who find bugs in 
the upstream kernel. What I reported was a bug not in the upstream 
kernel but in a previous version of this patch series so I think the 
"Reported-by" tag can be left out from this patch.

Additionally, please consider to use a more descriptive name instead of 
"dev", e.g. "parent".

Thanks,

Bart.
