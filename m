Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC60C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 00:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988CA20874
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 00:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbeLTAQt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 19:16:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46707 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbeLTAQt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 19:16:49 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so10594540pfe.13
        for <linux-block@vger.kernel.org>; Wed, 19 Dec 2018 16:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p9E45VkOLuL8Y9Kk1w7CHco3MbKFwRT9rPo+2Xx41Tk=;
        b=FtVRgzI/jicDxkcsSNjr2CR1/XetG+DeSLfwMhi9dpngqFoH/IHqM4NjsqeLqwDxVv
         trT6DfG/f+kxD8prGeIx7m0lFozEOw1E3iSM0C+9TZwwxI07bjRdMBr/XTJkHjIF3qSf
         pivmdwcRbJMjOJcakWZMlP5hJlKw7ESMe49TQ/nIe4SHsR9A35FScJth6tEPrynWjxNU
         XTdyrrpD2FQGfNV9P8SOkvLk+cDK34raoLvAb5WTu2yd61SLXsbPHpwIa+m14fcEw+R6
         /9anIZ4TWyGTX/zcJolz2wOAnsqT1utmNQOLeFGco4pk6c1yhIh3ADo8VxBuG5AFcJKO
         GcUg==
X-Gm-Message-State: AA+aEWbV5OLEivd8pmCtL7bP1vOKi1kRoeen8Pkp97VD/3qs6OZoiyAT
        tkgq4a+KRUKK4W50L+G2pfdRxDjd5dE=
X-Google-Smtp-Source: AFSGD/XBayz3E1LlUVnxNB3BbZwqktZH89LMKTByG3ZHLhMCyn0/6gNpzIJthbhnSkpAgYrgx43dHw==
X-Received: by 2002:a63:b30f:: with SMTP id i15mr21274639pgf.240.1545265003656;
        Wed, 19 Dec 2018 16:16:43 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id w88sm31617910pfk.11.2018.12.19.16.16.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 16:16:42 -0800 (PST)
Message-ID: <1545265001.185366.496.camel@acm.org>
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date:   Wed, 19 Dec 2018 16:16:41 -0800
In-Reply-To: <74c0280c-e557-ad03-cd75-98dd6d868da3@kernel.dk>
References: <1545261885.185366.488.camel@acm.org>
         <74c0280c-e557-ad03-cd75-98dd6d868da3@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2018-12-19 at 16:27 -0700, Jens Axboe wrote:
+AD4 On 12/19/18 4:24 PM, Bart Van Assche wrote:
+AD4 +AD4 Hello,
+AD4 +AD4 
+AD4 +AD4 If I run the srp blktests in a loop then I see the below call stack appearing
+AD4 +AD4 sporadically. I have not yet had the time to analyze this but I'm reporting
+AD4 +AD4 this here in case someone else would already have had a look at this.
+AD4 +AD4 
+AD4 +AD4 Bart.
+AD4 +AD4 
+AD4 +AD4 +AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0APQA9
+AD4 +AD4 BUG: KASAN: use-after-free in bt+AF8-iter+-0x86/0xf0
+AD4 +AD4 Read of size 8 at addr ffff88803b335240 by task fio/21412
+AD4 +AD4 
+AD4 +AD4 CPU: 0 PID: 21412 Comm: fio Tainted: G        W         4.20.0-rc6-dbg+- +ACM-3
+AD4 +AD4 Hardware name: QEMU Standard PC (i440FX +- PIIX, 1996), BIOS 1.10.2-1 04/01/2014
+AD4 +AD4 Call Trace:
+AD4 +AD4  dump+AF8-stack+-0x86/0xca
+AD4 +AD4  print+AF8-address+AF8-description+-0x71/0x239
+AD4 +AD4  kasan+AF8-report.cold.5+-0x242/0x301
+AD4 +AD4  +AF8AXw-asan+AF8-load8+-0x54/0x90
+AD4 +AD4  bt+AF8-iter+-0x86/0xf0
+AD4 +AD4  blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter+-0x373/0x5e0
+AD4 +AD4  blk+AF8-mq+AF8-in+AF8-flight+-0x96/0xb0
+AD4 +AD4  part+AF8-in+AF8-flight+-0x40/0x140
+AD4 +AD4  part+AF8-round+AF8-stats+-0x18e/0x370
+AD4 +AD4  blk+AF8-account+AF8-io+AF8-start+-0x3d7/0x670
+AD4 +AD4  blk+AF8-mq+AF8-bio+AF8-to+AF8-request+-0x19c/0x3a0
+AD4 +AD4  blk+AF8-mq+AF8-make+AF8-request+-0x7a9/0xcb0
+AD4 +AD4  generic+AF8-make+AF8-request+-0x41d/0x960
+AD4 +AD4  submit+AF8-bio+-0x9b/0x250
+AD4 +AD4  do+AF8-blockdev+AF8-direct+AF8-IO+-0x435c/0x4c70
+AD4 +AD4  +AF8AXw-blockdev+AF8-direct+AF8-IO+-0x79/0x88
+AD4 +AD4  ext4+AF8-direct+AF8-IO+-0x46c/0xc00
+AD4 +AD4  generic+AF8-file+AF8-direct+AF8-write+-0x119/0x210
+AD4 +AD4  +AF8AXw-generic+AF8-file+AF8-write+AF8-iter+-0x11c/0x280
+AD4 +AD4  ext4+AF8-file+AF8-write+AF8-iter+-0x1b8/0x6f0
+AD4 +AD4  aio+AF8-write+-0x204/0x310
+AD4 +AD4  io+AF8-submit+AF8-one+-0x9d3/0xe80
+AD4 +AD4  +AF8AXw-x64+AF8-sys+AF8-io+AF8-submit+-0x115/0x340
+AD4 +AD4  do+AF8-syscall+AF8-64+-0x71/0x210
+AD4 +AD4  entry+AF8-SYSCALL+AF8-64+AF8-after+AF8-hwframe+-0x49/0xbe
+AD4 +AD4 RIP: 0033:0x7f02cf043219
+AD4 
+AD4 I've seen this one before as well, it's not a new thing. As far as I can
+AD4 tell, it's a false positive. There should be no possibility for a
+AD4 use-after-free iterating the static tags/requests.

