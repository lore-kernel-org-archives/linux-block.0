Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA74C43141
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 17:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DDE206EC
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 17:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MMdVqgil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfKMRm6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:42:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52157 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKMRm6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 12:42:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id q70so2929837wme.1
        for <linux-block@vger.kernel.org>; Wed, 13 Nov 2019 09:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=yX9W29PDPJOVCyk0rG/7dC/ID2EKF8iE1TznMRyojp8=;
        b=MMdVqgilwVFZNPmfJ+/jPMOVAWhm3l2btPKN/v3sJMRJN0ypGVPGnRpim7CmPg4Yi+
         IGUsB/0PX5cQGe0pAonlCHHt9a32EmeapuwSRD4zWN1uhqQS7L3xO5nV1qD6WCxzf05y
         tRTXc+V6JZvYFCX1RXvDy7WT/qnaONunZVA+5chDzvbOjtg3rrCLcK1LLoE7Cb4QjAco
         aeNIgavo5CdqxPWEUui4Nyc1QmpR0VKwjl0uWNlA+s9f0R88eX1rcuPLwvO0UPwa5EVv
         idkbBfpGBTanoEqwjqq+wHG6nzAxSEQjHEqBY0PDx1c4pJSVVAROyoWMD/gFUETekGy7
         gVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=yX9W29PDPJOVCyk0rG/7dC/ID2EKF8iE1TznMRyojp8=;
        b=Oef3c3nQhzW141QEhoReSVgdBbnIsUiBgyU6fRoEVhX6FmvfKdlXP9yarX95l3OKbX
         GsPpBRonAgOm6+bJtTv7QkneB9fg39cfpGc+o4bbdmt7TocNcjdoglBMoZvrjRSKeIB5
         ogRsfPf5XB2X8OwIGNgy+AwsKbcZYt7cJK6f0nuNRG63IZ+29FNrwrcUAW2heQ4P0vVZ
         klN8o6oF8vbLk9DolOYUg9SEbYsKXVyTDAHegimkb76wn33e6F72gTEhnIV+G93q8mOA
         rlP/TTJvgZlZdBXFI/kw5cHwaqfOhHTmz5LcwJamqAvkFM4juhNEuzJWMhfgSlDTP6Cf
         Tdcg==
X-Gm-Message-State: APjAAAVCaoslNvw9G/VcraLMEKVhOl8maGooks++s9JRgOHqq0HDi3/W
        EV5Piyrc1D4d6ryBdViUYO2QvUI8VOtP9LcetCMMfcSaLTvR81fMppzqrmjyhQmoARdMBfdIxci
        8Kh6JKGp6ntB4IAE=
X-Google-Smtp-Source: APXvYqyFW2X9bgw3eA0oioB946BmOiqF0TGB808NMbqkSJ+lv+cZTmGNXdX/XkD7FZK7KQJut1HHLg==
X-Received: by 2002:a05:600c:2103:: with SMTP id u3mr4179705wml.150.1573666972505;
        Wed, 13 Nov 2019 09:42:52 -0800 (PST)
Received: from [192.168.43.233] ([37.160.7.118])
        by smtp.gmail.com with ESMTPSA id j7sm4121991wro.54.2019.11.13.09.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 09:42:51 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <69B451DE-B04B-4E0E-9464-826C4A7619AD@linaro.org>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_FF99937C-1954-4AA8-87A1-DBC9DB1E100C"
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH BUGFIX] block, bfq: deschedule empty bfq_queues not
 referred by any process
Date:   Wed, 13 Nov 2019 18:42:49 +0100
In-Reply-To: <5773ff54421ccf179ef57d96e19ef042@natalenko.name>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, Chris Evich <cevich@redhat.com>,
        Patrick Dung <patdung100@gmail.com>,
        Thorsten Schubert <tschubert@bafh.org>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20191112074856.40433-1-paolo.valente@linaro.org>
 <bb393dcaa426786e0963cf0e70f0b062@natalenko.name>
 <2FB3736A-693E-44B9-9D1F-39AE0D016644@linaro.org>
 <65fc0bffbcb2296d121b3d5a79108e76@natalenko.name>
 <5773ff54421ccf179ef57d96e19ef042@natalenko.name>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_FF99937C-1954-4AA8-87A1-DBC9DB1E100C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 13 nov 2019, alle ore 16:01, Oleksandr Natalenko =
<oleksandr@natalenko.name> ha scritto:
>=20
> On 13.11.2019 15:25, Oleksandr Natalenko wrote:
>> I didn't try to switch schedulers, but what I see now is once the
>> system is able to boot with BFQ, the I/O can still hang on I/O burst
>> (which for me happens to happen during VM reboot).
>> This may also not hang forever, but just slow down considerably. I've
>> noticed this inside a KVM VM, not on a real HW.
>=20
> Possible call traces:

Ok, you may have given me enough information, thank you very much.

Could you please apply the attached (compressed) patch on top of my
offending patch?  For review purposes, here is the simple change:

--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2728,7 +2728,8 @@ void bfq_release_process_ref(struct bfq_data =
*bfqd, struct bfq_queue *bfqq)
         * freed when dequeued from service. But this is assumed to
         * never happen.
         */
-       if (bfq_bfqq_busy(bfqq) && RB_EMPTY_ROOT(&bfqq->sort_list))
+       if (bfq_bfqq_busy(bfqq) && RB_EMPTY_ROOT(&bfqq->sort_list) &&
+           bfqq !=3D bfqd->in_service_queue)
                bfq_del_bfqq_busy(bfqd, bfqq, false);
=20
        bfq_put_queue(bfqq);

Crossing my fingers,
Paolo


--Apple-Mail=_FF99937C-1954-4AA8-87A1-DBC9DB1E100C
Content-Disposition: attachment;
	filename*0=0001-block-bfq-tentative-fix-for-deschedule-empty-bfq_que.patch.;
	filename*1=gz
