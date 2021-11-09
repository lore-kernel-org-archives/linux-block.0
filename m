Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78459C433F5
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 09:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48C8961152
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 09:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244900AbhKIJfa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 04:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241297AbhKIJfa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 04:35:30 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACC0C061764
        for <linux-block@vger.kernel.org>; Tue,  9 Nov 2021 01:32:44 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 1so35067036ljv.2
        for <linux-block@vger.kernel.org>; Tue, 09 Nov 2021 01:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=aZcuru0JmNcPAJuVrncdIZTIdfhHXZANpzA/sBRgO9E=;
        b=WSscTytRrjifo/tx/WybSxAMkrNoI2B85AccwDaYLla+bvPd7uoJDexm8RbBVt7J5v
         D9yYXIl69Un9V3W67EOenLg5iQdb/sTxfldNitlTaeWVqZCCGZvTBNp2Q5kWSFlKE+GK
         TH49Z5+WJymfjnqh3bfMW0vPpl5kJnF1vxLvePeVMvKxsydf/WocvC9zBpe/50rh5BGk
         eGglvCF7X29IvOqKMOIfVq7p+gjOU/35il1586ein5jmARhrvRDs8znfcHZhkicdA9Pq
         GzgeE6sHTxnnSrxdwp+QdVJoJSBdFa490wazn5Xzms3dzydONcbpzmXHN2OJCiX9IFmN
         f9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aZcuru0JmNcPAJuVrncdIZTIdfhHXZANpzA/sBRgO9E=;
        b=1CPJ+Saen3/X4BjiNcFYd90pDMnoQeDu6YiCResqrFqN+kohsOKdcMK+SojWfKg28s
         j5Gi7tkFlBSgDm/UtKICMAlyGeq2bo6siefaipJAK/2utLXIShogbmhtOLLQMSO38kwI
         S0nFKBNgOenN51OR2VniYB5IXI5oSgvPOox3XLx6difmzaOR4Yj7nECKcBxy+AuEsvLy
         3u9xo/M6bTU2y+ETna6kpoVr4sB8YeBwv6/HzG7E08+6YRXhUxoFBwiTo4fEMIbPF0ab
         z5qaNURl9jXFNWv4SyjyVoS3MpI+KQedpi1ZIJ7p3WLk//Wr6JtnBLKWK41p/d+yxxwE
         pWkQ==
X-Gm-Message-State: AOAM530ei2RnMoonwHtauF7PQaWwxMbodBK3TumVm1tm99RHHsJaAUZf
        IVplB+8vCQ5v92iN0+kFrf5SC0p0o0ag/oz1ZrAAVv1/VKAMrA==
X-Google-Smtp-Source: ABdhPJxYKaZpTAjTDrtrJRoqugLeQiDSuK+g0mr7zFNLncHR1dbDAVcz0mFAGceOc5qTjAc+hnNuI9xwBGhS6MCZcg0=
X-Received: by 2002:a2e:a916:: with SMTP id j22mr6070811ljq.88.1636450362796;
 Tue, 09 Nov 2021 01:32:42 -0800 (PST)
MIME-Version: 1.0
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Tue, 9 Nov 2021 10:32:32 +0100
Message-ID: <CAJpMwyixY_-AbMvtGGMBWBO3+oOEF9fuWHkYpLWDbXo3dcAGfg@mail.gmail.com>
Subject: Observing an fio hang with RNBD device in the latest v5.10.78 Linux kernel
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        sashal@kernel.org, ming.lei@redhat.com, jack@suse.cz
Cc:     Jinpu Wang <jinpu.wang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

We are observing an fio hang with the latest v5.10.78 Linux kernel
version with RNBD. The setup is as follows,

On the server side, 16 nullblk devices.
On the client side, map those 16 block devices through RNBD-RTRS.
Change the scheduler for those RNBD block devices to mq-deadline.

Run fios with the following configuration.

[global]
description=Emulation of Storage Server Access Pattern
bssplit=512/20:1k/16:2k/9:4k/12:8k/19:16k/10:32k/8:64k/4
fadvise_hint=0
rw=randrw:2
direct=1
random_distribution=zipf:1.2
time_based=1
runtime=60
ramp_time=1
ioengine=libaio
iodepth=128
iodepth_batch_submit=128
iodepth_batch_complete=128
numjobs=1
group_reporting


[job1]
filename=/dev/rnbd0
[job2]
filename=/dev/rnbd1
[job3]
filename=/dev/rnbd2
[job4]
filename=/dev/rnbd3
[job5]
filename=/dev/rnbd4
[job6]
filename=/dev/rnbd5
[job7]
filename=/dev/rnbd6
[job8]
filename=/dev/rnbd7
[job9]
filename=/dev/rnbd8
[job10]
filename=/dev/rnbd9
[job11]
filename=/dev/rnbd10
[job12]
filename=/dev/rnbd11
[job13]
filename=/dev/rnbd12
[job14]
filename=/dev/rnbd13
[job15]
filename=/dev/rnbd14
[job16]
filename=/dev/rnbd15

Some of the fio threads hangs and the fio never finishes.

