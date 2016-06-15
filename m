Return-Path: <hare@suse.de>
Subject: Re: block: don't check request size in blk_cloned_rq_check_limits()
To: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1464593093-93527-1-git-send-email-hare@suse.de>
 <20160610131901.GA28570@redhat.com> <yq160tgfoqr.fsf@sermon.lab.mkp.net>
 <575BE182.5010304@suse.de> <yq11t44f0hi.fsf@sermon.lab.mkp.net>
 <575C0DAE.7070502@suse.de> <yq17fdrcjs3.fsf@sermon.lab.mkp.net>
Cc: Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Brian King <brking@us.ibm.com>, linux-scsi@vger.kernel.org,
 linux-block@vger.kernel.org, mark.bergman@uphs.upenn.edu
From: Hannes Reinecke <hare@suse.de>
Message-ID: <5760F6BC.60109@suse.de>
Date: Wed, 15 Jun 2016 08:33:32 +0200
MIME-Version: 1.0
In-Reply-To: <yq17fdrcjs3.fsf@sermon.lab.mkp.net>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 06/15/2016 03:39 AM, Martin K. Petersen wrote:
>>>>>> "Hannes" == Hannes Reinecke <hare@suse.de> writes:
> 
> Hannes> Well, the primary issue is that 'blk_cloned_rq_check_limits()'
> Hannes> doesn't check for BLOCK_PC,
> 
> Yes it does. It calls blk_rq_get_max_sectors() which has an explicit
> check for this:
> 
> static inline unsigned int blk_rq_get_max_sectors(struct request *rq)
> {
>         struct request_queue *q = rq->q;
> 
>         if (unlikely(rq->cmd_type != REQ_TYPE_FS))
>                         return q->limits.max_hw_sectors;
> [...]
> 
> Hannes> The max_segments count, OTOH, _might_ change during failover
> Hannes> (different hardware has different max_segments setting, and this
> Hannes> is being changed during sg mapping), so there is some value to
> Hannes> be had from testing it here.
> 
> Oh, this happens during failover? Are you sure it's not because DM is
> temporarily resetting the queue limits? max_sectors is going to be a
> single page in that case. I just discussed a backport regression in this
> department with Mike at LSF/MM. But that was for an older kernel.
> 
> Accidentally resetting the limits during table swaps has happened a
> couple of times over the years. We trip it instantly with the database
> in failover testing.
> 
Unfortunately, we have two distinct bugs lurking in that function.
The resetting limits during failover is something we've probably hitting
with a mixed initiator setting, but it will typically materialize as a
transient error when tripping over the _other_ check.
But this particular issue is seen directly during booting.

And as I've mentioned before: what is the purpose of this check?

'max_sectors' and 'max_hw_sectors' are checked during request assembly,
and those limits are not changed even after calling
blk_recalc_rq_segments(). And if we go over any device-imposed
restrictions we'll be getting an I/O error from the driver anyway.
So why have it at all?

Especially as the system boots happily with this check removed...

Cheers,

-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
