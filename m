Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] virtio_blk: Fix an SG_IO regression
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "dann.frazier@canonical.com" <dann.frazier@canonical.com>
References: <20171025095617.7315-1-bart.vanassche@wdc.com>
 <11a35a46-dc51-c32f-cb64-793d9dd02c53@kernel.dk>
 <1508959556.5073.1.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <83926138-e6aa-6792-5275-31f5c1330c90@kernel.dk>
Date: Wed, 25 Oct 2017 12:34:25 -0700
MIME-Version: 1.0
In-Reply-To: <1508959556.5073.1.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/25/2017 12:25 PM, Bart Van Assche wrote:
> On Wed, 2017-10-25 at 11:23 -0700, Jens Axboe wrote:
>> On 10/25/2017 02:56 AM, Bart Van Assche wrote:
>>> Avoid that submitting an SG_IO ioctl triggers a kernel oops that
>>> is preceded by:
>>>
>>> usercopy: kernel memory overwrite attempt detected to (null) (<null>) (6 bytes)
>>> kernel BUG at mm/usercopy.c:72!
>>
>> Seems I saw a note on a runtime oops triggered by this patch yesterday,
>> but now I can't seem to find it... Did you see it?
> 
> Do you perhaps want me to add the stack trace from the following e-mail to
> the patch description: https://marc.info/?l=linux-arm-kernel&m=150854010321833 ?

It was an oops reported against the current patch, unless I'm mistaken. Hard
to say, when I can't find the email this morning, may have been deleted...
That's why I asked if you saw it.

>>> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
>>> index 4a438b8abe27..b0b2100763bf 100644
>>> --- a/drivers/block/Kconfig
>>> +++ b/drivers/block/Kconfig
>>> @@ -450,6 +450,7 @@ config VIRTIO_BLK_SCSI
>>>  	bool "SCSI passthrough request for the Virtio block driver"
>>>  	depends on VIRTIO_BLK
>>>  	select BLK_SCSI_REQUEST
>>> +	select SCSI_MOD
>>
>> Should this be SCSI? That's what libata does. It may be correct as-is,
>> didn't look too deeply, just curious why it's different.
> 
> That is what I came up with after having had a look at drivers/scsi/Makefile.
> But after having checked drivers/scsi/Kconfig I think we indeed need to select
> SCSI instead of SCSI_MOD.

I think so.

-- 
Jens Axboe
