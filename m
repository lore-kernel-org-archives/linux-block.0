Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECD5EB64D7
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 22:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjFPWga (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 18:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjFPWgZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 18:36:25 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C93F2D6B;
        Fri, 16 Jun 2023 15:36:24 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b53b8465daso4532795ad.0;
        Fri, 16 Jun 2023 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686954984; x=1689546984;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vWQWf1Vi/kzcg0apEc5j5giaZ7iGOcTQZNe9P1refP0=;
        b=GWVRCyoscwKJoBLRJwCvSv/ZfqYje7AkMQfaLuFUBgOm6Gv0el/rCXLFBWlCe3oY0V
         1NYaJL08r9CfYvWCiLDu0CyFhA6bv50Wej+MT279xVwv/KMJJk9PCX8IB3qRr8JdKapC
         q+ujyDlyRHiyp495Xj86aU0HkpadePbW0fI7s4XO20ErLHBMnjiDh8AXPudXW5z2q0H2
         V9CcC4V5yZ7+rmM/OlCcqiUR7/UC75t+qXmK8R3kJg7TCDrzAVxF+7UvTBHPdE2YgVIS
         Y+9QUqQp5ULqJ3i5mnqcCKJEYG4j2pw+Pw6E7WS6K+43kHO7ONH7n/zfd/sWlRVZURqy
         JpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686954984; x=1689546984;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWQWf1Vi/kzcg0apEc5j5giaZ7iGOcTQZNe9P1refP0=;
        b=HPPD8RDL80BjvDsYhrOvaKOIJvclVgdImSWvf0NCY9b+8QHNN7zPsiXzgOMkL+kaN5
         lMcYu33e/aXdCKb3V5NiBmTgc/1ZXW1svl8vThVXfiN1kbnrFJyiVStLng0dYsO5bdlJ
         03b5uHq7zevxYH4UFb1AVC03s4srP/FAE0o4hqXt607kRDyQ4QITC4kQ3fmfNoEJJyPc
         g3kyuXmOUOokV+x4prDsYhbpAeH2cXV7yWaWdF3IPDhPCNputCRwRc0UEgVfBbIFy/eJ
         /nW1lNKFkQbGa/3GbhrB8/dswu3iMyTxM7/T4mml6p/nR28pMutkUHpqKbM3yxDCH1JQ
         IBqg==
X-Gm-Message-State: AC+VfDzYC1absF6njCdeJ2wBAdpWBXn+JmI31Sxa1Tc7jBR/tXWrLLO0
        AA+Zv07qaCw186rz+VB1O/I=
X-Google-Smtp-Source: ACHHUZ4PrWy6cnU0tGBrtpxrqitq2cxjKgSh19R9P4wYnhj3NvktuxAHHoOt90s/5yB5quO8JWk3Uw==
X-Received: by 2002:a17:902:9891:b0:1b2:439f:aa6f with SMTP id s17-20020a170902989100b001b2439faa6fmr2547078plp.44.1686954983650;
        Fri, 16 Jun 2023 15:36:23 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id w17-20020a1709027b9100b001aae64e9b36sm6120764pll.114.2023.06.16.15.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 15:36:22 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 6D5D736045A; Sat, 17 Jun 2023 10:36:19 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        martin@lichtvoll.de, fthain@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v12 2/3] block: change annotation of rdb_CylBlocks in affs_hardblocks.h
Date:   Sat, 17 Jun 2023 10:36:15 +1200
Message-Id: <20230616223616.6002-3-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230616223616.6002-1-schmitzmic@gmail.com>
References: <20230616223616.6002-1-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The Amiga partition parser module uses signed int for partition sector
address and count, which will overflow for disks larger than 1 TB.

Use u64 as type for sector address and size to allow using disks up to
2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
format allows to specify disk sizes up to 2^128 bytes (though native
OS limitations reduce this somewhat, to max 2^68 bytes), so check for
u64 overflow carefully to protect against overflowing sector_t.

This bug was reported originally in 2012, and the fix was created by
the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
discussed and reviewed on linux-m68k at that time but never officially
submitted (now resubmitted as patch 1 of this series).

Patch 3 (this series) adds additional error checking and warning
messages. One of the error checks now makes use of the previously
unused rdb_CylBlocks field, which causes a 'sparse' warning
(cast to restricted __be32).

Annotate all 32 bit fields in affs_hardblocks.h as __be32, as the
on-disk format of RDB and partition blocks is always big endian.

Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Message-ID: <201206192146.09327.Martin@lichtvoll.de>
Cc: <stable@vger.kernel.org> # 5.2
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>

---

Changes from v10:

