Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F9BFA3740
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 15:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbiJ0Pij (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 11:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiJ0Pii (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 11:38:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23E8190478
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 08:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666885116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1yPkeN7l/PbIG4DTFCPy68NLf28VuSVOJ19jeCDuMCM=;
        b=geEMokzo4VD/ae37Wu+n6bV7RphLY7Vq0y57BQjVWMI0O9O01pTRU7V0oMLq08xu0zmFm8
        uNHZxbrb2buYkzbHUVv4D1M49k/02pLcLOa5s0/Oo8N+AKnYBIOUvoxQDE8/XQOVQm3N3r
        4Vl5YrSmO25Jth+tNqczgROd5WDibA0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-sWEAV2xqPwO4erw4-MBvyA-1; Thu, 27 Oct 2022 11:38:30 -0400
X-MC-Unique: sWEAV2xqPwO4erw4-MBvyA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C88D7857FAC;
        Thu, 27 Oct 2022 15:38:29 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38C692166B2B;
        Thu, 27 Oct 2022 15:38:25 +0000 (UTC)
Date:   Thu, 27 Oct 2022 23:38:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] ublk_drv: don't call task_work_add for queueing io
 commands
Message-ID: <Y1ql7K2zpVL4LskH@T590>
References: <8a225315-3932-62a6-2bc6-8e81e672fd9d@linux.alibaba.com>
 <Y1aRBaUWGH54TTs4@T590>
 <1816adbd-fa1c-71e0-652d-483d47697254@linux.alibaba.com>
 <Y1eN7VqaJrCVJZjb@T590>
 <1ab57612-685a-6272-5d09-bfae47b4a37e@linux.alibaba.com>
 <925c299f-0d2f-2970-9c85-2f67834dd2bf@linux.alibaba.com>
 <Y1f+IeFQZhZRmZda@T590>
 <85bf5d34-7bbc-7da1-54fb-b0cec68a610b@linux.alibaba.com>
 <Y1kaFyan927Qnnnh@T590>
 <228487d2-373c-57ae-c60d-53989324908e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <228487d2-373c-57ae-c60d-53989324908e@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 27, 2022 at 11:00:44AM +0800, Ziyang Zhang wrote:
> On 2022/10/26 19:29, Ming Lei wrote:
> 
> [...]
> >>
> >> Intel(R) Xeon(R) Platinum 8369B CPU @ 2.70GHz 16 cores
> >> 64GB MEM, CentOS 8, kernel 6.0+
> >> with IORING_SETUP_COOP_TASKRUN, without this kernel patch
> >>
> >> ucmd: io_uring_cmd_complete_in_task(), ublk_drv is a module
> >>
> >> ucmd-not-touch-pdu: use llist && do not touch 'cmd'/'pdu'/'io' in ublk_queue_rq()
> >>
> >> tw: task_work_add(), ublk is built-in.
> >>
> >>
> >> --------
> >> fio test
> >>
> >> iodepth=128 numjobs=1 direct=1 bs=4k
> >>
> >> --------------------------------------------
> >> ublk loop target, the backend is a file.
> >>
> >> IOPS(k)
> >>
> >> type		ucmd		tw		ucmd-not-touch-pdu
> >> seq-read	54.1		53.8		53.6
> >> rand-read	52.0		52.0		52.0
> >>
> >> --------------------------------------------
> >> ublk null target
> >> IOPS(k)
> >>
> >> type		ucmd		tw		ucmd-not-touch-pdu
> >> seq-read	272		286		275
> >> rand-read	262		278		269
> >>
> >>
> >> ------------
> >> ublksrv test
> >>
> >> -------------
> >> ucmd
> >>
> >> running loop/001
> >>         fio (ublk/loop( -f /root/work/ubdsrv/tests/tmp/ublk_loop_1G_BZ85U), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
> >>         randwrite: jobs 1, iops 66737
> >>         randread: jobs 1, iops 64935
> >>         randrw: jobs 1, iops read 32694 write 32710
> >>         rw(512k): jobs 1, iops read 772 write 819
> >>
> >> running null/001
> >>         fio (ublk/null(), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
> >>         randwrite: jobs 1, iops 715863
> >>         randread: jobs 1, iops 758449
> >>         randrw: jobs 1, iops read 357407 write 357183
> >>         rw(512k): jobs 1, iops read 5895 write 5875
> >>
> >> -------------
> >> tw
> >>
> >> running loop/001
> >>         fio (ublk/loop( -f /root/work/ubdsrv/tests/tmp/ublk_loop_1G_pvLTL), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
> >>         randwrite: jobs 1, iops 66856
> >>         randread: jobs 1, iops 65015
> >>         randrw: jobs 1, iops read 32751 write 32767
> >>         rw(512k): jobs 1, iops read 776 write 823
> >>
> >> running null/001
> >>         fio (ublk/null(), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
> >>         randwrite: jobs 1, iops 739450
> >>         randread: jobs 1, iops 787500
> >>         randrw: jobs 1, iops read 372956 write 372831
> >>         rw(512k): jobs 1, iops read 5798 write 5777
> >>
> >> -------------
> >> ucmd-not-touch-pdu
> >>
> >> running loop/001
> >>         fio (ublk/loop( -f /root/work/ubdsrv/tests/tmp/ublk_loop_1G_oH0eG), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
> >>         randwrite: jobs 1, iops 66754
> >>         randread: jobs 1, iops 65032
> >>         randrw: jobs 1, iops read 32776 write 32792
> >>         rw(512k): jobs 1, iops read 772 write 818
> >>
> >> running null/001
> >>         fio (ublk/null(), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
> >>         randwrite: jobs 1, iops 725334
> >>         randread: jobs 1, iops 741105
> >>         randrw: jobs 1, iops read 360285 write 360047
> >>         rw(512k): jobs 1, iops read 5770 write 5748
> >>
> >> Not touching cmd/pdu/io in ublk_queue_rq() improves IOPS.
> >> But it is worse than using task_work_add().
> > 
> > Thanks for the test! It is better to not share ucmd between
> > ublk blk-mq io context and ubq daemon context, and we can
> > improve it for using io_uring_cmd_complete_in_task(), and I
> > have one patch by using the batch handing approach in
> > io_uring_cmd_complete_in_task().
> > 
> > Another reason could be the extra __set_notify_signal() in
> > __io_req_task_work_add() via task_work_add(). When task_work_add()
> > is available, we just need to call __set_notify_signal() once
> > for the whole batch, but it can't be done in case of using
> > io_uring_cmd_complete_in_task().
> > 
> > Also the patch of 'use llist' is actually wrong since we have to
> > call io_uring_cmd_complete_in_task() once in ->commit_rqs(), but
> > that couldn't be easy because ucmd isn't available at that time.
> 
> Yes, you are correct.
> 
> > 
> > I think we may have to live with task_work_add() until the perf
> > number is improved to same basically with io_uring_cmd_complete_in_task().
> 
> OK, we can keep task_work_add() && io_uring_cmd_complete_in_task().
> BTW, from test:loop/001, I think with real backends, the performance
> gap between them seems not too big.

Actually in VM created in my laptop, the gap isn't small on ublk-loop:

1) ublk-null, single job, change nr_hw_queue to 2 for using none scheduler
[root@ktest-09 ublksrv]# make test T=null/001:null/004
make -C tests run T=null/001:null/004 R=10 D=tests/tmp/
make[1]: Entering directory '/root/git/ublksrv/tests'
./run_test.sh null/001:null/004 10 tests/tmp/
running null/001
	fio (ublk/null(), libaio, dio, hw queues:2, io jobs: 1, uring_comp: 0, get_data: 0)...
	randwrite(4k): jobs 1, iops 1028774, cpu_util(29% 69%)
	randread(4k): jobs 1, iops 958598, cpu_util(27% 72%)
	randrw(4k): jobs 1, iops read 453382 write 453239, cpu_util(29% 70%)
	rw(512k): jobs 1, iops read 5264 write 5242, cpu_util(7% 6%)

running null/004
	fio (ublk/null(), libaio, dio, hw queues:2, io jobs: 1, uring_comp: 1, get_data: 0)...
	randwrite(4k): jobs 1, iops 950755, cpu_util(30% 69%)
	randread(4k): jobs 1, iops 855984, cpu_util(26% 73%)
	randrw(4k): jobs 1, iops read 439369 write 439287, cpu_util(29% 70%)
	rw(512k): jobs 1, iops read 5225 write 5202, cpu_util(7% 5%)

2) ublk-loop, single job, change nr_hw_queue to 2 for using none scheduler
[root@ktest-09 ublksrv]# make test T=loop/001:loop/004
make -C tests run T=loop/001:loop/004 R=10 D=tests/tmp/
make[1]: Entering directory '/root/git/ublksrv/tests'
./run_test.sh loop/001:loop/004 10 tests/tmp/
running loop/001
	fio (ublk/loop( -f /root/git/ublksrv/tests/tmp/ublk_loop_2G_STbdZ), libaio, dio, hw queues:2, io jobs: 1, uring_comp: 0, get_data: 0)...
	randwrite(4k): jobs 1, iops 163177, cpu_util(7% 20%)
	randread(4k): jobs 1, iops 141584, cpu_util(6% 14%)
	randrw(4k): jobs 1, iops read 75034 write 75148, cpu_util(7% 17%)
	rw(512k): jobs 1, iops read 1574 write 1663, cpu_util(3% 4%)

running loop/004
	fio (ublk/loop( -f /root/git/ublksrv/tests/tmp/ublk_loop_2G_AdrHl), libaio, dio, hw queues:2, io jobs: 1, uring_comp: 1, get_data: 0)...
	randwrite(4k): jobs 1, iops 142353, cpu_util(7% 19%)
	randread(4k): jobs 1, iops 133883, cpu_util(6% 14%)
	randrw(4k): jobs 1, iops read 72581 write 72691, cpu_util(7% 18%)
	rw(512k): jobs 1, iops read 929 write 981, cpu_util(2% 2%)



Thanks,
Ming

