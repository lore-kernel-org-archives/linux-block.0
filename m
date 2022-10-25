Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1045BC38A2D
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 07:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiJYHTX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 03:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiJYHTW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 03:19:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7287D14D8D6
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 00:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666682360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OMITacMIuK06n7XR50wZoMRWWXDrz1szxyU8dgeD2bc=;
        b=Kqj/4Xq+XgycdXjCTFC10EhSn0cTDzUKBp11JhbHU1cN9eqKYEtDz6/2hZjUTOa9paMXDF
        ZUWNvai5Lkxp9S+2TdAp31ZyUQSPNrCsQNGTj95M5Xn91CFSiskD7LpY6ID0H8DDtl7FOn
        tlJIgj51+hdw1+++1vOp83QO5YSY6ow=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-PJNn_1QhN0W9v3bThzPbEw-1; Tue, 25 Oct 2022 03:19:18 -0400
X-MC-Unique: PJNn_1QhN0W9v3bThzPbEw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16B77101A56D;
        Tue, 25 Oct 2022 07:19:18 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 06831492B0A;
        Tue, 25 Oct 2022 07:19:14 +0000 (UTC)
Date:   Tue, 25 Oct 2022 15:19:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] ublk_drv: don't call task_work_add for queueing io
 commands
Message-ID: <Y1eN7VqaJrCVJZjb@T590>
References: <20221023093807.201946-1-ming.lei@redhat.com>
 <8a225315-3932-62a6-2bc6-8e81e672fd9d@linux.alibaba.com>
 <Y1aRBaUWGH54TTs4@T590>
 <1816adbd-fa1c-71e0-652d-483d47697254@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1816adbd-fa1c-71e0-652d-483d47697254@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 25, 2022 at 11:15:57AM +0800, Ziyang Zhang wrote:
> On 2022/10/24 21:20, Ming Lei wrote:
> > Hello Ziyang,
> > 
> > On Mon, Oct 24, 2022 at 05:48:51PM +0800, Ziyang Zhang wrote:
> >> On 2022/10/23 17:38, Ming Lei wrote:
> >>> task_work_add() is used for waking ubq daemon task with one batch
> >>> of io requests/commands queued. However, task_work_add() isn't
> >>> exported for module code, and it is still debatable if the symbol
> >>> should be exported.
> >>>
> >>> Fortunately we still have io_uring_cmd_complete_in_task() which just
> >>> can't handle batched wakeup for us.
> >>>
> >>> Add one one llist into ublk_queue and call io_uring_cmd_complete_in_task()
> >>> via current command for running them via task work.
> >>>
> >>> This way cleans up current code a lot, meantime allow us to wakeup
> >>> ubq daemon task after queueing batched requests/io commands.
> >>>
> >>
> >>
> >> Hi, Ming
> >>
> >> This patch works and I have run some tests to compare current version(ucmd)
> >> with your patch(ucmd-batch).
> >>
> >> iodepth=128 numjobs=1 direct=1 bs=4k
> >>
> >> --------------------------------------------
> >> ublk loop target, the backend is a file.
> >> IOPS(k)
> >>
> >> type		ucmd		ucmd-batch
> >> seq-read	54.7		54.2	
> >> rand-read	52.8		52.0
> >>
> >> --------------------------------------------
> >> ublk null target
> >> IOPS(k)
> >>
> >> type		ucmd		ucmd-batch
> >> seq-read	257		257
> >> rand-read	252		253
> >>
> >>
> >> I find that io_req_task_work_add() puts task_work node into a llist
> >> first, then it may call task_work_add() to run batched task_works. So do we really
> >> need such llist in ublk_drv? I think io_uring has already considered task_work batch
> >> optimization.
> >>
> >> BTW, task_work_add() in ublk_drv achieves
> >> higher IOPS(about 5-10% on my machine) than io_uring_cmd_complete_in_task()
> >> in ublk_drv.
> > 
> > Yeah, that is same with my observation, and motivation of this patch is
> > to get same performance with task_work_add by building ublk_drv as
> > module. One win of task_work_add() is that we get exact batching info
> > meantime only send TWA_SIGNAL_NO_IPI for whole batch, that is basically
> > what the patch is doing, but needs help of the following ublksrv patch:
> > 
> > https://github.com/ming1/ubdsrv/commit/dce6d1d222023c1641292713b311ced01e6dc548
> > 
> > which sets IORING_SETUP_COOP_TASKRUN for ublksrv's uring, then
> > io_uring_cmd_complete_in_task will notify via TWA_SIGNAL_NO_IPI, and 5+%
> > IOPS boost is observed on loop/001 by putting image on SSD in my test
> > VM.
> 
> Hi Ming,
> 
> I have added this ublksrv patch and run the above test again.
> I have also run ublksrv test: loop/001. Please check them.
> 
> Intel(R) Xeon(R) Platinum 8369B CPU @ 2.70GHz 16 cores
> 64GB MEM, CentOS 8, kernel 6.0+
> 
> --------
> fio test
> 
> iodepth=128 numjobs=1 direct=1 bs=4k
> 
> ucmd: without your kernel patch. Run io_uring_cmd_complete_in_task()
> for each blk-mq rq.
> 
> ucmd-batch: with your kernel patch. Run io_uring_cmd_complete_in_task()
> for the last blk-mq rq.
> 
> --------------------------------------------
> ublk loop target, the backend is a file.
> 
> IOPS(k)
> 
> type		ucmd		ucmd-batch
> seq-read	54.1		53.7
> rand-read	52.0		52.0
> 
> --------------------------------------------
> ublk null target
> IOPS(k)
> 
> type		ucmd		ucmd-batch
> seq-read	272		265
> rand-read	262		260
> 
> ------------
> ublksrv test
> 
> -------------
> ucmd
> 
> running loop/001
>         fio (ublk/loop( -f /root/work/ubdsrv/tests/tmp/ublk_loop_1G_BZ85U), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
>         randwrite: jobs 1, iops 66737
>         randread: jobs 1, iops 64935
>         randrw: jobs 1, iops read 32694 write 32710
>         rw(512k): jobs 1, iops read 772 write 819
> 
> -------------
> ucmd-batch
> 
> running loop/001
>         fio (ublk/loop( -f /root/work/ubdsrv/tests/tmp/ublk_loop_1G_F56a3), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
>         randwrite: jobs 1, iops 66720
>         randread: jobs 1, iops 65015
>         randrw: jobs 1, iops read 32743 write 32759
>         rw(512k): jobs 1, iops read 771 write 817
> 
> 
> It seems that manually putting rqs into llist and calling
> io_uring_cmd_complete_in_task() while handling the last rq does
> not improve IOPS much.
> 
> io_req_task_work_add() puts task_work node into a internal llist
> first, then it may call task_work_add() to run batched task_works.
> IMO, io_uring has already done such batch optimization and ublk_drv
> does not need to add such llist.

The difference is just how batching is handled, looks blk-mq's batch info
doesn't matter any more. In my test, looks the perf improvement is mainly
made by enabling IORING_SETUP_COOP_TASKRUN in ublksrv.

Can you check if enabling IORING_SETUP_COOP_TASKRUN only can reach
same perf with task_work_add()(ublk_drv is builtin) when building
ublk_drv as module?


Thanks,
Ming

