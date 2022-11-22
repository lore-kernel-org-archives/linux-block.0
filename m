Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F2CC4332F
	for <linux-block@archiver.kernel.org>; Tue, 22 Nov 2022 08:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbiKVItU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Nov 2022 03:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbiKVItU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 03:49:20 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5592EF13
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 00:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669106959; x=1700642959;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=smKB31JbIlAE0Xb0fLpXn9LT5pambLlIHOuxuNLpxjc=;
  b=MvDTDTdQnu3hvYXRc3p+uy0/bVu78zMzo97CTzUBPz7uuM25OJsCno1O
   fJEouyCKKCjVrkOCRGetJUdICtLqm2W4H6zaNLvCe+fMqdETU5o3CyB6x
   BDnChqvpK3zyMv5hjnn69NiMZBG1XWiT6wSItkddOxwbvjwVUEdrIaniw
   UgcX0YaKvLUZ9ni4fVcFIHXwlso5/3w4mEzVRmjjXZ1aCJN+fp6rMN2Oi
   3suZEMx/5fOFFeHClQNlnhpwyMAnFQmeact3pEl4wNqm9tXQKxIDYqX2C
   XJqzlbkMGV+6R9iMhupXbDlrIhqqXmIS4W2E5AbzDPCWI4QX8dUm2V40f
   A==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665417600"; 
   d="scan'208";a="222032756"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2022 16:49:19 +0800
IronPort-SDR: ETBXwUT2/QPhOAaBECbNThYQxZ8f+VAJPExoS1f38FG6Q5T37UpFG/XOf7gX1bDcMcYCo1iuMP
 P0kOXBFHPHW8CoaSSw7Mj3Y5Nl5PFSp5KKLaYgHUx+lti28J8ebNtTo6AZvjnFJ1B5a74BXj5S
 S5kfr/FMwc75razTh4a5EBpRWNF1fsGC/kHT/8n9uKhg2wEV5j+9l9Z1+S/MFRrmalfscm5nq3
 JrROyrIQPliLjjjhFTKgCXq1UWTYVAIpZPXm2kCPcuRg/FHWD30npTHaGQSUYLNuyuJBZX97c/
 jXw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Nov 2022 00:08:08 -0800
IronPort-SDR: sFXIl+IaD99tWgG7gW0u8/z4ryiyYTPG7OdHsr/3g/tpzIpjRSo0PFjiVf9sYA1G6HJ3/d8sN3
 jZmIIiksNG02r0dMXORMb04tCi9zXwQRE2FxcQa8IwbCNKPe+fWQMAdDtnYywJYGwO+RD/18yU
 nzBQHk6s+54FcmKhGUhr7XvvObf3wUEdqNt8E91vFgC5gK3XGBelvj8Xx2Omsj7GpQdFUQl4OU
 IVtjd3AiZt2SqLKWzOK2sbafZnTgKGkIW/U3XDyjBMBrFcwvPAdOtZObTI6n+ZEYNI5zXYQQYa
 jWc=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Nov 2022 00:49:18 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH for-next] block: fix missing nr_hw_queues update in blk_mq_realloc_tag_set_tags
Date:   Tue, 22 Nov 2022 17:49:17 +0900
Message-Id: <20221122084917.2034220-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The commit ee9d55210c2f ("blk-mq: simplify blk_mq_realloc_tag_set_tags")
cleaned up the function blk_mq_realloc_tag_set_tags. After this change,
the function does not update nr_hw_queues of struct blk_mq_tag_set when
new nr_hw_queues value is smaller than original. This results in failure
of queue number change of block devices. To avoid the failure, add the
missing nr_hw_queues update.

Fixes: ee9d55210c2f ("blk-mq: simplify blk_mq_realloc_tag_set_tags")
Reported-by: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://lore.kernel.org/linux-block/20221118140640.featvt3fxktfquwh@shindev/
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a3a5fb4d4ef6..f72164429446 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4385,7 +4385,7 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 	struct blk_mq_tags **new_tags;
 
 	if (set->nr_hw_queues >= new_nr_hw_queues)
-		return 0;
+		goto done;
 
 	new_tags = kcalloc_node(new_nr_hw_queues, sizeof(struct blk_mq_tags *),
 				GFP_KERNEL, set->numa_node);
@@ -4397,8 +4397,8 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 		       sizeof(*set->tags));
 	kfree(set->tags);
 	set->tags = new_tags;
+done:
 	set->nr_hw_queues = new_nr_hw_queues;
-
 	return 0;
 }
 
-- 
2.37.1

