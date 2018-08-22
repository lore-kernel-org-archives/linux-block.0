Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: MQ-BFQ crashing on battery mode
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1534926011.18658.29.camel@burcheri.de>
Date: Wed, 22 Aug 2018 10:30:12 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <282984A0-62E1-4762-9C31-51327C0D0BFF@linaro.org>
References: <1534926011.18658.29.camel@burcheri.de>
To: Massimo Burcheri <massimo@burcheri.de>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 22 ago 2018, alle ore 10:20, Massimo Burcheri =
<massimo@burcheri.de> ha scritto:
>=20
> Hello,
>=20
>=20
> I got a kernel trace when unplugging the power supply, switching to =
battery
> mode. I get the same kernel trace when booting on battery.
> Both making the system unusable or breaking the boot.
>=20
> The kernel call trace with symbols:
>=20
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
>=20
> Screenshot: 	https://ibin.co/4D34Ej3DWsqI.jpg
> Kernel config: 	https://bpaste.net/show/870004e55123
>=20
> Kernel: 4.17.11-ck
>=20
> Setup:
>=20
> btrfs-on-bcache-on-luks
> btrfs options (rw,noatime,nodiratime,compress-
> force=3Dlzo,nossd,noacl,space_cache,autodefrag)
>=20
> Using mq bfq scheduler for the hdd backing and kyber for the ssd =
caching device
>=20
>=20

Hi,
I'm missing why you mention bfq in the subject, as, according to the
trace, the failure has not to do with bfq.  IIRC this failure, or a
very similar one, has been reported recently (and maybe fixed too).

Thanks,
Paolo

> Failed tests:
> Tested many kernel down to 4.13.2 with Gentoo or Ck patchset. Sorry =
for not
> including the vanilla sources in the test, I can provide if required.
> Skipping services in the boot process didn't help, any next service =
leads to the
> same trace.
> Switching off the laptop-mode-tools daemon didn't help.
> Switching all devices to "none" scheduler did not help.
>=20
>=20
> Workaround:
> After some tests and due to the *mq* call stack I was able to =
workaround by
> disabling CONFIG_SCSI_MQ_DEFAULT and CONFIG_DM_MQ_DEFAULT and =
switching all
> devices to cfq scheduler.
> However with the MQ enabled kernel, only bfq, kyber and none are =
possible, while
> the non-mq kernel can only set cfq. I guess this is intentional as the =
current
> bfq implementation is a MQ only version and CFQ is a non-mq only =
version?
>=20
> Best regards,
> Massimo
