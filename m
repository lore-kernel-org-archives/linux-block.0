Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DAAC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 12:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CAC20700
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 12:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfC0MfU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:35:20 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42763 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfC0MfT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 08:35:19 -0400
Received: by mail-qk1-f193.google.com with SMTP id b74so9719031qkg.9
        for <linux-block@vger.kernel.org>; Wed, 27 Mar 2019 05:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iMg2feLiYX3n5O86PIvtCnH3yz8mRxrbvCppxbM1Awk=;
        b=n379+Arq8FiwsuoQbY/O38hD67XNlkMAufVTT3O7hW4nzDEVe/Vs5o0jDGRb7pi8b3
         QX6hZqWOz/kPkMDzt8ChbbsBF2x1pG5OZmhtFfAmdOkVe3v3l6jDdFhTsosIJZqO2QnV
         +2WBuoL+Y6Ty/DAyoafkeKMduXCKv++Q+qUPqR0+4ns/8Usqw4bFTSQdxl9nrh+tfgV1
         VT4bKnd+13pepHu1km3wCLHG1iIfsGAtkGQiBkCklvcxpT73pBtZIvXfEglVRByczRmY
         zmOdU48JQ6M3Jz7CMblcM/eBEqBa3kqyeBMTQUEyoi0AFRXzH51joOMakzrGFCeDUoPy
         CUTQ==
X-Gm-Message-State: APjAAAVA5+vKTkfMy8yc+H5KIbpvleE14yrFlaKNv/dL0+r72k5httfL
        PCLtcNr3XFtNu2u0GthjCGI6dA==
X-Google-Smtp-Source: APXvYqwV5vEXap2U+dv0w9nsmkJ0mp9wgm50YIujFAjeFMDSkcas4ZaUqWqzpGINDJQ/rO0vxPGKRQ==
X-Received: by 2002:a05:620a:1116:: with SMTP id o22mr12463449qkk.227.1553690117314;
        Wed, 27 Mar 2019 05:35:17 -0700 (PDT)
Received: from 2600-6c64-4e80-00f1-422c-9885-0a6c-81b2.dhcp6.chtrptr.net (2600-6c64-4e80-00f1-422c-9885-0a6c-81b2.dhcp6.chtrptr.net. [2600:6c64:4e80:f1:422c:9885:a6c:81b2])
        by smtp.gmail.com with ESMTPSA id o68sm12079454qkc.89.2019.03.27.05.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 05:35:16 -0700 (PDT)
Message-ID: <38a35a9c6a74371ebaea6cdf210184b8dee4dbeb.camel@redhat.com>
Subject: Re: Panic when rebooting target server testing srp on 5.0.0-rc2
From:   Laurence Oberman <loberman@redhat.com>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Date:   Wed, 27 Mar 2019 08:35:15 -0400
In-Reply-To: <CACVXFVOfZvnDo_ccVm1+cFRo_oSoiexgLfe_pyXp84v=0eQ7rQ@mail.gmail.com>
References: <6e19971d315f4a3ce2cc20a1c6693f4a263a280c.camel@redhat.com>
         <7858e19ce3fc3ebf7845494a2209c58cd9e3086d.camel@redhat.com>
         <1553113730.65329.60.camel@acm.org>
         <3645c45e88523d4b242333d96adbb492ab100f97.camel@redhat.com>
         <d9febee1de759206bbf4d66f6570415ae64e4f33.camel@redhat.com>
         <8a6807100283a0c1256410f4f0381979b18398fe.camel@redhat.com>
         <CACVXFVOfZvnDo_ccVm1+cFRo_oSoiexgLfe_pyXp84v=0eQ7rQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-03-27 at 09:40 +0800, Ming Lei wrote:
> On Tue, Mar 26, 2019 at 11:17 PM Laurence Oberman <
> loberman@redhat.com> wrote:
> > 
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
> > > > > > > 48 8b
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
> > > > > > > 48 85
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
> > > > > > > 180
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
> > > > > can be
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
> > dereference at
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
> > 48 39
> > c5 0f 84 ea 00 00 00 48 8b 5d 00 80 3c 24 00 4c 8d 6b b8 4c 8b 63
> > c8 75
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
> > 0b 31
> > c0 c3 48 89 d1 48 c7 c7 20 e4 ab b6 48 89 f2 48 89 c6 31 c0 e8 06
> > a6 cc
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
> 
> You may set 4b9254328254b or 'cd19181bf9ad' as 'git bad' and start
> the
> 'git bisect'
> again.
> 
> thanks,
> Ming Lei

