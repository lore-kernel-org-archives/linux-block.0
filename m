Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BACC4332F
	for <linux-block@archiver.kernel.org>; Tue, 22 Nov 2022 06:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiKVGF2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Nov 2022 01:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKVGF1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 01:05:27 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329432935D
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 22:05:25 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VVQn-Gy_1669097122;
Received: from 30.97.56.154(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VVQn-Gy_1669097122)
          by smtp.aliyun-inc.com;
          Tue, 22 Nov 2022 14:05:22 +0800
Message-ID: <7744e3c1-65ae-7dec-1e50-5ccf6035ceeb@linux.alibaba.com>
Date:   Tue, 22 Nov 2022 14:05:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] ublk_drv: don't forward io commands in reserve order
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Andreas Hindborg <andreas.hindborg@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20221121155645.396272-1-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20221121155645.396272-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/11/21 23:56, Ming Lei wrote:
> Either ublk_can_use_task_work() is true or not, io commands are
> forwarded to ublk server in reverse order, since llist_add() is
> always to add one element to the head of the list.
> 
> Even though block layer doesn't guarantee request dispatch order,
> requests should be sent to hardware in the sequence order generated
> from io scheduler, which usually considers the request's LBA, and
> order is often important for HDD.
> 
> So forward io commands in the sequence made from io scheduler by
> aligning task work with current io_uring command's batch handling,
> and it has been observed that both can get similar performance data
> if IORING_SETUP_COOP_TASKRUN is set from ublk server.
> 
> Reported-by: Andreas Hindborg <andreas.hindborg@wdc.com>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

I have tested this with dd. Looks like we get the correct order:

ublk_queue_rq: qid 0 tag 2 sect 12288
__ublk_rq_task_work: complete: op 33, qid 0 tag 2 io_flags 1 addr 7ff16699e000 sect 12288
ublk_queue_rq: qid 0 tag 5 sect 13312
__ublk_rq_task_work: complete: op 33, qid 0 tag 5 io_flags 1 addr 7ff166818000 sect 13312
ublk_queue_rq: qid 0 tag 4 sect 14336
__ublk_rq_task_work: complete: op 33, qid 0 tag 4 io_flags 1 addr 7ff16689a000 sect 14336
ublk_queue_rq: qid 0 tag 6 sect 15360
__ublk_rq_task_work: complete: op 33, qid 0 tag 6 io_flags 1 addr 7ff166796000 sect 15360


Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>

Regards,
Zhang
