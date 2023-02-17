Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E192C636D4
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 12:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBQMQ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Feb 2023 07:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBQMQt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 07:16:49 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBDD68562
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 04:16:15 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230217121603euoutp019b6ed64248c2a1a1ad67822b7b755a4e~Em7UhOYY31850618506euoutp01d
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 12:16:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230217121603euoutp019b6ed64248c2a1a1ad67822b7b755a4e~Em7UhOYY31850618506euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676636163;
        bh=LbgkyWrprcJ1/EyyqzYj2ibO7oqMjTUnaV1LOVnbzf4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VwZmk/zy3hOGNlZSWZKMNVodEhtMY7jGq9b6R1Suxz3Akf2frRXkW2A7r61TyN0Ej
         MWQsn/IyH4UwpHdn0oFugUzbOSvvUs3dR2PZnC4NbNv/euTYlT2Y/eIMfvDKcKrMz9
         OU5CPyyeSSIKiyP05haZjxc7DQ8RUKRnoNjlbdi8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230217121602eucas1p1b333f4243dd9a72152f4b36467a85f55~Em7Texrs51406714067eucas1p12;
        Fri, 17 Feb 2023 12:16:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 31.A3.13597.2007FE36; Fri, 17
        Feb 2023 12:16:02 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230217121602eucas1p1b85aa17f46f6b602446a9d83ccf67708~Em7TM6AlH2407324073eucas1p1U;
        Fri, 17 Feb 2023 12:16:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230217121602eusmtrp2e86c0df182d10a6397e0dcaf7f6e6b4a~Em7TL3paI2697026970eusmtrp2W;
        Fri, 17 Feb 2023 12:16:02 +0000 (GMT)
X-AuditID: cbfec7f4-207ff7000000351d-01-63ef7002988c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 91.B5.00518.1007FE36; Fri, 17
        Feb 2023 12:16:02 +0000 (GMT)
Received: from localhost (unknown [106.210.248.118]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230217121601eusmtip12c87f1ffff36d5c1b5d0de107e65c0dc~Em7S3iVnk0439004390eusmtip1t;
        Fri, 17 Feb 2023 12:16:01 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, gost.dev@samsung.com, linux-block@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] brd: use radix_tree_maybe_preload instead of
 radix_tree_preload
