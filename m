Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0886DC04EBF
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC522082B
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544029922;
	bh=4M1V3Q3vTfkJmRoc9yCgZzSH7EHae42bApShgxhiUmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JvURVcZxM1QKuykbAj5nUw4RF9aR3jtisgf4L3AkIZga+3c2ZGUW8FERvBOE/pmR4
	 pIFK8/a67PDqlMKKVTvrQZLHKG45Wv2LmMBg7EcymMEAUudr1i1h351LhuQjgbzYEB
	 qb2k5SnHbERYqiBn9W4rCoSGFJJ44b2kGSKhI+yQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC522082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbeLERL4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:11:56 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44880 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbeLERKv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 12:10:51 -0500
Received: by mail-qt1-f196.google.com with SMTP id n32so23074479qte.11;
        Wed, 05 Dec 2018 09:10:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PAF09T9AUnRDZbdy+9W+1tWiUCzC21kl3xO6QVyamzk=;
        b=i3Ad67oLv44e8CcO5HVmCxaZp+wb9SoJLcR7rG4unDXSTKA4RMJoaNl1j4hi3QOSuR
         FMJK0zRR0T7vRGo7mQnuplLpkkBsvu1hbI2fENT+VZD5+HXOjRNgb88bwGKh+XT1eMk3
         xylY70CE29gLhNt1CGz8Of/DSuj8m7pZGB3XGcfNTFG/e2VoiZP6cc53no9v//e3K4Wg
         fmhkDr/vhupF4dLNAcaFxkYvpQiSlUDOmDNmPWL5zsBDp0AQ/QNMTvJj4TfQgB7Iboec
         Z+8cC+Lv0Rzs1W1OANVy1SzeiQd5Kld9eE5nyGrgqRKqVCy2sxNcUa8n+vnObH3f+YjJ
         X9Ow==
X-Gm-Message-State: AA+aEWbvMMaIo+hpj0QDjze5CNX+PDx7lqByPNVyVUNaoXlmt+xZJz6P
        DbQU+nHAcxe/1XIADs1WTWc=
X-Google-Smtp-Source: AFSGD/XCWtQrJmEqO3LBRTulZvBHvAXLU7BxTMgwQ1xEZIu9gg1NRFplBmsqdGdFbkxVZMrmXEdL9w==
X-Received: by 2002:a0c:b48d:: with SMTP id c13mr24204851qve.91.1544029849522;
        Wed, 05 Dec 2018 09:10:49 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id q15sm12098751qkl.81.2018.12.05.09.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 09:10:48 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>,
        Alasdair Kergon <agk@redhat.com>
Subject: [PATCH 05/14] dm: set the static flush bio device on demand
Date:   Wed,  5 Dec 2018 12:10:30 -0500
Message-Id: <20181205171039.73066-6-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181205171039.73066-1-dennis@kernel.org>
References: <20181205171039.73066-1-dennis@kernel.org>
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
Acked-by: Mike Snitzer <snitzer@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
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
index a733e4c920af..ab72d79775ee 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1417,10 +1417,21 @@ static int __send_empty_flush(struct clone_info *ci)
 	unsigned target_nr = 0;
 	struct dm_target *ti;
 
+	/*
+	 * Empty flush uses a statically initialized bio, &md->flush_bio, as
+	 * the base for cloning.  However, blkg association requires that a
+	 * bdev is associated with a gendisk, which doesn't happen until the
+	 * bdev is opened.  So, blkg association is done at issue time of the
+	 * flush rather than when the device is created in alloc_dev().
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

