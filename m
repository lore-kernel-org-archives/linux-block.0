Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9E6C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 15:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF0B206B7
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 15:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfDCPZ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:25:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38907 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCPZ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 11:25:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so8501826pgl.5;
        Wed, 03 Apr 2019 08:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hwG/2rIwOprS7Qml3CdqWTLYp2FHA3Z2R1freTcl9XA=;
        b=WpihWzHyFRnnOUU/1RdQP1Dpo6r3/ledbj4J4PwoHn19+pItnwuJ45tr0g18hh+MZv
         2anB5bjAghbOBtdWfy17PDgnXoh+bwi0ACWI5eWaEq1Tpp3rY6KKT31/NJvCjIPCo3CK
         eUrPgIIGMFIXlB9qiKa553uYC3e9tXJDkcBgn0HlcfKO+HbkUfrstot3bmA+qc18IThi
         kLcxiBgcWp3H7kFEcDHPhfoSmcmmXrH2mgWhEUSt7aDO+HUwlrmLkMORFYLhbOsDcyX+
         hsZOW4fOKvmbTV28oPhSGhUV50vVjvxwJy1t0MTEjvp0v5NsV6kEbHRwevHr2evgDEhQ
         rTFw==
X-Gm-Message-State: APjAAAX+qV69YeADUtl7Nt28ukeW+9zKxogUlBT/tD86CUOaGbcubwCO
        15zL4afddY90Pa8T8Xzz5IQ=
X-Google-Smtp-Source: APXvYqzGwb7yWPL22+oVpsQKnGnvJ7lBk1VAx7DGXMRJq5YRB9DqSFMkHlcV5v89kmRyAmR9Z7jplA==
X-Received: by 2002:a63:3fc3:: with SMTP id m186mr228502pga.151.1554305158248;
        Wed, 03 Apr 2019 08:25:58 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 10sm24090611pft.83.2019.04.03.08.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 08:25:57 -0700 (PDT)
Message-ID: <1554305156.118779.186.camel@acm.org>
Subject: Re: [PATCH V3 5/6] block: don't drain in-progress dispatch in
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
Date:   Wed, 03 Apr 2019 08:25:56 -0700
In-Reply-To: <20190403102609.18707-6-ming.lei@redhat.com>
References: <20190403102609.18707-1-ming.lei@redhat.com>
         <20190403102609.18707-6-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-04-03 at 18:26 +-0800, Ming Lei wrote:
+AD4 Now freeing hw queue resource is moved to hctx's release handler,
+AD4 we don't need to worry about the race between blk+AF8-cleanup+AF8-queue and
+AD4 run queue any more.
+AD4 
+AD4 So don't drain in-progress dispatch in blk+AF8-cleanup+AF8-queue().
+AD4 
+AD4 This is basically revert of c2856ae2f315 (+ACI-blk-mq: quiesce queue before
+AD4 freeing queue+ACI).

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4


