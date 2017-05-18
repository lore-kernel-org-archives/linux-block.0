Return-Path: <ming.lei@redhat.com>
Date: Thu, 18 May 2017 23:04:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Zhang Yi <yizhan@redhat.com>, linux-block@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: fix race between removing and reseting failure
Message-ID: <20170518150406.GB18526@ming.t460p>
References: <20170517012729.13469-1-ming.lei@redhat.com>
 <20170517012729.13469-2-ming.lei@redhat.com>
 <20170518134734.GA31489@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170518134734.GA31489@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 18, 2017 at 03:47:34PM +0200, Christoph Hellwig wrote:
> On Wed, May 17, 2017 at 09:27:28AM +0800, Ming Lei wrote:
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
> > 
> > 	sleep 35
> > 	echo 1 > $SYSFS_NVME_PCI_PATH/rescan
> > 	echo 1 > $SYSFS_NVME_PCI_PATH/reset
> > 	echo 1 > $SYSFS_NVME_PCI_PATH/remove
> > 	echo 1 > /sys/bus/pci/rescan
> > 
> > [2] kernel hang log
> > [  492.232593] INFO: task nvme-test:5939 blocked for more than 120 seconds.
> > [  492.240081]       Not tainted 4.11.0.nvme_v4.11_debug_hang+ #3
> > [  492.246600] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [  492.255346] nvme-test       D    0  5939   5938 0x00000080
> > [  492.261475] Call Trace:
> > [  492.264215]  __schedule+0x289/0x8f0
> > [  492.268105]  ? write_cache_pages+0x14c/0x510
> > [  492.272873]  schedule+0x36/0x80
> > [  492.276381]  io_schedule+0x16/0x40
> > [  492.280181]  wait_on_page_bit_common+0x137/0x220
> > [  492.285336]  ? page_cache_tree_insert+0x120/0x120
> > [  492.290589]  __filemap_fdatawait_range+0x128/0x1a0
> > [  492.295941]  filemap_fdatawait_range+0x14/0x30
> > [  492.300902]  filemap_fdatawait+0x23/0x30
> > [  492.305282]  filemap_write_and_wait+0x4c/0x80
> > [  492.310151]  __sync_blockdev+0x1f/0x40
> > [  492.314336]  fsync_bdev+0x44/0x50
> > [  492.318039]  invalidate_partition+0x24/0x50
> > [  492.322710]  del_gendisk+0xcd/0x2e0
> > [  492.326608]  nvme_ns_remove+0x105/0x130 [nvme_core]
> > [  492.332054]  nvme_remove_namespaces+0x32/0x50 [nvme_core]
> > [  492.338082]  nvme_uninit_ctrl+0x2d/0xa0 [nvme_core]
> > [  492.343519]  nvme_remove+0x5d/0x170 [nvme]
> > [  492.348096]  pci_device_remove+0x39/0xc0
> > [  492.352477]  device_release_driver_internal+0x141/0x1f0
> > [  492.358311]  device_release_driver+0x12/0x20
> > [  492.363072]  pci_stop_bus_device+0x8c/0xa0
> > [  492.367646]  pci_stop_and_remove_bus_device_locked+0x1a/0x30
> > [  492.373965]  remove_store+0x7c/0x90
> > [  492.377852]  dev_attr_store+0x18/0x30
> > [  492.381941]  sysfs_kf_write+0x3a/0x50
> > [  492.386028]  kernfs_fop_write+0xff/0x180
> > [  492.390409]  __vfs_write+0x37/0x160
> > [  492.394304]  ? selinux_file_permission+0xe5/0x120
> > [  492.399556]  ? security_file_permission+0x3b/0xc0
> > [  492.404807]  vfs_write+0xb2/0x1b0
> > [  492.408508]  ? syscall_trace_enter+0x1d0/0x2b0
> > [  492.413462]  SyS_write+0x55/0xc0
> > [  492.417064]  do_syscall_64+0x67/0x180
> > [  492.421155]  entry_SYSCALL64_slow_path+0x25/0x25
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/nvme/host/pci.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index fed803232edc..5e39abe57c56 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -1887,6 +1887,14 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
> >  
> >  	kref_get(&dev->ctrl.kref);
> >  	nvme_dev_disable(dev, false);
> 
> > +	/*
> > +	 * nvme_dev_disable() has suspended queues, then no new I/O
> > +	 * can be submitted to hardware successfully any more, so
> > +	 * kill queues now for avoiding race between reset failure
> > +	 * and remove.
> 
> How about this instead:
> 
> 	/*
> 	 * nvme_dev_disable() has suspended the I/O queues and no new I/O can
> 	 * be submitted now.  Kill the queues now to avoid races between a
> 	 * possible reset failure and the controller removal work.
> 	 */

That is fine, will change to this.

Thanks,
Ming
