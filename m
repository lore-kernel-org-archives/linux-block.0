Return-Path: <hare@suse.de>
Subject: Re: bio-based DM multipath is back from the dead [was: Re: Notes from
 the four separate IO track sessions at LSF/MM]
To: Mike Snitzer <snitzer@redhat.com>
References: <1461800389.2311.70.camel@HansenPartnership.com>
 <20160428121108.GA9903@redhat.com>
 <1461858038.2307.16.camel@HansenPartnership.com>
 <20160526023855.GA20659@redhat.com> <574807D6.4030208@suse.de>
 <20160527144407.GA31394@redhat.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
 linux-block@vger.kernel.org, lsf@lists.linux-foundation.org,
 device-mapper development <dm-devel@redhat.com>, hch@lst.de,
 linux-scsi <linux-scsi@vger.kernel.org>, axboe@kernel.dk,
 Ming Lei <ming.lei@canonical.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <57486ACE.40707@suse.de>
Date: Fri, 27 May 2016 17:42:06 +0200
MIME-Version: 1.0
In-Reply-To: <20160527144407.GA31394@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/27/2016 04:44 PM, Mike Snitzer wrote:
> On Fri, May 27 2016 at  4:39am -0400,
> Hannes Reinecke <hare@suse.de> wrote:
>
[ .. ]
>> No, the real issue is load-balancing.
>> If you have several paths you have to schedule I/O across all paths,
>> _and_ you should be feeding these paths efficiently.
>
> <snip well known limitation of bio-based mpath load balancing, also
> detailed in the multipath paper I refernced>
>
> Right, as my patch header details, this is the only limitation that
> remains with the reinstated bio-based DM multipath.
>

:-)
And the very reason why we went into request-based multipathing in the 
first place...

>> I was sort-of hoping that with the large bio work from Shaohua we
>
> I think you mean Ming Lei and his multipage biovec work?
>
Errm. Yeah, of course. Apologies.

>> could build bio which would not require any merging, ie building
>> bios which would be assembled into a single request per bio.
>> Then the above problem wouldn't exist anymore and we _could_ do
>> scheduling on bio level.
>> But from what I've gathered this is not always possible (eg for
>> btrfs with delayed allocation).
>
> I doubt many people are running btrfs over multipath in production
> but...
>
Hey. There is a company who does ...

> Taking a step back: reinstating bio-based DM multipath is _not_ at the
> expense of request-based DM multipath.  As you can see I've made it so
> that all modes (bio-based, request_fn rq-based, and blk-mq rq-based) are
> supported by a single DM multipath target.  When the trnasition to
> request-based happened it would've been wise to preserve bio-based but I
> digress...
>
> So, the point is: there isn't any one-size-fits-all DM multipath queue
> mode here.  If a storage config benefits from the request_fn IO
> schedulers (but isn't hurt by .request_fn's queue lock, so slower
> rotational storage?) then use queue_mode=2.  If the storage is connected
> to a large NUMA system and there is some reason to want to use blk-mq
> request_queue at the DM level: use queue_mode=3.  If the storage is
> _really_ fast and doesn't care about extra IO grooming (e.g. sorting and
> merging) then select bio-based using queue_mode=1.
>
> I collected some quick performance numbers against a null_blk device, on
> a single NUMA node system, with various DM layers ontop -- the multipath
> runs are only with a single path... fio workload is just 10 sec randread:
>
Which is precisely the point.
Everything's nice and shiny with a single path, as then the above issue 
simply doesn't apply.
Things only start getting interesting if you have _several_ paths.
So the benchmarks only prove that device-mapper doesn't add too much of 
an overhead; they don't prove that the above point has been addressed...

[ .. ]
>> Have you found another way of addressing this problem?
>
> No, bio sorting/merging really isn't a problem for DM multipath to
> solve.
>
> Though Jens did say (in the context of one of these dm-crypt bulk mode
> threads) that the block core _could_ grow some additional _minimalist_
> capability for bio merging:
> https://www.redhat.com/archives/dm-devel/2015-November/msg00130.html
>
> I'd like to understand a bit more about what Jens is thinking in that
> area because it could benefit DM thinp as well (though that is using bio
> sorting rather than merging, introduced via commit 67324ea188).
>
> I'm not opposed to any line of future development -- but development
> needs to be driven by observed limitations while testing on _real_
> hardware.
>
In the end, with Ming Leis multipage bvec work we essentially already 
moved some merging ability into the bios; during bio_add_page() the 
block layer will already merge bios together.

(I'll probably be yelled at by hch for ignorance for the following, but 
nevertheless)
 From my POV there are several areas of 'merging' which currently happen:
a) bio merging: combine several consecutive bios into a larger one; 
should be largely address by Ming Leis multipage bvec
b) bio sorting: reshuffle bios so that any requests on the request queue 
are ordered 'best' for the underlying hardware (ie the actual I/O 
scheduler). Not implemented for mq, and actually of questionable value 
for fast storage. One of the points I'll be testing in the very near 
future; ideally we find that it's not _that_ important (compared to the 
previous point), then we could drop it altogether for mq.
c) clustering: coalescing several consecutive pages/bvecs into a single 
SG element. Obviously only can happen if you have large enough requests.
But the only gain is shortening the number of SG elements for a requests.
Again of questionable value as the request itself and the amount of data 
to transfer isn't changed. And another point of performance testing on 
my side.

So ideally we will find that b) and c) only contribute with a small 
amount to the overall performance, then we could easily drop it for MQ 
and concentrate on make bio merging work well.
Then it wouldn't really matter if we were doing bio-based or 
request-based multipathing as we had a 1:1 relationship, and this entire 
discussion could go away.

Well. Or that's the hope, at least.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
