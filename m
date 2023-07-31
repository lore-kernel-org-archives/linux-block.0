Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66C1C001DF
	for <linux-block@archiver.kernel.org>; Mon, 31 Jul 2023 12:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjGaMwb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jul 2023 08:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjGaMwa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2023 08:52:30 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A353EB8
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 05:52:29 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230731125227epoutp0375da9af51e53598fb281536ae37f8d64~29N7Ma2_D0200502005epoutp03A
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 12:52:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230731125227epoutp0375da9af51e53598fb281536ae37f8d64~29N7Ma2_D0200502005epoutp03A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690807947;
        bh=hKypVF/iC5KyqOUQrYuiPEcU/QBxpLeFbPvAkCacQF0=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=aQI84e0pLqFoFqlh7fCjt0qULxBQg677EfKqE4/xxCy8TMfKQHzQH+XFxemEqXAhC
         9DiHJ/copoUA38JOotAMv8mxcvrliFrp5VsjjBcJ6e5+fS+nKS7RoI7kepJNkPsaWC
         Z0lS4wA7YdK4axOKJPsGcOrSAVHR2QQYGAMYsi8Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230731125226epcas2p3e8b086a0f4e43ed8f9530be5fa33a501~29N6FDBmK1112211122epcas2p3K;
        Mon, 31 Jul 2023 12:52:26 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RDynQ0yCjz4x9Pv; Mon, 31 Jul
        2023 12:52:26 +0000 (GMT)
X-AuditID: b6c32a45-83dfd7000000c2f9-69-64c7ae89e16d
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.F4.49913.98EA7C46; Mon, 31 Jul 2023 21:52:26 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 2/4] bio-integrity: Sets the payload size in
 bio_integrity_add_page()
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung Choi <j-young.choi@samsung.com>
From:   Jinyoung Choi <j-young.choi@samsung.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5@epcms2p5>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230731125224epcms2p7e3c5bbe1fd544c0fd586520b2d155872@epcms2p7>
Date:   Mon, 31 Jul 2023 21:52:24 +0900
X-CMS-MailID: 20230731125224epcms2p7e3c5bbe1fd544c0fd586520b2d155872
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdljTXLdr3fEUg98HGS1W3+1ns5h1+zWL
        xctDmhaTDl1jtNh7S9vi8q45bBbLj/9jslj3+j2LA4fH+XsbWTwuny312LSqk83j49NbLB59
        W1YxenzeJOfRfqCbKYA9KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
        1VbJxSdA1y0zB+gkJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWle
        ul5eaomVoYGBkSlQYUJ2xqpP19gKlihUTPi0lr2BsUO6i5GTQ0LARKL90QM2EFtIYAejRMcn
        py5GDg5eAUGJvzuEQUxhgSiJua+0ISqUJM6tmcUIYgsLGEi03G5jAbHZBPQkdjzfzd7FyMUh
        IvCZSeLyjw+sEON5JWa0P2WBsKUlti/fCtbMKeAnMfX6WyaIuIbEj2W9zBC2qMTN1W/ZYez3
        x+YzQtgiEq33zkLVCEo8+LkbKi4pcejQVzaQOyUE8iU2HAiECNdItP16D1WuL3GtYyPYCbwC
        vhJPOmaCrWURUJXo+doJNcZF4ubUk2A1zALyEtvfzmEGGcksoCmxfpc+xHRliSO3oCr4JDoO
        /2WHebBh42+s7B3znjBBtKpJLGoyggjLSHw9PJ99AqPSLEQoz0KydhbC2gWMzKsYxVILinPT
        U4uNCgzh8Zqcn7uJEZwwtVx3ME5++0HvECMTB+MhRgkOZiUR3lMBh1KEeFMSK6tSi/Lji0pz
        UosPMZoCPTyRWUo0OR+YsvNK4g1NLA1MzMwMzY1MDcyVxHnvtc5NERJITyxJzU5NLUgtgulj
        4uCUamBqVPxY4nXskdaJK2vTtIr0JBVNeRyY/vm63ZgqfONZ0g/1+IiTc9ya+//enyU9O3hm
        cLE9w4tv/yXWnPKakMo+xyf8cOWszfFzMqWlc68E3/y2JvZyxrF/h+3rzeV7uudkc/cmtny6
        tW8zsxK77lfhF47OnO9iGCfsLCubVb98uz3fv30ndi2Nm3l8z0vrNR9eeR9+s/FmD4+cVUCK
        l4eBaYSUtpn6m9ZF298vu7F0vawIU77XudUf5BRWWfs8m6DfOXn9hAixPelP+i7bFXW4KM4R
        m9Q8cQ/Lw5kLTE5tf8vJPMGQweU3c+LcxZxr22eEuXdum8hkw/afO+DixrCSlyGiH1hqZjPJ
        HZm707ZNiaU4I9FQi7moOBEAMgfetiEEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5