Content-Type: application/x-gzip;
	x-unix-mode=0644;
	name="0001-block-bfq-tentative-fix-for-deschedule-empty-bfq_que.patch.gz"
Content-Transfer-Encoding: base64

H4sICJA/zF0AAzAwMDEtYmxvY2stYmZxLXRlbnRhdGl2ZS1maXgtZm9yLWRlc2NoZWR1bGUtZW1w
dHktYmZxX3F1ZS5wYXRjaAClUl1v0zAUfZ5/xWUPVbs0ab7atBlMY8DEy9i0TSCEUOTY160hs1Pb
KavEj8dJ9wDSeEBElpx77te55/rS6AcosOB1RpNVkrJ0wbI54lyssnS+YnWWz/NlkScrkQi40gru
sIWkgDguhwNpHCfk0pcp4YbqRsNH2qByCC/b3ox2B/O8kYoaHWmzPiNvqcMSPiGfQpLBB73zVZIV
JMsyK8r5HII4iWNy19XfkLkSvty8vn/z/ivUjWbfp1CLbQnOF6VO7hCEfAShDRxztGyDvGsQ8KF1
+z6w2nbYoSWgtAODAo1BDvUeqNpDazRDa48JuZNrhTzUQoT1/h8GCcOQHGjNfLNQ6oFBxOAnZBAE
3pl4fp4Q21C17udNQSqLxkmt7DiYeAGAY4O9PQ4nhHApBIThWjqgs+cq18+hRCqOj1DTxXKRFqIo
8jiKYrZIkzxfFYIx8IIu8rwn/HxdEgTBX2qfn0OYFulyWkAw3Evw0E5LPihsPH1qsXpS09tibJ3p
mBvcnDoKJ/7PD/8bPOxlwLcTAkdwAsKgX82PDSqvyODmHvPP08u1kwwjuOgcuI204A+1tnvwEU4f
shXu0MCGti2qaIBmJDySAsZ9t75NVXd2Px4awmgEtxfVu6ub+8/V7fX1/XjU4+GZ1cZVjbRuMiHB
f2T7EJ8P/us98OJVf/PwTKrqaZqDAP3oR4NK2PzZhg/vfDsFQRuLk1MCPrSPbDt3yD2QOfUrBZJG
aRwlhPwCv4imjs8DAAA=
--Apple-Mail=_FF99937C-1954-4AA8-87A1-DBC9DB1E100C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii




>=20
> [  179.107123] sysrq: Show Blocked State
> [  179.107127]   task                        PC stack   pid father
> [  179.107157] systemd-journal D    0   268      1 0x00000120
> [  179.107163] Call Trace:
> [  179.107177]  ? __schedule+0x637/0x2af0
> [  179.107184]  ? get_page_from_freelist+0x123d/0x2530
> [  179.107560]  schedule+0x3e/0x140
> [  179.107568]  schedule_timeout+0x354/0x4c0
> [  179.107576]  __down+0x8a/0xe0
> [  179.107583]  ? preempt_count_add+0x68/0xa0
> [  179.107702]  ? xfs_buf_find.isra.0+0x447/0x730 [xfs]
> [  179.107709]  down+0x3b/0x50
> [  179.107795]  xfs_buf_lock+0x33/0x110 [xfs]
> [  179.107885]  xfs_buf_find.isra.0+0x447/0x730 [xfs]
> [  179.108035]  xfs_buf_get_map+0x4b/0x4d0 [xfs]
> [  179.108115]  xfs_buf_read_map+0x28/0x180 [xfs]
> [  179.108205]  xfs_trans_read_buf_map+0xaa/0x390 [xfs]
> [  179.108274]  xfs_da_read_buf+0xf0/0x130 [xfs]
> [  179.108345]  xfs_dir3_block_read+0x35/0x70 [xfs]
> [  179.108423]  xfs_dir2_block_getdents+0xa7/0x280 [xfs]
> [  179.108503]  xfs_readdir+0x113/0x1b0 [xfs]
> [  179.108512]  iterate_dir+0x143/0x1a0
> [  179.108517]  ksys_getdents64+0x9c/0x130
> [  179.108522]  ? compat_filldir+0x180/0x180
> [  179.108527]  __x64_sys_getdents64+0x16/0x20
> [  179.108533]  do_syscall_64+0x4e/0x110
> [  179.108540]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  179.108546] RIP: 0033:0x7f3311baee3b
> [  179.108581] Code: Bad RIP value.
> [  179.108584] RSP: 002b:00007ffc60a3d6d8 EFLAGS: 00000293 ORIG_RAX: =
00000000000000d9
> [  179.108588] RAX: ffffffffffffffda RBX: 000056021e9df880 RCX: =
00007f3311baee3b
> [  179.108590] RDX: 0000000000008000 RSI: 000056021e9df8b0 RDI: =
000000000000001a
> [  179.108592] RBP: 000056021e9df8b0 R08: 0000000000000030 R09: =
00007f3311ca80e0
> [  179.108594] R10: 0000000000000000 R11: 0000000000000293 R12: =
ffffffffffffff80
> [  179.108596] R13: 000056021e9df884 R14: 0000000000000000 R15: =
00007ffc60a3e3f0
> [  179.108611] mkinitcpio      D    0   375    374 0x00000084
> [  179.108616] Call Trace:
> [  179.108624]  ? __schedule+0x637/0x2af0
> [  179.108643]  schedule+0x3e/0x140
> [  179.108648]  schedule_timeout+0x354/0x4c0
> [  179.108655]  __down+0x8a/0xe0
> [  179.108661]  ? preempt_count_add+0x68/0xa0
> [  179.108737]  ? xfs_buf_find.isra.0+0x447/0x730 [xfs]
> [  179.108743]  down+0x3b/0x50
> [  179.108820]  xfs_buf_lock+0x33/0x110 [xfs]
> [  179.108913]  xfs_buf_find.isra.0+0x447/0x730 [xfs]
> [  179.108992]  xfs_buf_get_map+0x4b/0x4d0 [xfs]
> [  179.109000]  ? get_page_from_freelist+0x123d/0x2530
> [  179.109077]  xfs_buf_read_map+0x28/0x180 [xfs]
> [  179.109166]  xfs_trans_read_buf_map+0xaa/0x390 [xfs]
> [  179.109239]  xfs_iread+0xaf/0x220 [xfs]
> [  179.109322]  xfs_iget+0x2f1/0xb80 [xfs]
> [  179.109391]  ? xfs_dir_lookup+0x1bb/0x210 [xfs]
> [  179.109472]  xfs_lookup+0x104/0x140 [xfs]
> [  179.109554]  xfs_vn_lookup+0x82/0xc0 [xfs]
> [  179.109561]  __lookup_slow+0x90/0x190
> [  179.109569]  path_lookupat.isra.0+0x322/0x610
> [  179.109576]  filename_lookup+0xc2/0x1d0
> [  179.109584]  __se_sys_newstat+0x6c/0x100
> [  179.109593]  do_syscall_64+0x4e/0x110
> [  179.109600]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  179.109604] RIP: 0033:0x7f8730e5b8da
> [  179.109610] Code: Bad RIP value.
> [  179.109612] RSP: 002b:00007ffe0505c378 EFLAGS: 00000246 ORIG_RAX: =
0000000000000004
> [  179.109616] RAX: ffffffffffffffda RBX: 000055e2f87bd900 RCX: =
00007f8730e5b8da
> [  179.109618] RDX: 00007ffe0505c3a0 RSI: 00007ffe0505c3a0 RDI: =
000055e2f8800cc0
> [  179.109620] RBP: 0000000000000000 R08: 0000000000000001 R09: =
0000000000000004
> [  179.109622] R10: 000055e2f8794f30 R11: 0000000000000246 R12: =
0000000000000000
> [  179.109623] R13: 000055e2f8800cc0 R14: 000055e2f71c57f4 R15: =
000055e2f88123e0
>=20
> [   87.069140] sysrq: Show Blocked State
> [   87.071749]   task                        PC stack   pid father
> [   87.073827] kworker/u2:3    D    0   220      2 0x80004000
> [   87.076330] Workqueue: writeback wb_workfn (flush-8:0)
> [   87.078086] Call Trace:
> [   87.079758]  ? __schedule+0x637/0x2af0
> [   87.083061]  schedule+0x3e/0x140
> [   87.084784]  io_schedule+0x41/0x70
> [   87.086349]  blk_mq_get_tag+0x119/0x250
> [   87.087503]  ? bfq_timeout_sync_show+0x30/0x30
> [   87.090520]  ? wait_woken+0x70/0x70
> [   87.093294]  blk_mq_get_request+0x30a/0x410
> [   87.098519]  blk_mq_make_request+0x15d/0x6f0
> [   87.101566]  generic_make_request+0xf2/0x370
> [   87.103148]  submit_bio+0x5f/0x180
> [   87.104538]  xfs_submit_ioend.isra.0+0x85/0x160 [xfs]
> [   87.106010]  xfs_vm_writepages+0x73/0xa0 [xfs]
> [   87.107256]  do_writepages+0x41/0x100
> [   87.108514]  ? __switch_to_asm+0x34/0x70
> [   87.110591]  ? __switch_to_asm+0x40/0x70
> [   87.112706]  ? __switch_to_asm+0x34/0x70
> [   87.114931]  ? __switch_to_asm+0x40/0x70
> [   87.117285]  ? kvm_sched_clock_read+0x14/0x40
> [   87.120036]  __writeback_single_inode+0x3d/0x3d0
> [   87.122671]  ? psi_task_change+0x123/0x430
> [   87.124950]  writeback_sb_inodes+0x20b/0x4a0
> [   87.127536]  __writeback_inodes_wb+0x4c/0x140
> [   87.131212]  wb_writeback+0x35c/0x410
> [   87.133642]  ? set_worker_desc+0xc2/0xd0
> [   87.136088]  ? soft_cursor+0x1a1/0x230
> [   87.138433]  wb_workfn+0x46a/0x560
> [   87.140383]  process_one_work+0x1e2/0x3b0
> [   87.142659]  worker_thread+0x5c/0x480
> [   87.145952]  kthread+0x131/0x170
> [   87.149337]  ? rescuer_thread+0x4d0/0x4d0
> [   87.152348]  ? kthread_park+0x80/0x80
> [   87.155309]  ret_from_fork+0x35/0x40
> [   87.158352] kworker/u2:4    D    0   223      2 0x80004000
> [   87.164537] Workqueue: writeback wb_workfn (flush-8:0)
> [   87.168819] Call Trace:
> [   87.171101]  ? __schedule+0x637/0x2af0
> [   87.174254]  ? ktime_get+0x3c/0x90
> [   87.177114]  ? _raw_spin_unlock_irq+0x1d/0x30
> [   87.180847]  ? bfq_insert_requests+0x6a/0x11a0
> [   87.183894]  ? preempt_count_add+0x30/0xa0
> [   87.187213]  schedule+0x3e/0x140
> [   87.190310]  io_schedule+0x41/0x70
> [   87.193559]  blk_mq_get_tag+0x119/0x250
> [   87.197036]  ? wait_woken+0x70/0x70
> [   87.200099]  blk_mq_get_request+0x30a/0x410
> [   87.203252]  blk_mq_make_request+0x15d/0x6f0
> [   87.206302]  generic_make_request+0xf2/0x370
> [   87.209355]  ? __test_set_page_writeback+0xfe/0x310
> [   87.213038]  submit_bio+0x5f/0x180
> [   87.215431]  xfs_submit_ioend.isra.0+0x85/0x160 [xfs]
> [   87.219264]  xfs_do_writepage+0x1c0/0x4f0 [xfs]
> [   87.223744]  write_cache_pages+0x189/0x440
> [   87.227220]  ? xfs_map_blocks+0x4c0/0x4c0 [xfs]
> [   87.230743]  xfs_vm_writepages+0x62/0xa0 [xfs]
> [   87.233752]  do_writepages+0x41/0x100
> [   87.236396]  ? sched_clock_cpu+0x12/0x160
> [   87.239905]  ? psi_task_change+0x123/0x430
> [   87.242949]  __writeback_single_inode+0x3d/0x3d0
> [   87.245812]  ? psi_task_change+0x123/0x430
> [   87.248885]  writeback_sb_inodes+0x20b/0x4a0
> [   87.253396]  __writeback_inodes_wb+0x4c/0x140
> [   87.256836]  wb_writeback+0x35c/0x410
> [   87.259635]  ? set_worker_desc+0xc2/0xd0
> [   87.262496]  wb_workfn+0x46a/0x560
> [   87.265226]  process_one_work+0x1e2/0x3b0
> [   87.268241]  worker_thread+0x5c/0x480
> [   87.270966]  kthread+0x131/0x170
> [   87.273225]  ? rescuer_thread+0x4d0/0x4d0
> [   87.276163]  ? kthread_park+0x80/0x80
> [   87.279137]  ret_from_fork+0x35/0x40
> [   87.282813] kworker/u2:5    D    0   224      2 0x80004000
> [   87.286817] Workqueue: writeback wb_workfn (flush-8:0)
> [   87.290770] Call Trace:
> [   87.292773]  ? __schedule+0x637/0x2af0
> [   87.295432]  schedule+0x3e/0x140
> [   87.298187]  io_schedule+0x41/0x70
> [   87.300723]  blk_mq_get_tag+0x119/0x250
> [   87.303627]  ? wait_woken+0x70/0x70
> [   87.306270]  blk_mq_get_request+0x30a/0x410
> [   87.309216]  blk_mq_make_request+0x15d/0x6f0
> [   87.313271]  generic_make_request+0xf2/0x370
> [   87.317023]  submit_bio+0x5f/0x180
> [   87.319899]  xfs_submit_ioend.isra.0+0x85/0x160 [xfs]
> [   87.323501]  xfs_vm_writepages+0x73/0xa0 [xfs]
> [   87.326520]  do_writepages+0x41/0x100
> [   87.329696]  ? sched_clock_cpu+0x12/0x160
> [   87.332555]  ? psi_task_change+0x123/0x430
> [   87.335264]  __writeback_single_inode+0x3d/0x3d0
> [   87.338447]  ? psi_task_change+0x123/0x430
> [   87.341905]  writeback_sb_inodes+0x20b/0x4a0
> [   87.345393]  __writeback_inodes_wb+0x4c/0x140
> [   87.348837]  wb_writeback+0x35c/0x410
> [   87.351496]  ? set_worker_desc+0xc2/0xd0
> [   87.354137]  wb_workfn+0x46a/0x560
> [   87.355742]  process_one_work+0x1e2/0x3b0
> [   87.357278]  worker_thread+0x5c/0x480
> [   87.359015]  kthread+0x131/0x170
> [   87.360477]  ? rescuer_thread+0x4d0/0x4d0
> [   87.362015]  ? kthread_park+0x80/0x80
> [   87.363473]  ret_from_fork+0x35/0x40
>=20
> [  127.931979] sysrq: Show Blocked State
> [  127.943816]   task                        PC stack   pid father
> [  127.949588] kworker/u2:3    D    0   220      2 0x80004000
> [  127.954562] Workqueue: writeback wb_workfn (flush-8:0)
> [  127.971556] Call Trace:
> [  127.973746]  ? __schedule+0x637/0x2af0
> [  127.975441]  schedule+0x3e/0x140
> [  127.977002]  io_schedule+0x41/0x70
> [  127.978949]  blk_mq_get_tag+0x119/0x250
> [  127.981525]  ? bfq_timeout_sync_show+0x30/0x30
> [  127.983861]  ? wait_woken+0x70/0x70
> [  127.985772]  blk_mq_get_request+0x30a/0x410
> [  127.990451]  blk_mq_make_request+0x15d/0x6f0
> [  127.994248]  generic_make_request+0xf2/0x370
> [  127.997879]  submit_bio+0x5f/0x180
> [  128.000832]  xfs_submit_ioend.isra.0+0x85/0x160 [xfs]
> [  128.004644]  xfs_vm_writepages+0x73/0xa0 [xfs]
> [  128.008598]  do_writepages+0x41/0x100
> [  128.011564]  ? __switch_to_asm+0x34/0x70
> [  128.014527]  ? __switch_to_asm+0x40/0x70
> [  128.017547]  ? __switch_to_asm+0x34/0x70
> [  128.022455]  ? __switch_to_asm+0x40/0x70
> [  128.025836]  ? kvm_sched_clock_read+0x14/0x40
> [  128.029223]  __writeback_single_inode+0x3d/0x3d0
> [  128.032533]  ? psi_task_change+0x123/0x430
> [  128.036069]  writeback_sb_inodes+0x20b/0x4a0
> [  128.039544]  __writeback_inodes_wb+0x4c/0x140
> [  128.042947]  wb_writeback+0x35c/0x410
> [  128.046167]  ? set_worker_desc+0xc2/0xd0
> [  128.049393]  ? soft_cursor+0x1a1/0x230
> [  128.053427]  wb_workfn+0x46a/0x560
> [  128.056444]  process_one_work+0x1e2/0x3b0
> [  128.059854]  worker_thread+0x5c/0x480
> [  128.062617]  kthread+0x131/0x170
> [  128.065320]  ? rescuer_thread+0x4d0/0x4d0
> [  128.068475]  ? kthread_park+0x80/0x80
> [  128.071626]  ret_from_fork+0x35/0x40
> [  128.074413] kworker/u2:4    D    0   223      2 0x80004000
> [  128.078421] Workqueue: writeback wb_workfn (flush-8:0)
> [  128.083873] Call Trace:
> [  128.086442]  ? __schedule+0x637/0x2af0
> [  128.089844]  ? ktime_get+0x3c/0x90
> [  128.092390]  ? _raw_spin_unlock_irq+0x1d/0x30
> [  128.095769]  ? bfq_insert_requests+0x6a/0x11a0
> [  128.099566]  ? preempt_count_add+0x30/0xa0
> [  128.102368]  schedule+0x3e/0x140
> [  128.104985]  io_schedule+0x41/0x70
> [  128.107840]  blk_mq_get_tag+0x119/0x250
> [  128.111122]  ? wait_woken+0x70/0x70
> [  128.115268]  blk_mq_get_request+0x30a/0x410
> [  128.118827]  blk_mq_make_request+0x15d/0x6f0
> [  128.122513]  generic_make_request+0xf2/0x370
> [  128.125688]  ? __test_set_page_writeback+0xfe/0x310
> [  128.129481]  submit_bio+0x5f/0x180
> [  128.132227]  xfs_submit_ioend.isra.0+0x85/0x160 [xfs]
> [  128.135979]  xfs_do_writepage+0x1c0/0x4f0 [xfs]
> [  128.139147]  write_cache_pages+0x189/0x440
> [  128.143406]  ? xfs_map_blocks+0x4c0/0x4c0 [xfs]
> [  128.149176]  xfs_vm_writepages+0x62/0xa0 [xfs]
> [  128.152721]  do_writepages+0x41/0x100
> [  128.155683]  ? sched_clock_cpu+0x12/0x160
> [  128.159142]  ? psi_task_change+0x123/0x430
> [  128.162682]  __writeback_single_inode+0x3d/0x3d0
> [  128.166272]  ? psi_task_change+0x123/0x430
> [  128.169611]  writeback_sb_inodes+0x20b/0x4a0
> [  128.174680]  __writeback_inodes_wb+0x4c/0x140
> [  128.178400]  wb_writeback+0x35c/0x410
> [  128.181249]  ? set_worker_desc+0xc2/0xd0
> [  128.182963]  wb_workfn+0x46a/0x560
> [  128.184508]  process_one_work+0x1e2/0x3b0
> [  128.187977]  worker_thread+0x5c/0x480
> [  128.191032]  kthread+0x131/0x170
> [  128.194041]  ? rescuer_thread+0x4d0/0x4d0
> [  128.197508]  ? kthread_park+0x80/0x80
> [  128.200633]  ret_from_fork+0x35/0x40
> [  128.204789] kworker/u2:5    D    0   224      2 0x80004000
> [  128.209060] Workqueue: writeback wb_workfn (flush-8:0)
> [  128.213110] Call Trace:
> [  128.215323]  ? __schedule+0x637/0x2af0
> [  128.219244]  schedule+0x3e/0x140
> [  128.223320]  io_schedule+0x41/0x70
> [  128.231005]  blk_mq_get_tag+0x119/0x250
> [  128.237796]  ? wait_woken+0x70/0x70
> [  128.241028]  blk_mq_get_request+0x30a/0x410
> [  128.244530]  blk_mq_make_request+0x15d/0x6f0
> [  128.248292]  generic_make_request+0xf2/0x370
> [  128.251900]  submit_bio+0x5f/0x180
> [  128.255073]  xfs_submit_ioend.isra.0+0x85/0x160 [xfs]
> [  128.259151]  xfs_vm_writepages+0x73/0xa0 [xfs]
> [  128.262690]  do_writepages+0x41/0x100
> [  128.267082]  ? sched_clock_cpu+0x12/0x160
> [  128.270697]  ? psi_task_change+0x123/0x430
> [  128.274259]  __writeback_single_inode+0x3d/0x3d0
> [  128.278024]  ? psi_task_change+0x123/0x430
> [  128.281327]  writeback_sb_inodes+0x20b/0x4a0
> [  128.284777]  __writeback_inodes_wb+0x4c/0x140
> [  128.288677]  wb_writeback+0x35c/0x410
> [  128.291625]  ? set_worker_desc+0xc2/0xd0
> [  128.296076]  wb_workfn+0x46a/0x560
> [  128.299680]  process_one_work+0x1e2/0x3b0
> [  128.303163]  worker_thread+0x5c/0x480
> [  128.306144]  kthread+0x131/0x170
> [  128.309172]  ? rescuer_thread+0x4d0/0x4d0
> [  128.312615]  ? kthread_park+0x80/0x80
> [  128.315576]  ret_from_fork+0x35/0x40
> [  128.318582] xfsaild/sda2    D    0   244      2 0x80004000
> [  128.322561] Call Trace:
> [  128.326085]  ? __schedule+0x637/0x2af0
> [  128.329795]  ? __bfq_deactivate_entity+0x19a/0x2b0
> [  128.333728]  schedule+0x3e/0x140
> [  128.336164]  io_schedule+0x41/0x70
> [  128.339493]  blk_mq_get_tag+0x119/0x250
> [  128.342546]  ? wait_woken+0x70/0x70
> [  128.346479]  blk_mq_get_request+0x30a/0x410
> [  128.351602]  blk_mq_make_request+0x15d/0x6f0
> [  128.354611]  generic_make_request+0xf2/0x370
> [  128.359399]  submit_bio+0x5f/0x180
> [  128.363135]  _xfs_buf_ioapply+0x2b8/0x430 [xfs]
> [  128.369007]  __xfs_buf_submit+0x82/0x1f0 [xfs]
> [  128.376663]  xfs_buf_delwri_submit_buffers+0x109/0x260 [xfs]
> [  128.379223]  ? xfsaild+0x3f0/0x8d0 [xfs]
> [  128.382396]  xfsaild+0x3f0/0x8d0 [xfs]
> [  128.384589]  kthread+0x131/0x170
> [  128.387601]  ? xfs_trans_ail_cursor_clear+0x40/0x40 [xfs]
> [  128.391164]  ? kthread_park+0x80/0x80
> [  128.401195]  ret_from_fork+0x35/0x40
>=20
> [  234.904047] sysrq: Show Blocked State
> [  234.908142]   task                        PC stack   pid father
> [  234.911166] kworker/u2:3    D    0   220      2 0x80004000
> [  234.915348] Workqueue: writeback wb_workfn (flush-8:0)
> [  234.917924] Call Trace:
> [  234.920610]  ? __schedule+0x637/0x2af0
> [  234.924304]  schedule+0x3e/0x140
> [  234.927397]  io_schedule+0x41/0x70
> [  234.934576]  blk_mq_get_tag+0x119/0x250
> [  234.940699]  ? bfq_timeout_sync_show+0x30/0x30
> [  234.942674]  ? wait_woken+0x70/0x70
> [  234.945013]  blk_mq_get_request+0x30a/0x410
> [  234.946858]  blk_mq_make_request+0x15d/0x6f0
> [  234.949202]  generic_make_request+0xf2/0x370
> [  234.951035]  submit_bio+0x5f/0x180
> [  234.952663]  xfs_submit_ioend.isra.0+0x85/0x160 [xfs]
> [  234.954829]  xfs_vm_writepages+0x73/0xa0 [xfs]
> [  234.957084]  do_writepages+0x41/0x100
> [  234.960939]  ? __switch_to_asm+0x34/0x70
> [  234.963202]  ? __switch_to_asm+0x40/0x70
> [  234.964921]  ? __switch_to_asm+0x34/0x70
> [  234.967063]  ? __switch_to_asm+0x40/0x70
> [  234.968989]  ? kvm_sched_clock_read+0x14/0x40
> [  234.970810]  __writeback_single_inode+0x3d/0x3d0
> [  234.972835]  ? psi_task_change+0x123/0x430
> [  234.976112]  writeback_sb_inodes+0x20b/0x4a0
> [  234.978133]  __writeback_inodes_wb+0x4c/0x140
> [  234.979943]  wb_writeback+0x35c/0x410
> [  234.981742]  ? set_worker_desc+0xc2/0xd0
> [  234.983428]  ? soft_cursor+0x1a1/0x230
> [  234.985088]  wb_workfn+0x46a/0x560
> [  234.986629]  process_one_work+0x1e2/0x3b0
> [  234.990135]  worker_thread+0x5c/0x480
> [  234.991870]  kthread+0x131/0x170
> [  234.993523]  ? rescuer_thread+0x4d0/0x4d0
> [  234.995287]  ? kthread_park+0x80/0x80
> [  234.996971]  ret_from_fork+0x35/0x40
> [  234.998827] kworker/u2:4    D    0   223      2 0x80004000
> [  235.001159] Workqueue: writeback wb_workfn (flush-8:0)
> [  235.003167] Call Trace:
> [  235.004605]  ? __schedule+0x637/0x2af0
> [  235.006286]  ? ktime_get+0x3c/0x90
> [  235.008191]  ? _raw_spin_unlock_irq+0x1d/0x30
> [  235.010088]  ? bfq_insert_requests+0x6a/0x11a0
> [  235.011891]  ? preempt_count_add+0x30/0xa0
> [  235.013966]  schedule+0x3e/0x140
> [  235.015705]  io_schedule+0x41/0x70
> [  235.017234]  blk_mq_get_tag+0x119/0x250
> [  235.022331]  ? wait_woken+0x70/0x70
> [  235.027501]  blk_mq_get_request+0x30a/0x410
> [  235.030930]  blk_mq_make_request+0x15d/0x6f0
> [  235.034333]  generic_make_request+0xf2/0x370
> [  235.038096]  ? __test_set_page_writeback+0xfe/0x310
> [  235.042030]  submit_bio+0x5f/0x180
> [  235.044645]  xfs_submit_ioend.isra.0+0x85/0x160 [xfs]
> [  235.047883]  xfs_do_writepage+0x1c0/0x4f0 [xfs]
> [  235.053087]  write_cache_pages+0x189/0x440
> [  235.056560]  ? xfs_map_blocks+0x4c0/0x4c0 [xfs]
> [  235.060329]  xfs_vm_writepages+0x62/0xa0 [xfs]
> [  235.064731]  do_writepages+0x41/0x100
> [  235.067990]  ? sched_clock_cpu+0x12/0x160
> [  235.071178]  ? psi_task_change+0x123/0x430
> [  235.074144]  __writeback_single_inode+0x3d/0x3d0
> [  235.078489]  ? psi_task_change+0x123/0x430
> [  235.082597]  writeback_sb_inodes+0x20b/0x4a0
> [  235.085988]  __writeback_inodes_wb+0x4c/0x140
> [  235.089749]  wb_writeback+0x35c/0x410
> [  235.092620]  ? set_worker_desc+0xc2/0xd0
> [  235.096787]  wb_workfn+0x46a/0x560
> [  235.099600]  process_one_work+0x1e2/0x3b0
> [  235.103916]  worker_thread+0x5c/0x480
> [  235.107162]  kthread+0x131/0x170
> [  235.118469]  ? rescuer_thread+0x4d0/0x4d0
> [  235.123893]  ? kthread_park+0x80/0x80
> [  235.125617]  ret_from_fork+0x35/0x40
> [  235.127317] kworker/u2:5    D    0   224      2 0x80004000
> [  235.130068] Workqueue: writeback wb_workfn (flush-8:0)
> [  235.132098] Call Trace:
> [  235.133579]  ? __schedule+0x637/0x2af0
> [  235.135252]  schedule+0x3e/0x140
> [  235.136942]  io_schedule+0x41/0x70
> [  235.138752]  blk_mq_get_tag+0x119/0x250
> [  235.141176]  ? wait_woken+0x70/0x70
> [  235.142816]  blk_mq_get_request+0x30a/0x410
> [  235.144816]  blk_mq_make_request+0x15d/0x6f0
> [  235.146681]  generic_make_request+0xf2/0x370
> [  235.150292]  submit_bio+0x5f/0x180
> [  235.153366]  xfs_submit_ioend.isra.0+0x85/0x160 [xfs]
> [  235.157466]  xfs_vm_writepages+0x73/0xa0 [xfs]
> [  235.161099]  do_writepages+0x41/0x100
> [  235.164213]  ? sched_clock_cpu+0x12/0x160
> [  235.167558]  ? psi_task_change+0x123/0x430
> [  235.174031]  __writeback_single_inode+0x3d/0x3d0
> [  235.178426]  ? psi_task_change+0x123/0x430
> [  235.183123]  writeback_sb_inodes+0x20b/0x4a0
> [  235.199636]  __writeback_inodes_wb+0x4c/0x140
> [  235.205597]  wb_writeback+0x35c/0x410
> [  235.217907]  ? set_worker_desc+0xc2/0xd0
> [  235.219695]  wb_workfn+0x46a/0x560
> [  235.221599]  process_one_work+0x1e2/0x3b0
> [  235.224343]  worker_thread+0x5c/0x480
> [  235.225978]  kthread+0x131/0x170
> [  235.228234]  ? rescuer_thread+0x4d0/0x4d0
> [  235.229958]  ? kthread_park+0x80/0x80
> [  235.231578]  ret_from_fork+0x35/0x40
> [  235.233324] xfsaild/sda2    D    0   244      2 0x80004000
> [  235.238349] Call Trace:
> [  235.240383]  ? __schedule+0x637/0x2af0
> [  235.242182]  ? __bfq_deactivate_entity+0x19a/0x2b0
> [  235.248196]  schedule+0x3e/0x140
> [  235.250080]  io_schedule+0x41/0x70
> [  235.252931]  blk_mq_get_tag+0x119/0x250
> [  235.254804]  ? wait_woken+0x70/0x70
> [  235.256396]  blk_mq_get_request+0x30a/0x410
> [  235.262031]  blk_mq_make_request+0x15d/0x6f0
> [  235.271989]  generic_make_request+0xf2/0x370
> [  235.275119]  submit_bio+0x5f/0x180
> [  235.277055]  _xfs_buf_ioapply+0x2b8/0x430 [xfs]
> [  235.279084]  __xfs_buf_submit+0x82/0x1f0 [xfs]
> [  235.281404]  xfs_buf_delwri_submit_buffers+0x109/0x260 [xfs]
> [  235.283550]  ? xfsaild+0x3f0/0x8d0 [xfs]
> [  235.285351]  xfsaild+0x3f0/0x8d0 [xfs]
> [  235.287060]  kthread+0x131/0x170
> [  235.290535]  ? xfs_trans_ail_cursor_clear+0x40/0x40 [xfs]
> [  235.292775]  ? kthread_park+0x80/0x80
> [  235.296030]  ret_from_fork+0x35/0x40
> [  246.488123] INFO: task kworker/u2:3:220 blocked for more than 122 =
seconds.
> [  246.595672]       Not tainted 5.3.0-pf7 #1
> [  246.602133] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" =
disables this message.
> [  246.611323] kworker/u2:3    D    0   220      2 0x80004000
> [  246.616858] Workqueue: writeback wb_workfn (flush-8:0)
> [  246.623147] Call Trace:
> [  246.625763]  ? __schedule+0x637/0x2af0
> [  246.627530]  schedule+0x3e/0x140
> [  246.629607]  io_schedule+0x41/0x70
> [  246.631407]  blk_mq_get_tag+0x119/0x250
> [  246.633226]  ? bfq_timeout_sync_show+0x30/0x30
> [  246.635814]  ? wait_woken+0x70/0x70
> [  246.643587]  blk_mq_get_request+0x30a/0x410
> [  246.647362]  blk_mq_make_request+0x15d/0x6f0
> [  246.654491]  generic_make_request+0xf2/0x370
> [  246.656568]  submit_bio+0x5f/0x180
> [  246.658388]  xfs_submit_ioend.isra.0+0x85/0x160 [xfs]
> [  246.660772]  xfs_vm_writepages+0x73/0xa0 [xfs]
> [  246.663464]  do_writepages+0x41/0x100
> [  246.665259]  ? __switch_to_asm+0x34/0x70
> [  246.667069]  ? __switch_to_asm+0x40/0x70
> [  246.669581]  ? __switch_to_asm+0x34/0x70
> [  246.671963]  ? __switch_to_asm+0x40/0x70
> [  246.674022]  ? kvm_sched_clock_read+0x14/0x40
> [  246.679684]  __writeback_single_inode+0x3d/0x3d0
> [  246.709238]  ? psi_task_change+0x123/0x430
> [  246.711444]  writeback_sb_inodes+0x20b/0x4a0
> [  246.714632]  __writeback_inodes_wb+0x4c/0x140
> [  246.718981]  wb_writeback+0x35c/0x410
> [  246.725222]  ? set_worker_desc+0xc2/0xd0
> [  246.728123]  ? soft_cursor+0x1a1/0x230
> [  246.744090]  wb_workfn+0x46a/0x560
> [  246.750812]  process_one_work+0x1e2/0x3b0
> [  246.760162]  worker_thread+0x5c/0x480
> [  246.761914]  kthread+0x131/0x170
> [  246.763468]  ? rescuer_thread+0x4d0/0x4d0
> [  246.766006]  ? kthread_park+0x80/0x80
> [  246.767865]  ret_from_fork+0x35/0x40
> [  246.769640] INFO: task kworker/u2:4:223 blocked for more than 123 =
seconds.
> [  246.772517]       Not tainted 5.3.0-pf7 #1
> [  246.775114] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" =
disables this message.
> [  246.779903] kworker/u2:4    D    0   223      2 0x80004000
> [  246.784611] Workqueue: writeback wb_workfn (flush-8:0)
> [  246.788280] Call Trace:
> [  246.790041]  ? __schedule+0x637/0x2af0
> [  246.796877]  ? ktime_get+0x3c/0x90
> [  246.802957]  ? _raw_spin_unlock_irq+0x1d/0x30
> [  246.807930]  ? bfq_insert_requests+0x6a/0x11a0
> [  246.812064]  ? preempt_count_add+0x30/0xa0
> [  246.819097]  schedule+0x3e/0x140
> [  246.821859]  io_schedule+0x41/0x70
> [  246.825235]  blk_mq_get_tag+0x119/0x250
> [  246.828659]  ? wait_woken+0x70/0x70
> [  246.836064]  blk_mq_get_request+0x30a/0x410
> [  246.848237]  blk_mq_make_request+0x15d/0x6f0
> [  246.857921]  generic_make_request+0xf2/0x370
> [  246.861569]  ? __test_set_page_writeback+0xfe/0x310
> [  246.865759]  submit_bio+0x5f/0x180
> [  246.868518]  xfs_submit_ioend.isra.0+0x85/0x160 [xfs]
> [  246.874268]  xfs_do_writepage+0x1c0/0x4f0 [xfs]
> [  246.878794]  write_cache_pages+0x189/0x440
> [  246.882209]  ? xfs_map_blocks+0x4c0/0x4c0 [xfs]
> [  246.884118]  xfs_vm_writepages+0x62/0xa0 [xfs]
> [  246.886729]  do_writepages+0x41/0x100
> [  246.888570]  ? sched_clock_cpu+0x12/0x160
> [  246.890648]  ? psi_task_change+0x123/0x430
> [  246.898729]  __writeback_single_inode+0x3d/0x3d0
> [  246.907282]  ? psi_task_change+0x123/0x430
> [  246.909678]  writeback_sb_inodes+0x20b/0x4a0
> [  246.911499]  __writeback_inodes_wb+0x4c/0x140
> [  246.913324]  wb_writeback+0x35c/0x410
> [  246.916341]  ? set_worker_desc+0xc2/0xd0
> [  246.919498]  wb_workfn+0x46a/0x560
> [  246.922393]  process_one_work+0x1e2/0x3b0
> [  246.925693]  worker_thread+0x5c/0x480
> [  246.929221]  kthread+0x131/0x170
> [  246.936731]  ? rescuer_thread+0x4d0/0x4d0
> [  246.946022]  ? kthread_park+0x80/0x80
> [  246.949593]  ret_from_fork+0x35/0x40
> [  246.952716] INFO: task kworker/u2:5:224 blocked for more than 123 =
seconds.
> [  246.958132]       Not tainted 5.3.0-pf7 #1
> [  246.961479] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" =
disables this message.
> [  246.968379] kworker/u2:5    D    0   224      2 0x80004000
> [  246.981073] Workqueue: writeback wb_workfn (flush-8:0)
> [  246.986238] Call Trace:
> [  246.988832]  ? __schedule+0x637/0x2af0
> [  246.992416]  schedule+0x3e/0x140
> [  246.995232]  io_schedule+0x41/0x70
> [  246.998399]  blk_mq_get_tag+0x119/0x250
> [  247.001661]  ? wait_woken+0x70/0x70
> [  247.006540]  blk_mq_get_request+0x30a/0x410
> [  247.010153]  blk_mq_make_request+0x15d/0x6f0
> [  247.020215]  generic_make_request+0xf2/0x370
> [  247.024701]  submit_bio+0x5f/0x180
> [  247.027620]  xfs_submit_ioend.isra.0+0x85/0x160 [xfs]
> [  247.031863]  xfs_vm_writepages+0x73/0xa0 [xfs]
> [  247.036968]  do_writepages+0x41/0x100
> [  247.040347]  ? sched_clock_cpu+0x12/0x160
> [  247.044046]  ? psi_task_change+0x123/0x430
> [  247.047533]  __writeback_single_inode+0x3d/0x3d0
> [  247.051963]  ? psi_task_change+0x123/0x430
> [  247.063498]  writeback_sb_inodes+0x20b/0x4a0
> [  247.068234]  __writeback_inodes_wb+0x4c/0x140
> [  247.072366]  wb_writeback+0x35c/0x410
> [  247.075423]  ? set_worker_desc+0xc2/0xd0
> [  247.078859]  wb_workfn+0x46a/0x560
> [  247.082140]  process_one_work+0x1e2/0x3b0
> [  247.086447]  worker_thread+0x5c/0x480
> [  247.089657]  kthread+0x131/0x170
> [  247.101209]  ? rescuer_thread+0x4d0/0x4d0
> [  247.105680]  ? kthread_park+0x80/0x80
> [  247.109483]  ret_from_fork+0x35/0x40
>=20
> --=20
>  Oleksandr Natalenko (post-factum)


--Apple-Mail=_FF99937C-1954-4AA8-87A1-DBC9DB1E100C--
