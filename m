Return-Path: <SRS0=pdd5=74=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45107C433DF
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 06:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A622067B
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 06:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZKAvCXrS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgFOG5f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgFOG5e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 02:57:34 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4ECC05BD43
        for <linux-block@vger.kernel.org>; Sun, 14 Jun 2020 23:57:34 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 205so14794906qkg.3
        for <linux-block@vger.kernel.org>; Sun, 14 Jun 2020 23:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=sAlar1NihVVApceAMxEoWLgMWkjXJ9kYnLmHd1yzj9A=;
        b=ZKAvCXrSYsY/bqiE4rb6UG3lU4Er7hCdeWESRBZVBkTpdNUCJZhhLRayMf0GSHzKnK
         8pT4Uf31J4hRgir/hQ4qBLDXIWZC95lrgbSv4fK0KuGQMTXsU8J24kl0P5qsQ+T2m9LG
         9q087jqb1sm60Or+h3H2YFhqTQFqQywCdFi0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=sAlar1NihVVApceAMxEoWLgMWkjXJ9kYnLmHd1yzj9A=;
        b=lE2xXS9ej5omF2wudjJq6lkcibzOMkYvj6SRwHVKtT2okEK+L2ap83oOyi7s77DB+l
         tLLZqmvzZr6vQwegHPw+vmOi+2vMzLxge6kxWcVdwph6d0oztnvN3q4exlWVLtBTEh34
         nlDCJ4IJEnRLR6hSkF+DhXH2D0JsHXVq+ZbbdltotBzjjdwmYSJQ30cDx2H+xSRkg0Ot
         I8m1oqD03J6ttABqxXwrn3guut10t9Cpj2IbH24cLADzS9OB1lfzk/gjyifGCspHw4pz
         gpskHAVvXSk4e6wg2ECDiNnU2WaSFQkCGzIUJgogvuKHB4fzLUCs1VnRvSG/Z1uW9KtF
         1WfQ==
X-Gm-Message-State: AOAM533l4GfsvcDgNIdhNx03SofiFEZ6KOANI5HgJYPEfGpm6nUBq5XK
        1ha9d7hePVZgd8vI3MW5xVxHODuyxcYwa3Ln5iRsMw==
X-Google-Smtp-Source: ABdhPJzBHtqx5pr6g2UkSRht7mswIlfn8JqOJ+c4w/7aV4xJstGn6XyTlfTktLt/3s2lpUPPiR9GA33ejCpTG/VTZtY=
X-Received: by 2002:ae9:e813:: with SMTP id a19mr13897734qkg.264.1592204252936;
 Sun, 14 Jun 2020 23:57:32 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <1591810159-240929-1-git-send-email-john.garry@huawei.com>
 <20200611030708.GB453671@T590> <c033f445-97fd-6dc9-c270-9890681b39d9@huawei.com>
 <bbdec3b3fbeb9907d2ec66a2afa56c29@mail.gmail.com> <20200615021355.GA4012@T590>
In-Reply-To: <20200615021355.GA4012@T590>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQBVjmvxAE7FMYb7GtMRWGcwtMcECgGaerxUAVTJvjECMFFU0QGrq6Usq6RLEnA=
Date:   Mon, 15 Jun 2020 12:27:30 +0530
Message-ID: <e49f164d867b53fd4495f1e05a85df03@mail.gmail.com>
Subject: RE: [PATCH RFC v7 00/12] blk-mq/scsi: Provide hostwide shared tags
 for SCSI HBAs
To:     Ming Lei <ming.lei@redhat.com>
Cc:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        don.brace@microsemi.com, Sumit Saxena <sumit.saxena@broadcom.com>,
        bvanassche@acm.org, hare@suse.com, hch@lst.de,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        esc.storagedev@microsemi.com, chenxiang66@hisilicon.com,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> >
