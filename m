Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38804 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752506AbdF2SyU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2017 14:54:20 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5TIqeWE025926
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 11:54:19 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2bd6qsg3ke-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 11:54:19 -0700
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.102.107.97) with ESMTP id
 5aa31e385cfc11e791870002c99331b0-81d398f0 for <linux-block@vger.kernel.org>;
        Thu, 29 Jun 2017 11:54:18 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: <hch@lst.de>, <axboe@fb.com>, <Kernel-team@fb.com>
Subject: [PATCH] block: call __bio_free in bio_endio
Date: Thu, 29 Jun 2017 11:54:17 -0700
Message-ID: <a4ff33f2c114d0d0e1d1f41b7524078d2e9fd3f0.1498762065.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

bio_free isn't a good place to free cgroup info. There are a
lot of cases bio is allocated in special way (for example, in stack) and
never gets called by bio_put hence bio_free, we are leaking memory. This
patch moves the free to bio endio, which should be called anyway. The
__bio_free call in bio_free is kept, in case the bio never gets called
bio endio.

This assumes ->bi_end_io() doesn't access cgroup info, which seems true
in my audit.

This along with Christoph's integrity patch should fix the memory leak
issue.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 9cf98b2..e8cda9c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1828,6 +1828,8 @@ void bio_endio(struct bio *bio)
 	}
 
 	blk_throtl_bio_endio(bio);
+	/* release cgroup info */
+	__bio_free(bio);
 	if (bio->bi_end_io)
 		bio->bi_end_io(bio);
 }
-- 
2.9.3
