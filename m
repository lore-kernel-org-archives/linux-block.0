Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9138C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 02:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743A920989
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 02:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CVHw2JYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeLTCye (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 21:54:34 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55548 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeLTCye (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 21:54:34 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181220025432euoutp02dd4f7cccfa58697e547e625cc1874aa2~x6vH2gZu92282122821euoutp02A;
        Thu, 20 Dec 2018 02:54:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181220025432euoutp02dd4f7cccfa58697e547e625cc1874aa2~x6vH2gZu92282122821euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545274472;
        bh=Q53Pu7zmhtbb0/XI07udDW76NOsU+s+62s8EsnuoaQA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=CVHw2JYO0aoAMnItOQ/wYEMS2DMdV5PvUiO22ncKz0i/l7eVR+OK7NCu/245JQBKp
         Icxto88T7rAA32a6/XqArdtQ0a66ytWwH/AVAGqK5S+tJ1HQkeNPtsZgTP2NqQM1Il
         mXGpMBHbsoYuFv2ToQ8VueEmGjvrgtoleROxFAfY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181220025431eucas1p22349c3afae2c93094fb5bdd8241ef56e~x6vHdp0y70881608816eucas1p2M;
        Thu, 20 Dec 2018 02:54:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 10.8F.04294.7640B1C5; Thu, 20
        Dec 2018 02:54:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181220025430eucas1p2850d6fc8565162908f0540db57d4ec32~x6vF565000358903589eucas1p2T;
        Thu, 20 Dec 2018 02:54:30 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-8c-5c1b0467df00
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4A.B9.04284.5640B1C5; Thu, 20
        Dec 2018 02:54:29 +0000 (GMT)
Received: from localhost.localdomain ([10.88.99.240]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PK0002QHLEL6A30@eusync1.samsung.com>; Thu, 20 Dec
        2018 02:54:29 +0000 (GMT)
From:   Huijin Park <huijin.park@samsung.com>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Huijin Park <huijin.park@samsung.com>,
        Huijin Park <bbanghj.park@gmail.com>,
        Jungseung Lee <js07.lee@samsung.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH] zram: avoid calling bio_endio() before io complete
Date:   Wed, 19 Dec 2018 21:54:14 -0500
Message-id: <1545274454-1535-1-git-send-email-huijin.park@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7djP87rpLNIxBsv6JCxe7j3EbNFx0cXi
        0c3frBZ7b2lbXN41h81i2df37BYbWmaxWzyaMInJgcNj56y77B6bVnWyefRtWcXosfPTZlaP
        z5vkAlijuGxSUnMyy1KL9O0SuDIW7TrLVNDCUdHQdpi5gfEkWxcjJ4eEgIlES/N1pi5GLg4h
        gRWMEv3PJrFAOJ8ZJV4cuwTkcIBV9V42gYgvY5R48GUjVMdfRokfp1aygIxiE9CWuL52KyOI
        LSJQL9Hw4AU7SBGzwBZGiQMdO5hBEsICzhKvT+5mB7FZBFQlli+GaOYVcJN4t/o0M8RNchI3
        z3UygzRLCHxllTi6/AhUwkVi4o/jUIcLS7w6voUdwpaR6Ow4yARhZ0v8etQKdXaFxNt5KhBh
        Y4l3b9eCjWEW4JOYtG06M0QJr0RHmxBEiYfE8qOLwUqEBGIlrh08xTiBUWIBI8MqRvHU0uLc
        9NRio7zUcr3ixNzi0rx0veT83E2MwFg7/e/4lx2Mu/4kHWIU4GBU4uGdESUVI8SaWFZcmXuI
        UYKDWUmEV30zUIg3JbGyKrUoP76oNCe1+BCjNAeLkjhvNcODaCGB9MSS1OzU1ILUIpgsEwen
        VAPjvJ17PoT3nP/NzfR7RbD0LBEmkaNSX658f5bcorAt6dnj4779jUqPQw49Zv6oPcv+r3KK
        m/+2BzMOcDXadDOGr5h+muew2fTLHzlD4rSnz5jxpULQLkPugqjW44lLm7d/XKTFKnx9+y3R
        QhcTq0dximwWPhOd58mVvz5xelJimeLyf5tZt4nYKrEUZyQaajEXFScCAG+gsv2xAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEJMWRmVeSWpSXmKPExsVy+t/xy7qpLNIxBtPWaVm83HuI2aLjoovF
        o5u/WS323tK2uLxrDpvFsq/v2S02tMxit3g0YRKTA4fHzll32T02repk8+jbsorRY+enzawe
        nzfJBbBGcdmkpOZklqUW6dslcGUs2nWWqaCFo6Kh7TBzA+NJti5GDg4JAROJ3ssmXYxcHEIC
        SxglZizsY4Jw/jNKNB85wNLFyMnBJqAtcX3tVkYQW0SgXuJT934WkCJmgS2MErunLWIFSQgL
        OEu8PrmbHcRmEVCVWL54JVgzr4CbxLvVp5lBbAkBOYmb5zqZJzByLWBkWMUoklpanJueW2yo
        V5yYW1yal66XnJ+7iREYEtuO/dy8g/HSxuBDjAIcjEo8vDOipGKEWBPLiitzDzFKcDArifCq
        bwYK8aYkVlalFuXHF5XmpBYfYpTmYFES5z1vUBklJJCeWJKanZpakFoEk2Xi4JRqYGx5/Nif
        ScWZfQ137fSzWbkSLL/m+UyWLSq1/ix8dPfbdSnsJ8SPLPufdMV44XH37oLaG8UTzncYCr+8
        n2o0Xy1We+7BCxyhDGU6MQEWxy7PZbm5WGz/WfnYwI5tz03t+jIveQSVpaqn21WJv962QHLL
        7pNuy9a5Red9fX764a7bj1rKXz3/naDEUpyRaKjFXFScCADtyJMNBQIAAA==
X-CMS-MailID: 20181220025430eucas1p2850d6fc8565162908f0540db57d4ec32
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181220025430eucas1p2850d6fc8565162908f0540db57d4ec32
References: <CGME20181220025430eucas1p2850d6fc8565162908f0540db57d4ec32@eucas1p2.samsung.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When the bio is given as parameter, zram calls the bio_endio() with
given bio after zram io finished.
However in the case of partial writing, the __zram_bvec_read() calls
the bio_endio() with the given bio regardless of the write operation.
In other words, the bio_endio() may be called at an unwanted time.
So this patch avoids calling bio_endio() with given bio before
writing is completed.

Signed-off-by: Huijin Park <huijin.park@samsung.com>
---
 drivers/block/zram/zram_drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4879595..b3d3ba2 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1226,7 +1226,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 		if (!page)
 			return -ENOMEM;
 
-		ret = __zram_bvec_read(zram, page, index, bio, true);
+		ret = __zram_bvec_read(zram, page, index, NULL, true);
 		if (ret)
 			goto out;
 
-- 
1.7.9.5

