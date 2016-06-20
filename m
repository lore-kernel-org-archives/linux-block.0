Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2on0094.outbound.protection.outlook.com ([207.46.100.94]:55264
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752001AbcFTNeF (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Mon, 20 Jun 2016 09:34:05 -0400
Subject: Re: [PATCH v3 2/3] block: convert to device_add_disk()
To: Dan Williams <dan.j.williams@intel.com>,
	<linux-block@vger.kernel.org>
References: <146618127395.31030.11800447312061202344.stgit@dwillia2-desk3.amr.corp.intel.com>
 <146618128465.31030.12159307386730181867.stgit@dwillia2-desk3.amr.corp.intel.com>
CC: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	<axboe@fb.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	<linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Keith Busch <keith.busch@intel.com>,
	<linux-nvdimm@lists.01.org>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	"Ross Zwisler" <ross.zwisler@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Christoph Hellwig <hch@lst.de>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <8dc61bb4-fc9f-a855-d792-37e4e6a02db9@sandisk.com>
Date: Mon, 20 Jun 2016 15:33:49 +0200
MIME-Version: 1.0
In-Reply-To: <146618128465.31030.12159307386730181867.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/17/2016 06:34 PM, Dan Williams wrote:
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index ef6b4d960bad..4e7cb5df8e43 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -823,12 +823,11 @@ static int ubd_disk_register(int major, u64 size, int unit,
>  		ubd_devs[unit].pdev.dev.release = ubd_device_release;
>  		dev_set_drvdata(&ubd_devs[unit].pdev.dev, &ubd_devs[unit]);
>  		platform_device_register(&ubd_devs[unit].pdev);
> -		disk->driverfs_dev = &ubd_devs[unit].pdev.dev;
>  	}
>
>  	disk->private_data = &ubd_devs[unit];
>  	disk->queue = ubd_devs[unit].queue;
> -	add_disk(disk);
> +	device_add_disk(&ubd_devs[unit].pdev.dev, disk);
>
>  	*disk_out = disk;
>  	return 0;

Have you reviewed this patch yourself? I think the above change is an 
unintended behavior change.

Bart.
