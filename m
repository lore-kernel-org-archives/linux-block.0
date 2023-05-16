Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E79C77B75
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 22:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjEPWdk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 18:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjEPWdj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 18:33:39 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6329E6EB3
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:37 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ae3fe67980so2078645ad.3
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684276417; x=1686868417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwyPTOfw7CLhqYC/Hv0uFzhwBy5QE+LBN1Uiqc5OArM=;
        b=FA3x9o8E7yp+W37E/30CyOSyAS24Cx+UnknqP50jtLtbrjYJaR0Gw7NuQq0szj7fh3
         n1rQP/jegd6GWJFHai1Ovbq1P1f0gBYT1e9HkA2irqTU1VdTx6KX5zkxpBO0hIRJUtLr
         SBPawyKMtByN16pm6jC17NPTYkTZiM527rn3eRy4iuZDlKINY6ntbl0a52M40XjYKe5T
         lGa/7k9wcqgQbaeF6kHJ0ttv23hczrXaP6yICT2tAoz4NktKuo2t/uRj5I5F/mfXPcGf
         EkMl2MLZH9zy9QWjc0UvX1DME0FKEiPNKFRZFAUxeLnOfoNB81L+VpijxggWpV1YnnC8
         wVNw==
X-Gm-Message-State: AC+VfDyTtD7iptQsridR5MA3jSTy5RpbRHSqpEooadopeiYF4zG0AIfb
        Cofl5fiDOV6XhCoguS1ZvoE=
X-Google-Smtp-Source: ACHHUZ5gZwV9UXtEGen9F3KbVsj/mGSpUON0h12rpHEowTIbm0HpDFWkWry96yyAor4HVwOKBdlpKg==
X-Received: by 2002:a17:902:9897:b0:1ab:253e:6906 with SMTP id s23-20020a170902989700b001ab253e6906mr36360906plp.67.1684276416752;
        Tue, 16 May 2023 15:33:36 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:baed:ee38:35e4:f97d])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b001ae48d441desm839255pln.148.2023.05.16.15.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:33:36 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v5 07/11] block: mq-deadline: Improve deadline_skip_seq_writes()
Date:   Tue, 16 May 2023 15:33:16 -0700
Message-ID: <20230516223323.1383342-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230516223323.1383342-1-bvanassche@acm.org>
References: <20230516223323.1383342-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make deadline_skip_seq_writes() do what its name suggests, namely to
skip sequential writes.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 6276afede9cd..dbc0feca963e 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -308,7 +308,7 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
 	do {
 		pos += blk_rq_sectors(rq);
 		rq = deadline_latter_request(rq);
-	} while (rq && blk_rq_pos(rq) == pos);
+	} while (rq && blk_rq_pos(rq) == pos && blk_rq_is_seq_zoned_write(rq));
 
 	return rq;
 }
