Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F09C47083
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 12:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD8D1613BA
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 12:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhFBMbB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jun 2021 08:31:01 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:25810 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhFBMbA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jun 2021 08:31:00 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210602122915epoutp032be2cf7e10a3b19a14c5628844d032a6~Ew7bdS3U03228932289epoutp03w
        for <linux-block@vger.kernel.org>; Wed,  2 Jun 2021 12:29:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210602122915epoutp032be2cf7e10a3b19a14c5628844d032a6~Ew7bdS3U03228932289epoutp03w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622636955;
        bh=m1WrSqMs1IZOEKia4Fv/1t0N4iuq4aefNOXRjbdjIrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IBBrHa00a4oXkhnh3FoFpgofWfdjkQld+B6K3o0B3vRPxBdF2PKHCerXujH6WVK59
         rhwnspVf5YWBlMhrkxgLPsocgOA347EpT5Nmq7I7QJNKl3RQLCRWrUC0CRCHY56Erp
         nBJfYW0p2r/LpDXUXnztj0Gc0OMa6YEMbsPeNu94=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210602122915epcas1p3da9960f17a09d745b1921381d04c4277~Ew7anNcSq0844208442epcas1p3_;
        Wed,  2 Jun 2021 12:29:15 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Fw7cn4qtMz4x9Py; Wed,  2 Jun
        2021 12:29:13 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.56.09824.99977B06; Wed,  2 Jun 2021 21:29:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210602122912epcas1p4faff714cc9457b0d482fc1a4b63a49a9~Ew7YmROlp0807908079epcas1p4G;
        Wed,  2 Jun 2021 12:29:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210602122912epsmtrp1e7bda9a122343de7ba2b95498d1848f0~Ew7YlE1GJ2602326023epsmtrp1_;
        Wed,  2 Jun 2021 12:29:12 +0000 (GMT)
X-AuditID: b6c32a37-04bff70000002660-73-60b7799931d3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.1C.08637.89977B06; Wed,  2 Jun 2021 21:29:12 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210602122912epsmtip1ea7e9ccfe55c7b0c136fa93847e045e0~Ew7YPcZ8M0228902289epsmtip1x;
        Wed,  2 Jun 2021 12:29:12 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     hch@infradead.org, Johannes.Thumshirn@wdc.com, alex_y_xu@yahoo.ca,
        asml.silence@gmail.com, axboe@kernel.dk, bgoncalv@redhat.com,
        bvanassche@acm.org, damien.lemoal@wdc.com,
        gregkh@linuxfoundation.org, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com, yi.zhang@redhat.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com, Changheun Lee <nanich.lee@samsung.com>
