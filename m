Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD33C67871
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 03:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJYDQI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 23:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiJYDQH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 23:16:07 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7CD264AF
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 20:16:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VT0ylga_1666667760;
Received: from 30.97.56.227(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VT0ylga_1666667760)
          by smtp.aliyun-inc.com;
          Tue, 25 Oct 2022 11:16:01 +0800
Message-ID: <1816adbd-fa1c-71e0-652d-483d47697254@linux.alibaba.com>
Date:   Tue, 25 Oct 2022 11:15:57 +0800
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
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <Y1aRBaUWGH54TTs4@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/10/24 21:20, Ming Lei wrote:
> Hello Ziyang,
> 
> On Mon, Oct 24, 2022 at 05:48:51PM +0800, Ziyang Zhang wrote:
>> On 2022/10/23 17:38, Ming Lei wrote:
>>> task_work_add() is used for waking ubq daemon task with one batch
>>> of io requests/commands queued. However, task_work_add() isn't
>>> exported for module code, and it is still debatable if the symbol
>>> should be exported.
>>>
>>> Fortunately we still have io_uring_cmd_complete_in_task() which just
>>> can't handle batched wakeup for us.
>>>
>>> Add one one llist into ublk_queue and call io_uring_cmd_complete_in_task()
>>> via current command for running them via task work.
>>>
>>> This way cleans up current code a lot, meantime allow us to wakeup
>>> ubq daemon task after queueing batched requests/io commands.
>>>
>>
>>
>> Hi, Ming
>>
>> This patch works and I have run some tests to compare current version(ucmd)
>> with your patch(ucmd-batch).
>>
>> iodepth=128 numjobs=1 direct=1 bs=4k
>>
>> --------------------------------------------
>> ublk loop target, the backend is a file.
>> IOPS(k)
>>
>> type		ucmd		ucmd-batch
>> seq-read	54.7		54.2	
>> rand-read	52.8		52.0
>>
>> --------------------------------------------
>> ublk null target
>> IOPS(k)
>>
>> type		ucmd		ucmd-batch
>> seq-read	257		257
>> rand-read	252		253
>>
>>
>> I find that io_req_task_work_add() puts task_work node into a llist
>> first, then it may call task_work_add() to run batched task_works. So do we really
>> need such llist in ublk_drv? I think io_uring has already considered task_work batch
>> optimization.
>>
>> BTW, task_work_add() in ublk_drv achieves
>> higher IOPS(about 5-10% on my machine) than io_uring_cmd_complete_in_task()
>> in ublk_drv.
> 
> Yeah, that is same with my observation, and motivation of this patch is
> to get same performance with task_work_add by building ublk_drv as
> module. One win of task_work_add() is that we get exact batching info
> meantime only send TWA_SIGNAL_NO_IPI for whole batch, that is basically
> what the patch is doing, but needs help of the following ublksrv patch:
> 
> https://github.com/ming1/ubdsrv/commit/dce6d1d222023c1641292713b311ced01e6dc548
> 
> which sets IORING_SETUP_COOP_TASKRUN for ublksrv's uring, then
> io_uring_cmd_complete_in_task will notify via TWA_SIGNAL_NO_IPI, and 5+%
> IOPS boost is observed on loop/001 by putting image on SSD in my test
> VM.

Hi Ming,

I have added this ublksrv patch and run the above test again.
I have also run ublksrv test: loop/001. Please check them.

Intel(R) Xeon(R) Platinum 8369B CPU @ 2.70GHz 16 cores
64GB MEM, CentOS 8, kernel 6.0+

--------
fio test

iodepth=128 numjobs=1 direct=1 bs=4k

ucmd: without your kernel patch. Run io_uring_cmd_complete_in_task()
for each blk-mq rq.

ucmd-batch: with your kernel patch. Run io_uring_cmd_complete_in_task()
for the last blk-mq rq.

--------------------------------------------
ublk loop target, the backend is a file.

IOPS(k)

type		ucmd		ucmd-batch
seq-read	54.1		53.7
rand-read	52.0		52.0

--------------------------------------------
ublk null target
IOPS(k)

type		ucmd		ucmd-batch
seq-read	272		265
rand-read	262		260

------------
ublksrv test

-------------
ucmd

running loop/001
        fio (ublk/loop( -f /root/work/ubdsrv/tests/tmp/ublk_loop_1G_BZ85U), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
        randwrite: jobs 1, iops 66737
        randread: jobs 1, iops 64935
        randrw: jobs 1, iops read 32694 write 32710
        rw(512k): jobs 1, iops read 772 write 819

-------------
ucmd-batch

running loop/001
        fio (ublk/loop( -f /root/work/ubdsrv/tests/tmp/ublk_loop_1G_F56a3), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
        randwrite: jobs 1, iops 66720
        randread: jobs 1, iops 65015
        randrw: jobs 1, iops read 32743 write 32759
        rw(512k): jobs 1, iops read 771 write 817


It seems that manually putting rqs into llist and calling
io_uring_cmd_complete_in_task() while handling the last rq does
not improve IOPS much.

io_req_task_work_add() puts task_work node into a internal llist
first, then it may call task_work_add() to run batched task_works.
IMO, io_uring has already done such batch optimization and ublk_drv
does not need to add such llist.

Regards,
Zhang.

