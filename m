Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A33FC19F2B
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 23:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbiGZX6T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 19:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbiGZX6S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 19:58:18 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67000286F9;
        Tue, 26 Jul 2022 16:58:17 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x1so12967098plb.3;
        Tue, 26 Jul 2022 16:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A3910st5lAPxa3eOzPeoaXcmTzbCAY5r2x+4hDwdkxs=;
        b=aaH/YjD1lqu+XfKnHDWQRwD8Qptq2u3XC0I07I3yyiP/GtcZVbfNViuxWIaj0eBDVo
         SJVsnTanj1uWpWNcTtMWKHdVRkiR3UtttMVsfEZfNBIMAnZuGSFSnyVRybk2s1qWGm3O
         VoKg689aYVko1I2lf5+FITy54IDEhW7Tx6MG6fq71bYFVZf7CkrCgjd/2kkhgwXYYcQ/
         yVpGvLwDDLYvQPDrxzEoYy8ryLwP3Q78NxKSYaZa7p6zgmpGpgIiur6GqWgK2cPb8qdF
         3SfQtXiFzMMH2zqr6OjtOoBvOC2xDxSh8w9BPoiy8vJhUxjlGxGGUWXTyywKrfK7xQAg
         H3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A3910st5lAPxa3eOzPeoaXcmTzbCAY5r2x+4hDwdkxs=;
        b=CePKQ8nGe1pROQHuvh86l/sQlfopyNAd/lpuC58OmEfFUMnZc8Zc6f18456X21tDnY
         ZYzxyck6NVWJSOSuSa61AxZT3/Vh2VeVQv/Y0h3nlr8Uj7khwnpq/hQXFmh4HMYfR9V9
         UpzG+/DhPIOEOpvXq1Q490a24aZrL+q4OiGOScEzR06BUqUfOQBKfMLG+MWtXNgq54qR
         FjJI76twTZxlCmjktqJdXV1mqt7njkOcPTVLY9zFdfW5fhww+lvsKQgEzBFaKG3B3ty5
         r4KcGqJSSVRSuT7bDatweXynILsgmOjKcv4sFhFgrK6dcB3mrhp16EYSxGCTuODw1BBi
         73mw==
X-Gm-Message-State: AJIora+zyzT9ymuA8TSBydt2tAKNmTwUW6i7fcPBGoRgwqLqtisckKNP
        kAPeHp7ExGoLMDpTiWnM9VycbcnXC0s=
X-Google-Smtp-Source: AGRyM1v6NaOVoKeutE2D9L0qvAtWByDFksn11+1URfoL4lSPnc6i7FNrKZ49rxzR6IwWwQq4RkjG6Q==
X-Received: by 2002:a17:903:40c5:b0:16d:35e6:c561 with SMTP id t5-20020a17090340c500b0016d35e6c561mr19546374pld.12.1658879896853;
        Tue, 26 Jul 2022 16:58:16 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-155-0-244-adsl.sparkbb.co.nz. [222.155.0.244])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b0052ab8a92496sm12225654pfm.168.2022.07.26.16.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 16:58:16 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id D13CF360326; Wed, 27 Jul 2022 11:58:12 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v9 1/2] block: fix signed int overflow in Amiga partition support
Date:   Wed, 27 Jul 2022 11:58:08 +1200
Message-Id: <20220726235809.15215-2-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220726235809.15215-1-schmitzmic@gmail.com>
References: <20220726235809.15215-1-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The Amiga partition parser module uses signed int for partition sector
address and count, which will overflow for disks larger than 1 TB.

Use sector_t as type for sector address and size to allow using disks
up to 2 TB without LBD support, and disks larger than 2 TB with LBD.

This bug was reported originally in 2012, and the fix was created by
the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
discussed and reviewed on linux-m68k at that time but never officially
submitted. This patch differs from Joanne's patch only in its use of
sector_t instead of unsigned int. No checking for overflows is done
(see patch 2 of this series for that).

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
Message-ID: <201206192146.09327.Martin@lichtvoll.de>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Tested-by: Martin Steigerwald <Martin@lichtvoll.de>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>

---

Changes from v3:

- split off change of sector address type as quick fix.
- cast to sector_t in sector address calculations.
- move overflow checking to separate patch for more thorough review.

Changes from v4:

Andreas Schwab:
- correct cast to sector_t in sector address calculations

Changes from v7:

Christoph Hellwig
- correct style issues
---
 block/partitions/amiga.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
index 5c8624e26a54..85c5c79aae48 100644
--- a/block/partitions/amiga.c
+++ b/block/partitions/amiga.c
@@ -31,7 +31,8 @@ int amiga_partition(struct parsed_partitions *state)
 	unsigned char *data;
 	struct RigidDiskBlock *rdb;
 	struct PartitionBlock *pb;
-	int start_sect, nr_sects, blk, part, res = 0;
+	sector_t start_sect, nr_sects;
+	int blk, part, res = 0;
 	int blksize = 1;	/* Multiplier for disk block size */
 	int slot = 1;
 
@@ -96,14 +97,14 @@ int amiga_partition(struct parsed_partitions *state)
 
 		/* Tell Kernel about it */
 
-		nr_sects = (be32_to_cpu(pb->pb_Environment[10]) + 1 -
-			    be32_to_cpu(pb->pb_Environment[9])) *
+		nr_sects = ((sector_t)be32_to_cpu(pb->pb_Environment[10]) + 1 -
+			   be32_to_cpu(pb->pb_Environment[9])) *
 			   be32_to_cpu(pb->pb_Environment[3]) *
 			   be32_to_cpu(pb->pb_Environment[5]) *
 			   blksize;
 		if (!nr_sects)
 			continue;
-		start_sect = be32_to_cpu(pb->pb_Environment[9]) *
+		start_sect = (sector_t)be32_to_cpu(pb->pb_Environment[9]) *
 			     be32_to_cpu(pb->pb_Environment[3]) *
 			     be32_to_cpu(pb->pb_Environment[5]) *
 			     blksize;
-- 
2.17.1

