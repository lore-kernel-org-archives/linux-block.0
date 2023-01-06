Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A52C54EBF
	for <linux-block@archiver.kernel.org>; Fri,  6 Jan 2023 08:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjAFIdk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Jan 2023 03:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjAFId1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jan 2023 03:33:27 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508D27A937
        for <linux-block@vger.kernel.org>; Fri,  6 Jan 2023 00:33:23 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230106083322euoutp01f880f3e18b004f8c6fdd430a5a920b36~3qy5chvtC2179921799euoutp01j
        for <linux-block@vger.kernel.org>; Fri,  6 Jan 2023 08:33:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230106083322euoutp01f880f3e18b004f8c6fdd430a5a920b36~3qy5chvtC2179921799euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672994002;
        bh=b0SsOCCybnCd/B43+zTI9/vDTuEOnzsWfQZ0xnE/tuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EYMHHFM5dYEkg65JHYPztPrOjCGqjbEHNX2jwOLCIYK6/ZW/3jJIytbCMC0fSWFyW
         ipl28gk9AXoKWXYPv2QzRiuTNZVlXrERsNMqNzdhFTkeL+Ch6/kHn0zIAJtrD+EKy/
         LfkkIGiOmeZa8y/E/QNGNsSinfLv4s1lc+n0IvOo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230106083321eucas1p14d9bd46a8be92a470a20e58d21071bb4~3qy4n0gEE1079910799eucas1p1H;
        Fri,  6 Jan 2023 08:33:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BD.93.56180.1DCD7B36; Fri,  6
        Jan 2023 08:33:21 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230106083320eucas1p1d23de4ad21d0a7aecb74c549ebc7757c~3qy4JXsly2243322433eucas1p1A;
        Fri,  6 Jan 2023 08:33:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230106083320eusmtrp15998075ae20ab5f906a740e158118e4d~3qy4Izv5j2166121661eusmtrp1i;
        Fri,  6 Jan 2023 08:33:20 +0000 (GMT)
X-AuditID: cbfec7f2-acbff7000000db74-9b-63b7dcd14f91
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F8.C6.23420.0DCD7B36; Fri,  6
        Jan 2023 08:33:20 +0000 (GMT)
Received: from localhost (unknown [106.210.248.66]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230106083320eusmtip25d92d5b1666eb6931c86064692a73f87~3qy3_HtjY2941329413eusmtip2D;
        Fri,  6 Jan 2023 08:33:20 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk
Cc:     kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
        hare@suse.de, bvanassche@acm.org, snitzer@kernel.org,
        dm-devel@redhat.com, damien.lemoal@opensource.wdc.com,
        linux-nvme@lists.infradead.org, hch@lst.de,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 3/7] nvmet: introduce bdev_zone_no helper
