Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A04C04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6964420834
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6964420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbeLDSgN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:36:13 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39854 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbeLDSgM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 13:36:12 -0500
Received: by mail-yb1-f195.google.com with SMTP id w17-v6so7269673ybl.6;
        Tue, 04 Dec 2018 10:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bQpKW5IQZRQCaOlxFPCc/zPZs+94fhLsbziJx/ehO80=;
        b=Yv7nFvqkbB16bhUT/6fvQoIcHPGKshSbg/1PENM+ej+vKUROCCFtZ7ZinGqv36RB9h
         RVcM4ixAcr4U4nBcr/GCUEma2aCpN+Z8YnMgeHzx+FqkJfgKawMj3IygD4kEx3NbrjIw
         HAtb1pouf9jzlQLYC4/OQrnlAfpYpFR9c/GMsGWj1gnljTIZ1pmo5wtoD5eIy89KSrpM
         WswfrzaGB7q6qcfj/ABd5Tj5Cl387suRXG5vz/MCckMpo+0PtCOq8QEtjUsC53XNOJMo
         vGMeeCPxErRdOfvaBkG4tjCRI8FzMBfVf5rF2If16dU+MG0NDTqYlZPbI8S45t5GXU1F
         v7/Q==
X-Gm-Message-State: AA+aEWYjzeKM9aDhkNer164WIg5pKzC2DyKRd3NUpRd5ka14ZuJp4aB/
        LSdVwtKfvMlCxEU5JmIGwMM=
X-Google-Smtp-Source: AFSGD/XR1R+g5dxCQSATxI7g+OX5hHcir6C4JwO7alvecSwRy907o12Vjy3wg4oYIk/K7eOlfe58rA==
X-Received: by 2002:a25:5e43:: with SMTP id s64mr10311833ybb.242.1543948570801;
        Tue, 04 Dec 2018 10:36:10 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id x82sm4274798ywb.34.2018.12.04.10.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Dec 2018 10:36:10 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 05/14] dm: set the static flush bio device on demand
Date:   Tue,  4 Dec 2018 13:35:51 -0500
Message-Id: <20181204183600.99746-6-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181204183600.99746-1-dennis@kernel.org>
References: <20181204183600.99746-1-dennis@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The next patch changes the macro bio_set_dev() to associate a bio with a
blkg based on the device set. However, dm creates a static bio to be
used as the basis for cloning empty flush bios on creation. The
bio_set_dev() call in alloc_dev() will cause problems with the next
patch adding association to bio_set_dev() because the call is before the
bdev is associated with a gendisk (bd_disk is %NULL). To get around
this, set the device on the static bio every time and use that to clone
to the other bios.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
---
 block/bio.c     |  1 +
 drivers/md/dm.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 452b8e79b998..41ebb3f8e2fc 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2021,6 +2021,7 @@ void bio_disassociate_blkg(struct bio *bio)
 		bio->bi_blkg = NULL;
 	}
 }
+EXPORT_SYMBOL_GPL(bio_disassociate_blkg);
 
 /**
  * __bio_associate_blkg - associate a bio with the a blkg
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a733e4c920af..a2d6f8b33d23 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1417,10 +1417,21 @@ static int __send_empty_flush(struct clone_info *ci)
 	unsigned target_nr = 0;
 	struct dm_target *ti;
 
+	/*
+	 * Empty flush uses a statically initialized bio as the base for
+	 * cloning, &md->flush_bio.  However, blkg association requires that
+	 * a bdev is associated with a gendisk, which doesn't happen until the
+	 * bdev is opened.  So, blkg association is done at issue time of the
+	 * flush rather than when the device is created in dm_alloc().
+	 */
+	bio_set_dev(ci->bio, ci->io->md->bdev);
+
 	BUG_ON(bio_has_data(ci->bio));
 	while ((ti = dm_table_get_target(ci->map, target_nr++)))
 		__send_duplicate_bios(ci, ti, ti->num_flush_bios, NULL);
 
+	bio_disassociate_blkg(ci->bio);
+
 	return 0;
 }
 
@@ -1939,7 +1950,6 @@ static struct mapped_device *alloc_dev(int minor)
 		goto bad;
 
 	bio_init(&md->flush_bio, NULL, 0);
-	bio_set_dev(&md->flush_bio, md->bdev);
 	md->flush_bio.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH | REQ_SYNC;
 
 	dm_stats_init(&md->stats);
-- 
2.17.1

