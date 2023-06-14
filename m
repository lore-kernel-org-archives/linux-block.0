Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132ADEB64D9
	for <linux-block@archiver.kernel.org>; Wed, 14 Jun 2023 13:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbjFNNfp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 09:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244966AbjFNNfp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 09:35:45 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3441FD6
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 06:35:43 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230614133540euoutp0181071689bd88c17188cd3e24b8565fbb~oifPG-GtT3107531075euoutp01w
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 13:35:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230614133540euoutp0181071689bd88c17188cd3e24b8565fbb~oifPG-GtT3107531075euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686749740;
        bh=Aa9oeJ+YIegKehUiDcAtm/9O3004HKkeMOduPePrteQ=;
        h=From:To:CC:Subject:Date:References:From;
        b=SJZDjDl/ZDi+dqg87O0EO9uKtiYRbTrobOZZpgJKiSF/Mikyl/7uDwCImQVk3KF9+
         GZA2lyfyOxxXwsOiiU0H88AnmzT1zfW051tWGclQqjnkB4dzet4Bs2s3TP+Jgt3tzP
         vyO5XDVLZBpQ/Sl3dy6wGGavvgDkUbWOnFlTVbJQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230614133540eucas1p10a0396b9bced3ff38c9c254af75c47e7~oifO_I_mJ0457804578eucas1p1x;
        Wed, 14 Jun 2023 13:35:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 48.A1.37758.C22C9846; Wed, 14
        Jun 2023 14:35:40 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230614133540eucas1p1a761c184d7d571cfcd893ab5f8b759fd~oifOpqFyI1745017450eucas1p1k;
        Wed, 14 Jun 2023 13:35:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230614133540eusmtrp1898123e7b29e4caf91eca508ea1b0565~oifOo7jef1602416024eusmtrp1E;
        Wed, 14 Jun 2023 13:35:40 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-6d-6489c22c4bd9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 72.92.14344.B22C9846; Wed, 14
        Jun 2023 14:35:39 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230614133539eusmtip2f783a8437dfc31a889870e9b52b99b65~oifOc56Ns1206812068eusmtip2g;
        Wed, 14 Jun 2023 13:35:39 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 14 Jun 2023 14:35:39 +0100
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     <axboe@kernel.dk>
CC:     <mcgrof@kernel.org>, <linux-block@vger.kernel.org>,
        <gost.dev@samsung.com>, <hare@suse.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH for-next] brd: use cond_resched instead of cond_resched_rcu
