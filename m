Return-Path: <holger@applied-asynchrony.com>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Mike Galbraith <efault@gmx.de>,
 Oleksandr Natalenko <oleksandr@natalenko.name>, Jens Axboe
 <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>,
 Alban Browaeys <alban.browaeys@gmail.com>, ming.lei@redhat.com,
 ivan@ludios.org, 169364@studenti.unimore.it,
 Serena Ziviani <ziviani.serena@gmail.com>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
 <20180205190510.5499-2-paolo.valente@linaro.org>
 <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
 <1517903761.9843.12.camel@gmx.de>
 <899B68CC-5955-4418-8BFF-DC55A743A61B@linaro.org>
 <1517918234.25841.31.camel@gmx.de>
 <BE442D49-D280-4B35-89ED-43C729263F2A@linaro.org>
 <7770589c-32e0-6bdb-530a-34c642e46630@applied-asynchrony.com>
 <a02e6252-e607-3a49-0916-81d7cabc768a@applied-asynchrony.com>
 <E5D79BA7-68B1-4107-9D49-0AC512BD254F@linaro.org>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Message-ID: <b38a023d-c1c0-628a-b39c-2fe1d4250ba2@applied-asynchrony.com>
Date: Tue, 6 Feb 2018 16:34:28 +0100
MIME-Version: 1.0
In-Reply-To: <E5D79BA7-68B1-4107-9D49-0AC512BD254F@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 02/06/18 15:55, Paolo Valente wrote:
> 
> 
>> Il giorno 06 feb 2018, alle ore 14:40, Holger Hoffstätte <holger@applied-asynchrony.com> ha scritto:
>>
>>
>> The plot thickens!
>>
> 
> Yep, the culprit seems clearer, though ...
> 
>> Just as I was about to post that I didn't have any problems - because
>> I didn't have any - I decided to do a second test, activated bfq on my
>> workstation, on a hunch typed "sync" and .. the machine locked up, hard.
>>
>> Rebooted, activated bfq, typed sync..sync hangs. Luckily this time
>> a second terminal was still alive, so I could capture a trace for
>> your enjoyment:
>>
>> Feb  6 14:28:17 ragnarok kernel: io scheduler bfq registered
>> Feb  6 14:28:20 ragnarok kernel: BUG: unable to handle kernel NULL pointer dereference at 0000000000000030
>> Feb  6 14:28:20 ragnarok kernel: IP: bfq_put_queue+0x10b/0x130 [bfq]
>> Feb  6 14:28:20 ragnarok kernel: PGD 0 P4D 0 
>> Feb  6 14:28:20 ragnarok kernel: Oops: 0000 [#1] SMP PTI
>> Feb  6 14:28:20 ragnarok kernel: Modules linked in: bfq lz4 lz4_compress lz4_decompress nfs lockd grace sunrpc autofs4 sch_fq_codel it87 hwmon_vid x86_pkg_temp_thermal snd_hda_codec_realtek coretemp radeon crc32_pclmul snd_hda_codec_generic crc32c_intel pcbc snd_hda_codec_hdmi i2c_algo_bit aesni_intel drm_kms_helper aes_x86_64 uvcvideo syscopyarea crypto_simd snd_hda_intel sysfillrect cryptd snd_usb_audio sysimgblt videobuf2_vmalloc glue_helper fb_sys_fops snd_hda_codec snd_hwdep videobuf2_memops ttm videobuf2_v4l2 snd_usbmidi_lib videobuf2_core snd_rawmidi snd_hda_core drm snd_seq_device videodev snd_pcm i2c_i801 usbhid snd_timer i2c_core snd backlight soundcore r8169 parport_pc mii parport
>> Feb  6 14:28:20 ragnarok kernel: CPU: 0 PID: 4 Comm: kworker/0:0H Not tainted 4.14.18 #1
>> Feb  6 14:28:20 ragnarok kernel: Hardware name: Gigabyte Technology Co., Ltd. P67-DS3-B3/P67-DS3-B3, BIOS F1 05/06/2011
>> Feb  6 14:28:20 ragnarok kernel: Workqueue: kblockd blk_mq_requeue_work
>> Feb  6 14:28:20 ragnarok kernel: task: ffff88060395a1c0 task.stack: ffffc90000044000
>> Feb  6 14:28:20 ragnarok kernel: RIP: 0010:bfq_put_queue+0x10b/0x130 [bfq]
>> Feb  6 14:28:20 ragnarok kernel: RSP: 0018:ffffc90000047ca0 EFLAGS: 00010286
>> Feb  6 14:28:20 ragnarok kernel: RAX: 0000000000000008 RBX: ffff8806023db690 RCX: 0000000000000000
>> Feb  6 14:28:20 ragnarok kernel: RDX: 0000000000000000 RSI: ffff880601bb39b0 RDI: ffff880601a56400
>> Feb  6 14:28:20 ragnarok kernel: RBP: 0000000001bb3980 R08: 0000000000000053 R09: ffff8806023db690
>> Feb  6 14:28:20 ragnarok kernel: R10: 000000001dd0f11e R11: 00000000080a011b R12: ffff880601a56400
>> Feb  6 14:28:20 ragnarok kernel: R13: ffff8806023dbed0 R14: 0000000000000053 R15: 0000000000000000
>> Feb  6 14:28:20 ragnarok kernel: FS:  0000000000000000(0000) GS:ffff88061f400000(0000) knlGS:0000000000000000
>> Feb  6 14:28:20 ragnarok kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> Feb  6 14:28:20 ragnarok kernel: CR2: 0000000000000030 CR3: 000000000200a002 CR4: 00000000000606f0
>> Feb  6 14:28:20 ragnarok kernel: Call Trace:
>> Feb  6 14:28:20 ragnarok kernel:  bfq_finish_requeue_request+0x4b/0x370 [bfq]
>> Feb  6 14:28:20 ragnarok kernel:  __blk_mq_requeue_request+0x57/0x130
>> Feb  6 14:28:20 ragnarok kernel:  blk_mq_dispatch_rq_list+0x1b3/0x510
>> Feb  6 14:28:20 ragnarok kernel:  ? __bfq_bfqd_reset_in_service+0x20/0x70 [bfq]
>> Feb  6 14:28:20 ragnarok kernel:  ? bfq_bfqq_expire+0x212/0x740 [bfq]
>> Feb  6 14:28:20 ragnarok kernel:  blk_mq_sched_dispatch_requests+0xf0/0x170
>> Feb  6 14:28:20 ragnarok kernel:  __blk_mq_run_hw_queue+0x4e/0x90
>> Feb  6 14:28:20 ragnarok kernel:  __blk_mq_delay_run_hw_queue+0x73/0x80
>> Feb  6 14:28:20 ragnarok kernel:  blk_mq_run_hw_queue+0x53/0x150
>> Feb  6 14:28:20 ragnarok kernel:  blk_mq_run_hw_queues+0x3a/0x50
>> Feb  6 14:28:20 ragnarok kernel:  blk_mq_requeue_work+0x104/0x110
>> Feb  6 14:28:20 ragnarok kernel:  process_one_work+0x1d4/0x3d0
>> Feb  6 14:28:20 ragnarok kernel:  worker_thread+0x2b/0x3c0
>> Feb  6 14:28:20 ragnarok kernel:  ? process_one_work+0x3d0/0x3d0
>> Feb  6 14:28:20 ragnarok kernel:  kthread+0x117/0x130
>> Feb  6 14:28:20 ragnarok kernel:  ? kthread_create_on_node+0x40/0x40
>> Feb  6 14:28:20 ragnarok kernel:  ret_from_fork+0x1f/0x30
>> Feb  6 14:28:20 ragnarok kernel: Code: c1 e8 06 83 e0 01 48 83 f8 01 45 19 f6 e8 ce 3a 00 00 41 83 e6 ee 48 89 c7 41 83 c6 53 e8 9e 3a 00 00 49 89 d9 45 89 f0 44 89 f9 <48> 8b 70 28 48 c7 c2 d8 00 25 a0 55 4c 89 ef e8 11 ba ea e0 8b 
>> Feb  6 14:28:20 ragnarok kernel: RIP: bfq_put_queue+0x10b/0x130 [bfq] RSP: ffffc90000047ca0
>> Feb  6 14:28:20 ragnarok kernel: CR2: 0000000000000030
>> Feb  6 14:28:20 ragnarok kernel: ---[ end trace 8b782ace30a4e7d8 ]---
>>
> 
> Same request: please
> gdb <buildir>/block/bfq-iosched.o
> list *(bfq_finish_requeue_request+0x4b)
> list *(bfq_put_queue+0x10b)

(gdb) list *(bfq_finish_requeue_request+0x4b)
0x46cb is in bfq_finish_requeue_request (block/bfq-iosched.c:4804).
4799		 * that re-insertions of requeued requests, without
4800		 * re-preparation, can happen only for pass_through or at_head
4801		 * requests (which are not re-inserted into bfq internal
4802		 * queues).
4803		 */
4804		rq->elv.priv[0] = NULL;
4805		rq->elv.priv[1] = NULL;
4806	}
4807	
4808	/*

(gdb) list *(bfq_put_queue+0x10b)
0x415b is in bfq_put_queue (block/bfq-iosched.c:3978).
3973	#ifdef CONFIG_BFQ_GROUP_IOSCHED
3974		struct bfq_group *bfqg = bfqq_group(bfqq);
3975	#endif
3976	
3977		if (bfqq->bfqd)
3978			bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: %p %d",
3979				     bfqq, bfqq->ref);
3980	
3981		bfqq->ref--;
3982		if (bfqq->ref)

Hope this helps!

Holger
