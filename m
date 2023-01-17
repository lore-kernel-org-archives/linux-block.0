Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07A6C3DA78
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 12:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbjAQMul (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 07:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbjAQMuT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 07:50:19 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D9D39CEA
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 04:49:18 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230117124917epoutp026ddf5bc766c6ff174dbe9165862cf3b3~7GYetXcGD2206322063epoutp02M
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 12:49:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230117124917epoutp026ddf5bc766c6ff174dbe9165862cf3b3~7GYetXcGD2206322063epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673959757;
        bh=oeDYEXVmmnImj5v8eZVFizkvI/O2OXXucvUr8qTHeSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYFJU9Da2dd/aTFMCfJ6xsml9fj2jJ1YupHGniQwAcw3+o+CcBdQkoirApvA9Iw71
         vyy+npEav2N4KRFfaGOuH8u9pW4PeuizqQLWETQPTk/0B2OCYE3EhredST+HCEfeuw
         TE7VYaSXCKz9gmbAmyPzpSlQGUAQ6pzNMmiLOaOg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230117124916epcas5p197c494391b94798e953a12e2e176eb05~7GYeJvOyR1503115031epcas5p1i;
        Tue, 17 Jan 2023 12:49:16 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Nx7xk5VJlz4x9Pp; Tue, 17 Jan
        2023 12:49:14 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.64.02301.A4996C36; Tue, 17 Jan 2023 21:49:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230117120802epcas5p4a9d1fca9d49140649a4152856b54f81f~7F0eF2U9-0962809628epcas5p4M;
        Tue, 17 Jan 2023 12:08:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230117120802epsmtrp254beb45c366894ef2ea6e58709d91fb9~7F0eFDBEJ0039100391epsmtrp2k;
        Tue, 17 Jan 2023 12:08:02 +0000 (GMT)
X-AuditID: b6c32a49-473fd700000108fd-b8-63c6994a43c2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.24.02211.2AF86C36; Tue, 17 Jan 2023 21:08:02 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230117120801epsmtip220b1f0d83333e54782a10fed688b1a83~7F0cxCsu_0720607206epsmtip2F;
        Tue, 17 Jan 2023 12:08:00 +0000 (GMT)
From:   Anuj Gupta <anuj20.g@samsung.com>
To:     axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
        asml.silence@gmail.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH for-next v1 2/2] block: extend bio-cache for non-polled
 requests
