Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61627EB64DB
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 22:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjFPWgY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 18:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjFPWgX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 18:36:23 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1444F30F8;
        Fri, 16 Jun 2023 15:36:23 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-54fb23ff7d3so807230a12.0;
        Fri, 16 Jun 2023 15:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686954982; x=1689546982;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+6UCFNg4ScFWTGZ3Vx9Eu23SfSzKM8aQG3DQ2QqYdjs=;
        b=UllzPgL7zJOBCr9Fe3ZurXLozyCkT1OMePqOvsv+vInpAV4h6Q+OkcrochHVQjsW9/
         /5/c9/mg68D8Wqc/4aHY7KWUhg9Ce7aqtJEG4TqwFp1nsBErdrczoIAjCCoZ1dDgtRK/
         cS1g7JrLDLf3ROtAePbw9b+G1Xokvn8ADM5y347GHw0DA95lMNApAuZ2HS7tUVfeXvJ+
         NqGEugbRaBOI/L58Hyr/ce7ecIKNa0CxIE+Dyr0NMMl3h0Apc9WHeo5HrC2eoWoZQ9f4
         HSvRTleKU1v/6TxyXb2V8u48nY4fW9/Fv+wvAqBiP1vY2+mHUp/GSmQrUhts6061+G3W
         27PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686954982; x=1689546982;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6UCFNg4ScFWTGZ3Vx9Eu23SfSzKM8aQG3DQ2QqYdjs=;
        b=PnVnVGiY/CKL7V9C13pmsSspJDFO1AAbKbF406OGoClzd7+EmzHlEyDHid/tWT5s/o
         8Zi4jMjDJoAk0hkVxF1AoDZNPzM3BNI+7QNCyvHSZSFFRUHzKy4SDvLqoAkHvp3piTOK
         aIRBQNdkcqBfMO5lQaVNiRwsyEbcAloFfdHMzvc8YDB4NnY55gtu/vxxDt0+tDbvEq+8
         mu9kHlRArHGwyVKuoubd8W1Ssc+juyuqZCcPa1hsv9MMpFVtLK+QFECszUJirgjHDx4K
         c7Snows1nMkB7haxKxUSzctg/yMZcpgCJbe/O9V5h2vC1vkm/r2FggYvJsQOkCiYNN6/
         O5WQ==
X-Gm-Message-State: AC+VfDydbNEg9f4zXyuQxyhEmwiHh/1qFzEfX5RAFfo78gJEr/fUpKCY
        HYo7mEdQnpZPK7wi04D6RUc=
X-Google-Smtp-Source: ACHHUZ6YFBQAcraTGjtnZuh+eb6ArsdKJ2Sq1aG8S6r33vyrxArWEwkFC9Hc7xKqJRQvySy1pgSFYA==
X-Received: by 2002:a17:902:e742:b0:1b5:3d2e:47fc with SMTP id p2-20020a170902e74200b001b53d2e47fcmr1307930plf.36.1686954982458;
        Fri, 16 Jun 2023 15:36:22 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b001ac2c3e54adsm10396847pll.118.2023.06.16.15.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 15:36:21 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id B07C83603D9; Sat, 17 Jun 2023 10:36:18 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        martin@lichtvoll.de, fthain@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v12 1/3] block: fix signed int overflow in Amiga partition support
Date:   Sat, 17 Jun 2023 10:36:14 +1200
Message-Id: <20230616223616.6002-2-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230616223616.6002-1-schmitzmic@gmail.com>
References: <20230616223616.6002-1-schmitzmic@gmail.com>
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

