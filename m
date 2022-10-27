Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A27C38A2D
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 03:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiJ0DBF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 23:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbiJ0DAy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 23:00:54 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA565FAC7
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 20:00:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VT9I0CL_1666839644;
Received: from 30.97.56.235(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VT9I0CL_1666839644)
          by smtp.aliyun-inc.com;
          Thu, 27 Oct 2022 11:00:45 +0800
Message-ID: <228487d2-373c-57ae-c60d-53989324908e@linux.alibaba.com>
Date:   Thu, 27 Oct 2022 11:00:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] ublk_drv: don't call task_work_add for queueing io
 commands
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20221023093807.201946-1-ming.lei@redhat.com>
 <8a225315-3932-62a6-2bc6-8e81e672fd9d@linux.alibaba.com>
 <Y1aRBaUWGH54TTs4@T590>
 <1816adbd-fa1c-71e0-652d-483d47697254@linux.alibaba.com>
 <Y1eN7VqaJrCVJZjb@T590>
 <1ab57612-685a-6272-5d09-bfae47b4a37e@linux.alibaba.com>
 <925c299f-0d2f-2970-9c85-2f67834dd2bf@linux.alibaba.com>
 <Y1f+IeFQZhZRmZda@T590>
 <85bf5d34-7bbc-7da1-54fb-b0cec68a610b@linux.alibaba.com>
 <Y1kaFyan927Qnnnh@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <Y1kaFyan927Qnnnh@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/10/26 19:29, Ming Lei wrote:

[...]
>>
>> Intel(R) Xeon(R) Platinum 8369B CPU @ 2.70GHz 16 cores
>> 64GB MEM, CentOS 8, kernel 6.0+
>> with IORING_SETUP_COOP_TASKRUN, without this kernel patch
>>
>> ucmd: io_uring_cmd_complete_in_task(), ublk_drv is a module
>>
>> ucmd-not-touch-pdu: use llist && do not touch 'cmd'/'pdu'/'io' in ublk_queue_rq()
>>
>> tw: task_work_add(), ublk is built-in.
>>
>>
>> --------
>> fio test
>>
>> iodepth=128 numjobs=1 direct=1 bs=4k
>>
>> --------------------------------------------
>> ublk loop target, the backend is a file.
>>
>> IOPS(k)
>>
>> type		ucmd		tw		ucmd-not-touch-pdu
>> seq-read	54.1		53.8		53.6
>> rand-read	52.0		52.0		52.0
>>
>> --------------------------------------------
>> ublk null target
>> IOPS(k)
>>
>> type		ucmd		tw		ucmd-not-touch-pdu
>> seq-read	272		286		275
>> rand-read	262		278		269
>>
>>
>> ------------
>> ublksrv test
>>
>> -------------
>> ucmd
>>
>> running loop/001
>>         fio (ublk/loop( -f /root/work/ubdsrv/tests/tmp/ublk_loop_1G_BZ85U), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
>>         randwrite: jobs 1, iops 66737
>>         randread: jobs 1, iops 64935
>>         randrw: jobs 1, iops read 32694 write 32710
>>         rw(512k): jobs 1, iops read 772 write 819
>>
>> running null/001
>>         fio (ublk/null(), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
>>         randwrite: jobs 1, iops 715863
>>         randread: jobs 1, iops 758449
>>         randrw: jobs 1, iops read 357407 write 357183
>>         rw(512k): jobs 1, iops read 5895 write 5875
>>
>> -------------
>> tw
>>
>> running loop/001
>>         fio (ublk/loop( -f /root/work/ubdsrv/tests/tmp/ublk_loop_1G_pvLTL), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
>>         randwrite: jobs 1, iops 66856
>>         randread: jobs 1, iops 65015
>>         randrw: jobs 1, iops read 32751 write 32767
>>         rw(512k): jobs 1, iops read 776 write 823
>>
>> running null/001
>>         fio (ublk/null(), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
>>         randwrite: jobs 1, iops 739450
>>         randread: jobs 1, iops 787500
>>         randrw: jobs 1, iops read 372956 write 372831
>>         rw(512k): jobs 1, iops read 5798 write 5777
>>
>> -------------
>> ucmd-not-touch-pdu
>>
>> running loop/001
>>         fio (ublk/loop( -f /root/work/ubdsrv/tests/tmp/ublk_loop_1G_oH0eG), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
>>         randwrite: jobs 1, iops 66754
>>         randread: jobs 1, iops 65032
>>         randrw: jobs 1, iops read 32776 write 32792
>>         rw(512k): jobs 1, iops read 772 write 818
>>
>> running null/001
>>         fio (ublk/null(), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
>>         randwrite: jobs 1, iops 725334
>>         randread: jobs 1, iops 741105
>>         randrw: jobs 1, iops read 360285 write 360047
>>         rw(512k): jobs 1, iops read 5770 write 5748
>>
>> Not touching cmd/pdu/io in ublk_queue_rq() improves IOPS.
>> But it is worse than using task_work_add().
> 
> Thanks for the test! It is better to not share ucmd between
> ublk blk-mq io context and ubq daemon context, and we can
> improve it for using io_uring_cmd_complete_in_task(), and I
> have one patch by using the batch handing approach in
> io_uring_cmd_complete_in_task().
> 
> Another reason could be the extra __set_notify_signal() in
> __io_req_task_work_add() via task_work_add(). When task_work_add()
> is available, we just need to call __set_notify_signal() once
> for the whole batch, but it can't be done in case of using
> io_uring_cmd_complete_in_task().
> 
> Also the patch of 'use llist' is actually wrong since we have to
> call io_uring_cmd_complete_in_task() once in ->commit_rqs(), but
> that couldn't be easy because ucmd isn't available at that time.

Yes, you are correct.

> 
> I think we may have to live with task_work_add() until the perf
> number is improved to same basically with io_uring_cmd_complete_in_task().

OK, we can keep task_work_add() && io_uring_cmd_complete_in_task().
BTW, from test:loop/001, I think with real backends, the performance
gap between them seems not too big.

Regards,
Zhang

