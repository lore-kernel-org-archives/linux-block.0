Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B63C54EBC
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 14:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbjAJOgp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 09:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjAJOgo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 09:36:44 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775D443A26
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 06:36:42 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230110143639euoutp01fc9a82b364b3f634594bab54bd64f800~4_VPAclvP3204332043euoutp017
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 14:36:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230110143639euoutp01fc9a82b364b3f634594bab54bd64f800~4_VPAclvP3204332043euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673361399;
        bh=G/NS82KayjnGwwjEEFhhHx3EPrjIVAhcZLJ4LNXd4zM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMdvrEW7jcP+qwuS6nc0Jn+dzBDRkomY7hy3TU1NLjJWQW0GbH6uBBJWF4J5rwMBb
         /xmon9NmJgYupcxuq/lDR7lO4rSe/0GjzHJLf6idikUC/crS+O3LJd1dS/mxm+eMw+
         myQg5DYAzuctUIYI2i6aKq890cFBc7dDE22C+E+A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230110143638eucas1p29d4ef05afa377a30424445d5d08ceda7~4_VOS8wPO2559425594eucas1p27;
        Tue, 10 Jan 2023 14:36:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 18.A6.56180.6F77DB36; Tue, 10
        Jan 2023 14:36:38 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230110143638eucas1p1551ada551876f82df671162860f08d7d~4_VN9kV5o1940819408eucas1p1R;
        Tue, 10 Jan 2023 14:36:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230110143638eusmtrp2253f535994defd647ada71e3498fafc3~4_VN8zmqG0701607016eusmtrp2W;
        Tue, 10 Jan 2023 14:36:38 +0000 (GMT)
X-AuditID: cbfec7f2-ab5ff7000000db74-09-63bd77f67d21
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D4.1C.23420.6F77DB36; Tue, 10
        Jan 2023 14:36:38 +0000 (GMT)
Received: from localhost (unknown [106.210.248.241]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230110143638eusmtip1b69c7bedc2a1239472475578e3da8991~4_VNx7tui1830618306eusmtip1P;
        Tue, 10 Jan 2023 14:36:38 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, bvanassche@acm.org,
        linux-block@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        gost.dev@samsung.com, snitzer@kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2 2/3] block: add a new helper bdev_{is_zone_start,
 offset_from_zone_start}
