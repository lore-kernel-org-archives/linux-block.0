Return-Path: <yizhan@redhat.com>
Subject: Re: [PATCH 1/2] nvme: fix race between removing and reseting failure
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20170517012729.13469-1-ming.lei@redhat.com>
 <20170517012729.13469-2-ming.lei@redhat.com>
 <d17e121f-799d-f555-8c7b-1d82ce61df53@kernel.dk>
 <20170519164038.GB4870@ming.t460p>
Cc: linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
 stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>
From: yizhan <yizhan@redhat.com>
Message-ID: <d288cb09-a2ea-b800-1fa9-dd0e4082df4e@redhat.com>
Date: Sat, 20 May 2017 00:55:50 +0800
MIME-Version: 1.0
In-Reply-To: <20170519164038.GB4870@ming.t460p>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 05/20/2017 12:40 AM, Ming Lei wrote:
> On Fri, May 19, 2017 at 08:41:13AM -0600, Jens Axboe wrote:
>> On 05/16/2017 07:27 PM, Ming Lei wrote:
>>> When one NVMe PCI device is being resetted and found reset failue,
>>> nvme_remove_dead_ctrl() is called to handle the failure: blk-mq hw queues
>>> are put into stopped first, then schedule .remove_work to release the driver.
>>>
>>> Unfortunately if the driver is being released via sysfs store
>>> just before the .remove_work is run, del_gendisk() from
>>> nvme_remove() may hang forever because hw queues are stopped and
>>> the submitted writeback IOs from fsync_bdev() can't be completed at all.
>>>
>>> This patch fixes the following issue[1][2] by moving nvme_kill_queues()
>>> into nvme_remove_dead_ctrl() to avoid the issue because nvme_remove()
>>> flushs .reset_work, and this way is reasonable and safe because
>>> nvme_dev_disable() has started to suspend queues and canceled requests
>>> already.
>>>
>>> [1] test script
>>> 	fio -filename=$NVME_DISK -iodepth=1 -thread -rw=randwrite -ioengine=psync \
>>> 	    -bssplit=5k/10:9k/10:13k/10:17k/10:21k/10:25k/10:29k/10:33k/10:37k/10:41k/10 \
>>> 	    -bs_unaligned -runtime=1200 -size=-group_reporting -name=mytest -numjobs=60
>>>
>>> 	sleep 35
>>> 	echo 1 > $SYSFS_NVME_PCI_PATH/rescan
>>> 	echo 1 > $SYSFS_NVME_PCI_PATH/reset
>>> 	echo 1 > $SYSFS_NVME_PCI_PATH/remove
>>> 	echo 1 > /sys/bus/pci/rescan
>> The patch looks good to me. But since you have a nice reproducer, how about
>> turning that into a blktests [1] test case?
>>
>> [1] https://github.com/osandov/blktests
> Forget to mention, this test case is written by Zhang Yi.
>
> Zhang Yi, maybe you can try to integrate your NVMe test case into
> blktests if you are interested, :-)
Sure, I will have a try. :)

Thanks
Yi
> Thanks,
> Ming
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
