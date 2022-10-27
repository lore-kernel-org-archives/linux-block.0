Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248E0C38A2D
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 10:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiJ0KPx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 06:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiJ0KPq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 06:15:46 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B1852E58
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 03:15:43 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221027101541epoutp047422371a76a3c5243a5d7e0472ffce32~h5Y93Rkra1028310283epoutp04b
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 10:15:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221027101541epoutp047422371a76a3c5243a5d7e0472ffce32~h5Y93Rkra1028310283epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666865741;
        bh=XVsj4N5BUDcKzrgvZUOiM5KMCXl5bBbU2cDw2F5NevA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=WhMclYR2df/5VBVnFHCSJf9etvSw+KPyuefP52372YDNxAFaQ2psGvKMg/Yr5j2T0
         iT404SXTmA/f3g3r/S1NdJR4hTdEz/i1dXfcc3yGE08lH/XD9n7oUGtCU+PUkLqBeL
         3K7ytdvKkVX2jzz1pMHYR26q37hfgp7xkPJkJqA0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221027101540epcas5p2a89eb6abb7b6f8e1558ccceb9adf0bbf~h5Y8vBoqQ2337223372epcas5p2J;
        Thu, 27 Oct 2022 10:15:40 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MyhQJ6pcvz4x9Py; Thu, 27 Oct
        2022 10:15:36 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.19.56352.74A5A536; Thu, 27 Oct 2022 19:15:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221027101534epcas5p3b8335c05a1003531f1a4488dc27f27ee~h5Y3mf_ti0474804748epcas5p3j;
        Thu, 27 Oct 2022 10:15:34 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221027101534epsmtrp27acecbc48af9b61125c1053907a3f899~h5Y3liqLI0697806978epsmtrp2g;
        Thu, 27 Oct 2022 10:15:34 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-5b-635a5a471415
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.07.18644.64A5A536; Thu, 27 Oct 2022 19:15:34 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221027101533epsmtip15411bcdc063317883da3c5e9ef29ca18~h5Y2tZp8w2533025330epsmtip1Z;
        Thu, 27 Oct 2022 10:15:33 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     axboe@kernel.dk, asml.silence@gmail.com,
        linux-block@vger.kernel.org
Cc:     Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH] block: fix bio-allocation from per-cpu cache
Date:   Thu, 27 Oct 2022 15:34:10 +0530
Message-Id: <20221027100410.3891-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7bCmlq57VFSywdV9ehZzVm1jtFh9t5/N
        4uj/t2wWe29pO7B47Jx1l93j8tlSj74tqxg9Pm+SC2CJyrbJSE1MSS1SSM1Lzk/JzEu3VfIO
        jneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAVqopFCWmFMKFApILC5W0rezKcovLUlVyMgv
        LrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOmDdtN1PBV96Kp3emMjYwnuXuYuTk
        kBAwkTjX8pexi5GLQ0hgN6PE9gP9zBDOJ0aJo1vPQ2U+M0rcvd3KDtPy5M9FFojELkaJF89O
        IlQd+NzH2sXIwcEmoClxYXIpSIOIgIfE6j3nmEBsZgF1iXdnVrKB2MICthJ7NmwEG8oioCqx
        sPcnI4jNK2Au8XbWZEaIZfISMy99Z4eIC0qcnPmEBWKOvETz1tnMEDWb2CU6p5pB2C4Sx6Z+
        YIKwhSVeHd8CdbSUxOd3e9kg7GSJSzPPQdWUSDzecxDKtpdoPQXyPgfQfE2J9bv0IVbxSfT+
        fsIEEpYQ4JXoaBOCqFaUuDfpKSuELS7xcMYSKNtD4uCOnWC2kECsxP6e1ywTGOVmIXlgFpIH
        ZiEsW8DIvIpRMrWgODc9tdi0wDgvtRwelcn5uZsYwSlNy3sH46MHH/QOMTJxMB5ilOBgVhLh
        PXsjPFmINyWxsiq1KD++qDQntfgQoykwVCcyS4km5wOTal5JvKGJpYGJmZmZiaWxmaGSOO/i
        GVrJQgLpiSWp2ampBalFMH1MHJxSDUxvOR1Z5G76bd52e9ajv6tNvm7ZvUD5RDJHqWeXoM6i
        o/mvm35NOy7Az6ddcU6fx3lD9qYbExgcirbe2XF8f7m8w05m0R6G5YZSr52O72X6M+vvy4n5
        UVeMMhtS78098CuNUfpPZFGEz8I3T7ylpy+Kr9lv7WjP784/KVJc0Oq/QyLbzTC2bOvQltSp
        JjyM3H2vd2/b/CFBzs7lYc4j1XytEzPWlUucmflwAvv/kO9X919wTv6yY9cptqK0RzeVN37L
        /3VwzrqaU6pHpE7VrRE5nxwqefTcmv8fVzS0zOxP+DH/75+eyuq/lu/sgw/UzvLXF/29rV7L
        5eu6xdtntq9hlvm0uWGT5P7/rB6uNvvnK7EUZyQaajEXFScCAOh+Wh/yAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsWy7bCSnK5bVFSywav5qhZzVm1jtFh9t5/N
        4uj/t2wWe29pO7B47Jx1l93j8tlSj74tqxg9Pm+SC2CJ4rJJSc3JLEst0rdL4MqYN203U8FX
        3oqnd6YyNjCe5e5i5OSQEDCRePLnIksXIxeHkMAORolnTzcxQiTEJZqv/WCHsIUlVv57zg5R
        9JFR4uuUJ0xdjBwcbAKaEhcml4LUiAj4SDTu38gMYjMLqEu8O7OSDcQWFrCV2LNhI9gcFgFV
        iYW9P8Hm8wqYS7ydNRlql7zEzEvf2SHighInZz5hgZgjL9G8dTbzBEa+WUhSs5CkFjAyrWKU
        TC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECA48La0djHtWfdA7xMjEwXiIUYKDWUmE9+yN
        8GQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamE5sLNvQ
        5rH9mkLtFp4Q6Vu3+ayeH/sR0Xjqx9p/x9NtOFmyRb0y3JbunF4ZLtZ1aGfZZ76agycvhUT2
        n2nZNXv9/C1Ojp+sGl4tdDALmBselpP5OOh/Y6uEpoXLjLX3Va5+f3r1nXhKlOXPzwVx+dfU
        ludvOdYWVnnoxmLWS5pf/BbPmmF1YfmDrS96ylkrU4XWTlmyQVLz5Cf/nA3TXi9ecah0bSbH
        NIONmtdE3vvOd46M6g58duKM/OUsnez1K/t1atWK2R9nlO3/9PjzMYc/W6dOnVty6qCAt/mD
        VA65BdPW225ZuSWn/s6e8CK3aU0hc+97xny58n+TUFJQ7rvyRcmZtXrLpoUHfznwpOWAEktx
        RqKhFnNRcSIArcitzKsCAAA=
