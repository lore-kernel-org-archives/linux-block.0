Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B50DC77B75
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 17:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjEQRpg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 13:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjEQRpd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 13:45:33 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68251D069
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:45:01 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-643557840e4so1118723b3a.2
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684345480; x=1686937480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDnGikLOYG1t6apzhUnxcr96a3tR4AhATdhtBeyLLBM=;
        b=cRVPa2Uv1ICZsHSL1nw3pU08r4aSrtsZVxOC6N4OjDpsUf0LqwrdxF436l8az5b/mV
         Rglqj43yWtoUSVi+vs6uZMJvq86ecRlXN69p6kaV6pMKGBK4pSngjO8hQds+6RiKnJu2
         fPhpcPnZyH3lTkvNIGLDesnZYzeE72n5b4SIm9Fqdfn8T1hwYkVWSypwQ6PpPoY7DMLt
         ve6M2Qqbm8vz5txyfz+Jo1obUFGUPrSlQmY+7Q/yRTOGl+78x2miLeeR9DIfbWfkixK6
         +MOsfd/X1yqtRl7S0QbIzS9KuUDDXCrCfR2WV0aRf6MOCONF8QVnUElbLphzrPJsaAxe
         PqdQ==
X-Gm-Message-State: AC+VfDz1evNwpz97g6K0gnn+X4WaM7auloOcaE2e9Q2OclitfS6WJre0
        9+tUkPsmBf0cyfa34xHWg3c=
X-Google-Smtp-Source: ACHHUZ71Yh2gf5KlY7qdUaaDvSPaWfp7f6W1Nl4kXB8zp5P1K+fqUs37Ow0Mybx6UcgVZxu6YEiogw==
X-Received: by 2002:a05:6a00:1a89:b0:62d:d045:392 with SMTP id e9-20020a056a001a8900b0062dd0450392mr498191pfv.32.1684345480348;
        Wed, 17 May 2023 10:44:40 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d22-20020aa78e56000000b00646e7d2b5a7sm15334410pfr.112.2023.05.17.10.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:44:39 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v6 07/11] block: mq-deadline: Simplify deadline_skip_seq_writes()
Date:   Wed, 17 May 2023 10:42:25 -0700
Message-ID: <20230517174230.897144-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230517174230.897144-1-bvanassche@acm.org>
References: <20230517174230.897144-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make the deadline_skip_seq_writes() code shorter without changing its
functionality.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index cea91ba4a6ea..56782ee93522 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -304,14 +304,11 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
 						struct request *rq)
 {
 	sector_t pos = blk_rq_pos(rq);
-	sector_t skipped_sectors = 0;
 
-	while (rq) {
-		if (blk_rq_pos(rq) != pos + skipped_sectors)
-			break;
-		skipped_sectors += blk_rq_sectors(rq);
+	do {
+		pos += blk_rq_sectors(rq);
 		rq = deadline_latter_request(rq);
-	}
+	} while (rq && blk_rq_pos(rq) == pos);
 
 	return rq;
 }