fio fio.ini
job1: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
512B-64.0KiB, ioengine=libaio, iodepth=128
job2: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
512B-64.0KiB, ioengine=libaio, iodepth=128
job3: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
512B-64.0KiB, ioengine=libaio, iodepth=128
job4: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
512B-64.0KiB, ioengine=libaio, iodepth=128
job5: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
512B-64.0KiB, ioengine=libaio, iodepth=128
job6: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
512B-64.0KiB, ioengine=libaio, iodepth=128
job7: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
512B-64.0KiB, ioengine=libaio, iodepth=128
job8: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
512B-64.0KiB, ioengine=libaio, iodepth=128
job9: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
512B-64.0KiB, ioengine=libaio, iodepth=128
job10: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
512B-64.0KiB, ioengine=libaio, iodepth=128
job11: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
512B-64.0KiB, ioengine=libaio, iodepth=128
job12: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
512B-64.0KiB, ioengine=libaio, iodepth=128
job13: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
512B-64.0KiB, ioengine=libaio, iodepth=128
job14: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
512B-64.0KiB, ioengine=libaio, iodepth=128
job15: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
512B-64.0KiB, ioengine=libaio, iodepth=128
job16: (g=0): rw=randrw, bs=(R) 512B-64.0KiB, (W) 512B-64.0KiB, (T)
512B-64.0KiB, ioengine=libaio, iodepth=128
fio-3.12
Starting 16 processes
Jobs: 16 (f=12):
[m(3),/(2),m(5),/(1),m(1),/(1),m(3)][0.0%][r=130MiB/s,w=130MiB/s][r=14.7k,w=14.7k
IOPS][eta 04d:07h:4
Jobs: 15 (f=11):
[m(3),/(2),m(5),/(1),_(1),/(1),m(3)][51.2%][r=7395KiB/s,w=6481KiB/s][r=770,w=766
IOPS][eta 01m:01s]
Jobs: 15 (f=11): [m(3),/(2),m(5),/(1),_(1),/(1),m(3)][52.7%][eta 01m:01s]

We checked the block devices, and there are requests waiting in their
fifo (not on all devices, just few whose corresponding fio threads are
hung).

$ cat /sys/kernel/debug/block/rnbd0/sched/read_fifo_list
00000000ce398aec {.op=READ, .cmd_flags=,
.rq_flags=SORTED|ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1,
.internal_tag=209}
000000005ec82450 {.op=READ, .cmd_flags=,
.rq_flags=SORTED|ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1,
.internal_tag=210}

$ cat /sys/kernel/debug/block/rnbd0/sched/write_fifo_list
000000000c1557f5 {.op=WRITE, .cmd_flags=SYNC|IDLE,
.rq_flags=SORTED|ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1,
.internal_tag=195}
00000000fc6bfd98 {.op=WRITE, .cmd_flags=SYNC|IDLE,
.rq_flags=SORTED|ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1,
.internal_tag=199}
000000009ef7c802 {.op=WRITE, .cmd_flags=SYNC|IDLE,
.rq_flags=SORTED|ELVPRIV|IO_STAT|HASHED, .state=idle, .tag=-1,
.internal_tag=217}


Potential points which fixes the hang

1) Using no scheduler (none) on the client side RNBD block devices
results in no hang.

2) In the fio config, changing the line "iodepth_batch_complete=128"
to the following fixes the hang,
iodepth_batch_complete_min=1
iodepth_batch_complete_max=128
OR,
iodepth_batch_complete=0

3) We also tracked down the version from which the hang started. The
hang started with v5.10.50, and the following commit was one which
results in the hang

commit 512106ae2355813a5eb84e8dc908628d52856890
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Jun 25 10:02:48 2021 +0800

    blk-mq: update hctx->dispatch_busy in case of real scheduler

    [ Upstream commit cb9516be7708a2a18ec0a19fe3a225b5b3bc92c7 ]

    Commit 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
    starts to support io batching submission by using hctx->dispatch_busy.

    However, blk_mq_update_dispatch_busy() isn't changed to update
hctx->dispatch_busy
    in that commit, so fix the issue by updating hctx->dispatch_busy in case
    of real scheduler.

    Reported-by: Jan Kara <jack@suse.cz>
    Reviewed-by: Jan Kara <jack@suse.cz>
    Fixes: 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
    Signed-off-by: Ming Lei <ming.lei@redhat.com>
    Link: https://lore.kernel.org/r/20210625020248.1630497-1-ming.lei@redhat.com
    Signed-off-by: Jens Axboe <axboe@kernel.dk>
    Signed-off-by: Sasha Levin <sashal@kernel.org>

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 00d6ed2fe812..a368eb6dc647 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1242,9 +1242,6 @@ static void blk_mq_update_dispatch_busy(struct
blk_mq_hw_ctx *hctx, bool busy)
 {
        unsigned int ewma;

-       if (hctx->queue->elevator)
-               return;
-
        ewma = hctx->dispatch_busy;

        if (!ewma && !busy)

We reverted the commit and tested and there is no hang.

4) Lastly, we tested newer version like 5.13, and there is NO hang in
that also. Hence, probably some other change fixed it.

Regards
-Haris