Hello Ming, OK, but that means starting good at v4.20. long bisect
again.

From the vmcore I got to this analysis

[  382.412285] fast_io_fail_tmo expired for SRP port-2:1 / host2.
[  382.604347] scsi host2: ib_srp: Got failed path rec status -110
[  382.638622] scsi host2: ib_srp: Path record query failed: sgid
fe80:0000:0000:0000:7cfe:9003:0072:6ed2, dgid
fe80:0000:0000:0000:7cfe:9003:0072:6e4e, pkey 0xffff, service_id
0x7cfe900300726e4e
[  382.736300] scsi host2: reconnect attempt 1 failed (-110)
[  383.239347] BUG: unable to handle kernel NULL pointer dereference at
00000000000000b8
[  383.239349] sd 2:0:0:0: rejecting I/O to offline device
[  383.239370] device-mapper: multipath: Failing path 8:64.
[  383.241278] sd 2:0:0:28: rejecting I/O to offline device
[  383.241284] sd 2:0:0:27: rejecting I/O to offline device
[  383.241289] device-mapper: multipath: Failing path 8:96.
[  383.241291] device-mapper: multipath: Failing path 8:160.
[  383.241301] print_req_error: I/O error, dev dm-8, sector 8191872
flags 80700
[  383.241303] print_req_error: I/O error, dev dm-7, sector 8191872
flags 80700
[  383.241335] print_req_error: I/O error, dev dm-8, sector 8191872
flags 0
[  383.241338] Buffer I/O error on dev dm-8, logical block 8191872,
async page read
[  383.241355] print_req_error: I/O error, dev dm-7, sector 8191872
flags 0
[  383.241357] Buffer I/O error on dev dm-7, logical block 8191872,
async page read
[  383.241367] print_req_error: I/O error, dev dm-7, sector 8191873
flags 0
[  383.241368] Buffer I/O error on dev dm-7, logical block 8191873,
async page read
[  383.241377] print_req_error: I/O error, dev dm-7, sector 8191874
flags 0
[  383.241378] Buffer I/O error on dev dm-7, logical block 8191874,
async page read
[  383.241387] print_req_error: I/O error, dev dm-7, sector 8191875
flags 0
[  383.241388] Buffer I/O error on dev dm-7, logical block 8191875,
async page read
[  383.241399] print_req_error: I/O error, dev dm-8, sector 8191873
flags 0
[  383.241400] Buffer I/O error on dev dm-8, logical block 8191873,
async page read
[  383.241409] print_req_error: I/O error, dev dm-7, sector 8191876
flags 0
[  383.241410] Buffer I/O error on dev dm-7, logical block 8191876,
async page read
[  383.241421] print_req_error: I/O error, dev dm-8, sector 8191874
flags 0
[  383.241422] Buffer I/O error on dev dm-8, logical block 8191874,
async page read
[  383.241431] Buffer I/O error on dev dm-7, logical block 8191877,
async page read
[  383.241440] Buffer I/O error on dev dm-8, logical block 8191875,
async page read

[  383.282566] #PF error: [normal kernel read fault]

