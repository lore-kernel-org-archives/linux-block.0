Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E861EB64DD
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 03:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242686AbjFODIv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 23:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237578AbjFODIq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 23:08:46 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011AF26AF;
        Wed, 14 Jun 2023 20:08:45 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-66615629689so1729125b3a.2;
        Wed, 14 Jun 2023 20:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686798525; x=1689390525;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RoV0x9WE7V+PqzE8yThOC56S+yTbJpuP21/lZAkY6fA=;
        b=HpOoYguVYnfHYMwJJdQd+bP6RftVhFB8wJZ9pVJIgHnb6jvfzadS1DrEBpmkXAcAIp
         6fKg46p9QCCHdiHDQ7npw1T//lfTpYP1jrCGQIQocR1H9sfsJZ7JcimBnhf1iUqvqGxe
         zxqG1EN4jPBeg9cc6+in3qJnRXmZqDtf8INjKgKyX53Xr0Ggg6u3CGMKW+Y7Va3VQwmr
         qYsi/sVoUO9qS1TOEvNLnUjid3ePqdR2QV/jOcbu7kAlBUCxEjmOCxNZp3bPWJF4gAz2
         QRkcfiuhn/fUILCf9usOFTnb3g/k2oKtGhRzUYxnJOWd764clurI/l+eNuRdav/2OuBW
         SMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686798525; x=1689390525;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RoV0x9WE7V+PqzE8yThOC56S+yTbJpuP21/lZAkY6fA=;
        b=Pd7B4EwrUzb0PTTmEYrRAx+RGCXwSzYV1bNAAGFrIx3tNNcME8md5ZzsOJA82hwwtp
         Eu3Eeh1+bfue+KSjqOOHF3ExydoidO1icNVh51x9UDVcPOluzAuY0gyc0YXNNVnvUb8y
         FuyWb4cBJ4tQoqVa5sdNYIfYg2FD7p8EK54QX4ydLoONfopaHlMkWcSTah7iMrDShoqr
         ZqC5jRQGLRoSpipOCIwbJ+CeY7FjYa23HIeoIWUFZFrKg1CEpC2INAdsSgdj07vKHqE6
         rlqTM3oQZEr51emfqbeTc6h46h0Xo6xUdseXPIOIQ09FpvqNSPWDVgR5qUx/hkti5LQf
         BiSg==
X-Gm-Message-State: AC+VfDzQDB9n2SLdEp3qm8phJU6HLF+b0m++F6ObmdxIqtZk/J3KCASY
        nz8zuZAyruFmV+ljnlAWga589//CgXY=
X-Google-Smtp-Source: ACHHUZ67YkksXQmUFva07EdhKPHhbjDo/M+QMgNaiACsn1put/2GZw2jR/+d5rPfKxyUHhqxT6lquQ==
X-Received: by 2002:a05:6a20:8f0b:b0:107:1805:feea with SMTP id b11-20020a056a208f0b00b001071805feeamr4111842pzk.37.1686798525426;
        Wed, 14 Jun 2023 20:08:45 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id v21-20020a631515000000b00543c6d7dbd7sm11785689pgl.24.2023.06.14.20.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 20:08:44 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 94C78360370; Thu, 15 Jun 2023 15:08:41 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        martin@lichtvoll.de, fthain@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v10 2/3] block: change annotation of rdb_CylBlocks in affs_hardblocks.h
Date:   Thu, 15 Jun 2023 15:08:36 +1200
Message-Id: <20230615030837.8518-3-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230615030837.8518-1-schmitzmic@gmail.com>
References: <20230615030837.8518-1-schmitzmic@gmail.com>
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

Annotate rdb_CylBlocks field as big endian to shut up the warning.
Add comment to document that the same annotation is going to be
needed for any other fields that may be used by the kernel in
future.

Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Message-ID: <201206192146.09327.Martin@lichtvoll.de>
Cc: <stable@vger.kernel.org> # 5.2
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
---
 include/uapi/linux/affs_hardblocks.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/affs_hardblocks.h b/include/uapi/linux/affs_hardblocks.h
index 5e2fb8481252..9da5bc607939 100644
--- a/include/uapi/linux/affs_hardblocks.h
+++ b/include/uapi/linux/affs_hardblocks.h
@@ -6,6 +6,11 @@
 
 /* Just the needed definitions for the RDB of an Amiga HD. */
 
+/* MSch 20230615: any field used by the Linux kernel must be
+ * annotated __be32! If any fields require increase to 64
+ * bit size, rdb_ID _must_ be changed!
+ */
+
 struct RigidDiskBlock {
 	__u32	rdb_ID;
 	__be32	rdb_SummedLongs;
@@ -32,7 +37,7 @@ struct RigidDiskBlock {
 	__u32	rdb_RDBBlocksHi;
 	__u32	rdb_LoCylinder;
 	__u32	rdb_HiCylinder;
-	__u32	rdb_CylBlocks;
+	__be32	rdb_CylBlocks;
 	__u32	rdb_AutoParkSeconds;
 	__u32	rdb_HighRDSKBlock;
 	__u32	rdb_Reserved4;
-- 
2.17.1

