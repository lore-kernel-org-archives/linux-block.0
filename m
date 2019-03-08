Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E01C43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 10:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FFA2081B
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 10:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfCHKQU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:16:20 -0500
Received: from mout.gmx.net ([212.227.15.19]:47579 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfCHKQU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 05:16:20 -0500
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx003 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0Lhfu5-1ggfQZ0ULZ-00mqWT; Fri, 08 Mar 2019 11:16:18 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH 2/2] block: code cleanup for bio_find_or_create_slab()
Date:   Fri,  8 Mar 2019 18:15:40 +0800
Message-Id: <20190308101540.24337-2-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190308101540.24337-1-cgxu519@gmx.com>
References: <20190308101540.24337-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:useDhvtVRU6tlxRXQy99R+6u4e8DQLqTBrEaWqX2RpiOVLoGiP5
 mSmRHGmizDshDQHFWOxkyLPRDUQEfmFIq21Lr9otZhuD/pm83qEcuE76u8TxcCKz6pS1JUU
 Le4B7qwpwYdsQbBU0Ye9L7koO4cOfcH+rxQ0u1Q45dArNUWwK2ZZj2F/nguMf1JpAmShK55
 sdpsywm1TbnZfDYf+4mmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:so1/LFNnZqI=:njYnS7tY4vQenVFpkUgKw4
 YwQ8do6/5yHwWmFihXMLR0wd+RadKHv2CbhP1permaZER2paWAQ4CT5jHz1Y/K0h19MGDyV//
 rzewfQoVoZ3w/kV2EYvvG0wlmAIySbVodQuAqQ8T7DpiAV6PvFxcCfUE3gpxbFhhL5tP8tkjk
 MmbdnR4QIXsezaugQlzeSFSD+e1Xh81IGEw4gQipShYtS1WrgyxkQvkRK59ApreBV0yLGzfaX
 fwQDQqiApIy9V9qQHUTm8mlSj3DLqbjEF6bD3W82RGs+PCpeBWR+ChUdrvnV1XKFyiGOGV5kL
 nhimuMucXZITUN6cwsjX5Z6OE+WJt58ULGoBLclNKyOVBEf3+f8T8ZRzZkabnxEgUvOoGj2Ni
 tROXjZsfPA9n3QioOKdWb8QjsGuCzfGGEe6Fw/hOP/RriDTEAUVtb9Oogo1ShqjNvEzGFUsc5
 kkC+wQ8yGRef210OPOX6VDqW3p1F/ZJ4VHLJ3gYg+MXJ0MyPRgKW3ScI+R5WmYDWFqRi/DkC8
 XBqiew8NXRnNhpZ4mXSoFifPUgLDYAxh3ohhnEVvXH09CpF6VfCV02+wvd1zDFQOqrQfLSLwN
 jmP6zAMnpUQh0xyPpIBIM+ubD1Uz7Lsy+M2jHAS57Hs3yU1zDP1c9NnRs3w9F8pbfteSU3gSd
 h6lI5dN0dfS7Uhg92TX7O5rBfvEh9wmNMdN+Bm7R5exPLTM7sWgIcItPv4OBuCPOeTkCuZgPo
 QMXu9MOCeTFMGZHi4BJTl4BVTjfRghLbfwhllzIMCrBQNognsNZ5aJM4Es2xLWAaca/g/+XD8
 E9h2ELWjdLF9An+01GD5nyLxAd3lTqNexvnOs4VY/6gDi6Y7gs4cG6Wflzu+YauXLEqVhSSno
 2UO4nT1Q4iP+bMpNe8qXtnklbJ6+KElp/oPzzxrLoegJoVoC6mflJpdCfabRdC
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It's just a simple code cleanup, not functional change.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 block/bio.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 8081906f5d01..fefd49a561ab 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -90,29 +90,27 @@ static struct kmem_cache *bio_find_or_create_slab(unsigned int extra_size)
 		else if (bslab->slab_size == sz) {
 			slab = bslab->slab;
 			bslab->slab_ref++;
-			break;
+			goto out_unlock;
 		}
 		i++;
 	}
 
-	if (slab)
-		goto out_unlock;
-
-	if (bio_slab_nr == bio_slab_max && entry == -1) {
-		new_bio_slab_max = bio_slab_max << 1;
-		new_bio_slabs = krealloc(bio_slabs,
+	if (entry == -1) {
+		if (bio_slab_nr == bio_slab_max) {
+			new_bio_slab_max = bio_slab_max << 1;
+			new_bio_slabs = krealloc(bio_slabs,
 					 new_bio_slab_max * sizeof(struct bio_slab),
 					 GFP_KERNEL);
-		if (!new_bio_slabs)
-			goto out_unlock;
-		bio_slab_max = new_bio_slab_max;
-		bio_slabs = new_bio_slabs;
-	}
-	if (entry == -1)
+			if (!new_bio_slabs)
+				goto out_unlock;
+			bio_slab_max = new_bio_slab_max;
+			bio_slabs = new_bio_slabs;
+		}
+
 		entry = bio_slab_nr;
+	}
 
 	bslab = &bio_slabs[entry];
-
 	snprintf(bslab->name, sizeof(bslab->name), "bio-%d", entry);
 	slab = kmem_cache_create(bslab->name, sz, ARCH_KMALLOC_MINALIGN,
 				 SLAB_HWCACHE_ALIGN, NULL);
-- 
2.20.1

