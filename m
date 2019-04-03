Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865ECC4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 14:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4023120830
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 14:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfDCOxZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:53:25 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45006 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbfDCOxU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 10:53:20 -0400
Received: by mail-qk1-f194.google.com with SMTP id y5so10285685qkc.11
        for <linux-block@vger.kernel.org>; Wed, 03 Apr 2019 07:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iCXzKDrY11Na2KmcMYovuNCfk/z9XnPrBNAjUzcdSRk=;
        b=PuZBpXpBKfHMmf2yX7mPEO4AvBZCxXgTaOf/baB0gfmt42M7m3CCvO0klLRKPAOtBE
         +EvgVTfSQEqjvhFHnaOp3oUno8K5aaVnpQHRA8je7Yrg2TEdHc2YoYy/dqH5rljPcIXw
         e3BW3MCk+gLZxpjIbnTTu9o2AHGgsHuE7mX3AIVjo/efvaGLCgUYNoQAAWM76wgy/uX7
         nsVuT3uxrwbGT0JZLMwJSWUyFZjkPwDbmjiovjOLtDyO5TU0rk9mCptybALqhslTwVzS
         91DbaC87NzqYaoOgiPhJ+ZSpe7WvGNBr4mjSNhcGzc+G8i7GDWZfRQK8wbeLlnhCtmcS
         Mjzw==
X-Gm-Message-State: APjAAAVz/GmGqR0blimCysVIpvKRCp60m45uA38GV8RqVV6f+zwNxIkl
        avbB8m1ciaOcNar7iFVZW94TLA==
X-Google-Smtp-Source: APXvYqz83qROyHcIDiqGzC4iG/vf0pCjUxumG6DsvOEAuA8oovlSBTGnZoNWn/FN9S0A7tLaX644OQ==
X-Received: by 2002:a37:64c7:: with SMTP id y190mr377648qkb.67.1554303198393;
        Wed, 03 Apr 2019 07:53:18 -0700 (PDT)
Received: from dhcp-49-37.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 76sm9525025qkf.88.2019.04.03.07.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 07:53:17 -0700 (PDT)
Message-ID: <3a0e6f4b35742a31dc5f11fab30dbdacf673b9ba.camel@redhat.com>
Subject: Re: Panic when rebooting target server testing srp on 5.0.0-rc2
From:   Laurence Oberman <loberman@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>
Date:   Wed, 03 Apr 2019 10:53:16 -0400
In-Reply-To: <10c96c79ed7a51ec22c6ccecbdbc3323655903b1.camel@redhat.com>
References: <6e19971d315f4a3ce2cc20a1c6693f4a263a280c.camel@redhat.com>
         <7858e19ce3fc3ebf7845494a2209c58cd9e3086d.camel@redhat.com>
         <1553113730.65329.60.camel@acm.org>
         <3645c45e88523d4b242333d96adbb492ab100f97.camel@redhat.com>
         <d9febee1de759206bbf4d66f6570415ae64e4f33.camel@redhat.com>
         <8a6807100283a0c1256410f4f0381979b18398fe.camel@redhat.com>
         <10c96c79ed7a51ec22c6ccecbdbc3323655903b1.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-03-26 at 15:06 -0400, Laurence Oberman wrote:
