Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBB1C10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 08:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4812084B
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 08:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n5VK7Sxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfDJIMz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:12:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45638 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfDJIMy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 04:12:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3A7xYBm155821;
        Wed, 10 Apr 2019 08:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=XJt9awfshyR0ES4vWlYX9i+zRuKgKZ/46mjVI3pl3TM=;
 b=n5VK7SxrhPVVBJkM+bGVhzQkwknQgAE93+Dk3ORzsQ6vXL6uxsa7UNcXYjXW96IgOqir
 2a7tImP45L/ePTxTqrHipk/vmUIw2ue/QC1As8T3MdJzlfVTrvuGsCXE06IH0XQ46KGN
 fzc8dO9ODs1TxZuDNu+jrxCSrzgK8mL9THRJvV/LrDdTOQI2z/6SZMYF3l7Qt+qT/ny0
 XfV/kR3eNvKSrG+RyJO+mt/cJPS8eowK6aXtjU2HOKDPMqBu7xpIen0GMxmJM3rjbmuF
 NVl48wr9hOrAEtSV8/6wM6qaigDXk8TY3LQXlhGFzGOBux1xcuvyg6corGYVWgKBQcmg Sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2rpkht1j70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 08:12:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3A8CTQd193883;
        Wed, 10 Apr 2019 08:12:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2rph7t2nqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 08:12:44 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3A8CgfM012572;
        Wed, 10 Apr 2019 08:12:43 GMT
Received: from kadam (/197.157.0.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Apr 2019 01:12:42 -0700
Date:   Wed, 10 Apr 2019 11:12:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        kernel-janitors@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Greg Edwards <gedwards@ddn.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3] dm zoned: Silence a static checker warning
Message-ID: <20190410081231.GA31089@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB58160DF520B305A4328FC438E72E0@BYAPR04MB5816.namprd04.prod.outlook.com>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904100059
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904100059
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

My static checker complains about this line from dmz_get_zoned_device()

	aligned_capacity = dev->capacity & ~(blk_queue_zone_sectors(q) - 1);

The problem is that "aligned_capacity" and "dev->capacity" are sector_t
type (which is a u64 under most configs) but blk_queue_zone_sectors(q)
returns a u32 so the higher 32 bits in aligned_capacity are cleared to
zero.  This patch adds a cast to address the issue.

Fixes: 114e025968b5 ("dm zoned: ignore last smaller runt zone")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: The v1 patch declared blk_queue_zone_sectors() as sector_t but the
    v2 cast added a cast to u64.
v3: Cast it to sector_t instead

 drivers/md/dm-zoned-target.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index 8865c1709e16..51d029bbb740 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -643,7 +643,8 @@ static int dmz_get_zoned_device(struct dm_target *ti, char *path)
 
 	q = bdev_get_queue(dev->bdev);
 	dev->capacity = i_size_read(dev->bdev->bd_inode) >> SECTOR_SHIFT;
-	aligned_capacity = dev->capacity & ~(blk_queue_zone_sectors(q) - 1);
+	aligned_capacity = dev->capacity &
+				~((sector_t)blk_queue_zone_sectors(q) - 1);
 	if (ti->begin ||
 	    ((ti->len != dev->capacity) && (ti->len != aligned_capacity))) {
 		ti->error = "Partial mapping not supported";
-- 
2.17.1
