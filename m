Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0BBC54EBE
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 14:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238525AbjAJOgr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 09:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjAJOgp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 09:36:45 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7735742E36
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 06:36:42 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230110143640euoutp0194158956b4db3ab7596b33015b16d1a2~4_VPpUeF-3100431004euoutp01V
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 14:36:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230110143640euoutp0194158956b4db3ab7596b33015b16d1a2~4_VPpUeF-3100431004euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673361400;
        bh=2suXkH1KFPiYteZ9oMdTIvkNeSw64bwFwUVTSVjrGjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XoKdh34Lp4UiSk+b9U9JIDNI5ksuBsYVeozgOmZCbr5yy/I25NxTMEKS5RvJY7GxV
         67Bc6NZinA4Z0YSWdk3d49ZGBt3L8CRStTa5UEu5n3gQCZYPKe+KFF7GNs8ZHjOi7F
         Edz4vYH+z1EvmUSjqWYEiweV7GgT4zlCp8dW1AJ4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230110143639eucas1p1a749f235b9f29daeed9db34f0c757cb9~4_VO6Ew9y0119001190eucas1p1M;
        Tue, 10 Jan 2023 14:36:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D8.18.43884.7F77DB36; Tue, 10
        Jan 2023 14:36:39 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230110143639eucas1p1969276de5218d8e71dfb1ffe4b636574~4_VOqGmPB1433014330eucas1p1m;
        Tue, 10 Jan 2023 14:36:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230110143639eusmtrp2545b3bcc97a80f81a850049e1aedf2b1~4_VOpZ_Z60701607016eusmtrp2Z;
        Tue, 10 Jan 2023 14:36:39 +0000 (GMT)
X-AuditID: cbfec7f5-25bff7000000ab6c-20-63bd77f7a6f7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 27.1C.23420.7F77DB36; Tue, 10
        Jan 2023 14:36:39 +0000 (GMT)
Received: from localhost (unknown [106.210.248.241]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230110143639eusmtip26ac82f8edf03ff344e2c0aab1f8da50c~4_VOaEFVl2566725667eusmtip2v;
        Tue, 10 Jan 2023 14:36:38 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, bvanassche@acm.org,
        linux-block@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        gost.dev@samsung.com, snitzer@kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2 3/3] block: introduce bdev_zone_no helper
