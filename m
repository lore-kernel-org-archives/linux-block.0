Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50C1C3F2CD
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 15:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6BB24699
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 15:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="VHQur06E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgB1PGO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:06:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33585 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgB1PGN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 10:06:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay11so1365728plb.0
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2020 07:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hoQ5Sz2fU5fHT68nNmiSfIc2yIcVxnWhwaZSaLfQ2j8=;
        b=VHQur06E+DNjGY7awwcX5lv+fmrIB+h6VmgNbZCsU9ZtkKCi8OQkDxDI520ZZ4ca7B
         3aC5SUv44YoKjouyhUxupXjBCzQDn35mlj4Ofic4t11hJtFFCBj/dYQfEcDksPCeVH94
         G7FFPvf0A3pMXLBit3xUYvh2eDz92GZMGvEWu+5PDNtU8dPW/xSKVlg6YAy42YEsQqJS
         NGOR+tOCK0WstgnTQkeWUB2jn+X5FnVn+aXDw8iLNoB3vtvEmiQeNC50mNvcwUZrzsoL
         ja5y21ovsoqFxQQIr4Ix6r2du+wpKfUApqjhvGWbg9IBoafwxxz6KZINbPpMw3Q08poc
         9qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hoQ5Sz2fU5fHT68nNmiSfIc2yIcVxnWhwaZSaLfQ2j8=;
        b=l4tM3n0Cdq46gryj9ROAoPfUQimWObrqvhvMqTav3G2AsJ3zkxakBTAs/hls5iUtC9
         wrIExpIdzM6TTaO7LvcK9D8ziOoNXmIbOB/2hKXE3wvYBKbCEqPahmX4jHoTlp0qilpN
         SkmfXKgd+MZ8QmZAHPJfg6jECh8EW54CpT/nfXg7hsB3WIdl7hzKmCl0gOGvzOy4rkY/
         4tQndBO26Y112HmTiJ4GorlNyNNVXyYIlXv163aT16SE7+BIKGOE0q1A3ZPw06FhJqmq
         0IpjJTeTM9E0j6Kb1wBAD62NYQo0gRY0M6JnEoPgOquRVxS3hovlvhaGppNvJxMmHOGC
         oJBg==
X-Gm-Message-State: APjAAAWLFmUOFtjZ2YKs12sSRd5jXgcYxBgREudijh8RI8I8hP7lixeT
        6kjLsm3+Ng/tpZn9MbDoNFJYc46ewWhgwWOS
X-Google-Smtp-Source: APXvYqy/n9t9tXFZ7iewlt2XEpnok/lB9H69Lp9QAqmX4w/EkAZ6DgjXLnPaiGoz0Uez5FCIb0PC/g==
X-Received: by 2002:a17:902:c154:: with SMTP id 20mr4441080plj.112.1582902372807;
        Fri, 28 Feb 2020 07:06:12 -0800 (PST)
Received: from nb01257.pb.local ([240e:82:3:5b12:940:b7e:a31d:58eb])
        by smtp.gmail.com with ESMTPSA id y1sm7621912pgs.74.2020.02.28.07.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:06:12 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 2/6] block: use bio_{wouldblock,io}_error in direct_make_request
Date:   Fri, 28 Feb 2020 16:05:14 +0100
Message-Id: <20200228150518.10496-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
References: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the two functions to simplify code.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fd43266029be..6d36c2ad40ba 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1121,10 +1121,9 @@ blk_qc_t direct_make_request(struct bio *bio)
 
 	if (unlikely(blk_queue_enter(q, nowait ? BLK_MQ_REQ_NOWAIT : 0))) {
 		if (nowait && !blk_queue_dying(q))
-			bio->bi_status = BLK_STS_AGAIN;
+			bio_wouldblock_error(bio);
 		else
-			bio->bi_status = BLK_STS_IOERR;
-		bio_endio(bio);
+			bio_io_error(bio);
 		return BLK_QC_T_NONE;
 	}
 
-- 
2.17.1

