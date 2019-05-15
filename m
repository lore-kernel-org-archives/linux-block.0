Return-Path: <SRS0=Ir13=TP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C950EC04AA7
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 06:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C712084E
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 06:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfEOGsE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 May 2019 02:48:04 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:56279 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfEOGsD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 May 2019 02:48:03 -0400
X-QQ-mid: bizesmtp9t1557902865truwyx644
Received: from [192.168.142.168] (unknown [218.76.23.26])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 15 May 2019 14:47:44 +0800 (CST)
X-QQ-SSF: 00400000002000Q0VN60000A0000000
X-QQ-FEAT: SnnKeZOKkzFThseBR9nDZwmCQNH7HGdTAa6n0mESdOi5qeebj9KP6iDShlbAv
        KDKSjJJMw98AfZjWeZI4l2UKIz31utLfrIHFUYvp8SxYfYjYo/QWN32wP1BWrV31UNUeltH
        2YozRys7T0iUvu4oWRR+dQyRFNY3DG95oEdIcl6HEL9auCkWLXVKNsROjSquJGKOXEs6bAw
        JvE9j9AY/k1tTlE1t7SNpuzowE3yiDOE7qs/oWCIj5WP34cO3sRRESDkLp5a+e8EysLnICY
        RwGL5iZALN9f7wXS2m8aR1IFw6BbOlHT7NBFWjiZs8Li7TqJpkzT/NwvkyOq2f739qJg==
X-QQ-GoodBg: 2
From:   JackieLiu <liuyun01@kylinos.cn>
Content-Type: text/plain;
        charset=gb2312
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: replace sq_mask with ring_mask
Message-Id: <820102D0-D768-4E39-A9FE-FB75A53FEE8F@kylinos.cn>
Date:   Wed, 15 May 2019 14:47:43 +0800
Cc:     linux-block@vger.kernel.org
To:     axboe@kernel.dk
X-Mailer: Apple Mail (2.3445.104.8)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Jens Axboe

Could we replace ctx->sq_mask/ctx->cq_mask with cq_ring->ring_mask
/sq_ring->ring_mask ? because it¡¯s a constant and never change in 
io_uring.c

I found that ctx->sq_mask just used on 

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/io_uring.c?h=v5.1#n1831

and we can replace like follow:

- head = READ_ONCE(ring->array[head & ctx->sq_mask]);
+ head = READ_ONCE(ring->array[head & ring->ring_mask]);

If I understand incorrectly, please point out.

Jackie Liu

