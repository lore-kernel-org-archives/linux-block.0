Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA048C001B0
	for <linux-block@archiver.kernel.org>; Tue,  4 Jul 2023 23:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGDXi1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jul 2023 19:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjGDXiY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jul 2023 19:38:24 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E01BD;
        Tue,  4 Jul 2023 16:38:24 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a04e5baffcso4678901b6e.3;
        Tue, 04 Jul 2023 16:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688513903; x=1691105903;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e6fOv3KfpYRgxDp5NnegPjCOw+kqjU07ZSKbfN9Zafw=;
        b=XUnbSQnr5C6k/HBziBsOf6Gx2Favu7CkdlNpOpQRxw0Kgowx3mUIUL9upitJ8RLoz0
         WApwn7CE73qZX2NrAzDb/B39IvONmSNdICWbXxMVBWhOOoUDdIMqoGLiknwJ7C0gVLlV
         RvWM1CtMPIra2uqeDeRVFOukjUNbpA1uK5qR111kfGxthergG869EKQwBkqCDuZ9EXmt
         Y0TFPhePbhTlqH9a/z5Hbwx1ZOOPmVMtdGCa+THnU+7m5C8LX1nPy6Dejuw5mUY6SdUr
         4bPr8dvfv51e4A8r+nhyTi3AkVqcGPyOfhihqABD52YFabtDChCEO04/iX8O8NWxlGX0
         Y6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688513903; x=1691105903;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6fOv3KfpYRgxDp5NnegPjCOw+kqjU07ZSKbfN9Zafw=;
        b=keQ2UySaiPyT0MstwcdG/P2QW5lESYSPS/LZ+DjhMysoxrfbgYcdcD0c7/L33kEaUQ
         BpSbHrcuDpNt6A30ChJsvcY8Kq2SgBTX+VwQQ8PJ4SYVamvVtJzpZTxjR2KXmpt2Y7UL
         aOeL3RkgDh3Y2hDlhu7GjBTgS3gcTSHnySn31yivgobhZXXQQ8v94PIQ5QDBm9gpRUDL
         VTxETd30enjI3XfojfGS6ou7wOg4C45XeyjhCrAmZkMvfraaZvyRq/mG2ajqfK8pw3sW
         yHo6o75izNqOglg0uFd+nhIqkGw/Jn+Cj30Pr/dK3qm8WC9fgYHm9j7P4QQUUoIKX5Vj
         bm2w==
X-Gm-Message-State: AC+VfDxtJ6JcvH5V9qoFYrlvSbHAnUWQlvN1qZTY0+zgsW2rQo4lpqcM
        BsRaTGp9KRloCZxO8ltRMHei9PLYb0YcSA==
X-Google-Smtp-Source: ACHHUZ5BriiXdRxvI6+OWJnyU1ruKdO37WbqxE3Y+fdZCQOhxWwLy2sVTMZ4um7Uq9d24v3z7bl11g==
X-Received: by 2002:a05:6808:1294:b0:3a3:82a1:d1e7 with SMTP id a20-20020a056808129400b003a382a1d1e7mr16491226oiw.6.1688513903535;
        Tue, 04 Jul 2023 16:38:23 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.gmail.com with ESMTPSA id a15-20020aa7864f000000b0066883d75932sm14045569pfo.204.2023.07.04.16.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 16:38:23 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id C24AA360370; Wed,  5 Jul 2023 11:38:19 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de,
        geert@linux-m68k.org, hch@lst.de, martin@lichtvoll.de,
        Michael Schmitz <schmitzmic@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v4 1/1] block: bugfix for Amiga partition overflow check patch
Date:   Wed,  5 Jul 2023 11:38:08 +1200
Message-Id: <20230704233808.25166-2-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230704233808.25166-1-schmitzmic@gmail.com>
References: <20230620201725.7020-1-schmitzmic@gmail.com>
 <20230704233808.25166-1-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Making 'blk' sector_t (i.e. 64 bit if LBD support is active)
fails the 'blk>0' test in the partition block loop if a
value of (signed int) -1 is used to mark the end of the
partition block list.

This bug was introduced in patch 3 of my prior Amiga partition
support fixes series, and spotted by Christian Zigotzky when
testing the latest block updates.

Explicitly cast 'blk' to signed int to allow use of -1 to
terminate the partition block linked list.

Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Fixes: b6f3f28f60 ("block: add overflow checks for Amiga partition support")
Message-ID: 024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
Cc: <stable@vger.kernel.org> # 5.2
Link: https://lore.kernel.org/r/024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Reviewed-by: Martin Steigerwald <martin@lichtvoll.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>

--

Changes since v1:

- corrected Fixes: tag
- added Tested-by:
- reworded commit message to describe filesystem partition
  size mismatch problem

Changes since v2:

Adrian Glaubitz:
- fix typo in commit message

Changes since v3:

Greg KH:
- fix stable tag

Geert Uytterhoeven:
- revert changes to commit message since v1
---
 block/partitions/amiga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
index ed222b9c901b..506921095412 100644
--- a/block/partitions/amiga.c
+++ b/block/partitions/amiga.c
@@ -90,7 +90,7 @@ int amiga_partition(struct parsed_partitions *state)
 	}
 	blk = be32_to_cpu(rdb->rdb_PartitionList);
 	put_dev_sector(sect);
-	for (part = 1; blk>0 && part<=16; part++, put_dev_sector(sect)) {
+	for (part = 1; (s32) blk>0 && part<=16; part++, put_dev_sector(sect)) {
 		/* Read in terms partition table understands */
 		if (check_mul_overflow(blk, (sector_t) blksize, &blk)) {
 			pr_err("Dev %s: overflow calculating partition block %llu! Skipping partitions %u and beyond\n",
-- 
2.17.1

