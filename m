Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64BEC10F03
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 15:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A223320850
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 15:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfCSPGw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:06:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37655 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfCSPGv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Mar 2019 11:06:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id q206so14052218pgq.4
        for <linux-block@vger.kernel.org>; Tue, 19 Mar 2019 08:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HFGBCFuimTcULWKnPVbc+f1hSxevFMnlvZzbx8ZgI9Y=;
        b=LIFQ4kxJ2bzWJiirC1xZ8isFHxJyQAolRy9a0QLbbEAm6XG73fm5x2eudb2pL8CKwx
         5GPeHqJxyqebpFSJIsMu2LQya9k+nTCUZ2b9lcf1CNVk6Fycx8p6ewBdB83Od0FtQsAV
         JKnka/R6iebvKoWsdibNqExx26QzTv7g2pCHETHs7G2qDXE+cFVLwtgJk4rZ3xdXRvys
         7BNHW4W6PIX/jGVni/YCMeWO9/DF980ztfZUA+9IZBwxuEAwvyot45MPWiy1zh2ePNU5
         tRHivSxfzTbnJP6Kgx36yqYnm36s2lUh0+QubWzQeUPgejLJQ/LFsYW22wthivL1tRuW
         ioAw==
X-Gm-Message-State: APjAAAUh0E1CqDfnRI2zktgXXyowaH2hWMY6G5gfb0ww9rZ5j8RO1S4w
        YykrfhuG0H53yCWCLVRGIa8=
X-Google-Smtp-Source: APXvYqxx5YQ/YusK5i5rsLy3yHrDWivFIb1dHwRr1FN5sb5f+Z563g05oUYcHEbBfg+SWnl7hd1F/g==
X-Received: by 2002:a65:6383:: with SMTP id h3mr2336805pgv.11.1553008010601;
        Tue, 19 Mar 2019 08:06:50 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id l5sm24812780pfi.97.2019.03.19.08.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 08:06:49 -0700 (PDT)
Message-ID: <1553008008.152266.42.camel@acm.org>
Subject: Re: [PATCH V2] sbitmap: order READ/WRITE freed instance and setting
 clear bit
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>
Date:   Tue, 19 Mar 2019 08:06:48 -0700
In-Reply-To: <20190319083842.30059-1-ming.lei@redhat.com>
References: <20190319083842.30059-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-03-19 at 16:38 +-0800, Ming Lei wrote:
+AD4 Inside sbitmap+AF8-queue+AF8-clear(), once the clear bit is set, it will be
+AD4 visiable to allocation path immediately. Meantime READ/WRITE on old
+AD4 associated instance(such as request in case of blk-mq) may be
+AD4 out-of-order with the setting clear bit, so race with re-allocation
+AD4 may be triggered.
+AD4 
+AD4 Adds one memory barrier for ordering READ/WRITE of the freed associated
+AD4 instance with setting clear bit for avoiding race with re-allocation.
+AD4 
+AD4 The following kernel oops triggerd by block/006 on aarch64 may be fixed:
                                                             +AF4AXgBe

Does that mean that it has not been verified whether this patch fixes the
NULL pointer issue mentioned in the patch description?

+AD4 diff --git a/lib/sbitmap.c b/lib/sbitmap.c
+AD4 index 5b382c1244ed..941a46495e12 100644
+AD4 --- a/lib/sbitmap.c
+AD4 +-+-+- b/lib/sbitmap.c
+AD4 +AEAAQA -591,6 +-591,17 +AEAAQA EXPORT+AF8-SYMBOL+AF8-GPL(sbitmap+AF8-queue+AF8-wake+AF8-up)+ADs
+AD4  void sbitmap+AF8-queue+AF8-clear(struct sbitmap+AF8-queue +ACo-sbq, unsigned int nr,
+AD4                          unsigned int cpu)
+AD4  +AHs
+AD4 +-       /+ACo
+AD4 +-        +ACo Once the clear bit is set, the bit may be allocated out.
             +AF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4

This comment is confusing. Did you perhaps mean +ACI-Once the bit is cleared+ACI?

+AD4 +-        +ACo
+AD4 +-        +ACo Orders READ/WRITE on the asssociated instance(such as request
+AD4 +-        +ACo of blk+AF8-mq) by this bit for avoiding race with re-allocation,
+AD4 +-        +ACo and its pair is the memory barrier implied in +AF8AXw-sbitmap+AF8-get+AF8-word.
+AD4 +-        +ACo
+AD4 +-        +ACo One invarient is that the clear bit has to be zero when the bit
                 +AF4AXgBeAF4AXgBeAF4AXgBe             +AF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4
                 invariant?            I cant' make sense of this.
+AD4 +-        +ACo is in use.
+AD4 +-        +ACo-/
+AD4 +-       smp+AF8-mb+AF8AXw-before+AF8-atomic()+ADs
+AD4         sbitmap+AF8-deferred+AF8-clear+AF8-bit(+ACY-sbq-+AD4-sb, nr)+ADs

Thanks,

Bart.