> On Tue, 2019-03-26 at 11:16 -0400, Laurence Oberman wrote:
> > On Thu, 2019-03-21 at 08:44 -0400, Laurence Oberman wrote:
> > > On Wed, 2019-03-20 at 16:35 -0400, Laurence Oberman wrote:
> > > > On Wed, 2019-03-20 at 13:28 -0700, Bart Van Assche wrote:
> > > > > On Wed, 2019-03-20 at 11:11 -0400, Laurence Oberman wrote:
> > > > > > On Wed, 2019-03-20 at 09:45 -0400, Laurence Oberman wrote:
> > > > > > > Hello Bart, I hope all is well with you.
> > > > > > > 
> > > > > > > Quick question
> > > > > > > preparing to test v5.1-rc2 SRP, my usual method is first
> > > > > > > validate
> > > > > > > the
> > > > > > > prior kernel I had in place.
> > > > > > > This had passed tests previously (5.0.0-rc2) but I had
> > > > > > > not
> > > > > > > run
> > > > > > > the
> > > > > > > target server reboot test, just the disconnect tests.
> > > > > > > 
> > > > > > > Today with mapped SRP devices I rebooted the target
> > > > > > > server
> > > > > > > and
> > > > > > > the
> > > > > > > client panicked.
> > > > > > > 
> > > > > > > Its been a while and I have been so busy that have not
> > > > > > > kept
> > > > > > > up
> > > > > > > with
> > > > > > > all
> > > > > > > the fixes. Is this a known issue.
> > > > > > > 
> > > > > > > Thanks
> > > > > > > Laurence
> > > > > > > 
> > > > > > > 5414228.917507] scsi host2: ib_srp: Path record query
> > > > > > > failed:
> > > > > > > sgid
> > > > > > > fe80:0000:0000:0000:7cfe:9003:0072:6ed3, dgid
> > > > > > > fe80:0000:0000:0000:7cfe:9003:0072:6e4f, pkey 0xffff,
> > > > > > > service_id
> > > > > > > 0x7cfe900300726e4e
> > > > > > > [5414229.014355] scsi host2: reconnect attempt 7 failed
> > > > > > > (-
> > > > > > > 110)
> > > > > > > [5414239.318161] scsi host2: ib_srp: Sending CM DREQ
> > > > > > > failed
> > > > > > > [5414239.318165] scsi host2: ib_srp: Sending CM DREQ
> > > > > > > failed
> > > > > > > [5414239.318167] scsi host2: ib_srp: Sending CM DREQ
> > > > > > > failed
> > > > > > > [5414239.318168] scsi host2: ib_srp: Sending CM DREQ
> > > > > > > failed
> > > > > > > [5414239.318170] scsi host2: ib_srp: Sending CM DREQ
> > > > > > > failed
> > > > > > > [5414239.318172] scsi host2: ib_srp: Sending CM DREQ
> > > > > > > failed
> > > > > > > [5414239.318173] scsi host2: ib_srp: Sending CM DREQ
> > > > > > > failed
> > > > > > > [5414239.318175] scsi host2: ib_srp: Sending CM DREQ
> > > > > > > failed
> > > > > > > [5414243.670072] scsi host2: ib_srp: Got failed path rec
> > > > > > > status
> > > > > > > -110
> > > > > > > [5414243.702179] scsi host2: ib_srp: Path record query
> > > > > > > failed:
> > > > > > > sgid
> > > > > > > fe80:0000:0000:0000:7cfe:9003:0072:6ed3, dgid
> > > > > > > fe80:0000:0000:0000:7cfe:9003:0072:6e4f, pkey 0xffff,
> > > > > > > service_id
> > > > > > > 0x7cfe900300726e4e
> > > > > > > [5414243.799313] scsi host2: reconnect attempt 8 failed
> > > > > > > (-
> > > > > > > 110)
> > > > > > > [5414247.510115] scsi host1: ib_srp: Sending CM REQ
> > > > > > > failed
> > > > > > > [5414247.510140] scsi host1: reconnect attempt 1 failed
> > > > > > > (-
> > > > > > > 104)
> > > > > > > [5414247.849078] BUG: unable to handle kernel NULL
> > > > > > > pointer
> > > > > > > dereference
> > > > > > > at 00000000000000b8
> > > > > > > [5414247.893793] #PF error: [normal kernel read fault]
> > > > > > > [5414247.921839] PGD 0 P4D 0 
> > > > > > > [5414247.937280] Oops: 0000 [#1] SMP PTI
> > > > > > > [5414247.958332] CPU: 4 PID: 7773 Comm: kworker/4:1H
> > > > > > > Kdump:
> > > > > > > loaded
> > > > > > > Tainted: G          I       5.0.0-rc2+ #2
> > > > > > > [5414248.012856] Hardware name: HP ProLiant DL380 G7,
> > > > > > > BIOS
> > > > > > > P67
> > > > > > > 08/16/2015
> > > > > > > [5414248.026174] device-mapper: multipath: Failing path
> > > > > > > 8:48.
> > > > > > > 
> > > > > > > 
> > > > > > > [5414248.050003] Workqueue: kblockd blk_mq_run_work_fn
> > > > > > > [5414248.108378] RIP:
> > > > > > > 0010:blk_mq_dispatch_rq_list+0xc9/0x590
> > > > > > > [5414248.139724] Code: 0f 85 c2 04 00 00 83 44 24 28 01
> > > > > > > 48
> > > > > > > 8b
> > > > > > > 45
> > > > > > > 00
> > > > > > > 48
> > > > > > > 39 c5 0f 84 ea 00 00 00 48 8b 5d 00 80 3c 24 00 4c 8d 6b
> > > > > > > b8
> > > > > > > 4c
> > > > > > > 8b
> > > > > > > 63
> > > > > > > c8
> > > > > > > 75 25 <49> 8b 84 24 b8 00 00 00 48 8b 40 40 48 8b 40 10
> > > > > > > 48
> > > > > > > 85
> > > > > > > c0
> > > > > > > 74
> > > > > > > 10
> > > > > > > 4c
> > > > > > > [5414248.246176] RSP: 0018:ffffb1cd8760fd90 EFLAGS:
> > > > > > > 00010246
> > > > > > > [5414248.275599] RAX: ffffa049d67a1308 RBX:
> > > > > > > ffffa049d67a1308
> > > > > > > RCX:
> > > > > > > 0000000000000004
> > > > > > > [5414248.316090] RDX: 0000000000000000 RSI:
> > > > > > > ffffb1cd8760fe20
> > > > > > > RDI:
> > > > > > > ffffa0552ca08000
> > > > > > > [5414248.356884] RBP: ffffb1cd8760fe20 R08:
> > > > > > > 0000000000000000
> > > > > > > R09:
> > > > > > > 8080808080808080
> > > > > > > [5414248.397632] R10: 0000000000000001 R11:
> > > > > > > 0000000000000001
> > > > > > > R12:
> > > > > > > 0000000000000000
> > > > > > > [5414248.439323] R13: ffffa049d67a12c0 R14:
> > > > > > > 0000000000000000
> > > > > > > R15:
> > > > > > > ffffa0552ca08000
> > > > > > > [5414248.481743] FS:  0000000000000000(0000)
> > > > > > > GS:ffffa04a37880000(0000)
> > > > > > > knlGS:0000000000000000
> > > > > > > [5414248.528310] CS:  0010 DS: 0000 ES: 0000 CR0:
> > > > > > > 0000000080050033
> > > > > > > [5414248.561779] CR2: 00000000000000b8 CR3:
> > > > > > > 0000000e9d40e004
> > > > > > > CR4:
> > > > > > > 00000000000206e0
> > > > > > > [5414248.602420] Call Trace:
> > > > > > > [5414248.616660]  blk_mq_sched_dispatch_requests+0x15c/0x
> > > > > > > 18
> > > > > > > 0
> > > > > > > [5414248.647066]  __blk_mq_run_hw_queue+0x5f/0xf0
> > > > > > > [5414248.672633]  process_one_work+0x171/0x370
> > > > > > > [5414248.695443]  worker_thread+0x49/0x3f0
> > > > > > > [5414248.716730]  kthread+0xf8/0x130
> > > > > > > [5414248.735085]  ? max_active_store+0x80/0x80
> > > > > > > [5414248.758569]  ? kthread_bind+0x10/0x10
> > > > > > > [5414248.779953]  ret_from_fork+0x35/0x40
> > > > > > > 
> > > > > > > [5414248.801005] Modules linked in: ib_isert
> > > > > > > iscsi_target_mod
> > > > > > > target_core_mod ib_srp rpcrdma scsi_transport_srp
> > > > > > > rdma_ucm
> > > > > > > ib_iser
> > > > > > > ib_ipoib ib_umad rdma_cm libiscsi iw_cm
> > > > > > > scsi_transport_iscsi
> > > > > > > ib_cm
> > > > > > > sunrpc mlx5_ib ib_uverbs ib_core intel_powerclamp
> > > > > > > coretemp
> > > > > > > kvm_intel
> > > > > > > kvm irqbypass ipmi_ssif crct10dif_pclmul crc32_pclmul
> > > > > > > ghash_clmulni_intel aesni_intel iTCO_wdt crypto_simd
> > > > > > > cryptd
> > > > > > > gpio_ich
> > > > > > > iTCO_vendor_support glue_helper joydev ipmi_si
> > > > > > > dm_service_time
> > > > > > > pcspkr
> > > > > > > ipmi_devintf hpilo hpwdt sg ipmi_msghandler
> > > > > > > acpi_power_meter
> > > > > > > lpc_ich
> > > > > > > i7core_edac pcc_cpufreq dm_multipath ip_tables xfs
> > > > > > > libcrc32c
> > > > > > > radeon
> > > > > > > sd_mod i2c_algo_bit drm_kms_helper syscopyarea
> > > > > > > sysfillrect
> > > > > > > sysimgblt
> > > > > > > fb_sys_fops ttm drm mlx5_core crc32c_intel serio_raw
> > > > > > > i2c_core
> > > > > > > hpsa
> > > > > > > bnx2
> > > > > > > scsi_transport_sas mlxfw devlink dm_mirror dm_region_hash
> > > > > > > dm_log
> > > > > > > dm_mod
> > > > > > > [5414249.199354] CR2: 00000000000000b8
> > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > > Looking at the vmcore
> > > > > > 
> > > > > > PID: 7773   TASK: ffffa04a2c1e2b80  CPU: 4   COMMAND:
> > > > > > "kworker/4:1H"
> > > > > >  #0 [ffffb1cd8760fab0] machine_kexec at ffffffffaaa6003f
> > > > > >  #1 [ffffb1cd8760fb08] __crash_kexec at ffffffffaab373ed
> > > > > >  #2 [ffffb1cd8760fbd0] crash_kexec at ffffffffaab385b9
> > > > > >  #3 [ffffb1cd8760fbe8] oops_end at ffffffffaaa31931
> > > > > >  #4 [ffffb1cd8760fc08] no_context at ffffffffaaa6eb59
> > > > > >  #5 [ffffb1cd8760fcb0] do_page_fault at ffffffffaaa6feb2
> > > > > >  #6 [ffffb1cd8760fce0] page_fault at ffffffffab2010ee
> > > > > >     [exception RIP: blk_mq_dispatch_rq_list+201]
> > > > > >     RIP: ffffffffaad90589  RSP: ffffb1cd8760fd90  RFLAGS:
> > > > > > 00010246
> > > > > >     RAX: ffffa049d67a1308  RBX: ffffa049d67a1308  RCX:
> > > > > > 0000000000000004
> > > > > >     RDX: 0000000000000000  RSI: ffffb1cd8760fe20  RDI:
> > > > > > ffffa0552ca08000
> > > > > >     RBP: ffffb1cd8760fe20   R8: 0000000000000000   R9:
> > > > > > 8080808080808080
> > > > > >     R10: 0000000000000001  R11: 0000000000000001  R12:
> > > > > > 0000000000000000
> > > > > >     R13: ffffa049d67a12c0  R14: 0000000000000000  R15:
> > > > > > ffffa0552ca08000
> > > > > >     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> > > > > >  #7 [ffffb1cd8760fe18] blk_mq_sched_dispatch_requests at
> > > > > > ffffffffaad9570c
> > > > > >  #8 [ffffb1cd8760fe60] __blk_mq_run_hw_queue at
> > > > > > ffffffffaad8de3f
> > > > > >  #9 [ffffb1cd8760fe78] process_one_work at ffffffffaaab0ab1
> > > > > > #10 [ffffb1cd8760feb8] worker_thread at ffffffffaaab11d9
> > > > > > #11 [ffffb1cd8760ff10] kthread at ffffffffaaab6758
> > > > > > #12 [ffffb1cd8760ff50] ret_from_fork at ffffffffab200215
> > > > > > 
> > > > > > We were working on this request_queue for
> > > > > >  blk_mq_sched_dispatch_requests
> > > > > > 
> > > > > > crash> dev -d | grep ffffa0552ca08000
> > > > > >     8
> > > > > > ffffa055c81b5800   sdd        ffffa0552ca08000       0     
> > > > > > 0 
> > > > > >   
> > > > > >   
> > > > > > 0 
> > > > > > ]
> > > > > > 
> > > > > > That device was no longer accessible 
> > > > > > 
> > > > > > sdev_state = SDEV_TRANSPORT_OFFLINE,
> > > > > > 
> > > > > > So it looks like we tried to process a no longer valid list
> > > > > > entry
> > > > > > in 
> > > > > > blk_mq_dispatch_rq_list
> > > > > > 
> > > > > > /home/loberman/rpmbuild/BUILD/kernel-5.0.0_rc2+/block/blk-
> > > > > > mq.h:
> > > > > > 211
> > > > > > 0xffffffffaad90589
> > > > > > <blk_mq_dispatch_rq_list+201>:       mov    0xb8(%r12),%rax
> > > > > > 
> > > > > > R12 is NULL
> > > > > > 
> > > > > > 
> > > > > > From
> > > > > > static inline bool blk_mq_get_dispatch_budget(struct
> > > > > > blk_mq_hw_ctx
> > > > > > *hctx)
> > > > > > {
> > > > > >         struct request_queue *q = hctx->queue;
> > > > > > 
> > > > > >         if (q->mq_ops->get_budget)
> > > > > >                 return q->mq_ops->get_budget(hctx);
> > > > > >         return true;
> > > > > > }
> > > > > > 
> > > > > > Willw ait for a reply befaore i try the newer kernel, but
> > > > > > looks
> > > > > > like a
> > > > > > use after free to me
> > > > > 
> > > > > Hi Laurence,
> > > > > 
> > > > > I don't think that any of the recent SRP initiator changes
> > > > > can
> > > > > be
> > > > > the
> > > > > root
> > > > > cause of this crash. However, significant changes went
> > > > > upstream
> > > > > in
> > > > > the block
> > > > > layer core during the v5.1-rc1 merge window, e.g. multi-page
> > > > > bvec
> > > > > support.
> > > > > Is it possible for you to bisect this kernel oops?
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > Bart.
> > > > > 
> > > > 
> > > > OK, I will see I can reproduce on the fly and I will bisect.
> > > > I do agree its not SRP, more likley some block layer race.
> > > > I was just able to reproduce it using SRP
> > > > 
> > > > Note that this was on 5.0.0-rc2+, prior to me trying 5.1.
> > > > 
> > > > I usually reboot the target server as part of my test series
> > > > but
> > > > when
> > > > I
> > > > last tested 5.0.0-rc2+ I only reset the SRP interfaces and had
> > > > devices
> > > > get rediscovered.
> > > > 
> > > > I did not see it during those tests.
> > > > 
> > > > Back when I have more to share.
> > > > 
> > > > Many Thanks for your time as always
> > > > Laurence
> > > > 
> > > > 
> > > 
> > > Something crept in, in the block layer causing a use after free
> > > 4.19.0-rc1+ does not have the issue, so I will narrow the bisect 
> > > Thanks
> > > Laurence
> > > 
> > 
> > This took a long time to bisect.
> > Repeating the issue seen. We have changes that when the target is
> > rebooted with mapped srp devices the client then experiences a ist
> > corruption and panic as already shown.
> > 
> > Some stacks
> > 
> > [  222.631998] scsi host1: ib_srp: Path record query failed: sgid
> > fe80:0000:0000:0000:7cfe:9003:0072:6ed2, dgid
> > fe80:0000:0000:0000:7cfe:9003:0072:6e4e, pkey 0xffff, service_id
> > 0x7cfe900300726e4e
> > [  222.729639] scsi host1: reconnect attempt 1 failed (-110)
> > [  223.176766] fast_io_fail_tmo expired for SRP port-1:1 / host1.
> > 
> > [  223.518759] BUG: unable to handle kernel NULL pointer
> > dereference
> > at
> > 00000000000000b8
> > [  223.519736] sd 1:0:0:0: rejecting I/O to offline device
> > [  223.563769] #PF error: [normal kernel read fault]
> > [  223.563770] PGD 0 P4D 0 
> > [  223.563774] Oops: 0000 [#1] SMP PTI
> > [  223.563778] CPU: 3 PID: 9027 Comm: kworker/3:1H Tainted:
> > G          I       5.0.0-rc1 #22
> > [  223.563779] Hardware name: HP ProLiant DL380 G7, BIOS P67
> > 08/16/2015
> > [  223.563787] Workqueue: kblockd blk_mq_run_work_fn
> > [  223.593723] device-mapper: multipath: Failing path 8:48.
> > [  223.620801] RIP: 0010:blk_mq_dispatch_rq_list+0xc9/0x590
> > [  223.635266] print_req_error: I/O error, dev dm-6, sector 8191872
> > flags 80700
> > [  223.655565] Code: 0f 85 c2 04 00 00 83 44 24 28 01 48 8b 45 00
> > 48
> > 39
> > c5 0f 84 ea 00 00 00 48 8b 5d 00 80 3c 24 00 4c 8d 6b b8 4c 8b 63
> > c8
> > 75
> > 25 <49> 8b 84 24 b8 00 00 00 48 8b 40 40 48 8b 40 10 48 85 c0 74 10
> > 4c
> > [  223.655566] RSP: 0018:ffffa65b4c43fd90 EFLAGS: 00010246
> > [  223.655570] RAX: ffff93ed9bfdbbc8 RBX: ffff93ed9bfdbbc8 RCX:
> > 0000000000000004
> > [  223.702351] print_req_error: I/O error, dev dm-6, sector 8191872
> > flags 0
> > [  223.737640] RDX: 0000000000000000 RSI: ffffa65b4c43fe20 RDI:
> > ffff93ed9b838000
> > [  223.737641] RBP: ffffa65b4c43fe20 R08: 0000000000000000 R09:
> > 8080808080808080
> > [  223.737642] R10: 0000000000000001 R11: 071c71c71c71c71c R12:
> > 0000000000000000
> > [  223.737643] R13: ffff93ed9bfdbb80 R14: 0000000000000000 R15:
> > ffff93ed9b838000
> > [  223.737645] FS:  0000000000000000(0000)
> > GS:ffff93ee33840000(0000)
> > knlGS:0000000000000000
> > [  223.737646] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  223.737646] CR2: 00000000000000b8 CR3: 000000059da0e006 CR4:
> > 00000000000206e0
> > [  223.737648] Call Trace:          
> > 
> > [  223.737657]  blk_mq_sched_dispatch_requests+0x15c/0x180  ***
> > Freed
> > already
> > 
> > [  223.737660]  __blk_mq_run_hw_queue+0x5f/0xf0
> > [  223.737665]  process_one_work+0x171/0x370
> > [  223.737667]  worker_thread+0x49/0x3f0
> > [  223.737670]  kthread+0xf8/0x130
> > [  223.737673]  ? max_active_store+0x80/0x80
> > 
> > And:
> > 
> > [  643.425005] device-mapper: multipath: Failing path 67:0.
> > [  643.696365] ------------[ cut here ]------------
> > [  643.722927] list_add corruption. prev->next should be next
> > (ffffc8c0c3bd9448), but was ffff93b971965e08.
> > (prev=ffff93b971965e08).
> > [  643.787089] WARNING: CPU: 14 PID: 6533 at lib/list_debug.c:28
> > __list_add_valid+0x6a/0x70
> > [  643.830951] Modules linked in: ib_isert iscsi_target_mod
> > target_core_mod ib_srp scsi_transport_srp rpcrdma ib_ipoib ib_umad
> > rdma_ucm ib_iser rdma_cm iw_cm libiscsi sunrpc scsi_transport_iscsi
> > ib_cm mlx5_ib ib_uverbs ib_core intel_powerclamp coretemp kvm_intel
> > kvm
> > irqbypass crct10dif_pclmul crc32_pclmul iTCO_wdt
> > ghash_clmulni_intel
> > ipmi_ssif aesni_intel iTCO_vendor_support gpio_ich crypto_simd
> > dm_service_time cryptd glue_helper joydev ipmi_si ipmi_devintf
> > pcspkr
> > hpilo hpwdt sg ipmi_msghandler acpi_power_meter pcc_cpufreq lpc_ich
> > i7core_edac dm_multipath ip_tables xfs libcrc32c radeon sd_mod
> > i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt
> > fb_sys_fops ttm drm crc32c_intel serio_raw mlx5_core i2c_core bnx2
> > hpsa
> > mlxfw scsi_transport_sas dm_mirror dm_region_hash dm_log dm_mod
> > [  644.224150] CPU: 14 PID: 6533 Comm: kworker/14:1H Tainted:
> > G          I       4.20.0+ #26
> > [  644.269637] Hardware name: HP ProLiant DL380 G7, BIOS P67
> > 08/16/2015
> > [  644.305110] Workqueue: kblockd blk_mq_run_work_fn
> > [  644.330984] RIP: 0010:__list_add_valid+0x6a/0x70
> > [  644.357601] Code: 31 c0 48 c7 c7 70 e4 ab b6 e8 22 a6 cc ff 0f
> > 0b
> > 31
> > c0 c3 48 89 d1 48 c7 c7 20 e4 ab b6 48 89 f2 48 89 c6 31 c0 e8 06
> > a6
> > cc
> > ff <0f> 0b 31 c0 c3 90 48 8b 07 48 b9 00 01 00 00 00 00 ad de 48 8b
> > 57
> > [  644.462542] RSP: 0018:ffffa8ccc72bfc00 EFLAGS: 00010286
> > [  644.491594] RAX: 0000000000000000 RBX: ffff93b971965dc0 RCX:
> > 0000000000000000
> > [  644.532745] RDX: 0000000000000001 RSI: ffff93b9b79d67b8 RDI:
> > ffff93b9b79d67b8
> > [  644.573533] RBP: ffffc8c0c3bd9448 R08: 0000000000000000 R09:
> > 000000000000072c
> > [  644.614180] R10: 0000000000000000 R11: ffffa8ccc72bf968 R12:
> > ffff93b96d454c00
> > [  644.654683] R13: ffffc8c0c3bd9440 R14: ffff93b971965e08 R15:
> > ffff93b971965e08
> > [  644.694275] FS:  0000000000000000(0000)
> > GS:ffff93b9b79c0000(0000)
> > knlGS:0000000000000000
> > [  644.739906] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  644.771879] CR2: 00007fd566c10000 CR3: 0000000253e0e002 CR4:
> > 00000000000206e0
> > [  644.811438] Call Trace:
> > [  644.824809]  __blk_mq_insert_request+0x62/0x130
> > [  644.849886]  blk_mq_sched_insert_request+0x13c/0x1b0
> > [  644.877402]  blk_mq_try_issue_directly+0x105/0x2c0
> > [  644.904452]  blk_insert_cloned_request+0x9a/0x130
> > [  644.931146]  ? ktime_get+0x37/0x90
> > [  644.950545]  dm_mq_queue_rq+0x21c/0x3f0 [dm_mod]
> > [  644.977064]  ? blk_mq_get_driver_tag+0xa1/0x120
> > [  645.003002]  blk_mq_dispatch_rq_list+0x8e/0x590
> > [  645.029812]  ? __switch_to_asm+0x40/0x70
> > [  645.052059]  ? __switch_to_asm+0x34/0x70
> > [  645.074664]  ? __switch_to_asm+0x40/0x70
> > [  645.097111]  ? __switch_to_asm+0x34/0x70
> > [  645.119948]  ? __switch_to_asm+0x34/0x70
> > [  645.143101]  ? __switch_to_asm+0x40/0x70
> > [  645.165273]  ? syscall_return_via_sysret+0x10/0x7f
> > [  645.192161]  blk_mq_sched_dispatch_requests+0xe8/0x180
> > [  645.221460]  __blk_mq_run_hw_queue+0x5f/0xf0
> > [  645.244766]  process_one_work+0x171/0x370
> > [  645.267164]  worker_thread+0x49/0x3f0
> > [  645.287860]  kthread+0xf8/0x130
> > [  645.304894]  ? max_active_store+0x80/0x80
> > [  645.327748]  ? kthread_bind+0x10/0x10
> > [  645.347898]  ret_from_fork+0x35/0x40
> > [  645.368298] ---[ end trace afa70bf68ffb006b ]---
> > [  645.397356] ------------[ cut here ]------------
> > [  645.423878] list_add corruption. prev->next should be next
> > (ffffc8c0c3bd9448), but was ffff93b971965e08.
> > (prev=ffff93b971965e08).
> > [  645.488009] WAR
> > NING: CPU: 14 PID: 6533 at lib/list_debug.c:28
> > __list_add_valid+0x6a/0x70
> > 
> > 
> > I started just looking at block but nothing made sense so re-ran
> > the
> > bisect with the entire kernel.
> > 
> > $ git bisect start 
> > $ git bisect good v4.20
> > $ git bisect bad v5.0-rc1
> > 
> > Bisecting: 5477 revisions left to test after this (roughly 13
> > steps)
> > *** Groan
> > 
> > I got to here and the problem is its an entire merge
> > 
> > [loberman@ibclient linux_torvalds]$ git bisect bad
> > 4b9254328254bed12a4ac449cdff2c332e630837 is the first bad commit
> > [loberman@ibclient linux_torvalds]$ git show
> > 4b9254328254bed12a4ac449cdff2c332e630837
> > commit 4b9254328254bed12a4ac449cdff2c332e630837
> > Merge: 1a9430d cd19181
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Tue Dec 18 08:29:53 2018 -0700
> > 
> >     Merge branch 'for-4.21/block' into for-4.21/aio
> >     
> >     * for-4.21/block: (351 commits)
> >       blk-mq: enable IO poll if .nr_queues of type poll > 0
> >       blk-mq: change blk_mq_queue_busy() to blk_mq_queue_inflight()
> >       blk-mq: skip zero-queue maps in blk_mq_map_swqueue
> >       block: fix blk-iolatency accounting underflow
> >       blk-mq: fix dispatch from sw queue
> >       block: mq-deadline: Fix write completion handling
> >       nvme-pci: don't share queue maps
> >       blk-mq: only dispatch to non-defauly queue maps if they have
> > queues
> >       blk-mq: export hctx->type in debugfs instead of sysfs
> >       blk-mq: fix allocation for queue mapping table
> >       blk-wbt: export internal state via debugfs
> >       blk-mq-debugfs: support rq_qos
> >       block: update sysfs documentation
> >       block: loop: check error using IS_ERR instead of
> > IS_ERR_OR_NULL
> > in loop_add()
> >       aoe: add __exit annotation
> >       block: clear REQ_HIPRI if polling is not supported
> >       blk-mq: replace and kill blk_mq_request_issue_directly
> >       blk-mq: issue directly with bypass 'false' in
> > blk_mq_sched_insert_requests
> >       blk-mq: refactor the code of issue request directly
> >       block: remove the bio_integrity_advance export
> >       ...
> > 
> > Definitley looks like a list corruption and use after free but its
> > the
> > merge so looking for ideas now from the block folks,
> > 
> > 
> > 
> 
> for-4.21/block: (351 commits) *****
> I will have to try narrow these down based on the heading of each and
> do a full review of the vmcore I captured.
> 
> This expsoure is now there from v5.0-rc1 and onwards
> 

Update on this issue

If I reset the SRP target server and do not reboot it I do not see the
block-mq race with the SRP initiator.
Just resetting the SRP target array and not runing the reboot avoids
the shutdown scripts of ib_srpt and seems somehow to prevent the race
with the initiator code.

Given that I see very little churn and activity with LIO lately I dont
know if its worth spending more time on trying to isolate this.

If anybody has an SRP native array (like DDN) and can reboot it with
5.x plus, that would be a good test.

I will reach out to DDN and ask if they can test it.

Regards
Laurence


