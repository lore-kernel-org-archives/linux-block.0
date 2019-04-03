Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52691C10F0B
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 16:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FBA20663
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 16:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfDCQ0f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:26:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40665 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCQ0f (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 12:26:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so8411987pfc.7;
        Wed, 03 Apr 2019 09:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FQ2FZk5IG+AD0Q5tHsFtTpgNUUZYrC93YpSdhU4ZCtE=;
        b=FE0zeaTX+GWRZSt7KpI1esOe1e2kSRFGA7KeE36F3SyfHvkajfDN8khB3j4v/6pvnz
         /AQghb17drdj2BMQjpIjn6e+Alfw5bWS755gp2VhDGIf52+exS1e7nNVOD5iAQCdDJlG
         XPtlyWYiXEgeGgDd4ctR4RI45u4d5lm0saeWm5H7PbNMWdiyjfYWaBxLi1wMY5xasZvO
         5nGPYmjQdx/0IqKDJbx1R4ejZCt+3vt6vzKPgfbCkA10rEDlkagVeSNR5HIyOgRGKBB8
         QOzj3NncDpdCRJ26THYcZKnqgLN3zGk8JcVJ4Q868BTO+M9ObjCstZo6Ex6JWZDvvHYI
         UDyw==
X-Gm-Message-State: APjAAAWX6xXqH25PW6f0+V5+Phr3GNNyy0ZqWYKOSmQO/Qll5MW+T9Sd
        yY8G0OzP20DKIEW2CH2cCpo=
X-Google-Smtp-Source: APXvYqwlWGlXxR9TdP29lW5mU+V7jXyLPCZ/L7iarPV0YVnQRu/f42Iy0H80esbqWDeb7Wz2HsJcNg==
X-Received: by 2002:a63:cc0d:: with SMTP id x13mr598158pgf.280.1554308794220;
        Wed, 03 Apr 2019 09:26:34 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id s16sm27867948pgo.69.2019.04.03.09.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 09:26:33 -0700 (PDT)
Message-ID: <1554308792.118779.221.camel@acm.org>
Subject: Re: [PATCH V3 3/6] blk-mq: free hw queue's resource in hctx's
 release handler
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
        jianchao wang <jianchao.w.wang@oracle.com>,
        stable@vger.kernel.org
Date:   Wed, 03 Apr 2019 09:26:32 -0700
In-Reply-To: <20190403102609.18707-4-ming.lei@redhat.com>
References: <20190403102609.18707-1-ming.lei@redhat.com>
         <20190403102609.18707-4-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-04-03 at 18:26 +-0800, Ming Lei wrote:
+AD4 diff --git a/block/blk-core.c b/block/blk-core.c
+AD4 index 6583d67f3e34..20298aa5a77c 100644
+AD4 --- a/block/blk-core.c
+AD4 +-+-+- b/block/blk-core.c
+AD4 +AEAAQA -374,7 +-374,7 +AEAAQA void blk+AF8-cleanup+AF8-queue(struct request+AF8-queue +ACo-q)
+AD4         blk+AF8-exit+AF8-queue(q)+ADs
+AD4  
+AD4         if (queue+AF8-is+AF8-mq(q))
+AD4 -               blk+AF8-mq+AF8-free+AF8-queue(q)+ADs
+AD4 +-               blk+AF8-mq+AF8-exit+AF8-queue(q)+ADs
+AD4  
+AD4         percpu+AF8-ref+AF8-exit(+ACY-q-+AD4-q+AF8-usage+AF8-counter)+ADs
+AD4  
+AD4 diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
+AD4 index 3f9c3f4ac44c..4040e62c3737 100644
+AD4 --- a/block/blk-mq-sysfs.c
+AD4 +-+-+- b/block/blk-mq-sysfs.c
+AD4 +AEAAQA -10,6 +-10,7 +AEAAQA
+AD4  +ACM-include +ADw-linux/smp.h+AD4
+AD4  
+AD4  +ACM-include +ADw-linux/blk-mq.h+AD4
+AD4 +-+ACM-include +ACI-blk.h+ACI
+AD4  +ACM-include +ACI-blk-mq.h+ACI
+AD4  +ACM-include +ACI-blk-mq-tag.h+ACI
+AD4  
+AD4 +AEAAQA -33,6 +-34,11 +AEAAQA static void blk+AF8-mq+AF8-hw+AF8-sysfs+AF8-release(struct kobject +ACo-kobj)
+AD4  +AHs
+AD4         struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx +AD0 container+AF8-of(kobj, struct blk+AF8-mq+AF8-hw+AF8-ctx,
+AD4                                                   kobj)+ADs
+AD4 +-
+AD4 +-       if (hctx-+AD4-flags +ACY BLK+AF8-MQ+AF8-F+AF8-BLOCKING)
+AD4 +-               cleanup+AF8-srcu+AF8-struct(hctx-+AD4-srcu)+ADs
+AD4 +-       blk+AF8-free+AF8-flush+AF8-queue(hctx-+AD4-fq)+ADs
+AD4 +-       sbitmap+AF8-free(+ACY-hctx-+AD4-ctx+AF8-map)+ADs
+AD4         free+AF8-cpumask+AF8-var(hctx-+AD4-cpumask)+ADs
+AD4         kfree(hctx-+AD4-ctxs)+ADs
+AD4         kfree(hctx)+ADs
+AD4 diff --git a/block/blk-mq.c b/block/blk-mq.c
+AD4 index b512ba0cb359..afc9912e2e42 100644
+AD4 --- a/block/blk-mq.c
+AD4 +-+-+- b/block/blk-mq.c
+AD4 +AEAAQA -2259,12 +-2259,7 +AEAAQA static void blk+AF8-mq+AF8-exit+AF8-hctx(struct request+AF8-queue +ACo-q,
+AD4         if (set-+AD4-ops-+AD4-exit+AF8-hctx)
+AD4                 set-+AD4-ops-+AD4-exit+AF8-hctx(hctx, hctx+AF8-idx)+ADs
+AD4  
+AD4 -       if (hctx-+AD4-flags +ACY BLK+AF8-MQ+AF8-F+AF8-BLOCKING)
+AD4 -               cleanup+AF8-srcu+AF8-struct(hctx-+AD4-srcu)+ADs
+AD4 -
+AD4         blk+AF8-mq+AF8-remove+AF8-cpuhp(hctx)+ADs
+AD4 -       blk+AF8-free+AF8-flush+AF8-queue(hctx-+AD4-fq)+ADs
+AD4 -       sbitmap+AF8-free(+ACY-hctx-+AD4-ctx+AF8-map)+ADs
+AD4  +AH0
+AD4  
+AD4  static void blk+AF8-mq+AF8-exit+AF8-hw+AF8-queues(struct request+AF8-queue +ACo-q,
+AD4 +AEAAQA -2899,7 +-2894,8 +AEAAQA struct request+AF8-queue +ACo-blk+AF8-mq+AF8-init+AF8-allocated+AF8-queue(struct blk+AF8-mq+AF8-tag+AF8-set +ACo-set,
+AD4  +AH0
+AD4  EXPORT+AF8-SYMBOL(blk+AF8-mq+AF8-init+AF8-allocated+AF8-queue)+ADs
+AD4  
+AD4 -void blk+AF8-mq+AF8-free+AF8-queue(struct request+AF8-queue +ACo-q)
+AD4 +-/+ACo tags can +AF8-not+AF8 be used after returning from blk+AF8-mq+AF8-exit+AF8-queue +ACo-/
+AD4 +-void blk+AF8-mq+AF8-exit+AF8-queue(struct request+AF8-queue +ACo-q)
+AD4  +AHs
+AD4         struct blk+AF8-mq+AF8-tag+AF8-set   +ACo-set +AD0 q-+AD4-tag+AF8-set+ADs
+AD4  
+AD4 diff --git a/block/blk-mq.h b/block/blk-mq.h
+AD4 index d704fc7766f4..c421e3a16e36 100644
+AD4 --- a/block/blk-mq.h
+AD4 +-+-+- b/block/blk-mq.h
+AD4 +AEAAQA -37,7 +-37,7 +AEAAQA struct blk+AF8-mq+AF8-ctx +AHs
+AD4         struct kobject          kobj+ADs
+AD4  +AH0 +AF8AXwBfAF8-cacheline+AF8-aligned+AF8-in+AF8-smp+ADs
+AD4  
+AD4 -void blk+AF8-mq+AF8-free+AF8-queue(struct request+AF8-queue +ACo-q)+ADs
+AD4 +-void blk+AF8-mq+AF8-exit+AF8-queue(struct request+AF8-queue +ACo-q)+ADs
+AD4  int blk+AF8-mq+AF8-update+AF8-nr+AF8-requests(struct request+AF8-queue +ACo-q, unsigned int nr)+ADs
+AD4  void blk+AF8-mq+AF8-wake+AF8-waiters(struct request+AF8-queue +ACo-q)+ADs
+AD4  bool blk+AF8-mq+AF8-dispatch+AF8-rq+AF8-list(struct request+AF8-queue +ACo, struct list+AF8-head +ACo, bool)+ADs

Isn't this an incomplete solution? The above patch fixes the race between
cleaning up a queue and running a queue but does not address the race between
running a queue and changing the number of hardware queues.

Thanks,

Bart.
