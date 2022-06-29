Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3704C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiF2Xch (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiF2Xcg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:36 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3DA31F
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:36 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id c6-20020a17090abf0600b001eee794a478so1024080pjs.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYN+z8YXhiwlM9h20/i7DEnZqOdFe4dlzQhIALAAaSk=;
        b=F6qX5assyKTNlOyDMfhrzf1ivVG9tSEqZ9fNtbV+TGMQ1ZpzqPSyC/uZiH08Shynfs
         7R19byu5Eb5QcyDwQNqxiF8dueAZmXKzBC1IB4daGZodMfwi74t7XY3/mvoDUzpPisDl
         /9kV7iR/KrWRK1bz3jpvxS2LFFO+eNawHJsb7sMLspTE7WTA0Hn+wfIEQrSf3NGU4/Ty
         5tz9/Yea2wUi/7uzCGS5c62kMOwBUoLyfVKg8ewwVUe1rjjW9RY1LiVCOdZiCwXW6fkf
         exyospIES8kkwuHjCQ7g5ziItu8fZKLoYoI7q6hwYzQ81hBLQARf6ky67fGl1a+RVXyV
         xD0A==
X-Gm-Message-State: AJIora9KExJSJTsIqJ7elTKEdZHo/+AP8YaSV5OC5vTOevnFAxVRaWQm
        mQ/WxLbBB3KMxT9/7ELB1T8=
X-Google-Smtp-Source: AGRyM1vKy0ovk81xl5cPeJBqXFjWnauqT2Y5MiWXoCgrU9SqkburdULnNOcxJ0kjM9jK5urSIfNFtw==
X-Received: by 2002:a17:90a:c244:b0:1ec:d65f:e1c7 with SMTP id d4-20020a17090ac24400b001ecd65fe1c7mr8285725pjx.15.1656545555520;
        Wed, 29 Jun 2022 16:32:35 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:34 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v2 27/63] dm mirror log: Use the new blk_opf_t type
Date:   Wed, 29 Jun 2022 16:31:09 -0700
Message-Id: <20220629233145.2779494-28-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for a function
argument that represents a request operation type.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-log.c b/drivers/md/dm-log.c
index 56ad13f9347b..cf10fa667797 100644
--- a/drivers/md/dm-log.c
+++ b/drivers/md/dm-log.c
@@ -291,7 +291,7 @@ static void header_from_disk(struct log_header_core *core, struct log_header_dis
 	core->nr_regions = le64_to_cpu(disk->nr_regions);
 }
 
-static int rw_header(struct log_c *lc, int op)
+static int rw_header(struct log_c *lc, enum req_op op)
 {
 	lc->io_req.bi_opf = op;
 
