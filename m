Return-Path: <ming.lei@redhat.com>
Date: Wed, 3 May 2017 23:03:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 0/4] blk-mq: support to use hw tag for scheduling
Message-ID: <20170503150351.GA7927@ming.t460p>
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <839682da-f375-8eab-d6f5-fcf1457150f1@fb.com>
 <20170503040303.GA20187@ming.t460p>
 <f52b4478-0d18-a248-3fbf-721216a79f92@fb.com>
 <370fbeb6-d832-968a-2759-47f16b866551@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <370fbeb6-d832-968a-2759-47f16b866551@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 03, 2017 at 08:10:58AM -0600, Jens Axboe wrote:
> On 05/03/2017 08:08 AM, Jens Axboe wrote:
> > On 05/02/2017 10:03 PM, Ming Lei wrote:
> >> On Fri, Apr 28, 2017 at 02:29:18PM -0600, Jens Axboe wrote:
> >>> On 04/28/2017 09:15 AM, Ming Lei wrote:
> >>>> Hi,
> >>>>
> >>>> This patchset introduces flag of BLK_MQ_F_SCHED_USE_HW_TAG and
> >>>> allows to use hardware tag directly for IO scheduling if the queue's
> >>>> depth is big enough. In this way, we can avoid to allocate extra tags
> >>>> and request pool for IO schedule, and the schedule tag allocation/release
> >>>> can be saved in I/O submit path.
> >>>
> >>> Ming, I like this approach, it's pretty clean. It'd be nice to have a
> >>> bit of performance data to back up that it's useful to add this code,
> >>> though.  Have you run anything on eg kyber on nvme that shows a
> >>> reduction in overhead when getting rid of separate scheduler tags?
> >>
> >> I can observe small improvement in the following tests:
> >>
> >> 1) fio script
> >> # io scheduler: kyber
> >>
> >> RWS="randread read randwrite write"
> >> for RW in $RWS; do
> >>         echo "Running test $RW"
> >>         sudo echo 3 > /proc/sys/vm/drop_caches
> >>         sudo fio --direct=1 --size=128G --bsrange=4k-4k --runtime=20 --numjobs=1 --ioengine=libaio --iodepth=10240 --group_reporting=1 --filename=$DISK --name=$DISK-test-$RW --rw=$RW --output-format=json
> >> done
> >>
> >> 2) results
> >>
> >> ---------------------------------------------------------
> >> 			|sched tag(iops/lat)	| use hw tag to sched(iops/lat)
> >> ----------------------------------------------------------
> >> randread	|188940/54107			| 193865/52734
> >> ----------------------------------------------------------
> >> read		|192646/53069			| 199738/51188
> >> ----------------------------------------------------------
> >> randwrite	|171048/59777			| 179038/57112
> >> ----------------------------------------------------------
> >> write		|171886/59492			| 181029/56491
> >> ----------------------------------------------------------
> >>
> >> I guess it may be a bit more obvious when running the test on one slow
> >> NVMe device, and will try to find one and run the test again.
> > 
> > Thanks for running that. As I said in my original reply, I think this
> > is a good optimization, and the implementation is clean. I'm fine with
> > the current limitations of when to enable it, and it's not like we
> > can't extend this later, if we want.
> > 
> > I do agree with Bart that patch 1+4 should be combined. I'll do that.
> 
> Actually, can you do that when reposting? Looks like you needed to
> do that anyway.

Yeah, I will do that in V1.

Thanks,
Ming
