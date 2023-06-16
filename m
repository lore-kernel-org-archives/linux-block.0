Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FAAEB64DA
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 01:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjFPBT0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 21:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjFPBTU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 21:19:20 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9772959;
        Thu, 15 Jun 2023 18:19:19 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5440e98616cso1085781a12.0;
        Thu, 15 Jun 2023 18:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686878358; x=1689470358;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CgPDFccY0X+baBWQrUeSsm5DEpkmq8BO0yiFecVSAqQ=;
        b=QCpC/zZXYtgnegshphovipYh9rfwCPcoVbZhGxofysm02s6gO6WPrfbeTGTgZxaNoX
         25gjYSJBrp3O63nA1mJLta+zQ+ZzOycPFJqMKFLAsAqZr80vDQ2Fb8C1uPx6hLNKGKSu
         6GSTW1zao7T4bXqUVuEaFidnVxo2ZsGVYQPV1t+ze4SSp+pDxc+0Ez4F3TF/fsFa2H32
         WAoSTTlbTpRj5enPhWFGzepcMTmjphqA4gzDQ/WyvOaYEQwwryHDef6ZI9/kycSqsv0G
         QnScnJgf3Il7kTU8Xi+YvvNTXwzjau8S0VKhMV+FoQjc/OvqTn7oYG9HoTRTp+3rGSWD
         e7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686878358; x=1689470358;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgPDFccY0X+baBWQrUeSsm5DEpkmq8BO0yiFecVSAqQ=;
        b=fmW0ZNr1jXdqzjFygpebB6pbHCrSl2jeABSTwLtkdHrO+onTXYQB5jMta+FFf6sK/2
         a67VCmG2MR95Vyy4qwIbi/6+JQYqoExqKza1D+4Z6ylj96WoTdkvr911wdQGED3kcS+U
         BL8zXKkkN9HAMrmyqeUV6/l41UiGoE74W8g0g2LkoPuMIbGrVejgOficHu8ToKg77lRF
         NrCLKp6YqcjK8kJIX6JbsXWxnArovhiCcaMJ5j7oXdLV3Zz54QBAGoAOIO7OImfMYPxZ
         9QGXzeSrnoARekBV3G9na1eJ6P7JkR/heE7Lo0cUEbRqjUNAxPYPvs5OMLDz6nD5ppdR
         54Jw==
X-Gm-Message-State: AC+VfDzq095PDN9wXp4ChdTLKF2TgDvGiF6kS3YrERZ4rZno30yOSHCo
        afrxRF6PC7EbuLAOrv+JF4k=
X-Google-Smtp-Source: ACHHUZ4VLNhns1dgMcnhkQopqgw1XxNKKhwnwNVS54MdWbPHolSNpR6HEAGEKOyMfjlw6t8nenKRtw==
X-Received: by 2002:a17:90b:3686:b0:25e:8076:dd04 with SMTP id mj6-20020a17090b368600b0025e8076dd04mr7062357pjb.6.1686878358398;
        Thu, 15 Jun 2023 18:19:18 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id i24-20020a17090adc1800b0024e49b53c24sm227487pjv.10.2023.06.15.18.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 18:19:18 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 632C436045A; Fri, 16 Jun 2023 13:19:14 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        martin@lichtvoll.de, fthain@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v11 2/3] block: change annotation of rdb_CylBlocks in affs_hardblocks.h
Date:   Fri, 16 Jun 2023 13:19:06 +1200
Message-Id: <20230616011907.26498-3-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230616011907.26498-1-schmitzmic@gmail.com>
References: <20230616011907.26498-1-schmitzmic@gmail.com>
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

Annotate all __u32 fields in affs_hardblocks.h as __be32, as the
on-disk format of RDB and partition blocks is always big endian.

Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Message-ID: <201206192146.09327.Martin@lichtvoll.de>
Cc: <stable@vger.kernel.org> # 5.2
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 include/uapi/linux/affs_hardblocks.h | 64 ++++++++++++++--------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/include/uapi/linux/affs_hardblocks.h b/include/uapi/linux/affs_hardblocks.h
index 5e2fb8481252..d507b3ace43d 100644
--- a/include/uapi/linux/affs_hardblocks.h
+++ b/include/uapi/linux/affs_hardblocks.h
@@ -7,42 +7,42 @@
 /* Just the needed definitions for the RDB of an Amiga HD. */
 
 struct RigidDiskBlock {
-	__u32	rdb_ID;
+	__be32	rdb_ID;
 	__be32	rdb_SummedLongs;
 	__s32	rdb_ChkSum;
-	__u32	rdb_HostID;
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
@@ -51,15 +51,15 @@ struct PartitionBlock {
 	__be32	pb_ID;
 	__be32	pb_SummedLongs;
 	__s32	pb_ChkSum;
-	__u32	pb_HostID;
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

