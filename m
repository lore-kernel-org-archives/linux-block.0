Return-Path: <ming.lei@redhat.com>
Date: Tue, 29 Aug 2017 19:16:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hare@suse.com" <hare@suse.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: Call .initialize_rq_fn() also for filesystem
 requests
Message-ID: <20170829111619.GE32439@ming.t460p>
References: <20170825190057.15592-1-bart.vanassche@wdc.com>
 <20170828081017.GC2851@lst.de>
 <1503945091.2841.50.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503945091.2841.50.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 28, 2017 at 06:31:33PM +0000, Bart Van Assche wrote:
> On Mon, 2017-08-28 at 10:10 +0200, Christoph Hellwig wrote:
> > I still disagree that we should have an indirect function call like this
> > in the fast path.
> > 
> > All that can be done by clearing or setting a flag on the first call to
> > ->queue_rq or ->queuecommand instead.  In NVMe we use RQF_DONTPREP for
> > that, but for SCSI we probably can't use that given that it has more
> > meaning for the old request path.  But how about just adding a new
> > RQD_DRV_INITIALIZED or similar flag?
> 
> Hello Christoph,
> 
> Sorry but I'm not enthusiast about the proposal to introduce a
> RQD_DRV_INITIALIZED or similar flag. That approach involves an annoying
> behavior difference, namely that .initialize_rq_fn() would be called from
> inside blk_get_request() for pass-through requests and from inside the prep
> function for filesystem requests. Another disadvantage of that approach is
> that the block layer core never clears request.atomic_flags completely but
> only sets and clears individual flags. The SCSI core would have to follow
> that model and hence code for clearing RQD_DRV_INITIALIZED would have to be
> added to all request completion paths in the SCSI core.
> 
> Have you noticed that Ming Lei's patch series introduces several new atomic
> operations in the hot path? I'm referring here to the BLK_MQ_S_DISPATCH_BUSY
> manipulations. Have you noticed that for SCSI drivers these patches introduce
> an overhead between 0.1 and 1.0 microseconds per I/O request in the hot path?
> I have derived these numbers from the random write SRP performance numbers
> as follows: 1/142460 - 1/142990 = 2.6 microseconds. That number has to be
> multiplied with the number of I/O requests processed in parallel. The number
> of jobs in Ming Lei's test was 64 but that's probably way higher than the
> actual I/O parallelism.

Hi Bart,

Did you see perf regression on SRP with smaller jobs after applying
my patchset V3?

I just run the test with 16 jobs(the system has 16 CPU cores) instead of 64,
looks not see perf regression on SRP about v4.13-rc6+blk-next(2nd column) VS.
v4.13-rc6+blk-next+patch V3(3rd column):


---------------------------------------
 IOPS(K)  |    NONE     |    NONE
---------------------------------------
read      |      475.83 |      485.88
---------------------------------------
randread  |      142.86 |      141.96
---------------------------------------
write     |       483.9 |      492.39
---------------------------------------
randwrite |      124.83 |      124.53
---------------------------------------



---------------------------------------
 CPU(%)   |    NONE     |    NONE
---------------------------------------
read      |       15.43 |       15.81
---------------------------------------
randread  |        9.87 |        9.75
---------------------------------------
write     |       17.67 |       18.34
---------------------------------------
randwrite |       10.96 |       10.56
---------------------------------------



---------------------------------------
 LAT(us)  |    NONE     |    NONE
---------------------------------------
read      |        2.15 |        2.11
---------------------------------------
randread  |        7.17 |        7.21
---------------------------------------
write     |        2.11 |        2.08
---------------------------------------
randwrite |         8.2 |        8.22
---------------------------------------



---------------------------------------
MERGE(K)  |    NONE     |    NONE
---------------------------------------
read      |     8798.59 |     9064.09
---------------------------------------
randread  |        0.02 |        0.19
---------------------------------------
write     |     8847.73 |     9102.18
---------------------------------------
randwrite |        0.03 |        0.13
---------------------------------------



-- 
Ming
