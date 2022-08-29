Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D688ECAAA2
	for <linux-block@archiver.kernel.org>; Mon, 29 Aug 2022 03:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiH2DZv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Aug 2022 23:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiH2DZj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Aug 2022 23:25:39 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27111EED6
        for <linux-block@vger.kernel.org>; Sun, 28 Aug 2022 20:25:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=gumi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VNVnMuO_1661743533;
Received: from LR9115VM81021(mailfrom:gumi@linux.alibaba.com fp:SMTPD_---0VNVnMuO_1661743533)
          by smtp.aliyun-inc.com;
          Mon, 29 Aug 2022 11:25:34 +0800
From:   <gumi@linux.alibaba.com>
To:     "'Bart Van Assche'" <bvanassche@acm.org>, <axboe@kernel.dk>,
        <damien.lemoal@opensource.wdc.com>
Cc:     <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] block: I/O error occurs during SATA disk stress test
Date:   Mon, 29 Aug 2022 11:25:33 +0800
Message-ID: <002001d8bb57$000eabe0$002c03a0$@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adi7Vv5UwmI2V3CoSp+Rf4KspXirmg==
Content-Language: zh-cn
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Re: [PATCH v2] block: I/O error occurs during SATA disk stress test

On 8/25/22 00:09, Gu Mi wrote:
> The problem occurs in two async processes, One is when a new IO calls 
> the blk_mq_start_request() interface to start sending,The other is 
> that the block layer timer process calls the blk_mq_req_expired 
> interface to check whether there is an IO timeout.
> 
> When an instruction out of sequence occurs between blk_add_timer and 
> WRITE_ONCE(rq->state,MQ_RQ_IN_FLIGHT) in the interface 
> blk_mq_start_request,at this time, the block timer is checking the new 
> IO timeout, Since the req status has been set to MQ_RQ_IN_FLIGHT and 
> req->deadline is 0 at this time, the new IO will be misjudged as a 
> timeout.
> 
> Our repair plan is for the deadline to be 0, and we do not think that 
> a timeout occurs. At the same time, because the jiffies of the 32-bit 
> system will be reversed shortly after the system is turned on, we will 
> add 1 jiffies to the deadline at this time.

Hi Gu,

With which kernel version has this race been observed? Since commit
2e315dc07df0 ("blk-mq: grab rq->refcount before calling ->fn in
blk_mq_tagset_busy_iter") the request reference count is increased before the timeout handler (blk_mq_check_expired()) is called. Do you agree that since then it is no longer possible that
blk_mq_start_request() is called while blk_mq_check_expired() is in progress?

Thanks,

Bart.
 
---

Hi Bart,


This problem occurs on kernel version 5.10, and i read this commit you mentioned. The problem I observed is not a problem of req re-used fixed by commit 2e315dc07df0, but 
a different problem. The specific scene is this: A new IO has called blk_mq_start_request() to start sending, and an instruction out of sequence occurs between blk_add_timer() and 
WRITE_ONCE(rq->state,MQ_RQ_IN_FLIGHT) in blk_mq_start_request(), so the req->state is set to MQ_RQ_IN_FLIGHT, but req->deadline still 0, and at this very moment, timeout handler(blk_mq_check_expired())
check if this new IO times out,  this condition(if (time_after_eq(jiffies, deadline)) in blk_mq_req_expired() called by blk_mq_check_expired()) will is true. The end result is that this new IO is considered to have timed out.
I looked at the latest kernel code and the problem persists, do you agree with my analysis process?

Thanks,

Gu Mi.

