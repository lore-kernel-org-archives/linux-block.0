Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396EDC433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Mar 2022 16:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345068AbiCHQzV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 11:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238663AbiCHQzU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 11:55:20 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962684EA31
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 08:54:23 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220308165422euoutp0241c67d709cc51440c7fdc9632b92d8af~adhixliNx1845618456euoutp02H
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 16:54:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220308165422euoutp0241c67d709cc51440c7fdc9632b92d8af~adhixliNx1845618456euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646758462;
        bh=TPUaZzbXqWKNL5NK3tHyPNndlEeKhHRqKKMcymvnEMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ELlwquSipcHFH7woU1a1qEceNMFUIpRAo2p4pantT4OXqjBOHWQdbyhTifczzSfTK
         xtXzfu3Sa0a5fBYBGw+u8kffZ+E3ri9qVNUMn2BceqxjMMUJrUDCUzJbkIq6XXshaQ
         nvPTQNcZ6jarEtta1/vAi50KRL5e3R3tV7YuOqbw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220308165421eucas1p2d7e3afd6d010d9272674f1082b9cdc7f~adhiZ_tpP2398623986eucas1p2X;
        Tue,  8 Mar 2022 16:54:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 69.3B.10009.D3A87226; Tue,  8
        Mar 2022 16:54:21 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220308165421eucas1p20575444f59702cd5478cb35fce8b72cd~adhhtgbkY2414524145eucas1p2V;
        Tue,  8 Mar 2022 16:54:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220308165421eusmtrp196690df24c43b52d7b47ce9b95f35190~adhhshRtE0526005260eusmtrp1L;
        Tue,  8 Mar 2022 16:54:21 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-af-62278a3d5bfc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 47.73.09522.C3A87226; Tue,  8
        Mar 2022 16:54:20 +0000 (GMT)