Date:   Wed, 14 Jun 2023 15:35:38 +0200
Message-ID: <20230614133538.1279369-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjtvffueh2urlPZ4xZam2loaVHoaClZBov+RL8isBzuMqs5bXN+
        RaF9zyxtYeYyi/U1NSqcaa2sHKKZiqGZs/woa1li0pdlSZHzNfDfOec5532eAy9DCvN5YmaX
        LoPT61RaKc2n6pp/dS5f5jSpVxTZ/OXVA0W0/IHVTMgbXkbIXcVuJJ+aLKfX8ZR2W7iyu8Oo
        rKky0Up72z7lt5qgLbzt/LVqTrsrk9NHxSXxU6wjfWS6hc6eOD7My0OlvALkzQC7GsZ/1FMF
        iM8IWRuCx1ddCJPv02RybJZ8Q3D+4v1pwsxEmlplWL+OoKeih/A8NWO6Vi3Bg1oElVc+k54A
        zYZDvsnLA/3ZACi35ngsJHsTQcnPJsKj+7GboaRnhecZil0CpU8mKA8WsApodtfOrg2Gy68B
        y77QWvZuxkJOy4funCcxBmj88IHExaSQZ2+nMN4PDYcee3nWAvuAgf4RB8KDBCjuP0Jg7Aej
        LbVeGC+EtjOFs+F94HZNkTh8GEHRvVs0PkgBp9q12BMP/Y9OElieD65Pvvie+WCuKyWxLIDj
        R4XYHQrVg2NUMZJZ5rSxzGljmdPmEiKrkIgzGlI1nGGVjsuKNKhSDUadJjI5LbUGTf+Str8t
        E3eRbfRLpBMRDHIiYEipv8C99JhaKFCrcnI5fdpOvVHLGZxIwlBSkSAitjVZyGpUGdwejkvn
        9P+nBOMtziO0z8dtmts74gmfQB+CWtMREHtj7wnHBk3UwKCoOKywdOwtaQ4aDlFSmj5/7ZD4
        ID154kLJ5s6NDntmwm8fLzZgwVmjuevVyqLErdF9LxYLJYqs7g5bWWJ0Di897SO/wfi1sNER
        Uv68+X32Upm4cc2lFNkiZv1UBIpJNcdfPtJ7LXyecxu7aXf6E4n867HvFkVJjML0NE72ts0R
        PFnxzLb/jUvyp+BAYTBTn//LNOq7oydHZG2ueJdhvzDkbuxdHzZad+N33NPKsuR1I6FWYoSf
        7deVFRT4yIeheMF2ZbZ7IClDBHWZTnPuw9O5exP+bFVGtFScHj5H65o6hbEpUsqQoloZTuoN
        qn++tL3plAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t/xe7rahzpTDF7tsbZYfbefzWLPoklM
        FntvaVvcmPCU0eL3jzlsDqwem1doeVw+W+qxaVUnm8fm09UenzfJBbBG6dkU5ZeWpCpk5BeX
        2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GUsen6TuWAWW8XXjkesDYzT
        WbsYOTgkBEwkjpxU7mLk4hASWMoo8fvDJ6A4J1BcRmLjl6tQtrDEn2tdbBBFHxklbtydwQ7h
        bGGUeLF/JjPIJDYBLYnGTnYQU0RAVGLOokqQEmaBdYwSp//uZwOJCwt4S0y9agAyk0VAVWL6
        ia8sIDavgLXEsadbGCHukZdY/EACIiwocXLmE7ASZqBw89bZzBC2hMTBFy+YIU5TkmjYfIYF
        wq6V6Hx1mm0Co9AsJO2zkLTPQtK+gJF5FaNIamlxbnpusZFecWJucWleul5yfu4mRmDsbDv2
        c8sOxpWvPuodYmTiYDzEKMHBrCTC+1SjPUWINyWxsiq1KD++qDQntfgQoynQOxOZpUST84HR
        m1cSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwJQxubqGMXF2lZeK
        0I4/ZpeTbHOLnxdq/+SsP/i1aJJ/V6SuRUEzg8Ouwis28Todi69sOXVaIZf/1fT8J26vvsUc
        l383b22f3sKATZJdq/ia1O7Nmffl1sTTEQdnnVK6U/5eKqRfrOmMi+WFL5F3g039/vgecT+6
        NPRC2sUpWQkdr7bzXdjV8l1R7qxPQTKPyl3rHzdiYoJufhOXt9l4cXZbAo+vUk0Ed4GU6Q+h
        oKeiLLYN+p7KvXb2PddP3Pz15vzJ6Eld5178X3NMTZ2Tf6/MpAPTAuWPv1Jb4Cc2R9jGesmC
        1N0cb0yV5OZGMy1U1b92xIVlSYCFU43nnLRdNdY7emdNLfrUH639jf9KoxJLcUaioRZzUXEi
        ADRuT4UmAwAA
X-CMS-MailID: 20230614133540eucas1p1a761c184d7d571cfcd893ab5f8b759fd
X-Msg-Generator: CA
X-RootMTR: 20230614133540eucas1p1a761c184d7d571cfcd893ab5f8b759fd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230614133540eucas1p1a761c184d7d571cfcd893ab5f8b759fd
References: <CGME20230614133540eucas1p1a761c184d7d571cfcd893ab5f8b759fd@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The body of the loop is run without RCU lock held. Use the regular
cond_resched() instead of cond_resched_rcu().

Fixes: 786bb0245881 ("brd: use XArray instead of radix-tree to index backing pages")
Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/brd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 2f71376afc71..970bd6ff38c4 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -111,7 +111,7 @@ static void brd_free_pages(struct brd_device *brd)
 
 	xa_for_each(&brd->brd_pages, idx, page) {
 		__free_page(page);
-		cond_resched_rcu();
+		cond_resched();
 	}
 
 	xa_destroy(&brd->brd_pages);
-- 
2.39.2

