Return-Path: <ming.lei@redhat.com>
Date: Wed, 17 May 2017 15:01:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Zhang Yi <yizhan@redhat.com>,
	linux-block@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: fix race between removing and reseting failure
Message-ID: <20170517070132.GA14057@ming.t460p>
References: <20170517012729.13469-1-ming.lei@redhat.com>
 <20170517012729.13469-2-ming.lei@redhat.com>
 <3394ff16-2876-c9da-b457-98d6479516e0@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3394ff16-2876-c9da-b457-98d6479516e0@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 17, 2017 at 08:38:01AM +0200, Johannes Thumshirn wrote:
> On 05/17/2017 03:27 AM, Ming Lei wrote:
> > When one NVMe PCI device is being resetted and found reset failue,
> > nvme_remove_dead_ctrl() is called to handle the failure: blk-mq hw queues
> > are put into stopped first, then schedule .remove_work to release the driver.
> > 
> > Unfortunately if the driver is being released via sysfs store
> > just before the .remove_work is run, del_gendisk() from
> > nvme_remove() may hang forever because hw queues are stopped and
> > the submitted writeback IOs from fsync_bdev() can't be completed at all.
> > 
> > This patch fixes the following issue[1][2] by moving nvme_kill_queues()
> > into nvme_remove_dead_ctrl() to avoid the issue because nvme_remove()
> > flushs .reset_work, and this way is reasonable and safe because
> > nvme_dev_disable() has started to suspend queues and canceled requests
> > already.
> > 
> > [1] test script
> > 	fio -filename=$NVME_DISK -iodepth=1 -thread -rw=randwrite -ioengine=psync \
> > 	    -bssplit=5k/10:9k/10:13k/10:17k/10:21k/10:25k/10:29k/10:33k/10:37k/10:41k/10 \
> > 	    -bs_unaligned -runtime=1200 -size=-group_reporting -name=mytest -numjobs=60
> 
> Nit: the actual size after the -size parameter is missing.

Forget to mention, $NVME_DISK has to be one partition of nvme disk, and
the type need to be 'filesystem' type for reproduction, then actual size
isn't needed.

> 
> Anyways:
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

Thanks for review!


Thanks,
Ming
