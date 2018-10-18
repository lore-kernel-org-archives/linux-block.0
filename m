Return-Path: <hare@suse.de>
Subject: Re: [PATCHv6 0/3] Deprecate DAC960 driver
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 James Bottomley <james.bottomley@hansenpartnership.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20181017152513.136526-1-hare@suse.de>
 <yq1lg6wkqe9.fsf@oracle.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d9f916e8-3a7a-f768-72ba-fcadc8e34ec0@suse.de>
Date: Thu, 18 Oct 2018 07:54:32 +0200
MIME-Version: 1.0
In-Reply-To: <yq1lg6wkqe9.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/18/18 3:14 AM, Martin K. Petersen wrote:
> 
> Hannes,
> 
>> as we're trying to get rid of the remaining request_fn drivers here's
>> a patchset to move the DAC960 driver to the SCSI stack.  As per
>> request from hch I've split up the driver into two new SCSI drivers
>> called 'myrb' and 'myrs'.
> 
> Applied to 4.20/scsi-queue since Jens already dropped the block driver.
> 
> Have you considered a dummy CONFIG_BLK_DEV_DAC960 config option like we
> did when we merged mpt2sas and mpt3sas?
> 
No, I haven't, but I should probably do it. Should I fix up the patch
or send an additional one?

> Also, does MODULE_ALIAS do the right thing when a driver is split into
> two distinct modules?
> 
Well, it does; half of the time :-)

Personally, I don't think there'll be many users around so I've just 
added if for completions sake.

But I can remove it if you think that'll be more suitable.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