Date:   Tue, 10 Jan 2023 15:36:35 +0100
Message-Id: <20230110143635.77300-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110143635.77300-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djPc7rfy/cmG2zYL2+x+m4/m8W0Dz+Z
        LX6fPc9scfPATiaLlauPMlk8vTqLyWLvLW2L+cueslt8XtrCbnHilrQDl8flK94el8+Wemxa
        1cnmsXlJvcfumw1sHr3N79g8drbeZ/Xo27KK0ePzJrkAzigum5TUnMyy1CJ9uwSujHutu5kL
        DvNV/H16iamBcQNPFyMHh4SAiUTDC44uRi4OIYEVjBKfdk1ig3C+MEq8+bcYyOEEcj4zShz+
        bg7TsO6FG0TNckaJG8f2sEI4Lxklrk9uZgQpYhPQkmjsZAfpFREQltjf0coCUsMs8IdR4v/d
        kywgCWEBG4nnVw+AFbEIqEqc737PDGLzClhKrP3YDBaXEJCXmHnpO5jNKWAlcWHib0aIGkGJ
        kzOfgM1hBqpp3jqbGWSBhMATDond518wQTS7SBxa8ZgFwhaWeHV8C9RQGYn/O+dD1VRLPL3x
        G6q5hVGif+d6Nog3rSX6zuSAmMwCmhLrd+lDlDtK3Gl5wA5RwSdx460gxAl8EpO2TWeGCPNK
        dLQJQVQrSez8+QRqqYTE5aY5UMd4SOxa/pd1AqPiLCTPzELyzCyEvQsYmVcxiqeWFuempxYb
        56WW6xUn5haX5qXrJefnbmIEJqjT/45/3cG44tVHvUOMTByMhxglOJiVRHhXcu5JFuJNSays
        Si3Kjy8qzUktPsQozcGiJM47Y+v8ZCGB9MSS1OzU1ILUIpgsEwenVANTwxkLQSWT51GXDnyd
        XChbyCtykaf39qsT7ocKJm8QtmCo2HGyzejJOrY23QcCDzuzeJ4fc+/LnZa1wH2mk13svBpJ
        vXfb/opJ5smIyFmLMkzR7w3pUJZUmJqd9rbb4r9kfXOY4c5ltvsKdpTPZGdL+Sv+Ml49Yx7X
        1fPVaRJBPulas5mTD954KPdr7R6vBv09X+9ss13YoGJzgqf/fMtNKc3/z9/Fb/nJYV9iyZDs
        2O6in9B7fUf8hwsK2f0bEh/7XJrOuMfqEMvjGQ9fX8m/VHTkv8ZvL77zqnXT+1bfPTD5p4wF
        4+vri61/BX44Ir30l6Ly9Yn2t/YLqkX2GddF13gY/Tl76LStdvFtD14lluKMREMt5qLiRABx
        1cR8vwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xe7rfy/cmG8w6z2Wx+m4/m8W0Dz+Z
        LX6fPc9scfPATiaLlauPMlk8vTqLyWLvLW2L+cueslt8XtrCbnHilrQDl8flK94el8+Wemxa
        1cnmsXlJvcfumw1sHr3N79g8drbeZ/Xo27KK0ePzJrkAzig9m6L80pJUhYz84hJbpWhDCyM9
        Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jHutu5kLDvNV/H16iamBcQNPFyMHh4SA
        icS6F25djFwcQgJLGSUuXNvH2sXICRSXkLi9sIkRwhaW+HOtiw2i6DmjxNyF65hBmtkEtCQa
        O9lBakSAavZ3tLKA1DALtDFJrFr2gQkkISxgI/H86gGwIhYBVYnz3e+ZQWxeAUuJtR+b2SEW
        yEvMvPQdzOYUsJK4MPE3I8h8IaCa/ovSEOWCEidnPmEBsZmBypu3zmaewCgwC0lqFpLUAkam
        VYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIHRtO3Yz807GOe9+qh3iJGJg/EQowQHs5II70rO
        PclCvCmJlVWpRfnxRaU5qcWHGE2Bzp7ILCWanA+M57ySeEMzA1NDEzNLA1NLM2MlcV7Pgo5E
        IYH0xJLU7NTUgtQimD4mDk6pBqYFfxIFH1tVKh9pt6uUEJFL/sJTeFrf36uhWrAqt2JWUF9f
        U57368Cg/zm+qabLPWOFbrv5vHubaqnKrnaUX6tqw8OA2fOPRaZNnlGwdI7Fs6ipnyofLTWx
        TNgqJRF/ZsvtMPv5bi+MPYwfP0jvOOihFB15mG9D6/mW18efm0k2Fbwo/HxK8b1nL0P2w0cS
        y7cefW2W+2udQ62VQseJ2CgnmSMfZD/2tztN8nA89I1xgxlTGB8nH2t7LpebmTnX1Yez1/y8
        MH/lnQ+7NcI6v81ijhAMfhZmuups8bx70fd/qBowcp/0fFGw453wrNmRleqTZ4rtvWup+0ZL
        fOn+suYAPV2jf1GeUzk33ZfYr8RSnJFoqMVcVJwIALn/OEEvAwAA
X-CMS-MailID: 20230110143639eucas1p1969276de5218d8e71dfb1ffe4b636574
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230110143639eucas1p1969276de5218d8e71dfb1ffe4b636574
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230110143639eucas1p1969276de5218d8e71dfb1ffe4b636574
References: <20230110143635.77300-1-p.raghav@samsung.com>
        <CGME20230110143639eucas1p1969276de5218d8e71dfb1ffe4b636574@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a generic bdev_zone_no() helper to calculate zone number for a
given sector in a block device. This helper internally uses disk_zone_no()
to find the zone number.

Use the helper bdev_zone_no() to calculate nr of zones. This lets us
make modifications to the math if needed in one place.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/target/zns.c | 3 +--
 include/linux/blkdev.h    | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 1254cf57e008..7e4292d88016 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -254,8 +254,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
 {
 	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
 
-	return bdev_nr_zones(req->ns->bdev) -
-		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
+	return bdev_nr_zones(req->ns->bdev) - bdev_zone_no(req->ns->bdev, sect);
 }
 
 static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7822c6f4c7bd..89f51d68c68a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1288,6 +1288,11 @@ static inline bool bdev_is_zoned(struct block_device *bdev)
 	return blk_queue_is_zoned(bdev_get_queue(bdev));
 }
 
+static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
+{
+	return disk_zone_no(bdev->bd_disk, sec);
+}
+
 static inline bool bdev_op_is_zoned_write(struct block_device *bdev,
 					  blk_opf_t op)
 {
-- 
2.25.1

