Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C59C77B6E
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 23:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDGX65 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Apr 2023 19:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDGX6z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 19:58:55 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DB5EFB7
        for <linux-block@vger.kernel.org>; Fri,  7 Apr 2023 16:58:51 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id n14so25305493plc.8
        for <linux-block@vger.kernel.org>; Fri, 07 Apr 2023 16:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680911931; x=1683503931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXMoxgLDo4dyjVXptXOnmrqXR6FziNMll+I0AUUU5Fg=;
        b=mbljzSFG78jj4o4hbDxQv8LqezLk+53DAVgSPt8OrZagTwL9CL9sf6dDIQdkB1P2Mo
         Yu5e0Bnr3W0lzplzouYL2WLUVuCfX+N6N98Km63uxCsV/8OAoMwqLzIQG1vRg/BzzNC4
         tGk9GzrTSQnwezY1zXo78KKWKvuvHWfV7fIKDHl8aYHaF5HmqqKgUo89HkqGc3fvJ/F/
         Rsrp3OHiAsAuVEiycQ+Flw2kK2rYt1lCFzie3rX1FxT7KvRuTfMnqja3TAPGQjQcIRbZ
         F2Mn8IC53576NmItAl07/Y6lJWOG5Xa7agYagivI+FJsMxNlEfO3pfFt4TUmNYz/+OvZ
         laEA==
X-Gm-Message-State: AAQBX9dXBLDZLBmYU8wO1rubxCn0XFGHJhc+II0x3YlmmoGwmlCbS7cl
        12/RgmLQgKpANlXTK4gzduE=
X-Google-Smtp-Source: AKy350bYZBQKbkrqAw7/0RibIIUwwovlm9AAw4h8PZ3DH8OZlBgVd8kig/oIGkNptT0oHOQekYOooA==
X-Received: by 2002:a05:6a20:7b07:b0:d6:ba0b:c81d with SMTP id s7-20020a056a207b0700b000d6ba0bc81dmr3870676pzh.12.1680911930728;
        Fri, 07 Apr 2023 16:58:50 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:f2c:4ac2:6000:5900])
        by smtp.gmail.com with ESMTPSA id j16-20020a62e910000000b006258dd63a3fsm3556003pfh.56.2023.04.07.16.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 16:58:50 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2 08/12] block: mq-deadline: Simplify deadline_skip_seq_writes()
Date:   Fri,  7 Apr 2023 16:58:18 -0700
Message-Id: <20230407235822.1672286-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407235822.1672286-1-bvanassche@acm.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
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
 
