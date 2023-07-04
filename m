Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA205EB64DD
	for <linux-block@archiver.kernel.org>; Tue,  4 Jul 2023 05:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjGDFuF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jul 2023 01:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGDFuE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jul 2023 01:50:04 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B9DEE;
        Mon,  3 Jul 2023 22:50:03 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-56597d949b1so3548567eaf.1;
        Mon, 03 Jul 2023 22:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688449801; x=1691041801;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zamxSwVQK9aC0g6pMD2q0YTDJfFCe+tp404LSKnDSpo=;
        b=GNh03kO2ZRUg0YKACbzje2SOnj/s6UsiCTvP4DFJBXfNzgiLYNULDTVN5xT6F9W1C7
         P0MnLWKMlPqqzI94DjhD867VyIGJzQG+E4noapOnpH9Nbv7O19oliA9WqfEB1WhwIrL9
         bBs9gpCJ7aQ5zs/Oo9AECNaA++zHkZJ2CoEsRP4wzK+Syl6mOMSdncMq7FA6vFGit0vm
         Dx2FsXsDhaaulm/1sG/QDWK9mi/JCViBLNem/q/hqkYbzy3c+C2wRnN4ZmZvcUngDAws
         +OF3+KiA32hgLAEhVbJ3ka1+ttIW36XvXobMnP8Hw+orVDnbmF5upvYOrnQWtK/ooNu+
         lgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688449801; x=1691041801;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zamxSwVQK9aC0g6pMD2q0YTDJfFCe+tp404LSKnDSpo=;
        b=OkdQI0V962augj1I8BdJO/hDJ6784vaXI4N1h/ZNtmsaJ9e7WD9r1EVl91HUShjqUq
         bo6F6cCa5sDIhrHwabbeayqFPD/VtifVBAZ9R3QLo8yiKIhUF7DnzCnTbEzuHN4FFgw5
         Aplo5zllpENCV1iw5n618nmj+gRIeLGwPuYshlVP4TzrVaDUXEJaCj4+WSfCFGDdAS0e
         mWHCykpd1OcS3a8MxvKn5/hW5SwzUk6+fvPIF7biCcw/kfFfCVUXxw6O0qQ/BppyvNnb
         8h2SjAgl0d0ZsTCaGPmKHISo9rOK8neH5nkAfLhFqL0jldugbJk9cVl2D+ocQYnElLGM
         /FKw==
X-Gm-Message-State: ABy/qLYmkIujwL1izKIadVa7I5+Yn2vxNq+oz/H89uxDkJYKTQ7QBfSd
        Q8FyzNAe1wPu83wF6DAbFh0=
X-Google-Smtp-Source: APBJJlEi81K1c6bR2jRrcj8oqwrmwWl+90EijZmqG62eZax8j4AvDVFALDlzpky+y9tXVnUbClgx4g==
X-Received: by 2002:a05:6358:5115:b0:134:e41a:9227 with SMTP id 21-20020a056358511500b00134e41a9227mr7834759rwi.5.1688449800684;
        Mon, 03 Jul 2023 22:50:00 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.gmail.com with ESMTPSA id iz21-20020a170902ef9500b001b807863627sm13627379plb.194.2023.07.03.22.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 22:50:00 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 13E75360319; Tue,  4 Jul 2023 17:49:57 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de,
        geert@linux-m68k.org, hch@lst.de, martin@lichtvoll.de,
        Michael Schmitz <schmitzmic@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v3] block: bugfix for Amiga partition overflow check patch
Date:   Tue,  4 Jul 2023 17:49:55 +1200
Message-Id: <20230704054955.16906-1-schmitzmic@gmail.com>
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

Partitions that did overflow the disk size (due to 32 bit int
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

Changes since v2:

Adrian Glaubitz:
- fix typo in commit message

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