[  384.290154] PGD 0 P4D 0 
[  384.303791] Oops: 0000 [#1] SMP PTI
[  384.323687] CPU: 1 PID: 9191 Comm: kworker/1:1H Kdump: loaded
Tainted: G        W I       5.1.0-rc2+ #39
[  384.375898] Hardware name: HP ProLiant DL380 G7, BIOS P67 08/16/2015

[  384.411812] Workqueue: kblockd blk_mq_run_work_fn
[  384.438498] RIP: 0010:blk_mq_dispatch_rq_list+0x72/0x570
[  384.468539] Code: 08 84 d2 0f 85 cf 03 00 00 45 31 f6 c7 44 24 38 00
00 00 00 c7 44 24 3c 00 00 00 00 80 3c 24 00 4c 8d 6b b8 48 8b 6b c8 75
24 <48> 8b 85 b8 00 00 00 48 8b 40 40 48 8b 40 10 48 85 c0 74 10 48 89
[  384.573942] RSP: 0018:ffffa9fe0759fd90 EFLAGS: 00010246
[  384.604181] RAX: ffff9de9c4d3bbc8 RBX: ffff9de9c4d3bbc8 RCX:
0000000000000004
[  384.645173] RDX: 0000000000000000 RSI: ffffa9fe0759fe20 RDI:
ffff9dea0dad87f0
[  384.686668] RBP: 0000000000000000 R08: 0000000000000000 R09:
8080808080808080
[  384.727154] R10: ffff9dea33827660 R11: ffffee9d9e097a00 R12:
ffffa9fe0759fe20
[  384.767777] R13: ffff9de9c4d3bb80 R14: 0000000000000000 R15:
ffff9dea0dad87f0
[  384.807728] FS:  0000000000000000(0000) GS:ffff9dea33800000(0000)
knlGS:0000000000000000
[  384.852776] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  384.883825] CR2: 00000000000000b8 CR3: 000000092560e002 CR4:
00000000000206e0
[  384.922960] Call Trace:
[  384.936550]  ? blk_mq_flush_busy_ctxs+0xca/0x120
[  384.962425]  blk_mq_sched_dispatch_requests+0x15c/0x180
[  384.992025]  __blk_mq_run_hw_queue+0x5f/0x100
[  385.016980]  process_one_work+0x171/0x380
[  385.040065]  worker_thread+0x49/0x3f0
[  385.060971]  kthread+0xf8/0x130
[  385.079101]  ? max_active_store+0x80/0x80
[  385.102005]  ? kthread_bind+0x10/0x10
[  385.122531]  ret_from_fork+0x35/0x40
[  385.142477] Modules linked in: ib_isert iscsi_target_mod
target_core_mod ib_srp scsi_transport_srp rpcrdma rdma_ucm ib_iser
ib_umad ib_ipoib sunrpc rdma_cm iw_cm libiscsi scsi_transport_iscsi
ib_cm mlx5_ib ib_uverbs ib_core intel_powerclamp coretemp kvm_intel
ipmi_ssif kvm iTCO_wdt gpio_ich iTCO_vendor_support irqbypass
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel
dm_service_time crypto_simd cryptd glue_helper ipmi_si pcspkr lpc_ich
joydev ipmi_devintf hpilo hpwdt sg ipmi_msghandler i7core_edac
acpi_power_meter pcc_cpufreq dm_multipath ip_tables xfs libcrc32c
radeon sd_mod i2c_algo_bit drm_kms_helper syscopyarea sysfillrect
sysimgblt fb_sys_fops ttm serio_raw crc32c_intel drm mlx5_core i2c_core
bnx2 hpsa mlxfw scsi_transport_sas dm_mirror dm_region_hash dm_log
dm_mod
[  385.534331] CR2: 00000000000000b8
crash> 

kblockd blk_mq_run_work_fn then blk_mq_dispatch_rq_list and we have the
panic                   

crash> bt
PID: 9191   TASK: ffff9dea0a8395c0  CPU: 1   COMMAND: "kworker/1:1H"
 #0 [ffffa9fe0759fab0] machine_kexec at ffffffff938606cf
 #1 [ffffa9fe0759fb08] __crash_kexec at ffffffff9393a48d
 #2 [ffffa9fe0759fbd0] crash_kexec at ffffffff9393b659
 #3 [ffffa9fe0759fbe8] oops_end at ffffffff93831c41
 #4 [ffffa9fe0759fc08] no_context at ffffffff9386ecb9
 #5 [ffffa9fe0759fcb0] do_page_fault at ffffffff93870012
 #6 [ffffa9fe0759fce0] page_fault at ffffffff942010ee
    [exception RIP: blk_mq_dispatch_rq_list+114]
    RIP: ffffffff93b9f202  RSP: ffffa9fe0759fd90  RFLAGS: 00010246
    RAX: ffff9de9c4d3bbc8  RBX: ffff9de9c4d3bbc8  RCX: 0000000000000004
    RDX: 0000000000000000  RSI: ffffa9fe0759fe20  RDI: ffff9dea0dad87f0
    RBP: 0000000000000000   R8: 0000000000000000   R9: 8080808080808080
    R10: ffff9dea33827660  R11: ffffee9d9e097a00  R12: ffffa9fe0759fe20
    R13: ffff9de9c4d3bb80  R14: 0000000000000000  R15: ffff9dea0dad87f0
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #7 [ffffa9fe0759fe18] blk_mq_sched_dispatch_requests at
ffffffff93ba455c
 #8 [ffffa9fe0759fe60] __blk_mq_run_hw_queue at ffffffff93b9e3cf
 #9 [ffffa9fe0759fe78] process_one_work at ffffffff938b0c21
