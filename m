Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE80ECAAD4
	for <linux-block@archiver.kernel.org>; Mon, 29 Aug 2022 04:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiH2EHm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Aug 2022 00:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiH2EHk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Aug 2022 00:07:40 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A7D30551
        for <linux-block@vger.kernel.org>; Sun, 28 Aug 2022 21:07:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=gumi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VNW3YsK_1661746055;
Received: from LR9115VM81021(mailfrom:gumi@linux.alibaba.com fp:SMTPD_---0VNW3YsK_1661746055)
          by smtp.aliyun-inc.com;
          Mon, 29 Aug 2022 12:07:36 +0800
From:   <gumi@linux.alibaba.com>
To:     "'Bart Van Assche'" <bvanassche@acm.org>, <axboe@kernel.dk>,
        <damien.lemoal@opensource.wdc.com>
Cc:     <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] block: I/O error occurs during SATA disk stress test
Date:   Mon, 29 Aug 2022 12:07:35 +0800
Message-ID: <000401d8bb5c$df344640$9d9cd2c0$@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adi7XN4DrcD67lsLRUOJTUTEJt7R/Q==
Content-Language: zh-cn
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/28/22 20:25, gumi@linux.alibaba.com wrote:
> This problem occurs on kernel version 5.10, and i read this commit you 
> mentioned. The problem I observed is not a problem of req re-used 
> fixed by commit 2e315dc07df0, but a different problem. The specific 
> scene is this: A new IO has called blk_mq_start_request() to start 
> sending, and an instruction out of sequence occurs between
> blk_add_timer() and WRITE_ONCE(rq->state,MQ_RQ_IN_FLIGHT) in 
> blk_mq_start_request(), so the req->state is set to MQ_RQ_IN_FLIGHT, 
> but req->deadline still 0, and at this very moment, timeout
> handler(blk_mq_check_expired()) check if this new IO times out,  this 
> condition(if (time_after_eq(jiffies, deadline)) in
> blk_mq_req_expired() called by blk_mq_check_expired()) will is true.
> The end result is that this new IO is considered to have timed out. I 
> looked at the latest kernel code and the problem persists, do you 
> agree with my analysis process?
It seems unlikely to me that the above analysis is correct. If this problem would occur with recent kernel versions, I think that it would already have been reported by other Linux users.

Thanks,

Bart.

---

Hi Bart,

First of all, this problem is not easy to be tested. We have tested it hundreds of times, and the recurrence is low probability. Basically, it needs to run continuously for 15-20 days under the high pressure test.
After analyzing the reason, we modified it according to the method of V1, and continued to test for more than 30 days, and this problem did not appear. Finally I decided to submit this patch to upstream.
According to our code analysis, this problem scenario is one that may occur under polar probability, please re-examine my analysis process.

Thanks,

Gu Mi 




