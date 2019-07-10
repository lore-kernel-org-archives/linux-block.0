Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0454C74A21
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 15:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997892087F
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 15:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfGJPdd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:33:33 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:45646 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbfGJPdc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 11:33:32 -0400
X-QQ-mid: bizesmtp24t1562772799tvp6zkyz
Received: from [192.168.31.139] (unknown [175.10.88.112])
        by esmtp10.qq.com (ESMTP) with 
        id ; Wed, 10 Jul 2019 23:33:18 +0800 (CST)
X-QQ-SSF: 00400000002000Q0WO70000A0000000
X-QQ-FEAT: w8rTskylU5YMmCAYbtHdn/MUGLbHtgl8Y9fB6Qu1BJRt+JTFGWrTi2S0uURK3
        CdZBdSNeih2AFiCnK4vnt+YnGBAVn2uxcYEo1nJqFfNnR7O43L5T+WsogZ8OZ39h9+nCNz4
        WY9dAYg4bgzTHErOCnAQWR0XpQtacUx7Bjfl3WXlyIUMS3WOtb1OnRLGI3zs379Ed3ZROvJ
        dmxTgynT0zaOFpz4usH/N2oTSg3W0YuQ23b450AVrcebEvzFi3hxtH/jLXtV+gFmdC7sBpg
        B5ELOcYHi0yLGD1Vqu12CuvoLEtokk2y0XFYyp83IYb+Ozkh90tncHrMHcAGjWYsfRJNdET
        3BQvChK
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] io_uring: fix stuck problem caused by potential memory
 alloc failure
From:   JackieLiu <liuyun01@kylinos.cn>
In-Reply-To: <25691b9f-8c0f-0d19-d1db-4c4ce6dfb5a9@kernel.dk>
Date:   Wed, 10 Jul 2019 23:33:18 +0800
Cc:     linux-block@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <7E6A5863-5948-45B2-A7B7-C0CAEB8EDD8C@kylinos.cn>
References: <20190710083558.5940-1-liuyun01@kylinos.cn>
 <25691b9f-8c0f-0d19-d1db-4c4ce6dfb5a9@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thank you for pointing out. I haven't had time to pay attention to the new 
features of sqe links. When I was debugging another stuck problem, I found 
that there was no free the reference count, so I sent the patch about this.

Anyway, if necessary, I will resend the patch again, with your rewritten
comments.
 

> 在 2019年7月10日，21:57，Jens Axboe <axboe@kernel.dk> 写道：
> 
> On 7/10/19 2:35 AM, Jackie Liu wrote:
>> when io_req_defer alloc memory failed, it will be return -EAGAIN.
>> But io_submit_sqe cannot be returned immediately because the reference
>> count for req is still hold. we should be clean it.
> 
> Looks like this actually got fixed in my for-5.3/io_uring branch which
> I haven't pushed out yet. Once that's in, I'd suggest we send yours to
> stable separately. Probably change the wording to:
> 
> When io_req_defer alloc memory fails, it will be -EAGAIN. But
> io_submit_sqe cannot return immediately because the reference count for
> req is still held. Ensure that we free it.
> 
> -- 
> Jens Axboe
> 
> 



