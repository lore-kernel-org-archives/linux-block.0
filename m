Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00683C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 16:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92D221841
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 16:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeLRQP6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:15:58 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41713 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbeLRQP5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 11:15:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so8024373plm.8;
        Tue, 18 Dec 2018 08:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WPq4ZGelhHih3IXdFg4Jm7TjdQm4pFOd1fa0f6AW+sI=;
        b=D/tkdM5mgOUsmi7SInVPU8x0NPVlIiMATWypdXvWOt8qIX0LKb7IrHlHm0gU7iJe6S
         71KdkvWATLE8/TwigRfjoJEaLfFAxhZANnhmMp6G9yTEwLJFy+GBQimEGO458+rqHIb5
         zzj4cbU/5VTJ+s7emI4llQmOi8hrdahlux7XrSuIlO3TouVlvUlFgnslZJHnSoJhzPrZ
         KBvX25n6m3ic937zTVizPgHWV/03usngzM9sB0zlCKSaPAQbGIGUxZDPQvoNuiHEcgyU
         n/EH85pxJmDi1o2vwU8lnAyCiZlZvC2rO8JG2IlyM4Xc1GeWg0Mb++qMqXBqZL/QCrfz
         qqJg==
X-Gm-Message-State: AA+aEWYzOQmr1O9LWoG9NvvMFPzmrdO/U+dhMNrqJflEl0ms7C3BpH37
        VUm5ebGtc0izcpKP6SeE2ko=
X-Google-Smtp-Source: AFSGD/W5P+Q+VyMRAI2M/AmHvYYPFg5oHy+Hz5+DeMphu2cZV1BqgQ9tdYAHReJi62lUAhoImZ+TQQ==
X-Received: by 2002:a17:902:24e7:: with SMTP id l36mr17011395plg.61.1545149756781;
        Tue, 18 Dec 2018 08:15:56 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id f20sm19330450pfn.177.2018.12.18.08.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 08:15:56 -0800 (PST)
Message-ID: <1545149754.185366.449.camel@acm.org>
Subject: Re: [PATCH V2] blk-mq: Set request mapping to NULL in
 blk_mq_put_driver_tag
From:   Bart Van Assche <bvanassche@acm.org>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-scsi <linux-scsi@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>
Date:   Tue, 18 Dec 2018 08:15:54 -0800
In-Reply-To: <CAHsXFKHSjBHZy9tyhdEjYJcLJeE6SqdeBPcoeq=bCaRfzvMqgw@mail.gmail.com>
References: <CAHsXFKHSjBHZy9tyhdEjYJcLJeE6SqdeBPcoeq=bCaRfzvMqgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2018-12-18 at 12:38 +-0530, Kashyap Desai wrote:
+AD4 V1 -+AD4 V2
+AD4 Added fix in +AF8AXw-blk+AF8-mq+AF8-finish+AF8-request around blk+AF8-mq+AF8-put+AF8-tag() for
+AD4 non-internal tags
+AD4 
+AD4 Problem statement :
+AD4 Whenever try to get outstanding request via scsi+AF8-host+AF8-find+AF8-tag,
+AD4 block layer will return stale entries instead of actual outstanding
+AD4 request. Kernel panic if stale entry is inaccessible or memory is reused.
+AD4 Fix :
+AD4 Undo request mapping in blk+AF8-mq+AF8-put+AF8-driver+AF8-tag  nce request is return.
+AD4 
+AD4 More detail :
+AD4 Whenever each SDEV entry is created, block layer allocate separate tags
+AD4 and static requestis.Those requests are not valid after SDEV is deleted
+AD4 from the system. On the fly, block layer maps static rqs to rqs as below
+AD4 from blk+AF8-mq+AF8-get+AF8-driver+AF8-tag()
+AD4 
+AD4 data.hctx-+AD4-tags-+AD4-rqs+AFs-rq-+AD4-tag+AF0 +AD0 rq+ADs
+AD4 
+AD4 Above mapping is active in-used requests and it is the same mapping which
+AD4 is referred in function scsi+AF8-host+AF8-find+AF8-tag().
+AD4 After running some IOs, +IBw-data.hctx-+AD4-tags-+AD4-rqs+AFs-rq-+AD4-tag+AF0gHQ will have some
+AD4 entries which will never be reset in block layer.
+AD4 
+AD4 There would be a kernel panic, If request pointing to
+AD4 +IBw-data.hctx-+AD4-tags-+AD4-rqs+AFs-rq-+AD4-tag+AF0gHQ is part of +IBw-sdev+IB0 which is removed
+AD4 and as part of that all the memory allocation of request associated with
+AD4 that sdev might be reused or inaccessible to the driver.
+AD4 Kernel panic snippet -
+AD4 
+AD4 BUG: unable to handle kernel paging request at ffffff8000000010
+AD4 IP: +AFsAPA-ffffffffc048306c+AD4AXQ mpt3sas+AF8-scsih+AF8-scsi+AF8-lookup+AF8-get+-0x6c/0xc0 +AFs-mpt3sas+AF0
+AD4 PGD aa4414067 PUD 0
+AD4 Oops: 0000 +AFsAIw-1+AF0 SMP
+AD4 Call Trace:
+AD4  +AFsAPA-ffffffffc046f72f+AD4AXQ mpt3sas+AF8-get+AF8-st+AF8-from+AF8-smid+-0x1f/0x60 +AFs-mpt3sas+AF0
+AD4  +AFsAPA-ffffffffc047e125+AD4AXQ scsih+AF8-shutdown+-0x55/0x100 +AFs-mpt3sas+AF0

Other block drivers (e.g. ib+AF8-srp, skd) do not need this to work reliably.
It has been explained to you that the bug that you reported can be fixed
by modifying the mpt3sas driver. So why to fix this by modifying the block
layer? Additionally, what prevents that a race condition occurs between
the block layer clearing hctx-+AD4-tags-+AD4-rqs+AFs-rq-+AD4-tag+AF0 and scsi+AF8-host+AF8-find+AF8-tag()
reading that same array element? I'm afraid that this is an attempt to
paper over a real problem instead of fixing the root cause.

Bart.
