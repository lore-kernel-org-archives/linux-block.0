Return-Path: <hare@suse.de>
Subject: Re: block: don't check request size in blk_cloned_rq_check_limits()
To: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1464593093-93527-1-git-send-email-hare@suse.de>
 <20160610131901.GA28570@redhat.com> <yq160tgfoqr.fsf@sermon.lab.mkp.net>
 <575BE182.5010304@suse.de> <yq11t44f0hi.fsf@sermon.lab.mkp.net>
Cc: Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Brian King <brking@us.ibm.com>, linux-scsi@vger.kernel.org,
 linux-block@vger.kernel.org, mark.bergman@uphs.upenn.edu
From: Hannes Reinecke <hare@suse.de>
Message-ID: <575C0DAE.7070502@suse.de>
Date: Sat, 11 Jun 2016 15:10:06 +0200
MIME-Version: 1.0
In-Reply-To: <yq11t44f0hi.fsf@sermon.lab.mkp.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/11/2016 01:06 PM, Martin K. Petersen wrote:
>>>>>> "Hannes" == Hannes Reinecke <hare@suse.de> writes:
>
> Hannes> Because we're checking the wrong limit.
>
> The original code checked that the request was smaller than both
> max_sectors and max_hw_sectors so it would have failed here as well.
>
> Hannes> blk_queue_get_max_sectors() is checking limits.max_sectors(),
> Hannes> but the requests are already fully formed and can extend up to
> Hannes> limits.max_hw_sectors().
>
> We should not be issuing REQ_TYPE_FS requests larger than max_sectors.
> How did we get here?
>
Well, the primary issue is that 'blk_cloned_rq_check_limits()' doesn't 
check for BLOCK_PC, so this particular check would be applied for every 
request.

But as it turns out, even adding a check for BLOCK_PC doesn't help, so 
we're indeed seeing REQ_TYPE_FS requests with larger max_sector counts.

As to _why_ this happens I frankly have no idea. I have been staring at 
this particular code for over a year now (I've got another bug pending 
where we hit the _other_ if clause), but to no avail.
So I've resolved to drop the check altogether, seeing that max_sector 
size is _not_ something which gets changed during failover.
Therefore if the max_sector count is wrong for the cloned request it was 
already wrong for the original request, and we should've errored it out 
far earlier.
The max_segments count, OTOH, _might_ change during failover (different 
hardware has different max_segments setting, and this is being changed 
during sg mapping), so there is some value to be had from testing it here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
