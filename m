Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454C0C43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 10:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097BE20854
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 10:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfCHKQQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:16:16 -0500
Received: from mout.gmx.net ([212.227.15.19]:35409 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfCHKQQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 05:16:16 -0500
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx003 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0MbgKD-1hL6yW0qIP-00J4Dx; Fri, 08 Mar 2019 11:16:13 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH 1/2] block: increase bio_slab_nr only for necessary case
Date:   Fri,  8 Mar 2019 18:15:39 +0800
Message-Id: <20190308101540.24337-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NJDGC73ptg56T/6PaU11+peg/vXB/xH6KytvXqBjWctczMg2eP5
 YdV1cWDthcvwqtkDV1fkZknscnzd85RUbbhB5tAV/GkSh0nE1tixENqbsmJ7y3ucrBKrn6z
 DtzuvNEnTpaVEuhV1CKGz3Txyin7vBM8k6CBsmIUzw/8oDaxj4Af7C69L9EoJ7O86+4L/AN
 9hzAN8A+PfwqZGOan/MFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yRDS1EQYRSE=:NkSoPHc0/qrC6pCYPoPCNh
 aL+ldbRrA1LACGHD9E0Q0vS6n/I3Xx/ctLUwf+tB4VY1rmDou+qzwKV5qqKC5XWIKbGaz0ogl
 5t4JmCCp+v8F/nksg3SyKVnvHKSyE+m7XIQB0tOQWWPVJJC+EUb6MAAghi2fOEwXCVbQn45b3
 NCCJAQLmSfcuf51/IT0h0VU/OnLYH2Vrx+2drgx32RBk3V0IK3Y3RlpZw/0GY9RDWSnBF559S
 lWDeevk7TCX1mHtxY2TcFWFGyoEefcarGRaew0wpD//U0GfD4K3+QIb3qI/+qMjlLVK25ESGh
 9ECQKcrOLD5LcG4ZXy0jJB2cSqsxNzeQWXT+2AA2W2uIW1GzjunBjRcsC6g8qlJAei+E7TMqP
 PicmfBf1R5zCCItNh3JXPS+K2waCFwZq9HBLzV6Izl5WI1fd5cCtF4DgQBxmhBWEItyFSNkVN
 WKsUZ5cyQNXVmotmxoqiOMflU1OU8o+vp0c0iEeJ+iQpclo/CafYLbZOZP0tyYGlEFf/znfh2
 PmAgxGH0DuzYw4e6ai/0oMNRiAeMjWWdWGTWLBTJ1fNPtXcWLWxWfPZ59/vyKjp3W3ByAb1sk
 4UCzFWpcDd6qlysaH/iogc4q0+QPtvIABPVCexT+P+b2Vpk59eAZUtTVgqwfoucPkRTdDZbeL
 h6D6Kpc5i2RtW/qtQ3VrQUyn2hT3A4Xay6/7FriAeC6mMfeSvcLIyP4O+ktdAFlv/M1Zvt9Px
 ypGj9kMMASB/b2IdwDUpHJ//i+k3cWvwIhE6DCWg8Vu9rHgb/DPowLaXOleY0pvuBpiOf7kCk
 FxEsBxX9brjKlUM37HblpmxxRxSiq1ZYZkBLvnYya5PZKC93BjUXTHUTrDbeNiSkR3dwLz6Te
 STw2k2z0Qy4YlCPGU9C8Y/SnhWxmGAI8CJHWa89HCvuQ7bebj8TR87l1NKL2um
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When fail to create new cache in bio_find_or_create_slab(),
we should not increase bio_slab_nr because it will cause
referring uninitilized data in subsequent search.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 block/bio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 4db1008309ed..8081906f5d01 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -109,7 +109,7 @@ static struct kmem_cache *bio_find_or_create_slab(unsigned int extra_size)
 		bio_slabs = new_bio_slabs;
 	}
 	if (entry == -1)
-		entry = bio_slab_nr++;
+		entry = bio_slab_nr;
 
 	bslab = &bio_slabs[entry];
 
@@ -122,6 +122,10 @@ static struct kmem_cache *bio_find_or_create_slab(unsigned int extra_size)
 	bslab->slab = slab;
 	bslab->slab_ref = 1;
 	bslab->slab_size = sz;
+
+	if (entry == bio_slab_nr)
+		bio_slab_nr++;
+
 out_unlock:
 	mutex_unlock(&bio_slab_lock);
 	return slab;
-- 
2.20.1

