Return-Path: <ming.lei@redhat.com>
Date: Wed, 30 Aug 2017 11:01:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hare@suse.com" <hare@suse.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: Call .initialize_rq_fn() also for filesystem
 requests
Message-ID: <20170830030145.GD4897@ming.t460p>
References: <20170825190057.15592-1-bart.vanassche@wdc.com>
 <20170828081017.GC2851@lst.de>
 <1503945091.2841.50.camel@wdc.com>
 <20170829111619.GE32439@ming.t460p>
 <1504037722.2653.47.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504037722.2653.47.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 29, 2017 at 08:15:23PM +0000, Bart Van Assche wrote:
> On Tue, 2017-08-29 at 19:16 +0800, Ming Lei wrote:
> > Hi Bart,
> > 
> > Did you see perf regression on SRP with smaller jobs after applying
> > my patchset V3?
> > 
> > I just run the test with 16 jobs(the system has 16 CPU cores) instead of 64,
> > looks not see perf regression on SRP about v4.13-rc6+blk-next(2nd column) VS.
> > v4.13-rc6+blk-next+patch V3(3rd column):
> > 
> > 
> > ---------------------------------------
> >  IOPS(K)  |    NONE     |    NONE
> > ---------------------------------------
> > read      |      475.83 |      485.88
> > ---------------------------------------
> > randread  |      142.86 |      141.96
> > ---------------------------------------
> > write     |       483.9 |      492.39
> > ---------------------------------------
> > randwrite |      124.83 |      124.53
> > ---------------------------------------
> > [ ... ]
> > ---------------------------------------
> >  LAT(us)  |    NONE     |    NONE
> > ---------------------------------------
> > read      |        2.15 |        2.11
> > ---------------------------------------
> > randread  |        7.17 |        7.21
> > ---------------------------------------
> > write     |        2.11 |        2.08
> > ---------------------------------------
> > randwrite |         8.2 |        8.22
> > ---------------------------------------
> > [ ... ]
> 
> Hello Ming,
> 
> Although I would prefer to see measurement data against an SRP target system
> that supports a higher workload (>1M IOPS) and

Hi Bart,

For so higher workload, I guess it often requires to increase
.cmd_per_lun.

> also for a high-end NVMe drive,

My patch won't affect NVMe drive since NVMe driver doesn't become busy
usually.


> I think the above data is sufficient to show that the performance impact of
> your patch series is most likely small enough even for high-end SCSI initiator
> drivers.

OK.

-- 
Ming
