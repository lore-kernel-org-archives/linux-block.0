Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D36DC433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Mar 2022 16:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbiCHQz3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 11:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346381AbiCHQz2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 11:55:28 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F234ECFE
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 08:54:31 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220308165429euoutp02c41eb24f8431e23326236e2839ff9445~adhqDJbTu1860718607euoutp02N
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 16:54:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220308165429euoutp02c41eb24f8431e23326236e2839ff9445~adhqDJbTu1860718607euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646758470;
        bh=EVDf6R84igtJ/y3qEBnMjQVZ6aHLsjiJLYrL/j3arWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qi/hu/CVraA9IG7h/lSGqPgic3BhuK5edr/24K6jV58mOiW2J3ECAfqx5yfyseMzH
         v1IXlIPTXWSTXVY8Yrp1brL72rBGZHXjgZsfG56TZg42l2L5Wk5ov8H8TFrKZJgOmJ
         9GYsoZSTVYsdaU1/q7qFTUcximPGu/znNzEflzIs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220308165429eucas1p211fb120efe0efa0a2a27a3ea3a400ff9~adhph4M3Q2912829128eucas1p2F;
        Tue,  8 Mar 2022 16:54:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 23.4B.10009.54A87226; Tue,  8
        Mar 2022 16:54:29 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220308165428eucas1p14ea0a38eef47055c4fa41d695c5a249d~adhohIFSy0406404064eucas1p1l;
        Tue,  8 Mar 2022 16:54:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220308165428eusmtrp17c3bb4cc2490d53f3a86cad323a434ae~adhogYd9f0526005260eusmtrp1S;
        Tue,  8 Mar 2022 16:54:28 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-cd-62278a457bf8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0B.73.09522.44A87226; Tue,  8
        Mar 2022 16:54:28 +0000 (GMT)
Received: from localhost (unknown [106.210.248.181]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220308165428eusmtip140f2ab8c2fedd3e5358318dcff5517a4~adhoODwyn0418504185eusmtip1V;
        Tue,  8 Mar 2022 16:54:28 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        jiangbo.365@bytedance.com
Cc:     Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 2/6] block: Add npo2_zone_setup callback to block device
 fops
