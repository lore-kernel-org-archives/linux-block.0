Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3466EC761A6
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 00:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjDGARb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 20:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238199AbjDGAR1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 20:17:27 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64CF93EB
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 17:17:25 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id l7so38620589pjg.5
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 17:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680826645; x=1683418645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXMoxgLDo4dyjVXptXOnmrqXR6FziNMll+I0AUUU5Fg=;
        b=zlVej3lBK7/WEsGHzo/9I1Q+JhK7Xudm+MLLfNrJtqdYOHgE7Gs7QZSruDZQlOVgw4
         tenrckcw2YmvYsJAiwJIKFVRMGvWe0XH3NygpSLKZ84d6sMAG1OYIbEaAv/ZF5u24/yZ
         zvBqJ8Zega03Gl8WvLrf6dS27hmNSXY3iglZAVYp4E8uPpLuNC9X6iTN7v7MIEJomivN
         k6LF552tPcz3cTTx5PwpaLqX7bUsoyCxk+fbqnLbveou42dblKjgJ2vAq88a6TgLd9Kr
         lGBd9OWddKzrGjcQnpLYlZD0IhHwISgKrOplF/Bs6DFkU4GimMBeqm6eNRa7eVrD9XvH
         jCJA==
X-Gm-Message-State: AAQBX9eBzzxiBBUoFECgUEkhRYoMgZJ1XEQEddf6FCwS8pFG6RI6DE0N
        cHQEYVP3G96VULHZHQo4SJo=
X-Google-Smtp-Source: AKy350Z8LMBBLwqFPGFbt0H7yoeE82UNDUt0VF3gsd0BZXSUDQFxNrpwmfBK68vLQlFr/IB7n/MiLw==
X-Received: by 2002:a17:902:f552:b0:1a0:6bd4:ea9a with SMTP id h18-20020a170902f55200b001a06bd4ea9amr8089231plf.16.1680826645076;
        Thu, 06 Apr 2023 17:17:25 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709028ec900b0019a773419a6sm1873676plo.170.2023.04.06.17.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 17:17:24 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 08/12] block: mq-deadline: Simplify deadline_skip_seq_writes()
Date:   Thu,  6 Apr 2023 17:17:06 -0700
Message-Id: <20230407001710.104169-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407001710.104169-1-bvanassche@acm.org>
References: <20230407001710.104169-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make deadline_skip_seq_writes() shorter without changing its
functionality.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index d885ccf49170..50a9d3b0a291 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -312,12 +312,9 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
 						struct request *rq)
 {
 	sector_t pos = blk_rq_pos(rq);
-	sector_t skipped_sectors = 0;
 
-	while (rq) {
-		if (blk_rq_pos(rq) != pos + skipped_sectors)
-			break;
-		skipped_sectors += blk_rq_sectors(rq);
+	while (rq && blk_rq_pos(rq) == pos) {
+		pos += blk_rq_sectors(rq);
 		rq = deadline_latter_request(rq);
 	}
 