Date:   Fri, 17 Feb 2023 17:44:44 +0530
Message-Id: <20230217121442.33914-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7djPc7pMBe+TDa5dFbdYfbefzeLmgZ1M
        FitXH2Wy2HtL2+Lz0hZ2B1aPy2dLPXbfbGDz6NuyitHj8ya5AJYoLpuU1JzMstQifbsEroz+
        l8+ZCk5zV/yb1c7YwHiXs4uRk0NCwETi4sYOdhBbSGAFo8T8T4ZdjFxA9hdGiYVvDrBCOJ8Z
        JW7e3cUE0/Ht2iE2iMRyRomWtUuhnJeMEpuuzmTsYuTgYBPQkmjsBBsrIiAssb+jlQXEZhbI
        lDjZvJAFpERYIEjizgZbkDCLgKrE1u+7mEFsXgFLidvztkPtkpeYeek7O0RcUOLkzCdQY+Ql
        mrfOZgZZKyHQyCGxePUqFogGF4mf2z8xQ9jCEq+Ob2GHsGUk/u+cDzW0WuLpjd9QzS2MEv07
        17OBHCQhYC3RdyYHxGQW0JRYv0sfotxR4taN06wQFXwSN94KQpzAJzFp23RmiDCvREebEES1
        ksTOn0+glkpIXG6aA3WYh0Rz40MmSDjHStxqbWafwKgwC8ljs5A8NgvhhgWMzKsYxVNLi3PT
        U4uN8lLL9YoTc4tL89L1kvNzNzECU8jpf8e/7GBc/uqj3iFGJg7GQ4wSHMxKIrybbr5JFuJN
        SaysSi3Kjy8qzUktPsQozcGiJM6rbXsyWUggPbEkNTs1tSC1CCbLxMEp1cC08uLnsoec2vtm
        XiiexbRtyYI/G3/rJ1XP3rns9PTzy9a8DSm4YHZ1ks+b2/HvcgV91KfsZ7o6y2jOjWMM5mLJ
        4k/WdMz+ztr7ZJqFcd+xPrEpp+54HrCtWs+4//uPii7TjxwV57Lit56UmlJ7fHW9TNYfrols
        z66adyqkvpPymJogfiort+WsS1mBzKmCiTFs5Qmtnau5+WxnvfwykbmS58yd7R9VIm+q665o
        OLyNZ37bpy8rzdu412sHH3V5uUXqYs2LU69Loxflh/yQF1nx0++f/KKsStMzEVctP/fdDzb6
        HPP/T+cF36bIN/cPVd0I0ZyQp+ho7/I+5rJdidTtav8lq7+WvVywiO+lM8f8ICWW4oxEQy3m
        ouJEAOroD0aQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsVy+t/xu7pMBe+TDT4sZrZYfbefzeLmgZ1M
        FitXH2Wy2HtL2+Lz0hZ2B1aPy2dLPXbfbGDz6NuyitHj8ya5AJYoPZui/NKSVIWM/OISW6Vo
        QwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYz+l8+ZCk5zV/yb1c7YwHiXs4uR
        k0NCwETi27VDbF2MXBxCAksZJU4cPs0EkZCQuL2wiRHCFpb4c60Lqug5o8TB0/+Aijg42AS0
        JBo72UFqRIBq9ne0soDYzAK5EtcevWADsYUFAiT+3ZwIFmcRUJXY+n0XM4jNK2ApcXvedqhd
        8hIzL31nh4gLSpyc+QRqjrxE89bZzBMY+WYhSc1CklrAyLSKUSS1tDg3PbfYSK84Mbe4NC9d
        Lzk/dxMjMIC3Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuHddPNNshBvSmJlVWpRfnxRaU5q8SFG
        U6D7JjJLiSbnA2MoryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qB
        qVzyzsNV9ReOW274b9ihavlb9UDc5FSZHplTnN+eJC5Tr0v9lZWTIXy4+He15uZHPy1063U0
        gvzPcRlIuItd2zI53tUuzfoXX4Ph3mBLhhvvX6jeKPleESfi62ou0dA7WVtAu+7bHnvRDS/2
        mMcLX8hKO3/Uzffnk21PLlVlCVz9tL+rvm+7T/qLiTfKzN91c5kIar368/87t2fKspk/18xV
        1D59N8zHMnof/+/UZ8uVJOd8MLkVrVSgcy0hPC3LbXpslPyRg/+KrXLFoxNuHHme83T74ykN
        LJocrgWcBoe4a+eunb7tnIqBGOft/0WR7H2b1W/8uSfGV53GYmBwWXdRrxjnhYb34rKSX68q
        sRRnJBpqMRcVJwIATs8TJekCAAA=
X-CMS-MailID: 20230217121602eucas1p1b85aa17f46f6b602446a9d83ccf67708
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230217121602eucas1p1b85aa17f46f6b602446a9d83ccf67708
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230217121602eucas1p1b85aa17f46f6b602446a9d83ccf67708
References: <CGME20230217121602eucas1p1b85aa17f46f6b602446a9d83ccf67708@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Unconditionally calling radix_tree_preload_end() results in a OOPS
message as the preload is only conditionally called for
gfpflags_allow_blocking().

[   20.267323] BUG: using smp_processor_id() in preemptible [00000000] code: fio/416
[   20.267837] caller is brd_insert_page.part.0+0xbe/0x190 [brd]
[   20.269436] Call Trace:
[   20.269598]  <TASK>
[   20.269742]  dump_stack_lvl+0x32/0x50
[   20.269982]  check_preemption_disabled+0xd1/0xe0
[   20.270289]  brd_insert_page.part.0+0xbe/0x190 [brd]
[   20.270664]  brd_submit_bio+0x33f/0xf40 [brd]

Use radix_tree_maybe_preload() which does preload only if
gfpflags_allow_blocking() is true but also takes the lock. Therefore,
unconditionally calling radix_tree_preload_end() should not create any
issues and the message disappears.

Fixes: 6ded703c56c2 ("brd: check for REQ_NOWAIT and set correct page allocation mask")
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/brd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 734d9193d1d8..34177f1bd97d 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -94,7 +94,7 @@ static int brd_insert_page(struct brd_device *brd, sector_t sector, gfp_t gfp)
 	if (!page)
 		return -ENOMEM;
 
-	if (gfpflags_allow_blocking(gfp) && radix_tree_preload(gfp)) {
+	if (radix_tree_maybe_preload(gfp)) {
 		__free_page(page);
 		return -ENOMEM;
 	}
-- 
2.39.1

