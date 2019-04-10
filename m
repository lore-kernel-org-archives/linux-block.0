Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E5DC10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 06:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38392083E
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 06:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="14wvgXJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfDJGKd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:10:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49222 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfDJGKd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 02:10:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3A69C3o064006;
        Wed, 10 Apr 2019 06:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=D7mYeA31WvSmotVSpH30vRe0Ao+9fhuM3kpPMMNcwKE=;
 b=14wvgXJj9p9XnDqYeOxf1oz/NYCPsGgp1J8B70S4LW4Rcp/rSKAK/Od3bfJNWytIiYQf
 GWGZBh2IEJTySgb8V7mHOdBg53IHZtPYAu8Ny5HviaglS5BifMi/mucQnXHo7I2gLx3E
 6j7SJzx8fUxiD3M7SeTLme8Rex+iJP5RPJk2P+8r9KjgQ07CBzerG0NkrLZl7b0sCJcG
 3glAV20P2ApJGmsr5hoNUbN3ScAKtjJd9+8Z7rD+TS7iWhjvVuwDd+vsEutIiOAorwt4
 AGxN7MKJIGG0rfC7dCYYcf504kLvuOzJ76x109d8gcZHGEjVYpXxKhUWbiSeAazgXy4s zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2rpkht10p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 06:10:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3A69eRw090079;
        Wed, 10 Apr 2019 06:10:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2rpytc218h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 06:10:20 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3A6AHGQ029454;
        Wed, 10 Apr 2019 06:10:18 GMT
Received: from kadam (/197.157.0.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Apr 2019 23:10:16 -0700
Date:   Wed, 10 Apr 2019 09:10:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Greg Edwards <gedwards@ddn.com>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] block: make blk_queue_zone_sectors() return sector_t type
Message-ID: <20190410061006.GA18813@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904100045
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904100045
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

My static checker complains about this line from dmz_get_zoned_device()

	aligned_capacity = dev->capacity & ~(blk_queue_zone_sectors(q) - 1);

The problem is that "aligned_capacity" and "dev->capacity" are sector_t
type (which is a u64) but blk_queue_zone_sectors(q) returns a u32 so the
higher 32 bits in aligned_capacity are always cleared to zero.

Declaring blk_queue_zone_sectors() as a sector_t addresses this warning
and it feels intuitive based on the function name.  I updated
bdev_zone_sectors() as well just to be consistent.

Fixes: 114e025968b5 ("dm zoned: ignore last smaller runt zone")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Please review this one extra carefully.  I'm not positive it's correct.

 include/linux/blkdev.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4b85dc066264..1785a7f506be 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -670,7 +670,7 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
 	}
 }
 
-static inline unsigned int blk_queue_zone_sectors(struct request_queue *q)
+static inline sector_t blk_queue_zone_sectors(struct request_queue *q)
 {
 	return blk_queue_is_zoned(q) ? q->limits.chunk_sectors : 0;
 }
@@ -1419,7 +1419,7 @@ static inline bool bdev_is_zoned(struct block_device *bdev)
 	return false;
 }
 
-static inline unsigned int bdev_zone_sectors(struct block_device *bdev)
+static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 
-- 
2.17.1