#10 [ffffa9fe0759feb8] worker_thread at ffffffff938b18d9
#11 [ffffa9fe0759ff10] kthread at ffffffff938b6ee8
#12 [ffffa9fe0759ff50] ret_from_fork at ffffffff94200215

crash> whatis blk_mq_sched_dispatch_requests
void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *);

void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
{
        struct request_queue *q = hctx->queue;
        struct elevator_queue *e = q->elevator;
        const bool has_sched_dispatch = e && e->type-
>ops.dispatch_request;

        ***** Should have panicked here

        LIST_HEAD(rq_list);
..
..
       /*
         * Only ask the scheduler for requests, if we didn't have
residual
         * requests from the dispatch list. This is to avoid the case
where
         * we only ever dispatch a fraction of the requests available
because
         * of low device queue depth. Once we pull requests out of the
IO
         * scheduler, we can no longer merge or sort them. So it's best
to
         * leave them there for as long as we can. Mark the hw queue as
         * needing a restart in that case.
         *
         * We want to dispatch from the scheduler if there was nothing
         * on the dispatch list or we were able to dispatch from the
         * dispatch list.
         */
        if (!list_empty(&rq_list)) {
                blk_mq_sched_mark_restart_hctx(hctx);
                if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
                        if (has_sched_dispatch)
                                blk_mq_do_dispatch_sched(hctx);
                        else
                                blk_mq_do_dispatch_ctx(hctx);
                }
        } else if (has_sched_dispatch) {
                blk_mq_do_dispatch_sched(hctx);
        } else if (hctx->dispatch_busy) {
                /* dequeue request one by one from sw queue if queue is
busy */
                blk_mq_do_dispatch_ctx(hctx);
        } else {
                blk_mq_flush_busy_ctxs(hctx, &rq_list);

 ***** Called here

                blk_mq_dispatch_rq_list(q, &rq_list,
false);                 
        }
}


crash> request_queue.elevator 0xffff9dea0dad87f0
  elevator = 0x0
Should have panicked earlier as elevator is NULL

request was for 2:0:0:0
sdev_state = SDEV_TRANSPORT_OFFLINE,

crash> dis -l blk_mq_dispatch_rq_list+114
/home/loberman/git/linux_torvalds/block/blk-mq.h: 210
0xffffffff93b9f202
<blk_mq_dispatch_rq_list+114>:       mov    0xb8(%rbp),%rax

RBP: 0000000000000000 



static inline bool blk_mq_get_dispatch_budget(struct blk_mq_hw_ctx
*hctx)
{
        struct request_queue *q = hctx->queue;

        if (q->mq_ops->get_budget)                       ******* This
Line
                return q->mq_ops->get_budget(hctx);
        return true;
}

crash> blk_mq_hw_ctx.queue ffff9de9c4d11000
  queue = 0xffff9dea0dad87f0

crash> request_queue.mq_ops 0xffff9dea0dad87f0 
  mq_ops = 0xffffffff946afdc0

