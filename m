Return-Path: <axboe@kernel.dk>
Subject: Re: block: don't check request size in blk_cloned_rq_check_limits()
To: Hannes Reinecke <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1464593093-93527-1-git-send-email-hare@suse.de>
 <20160610131901.GA28570@redhat.com> <yq160tgfoqr.fsf@sermon.lab.mkp.net>
 <575BE182.5010304@suse.de> <yq11t44f0hi.fsf@sermon.lab.mkp.net>
 <575C0DAE.7070502@suse.de> <yq17fdrcjs3.fsf@sermon.lab.mkp.net>
 <5760F6BC.60109@suse.de>
Cc: Mike Snitzer <snitzer@redhat.com>, Brian King <brking@us.ibm.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 mark.bergman@uphs.upenn.edu
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <576127FC.9020608@kernel.dk>
Date: Wed, 15 Jun 2016 12:03:40 +0200
MIME-Version: 1.0
In-Reply-To: <5760F6BC.60109@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/15/2016 08:33 AM, Hannes Reinecke wrote:
> And as I've mentioned before: what is the purpose of this check?
>
> 'max_sectors' and 'max_hw_sectors' are checked during request assembly,
> and those limits are not changed even after calling
> blk_recalc_rq_segments(). And if we go over any device-imposed
> restrictions we'll be getting an I/O error from the driver anyway.
> So why have it at all?

You don't know that to be the case. The driver asked for certain limits, 
the core MUST obey them. The driver should not need to check for these 
limits, outside of in a BUG_ON() like manner.

> Especially as the system boots happily with this check removed...

That's the case for you, but you can't assume this to be the case in 
general.

There's a _lot_ of hand waving in this thread, Hannes. How do we 
reproduce this? We need to get this fixed for real, not just delete some 
check that triggers for you and that it just happens to work without. 
That's not how you fix problems.

-- 
Jens Axboe
