Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34425C6FD18
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 22:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjDRWka (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 18:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjDRWkZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 18:40:25 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1A89ED8
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:17 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1a66b9bd7dfso23630455ad.2
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681857616; x=1684449616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkyzbelvOYZFYWXCk1JGM0JOOJuFYKPpEP8FtOY0LsI=;
        b=NCGgtJbmB0XPzRT+n6NUHPYAYMJTK2yz5BY3RduTDqfnXI0Ev808BMr2fwqRXHltAB
         8bJtiRPUU+2tm7/WZ0Y7TMvOG47cYLzFM0h4YhEB5n9XWKwP6xkoA62h502C8dVFWpIA
         wrOf4Nv7lFCy/kVrBCrJ4DAohZ+M4LxyRtc3wD1I7oOdaE1Ugx+h7tKX2h+H6DtC6vk5
         R10X2tWOnioTxohxBAoIWIQALszp6BKJbgBk24GJc1VBMtd7GuzHd45w5NrxyuxR7/2c
         gcf/Lqn9zlAeFWjcls1Cy25G8J7WUA+zAaXQHhtd8UxnCnX5gH9RnfYrM7kIEe/3qlfQ
         9DKQ==
X-Gm-Message-State: AAQBX9fMBn/C0lF15egNlZW7cgEITmhmGq9SdMKbk5cqIrSuZPxdl4Bd
        IyLbfkidKh/CK8tiXcrx1Rk=
X-Google-Smtp-Source: AKy350YXi6QPOZgD7m/mt6gl58sT0bffCR+lHn0/zp4QvZvjrdpGRwmD1McI3RQWCb2BwSl7DSRolg==
X-Received: by 2002:a17:903:110e:b0:1a6:6b5d:8381 with SMTP id n14-20020a170903110e00b001a66b5d8381mr3834086plh.21.1681857616682;
        Tue, 18 Apr 2023 15:40:16 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5d9b:263d:206c:895a])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001a4ee93efa2sm8285646plb.137.2023.04.18.15.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:40:16 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 07/11] block: mq-deadline: Preserve write streams for all device types
Date:   Tue, 18 Apr 2023 15:39:58 -0700
Message-ID: <20230418224002.1195163-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230418224002.1195163-1-bvanassche@acm.org>
References: <20230418224002.1195163-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For SSDs, preserving a write stream reduces the number of active zones.
This is important for devices that restrict the number of active zones.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index a73e16d3f8ac..3122c471f473 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -381,16 +381,14 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	 * an unlocked target zone. For some HDDs, breaking a sequential
 	 * write stream can lead to lower throughput, so make sure to preserve
 	 * sequential write streams, even if that stream crosses into the next
-	 * zones and these zones are unlocked.
+	 * zones and these zones are unlocked. For SSDs, do not break write
+	 * streams to minimize the number of active zones.
 	 */
 	spin_lock_irqsave(&dd->zone_lock, flags);
 	while (rq) {
 		if (blk_req_can_dispatch_to_zone(rq))
 			break;
-		if (blk_queue_nonrot(rq->q))
-			rq = deadline_latter_request(rq);
-		else
-			rq = deadline_skip_seq_writes(dd, rq);
+		rq = deadline_skip_seq_writes(dd, rq);
 	}
 	spin_unlock_irqrestore(&dd->zone_lock, flags);
 
