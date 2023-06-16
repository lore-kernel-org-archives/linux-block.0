Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF62BC0015E
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 01:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjFPBTT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 21:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjFPBTS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 21:19:18 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD423296E;
        Thu, 15 Jun 2023 18:19:17 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-543cc9541feso188197a12.2;
        Thu, 15 Jun 2023 18:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686878357; x=1689470357;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+6UCFNg4ScFWTGZ3Vx9Eu23SfSzKM8aQG3DQ2QqYdjs=;
        b=Y7WNFfieor5wW7jJr1BhBVec54Lt/ZGKs/wQiT3fom9p+t0B6buIO0j8qekOUpEz0r
         Ij6ywikCLA9ccbRuRFD/6wgEQ8dLXEnDaJlXmQtEaIQDZVJkHV3uhM8aAJWL8JoWu7EC
         +BvWIJCa5UUFb+wrMO83WY/X2qt2DYV341Mj6/13C3Jklz/RCPC0ivlQjcScspQX2PVJ
         mpbyLh5e+5dZII8XGLtOBy72iMEIxza7pvjyBSc9VQrh/AgY0ANSRYYL+jDYQ1pR7ccw
         1GLNMrHqDen/Pse7JNx22MlSGiKiEgUOUiR1ufORKhxuiu/i6L6DdSfxKW1ADZSwyRA1
         Mzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686878357; x=1689470357;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6UCFNg4ScFWTGZ3Vx9Eu23SfSzKM8aQG3DQ2QqYdjs=;
        b=CYxWw/Lc/YmG1FjjNrLiOu22UrgqoemLXEPYcTnSrlCh6JPx4JISQPFX6gCqfXum5+
         Zcv7czui6UBrUr+Sg4qHmBqR1XGUzd64ASB7LJs2uYvTVal32/067Bt27M/VxzYy+pKV
         5mT1zQBazXdRQzy6wL3L6CE9FRE/a9D4Mwm33KZJCb38XARQiFtEZDi+mWXJne/cn5KM
         4RjfXAj7+l66RAFA+q17xnu0kpmalflmT7gFWFg5jjMF/pcfo+WiZ5s4x2mfeDOs4ma1
         +Dnpm11H1SPiJbZxgCFaptbG8XmZ9kJ4m9/nMlMeb9JSb/Hysaz7EMGjYoOnNDBlsNje
         42OQ==
X-Gm-Message-State: AC+VfDxpppPa3LFtRfo8hJ2pIKbZ1KrTj0yNgMRRfnF+TWUYPSmiLpRa
        1FexXBevRSqBpcxhEgN3RSjl51rY1KU=
X-Google-Smtp-Source: ACHHUZ4fktKrU8aVkhhxeiI53Gjah0TLFMI97dyQrOhXq9//mf5LPGnecWJRp1ChBRfs5Xk38+lEvg==
X-Received: by 2002:a05:6a21:3803:b0:118:2032:8109 with SMTP id yi3-20020a056a21380300b0011820328109mr881509pzb.11.1686878357218;
        Thu, 15 Jun 2023 18:19:17 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79211000000b00662610cf7a8sm12833567pfo.172.2023.06.15.18.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 18:19:16 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 8C8693603D9; Fri, 16 Jun 2023 13:19:13 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        martin@lichtvoll.de, fthain@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v11 1/3] block: fix signed int overflow in Amiga partition support
Date:   Fri, 16 Jun 2023 13:19:05 +1200
Message-Id: <20230616011907.26498-2-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230616011907.26498-1-schmitzmic@gmail.com>
References: <20230616011907.26498-1-schmitzmic@gmail.com>
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

