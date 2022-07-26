Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA111CCA489
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 04:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiGZE56 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 00:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbiGZE54 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 00:57:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2E125E8C;
        Mon, 25 Jul 2022 21:57:54 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id li4so1031900pjb.3;
        Mon, 25 Jul 2022 21:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W94qn3nGmVR/O4UrSjj7D/CmCTf8ayPCIaQqSAZ/DBA=;
        b=j7KMIJrO4k530gQ37gHVT9sl9RU/VKp7nTo9uUFs43OZROSC4+N1lGHOUeDr2x4gKG
         AQiFMrrPD474U8kTN7If/A6gFqYNacAiwOBGhV13gjfpj8K8wHb1OMv/eUlY1pnRM7tS
         AK0dXWo8jbkBW+NTnS/KXH3Ryzd/c8hZCim/zWrS6qkfcuibqtld7EQfhO3xNKRqMtL3
         +31l2+Xv3pKZbyHhgJNl2JkwObMGLeH+iWFg9v6jkQvMPEiYQsStcYWrQBAaKfhgWOcG
         XMTSxyt4pVP7T3IjDR5FkcKTw1wYoS4qxQm0d/ZG17dUppWJWt2A3PBO/6oeoJu9JXCK
         +A3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W94qn3nGmVR/O4UrSjj7D/CmCTf8ayPCIaQqSAZ/DBA=;
        b=vZEBfsH2ZxMD1zDgms6pPjYaelME6kxZwWRsLhg9CxhGT455gN9+xkfQhjQFI7T1Ok
         hPQbEBf6ynvod9D68ecTiRrMkbhCb98704dKJ52E6wTjanbcBUFM1mE9rjQW9VuwxWa/
         Yv2nHESwrOj0vPsCfUfhqNv1wpMFezCav6EkRLWjf/bjK/QjfxwCvZueCCpURcESkmcZ
         VVJi3Bqh2RiTMCvQWEFdecLgEActZ6UYB1yZfOg4WWLFMIcdcLYwDeFWVfWUhOTMOyBx
         V6Ya7u7KK47oOHu/cODDXHHFcwj8PCfPJfriGE52ky0EDQSw68IebBx2inY8MOv9rjrM
         OvBw==
X-Gm-Message-State: AJIora+dyLWylt4gswmklIqWG7qNmbH6mMVEvETvhnnHp4Sle5GdyLTN
        EdTi3pyuYJ0lPu3k7D63Yak=
X-Google-Smtp-Source: AGRyM1vUB1LDtsBxMotXVJJ1oKUD0bhNW2CnmTq27XG8xmNUcy2aruFoOl8MMjpFZfr8DR3o6rKmSg==
X-Received: by 2002:a17:90a:fe07:b0:1f2:1a1e:e0db with SMTP id ck7-20020a17090afe0700b001f21a1ee0dbmr17905574pjb.106.1658811474126;
        Mon, 25 Jul 2022 21:57:54 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-155-0-244-adsl.sparkbb.co.nz. [222.155.0.244])
        by smtp.gmail.com with ESMTPSA id c22-20020a63ef56000000b0040d48cf046csm9271262pgk.55.2022.07.25.21.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 21:57:53 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 8245E360326; Tue, 26 Jul 2022 16:57:50 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v8 1/2] block: fix signed int overflow in Amiga partition support
Date:   Tue, 26 Jul 2022 16:57:46 +1200
Message-Id: <20220726045747.4779-2-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220726045747.4779-1-schmitzmic@gmail.com>
References: <20220726045747.4779-1-schmitzmic@gmail.com>
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
---
 block/partitions/amiga.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
index 5c8624e26a54..f98191545d9a 100644
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
+		nr_sects = ((sector_t) be32_to_cpu(pb->pb_Environment[10])
+			   + 1 - be32_to_cpu(pb->pb_Environment[9])) *
 			   be32_to_cpu(pb->pb_Environment[3]) *
 			   be32_to_cpu(pb->pb_Environment[5]) *
 			   blksize;
 		if (!nr_sects)
 			continue;
-		start_sect = be32_to_cpu(pb->pb_Environment[9]) *
+		start_sect = (sector_t) be32_to_cpu(pb->pb_Environment[9]) *
 			     be32_to_cpu(pb->pb_Environment[3]) *
 			     be32_to_cpu(pb->pb_Environment[5]) *
 			     blksize;
-- 
2.17.1