crash> blk_mq_ops 0xffffffff946afdc0
struct blk_mq_ops {
  queue_rq = 0xffffffff93d619e0, 
  commit_rqs = 0x0, 
  get_budget = 0xffffffff93d60510, 
  put_budget = 0xffffffff93d5efd0, 
  timeout = 0xffffffff93d5fa80, 
  poll = 0x0, 
  complete = 0xffffffff93d60f70, 
  init_hctx = 0x0, 
  exit_hctx = 0x0, 
  init_request = 0xffffffff93d5f9e0, 
  exit_request = 0xffffffff93d5f9b0, 
  initialize_rq_fn = 0xffffffff93d5f850, 
  busy = 0xffffffff93d60900, 
  map_queues = 0xffffffff93d5f980, 
  show_rq = 0xffffffff93d68b30
}[  382.412285] fast_io_fail_tmo expired for SRP port-2:1 / host2.
[  382.604347] scsi host2: ib_srp: Got failed path rec status -110
[  382.638622] scsi host2: ib_srp: Path record query failed: sgid
fe80:0000:0000:0000:7cfe:9003:0072:6ed2, dgid
fe80:0000:0000:0000:7cfe:9003:0072:6e4e, pkey 0xffff, service_id
0x7cfe900300726e4e
[  382.736300] scsi host2: reconnect attempt 1 failed (-110)
[  383.239347] BUG: unable to handle kernel NULL pointer dereference at
00000000000000b8
[  383.239349] sd 2:0:0:0: rejecting I/O to offline device
[  383.239370] device-mapper: multipath: Failing path 8:64.
[  383.241278] sd 2:0:0:28: rejecting I/O to offline device
[  383.241284] sd 2:0:0:27: rejecting I/O to offline device
[  383.241289] device-mapper: multipath: Failing path 8:96.
[  383.241291] device-mapper: multipath: Failing path 8:160.
[  383.241301] print_req_error: I/O error, dev dm-8, sector 8191872
flags 80700
[  383.241303] print_req_error: I/O error, dev dm-7, sector 8191872
flags 80700
[  383.241335] print_req_error: I/O error, dev dm-8, sector 8191872
flags 0
[  383.241338] Buffer I/O error on dev dm-8, logical block 8191872,
async page read
[  383.241355] print_req_error: I/O error, dev dm-7, sector 8191872
flags 0
[  383.241357] Buffer I/O error on dev dm-7, logical block 8191872,
async page read
[  383.241367] print_req_error: I/O error, dev dm-7, sector 8191873
flags 0
[  383.241368] Buffer I/O error on dev dm-7, logical block 8191873,
async page read
[  383.241377] print_req_error: I/O error, dev dm-7, sector 8191874
flags 0
[  383.241378] Buffer I/O error on dev dm-7, logical block 8191874,
async page read
[  383.241387] print_req_error: I/O error, dev dm-7, sector 8191875
flags 0
[  383.241388] Buffer I/O error on dev dm-7, logical block 8191875,
async page read
[  383.241399] print_req_error: I/O error, dev dm-8, sector 8191873
flags 0
[  383.241400] Buffer I/O error on dev dm-8, logical block 8191873,
async page read
[  383.241409] print_req_error: I/O error, dev dm-7, sector 8191876
flags 0
[  383.241410] Buffer I/O error on dev dm-7, logical block 8191876,
async page read
[  383.241421] print_req_error: I/O error, dev dm-8, sector 8191874
flags 0
[  383.241422] Buffer I/O error on dev dm-8, logical block 8191874,
async page read
[  383.241431] Buffer I/O error on dev dm-7, logical block 8191877,
async page read
[  383.241440] Buffer I/O error on dev dm-8, logical block 8191875,
async page read

[  383.282566] #PF error: [normal kernel read fault]