> > John -
> >
> > I tried V7 series and debug further on mq-deadline interface. This
> > time I have used another setup since HDD based setup is not readily
> > available for me.
> > In fact, I was able to simulate issue very easily using single
> > scsi_device as well. BTW, this is not an issue with this RFC, but
generic issue.
> > Since I have converted nr_hw_queue > 1 for Broadcom product using this
> > RFC, It becomes noticeable now.
> >
> > Problem - Using below command  I see heavy CPU utilization on "
> > native_queued_spin_lock_slowpath". This is because kblockd work queue
> > is submitting IO from all the CPUs even though fio is bound to single
CPU.
> > Lock contention from " dd_dispatch_request" is causing this issue.
> >
> > numactl -C 13  fio
> > single.fio --iodepth=32 --bs=4k --rw=randread --ioscheduler=none
> > --numjobs=1  --cpus_allowed_policy=split --ioscheduler=mq-deadline
> > --group_reporting --filename=/dev/sdd
> >
> > While running above command, ideally we expect only kworker/13 to be
> active.
> > But you can see below - All the CPU is attempting submission and lots
> > of CPU consumption is due to lock contention.
> >
> >   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+
COMMAND
> >  2726 root       0 -20       0      0      0 R  56.5  0.0   0:53.20
> > kworker/13:1H-k
> >  7815 root      20   0  712404  15536   2228 R  43.2  0.0   0:05.03
fio
> >  2792 root       0 -20       0      0      0 I  26.6  0.0   0:22.19
> > kworker/18:1H-k
> >  2791 root       0 -20       0      0      0 I  19.9  0.0   0:17.17
> > kworker/19:1H-k
> >  1419 root       0 -20       0      0      0 I  19.6  0.0   0:17.03
> > kworker/20:1H-k
> >  2793 root       0 -20       0      0      0 I  18.3  0.0   0:15.64
> > kworker/21:1H-k
> >  1424 root       0 -20       0      0      0 I  17.3  0.0   0:14.99
> > kworker/22:1H-k
> >  2626 root       0 -20       0      0      0 I  16.9  0.0   0:14.68
> > kworker/26:1H-k
> >  2794 root       0 -20       0      0      0 I  16.9  0.0   0:14.87
> > kworker/23:1H-k
> >  2795 root       0 -20       0      0      0 I  16.9  0.0   0:14.81
> > kworker/24:1H-k
> >  2797 root       0 -20       0      0      0 I  16.9  0.0   0:14.62
> > kworker/27:1H-k
> >  1415 root       0 -20       0      0      0 I  16.6  0.0   0:14.44
> > kworker/30:1H-k
> >  2669 root       0 -20       0      0      0 I  16.6  0.0   0:14.38
> > kworker/31:1H-k
> >  2796 root       0 -20       0      0      0 I  16.6  0.0   0:14.74
> > kworker/25:1H-k
> >  2799 root       0 -20       0      0      0 I  16.6  0.0   0:14.56
> > kworker/28:1H-k
> >  1425 root       0 -20       0      0      0 I  16.3  0.0   0:14.21
> > kworker/34:1H-k
> >  2746 root       0 -20       0      0      0 I  16.3  0.0   0:14.33
> > kworker/32:1H-k
> >  2798 root       0 -20       0      0      0 I  16.3  0.0   0:14.50
> > kworker/29:1H-k
> >  2800 root       0 -20       0      0      0 I  16.3  0.0   0:14.27
> > kworker/33:1H-k
> >  1423 root       0 -20       0      0      0 I  15.9  0.0   0:14.10
> > kworker/54:1H-k
> >  1784 root       0 -20       0      0      0 I  15.9  0.0   0:14.03
> > kworker/55:1H-k
> >  2801 root       0 -20       0      0      0 I  15.9  0.0   0:14.15
> > kworker/35:1H-k
> >  2815 root       0 -20       0      0      0 I  15.9  0.0   0:13.97
> > kworker/56:1H-k
> >  1484 root       0 -20       0      0      0 I  15.6  0.0   0:13.90
> > kworker/57:1H-k
> >  1485 root       0 -20       0      0      0 I  15.6  0.0   0:13.82
> > kworker/59:1H-k
> >  1519 root       0 -20       0      0      0 I  15.6  0.0   0:13.64
> > kworker/62:1H-k
> >  2315 root       0 -20       0      0      0 I  15.6  0.0   0:13.87
> > kworker/58:1H-k
> >  2627 root       0 -20       0      0      0 I  15.6  0.0   0:13.69
> > kworker/61:1H-k
> >  2816 root       0 -20       0      0      0 I  15.6  0.0   0:13.75
> > kworker/60:1H-k
> >
> >
> > I root cause this issue -
> >
> > Block layer always queue IO on hctx context mapped to CPU-13, but hw
> > queue run from all the hctx context.
> > I noticed in my test hctx48 has queued all the IOs. No other hctx has
> > queued IO. But all the hctx is counting for "run".
> >
> > # cat hctx48/queued
> > 2087058
> >
> > #cat hctx*/run
> > 151318
> > 30038
> > 83110
> > 50680
> > 69907
> > 60391
> > 111239
> > 18036
> > 33935
> > 91648
> > 34582
> > 22853
> > 61286
> > 19489
> >
> > Below patch has fix - "Run the hctx queue for which request was
> > completed instead of running all the hardware queue."
> > If this looks valid fix, please include in V8 OR I can post separate
> > patch for this. Just want to have some level of review from this
discussion.
> >
> > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c index
> > 0652acd..f52118f 100644
> > --- a/drivers/scsi/scsi_lib.c
> > +++ b/drivers/scsi/scsi_lib.c
> > @@ -554,6 +554,7 @@ static bool scsi_end_request(struct request *req,
> > blk_status_t error,
> >         struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
> >         struct scsi_device *sdev = cmd->device;
> >         struct request_queue *q = sdev->request_queue;
> > +       struct blk_mq_hw_ctx *mq_hctx = req->mq_hctx;
> >
> >         if (blk_update_request(req, error, bytes))
> >                 return true;
> > @@ -595,7 +596,8 @@ static bool scsi_end_request(struct request *req,
> > blk_status_t error,
> >             !list_empty(&sdev->host->starved_list))
> >                 kblockd_schedule_work(&sdev->requeue_work);
> >         else
> > -               blk_mq_run_hw_queues(q, true);
> > +               blk_mq_run_hw_queue(mq_hctx, true);
> > +               //blk_mq_run_hw_queues(q, true);
>
> This way may cause IO hang because ->device_busy is shared by all hctxs.

From SCSI stack, if we attempt to run all h/w queue, is it possible that
block layer actually run hw_queue which has really not queued any IO.
Currently, in case of mq-deadline, IOS are inserted using
"dd_insert_request". This function will add IOs on elevator data which is
per request queue and not per hctx.
When there is an attempt to run hctx, "blk_mq_sched_has_work" will check
pending work which is per request queue and not per hctx.
Because of this, IOs queued on only one hctx will be run from all the hctx
and this will create unnecessary lock contention.

How about below patch - ?

diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 126021f..1d30bd3 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -74,6 +74,13 @@ static inline bool blk_mq_sched_has_work(struct
blk_mq_hw_ctx *hctx)
 {
        struct elevator_queue *e = hctx->queue->elevator;

+       /* If current hctx has not queued any request, there is no need to
run.
+        * blk_mq_run_hw_queue() on hctx which has queued IO will handle
+        * running specific hctx.
+        */
+       if (!hctx->queued)
+               return false;
+
        if (e && e->type->ops.has_work)
                return e->type->ops.has_work(hctx);

Kashyap

>
> Thanks,
> Ming
