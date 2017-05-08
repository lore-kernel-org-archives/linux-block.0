Return-Path: <ming.lei@redhat.com>
Date: Mon, 8 May 2017 20:46:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: remove disk after hw queue is started
Message-ID: <20170508124638.GD5696@ming.t460p>
References: <20170508112457.10236-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170508112457.10236-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 08, 2017 at 07:24:57PM +0800, Ming Lei wrote:
> If hw queue is stopped, the following hang can be triggered
> when doing pci reset/remove and running heavy I/O load
> meantime.
> 
> This patch fixes the issue by calling nvme_uninit_ctrl()
> just after nvme_dev_disable(dev, true) in nvme_remove().
> 
> [  492.232593] INFO: task nvme-test:5939 blocked for more than 120 seconds.
> [  492.240081]       Not tainted 4.11.0.nvme_v4.11_debug_hang+ #3
> [  492.246600] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  492.255346] nvme-test       D    0  5939   5938 0x00000080
> [  492.261475] Call Trace:
> [  492.264215]  __schedule+0x289/0x8f0
> [  492.268105]  ? write_cache_pages+0x14c/0x510
> [  492.272873]  schedule+0x36/0x80
> [  492.276381]  io_schedule+0x16/0x40
> [  492.280181]  wait_on_page_bit_common+0x137/0x220
> [  492.285336]  ? page_cache_tree_insert+0x120/0x120
> [  492.290589]  __filemap_fdatawait_range+0x128/0x1a0
> [  492.295941]  filemap_fdatawait_range+0x14/0x30
> [  492.300902]  filemap_fdatawait+0x23/0x30
> [  492.305282]  filemap_write_and_wait+0x4c/0x80
> [  492.310151]  __sync_blockdev+0x1f/0x40
> [  492.314336]  fsync_bdev+0x44/0x50
> [  492.318039]  invalidate_partition+0x24/0x50
> [  492.322710]  del_gendisk+0xcd/0x2e0
> [  492.326608]  nvme_ns_remove+0x105/0x130 [nvme_core]
> [  492.332054]  nvme_remove_namespaces+0x32/0x50 [nvme_core]
> [  492.338082]  nvme_uninit_ctrl+0x2d/0xa0 [nvme_core]
> [  492.343519]  nvme_remove+0x5d/0x170 [nvme]
> [  492.348096]  pci_device_remove+0x39/0xc0
> [  492.352477]  device_release_driver_internal+0x141/0x1f0
> [  492.358311]  device_release_driver+0x12/0x20
> [  492.363072]  pci_stop_bus_device+0x8c/0xa0
> [  492.367646]  pci_stop_and_remove_bus_device_locked+0x1a/0x30
> [  492.373965]  remove_store+0x7c/0x90
> [  492.377852]  dev_attr_store+0x18/0x30
> [  492.381941]  sysfs_kf_write+0x3a/0x50
> [  492.386028]  kernfs_fop_write+0xff/0x180
> [  492.390409]  __vfs_write+0x37/0x160
> [  492.394304]  ? selinux_file_permission+0xe5/0x120
> [  492.399556]  ? security_file_permission+0x3b/0xc0
> [  492.404807]  vfs_write+0xb2/0x1b0
> [  492.408508]  ? syscall_trace_enter+0x1d0/0x2b0
> [  492.413462]  SyS_write+0x55/0xc0
> [  492.417064]  do_syscall_64+0x67/0x180
> [  492.421155]  entry_SYSCALL64_slow_path+0x25/0x25
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c8541c3dcd19..ebe13e157c00 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2185,8 +2185,8 @@ static void nvme_remove(struct pci_dev *pdev)
>  	}
>  
>  	flush_work(&dev->reset_work);
> -	nvme_uninit_ctrl(&dev->ctrl);
>  	nvme_dev_disable(dev, true);
> +	nvme_uninit_ctrl(&dev->ctrl);
>  	nvme_dev_remove_admin(dev);
>  	nvme_free_queues(dev, 0);
>  	nvme_release_cmb(dev);

This patch should be wrong, and looks the correct fix should be
flushing 'dev->remove_work' before calling nvme_uninit_ctrl().

But it might cause deadloack by calling flush_work(&dev->remove_work)
here simply.

Thanks,
Ming
