Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7923BC4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 16:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340E220700
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 16:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfDCQTQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:19:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33542 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCQTQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 12:19:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so6403689plo.0;
        Wed, 03 Apr 2019 09:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WD7gCDJzi8Y/ZdkVA2BEwYkfpHo3aqVgZJrbQ6DHVhk=;
        b=Co4RHwtsiUJVvz4mrjY64W/NyDUxmCZOdVLCpUQrx1gvtvTwddd4lDrc9kyxAM1Eqp
         I/vd3EW4oYSaEKuEuLSy2ZnI48eJTyzzbwa5x3+n934ZX/yNYOw4qxoFpjoCBxkpBMJH
         GIEE2Y0jqmwdnVbzYFw1dudOIRJLdMXoz4gsPHib5FQMKNJDVqCotHJbABzU2Bnr12vd
         ttLjA77lQVRtQ5nhB2aeHtkGzw5qBBAzP4gz8VFgqyb+2ppvT9mmcanvFk/pVKp65wfL
         8CZQ94kn6rHtfEw7dEAsbkZXy6QUFk5u315Pnd6U1/ZjLBC0qOjCtOvHuWwjDAIIUjOx
         mN9Q==
X-Gm-Message-State: APjAAAXgAVhenkenuyBekLUEwJrHq/XvD9oKPrtraj05ssVoaE8jBD07
        hrJK1QHO/REFTlo89lX+vHo=
X-Google-Smtp-Source: APXvYqyHvilBCLmH2Nu5cdXy05gM07Wlmrh9a7CUJpuExiDsILR6/cZyM4rlmVQI4rzkQapaINdPuQ==
X-Received: by 2002:a17:902:5c5:: with SMTP id f63mr859303plf.64.1554308355541;
        Wed, 03 Apr 2019 09:19:15 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id z14sm26080453pfn.161.2019.04.03.09.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 09:19:14 -0700 (PDT)
Message-ID: <1554308353.118779.216.camel@acm.org>
Subject: Re: [PATCH V3 2/6] blk-mq: move cancel of requeue_work into
 blk_mq_release
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
Date:   Wed, 03 Apr 2019 09:19:13 -0700
In-Reply-To: <20190403102609.18707-3-ming.lei@redhat.com>
References: <20190403102609.18707-1-ming.lei@redhat.com>
         <20190403102609.18707-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-04-03 at 18:26 +-0800, Ming Lei wrote:
+AD4 with holding queue's kobject refcount, it is safe for driver
+AD4 to schedule requeue. However, blk+AF8-mq+AF8-kick+AF8-requeue+AF8-list() may
+AD4 be called after blk+AF8-sync+AF8-queue() is done because of concurrent
+AD4 requeue activities, then requeue work may not be completed when
+AD4 freeing queue, and kernel oops is triggered.
+AD4 
+AD4 So moving the cancel of requeue+AF8-work into blk+AF8-mq+AF8-release() for
+AD4 avoiding race between requeue and freeing queue.
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
+AD4
+AD4  block/blk-core.c +AHw 1 -
+AD4  block/blk-mq.c   +AHw 2 +-+-
+AD4  2 files changed, 2 insertions(+-), 1 deletion(-)
+AD4 
+AD4 diff --git a/block/blk-core.c b/block/blk-core.c
+AD4 index 4673ebe42255..6583d67f3e34 100644
+AD4 --- a/block/blk-core.c
+AD4 +-+-+- b/block/blk-core.c
+AD4 +AEAAQA -237,7 +-237,6 +AEAAQA void blk+AF8-sync+AF8-queue(struct request+AF8-queue +ACo-q)
+AD4                 struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx+ADs
+AD4                 int i+ADs
+AD4  
+AD4 -               cancel+AF8-delayed+AF8-work+AF8-sync(+ACY-q-+AD4-requeue+AF8-work)+ADs
+AD4                 queue+AF8-for+AF8-each+AF8-hw+AF8-ctx(q, hctx, i)
+AD4                         cancel+AF8-delayed+AF8-work+AF8-sync(+ACY-hctx-+AD4-run+AF8-work)+ADs
+AD4         +AH0
+AD4 diff --git a/block/blk-mq.c b/block/blk-mq.c
+AD4 index 5b586affee09..b512ba0cb359 100644
+AD4 --- a/block/blk-mq.c
+AD4 +-+-+- b/block/blk-mq.c
+AD4 +AEAAQA -2626,6 +-2626,8 +AEAAQA void blk+AF8-mq+AF8-release(struct request+AF8-queue +ACo-q)
+AD4         struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx+ADs
+AD4         unsigned int i+ADs
+AD4  
+AD4 +-       cancel+AF8-delayed+AF8-work+AF8-sync(+ACY-q-+AD4-requeue+AF8-work)+ADs
+AD4 +-
+AD4         /+ACo hctx kobj stays in hctx +ACo-/
+AD4         queue+AF8-for+AF8-each+AF8-hw+AF8-ctx(q, hctx, i) +AHs
+AD4                 if (+ACE-hctx)

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4-