Received: from localhost (unknown [106.210.248.181]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220308165420eusmtip27049d06298085b75b096df4273286dbd~adhhW6HS30867508675eusmtip2N;
        Tue,  8 Mar 2022 16:54:20 +0000 (GMT)
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
Subject: [PATCH 1/6] nvme: zns: Allow ZNS drives that have non-power_of_2
 zone size
Date:   Tue,  8 Mar 2022 17:53:44 +0100
Message-Id: <20220308165349.231320-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308165349.231320-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsWy7djP87q2XepJBos/qllMP6xosfpuP5vF
        77PnmS1Wrj7KZPH4zmd2i54DH1gsjv5/y2Zx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5M
        eMpo8XlpC7vFmptPWSzWvX7P4iDg8e/EGjaPnbPusnucv7eRxePy2VKPTas62Tw2L6n32H2z
        ASjXep/Vo2/LKkaPz5vkPNoPdDMFcEdx2aSk5mSWpRbp2yVwZbQumcpecJer4u38iawNjD85
        uhg5OSQETCTOTV/I0sXIxSEksIJR4uekB6wQzhdGiYnHzzKDVAkJfGaU2NKb2sXIAdbRc6II
        omY5o8Te5jeMEM5LRon/fWtZQYrYBLQkGjvZQXpFBC4wS/y4qQhSwyywmVHiw6QVrCAJYYFQ
        iRlr57KB2CwCqhI7nm5iAbF5Bawkbm25zghxnrzEzEvfwQZxClhLPO2cyQZRIyhxcuYTsHpm
        oJrmrbOZIeoXc0o8WFQAYbtItJ9ZBBUXlnh1fAs7hC0jcXpyD9jLEgL9jBJTW/4wQTgzGCV6
        Dm9mgnjTWqLvTA6IySygKbF+lz5E1FHi5kEzCJNP4sZbQYgL+CQmbZvODBHmlehoE4JYpCSx
        8+cTqKUSEpeb5rBA2B4SPbOWsk9gVJyF5JdZSH6ZhbB2ASPzKkbx1NLi3PTUYsO81HK94sTc
        4tK8dL3k/NxNjMCUd/rf8U87GOe++qh3iJGJg/EQowQHs5II7/3zKklCvCmJlVWpRfnxRaU5
        qcWHGKU5WJTEeZMzNyQKCaQnlqRmp6YWpBbBZJk4OKUamLRnsxnfzs6afTuBUVUyU1ejuu58
        78/lr6oVb63OdHq5f+Gcy78dqjK/27I+vP5RrfaiZDh3i3Pon8nBqn9XdewwdFn1KVUuY+0l
        h4Mahru23w3csO2f/8rL0882/t061acq2aR9g46Za+651fNee5778slY+72MwrTsda0PJ2Zf
        uPvlIs+O93LbBd4yfH5offtV78+nwmdVOa6ZpBw9F227uuz20tSeexcU9zziqy60EPh5NkZI
        yfoQ87fTk4MWWRY55D77O/d5g9Wh7Njnn8+ukXsvv+X55H/POo/5aH3e/sWtIT97erFad8Dd
        30KSvO4roiI+bmZePq9T7lAl9yftrT+zgk7af3S57zntk/oEJZbijERDLeai4kQARjhbY+gD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xe7o2XepJBusvW1hMP6xosfpuP5vF
        77PnmS1Wrj7KZPH4zmd2i54DH1gsjv5/y2Zx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5M
        eMpo8XlpC7vFmptPWSzWvX7P4iDg8e/EGjaPnbPusnucv7eRxePy2VKPTas62Tw2L6n32H2z
        ASjXep/Vo2/LKkaPz5vkPNoPdDMFcEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvH
        WhmZKunb2aSk5mSWpRbp2yXoZbQumcpecJer4u38iawNjD85uhg5OCQETCR6ThR1MXJxCAks
        ZZS4/2UfUxcjJ1BcQuL2wiZGCFtY4s+1LjaIoueMEhcfb2cDaWYT0JJo7GQHiYsI3GCWWDa1
        jRHEYRbYziixYeUcNpBuYYFgifmzzrOC2CwCqhI7nm5iAbF5Bawkbm25DrVBXmLmpe/sIDan
        gLXE086ZYL1CQDW/DrQyQdQLSpyc+QSslxmovnnrbOYJjAKzkKRmIUktYGRaxSiSWlqcm55b
        bKhXnJhbXJqXrpecn7uJERij24793LyDcd6rj3qHGJk4GA8xSnAwK4nw3j+vkiTEm5JYWZVa
        lB9fVJqTWnyI0RTo7onMUqLJ+cAkkVcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpa
        kFoE08fEwSnVwMSx5H2N8MkYLv91fEV55xuzf5as/nZzS/TUGJaQs+sy1hdt99OynfJyhVeU
        5aKICWLhyX23XzJUvy2dvsb4fpWrpeynfnvHe1Z5jrd2bGec8aKlYOvbx7ue7eo8ED6V87/n
        g8vBpS9vVZ3O4fEK4/lkIM/sxOTe/rBEL/VlgY2lerLW9KDFkvU299aut2JuZy2w1HB8fDAy
        tvXZT3ne+DiHEy7FElb9/zKeBcSw9Eze9adSj2+Oks2/jJioH4qsqy7qq6R+7u7er/Ery21/
        vMjZFzwFFhs+B58+om+RFbQtU3mdJdchu+th++3Efv4UVoreGzh7963YmTNza04+m7hdxfqO
        wf/mpibBELUvSizFGYmGWsxFxYkA1+uce1oDAAA=
X-CMS-MailID: 20220308165421eucas1p20575444f59702cd5478cb35fce8b72cd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220308165421eucas1p20575444f59702cd5478cb35fce8b72cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220308165421eucas1p20575444f59702cd5478cb35fce8b72cd
References: <20220308165349.231320-1-p.raghav@samsung.com>
        <CGME20220308165421eucas1p20575444f59702cd5478cb35fce8b72cd@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the condition which disallows non-power_of_2 zone size ZNS drive
to be updated and use generic method to calculate number of zones
instead of relying on log and shift based calculation on zone size.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/host/zns.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 9f81beb4df4e..ad02c61c0b52 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -101,13 +101,6 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 	}
 
 	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
-	if (!is_power_of_2(ns->zsze)) {
-		dev_warn(ns->ctrl->device,
-			"invalid zone size:%llu for namespace:%u\n",
-			ns->zsze, ns->head->ns_id);
-		status = -ENODEV;
-		goto free_data;
-	}
 
 	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
@@ -129,7 +122,7 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
 				   sizeof(struct nvme_zone_descriptor);
 
 	nr_zones = min_t(unsigned int, nr_zones,
-			 get_capacity(ns->disk) >> ilog2(ns->zsze));
+			 get_capacity(ns->disk) / ns->zsze);
 
 	bufsize = sizeof(struct nvme_zone_report) +
 		nr_zones * sizeof(struct nvme_zone_descriptor);
-- 
2.25.1

