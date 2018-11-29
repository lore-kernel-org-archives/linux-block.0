Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CCBC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 10:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177D120863
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 10:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rnFnjfw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177D120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbeK2WAf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:00:35 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43006 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeK2WAf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 17:00:35 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wATArmct056573;
        Thu, 29 Nov 2018 10:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=5ZWr2cjWOap3myAYbiHBsW3+3XxI4l9n/cE/MqwXlEc=;
 b=rnFnjfw3zTbGfbyYmB/4TGlbI2bmyLFuWvAFM+S4GTjc1maELWiwW+OEfqATwmT8RNLL
 4VksCfIR4IaEXrWZOnfrcxAxjbBHIIulLM1BuXCDT/+86JBXYF1bgx8NKbPpQ/q6vY/k
 8lm9iGeAb6lsySoCjWnDAk7FYW0vWWDDh/UDjGyg3F6mNhxBzxCCLnYsqA5IiRW+0jys
 5j5xR9/obQcGfSFGpEaLQfZoAsIyUGAl9HdGcOXwgi2nYoxt/VPIdJLjM1MlokpOeNqQ
 Dj+RCVO5SzHuX8JoRqO57owu5opCRYqU6HcoMlwMnNPpOaYXfCqJzbdgO7QIXPeH6bWR sw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2nxy9rffg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 10:55:34 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wATAtSf4009578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 10:55:28 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wATAtS4E013869;
        Thu, 29 Nov 2018 10:55:28 GMT
Received: from kili.mountain (/197.157.34.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Nov 2018 02:55:27 -0800
Date:   Thu, 29 Nov 2018 13:55:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] ataflop: fix error handling in atari_floppy_init()
Message-ID: <20181129105519.mklhnmx34yjucb22@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=800
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290095
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Smatch complains that there is an off by one if the allocation fails in:

	DMABuffer = atari_stram_alloc(BUFFER_SIZE+512, "ataflop");

In that situation, "i" would be point to one element beyond the end of
the unit[] array.

There is a second bug because the error handling calls
blk_mq_free_tag_set(&unit[i].tag_set); regardless of whether
"disk->queue" is NULL or non-NULL.  So if blk_mq_init_sq_queue() fails,
then that means unit[i].tag_set->tags is NULL and it leads to an Oops.

It's easiest to call put_disk() before the goto to clean up the partial
iteration.  Then the earlier unit[] elements are fully allocated so we
can remove the checks whether "disk->queue" is NULL and the code is
simpler.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---

I hope the Atari floppy disk users are appropriately grateful for all
the love and effort we put into their software...

 drivers/block/ataflop.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index f88b4c26d422..313064b1005c 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1982,6 +1982,7 @@ static int __init atari_floppy_init (void)
 							   &ataflop_mq_ops, 2,
 							   BLK_MQ_F_SHOULD_MERGE);
 		if (IS_ERR(unit[i].disk->queue)) {
+			put_disk(unit[i].disk);
 			ret = PTR_ERR(unit[i].disk->queue);
 			unit[i].disk->queue = NULL;
 			goto err;
@@ -2033,18 +2034,13 @@ static int __init atari_floppy_init (void)
 	return 0;
 
 err:
-	do {
+	while (--i >= 0) {
 		struct gendisk *disk = unit[i].disk;
 
-		if (disk) {
-			if (disk->queue) {
-				blk_cleanup_queue(disk->queue);
-				disk->queue = NULL;
-			}
-			blk_mq_free_tag_set(&unit[i].tag_set);
-			put_disk(unit[i].disk);
-		}
-	} while (i--);
+		blk_cleanup_queue(disk->queue);
+		blk_mq_free_tag_set(&unit[i].tag_set);
+		put_disk(unit[i].disk);
+	}
 
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
 	return ret;
-- 
2.11.0

