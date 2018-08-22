Return-Path: <axboe@kernel.dk>
Subject: Re: MQ-BFQ crashing on battery mode
To: Massimo Burcheri <massimo@burcheri.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>
References: <1534926011.18658.29.camel@burcheri.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a43c5bdd-06ec-ae23-ebd3-bda8c0ea4f5c@kernel.dk>
Date: Wed, 22 Aug 2018 11:42:00 -0600
MIME-Version: 1.0
In-Reply-To: <1534926011.18658.29.camel@burcheri.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/22/18 2:20 AM, Massimo Burcheri wrote:
> Hello,
> 
> 
> I got a kernel trace when unplugging the power supply, switching to battery
> mode. I get the same kernel trace when booting on battery.
> Both making the system unusable or breaking the boot.
> 
> The kernel call trace with symbols:
> 
> ? blk_mq_requeue_request+0x...
> ? __scsi_queue_insert+0x...
> ? ata_scsi_var_len_cdb_xlat+0x
> ? __blk_mq_complete_request+0x...
> ? ata_scsi_translate+0x...
> ? ata_scsi_queuecmd+0x...
> ? scsi_dispatch_cmd+0x...
> ? scsi_queue_rq+0x...
> ? blk_mq_dispatch_rq_list+0x...
> ? kyber_dispatch_cur_domain+0x...
> ? kyber_completed_request+0x...
> ? blk_mq_sched_dispatch_requests+0x...
> ? __ blk_mq_run_hw_queue+0x...
> ? __blk_mq_delay_run_hw_queue+0x...
> ? blk_mq_run_hw_queue+0x...
> ? blk_mq_run_hw_queues+0x...
> ? blk_mq_requeue_work+0x...
> ? process_one_work+0x...
> ? worker_thread+0x...
> ? process_one_work+0x...
> ? kthread+0x...
> ? kthread_flush_work_fn+0x...
> ? ret_from_fork+0x...
> Code: ...
> RIP: sbitmap_queue_clear+0x...
> 
> Screenshot: 	https://ibin.co/4D34Ej3DWsqI.jpg
> Kernel config: 	https://bpaste.net/show/870004e55123
> 
> Kernel: 4.17.11-ck
> 
> Setup:
> 
> btrfs-on-bcache-on-luks
> btrfs options (rw,noatime,nodiratime,compress-
> force=lzo,nossd,noacl,space_cache,autodefrag)
> 
> Using mq bfq scheduler for the hdd backing and kyber for the ssd caching device
> 
> 
> Failed tests:
> Tested many kernel down to 4.13.2 with Gentoo or Ck patchset. Sorry for not
> including the vanilla sources in the test, I can provide if required.
> Skipping services in the boot process didn't help, any next service leads to the
> same trace.
> Switching off the laptop-mode-tools daemon didn't help.
> Switching all devices to "none" scheduler did not help.

Any chance you can try 4.18 at least?

> Workaround:
> After some tests and due to the *mq* call stack I was able to workaround by
> disabling CONFIG_SCSI_MQ_DEFAULT and CONFIG_DM_MQ_DEFAULT and switching all
> devices to cfq scheduler.
> However with the MQ enabled kernel, only bfq, kyber and none are possible, while
> the non-mq kernel can only set cfq. I guess this is intentional as the current
> bfq implementation is a MQ only version and CFQ is a non-mq only version?

Schedulers are specific to the queuing infrastructure, so certain types
will only be available with MQ and certain types will only be available
on !MQ.

-- 
Jens Axboe
