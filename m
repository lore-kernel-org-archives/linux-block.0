Return-Path: <hare@suse.de>
Subject: Re: [PATCH] scsi: scsi_debug: introduce module parameter of
 'use_blk_mq'
To: Christoph Hellwig <hch@infradead.org>,
 Johannes Thumshirn <jthumshirn@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, linux-block@vger.kernel.org,
 Douglas Gilbert <dgilbert@interlog.com>,
 Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>,
 Omar Sandoval <osandov@fb.com>
References: <20180702050642.26265-1-ming.lei@redhat.com>
 <20180702125422.GA600@infradead.org>
 <20180702125652.jxjcig63xvljfqow@linux-x5ow.site>
 <20180702130310.GA19610@infradead.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <8abd3881-2489-47b0-c2df-c9b459261df6@suse.de>
Date: Tue, 3 Jul 2018 08:58:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180702130310.GA19610@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/02/2018 03:03 PM, Christoph Hellwig wrote:
> On Mon, Jul 02, 2018 at 02:56:52PM +0200, Johannes Thumshirn wrote:
>> On Mon, Jul 02, 2018 at 05:54:22AM -0700, Christoph Hellwig wrote:
>>> On Mon, Jul 02, 2018 at 01:06:42PM +0800, Ming Lei wrote:
>>>> With the introduced module parameter of 'use_blk_mq', it is easy
>>>> to switch between 'blk_mq' and 'non_blk_mq' by reloading scsi_debug
>>>> module, so that we can test scsi_mq/blk_mq related regressions easily.
>>>
>>> No.  We should not make a per driver choice.
>>
>> Btw, wouldn't it be time for:
>>
>> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
>> index 35c909bbf8ba..bd115bab162e 100644
>> --- a/drivers/scsi/Kconfig
>> +++ b/drivers/scsi/Kconfig
>> @@ -49,6 +49,7 @@ config SCSI_NETLINK
>>  
>>  config SCSI_MQ_DEFAULT
>>  	bool "SCSI: use blk-mq I/O path by default"
>> +	default y
>>  	depends on SCSI
>>  	---help---
>>  	  This option enables the new blk-mq based I/O path for SCSI
>>
>> again and see how we've improved in the last year and a half?
> 
> Yes, totally.  We'll just need to sort out the error handling with
> scsi and mq first (for 4.18 in fact).
> 
Ah. Seem to have missed that.
Care to elaborate?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
