Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48826 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751817AbdGJS7b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2017 14:59:31 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6AIwq5B030162
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2017 11:59:30 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2bmb1090ra-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2017 11:59:30 -0700
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (2401:db00:2050:5102:face:0000:003b:0000) with ESMTP       id
 3894b4ae659f11e79db0ade1b876fb2a-9c9e0150 for <linux-block@vger.kernel.org>;
        Mon, 10 Jul 2017 11:40:18 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2] block: call bio_uninit in bio_endio
Date: Mon, 10 Jul 2017 11:40:17 -0700
Message-ID: <d0186f22982fb49e88bd5ee2273ba90946318ba5.1499711846.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

bio_free isn't a good place to free cgroup info. There are a
lot of cases bio is allocated in special way (for example, in stack) and
never gets called by bio_put hence bio_free, we are leaking memory. This
patch moves the free to bio endio, which should be called anyway. The
bio_uninit call in bio_free is kept, in case the bio never gets called
bio endio.

This assumes ->bi_end_io() doesn't access cgroup info, which seems true
in my audit.

This along with Christoph's integrity patch should fix the memory leak
issue.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 9cabf5d..9a63597 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1833,6 +1833,8 @@ void bio_endio(struct bio *bio)
 	}
 
 	blk_throtl_bio_endio(bio);
+	/* release cgroup info */
+	bio_uninit(bio);
 	if (bio->bi_end_io)
 		bio->bi_end_io(bio);
 }
-- 
2.9.3