Date:   Tue, 17 Jan 2023 17:36:38 +0530
Message-Id: <20230117120638.72254-3-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230117120638.72254-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmlq7XzGPJBjubNS2aJvxltpizahuj
        xeq7/WwWNw/sZLJYufook8XR/2/ZLCYdusZosfeWtsX8ZU/ZHTg9ds66y+5x+Wypx6ZVnWwe
        m5fUe+y+2cDm0bdlFaPH501yAexR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbm
        Sgp5ibmptkouPgG6bpk5QHcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSK
        E3OLS/PS9fJSS6wMDQyMTIEKE7Izfn85zl5wjq2id5FNA+Mm1i5GTg4JAROJHx+6mLsYuTiE
        BHYzStw68ZMRwvnEKLFs9W82kCohgW+MEv2bpLoYOcA6jlySg6jZyyhxpasPqvszo8SnZfvB
        GtgE1CWOPG9lBLFFBLwk7t9+zwpSxCywkFFi0vI3YEXCAkESa84fZQGZyiKgKrHoIhdImFfA
        UmLq85lQ58lLzLz0nR3E5hSwkvh4fjYrRI2gxMmZT1hAbGagmuats8GOkBBo5JCYdXoRC8Sl
        LhKtJwMg5ghLvDq+hR3ClpL4/G4vG4SdLvHj8lMmCLtAovnYPkYI216i9VQ/M8gYZgFNifW7
        9CHCshJTT61jgljLJ9H7+wlUK6/EjnkwtpJE+8o5ULaExN5zDVC2h8SEVW3skLDqZZS4ceU6
        4wRGhVlI3pmF5J1ZCKsXMDKvYpRMLSjOTU8tNi0wzEsth0dxcn7uJkZwQtXy3MF498EHvUOM
        TByMhxglOJiVRHj9dh1OFuJNSaysSi3Kjy8qzUktPsRoCgzuicxSosn5wJSeVxJvaGJpYGJm
        ZmZiaWxmqCTOm7p1frKQQHpiSWp2ampBahFMHxMHp1QDU4G169o/OkIJE3/o8d8/trVF/7SM
        TqWRbUPopZYnweHu+en2Ui7SHfuF7CXs9O7O0X3hIdmd+7piGvfxyybefs5nry6PN+pZKH7Z
        YK57tAPLgVS2uYFys59svPfwaKuWFG+K0hXfazlbjLdGX3/0xXCBzgoBJkO9i1XMu1tZXe5N
        OXdkd5/nnFcKia6LHh9y3PhmW2/FyVsZHFM9y/a8XHUrY4vrUo3bqfOnaCZvtXddf2H36yzH
        CW1PUr/Gh8/j/JO3JdLlRUHsE1bGkqUlf5/+El1p0qvbcJnnoHd5F7fxwdAEU900Xa3Th0xM
        Z4fz7NzjeoXrYnbYkg9rkj1M171dyn9HLvfxQamMTX7flFiKMxINtZiLihMBHS+y3TEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSvO6i/mPJBj8XiFk0TfjLbDFn1TZG
        i9V3+9ksbh7YyWSxcvVRJouj/9+yWUw6dI3RYu8tbYv5y56yO3B67Jx1l93j8tlSj02rOtk8
        Ni+p99h9s4HNo2/LKkaPz5vkAtijuGxSUnMyy1KL9O0SuDJ+fznOXnCOraJ3kU0D4ybWLkYO
        DgkBE4kjl+S6GLk4hAR2M0pc/nSdsYuREyguIXHq5TIoW1hi5b/n7BBFHxklTm3cyg6SYBNQ
        lzjyvBWsSEQgQOJg42WwImaBpYwSk7e3gyWEgRJT198C28YioCqx6CIXSJhXwFJi6vOZrBAL
        5CVmXvoONpNTwEri4/nZYHEhoJoFH9oYIeoFJU7OfMICYjMD1Tdvnc08gVFgFpLULCSpBYxM
        qxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgoNeS3MH4/ZVH/QOMTJxMB5ilOBgVhLh
        9dt1OFmINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpm5V
        5XOpM9rX3FP7dI7/2QO51u8Tsnlkt86SlXka1sMdW/jtl/uTksNi+7Pmd0z+qzJ5Z3nmhakJ
        S64bJS0x3L47SvUnk89tseDYhoWWTqFOCmc/qJgd6p6UY+pyrFJCzbcprX373s2HX7PP1D4c
        phP/iOEoj23q1lsPdmcYpmx/Wvwj5EuD1/rgJdbSR80uVN85L7fG7MzBHTvPNc8/u8eBvSun
        X2WGrLpx/AahhfHfF0yLDPdtbUr43Xf3TewS42lvi258fXn+3hPNhs1qfkHfX60UkD1UunqG
        0lujp6Xr6l7eYos1np+w88uKF0e3HyvXfCkW7SvPxPs6j6c8u9JuJpfRVxWPl82ak6czSCux
        FGckGmoxFxUnAgCchTDT6QIAAA==
X-CMS-MailID: 20230117120802epcas5p4a9d1fca9d49140649a4152856b54f81f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230117120802epcas5p4a9d1fca9d49140649a4152856b54f81f
References: <20230117120638.72254-1-anuj20.g@samsung.com>
        <CGME20230117120802epcas5p4a9d1fca9d49140649a4152856b54f81f@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch modifies the present check, so that bio-cache is not limited
to iopoll.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/blk-map.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index f2135e6ee8f6..9ee4be4ba2f1 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -247,10 +247,8 @@ static struct bio *blk_rq_map_bio_alloc(struct request *rq,
 {
 	struct bio *bio;
 
-	if (rq->cmd_flags & REQ_POLLED) {
-		blk_opf_t opf = rq->cmd_flags | REQ_ALLOC_CACHE;
-
-		bio = bio_alloc_bioset(NULL, nr_vecs, opf, gfp_mask,
+	if (rq->cmd_flags & REQ_ALLOC_CACHE) {
+		bio = bio_alloc_bioset(NULL, nr_vecs, rq->cmd_flags, gfp_mask,
 					&fs_bio_set);
 		if (!bio)
 			return NULL;
-- 
2.25.1

