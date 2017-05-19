Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] nvme: fix race between removing and reseting failure
To: Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Zhang Yi <yizhan@redhat.com>,
 linux-block@vger.kernel.org, stable@vger.kernel.org
References: <20170517012729.13469-1-ming.lei@redhat.com>
 <20170517012729.13469-2-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d17e121f-799d-f555-8c7b-1d82ce61df53@kernel.dk>
Date: Fri, 19 May 2017 08:41:13 -0600
MIME-Version: 1.0
In-Reply-To: <20170517012729.13469-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/16/2017 07:27 PM, Ming Lei wrote:
> When one NVMe PCI device is being resetted and found reset failue,
> nvme_remove_dead_ctrl() is called to handle the failure: blk-mq hw queues
> are put into stopped first, then schedule .remove_work to release the driver.
> 
> Unfortunately if the driver is being released via sysfs store
> just before the .remove_work is run, del_gendisk() from
> nvme_remove() may hang forever because hw queues are stopped and
> the submitted writeback IOs from fsync_bdev() can't be completed at all.
> 
> This patch fixes the following issue[1][2] by moving nvme_kill_queues()
> into nvme_remove_dead_ctrl() to avoid the issue because nvme_remove()
> flushs .reset_work, and this way is reasonable and safe because
> nvme_dev_disable() has started to suspend queues and canceled requests
> already.
> 
> [1] test script
> 	fio -filename=$NVME_DISK -iodepth=1 -thread -rw=randwrite -ioengine=psync \
> 	    -bssplit=5k/10:9k/10:13k/10:17k/10:21k/10:25k/10:29k/10:33k/10:37k/10:41k/10 \
> 	    -bs_unaligned -runtime=1200 -size=-group_reporting -name=mytest -numjobs=60
> 
> 	sleep 35
> 	echo 1 > $SYSFS_NVME_PCI_PATH/rescan
> 	echo 1 > $SYSFS_NVME_PCI_PATH/reset
> 	echo 1 > $SYSFS_NVME_PCI_PATH/remove
> 	echo 1 > /sys/bus/pci/rescan

The patch looks good to me. But since you have a nice reproducer, how about
turning that into a blktests [1] test case?

[1] https://github.com/osandov/blktests

-- 
Jens Axboe
