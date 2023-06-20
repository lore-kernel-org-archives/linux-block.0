Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF18C001DE
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 20:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjFTUSU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 16:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjFTUSG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 16:18:06 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FFE1728;
        Tue, 20 Jun 2023 13:17:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b51780bed0so41300585ad.3;
        Tue, 20 Jun 2023 13:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687292253; x=1689884253;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cm7myBzENeth//c3gWLJa2AnqvJYxKWafrda0LE9Q3c=;
        b=l/ODN4k1VR+GWFFUuOxlnjlODQDY8pAalSOD7Qfw6UQ8AmZnvvrRnnjxZXWLCtCCMa
         FN6joXsZqpmwRdQBZK8VJuOQ/7vFv3Nhrz+nRtpYq42IL3Kf6uRpYIty3KeKCUcvyjqp
         Swg/3P8S0C4k7sA/ue0jTVR8PfmkyPExF7+fRSJ3x4D2M2qMqA4f+05902mL5y4dLKj/
         KpD3SHq9Q2b0kPXWbL3Nx2ZP4ItiF7LwFjgvgiUlhmL9XRyKznOBJrO6OFGCQbJUhbJX
         cfA0Sta1tW+DColxyiZtXQO9O1yny1w4VkPGn2u0EByHJCby5Sk5Q/X8nAt3L8DxwRuJ
         3VtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687292253; x=1689884253;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cm7myBzENeth//c3gWLJa2AnqvJYxKWafrda0LE9Q3c=;
        b=CP1fuUoXFHGxld1J0t5ZICIt74OPDEHKjPWOJOqtaYP8tcyoWRjgy/8HAlzBtKMO3P
         MJpjKD0Y1pcal+awkpXQnai+qfYKhkYJqFV7DqOuHu3fw6XLlRRP/73vcyUe21abnKj3
         UhRjZN9pOc2wTwYrlCq3og4Lpm28SQQ6yxOxfZhP74EZx3UR0/ShnyFdJdJvvCn1LvX9
         A7aKvGR4Q6lRkwJK+9ZSjqpe8Tl0wAs8D6odKsvWJyeZ3TePKNLbWXblHR26afU/9JcD
         +YDwFZw/9/tCF1HM06F6z/0Q8BhtnwJOYboGXhaxd5UZzg7TwhpINxk9nPjMLF97+mWf
         RsNQ==
X-Gm-Message-State: AC+VfDxHrL3BVtQaXXiAtp1YyB2aDDKQRpeGTFb+sB2yIJYpH01/HSVP
        sT9iQwDymaSF0lsXL9Aavdo=
X-Google-Smtp-Source: ACHHUZ5YcdhmnmqsrRTnsCaOsgTAYpy7lMGixbNCr9mD2lcG0OBTMAr9PIXC6HW1upDmsjetNVAPiQ==
X-Received: by 2002:a17:902:6ac5:b0:1ae:3991:e4f9 with SMTP id i5-20020a1709026ac500b001ae3991e4f9mr12181407plt.61.1687292253436;
        Tue, 20 Jun 2023 13:17:33 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id iz18-20020a170902ef9200b001ae6e270d8bsm1999473plb.131.2023.06.20.13.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:17:33 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 5E51E36045A; Wed, 21 Jun 2023 08:17:29 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        martin@lichtvoll.de, fthain@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v13 2/3] block: change all __u32 annotations to __be32 in affs_hardblocks.h
Date:   Wed, 21 Jun 2023 08:17:24 +1200
Message-Id: <20230620201725.7020-3-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230620201725.7020-1-schmitzmic@gmail.com>
References: <20230620201725.7020-1-schmitzmic@gmail.com>
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
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

---

Changes from v10:

Christoph Hellwig:
- change annotation of all __u32 fields to __be32

Changes from v11:

Geert Uytterhoeven:
- also change annotation of the two __s32 checksum fields

Changes from v12:

- change patch subject to reflect changes in v11 and v12
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

