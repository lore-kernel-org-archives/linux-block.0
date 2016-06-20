Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34998 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbcFTPKm (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Mon, 20 Jun 2016 11:10:42 -0400
Received: by mail-io0-f180.google.com with SMTP id f30so124534837ioj.2
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2016 08:10:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8dc61bb4-fc9f-a855-d792-37e4e6a02db9@sandisk.com>
References: <146618127395.31030.11800447312061202344.stgit@dwillia2-desk3.amr.corp.intel.com>
	<146618128465.31030.12159307386730181867.stgit@dwillia2-desk3.amr.corp.intel.com>
	<8dc61bb4-fc9f-a855-d792-37e4e6a02db9@sandisk.com>
Date: Mon, 20 Jun 2016 07:43:27 -0700
Message-ID: <CAPcyv4hHkMuj+E5_VZihi92fdimmzLk=ciryBrhR2ZfmK9SEKw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] block: convert to device_add_disk()
From: Dan Williams <dan.j.williams@intel.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jens Axboe <axboe@fb.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Keith Busch <keith.busch@intel.com>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jun 20, 2016 at 6:33 AM, Bart Van Assche
<bart.vanassche@sandisk.com> wrote:
> On 06/17/2016 06:34 PM, Dan Williams wrote:
>>
>> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
>> index ef6b4d960bad..4e7cb5df8e43 100644
>> --- a/arch/um/drivers/ubd_kern.c
>> +++ b/arch/um/drivers/ubd_kern.c
>> @@ -823,12 +823,11 @@ static int ubd_disk_register(int major, u64 size,
>> int unit,
>>                 ubd_devs[unit].pdev.dev.release = ubd_device_release;
>>                 dev_set_drvdata(&ubd_devs[unit].pdev.dev,
>> &ubd_devs[unit]);
>>                 platform_device_register(&ubd_devs[unit].pdev);
>> -               disk->driverfs_dev = &ubd_devs[unit].pdev.dev;
>>         }
>>
>>         disk->private_data = &ubd_devs[unit];
>>         disk->queue = ubd_devs[unit].queue;
>> -       add_disk(disk);
>> +       device_add_disk(&ubd_devs[unit].pdev.dev, disk);
>>
>>         *disk_out = disk;
>>         return 0;
>
>
> Have you reviewed this patch yourself? I think the above change is an
> unintended behavior change.

Good catch! You are correct, this driver emits both parented an
un-parented disks.  I'll fix this up and re-check the others.