[  384.290154] PGD 0 P4D 0 
[  384.303791] Oops: 0000 [#1] SMP PTI
[  384.323687] CPU: 1 PID: 9191 Comm: kworker/1:1H Kdump: loaded
Tainted: G        W I       5.1.0-rc2+ #39
[  384.375898] Hardware name: HP ProLiant DL380 G7, BIOS P67 08/16/2015

[  384.411812] Workqueue: kblockd blk_mq_run_work_fn
[  384.438498] RIP: 0010:blk_mq_dispatch_rq_list+0x72/0x570
[  384.468539] Code: 08 84 d2 0f 85 cf 03 00 00 45 31 f6 c7 44 24 38 00
00 00 00 c7 44 24 3c 00 00 00 00 80 3c 24 00 4c 8d 6b b8 48 8b 6b c8 75
24 <48> 8b 85 b8 00 00 00 48 8b 40 40 48 8b 40 10 48 85 c0 74 10 48 89
[  384.573942] RSP: 0018:ffffa9fe0759fd90 EFLAGS: 00010246
[  384.604181] RAX: ffff9de9c4d3bbc8 RBX: ffff9de9c4d3bbc8 RCX:
0000000000000004
[  384.645173] RDX: 0000000000000000 RSI: ffffa9fe0759fe20 RDI:
ffff9dea0dad87f0
[  384.686668] RBP: 0000000000000000 R08: 0000000000000000 R09:
8080808080808080
[  384.727154] R10: ffff9dea33827660 R11: ffffee9d9e097a00 R12:
ffffa9fe0759fe20
[  384.767777] R13: ffff9de9c4d3bb80 R14: 0000000000000000 R15:
ffff9dea0dad87f0
[  384.807728] FS:  0000000000000000(0000) GS:ffff9dea33800000(0000)
knlGS:0000000000000000
[  384.852776] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  384.883825] CR2: 00000000000000b8 CR3: 000000092560e002 CR4:
00000000000206e0
[  384.922960] Call Trace:
[  384.936550]  ? blk_mq_flush_busy_ctxs+0xca/0x120
[  384.962425]  blk_mq_sched_dispatch_requests+0x15c/0x180
[  384.992025]  __blk_mq_run_hw_queue+0x5f/0x100
[  385.016980]  process_one_work+0x171/0x380
[  385.040065]  worker_thread+0x49/0x3f0
[  385.060971]  kthread+0xf8/0x130
[  385.079101]  ? max_active_store+0x80/0x80
[  385.102005]  ? kthread_bind+0x10/0x10
[  385.122531]  ret_from_fork+0x35/0x40
[  385.142477] Modules linked in: ib_isert iscsi_target_mod
target_core_mod ib_srp scsi_transport_srp rpcrdma rdma_ucm ib_iser
ib_umad ib_ipoib sunrpc rdma_cm iw_cm libiscsi scsi_transport_iscsi
ib_cm mlx5_ib ib_uverbs ib_core intel_powerclamp coretemp kvm_intel
ipmi_ssif kvm iTCO_wdt gpio_ich iTCO_vendor_support irqbypass
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel
dm_service_time crypto_simd cryptd glue_helper ipmi_si pcspkr lpc_ich
joydev ipmi_devintf hpilo hpwdt sg ipmi_msghandler i7core_edac
acpi_power_meter pcc_cpufreq dm_multipath ip_tables xfs libcrc32c
radeon sd_mod i2c_algo_bit drm_kms_helper syscopyarea sysfillrect
sysimgblt fb_sys_fops ttm serio_raw crc32c_intel drm mlx5_core i2c_core
bnx2 hpsa mlxfw scsi_transport_sas dm_mirror dm_region_hash dm_log
dm_mod
[  385.534331] CR2: 00000000000000b8
crash> 

kblockd blk_mq_run_work_fn then blk_mq_dispatch_rq_list and we have the
panic                   

crash> bt
PID: 9191   TASK: ffff9dea0a8395c0  CPU: 1   COMMAND: "kworker/1:1H"
 #0 [ffffa9fe0759fab0] machine_kexec at ffffffff938606cf
 #1 [ffffa9fe0759fb08] __crash_kexec at ffffffff9393a48d
 #2 [ffffa9fe0759fbd0] crash_kexec at ffffffff9393b659
 #3 [ffffa9fe0759fbe8] oops_end at ffffffff93831c41
 #4 [ffffa9fe0759fc08] no_context at ffffffff9386ecb9
 #5 [ffffa9fe0759fcb0] do_page_fault at ffffffff93870012
 #6 [ffffa9fe0759fce0] page_fault at ffffffff942010ee
    [exception RIP: blk_mq_dispatch_rq_list+114]
    RIP: ffffffff93b9f202  RSP: ffffa9fe0759fd90  RFLAGS: 00010246
    RAX: ffff9de9c4d3bbc8  RBX: ffff9de9c4d3bbc8  RCX: 0000000000000004
    RDX: 0000000000000000  RSI: ffffa9fe0759fe20  RDI: ffff9dea0dad87f0
    RBP: 0000000000000000   R8: 0000000000000000   R9: 8080808080808080
    R10: ffff9dea33827660  R11: ffffee9d9e097a00  R12: ffffa9fe0759fe20
    R13: ffff9de9c4d3bb80  R14: 0000000000000000  R15: ffff9dea0dad87f0
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #7 [ffffa9fe0759fe18] blk_mq_sched_dispatch_requests at
ffffffff93ba455c
 #8 [ffffa9fe0759fe60] __blk_mq_run_hw_queue at ffffffff93b9e3cf
 #9 [ffffa9fe0759fe78] process_one_work at ffffffff938b0c21
