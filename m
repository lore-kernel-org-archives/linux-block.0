Return-Path: <hare@suse.de>
Subject: Re: remove the cmd_type field from struct request
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
References: <1485878251-6107-1-git-send-email-hch@lst.de>
 <bbe16fc1-5652-bbc2-03a5-0298c3f16645@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c61b9b98-8e4a-ac23-bf0c-002d112d5468@suse.de>
Date: Wed, 1 Feb 2017 07:53:26 +0100
MIME-Version: 1.0
In-Reply-To: <bbe16fc1-5652-bbc2-03a5-0298c3f16645@kernel.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 01/31/2017 07:02 PM, Jens Axboe wrote:
> On 01/31/2017 07:57 AM, Christoph Hellwig wrote:
>> [1] which were a pain in the ass to untangle and debug during development,
>> it's really time for it to die..
>
> Outside of the patch series in question, how to we expedite the
> euthanasia of IDE? What explicit features/support are we missing through
> libata that would need to be added, before we can git rm drivers/ide/ ?
>
There is only a single driver (sgi_ide) which hasn't been moved over to 
libata. But this is for an old Itanium-based server only, and even SGI 
didn't press us to have this ported.
(And we have disabled the IDE drivers since SLES11, where we still 
support Itanium.)
So they can be safely assumed defunct at this time.

I'm all for removing them.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
