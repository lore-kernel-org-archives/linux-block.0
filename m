Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751144AbdECEDW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 May 2017 00:03:22 -0400
Date: Wed, 3 May 2017 12:03:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 0/4] blk-mq: support to use hw tag for scheduling
Message-ID: <20170503040303.GA20187@ming.t460p>
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <839682da-f375-8eab-d6f5-fcf1457150f1@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <839682da-f375-8eab-d6f5-fcf1457150f1@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 28, 2017 at 02:29:18PM -0600, Jens Axboe wrote:
> On 04/28/2017 09:15 AM, Ming Lei wrote:
> > Hi,
> > 
> > This patchset introduces flag of BLK_MQ_F_SCHED_USE_HW_TAG and
> > allows to use hardware tag directly for IO scheduling if the queue's
> > depth is big enough. In this way, we can avoid to allocate extra tags
> > and request pool for IO schedule, and the schedule tag allocation/release
> > can be saved in I/O submit path.
> 
> Ming, I like this approach, it's pretty clean. It'd be nice to have a
> bit of performance data to back up that it's useful to add this code,
> though.  Have you run anything on eg kyber on nvme that shows a
> reduction in overhead when getting rid of separate scheduler tags?

I can observe small improvement in the following tests:

1) fio script
# io scheduler: kyber

RWS="randread read randwrite write"
for RW in $RWS; do
        echo "Running test $RW"
        sudo echo 3 > /proc/sys/vm/drop_caches
        sudo fio --direct=1 --size=128G --bsrange=4k-4k --runtime=20 --numjobs=1 --ioengine=libaio --iodepth=10240 --group_reporting=1 --filename=$DISK --name=$DISK-test-$RW --rw=$RW --output-format=json
done

2) results

---------------------------------------------------------
			|sched tag(iops/lat)	| use hw tag to sched(iops/lat)
----------------------------------------------------------
randread	|188940/54107			| 193865/52734
----------------------------------------------------------
read		|192646/53069			| 199738/51188
----------------------------------------------------------
randwrite	|171048/59777			| 179038/57112
----------------------------------------------------------
write		|171886/59492			| 181029/56491
----------------------------------------------------------

I guess it may be a bit more obvious when running the test on one slow
NVMe device, and will try to find one and run the test again.


thanks,
Ming