#10 [ffffa9fe0759feb8] worker_thread at ffffffff938b18d9
#11 [ffffa9fe0759ff10] kthread at ffffffff938b6ee8
#12 [ffffa9fe0759ff50] ret_from_fork at ffffffff94200215

crash> whatis blk_mq_sched_dispatch_requests
void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *);

void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
{
        struct request_queue *q = hctx->queue;
        struct elevator_queue *e = q->elevator;
        const bool has_sched_dispatch = e && e->type-
>ops.dispatch_request;

        ***** Should have panicked here

        LIST_HEAD(rq_list);
..
..
       /*
         * Only ask the scheduler for requests, if we didn't have
residual
         * requests from the dispatch list. This is to avoid the case
where
         * we only ever dispatch a fraction of the requests available
because
         * of low device queue depth. Once we pull requests out of the
IO
         * scheduler, we can no longer merge or sort them. So it's best
to
         * leave them there for as long as we can. Mark the hw queue as
         * needing a restart in that case.
         *
         * We want to dispatch from the scheduler if there was nothing
         * on the dispatch list or we were able to dispatch from the
         * dispatch list.
         */
        if (!list_empty(&rq_list)) {
                blk_mq_sched_mark_restart_hctx(hctx);
                if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
                        if (has_sched_dispatch)
                                blk_mq_do_dispatch_sched(hctx);
                        else
                                blk_mq_do_dispatch_ctx(hctx);
                }
        } else if (has_sched_dispatch) {
                blk_mq_do_dispatch_sched(hctx);
        } else if (hctx->dispatch_busy) {
                /* dequeue request one by one from sw queue if queue is
busy */
                blk_mq_do_dispatch_ctx(hctx);
        } else {
                blk_mq_flush_busy_ctxs(hctx, &rq_list);

 ***** Called here

                blk_mq_dispatch_rq_list(q, &rq_list,
false);                 
        }
}


crash> request_queue.elevator 0xffff9dea0dad87f0
  elevator = 0x0
Should have panicked earlier as elevator is NULL

request was for 2:0:0:0
sdev_state = SDEV_TRANSPORT_OFFLINE,

crash> dis -l blk_mq_dispatch_rq_list+114
/home/loberman/git/linux_torvalds/block/blk-mq.h: 210
0xffffffff93b9f202
<blk_mq_dispatch_rq_list+114>:       mov    0xb8(%rbp),%rax

RBP: 0000000000000000 



static inline bool blk_mq_get_dispatch_budget(struct blk_mq_hw_ctx
*hctx)
{
        struct request_queue *q = hctx->queue;

        if (q->mq_ops->get_budget)                       ******* This
Line
                return q->mq_ops->get_budget(hctx);
        return true;
}

crash> blk_mq_hw_ctx.queue ffff9de9c4d11000
  queue = 0xffff9dea0dad87f0

crash> request_queue.mq_ops 0xffff9dea0dad87f0 
  mq_ops = 0xffffffff946afdc0

crash> blk_mq_ops 0xffffffff946afdc0
struct blk_mq_ops {
  queue_rq = 0xffffffff93d619e0, 
  commit_rqs = 0x0, 
  get_budget = 0xffffffff93d60510, 
  put_budget = 0xffffffff93d5efd0, 
  timeout = 0xffffffff93d5fa80, 
  poll = 0x0, 
  complete = 0xffffffff93d60f70, 
  init_hctx = 0x0, 
  exit_hctx = 0x0, 
  init_request = 0xffffffff93d5f9e0, 
  exit_request = 0xffffffff93d5f9b0, 
  initialize_rq_fn = 0xffffffff93d5f850, 
  busy = 0xffffffff93d60900, 
  map_queues = 0xffffffff93d5f980, 
  show_rq = 0xffffffff93d68b30
}

