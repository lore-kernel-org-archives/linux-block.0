Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2E2CCA47A
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 17:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345059AbiFNRt4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 13:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345050AbiFNRtx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 13:49:53 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1652934B93
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 10:49:53 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id h1so8329704plf.11
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 10:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/52IjGm18EW/U7nu7Sdnq42Uyhsn7+KydneD7v41/xc=;
        b=HJjrAtzpSJkDrXxYj5vRobx4E68WK2KyRkJ6qQJAft4eqfm1li0efv5Rhj3uD70UXu
         qPlIG4M9O8+1zkd14UU2sgw3/GjcNm4VHj7TFUi1ql2PtM1/z0gu3JI64J+1AUU2j1BU
         qy7eSJkOuSv75z9Yz45EL9r2wjdwXLv/bnzSXboCUazljbaHpWF/AfZLZutiA2ExkYpg
         7O/HeKy16iVlzDr3JJ6o+qF4KYkgCGKSZ47jZVAMKMpix34WtPDYwO3J4JbEhIlsFqwX
         rdkDFFWF2obw02LQh7icOxh+TxWyjQ/Gk6NO7wEIytOvQQPR1ExcaDOlxc0FjzE2EhqU
         AC1A==
X-Gm-Message-State: AJIora8VF+MEVPZGxP/HsOOkMQzQR3oJt9Ia2SQ2bQpuDQ+R9Ku/UkFv
        8BobXiqAQgl25hGZjjXqxbw=
X-Google-Smtp-Source: AGRyM1sGpL26UVvTBBoRhLoqtfLel04A8xbEP8/9HNgeXdX5p4FfI5P4dKTH1fiqrE6oF7ZhWntvdg==
X-Received: by 2002:a17:90a:9481:b0:1e8:7bbf:fa9a with SMTP id s1-20020a17090a948100b001e87bbffa9amr5762380pjo.164.1655228992467;
        Tue, 14 Jun 2022 10:49:52 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id gd3-20020a17090b0fc300b001e2da6766ecsm9866922pjb.31.2022.06.14.10.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 10:49:51 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/5] block: Introduce the blk_rq_is_seq_write() function
Date:   Tue, 14 Jun 2022 10:49:39 -0700
Message-Id: <20220614174943.611369-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220614174943.611369-1-bvanassche@acm.org>
References: <20220614174943.611369-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce a function that makes it easy to verify whether a write
request is for a sequential write required or sequential write preferred
zone.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blk-mq.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e2d9daf7e8dd..3e7feb48105f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1129,6 +1129,15 @@ static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
 	return blk_queue_zone_is_seq(rq->q, blk_rq_pos(rq));
 }
 
+/**
+ * blk_rq_is_seq_write() - Whether @rq is a write request for a sequential zone.
+ * @rq: Request to examine.
+ */
+static inline bool blk_rq_is_seq_write(struct request *rq)
+{
+	return req_op(rq) == REQ_OP_WRITE && blk_rq_zone_is_seq(rq);
+}
+
 bool blk_req_needs_zone_write_lock(struct request *rq);
 bool blk_req_zone_write_trylock(struct request *rq);
 void __blk_req_zone_write_lock(struct request *rq);
@@ -1159,6 +1168,11 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
 	return !blk_req_zone_is_write_locked(rq);
 }
 #else /* CONFIG_BLK_DEV_ZONED */
+static inline bool blk_rq_is_seq_write(struct request *rq)
+{
+	return false;
+}
+
 static inline bool blk_req_needs_zone_write_lock(struct request *rq)
 {
 	return false;
