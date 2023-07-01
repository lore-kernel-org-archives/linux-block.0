Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373A2EB64DA
	for <linux-block@archiver.kernel.org>; Sat,  1 Jul 2023 02:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjGACh4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Jun 2023 22:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjGAChm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2023 22:37:42 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7FE44B0;
        Fri, 30 Jun 2023 19:35:31 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-765a6bbddd6so233229185a.0;
        Fri, 30 Jun 2023 19:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688178930; x=1690770930;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0z2JwK1RrLjO9rd7bUAW0h8yDPkiVe+KUjRl/TttWdo=;
        b=RJ6uk2LkUUdpHJxoGZsLheBAoPGgdMejv/jD37sHByR8Mdb2SDnV9KGNxwUxvrM4JZ
         y/alIuH7vSSUvJl24tVndCm755nKVL3FopivY1CNG9ByPwCYhVSZDuW6iCR9hJjg+1DE
         GEoh0rn6izPL+v7xn00FavCIzjKFL9SUHlEw2k/6R9ykt67Yf0Cl5gIRjbIV/4I/3VP0
         r6H09WYaZGjAa5DeIHXb82CagkMQXL3U0BaEzZFpS/VOM7viGc7PvvZD2VCHae/4BfnQ
         4hZ7EGXet6J9z6NJliqH5qcOpACHtDkg6FI3iS8YPgtBkvROz3+dJe/zZPg4HWz/Y+wx
         TlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688178930; x=1690770930;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0z2JwK1RrLjO9rd7bUAW0h8yDPkiVe+KUjRl/TttWdo=;
        b=Ym0tyNdrxU17szIz0pO0wlHTWNVFBMCnW7ubUm2LTZW+g6TxpaQnHdoR+5mcJVu4Sj
         Z6tmKFm0XJQOUSQTrqNh4+rsFRQm7JiaQrb2rEZxwvZZ6aZI6Q7R3C0oHkgbccYIqrX8
         75r9hGH7WDAjivBjAdTuqRA9ceQBlooOuGqP/QnPNU6sr48Jc0ms0HN3tDpBBZQgrAx8
         qsfBHzsu7iK6u+UYgWIw0qLLARVLVKI7UFzo7tUx7AbWC5QZopBHl3ABL099Kwu79aPW
         UERjsgJeRoRTZrneQ2VSZAkm2A0eIAa7fH3+smRmvVGOYoTHN/BhjSIunUq2mJP/ilVy
         X7pQ==
X-Gm-Message-State: AC+VfDxl4CE1OpJhunx662ICaTGEYG8TdS5/d8hLNWytuJ0oZMsVofUA
        bvNoO1oxY7fXuYF3yQpB9Ko=
X-Google-Smtp-Source: ACHHUZ5AeASuq18tzxZAjVAgnmo2eS+teacxv7pTfdVV2/3zL+UqpyodBAa3HHw8BaOZrrONckNjuw==
X-Received: by 2002:a05:620a:4082:b0:767:954:a743 with SMTP id f2-20020a05620a408200b007670954a743mr5120547qko.51.1688178930463;
        Fri, 30 Jun 2023 19:35:30 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.gmail.com with ESMTPSA id s11-20020a62e70b000000b00663ab37ff74sm10030026pfh.72.2023.06.30.19.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 19:35:30 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 673CB360319; Sat,  1 Jul 2023 14:35:26 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de,
        geert@linux-m68k.org, hch@lst.de, martin@lichtvoll.de,
        Michael Schmitz <schmitzmic@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] block: bugfix for Amiga partition overflow check patch
Date:   Sat,  1 Jul 2023 14:35:24 +1200
Message-Id: <20230701023524.7434-1-schmitzmic@gmail.com>
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

Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Fixes: b6f3f28f60 ("Linux 6.4")
Message-ID: 024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
Cc: <stable@vger.kernel.org> # 6.4
Link: https://lore.kernel.org/r/024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
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