Subject: [PATCH v11 3/3] scsi: set max_bio_bytes with queue max sectors
Date:   Wed,  2 Jun 2021 21:10:37 +0900
Message-Id: <20210602121037.11083-4-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210602121037.11083-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxje10NPC1vHscD41hmEE0xsEWwpl28IxA3Fs6Cm2ZZsaExb4Kzg
        Stv1tHNMtzluIhcpweGsYBEJU8bFVW5lXEzNRpiMjSEjIQKKDJRYQZiom5q1FDL+Pe+X53mf
        932+vFyMf4Ij4GZoDLReo1STuJdH2zWhOPRMVrtCXF4ehJpuNnBQZX0bQN+Pl+Koc8gCUMXC
        UwzlHV9moZwLzTi6bqphoelmM4aKp7PZ6HnhBAs9us2g7rEQNNxZiSN7eQ4Lnb5SiaE/Jwc4
        6NrEiAe6XVuGocH+RTY6d2cH+ue7nwCafzLKQb90lGNodLACR83dT/EdAmr4RhJVlvOAQ9nM
        4xzqykURNfyrkbLWn8Cp3qoGDjXfM4JTJ1vqAbVkDaCOXy1iUXZ7HSZ7Zb86Np1WptH6QFqT
        qk3L0KjiyKT35AnyyCixJFTyJoomAzXKTDqO3LlHFpqYoXZGQAZ+qlQbnU8yJcOQ2+Jj9Vqj
        gQ5M1zKGOJLWpal1ErEujFFmMkaNKixVmxkjEYvDI51MhTr9r4nLmM7C+Wy2K+EYyMcLgScX
        EhFwaLQEKwReXD7RAeBvjtHVYhHAs8WX2O5iGcDlsQucNUlh4wRwYT7RDeCLzn1uvARgSZXI
        hXFiKzzpGFux8CUsGOwcZ1yNMOIOgDf63d4+xG5YU3xvpakHsRlenJlxYi6XR2yHM3lxbq9N
        8NlkMebCnkQstN6yrkh5xAbYf2baw4UxJyen9ezK1JCweMIcRyPbLd4J+35YXh3aB871taxi
        AbxXms9xC4oAzMm3AHdhArB2to7lZknh4tIScE2EEULY3LnN/RwEbf9WAbfzq/DBo2K2iwIJ
        HizI57spwXAgdxJb85pttK12pGBedftqvKXORLtnWSYQaF63kHndQub/nasBVg9eo3VMpopm
        JDrp+h+2gpWbEEV3gArHQpgdsLjADiAXI315uzWtCj4vTZn1Oa3XyvVGNc3YQaQz7TJM4Jeq
        dR6VxiCXRIZLpVIUERUdFSkl/XmqhCMKPqFSGuiPaVpH69d0LK6n4BirYH/a+/ORrfiPR/b1
        +JNjwix5eNF5Bz4gF8nnP+xI+j3072z23dpDuMnvoz3x6mdmc4Cff3TzZkUKxWOmZPFbUlTy
        d1vEQllTYp4167HMp3fSFnq+78tbwcviqYqDX0/JN5hNb3yhqJ9MtlyaM/ef0+waPGxiDghj
        tmi++vkto9lrl0Yo6Ok97T2nPnjXQlaEbKx5XrPphciRfPjQRm9vilTGfNt6IGgE5DLfaN4p
        afTvTYy4nzJzdHvPy8mXbZaHaYVd1OO+4BCfPx72xfvZnrS3deU23J9puumbPVR91GfvB9dP
        7S2kF6JkAQWCqvlP6q6mtm5tj2lwSA32otfffslOejDpSokI0zPK/wCtMZEKnAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Rf0yMcRzHfZ/nnh+dbh5XW0+nMrdZhDhjvhM5qfWYjQybH7PuuMdpuut2
        T9evsakknUSLkxwRK86P7NQlQu6Q/Dj6za0urUQhiuLIj7uazX/vfV6vvd9/fEhUWMsTkXHq
        RFarlseLcT7PYhMHzSlMrZLNa26YAa+2Xyag0WQB8FLHYRzebCgG0PDZhcKs7BEEZp4rx+GT
        IyUI7CkvQmFuTwYGf+mdCBzu4uBtxyzYdNOIQ2tBJgKPXzeisLXzKQFtzhYe7Dqfj0J7/RAG
        T3dL4Y+yBwB++t5GwMc3ClDYZjfgsPy2C5eKmKbmVUx+5gDBVBd1EMz1CyFM0zMdYzbl4Mzd
        U5cJ5tOdFpzJqzAB5os5iMmuPYgwVmspGuO9mb9EwcbHJbHaueEy/s43zmuopphIeVuzYi/Y
        j+uBF0lTC2j9FSfQAz4ppG4B+tVPAzYORHTdo4/uTLqzD22zcePOIKC/5bzkeRycmk3nfXSM
        FflSlSjdvW+qR0Kp94DWd5eMST5UNF2S20d4Mo+aTl/o7SU8pQIqjO7NWjq+NZUe7cxFPdmL
        WkKbX5txjyJ0K4ajmzxnATWZrj/RM9aIuvXMypPoEUAV/YeK/kNnAGIC/qyGUylVnEQjUbPJ
        oZxcxenUytDtCSozGHtyyMwboMr0OdQKEBJYAU2iYl9BtLpSJhQo5KlprDYhVquLZzkrmELy
        xH6CF/r6WCGllCeyu1hWw2r/UYT0Eu1Fat5Fm4fn62ZPCFFKAn73r425uPv9/lf+I6l+uWUS
        LDmxGTi0/RfTF85Z1FKzun9ofZjPKKYfuJ+v2pwV3jbJsuz+msKR7slvXBvmT9gj1cR6990L
        jjJu2104VD0Y1KyI87dTf7BWZutJ35z1cEeyZMgJAlXlgwN2fkXjFZnUPdz1zvLBcEaeXh3h
        iJiW/qG9uFJG1n09e8xVZsOUSdOkisCm1prItIzl7ZH2KG5iQkArlvJMuqW073mpdMdDveLc
        d8Qqqt0YGey61FgxgB0d9UpVP11cHDAv6vjhLso46KdrqJIq6+82hq+sezG67tCBpKz+xAez
        HGmaQkmepUDM43bKJSGolpP/BQh16bdTAwAA
X-CMS-MailID: 20210602122912epcas1p4faff714cc9457b0d482fc1a4b63a49a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210602122912epcas1p4faff714cc9457b0d482fc1a4b63a49a9
References: <20210602121037.11083-1-nanich.lee@samsung.com>
        <CGME20210602122912epcas1p4faff714cc9457b0d482fc1a4b63a49a9@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Set max_bio_bytes same with queue max sectors. It will lead to fast bio
submit when bio size is over than queue max sectors. And it might be helpful
to align submit bio size in some case.

Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
---
 drivers/scsi/scsi_lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 532304d42f00..f6269268b0e0 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1837,6 +1837,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
 	blk_queue_virt_boundary(q, shost->virt_boundary_mask);
 	dma_set_max_seg_size(dev, queue_max_segment_size(q));
 
+	blk_queue_max_bio_bytes(q, queue_max_sectors(q));
+
 	/*
 	 * Set a reasonable default alignment:  The larger of 32-byte (dword),
 	 * which is a common minimum for HBAs, and the minimum DMA alignment,
-- 
2.29.0