References: <20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5@epcms2p5>
        <CGME20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5@epcms2p7>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Previously, the bip's bi_size has been set before an integrity pages
were added. If a problem occurs in the process of adding pages for
bip, the bi_size mismatch problem must be dealt with.

When the page is successfully added to bvec, the bi_size is updated.

The parts affected by the change were also contained in this commit.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/bio-integrity.c               | 2 +-
 drivers/md/dm-crypt.c               | 1 -
 drivers/nvme/host/ioctl.c           | 1 -
 drivers/nvme/target/io-cmd-bdev.c   | 3 +--
 drivers/target/target_core_iblock.c | 3 +--
 5 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 045553a164e0..6220a99977a4 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -137,6 +137,7 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 
 	bvec_set_page(&bip->bip_vec[bip->bip_vcnt], page, len, offset);
 	bip->bip_vcnt++;
+	bip->bip_iter.bi_size += len;
 
 	return len;
 }
@@ -244,7 +245,6 @@ bool bio_integrity_prep(struct bio *bio)
 	}
 
 	bip->bip_flags |= BIP_BLOCK_INTEGRITY;
-	bip->bip_iter.bi_size = len;
 	bip_set_seed(bip, bio->bi_iter.bi_sector);
 
 	if (bi->flags & BLK_INTEGRITY_IP_CHECKSUM)
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 1dc6227d353e..f2662c21a6df 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1160,7 +1160,6 @@ static int dm_crypt_integrity_io_alloc(struct dm_crypt_io *io, struct bio *bio)
 
 	tag_len = io->cc->on_disk_tag_size * (bio_sectors(bio) >> io->cc->sector_shift);
 
-	bip->bip_iter.bi_size = tag_len;
 	bip->bip_iter.bi_sector = io->cc->start + io->sector;
 
 	ret = bio_integrity_add_page(bio, virt_to_page(io->integrity_metadata),
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 5c3250f36ce7..19a5177bc360 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -118,7 +118,6 @@ static void *nvme_add_user_metadata(struct request *req, void __user *ubuf,
 		goto out_free_meta;
 	}
 
-	bip->bip_iter.bi_size = len;
 	bip->bip_iter.bi_sector = seed;
 	ret = bio_integrity_add_page(bio, virt_to_page(buf), len,
 			offset_in_page(buf));
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 2733e0158585..468833675cc9 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -206,12 +206,11 @@ static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
 		return PTR_ERR(bip);
 	}
 
-	bip->bip_iter.bi_size = bio_integrity_bytes(bi, bio_sectors(bio));
 	/* virtual start sector must be in integrity interval units */
 	bip_set_seed(bip, bio->bi_iter.bi_sector >>
 		     (bi->interval_exp - SECTOR_SHIFT));
 
-	resid = bip->bip_iter.bi_size;
+	resid = bio_integrity_bytes(bi, bio_sectors(bio));
 	while (resid > 0 && sg_miter_next(miter)) {
 		len = min_t(size_t, miter->length, resid);
 		rc = bio_integrity_add_page(bio, miter->page, len,
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 3d1b511ea284..a7050f63b7cc 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -689,7 +689,6 @@ iblock_alloc_bip(struct se_cmd *cmd, struct bio *bio,
 		return PTR_ERR(bip);
 	}
 
-	bip->bip_iter.bi_size = bio_integrity_bytes(bi, bio_sectors(bio));
 	/* virtual start sector must be in integrity interval units */
 	bip_set_seed(bip, bio->bi_iter.bi_sector >>
 				  (bi->interval_exp - SECTOR_SHIFT));
@@ -697,7 +696,7 @@ iblock_alloc_bip(struct se_cmd *cmd, struct bio *bio,
 	pr_debug("IBLOCK BIP Size: %u Sector: %llu\n", bip->bip_iter.bi_size,
 		 (unsigned long long)bip->bip_iter.bi_sector);
 
-	resid = bip->bip_iter.bi_size;
+	resid = bio_integrity_bytes(bi, bio_sectors(bio));
 	while (resid > 0 && sg_miter_next(miter)) {
 
 		len = min_t(size_t, miter->length, resid);
-- 
2.34.1