Are you sure this is a false positive? I have not yet encountered any false
positive KASAN complaints. According to the following gdb output this complaint
refers to reading rq-+AD4-q:

(gdb) list +ACo(bt+AF8-iter+-0x86)
0xffffffff816b9346 is in bt+AF8-iter (block/blk-mq-tag.c:237).
232
233             /+ACo
234              +ACo We can hit rq +AD0APQ NULL here, because the tagging functions
235              +ACo test and set the bit before assigning -+AD4-rqs+AFsAXQ.
236              +ACo-/
237             if (rq +ACYAJg rq-+AD4-q +AD0APQ hctx-+AD4-queue)
238                     iter+AF8-data-+AD4-fn(hctx, rq, iter+AF8-data-+AD4-data, reserved)+ADs
239             return true+ADs
240     +AH0
241

From the disassembly output:

232
233             /+ACo
234              +ACo We can hit rq +AD0APQ NULL here, because the tagging functions
235              +ACo test and set the bit before assigning -+AD4-rqs+AFsAXQ.
236              +ACo-/
237             if (rq +ACYAJg rq-+AD4-q +AD0APQ hctx-+AD4-queue)
   0xffffffff816b9339 +ADwAKw-121+AD4:   test   +ACU-r12,+ACU-r12
   0xffffffff816b933c +ADwAKw-124+AD4:   je     0xffffffff816b935f +ADw-bt+AF8-iter+-159+AD4
   0xffffffff816b933e +ADwAKw-126+AD4:   mov    +ACU-r12,+ACU-rdi
   0xffffffff816b9341 +ADwAKw-129+AD4:   callq  0xffffffff813bd3e0 +ADwAXwBf-asan+AF8-load8+AD4
   0xffffffff816b9346 +ADwAKw-134+AD4:   lea    0x138(+ACU-r13),+ACU-rdi
   0xffffffff816b934d +ADwAKw-141+AD4:   mov    (+ACU-r12),+ACU-r14
   0xffffffff816b9351 +ADwAKw-145+AD4:   callq  0xffffffff813bd3e0 +ADwAXwBf-asan+AF8-load8+AD4
   0xffffffff816b9356 +ADwAKw-150+AD4:   cmp    0x138(+ACU-r13),+ACU-r14
   0xffffffff816b935d +ADwAKw-157+AD4:   je     0xffffffff816b936f +ADw-bt+AF8-iter+-175+AD4

BTW, rq may but does not have to refer to tags-+AD4-static+AF8-rqs+AFs...+AF0. It may also
refer to hctx-+AD4-fq.flush+AF8-rq.

Bart.