Christoph Hellwig:
- change annotation of all __u32 fields to __be32

Changes from v11:

Geert Uytterhoeven:
- also change annotation of the two __s32 checksum fields
---
 include/uapi/linux/affs_hardblocks.h | 68 ++++++++++++++--------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/include/uapi/linux/affs_hardblocks.h b/include/uapi/linux/affs_hardblocks.h
index 5e2fb8481252..a5aff2eb5f70 100644
--- a/include/uapi/linux/affs_hardblocks.h
+++ b/include/uapi/linux/affs_hardblocks.h
@@ -7,42 +7,42 @@
 /* Just the needed definitions for the RDB of an Amiga HD. */
 
 struct RigidDiskBlock {
-	__u32	rdb_ID;
+	__be32	rdb_ID;
 	__be32	rdb_SummedLongs;
-	__s32	rdb_ChkSum;
-	__u32	rdb_HostID;
+	__be32	rdb_ChkSum;
+	__be32	rdb_HostID;
 	__be32	rdb_BlockBytes;
-	__u32	rdb_Flags;
-	__u32	rdb_BadBlockList;
+	__be32	rdb_Flags;
+	__be32	rdb_BadBlockList;
 	__be32	rdb_PartitionList;
-	__u32	rdb_FileSysHeaderList;
-	__u32	rdb_DriveInit;
-	__u32	rdb_Reserved1[6];
-	__u32	rdb_Cylinders;
-	__u32	rdb_Sectors;
-	__u32	rdb_Heads;
-	__u32	rdb_Interleave;
-	__u32	rdb_Park;
-	__u32	rdb_Reserved2[3];
-	__u32	rdb_WritePreComp;
-	__u32	rdb_ReducedWrite;
-	__u32	rdb_StepRate;
-	__u32	rdb_Reserved3[5];
-	__u32	rdb_RDBBlocksLo;
-	__u32	rdb_RDBBlocksHi;
-	__u32	rdb_LoCylinder;
-	__u32	rdb_HiCylinder;
-	__u32	rdb_CylBlocks;
-	__u32	rdb_AutoParkSeconds;
-	__u32	rdb_HighRDSKBlock;
-	__u32	rdb_Reserved4;
+	__be32	rdb_FileSysHeaderList;
+	__be32	rdb_DriveInit;
+	__be32	rdb_Reserved1[6];
+	__be32	rdb_Cylinders;
+	__be32	rdb_Sectors;
+	__be32	rdb_Heads;
+	__be32	rdb_Interleave;
+	__be32	rdb_Park;
+	__be32	rdb_Reserved2[3];
+	__be32	rdb_WritePreComp;
+	__be32	rdb_ReducedWrite;
+	__be32	rdb_StepRate;
+	__be32	rdb_Reserved3[5];
+	__be32	rdb_RDBBlocksLo;
+	__be32	rdb_RDBBlocksHi;
+	__be32	rdb_LoCylinder;
+	__be32	rdb_HiCylinder;
+	__be32	rdb_CylBlocks;
+	__be32	rdb_AutoParkSeconds;
+	__be32	rdb_HighRDSKBlock;
+	__be32	rdb_Reserved4;
 	char	rdb_DiskVendor[8];
 	char	rdb_DiskProduct[16];
 	char	rdb_DiskRevision[4];
 	char	rdb_ControllerVendor[8];
 	char	rdb_ControllerProduct[16];
 	char	rdb_ControllerRevision[4];
-	__u32	rdb_Reserved5[10];
+	__be32	rdb_Reserved5[10];
 };
 
 #define	IDNAME_RIGIDDISK	0x5244534B	/* "RDSK" */
@@ -50,16 +50,16 @@ struct RigidDiskBlock {
 struct PartitionBlock {
 	__be32	pb_ID;
 	__be32	pb_SummedLongs;
-	__s32	pb_ChkSum;
-	__u32	pb_HostID;
+	__be32	pb_ChkSum;
+	__be32	pb_HostID;
 	__be32	pb_Next;
-	__u32	pb_Flags;
-	__u32	pb_Reserved1[2];
-	__u32	pb_DevFlags;
+	__be32	pb_Flags;
+	__be32	pb_Reserved1[2];
+	__be32	pb_DevFlags;
 	__u8	pb_DriveName[32];
-	__u32	pb_Reserved2[15];
+	__be32	pb_Reserved2[15];
 	__be32	pb_Environment[17];
-	__u32	pb_EReserved[15];
+	__be32	pb_EReserved[15];
 };
 
 #define	IDNAME_PARTITION	0x50415254	/* "PART" */
-- 
2.17.1

