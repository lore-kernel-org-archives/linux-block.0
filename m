Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C477EC32792
	for <linux-block@archiver.kernel.org>; Mon, 22 Aug 2022 21:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbiHVVF2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 17:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbiHVVE2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 17:04:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B9840551;
        Mon, 22 Aug 2022 14:04:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id g8so7143154plq.11;
        Mon, 22 Aug 2022 14:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=8+88R7qOds/HkPR0iwegb881QZcMqG1b6vh5BeEwu4Y=;
        b=AFQ7CpJOCtylO6WbJQ0uzNrGQNTAOsr8iS4HiAfkStp82p1jAXy1cQlA1plQB1brVf
         AEdyDvTSLQepkMwf/0pp+Eh2Ow6yEzeJvkqC+BejwgVNwOfe16bOkk5HX8GLf5VYUggQ
         qCXXdKcQVq4F5MO1nY+0Z1Z8MYwt7w+EqeW5sZ3ZtYt3D/P5mByzd573ivAMjPaAAXr7
         qlR4IaT0kNdGfpKuvwuWkSCaIe9z1pSZeGOT8T6jVOhz/KKV/jah6UF5Ql0wTTHGMfLN
         GzFAlu63C1Lj/+P1HJSsXMQba8x20pqZ1K88trwnuXArwJTFb8PZjkhU2U2Xdz8gFb3W
         Md9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=8+88R7qOds/HkPR0iwegb881QZcMqG1b6vh5BeEwu4Y=;
        b=st2vI/xYoGrrmriRAq6xhKTcilEKEGjduQF6hKjoRtRpK967nD7BdJ2ZUF/5Py3g6S
         3ffZKSqQ0jbtgcbhgkedO3pBL0QvNKIuDRKIhMMOd5VG2Gvl0z/BrgmiCKsnq6nlBj69
         hhOXmT1tc+pGvMvzv2YKfvVdEGurhoRSRA2+sOpX2rzG/hIB7zcd3mvbs79CHiQ4cz1v
         IfxPzFBygyCqOtbnrF5ANaiiPSHRMvDbF5e3CyqyWEc43bLAZtBJWGjuWDjpyB22ov6H
         G4EGWLYcfVK+UAcAshXIOUOcdKz0M0VeDgcVTRJQqppXg8hWEeV1BbVnKrhWsCw73BnI
         FjIQ==
X-Gm-Message-State: ACgBeo3QvSyJWatefVz8P5hxrP5kQjXdlZW6+jiAi+rAfQjS+nVBcZh8
        lx+EcAiIeVYRJYGqLAOLYYQ=
X-Google-Smtp-Source: AA6agR6E0b553VooYFGeO7qD2Y4mIaTrm54iFrqjOn2Keop1VPYpgF/HLA/eEDETZhq73/Blb024MQ==
X-Received: by 2002:a17:90a:304a:b0:1fa:d832:5aca with SMTP id q10-20020a17090a304a00b001fad8325acamr203073pjl.16.1661202266377;
        Mon, 22 Aug 2022 14:04:26 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-155-0-244-adsl.sparkbb.co.nz. [222.155.0.244])
        by smtp.gmail.com with ESMTPSA id g9-20020a170902934900b00168dadc7354sm4281794plp.78.2022.08.22.14.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:04:26 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id D422636031F; Tue, 23 Aug 2022 09:04:22 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v9 RESEND 1/2] block: fix signed int overflow in Amiga partition support
Date:   Tue, 23 Aug 2022 09:04:12 +1200
Message-Id: <20220822210413.8603-2-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220822210413.8603-1-schmitzmic@gmail.com>
References: <20220822210413.8603-1-schmitzmic@gmail.com>
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
Fixes: 1da177e4c3f41524 ("Linux-2.6.12-rc2")
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

