Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07472C19759
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 10:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F734206A2
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 10:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YqBJJjS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfHAKVy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 06:21:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26358 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbfHAKVx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 06:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564654913; x=1596190913;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aggZcSPS3xcvRMHLy9IinQXiE+ZvVRSbcBtZoLj/F4g=;
  b=YqBJJjS6GoStoNQpWJHoROEZcd2KKEhOd3nHlnU8gfNlWqHHEOmfvVyI
   C03v3zpSBeZWkZYtZUUeqCnluNuHJK5s80i/uBTY2L3LTm3sLbdB9mCJm
   iJA3lktwBRBZkyG7AfReFwnUNbvqQ1ib3qqesLUqvdS8AjwqbSx1IwXfW
   mIaot/lAFrZ57RAQ2ohHCIYLcALU0hbFPRrNCjUdUXhaXWLleQn+7Gw3W
   676j2GFk4sy8/QGnSQdLhQXB2fGBeMShjP1SKMz58R/I4UHYm7RXBztgv
   c/ByKw/3c4/qtbJEs8ABTbMzDo+Tvr22m9/vgAJBTUDzNybJ77cCBtQKq
   w==;
IronPort-SDR: iK9+j0B4RbdyIKW9gVm03fhgInGRdSVXtEI1LqZ6U8MY1alFhJtRZCyRqqI2AWS5bU/KVdxhci
 0vSV19/rrmVzmC7nHT0OOUvip3He6hB+5lx+jP6YtK6HNfSzI57XoGlbV5pKgl6AXFflSfkC0D
 Vf2Ehg5pzWBCZ07QP4vk3CSR3zwGe7yQuMLagNnHf5EFeG6ZESpf6bp6coYdFJ2rZDDqNHQEiR
 zliiQe6k0udjvvXQvyIXIv37lu4TVpl/ylGvVarprxZDjcuX2WFILreqkHB+uTUverAPQib96f
 GBU=
X-IronPort-AV: E=Sophos;i="5.64,333,1559491200"; 
   d="scan'208";a="119354034"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2019 18:21:53 +0800
IronPort-SDR: A0woRhtM1LGZy8wIHUqT/3GV92gke4qFHM7SJnDR0+vxI2BY3OGfeq6xc8R2uf3gzMC4AD7wqK
 lyzX+fM/Vv3XzKpDkwD45+nxC8HB7AIDa5PEYWn2dHnrY2T4lD7iZGMCgffF9sos17F0qvBKa/
 e4rTchDOGPH6VUoevo4bOA6V5u0JO6PaFIi07Cga9jUcCFPK4qjv+uBrRy57IgB8WOdx15zao3
 KvKWlHofcmwr7D0oM44+P27Xvq2/bG2EYkzLpHW8mjWkXFCtXlXvMiaPmi06UKoKCXi0961Axx
 2FKIolv2HJ/pORli2ip3hVE+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 03:19:53 -0700
IronPort-SDR: XXG0M4GeBFx5HpeeIOTmwj9toy4UsYn6yAHH7CxQMWJWJ1RcmALjud/5osXoUHqG1mSvtrmX4T
 C5Gmoa+wl4aHqQHgKR7sQrLI2YizWhqafmqL7F21zlD4q0iCq4F+PRs8q6b1LFLPf/COYUnwuW
 VMTBxDdFvsYgPXdXLYjg2aqTECq+tr85Anw3nYVul4R7ED+UM4jJ2bdvF38ah2P+oY1CG5hYTc
 ywAZrcHKcKoYKj2AsQlSlqZnIqcmLFwmKk4Wtm9ct/NHUGf6aczsEPvrFKMq2oBhvblFpyOUFA
 xLM=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Aug 2019 03:21:53 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Masato Suzuki <masato.suzuki@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] block: Fix __blkdev_direct_IO()
Date:   Thu,  1 Aug 2019 19:21:51 +0900
Message-Id: <20190801102151.7846-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The recent fix to properly handle IOCB_NOWAIT for async O_DIRECT IO
(patch 6a43074e2f46) introduced two problems with BIO fragment handling
for direct IOs:
1) The dio size processed is claculated by incrementing the ret variable
by the size of the bio fragment issued for the dio. However, this size
is obtained directly from bio->bi_iter.bi_size AFTER the bio submission
which may result in referencing the bi_size value after the bio
completed, resulting in an incorrect value use.
2) The ret variable is not incremented by the size of the last bio
fragment issued for the bio, leading to an invalid IO size being
returned to the user.

Fix both problem by using dio->size (which is incremented before the bio
submission) to update the value of ret after bio submissions, including
for the last bio fragment issued.

Fixes: 6a43074e2f46 ("block: properly handle IOCB_NOWAIT for async O_DIRECT IO")
Reported-by: Masato Suzuki <masato.suzuki@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/block_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index c2a85b587922..75cc7f424b3a 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -439,6 +439,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 					ret = -EAGAIN;
 				goto error;
 			}
+			ret = dio->size;
 
 			if (polled)
 				WRITE_ONCE(iocb->ki_cookie, qc);
@@ -465,7 +466,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 				ret = -EAGAIN;
 			goto error;
 		}
-		ret += bio->bi_iter.bi_size;
+		ret = dio->size;
 
 		bio = bio_alloc(gfp, nr_pages);
 		if (!bio) {
-- 
2.21.0

