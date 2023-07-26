Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E44C001DC
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 19:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjGZTfk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 15:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjGZTfj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 15:35:39 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFB4E73
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 12:35:36 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-68336d06620so224585b3a.1
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 12:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690400135; x=1691004935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5g5dDMJrDnmVBYbURJxSyl07IG82zCyXPOwukTCAfBk=;
        b=kS0zfG5wc3qrKU+m4nxmvpPQazxysvfGX1GLM2Vr44NswB2vj/kBDVr4J1A3MwdLVr
         K8vw1CHN+2IiRFL/HTiL+PZ3v4cQpY7wDadlAadiKew3HLIfCYCWFk92jzuCxtZTmGKe
         +xzH9kuxHSm6OfWvW2tV3fUu7x8lBfL6sRw9aK9DXoGqRvJJjS3cW/qMV3boZkFqcEyr
         dgvfmD1U3+kafvF3maYLPqwSofc6p5nQC8MBjeoG3KGEfIsykUJ5MACRmB9EfHaAh6Qg
         vTz2w+eLr1k5SmZ2h/DGbCd4GERFVI4eIcY4A1wMFEZCT3cJq5O5gY3kFmc+keyU+Y4P
         n45A==
X-Gm-Message-State: ABy/qLYUrQwDnyQSq4zJZSMfAOFK3hH+6KpZhWbvVMXhwb1JSShOxjOx
        G2Q8QJ+iwuUtDMbUpS+9iSSTbW00QC8=
X-Google-Smtp-Source: APBJJlEl1g3vhRzz8R5sWC2162DA2g4F9kH2BjVdNcMky9ozXLdMMwIc8F+aKXhZ1uOZw8DyI8A9Pw==
X-Received: by 2002:a05:6a00:1503:b0:64d:46b2:9a58 with SMTP id q3-20020a056a00150300b0064d46b29a58mr3889745pfu.26.1690400135435;
        Wed, 26 Jul 2023 12:35:35 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:32d2:d535:b137:7ba3])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b00682ba300cd1sm11846685pfu.29.2023.07.26.12.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 12:35:35 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Chao Yu <chao@kernel.org>
Subject: [PATCH v4 7/7] fs/f2fs: Disable zone write locking
Date:   Wed, 26 Jul 2023 12:34:11 -0700
Message-ID: <20230726193440.1655149-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230726193440.1655149-1-bvanassche@acm.org>
References: <20230726193440.1655149-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Set the REQ_NO_ZONE_WRITE_LOCK flag to inform the block layer that F2FS
allocates and submits zoned writes in LBA order per zone.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5882afe71d82..87ef089f1e88 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -468,8 +468,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	struct bio *bio;
 
 	bdev = f2fs_target_device(sbi, fio->new_blkaddr, &sector);
-	bio = bio_alloc_bioset(bdev, npages,
-				fio->op | fio->op_flags | f2fs_io_flags(fio),
+	bio = bio_alloc_bioset(bdev, npages, fio->op | fio->op_flags |
+				f2fs_io_flags(fio) | REQ_NO_ZONE_WRITE_LOCK,
 				GFP_NOIO, &f2fs_bioset);
 	bio->bi_iter.bi_sector = sector;
 	if (is_read_io(fio->op)) {
