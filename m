Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF369EB64DC
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 20:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjFTUSS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 16:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjFTUSF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 16:18:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81131BEA;
        Tue, 20 Jun 2023 13:17:34 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b539d2f969so29752455ad.0;
        Tue, 20 Jun 2023 13:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687292253; x=1689884253;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+6UCFNg4ScFWTGZ3Vx9Eu23SfSzKM8aQG3DQ2QqYdjs=;
        b=R0LonCNXLmUPqGHBYylagYDafMHdO5iO4h8sdlp3ecgHQAQ1poSKFZn3eNF7uRly5C
         T2V8ecsGMhBY+0ui71nxIhMNfDZ2a8LRhZs7Znn3bMAE7VCaakhkOw3ExvrvoJ92VBGU
         B2u9828FxLFdkhXgu+3NppAdRG+M5+dfWnP52WHB2pcl2oi+6slYodmVgoHjZkOg3I6A
         TzYNbzMaOgLG2Rdv0DqHqfZm/DyH5GCYsi/CVd28Oa+3/uQ6FdcEbd6wo1jLn63hIpuM
         CTuZzymoOqBSvYpb87nOCy/jK08IRImbFH2ntu9072LBtEQqawY3U+yzj88o996Yq0Xq
         SCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687292253; x=1689884253;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6UCFNg4ScFWTGZ3Vx9Eu23SfSzKM8aQG3DQ2QqYdjs=;
        b=kOX9lvGVB0rX3GW1Dq9a948u7SMsDh4GFZrzh69/lF+XbCUTy3lA5DbpQMcccnMx7z
         FcdmaV6nMKcgDtKHlQKt/YnSbZ53MyCxoaaOz+73fGXFxtngTizf923gXFbk9zcpxKBS
         p9Otn0cAe55rxdr9QXCyRsvC+gn2LksyLU15qB4vvhrjwVRagttjkmloVV8ez62hGZrm
         mS0K/y7W959gseqzrZirGb6PHVshENvMJaXD2W9dtYyeUnOTmh29199Rh4QlJdJHfRgL
         AjLgTVXwZ3hQnrkSNNcAvPblkv5BawttVYe3zxTC3BJD6BVEWZ5E53WPD+lJQYXMagMd
         SbDA==
X-Gm-Message-State: AC+VfDwZN2wxrlZ9MKJe0zzeU91Fh/n3o3htnR4GJkaeF3Ar4M2vG6xs
        97+sangFQ68J1zLM9rUe1kE=
X-Google-Smtp-Source: ACHHUZ4U3Yo0Sk7r11zdKI8hnnbWTGfS94nYBh96Fjq8uhWgDK9EEBqkZspSNgBbCVqvzwm6B1LRhg==
X-Received: by 2002:a17:902:ec85:b0:1b0:f31:a386 with SMTP id x5-20020a170902ec8500b001b00f31a386mr29052751plg.26.1687292252600;
        Tue, 20 Jun 2023 13:17:32 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id g9-20020a170902740900b001b54a88e6adsm1960939pll.309.2023.06.20.13.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:17:31 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id A37843603D9; Wed, 21 Jun 2023 08:17:28 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        martin@lichtvoll.de, fthain@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v13 1/3] block: fix signed int overflow in Amiga partition support
Date:   Wed, 21 Jun 2023 08:17:23 +1200
Message-Id: <20230620201725.7020-2-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230620201725.7020-1-schmitzmic@gmail.com>
References: <20230620201725.7020-1-schmitzmic@gmail.com>
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
(see patch 3 of this series for that).

Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Message-ID: <201206192146.09327.Martin@lichtvoll.de>
Cc: <stable@vger.kernel.org> # 5.2
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

Changes from v9:

- add Fixes: tags and stable backport prereq
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