X-CMS-MailID: 20221027101534epcas5p3b8335c05a1003531f1a4488dc27f27ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221027101534epcas5p3b8335c05a1003531f1a4488dc27f27ee
References: <CGME20221027101534epcas5p3b8335c05a1003531f1a4488dc27f27ee@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If cache does not have any entry, make sure to detect that and return
failure. Otherwise this leads to null pointer dereference.

Fixes: 13a184e26965 ("block/bio: add pcpu caching for non-polling bio_put")
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
Can be reproduced by:
fio -direct=1 -iodepth=1 -rw=randread -ioengine=io_uring -bs=4k -numjobs=1 -size=4k -filename=/dev/nvme0n1 -hipri=1 -name=block

BUG: KASAN: null-ptr-deref in bio_alloc_bioset.cold+0x2a/0x16a
Read of size 8 at addr 0000000000000000 by task fio/1835

CPU: 5 PID: 1835 Comm: fio Not tainted 6.1.0-rc2+ #226
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g
Call Trace:
 <TASK>
 dump_stack_lvl+0x34/0x48
 print_report+0x490/0x4a1
 ? __virt_addr_valid+0x28/0x140
 ? bio_alloc_bioset.cold+0x2a/0x16a
 kasan_report+0xb3/0x130
 ? bio_alloc_bioset.cold+0x2a/0x16a
 bio_alloc_bioset.cold+0x2a/0x16a
 ? bvec_alloc+0xf0/0xf0
 ? iov_iter_is_aligned+0x130/0x2c0
 blkdev_direct_IO.part.0+0x16a/0x8d0

 block/bio.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 8f624ffaf3d0..66f088bb3736 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -439,13 +439,14 @@ static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
 
 	cache = per_cpu_ptr(bs->cache, get_cpu());
 	if (!cache->free_list &&
-	    READ_ONCE(cache->nr_irq) >= ALLOC_CACHE_THRESHOLD) {
+	    READ_ONCE(cache->nr_irq) >= ALLOC_CACHE_THRESHOLD)
 		bio_alloc_irq_cache_splice(cache);
-		if (!cache->free_list) {
-			put_cpu();
-			return NULL;
-		}
+
+	if (!cache->free_list) {
+		put_cpu();
+		return NULL;
 	}
+
 	bio = cache->free_list;
 	cache->free_list = bio->bi_next;
 	cache->nr--;
-- 
2.25.1

