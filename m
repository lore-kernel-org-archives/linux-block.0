Return-Path: <SRS0=VL3J=P3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB0FC61CE8
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 18:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF56D2087E
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 18:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM+BS3Hn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfASSFS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jan 2019 13:05:18 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46339 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbfASSFS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jan 2019 13:05:18 -0500
Received: by mail-qt1-f194.google.com with SMTP id y20so18747339qtm.13
        for <linux-block@vger.kernel.org>; Sat, 19 Jan 2019 10:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g45qMdy3Kp0PFHIpUrKiuZWWVQgkrHivQ30JFr3/2Mw=;
        b=PM+BS3HnV9IdKEIU1dB30FSOEx6NWB6oGOj1QG3mKGnmBiy08GSqOnW2la6KUZCOGt
         lNVMT0BfUMmd8Q5dCCOR/3zuYrr8S9leCR+qIC08iCiczfDOAVXJB5qBkCgWMGjRC1sk
         xio56TbeJr+WtElGMP8OugM92mO58PL6VGDHDO6xcrvx2TuGCo/sSC8qQ2g8MEpfhmOW
         3NtAelMmJj8q8PsP0JLwEsKIdJL7jhCs7M1umf1J6oujVnOSOS8I2D9qZuVp3LEOBfEt
         JYcc0bviJEAf8FUWYAY4wDMYFNznjlCskuMp1GIdgQJIKJIYDuCyDC6yzDH3FqbJwoEC
         RkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=g45qMdy3Kp0PFHIpUrKiuZWWVQgkrHivQ30JFr3/2Mw=;
        b=MCUBwArwIPTKtM9wQUBQu7TBC1lbC0qX/DL5Lh3HfgUubgcVEE1gHPcu+gAsFv/RJN
         kizii6IIl1ZPxvJmzTsOmYWHhJyE5eJDgQGkWd7U7NHQnpx5n9w14eumQTp8jR4K9at8
         6n5iO7LyaR0ggerlzeA7cuVL+ScUJIOnRl0oY7RNAzGoAT8X6GDg3fLPGvUiOEsNhBsf
         AvIehwQvbFSUEcKdePVQn7eg6Vd0aepGiwwF3FX1JRwQUdqAf+s3Mr1S/Hfx+TJo2s6J
         W4j0Tyn79phFGwbMcBO7fQX548ALS5XT+NKMzpVOyxbtlrmqjQwSI1W9g/LMMcLNsYqN
         bt3w==
X-Gm-Message-State: AJcUukdJ3L6Wkbjm/pBHoLycbMn/E1UB9JtytGuTPJ0eLF8TBSWBza50
        V5Cn9cRiy6YHAFW5yAP9g/E=
X-Google-Smtp-Source: ALg8bN6PEMJUiaxDn2v09hGoE6IweZyZL5k9aIsELqSZhXdr0DHxwOO3b/HTIFMA+KTs3OM8YJgMEg==
X-Received: by 2002:aed:3968:: with SMTP id l95mr20974027qte.344.1547921116591;
        Sat, 19 Jan 2019 10:05:16 -0800 (PST)
Received: from localhost (pool-68-160-176-113.bstnma.fios.verizon.net. [68.160.176.113])
        by smtp.gmail.com with ESMTPSA id n92sm48474086qtd.85.2019.01.19.10.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 10:05:15 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     NeilBrown <neilb@suse.com>, Ming Lei <ming.lei@redhat.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org
Subject: [PATCH 4/4] dm: fix dm_wq_work() to only use __split_and_process_bio() if appropriate
Date:   Sat, 19 Jan 2019 13:05:06 -0500
Message-Id: <20190119180506.1300-5-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190119180506.1300-1-snitzer@redhat.com>
References: <20190119180506.1300-1-snitzer@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Otherwise targets that don't support/expect IO splitting could resubmit
bios using code paths with unnecessary IO splitting complexity.

Depends-on: 24113d487843 ("dm: avoid indirect call in __dm_make_request")
Fixes: 978e51ba38e00 ("dm: optimize bio-based NVMe IO submission")
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 6e29c2d99b99..aa7e429646b3 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1727,6 +1727,15 @@ static blk_qc_t __process_bio(struct mapped_device *md,
 	return ret;
 }
 
+static blk_qc_t dm_process_bio(struct mapped_device *md,
+			       struct dm_table *map, struct bio *bio)
+{
+	if (dm_get_md_type(md) == DM_TYPE_NVME_BIO_BASED)
+		return __process_bio(md, map, bio);
+	else
+		return __split_and_process_bio(md, map, bio);
+}
+
 static blk_qc_t dm_make_request(struct request_queue *q, struct bio *bio)
 {
 	struct mapped_device *md = q->queuedata;
@@ -1747,10 +1756,7 @@ static blk_qc_t dm_make_request(struct request_queue *q, struct bio *bio)
 		return ret;
 	}
 
-	if (dm_get_md_type(md) == DM_TYPE_NVME_BIO_BASED)
-		ret = __process_bio(md, map, bio);
-	else
-		ret = __split_and_process_bio(md, map, bio);
+	ret = dm_process_bio(md, map, bio);
 
 	dm_put_live_table(md, srcu_idx);
 	return ret;
@@ -2429,9 +2435,9 @@ static void dm_wq_work(struct work_struct *work)
 			break;
 
 		if (dm_request_based(md))
-			generic_make_request(c);
+			(void) generic_make_request(c);
 		else
-			__split_and_process_bio(md, map, c);
+			(void) dm_process_bio(md, map, c);
 	}
 
 	dm_put_live_table(md, srcu_idx);
-- 
2.15.0

