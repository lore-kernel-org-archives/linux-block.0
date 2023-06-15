Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7D1C001B1
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 03:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242731AbjFODIx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 23:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbjFODIq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 23:08:46 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D130F26AD;
        Wed, 14 Jun 2023 20:08:45 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-25e820b8bc1so648149a91.1;
        Wed, 14 Jun 2023 20:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686798525; x=1689390525;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+6UCFNg4ScFWTGZ3Vx9Eu23SfSzKM8aQG3DQ2QqYdjs=;
        b=a0qptBRws1qhqj3Drp+rGVx1eK78HYVKNvOAdya0hnrr0cAuZgIM6/5EhQNLxW09UK
         hid5MFMDZgXFjyZfQP2UqJkI/fgX1uDJ4Q6T39H+gYE1rVh30Oebh8uveUofjIh3+7SS
         gvtuedWV+Tr2dCayBSXBlBAYWqN8duGuBUxuv4FMHS4aI3Eieox5nTtVdueIjOW2oVoz
         DwEyk3xeIWk03PUr10VBZzRDdtyuySiBt2mvCxqcPURS6u6sNEc62HRdWRUEmTVH77XJ
         2xEJB1c2ue+GdKBIRcdtvmG/MSrAvB2ZvfZUgK2T4VV+R6c/JS6FKoYymZsEb7YmHLQX
         sQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686798525; x=1689390525;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6UCFNg4ScFWTGZ3Vx9Eu23SfSzKM8aQG3DQ2QqYdjs=;
        b=KoArkF99r4eiJ4FQxKCol8r64NB3OgmGg96bUBwhypnKCcthAA8y7B9R72UnQbX09i
         Jz2Nuk0aIGZs3XaS/aAQoYmslYaz+PsxRS3WOOwSUdn8kWjAJlsvvSIdX/F7tmXb/WKV
         TofOnLFIcel/FZGG6DXL4Ieg+ohGWhOWOB5XWWIYXFe/4JLNDc+KVqOl0a2cS9Xm4O6e
         sjaPFvPiEGe9h5W6+9nzU90dRoc1CtKPAwbGd/BdyUJF/FOwaU6TvksxtzAk9VGyK4v2
         4KhpdLF4QbL15Xw6lJFTcYTJooiy8u+VSz7vQ+zPIk7xuwA+y28wOG+7K5bTNsKxCBgd
         geXw==
X-Gm-Message-State: AC+VfDywvUgSq4OjMAKICE8VWDnpeWHYwcII0mUqOUiCO8m7IjKs4Ira
        um6fRRJ7/TQjXQ3XfU2HbbI=
X-Google-Smtp-Source: ACHHUZ5z3EPz9ldcCp+zdRK4LseB4//i95e30AFPT++7wRgcKy2Q1JMcpfu7KQnXX8iInx+ad2i7PQ==
X-Received: by 2002:a17:90a:8b92:b0:25b:d67c:6a9e with SMTP id z18-20020a17090a8b9200b0025bd67c6a9emr2876653pjn.16.1686798525237;
        Wed, 14 Jun 2023 20:08:45 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id 15-20020a17090a004f00b0025352448ba9sm14502956pjb.0.2023.06.14.20.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 20:08:44 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id D9922360328; Thu, 15 Jun 2023 15:08:40 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        martin@lichtvoll.de, fthain@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v10 1/3] block: fix signed int overflow in Amiga partition support
Date:   Thu, 15 Jun 2023 15:08:35 +1200
Message-Id: <20230615030837.8518-2-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230615030837.8518-1-schmitzmic@gmail.com>
References: <20230615030837.8518-1-schmitzmic@gmail.com>
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