Date:   Fri,  6 Jan 2023 09:33:13 +0100
Message-Id: <20230106083317.93938-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106083317.93938-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se1BMYRztu/fu3bvL5rqFb8ow1ghhyWNcjyEmMxd5/IGhQVZuu6ilva2E
        oSQqjSWPtKsi0ksyWy1bXrMpj1XUZrBeYzA22R5WY9Z6td01/Hd+53d+3zln5iNQql4QQGxW
        xbNqlTxGiosxY4OraULzy6tRkyoO9aPLXmlx+lSXC6XdjY9Q+kaHXkA/v21C6OsFWQhdUlaP
        0A/bnBh9wzaOttacwen8ix+EtLPwgJC+ZwsMlTDW1sWMtVHDGErTcabywj6m9nkSzphS3wiY
        xpJ5TOfNJzhzpKoUMJWW3YzTMGx5vwjx7E1szOYdrHrinA1iZbazBt/+rf/O1JS3WBJwiTOA
        iIDkVFhc3SrMAGKCIosB7LnswvnhK4DaH+XejRPAunotlgGIvpMnP4J4vgjA2u/dKD/YATTo
        rQKPCCeDYXK60GPhT/rBW2mpmEeDkpUIfOEuB56FHzkDFlacRDwYI0fB7KeXcQ+W9PKp9izA
        5xsOc1q+9T0kImfCj9mXEF4zEN7PeY95MNqrSanW94WA5CERbMjU4/xxGGz/nILx2A9+ulsl
        5PFQaDme6eV3ww/P3N7jA72dTRU4X3MWPPIwxgNRciysqJnIy+fBNNsVhFf4wmeOgXwEX5hl
        zEZ5WgLTDlK8WgpNrvdeUwit+894TRl4O/8wdhSM0P1XRvdfGd0/37MALQVDWA0Xq2C5EBWb
        IOPksZxGpZBFbYs1gN6fZvl198s1kPupW2YGCAHMABKo1F+yQ2uMoiSb5Im7WPW2SLUmhuXM
        IJDApEMkp6vzoyhSIY9nt7Lsdlb9d4sQooAkJCFH4DNN1HFe3Rw8KjRP0b/ZEeljmpW3l9NO
        yrJ2zh1cXPt60J7cr3obVrLEGKxsCixd0GONGxC+fGn72KllijYQmZyYrkEeKOvIzARDx/5V
        ssCNLT7mlQ+WJTHlY6p6TlC19szqoUrLruh2u1m+YPp8S050pc5N+QVNxuhO2+LHMuecrtU6
        KlRaRKvaviRTDdoGkV40fn14RMmF9LSE+HdXuBlidpFp3b4thT/vd6vBndGvG/NU01c4wmwE
        NrNgQN3wgzVW3xXL/HOBO6I94GLsqda5C6c4mkLC1zjyj0UTcUU06DoRd+6VMej3mq7EFnvi
        /PVhYwxNI9duLTgsxTilPCQYVXPyP4CET9XYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xe7oX7mxPNvh1UNdi9d1+NotpH34y
        W/w+e57ZYu+72awWNw/sZLLYs2gSk8XK1UeZLM68/MxisfeWtsXlXXPYLOYve8pu8XlpC7vF
        iVvSDrwel694e1w+W+qxaVUnm8fmJfUeu282sHnsbL3P6nF2paPH+31X2Tz6tqxi9Nh8utrj
        8ya5AO4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsE
        vYzpn3exFXznqWhtfsjSwPiTq4uRg0NCwETi6h+1LkYuDiGBpYwS8+9vZ+xi5ASKS0jcXtgE
        ZQtL/LnWxQZR9IxRYvvdc2wgzWwCWhKNnewgNSJANfs7WllAapgFDjJJPJvynRkkISxgKbF0
        /VQmEJtFQFVi+vV1bCA2L1C89cUkqAXyEjMvfQcbxClgJfF8+hqweiGgmo6PvVD1ghInZz5h
        AbGZgeqbt85mnsAoMAtJahaS1AJGplWMIqmlxbnpucWGesWJucWleel6yfm5mxiB0bft2M/N
        Oxjnvfqod4iRiYPxEKMEB7OSCG9Z/7ZkId6UxMqq1KL8+KLSnNTiQ4ymQHdPZJYSTc4Hxn9e
        SbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAMTu/ePezyz33/6aPU4
        gfX3yoWP7TaHqegsvXx9WeqbUPEJ65Wic6TSW14YpLy84ZET9TJvieDNX+0sYW9VOxbE1z/S
        Y++7wHjlx8s7q+rcf3OePDdRv0G2/sQhuXDHzPqAZ3v2TDyYv/vB+fSu1Dzx2LzGPomASn+J
        loLPu7xPXmNw+3SPccrv2qX5x3dKRq+eZiD/zzPBaapLfN+++V6vXp0J7HE0PyyTaf03ivXH
        z2XnV8/it5oeNmvT9kn8R2sCWRtkQ47s2ZbmtMrA4lnDWf43OsvylR792JMrrWPTN3PKBUuu
        R9/2vP+1QepEseipM7NmtV0Is0hcdaHkuebu8FlyGj4HRc50OxbPWMklrcRSnJFoqMVcVJwI
        AIlgaJxHAwAA
X-CMS-MailID: 20230106083320eucas1p1d23de4ad21d0a7aecb74c549ebc7757c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230106083320eucas1p1d23de4ad21d0a7aecb74c549ebc7757c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230106083320eucas1p1d23de4ad21d0a7aecb74c549ebc7757c
References: <20230106083317.93938-1-p.raghav@samsung.com>
        <CGME20230106083320eucas1p1d23de4ad21d0a7aecb74c549ebc7757c@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A generic bdev_zone_no() helper is added to calculate zone number for a
given sector in a block device. This helper internally uses disk_zone_no()
to find the zone number.

Use the helper bdev_zone_no() to calculate nr of zones. This let's us
make modifications to the math if needed in one place.

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
index 04b7cbfd7a2a..669cf4fed1ad 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1287,6 +1287,11 @@ static inline bool bdev_is_zoned(struct block_device *bdev)
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