Date:   Tue, 10 Jan 2023 15:36:34 +0100
Message-Id: <20230110143635.77300-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110143635.77300-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURiFvTPtdFqtjgXpH1HQJsSIASQxOgouGB8mIUYffBKt1HYEtRTs
        Iq5YNhfQukRQEMUFZIupIigVECQoixAakYhWMNGiUnFBQK1sUqZG385//+/cc09ySVxi5s8m
        d2r0rFajUMsIEe/eE2dbwI/4auXiImsQXdJ1mqAzvzlxeri1Dadf1lowuqjkMUb3dGRjdPWr
        RXTuzR4BPZCfIqAbX3mvETHtz8OZ9lYDU1p8gmDu5h1hKl8aCeZU8heCsaS+4TOmsmLEDJT6
        bBRuFoWqWPXOvaw2aFWkKNqYN4rizkv2fbthFRiRcUYaEpJALYH79TUoDYlICVWIoNr2g+CG
        QQTOpH4+NwwgKB7qI/5aUqsKBdyiAMHp9D63vxfBp2tZExRJEpQ/JJ4QuAyelAfUHE/luRic
        GkEw3tXEcy08KDm86+jAXZpH+cGzD98ntZhaDi+G6nlcmi9kPfs5eZGQWgHWs8OIY2ZCU5Z9
        ksEnmOTyS7grAKiPJCSN1Ag48zoor8jhc9oDHA1l7vM5MG7JxTh9EHo6h93mlIk6FvNkA6BC
        wNSidkmcWgjmB0EcHgamX/luYjp0fp7JPWE6nLt3AeeOxXD8qISjZWBx2t2hAO1JOe5WDFR3
        nyTOoPnZ/5XJ/q9M9r/cqwgvRlLWoIuJYnXBGjY+UKeI0Rk0UYHK2JhSNPGnno41fK9Alx39
        gXUII1EdAhKXeYqLhFVKiVil2H+A1cZu0xrUrK4OeZM8mVR8sTxXKaGiFHp2N8vGsdq/W4wU
        zjZiayNqvWKn4qOhjbtG5aE5Wc7hHZGtO6xWQ3N4CAr1Nen5Gzb4HlHFLUn5cO1t423jRd2C
        1RAoVTtKGgdTVacqFKo7DclzE8TRjgz7qm7jUnn+4PmEMdvQWr+hzlsR4dttY5p56YmtwfdF
        Fes7l+XZp+l5HrFLA47VxtdgG71t3W/jsd8+/mU+41e22qUj1wMS+pRhEYe21Ulz2uR+o3vo
        qMhZu9N7xzuu+u678HWarX9KyIrgpoY26bmWd6gyM+PzloKIJPxhU9/62kVpKttHI6buWfnr
        0NmEM+Zur6+OR703j246Zn/tVWiqv9UeZpYfphMzNnfNu0tm6omCZs/3KhlPF60I9se1OsUf
        A2LiasIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xu7rfyvcmGzy5I2ux+m4/m8W0Dz+Z
        LX6fPc9scfPATiaLlauPMlk8vTqLyWLvLW2L+cueslt8XtrCbnHilrQDl8flK94el8+Wemxa
        1cnmsXlJvcfumw1sHr3N79g8drbeZ/Xo27KK0ePzJrkAzig9m6L80pJUhYz84hJbpWhDCyM9
        Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jIYlfxkLpghVfFh8gb2BsYG/i5GTQ0LA
        RKJ1zwr2LkYuDiGBpYwS+5+uYYRISEjcXtgEZQtL/LnWxQZR9JxRovfFRdYuRg4ONgEticZO
        dpAaEaCa/R2tLCA1zAJtTBKrln1gAkkIC8RIHD4+kQ3EZhFQlbj0/BMziM0rYClx/esRFogF
        8hIzL30HG8QpYCVxYeJvRpD5QkA1/RelIcoFJU7OfAJWzgxU3rx1NvMERoFZSFKzkKQWMDKt
        YhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIynbcd+bt7BOO/VR71DjEwcjIcYJTiYlUR4V3Lu
        SRbiTUmsrEotyo8vKs1JLT7EaAp09kRmKdHkfGBE55XEG5oZmBqamFkamFqaGSuJ83oWdCQK
        CaQnlqRmp6YWpBbB9DFxcEo1MDUpznarndZ8eAUvXwrjoaZDP1Y1vHNZZrTo5vE5D1866god
        zzm4/Z4mt3q1hsdCcfNU1+DNc/NXr3zB+zMkLGP69OXr9AqfSqmVZN5ytBec46qzjOclo/Tv
        e1xzzfj0vlgo7uQWSfb//HdjVFqC7mslqYSm4FnmtQUTp++N4plfcsj2bd6uc031Gxvepzif
        qp+2ZXqV2hGOz7s4/omsTVi0akmCh/86pecM2rMz70xbwvjYIrro9PYWj7MPeY/0ZTS+iLw7
        T4ntxkdl3+NXGmPeJp2o3cv6IGWaopxHWmmhxedzv8SO9vgbOr4XnuDnL/nN9NQH3t3Tfy2Z
        1pW4f3KGjKbEXSeNX1+l6o2M7iixFGckGmoxFxUnAgDMeJZgMAMAAA==
X-CMS-MailID: 20230110143638eucas1p1551ada551876f82df671162860f08d7d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230110143638eucas1p1551ada551876f82df671162860f08d7d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230110143638eucas1p1551ada551876f82df671162860f08d7d
References: <20230110143635.77300-1-p.raghav@samsung.com>
        <CGME20230110143638eucas1p1551ada551876f82df671162860f08d7d@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of open coding to check for zone start, add a helper to improve
readability and store the logic in one place.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-core.c       |  2 +-
 block/blk-zoned.c      |  4 ++--
 include/linux/blkdev.h | 12 ++++++++++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9321767470dc..0405b3144e7a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -573,7 +573,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 		return BLK_STS_NOTSUPP;
 
 	/* The bio sector must point to the start of a sequential zone */
-	if (bio->bi_iter.bi_sector & (bdev_zone_sectors(bio->bi_bdev) - 1) ||
+	if (!bdev_is_zone_start(bio->bi_bdev, bio->bi_iter.bi_sector) ||
 	    !bio_zone_is_seq(bio))
 		return BLK_STS_IOERR;
 
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index db829401d8d0..614b575be899 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -277,10 +277,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
 		return -EINVAL;
 
 	/* Check alignment (handle eventual smaller last zone) */
-	if (sector & (zone_sectors - 1))
+	if (!bdev_is_zone_start(bdev, sector))
 		return -EINVAL;
 
-	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
+	if (!bdev_is_zone_start(bdev, nr_sectors) && end_sector != capacity)
 		return -EINVAL;
 
 	/*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0956bc0fb5b0..7822c6f4c7bd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1306,6 +1306,18 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 	return q->limits.chunk_sectors;
 }
 
+static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
+						   sector_t sector)
+{
+	return sector & (bdev_zone_sectors(bdev) - 1);
+}
+
+static inline bool bdev_is_zone_start(struct block_device *bdev,
+				      sector_t sector)
+{
+	return bdev_offset_from_zone_start(bdev, sector) == 0;
+}
+
 static inline int queue_dma_alignment(const struct request_queue *q)
 {
 	return q ? q->limits.dma_alignment : 511;
-- 
2.25.1

