Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED6CC43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 15:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F25208E4
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 15:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfDAPPD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:15:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46738 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfDAPPD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Apr 2019 11:15:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id y6so4636601pll.13;
        Mon, 01 Apr 2019 08:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AIRhixesr2nYIBWP0RtlIR90tBEm7g07dp6hjtKGYv0=;
        b=mcxB1RpQfqucwi+xX5tRqyz0QjrtdORVqY/RYPjEviqruYIC06Lay3E0HnZyC+CU20
         yPg2QV4ZdC4ls060HqxDCpHn01n3iasEuUx3YuoUCp54FUbScEXz5dx4ZLDda6ygjeb/
         +2/bQl16kup2hPvcvx5CQYhox5TgUnKVM2jNcXXMnQxstsQTkcjJBlftMVpHsW2Zo/TX
         +XNb+Yp7ELobHH6S2Lksl4QvElKwDmMqZbTowq06Q/nO99ImeOFaCjw8tHMjNP7/kUO3
         ei1u22tXtVvzsurLgDpxR8oG5kBfhzAUf0m+hNJ1yRvHhWyJxxzaYHlt20T2f2v8LJtl
         kn0w==
X-Gm-Message-State: APjAAAUQD1rXYmiut/wWp2okpwd0KDtyUeTHIR7beaFBwAwApFXnblFx
        z3SwRnc13wt0X8ivd4+0pX7Y3zq6
X-Google-Smtp-Source: APXvYqxY3FZCzoBInlJD+DZuw7uVo4aEOXM3pzHAB4ND4e2121JxgGvCxE7SR/jnhN8ObKBbPi3vvw==
X-Received: by 2002:a17:902:694c:: with SMTP id k12mr2225994plt.149.1554131702468;
        Mon, 01 Apr 2019 08:15:02 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id p6sm1436626pfd.122.2019.04.01.08.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 08:15:01 -0700 (PDT)
Message-ID: <1554131699.118779.119.camel@acm.org>
Subject: Re: [PATCH V2 2/3] block: don't drain in-progress dispatch in
 blk_cleanup_queue()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Date:   Mon, 01 Apr 2019 08:14:59 -0700
In-Reply-To: <20190401044247.29881-3-ming.lei@redhat.com>
References: <20190401044247.29881-1-ming.lei@redhat.com>
         <20190401044247.29881-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-04-01 at 12:42 +-0800, Ming Lei wrote:
+AD4 Now freeing hw queue resource is moved to hctx's release handler,
+AD4 we don't need to worry about the race between blk+AF8-cleanup+AF8-queue and
+AD4 run queue any more.
+AD4 
+AD4 So don't drain in-progress dispatch in blk+AF8-cleanup+AF8-queue().
+AD4 
+AD4 This is basically revert of c2856ae2f315 (+ACI-blk-mq: quiesce queue before
+AD4 freeing queue+ACI).
+AD4 
+AD4 Cc: Dongli Zhang +ADw-dongli.zhang+AEA-oracle.com+AD4
+AD4 Cc: James Smart +ADw-james.smart+AEA-broadcom.com+AD4
+AD4 Cc: Bart Van Assche +ADw-bart.vanassche+AEA-wdc.com+AD4
+AD4 Cc: linux-scsi+AEA-vger.kernel.org,
+AD4 Cc: Martin K . Petersen +ADw-martin.petersen+AEA-oracle.com+AD4,
+AD4 Cc: Christoph Hellwig +ADw-hch+AEA-lst.de+AD4,
+AD4 Cc: James E . J . Bottomley +ADw-jejb+AEA-linux.vnet.ibm.com+AD4,
+AD4 Cc: jianchao wang +ADw-jianchao.w.wang+AEA-oracle.com+AD4
+AD4 Signed-off-by: Ming Lei +ADw-ming.lei+AEA-redhat.com+AD4
+AD4 ---
+AD4  block/blk-core.c +AHw 12 ------------
+AD4  1 file changed, 12 deletions(-)
+AD4
+AD4 diff --git a/block/blk-core.c b/block/blk-core.c
+AD4 index b3bbf8a5110d..491dc0295778 100644
+AD4 --- a/block/blk-core.c
+AD4 +-+-+- b/block/blk-core.c
+AD4 +AEAAQA -347,18 +-347,6 +AEAAQA void blk+AF8-cleanup+AF8-queue(struct request+AF8-queue +ACo-q)
+AD4  
+AD4         blk+AF8-queue+AF8-flag+AF8-set(QUEUE+AF8-FLAG+AF8-DEAD, q)+ADs
+AD4  
+AD4 -       /+ACo
+AD4 -        +ACo make sure all in-progress dispatch are completed because
+AD4 -        +ACo blk+AF8-freeze+AF8-queue() can only complete all requests, and
+AD4 -        +ACo dispatch may still be in-progress since we dispatch requests
+AD4 -        +ACo from more than one contexts.
+AD4 -        +ACo
+AD4 -        +ACo We rely on driver to deal with the race in case that queue
+AD4 -        +ACo initialization isn't done.
+AD4 -        +ACo-/
+AD4 -       if (queue+AF8-is+AF8-mq(q) +ACYAJg blk+AF8-queue+AF8-init+AF8-done(q))
+AD4 -               blk+AF8-mq+AF8-quiesce+AF8-queue(q)+ADs
+AD4 -
+AD4         /+ACo for synchronous bio-based driver finish in-flight integrity i/o +ACo-/
+AD4         blk+AF8-flush+AF8-integrity()+ADs

Many block drivers clean up resources immediately after blk+AF8-cleanup+AF8-queue()
returns. Not waiting for ongoing .queue+AF8-rq() calls to finish is wrong because
it can cause block drivers to destroy resources that are in use by a concurrent
.queue+AF8-rq() call.

Bart.