Date:   Tue,  8 Mar 2022 17:53:45 +0100
Message-Id: <20220308165349.231320-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308165349.231320-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djP87quXepJBlu7RC2mH1a0WH23n83i
        99nzzBYrVx9lsnh85zO7Rc+BDywWR/+/ZbM4//Ywk8WkQ9cYLfbe0raYv+wpu8WEtq/MFjcm
        PGW0+Ly0hd1izc2nLBbrXr9ncRDw+HdiDZvHzll32T3O39vI4nH5bKnHplWdbB6bl9R77L7Z
        AJRrvc/q0bdlFaPH501yHu0HupkCuKO4bFJSczLLUov07RK4Mm68XsRc0M1XsWn5R7YGxjPc
        XYycHBICJhIfp/1g6WLk4hASWMEoMXHXCiYI5wujxLKe82wQzmdGiVlPnjDDtNx8vY8dIrGc
        UeL6+bvsIAkhgZeMEptaS7oYOTjYBLQkGjvBwiICF5glftxUBKlnFtjMKPFh0gpWkISwgL/E
        vb5usKEsAqoS+2c1sYHYvAJWEgdmfGCDWCYvMfPSd7BBnALWEk87Z0LVCEqcnPmEBcRmBqpp
        3jqbGWSBhMByTonbm76xQzS7SKz+dZgJwhaWeHV8C1RcRuL05B4WiIZ+RompLX+YIJwZjBI9
        hzczgbwgAbSu70wOiMksoCmxfpc+RNRR4t40JwiTT+LGW0GIE/gkJm2bzgwR5pXoaBOCWKQk
        sfPnE6ilEhKXm+awQNgewCCczD6BUXEWkmdmIXlmFsLaBYzMqxjFU0uLc9NTiw3zUsv1ihNz
        i0vz0vWS83M3MQLT3ul/xz/tYJz76qPeIUYmDsZDjBIczEoivPfPqyQJ8aYkVlalFuXHF5Xm
        pBYfYpTmYFES503O3JAoJJCeWJKanZpakFoEk2Xi4JRqYBLe+Mf+n4Tf+fynO8RefD/y+Ezd
        6fvBLvHZAZ3nriddM+Wp54hr7i1r2if9qz04THTRFJfXKm94hFvfnpwxb8osm1b1rRnr/8gG
        Jf6RnPPfYCk/x+wdGqz6j5vfzPTuO37s4aFryw0XcCW3+bL7HmQ8OrEjsbxjl7nYnasf4pk3
        H7HeF6j9bbl7+vQf96LPbd2zK5Tp+r7FP9v49r9SDIttde26lHMgy/H8koee/XzC8vWzZfZU
        rbJ15fetmRZ86c/JKdssk3YFcFuoJR3N/J9lmnhqjWyR28UHT9ZY1ey87zh9OYdC+36NeS/L
        thzP29jyeU7Lc12XtZntCtctlpxdfef7pK1eWQm1mvoNGppKLMUZiYZazEXFiQC2OYlv6gMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xu7ouXepJBhuf8llMP6xosfpuP5vF
        77PnmS1Wrj7KZPH4zmd2i54DH1gsjv5/y2Zx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5M
        eMpo8XlpC7vFmptPWSzWvX7P4iDg8e/EGjaPnbPusnucv7eRxePy2VKPTas62Tw2L6n32H2z
        ASjXep/Vo2/LKkaPz5vkPNoPdDMFcEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvH
        WhmZKunb2aSk5mSWpRbp2yXoZdx4vYi5oJuvYtPyj2wNjGe4uxg5OSQETCRuvt7H3sXIxSEk
        sJRR4m/bdCaIhITE7YVNjBC2sMSfa11sEEXPGSUmvVoBlODgYBPQkmjsBGsWEbjBLLFsahsj
        iMMssJ1RYsPKOWwgRcICvhJTtkWADGIRUJXYP6uJDcTmFbCSODDjAxvEAnmJmZe+s4PYnALW
        Ek87Z4LFhYBqfh1oZYKoF5Q4OfMJC4jNDFTfvHU28wRGgVlIUrOQpBYwMq1iFEktLc5Nzy02
        1CtOzC0uzUvXS87P3cQIjNFtx35u3sE479VHvUOMTByMhxglOJiVRHjvn1dJEuJNSaysSi3K
        jy8qzUktPsRoCnT3RGYp0eR8YJLIK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1I
        LYLpY+LglGpgig//+WaV+eao81fnBqiEu/4VX9dWu3z3nL+HhFIWvJ74L6nuaLPYLPFJS2oO
        LF6zJWzWGqO1FpKGi+79nLuyap/mv8mVvFvvCIS/T/K7YX981paZ0/VXBzm+WJuizbnT65qK
        mu60g5axVy422B7922jxZZ6UpvrUtr16XtOSbDqUsooi9keICz2zefb4/Mppr+xMlobIHmBd
        FCfskvz7mOu8ovX/FT/ENX2b+yLD1/3dRdb/cwsa4suPlT46te74TZZweaslaWdW/+07JTj9
        4px3X6qmTtOJ2JQSbvfB6F1Hfn7JVe+w77Y1KyfEnzNmzKhnEAlSmZ+imzU9etuKN9syumT1
        FZrnXDxhcF4+b6YSS3FGoqEWc1FxIgDCpdpDWgMAAA==
X-CMS-MailID: 20220308165428eucas1p14ea0a38eef47055c4fa41d695c5a249d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220308165428eucas1p14ea0a38eef47055c4fa41d695c5a249d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220308165428eucas1p14ea0a38eef47055c4fa41d695c5a249d
References: <20220308165349.231320-1-p.raghav@samsung.com>
        <CGME20220308165428eucas1p14ea0a38eef47055c4fa41d695c5a249d@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A new fops is added to block device which will be used to setup the
necessary hooks when a non-power_of_2 zone size is detected in a zoned
device.

This fops will be called as a part of blk_revalidate_disk_zones.

The primary use case for this callback is to deal with zoned devices
that does not have a power_of_2 zone size such as ZNS drives.For e.g,
the current NVMe ZNS specification does not require zone size to be
power_of_2 but the linux block layer still expects a all zoned device to
have a power_of_2 zone size.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-zoned.c      | 3 +++
 include/linux/blkdev.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 602bef54c813..d3d821797559 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -575,6 +575,9 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 	if (!get_capacity(disk))
 		return -EIO;
 
+	if (disk->fops->npo2_zone_setup)
+		disk->fops->npo2_zone_setup(disk);
+
 	/*
 	 * Ensure that all memory allocations in this context are done as if
 	 * GFP_NOIO was specified.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a12c031af887..08cf039c1622 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1472,6 +1472,7 @@ struct block_device_operations {
 	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
 	int (*report_zones)(struct gendisk *, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data);
+	void (*npo2_zone_setup)(struct gendisk *disk);
 	char *(*devnode)(struct gendisk *disk, umode_t *mode);
 	/* returns the length of the identifier or a negative errno: */
 	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
-- 
2.25.1

