Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA58C0015E
	for <linux-block@archiver.kernel.org>; Mon,  3 Jul 2023 23:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGCXIL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jul 2023 19:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGCXIK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jul 2023 19:08:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82D2186;
        Mon,  3 Jul 2023 16:07:59 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666edfc50deso3134659b3a.0;
        Mon, 03 Jul 2023 16:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688425679; x=1691017679;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30zNCo+aXEcdrX1BYZ3Jkoz9pf4nQ32fKAkcmaAbuak=;
        b=gSUs7NtBYHwpeLLg17wEsJTefX77ut3A/4nFbS2k2LZV2Lxv6cF/guao2w3TCt+PNu
         JVSvokGP/0Z2tkeVM0buJ0VcckFpwfJKML4tznnFa/Im8Fd/A28b6nWRuANIn5dTXyPa
         5jCFTeRehKQHIAmHDJeDIsu+rm4LgBgfeqwtLg3Cx3ahVVkuWIulpSWP9Jv6EBw9LW4B
         D8dO1IUj6WyPY5ZT6gj6hcaekGunAjSfeOIaLiH1uZazZH14nBqwlQvzYmFDfWZ9tbCH
         64sZ9kyOoICO8dLTZWI+ggvvFv8vpa6GvlgLiQrXZUGefwOKdiIjL/haWUeQM13mAlJv
         LOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688425679; x=1691017679;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30zNCo+aXEcdrX1BYZ3Jkoz9pf4nQ32fKAkcmaAbuak=;
        b=H+ELCeOB7fU3gjAImwYUCIWfAN5oC7HFuL/250B0N5tuIXQEbNUWM9YyPR4p+eOlZ2
         u/MGDPO9Eo0LbhHTaPlV+pi6S23IJ/LkmkQKcknBzz5Na5A6TQa6MzZJVeetz/e+zqTY
         rebPzL1e/Gq1O2WUebT54CRXCB6PvjSH9n+MliwbjhMX28Jqu9lFvIw7ZmM/XjaZFhpL
         pBaB29xAoAbnhX1Ao8rAwnZ/hUltg5FtEhCQJAHz+dCyjp6ENFe4boSGnnzcnMAGyWQN
         ziUBy/Vc9AtwJixyRKj8cxihJvr39IDkohElZCXp+4mwSS1q1dY9mcPVnMU6Lox+Wppv
         r7wA==
X-Gm-Message-State: AC+VfDzxKwhpgdfLTYfQUyf/YXY3qZFCLJy3NEqphvsF6ZZBhn8jjZPK
        reR1GwcMKXpNlgCi7DyKRt8=
X-Google-Smtp-Source: ACHHUZ7gcOaPDsbNzc5xwNmjHgIPbfFNvEWUcCtR2orYaGicSiZSsbCe/eSSHHqXKJ3OKv6MfQAlGQ==
X-Received: by 2002:a05:6a00:1388:b0:668:93e7:6800 with SMTP id t8-20020a056a00138800b0066893e76800mr25863549pfg.14.1688425678950;
        Mon, 03 Jul 2023 16:07:58 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.gmail.com with ESMTPSA id y19-20020aa78553000000b0066f37665a63sm9982670pfn.73.2023.07.03.16.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 16:07:58 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 9EBA8360319; Tue,  4 Jul 2023 11:07:54 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de,
        geert@linux-m68k.org, hch@lst.de, martin@lichtvoll.de,
        Michael Schmitz <schmitzmic@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v2] block: bugfix for Amiga partition overflow check patch
Date:   Tue,  4 Jul 2023 11:07:52 +1200
Message-Id: <20230703230752.13394-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
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

Testing by Christian also exposed another aspect of the old
bug fixed in commits fc3d092c6b ("block: fix signed int
overflow in Amiga partition support") and b6f3f28f60
("block: add overflow checks for Amiga partition support"):

Partitons that did overflow the disk size (due to 32 bit int
overflow) were not skipped but truncated to the end of the
disk. Users who missed the warning message during boot would
go on to create a filesystem with a size exceeding the
actual partition size. Now that the 32 bit overflow has been
corrected, such filesystems may refuse to mount with a
'filesystem exceeds partition size' error. Users should
either correct the partition size, or resize the filesystem
before attempting to boot a kernel with the RDB fixes in
place.

Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Fixes: b6f3f28f60 ("block: add overflow checks for Amiga partition support")
Message-ID: 024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
Cc: <stable@vger.kernel.org> # 6.4
Link: https://lore.kernel.org/r/024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>

--

Changes since v1:

- corrected Fixes: tag
- added Tested-by:
- reworded commit message to describe filesystem partition
  size mismatch problem
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

