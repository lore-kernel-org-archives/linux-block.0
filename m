Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EA3C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 12:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0553220857
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 12:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DeG4vLfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfCRMTj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:19:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35878 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfCRMTi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 08:19:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2ICJFUB122337;
        Mon, 18 Mar 2019 12:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=3rpCUiaSB+U6fopAwDgIrcqIuKktISQzb4oCWRgSzu8=;
 b=DeG4vLfK1egQ9yGxfCLyHFdvXs0xULT5n+ROiVauM3TaVculSaYo6f/bnePmzIw1ZvRh
 k0LMaiCJNJKCUqxFFM6YwUdus01PLkV3bw5z5Xk9ahg2M+cxq+evAZ6p3GAppjpJNMV6
 fD9vVQUpuuB0CjzKB3gzNVEKZnrLYZJg5E/6BRzChIaSVRnRyYJAPqK+5vPc3EsygwaK
 8F7onUNw5OpU4XVLgIs4ZiAZBSBGG6IB6wshryBquCPsyOAGi0nFIzfEMsc3gdLrJqLX
 BT/+FMt0RWe07qEs75HYmYr199kZDpwGq+VF1oI/TRcD65qSnrq0DZERrjVbCcGC1tJ/ Jg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2r8rjue4yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 12:19:30 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2ICJO1J000436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 12:19:24 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2ICJNl7030671;
        Mon, 18 Mar 2019 12:19:23 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Mar 2019 05:19:23 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        penguin-kernel@i-love.sakura.ne.jp
Subject: [PATCH 1/1] loop: access lo_backing_file only when the loop device is Lo_bound
Date:   Mon, 18 Mar 2019 20:23:17 +0800
Message-Id: <1552911797-20455-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9198 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903180093
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 758a58d0bc67 ("loop: set GENHD_FL_NO_PART_SCAN after
blkdev_reread_part()") separates "lo->lo_backing_file = NULL" and
"lo->lo_state = Lo_unbound" into different critical regions protected by
loop_ctl_mutex.

However, there is below race that the NULL lo->lo_backing_file would be
accessed when the backend of a loop is another loop device, e.g., loop0's
backend is a file, while loop1's backend is loop0.

loop0's backend is file            loop1's backend is loop0

__loop_clr_fd()
  mutex_lock(&loop_ctl_mutex);
  lo->lo_backing_file = NULL; --> set to NULL
  mutex_unlock(&loop_ctl_mutex);
                                   loop_set_fd()
                                     mutex_lock_killable(&loop_ctl_mutex);
                                     loop_validate_file()
                                       f = l->lo_backing_file; --> NULL
                                         access if loop0 is not Lo_unbound
  mutex_lock(&loop_ctl_mutex);
  lo->lo_state = Lo_unbound;
  mutex_unlock(&loop_ctl_mutex);

lo->lo_backing_file should be accessed only when the loop device is
Lo_bound.

In fact, the problem has been introduced already in commit 7ccd0791d985
("loop: Push loop_ctl_mutex down into loop_clr_fd()") after which
loop_validate_file() could see devices in Lo_rundown state with which it
did not count. It was harmless at that point but still.

Fixes: 7ccd0791d985 ("loop: Push loop_ctl_mutex down into loop_clr_fd()")
Reported-by: syzbot+9bdc1adc1c55e7fe765b@syzkaller.appspotmail.com
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1e6edd5..bf1c61c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -656,7 +656,7 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 			return -EBADF;
 
 		l = f->f_mapping->host->i_bdev->bd_disk->private_data;
-		if (l->lo_state == Lo_unbound) {
+		if (l->lo_state != Lo_bound) {
 			return -EINVAL;
 		}
 		f = l->lo_backing_file;
-- 
2.7.4

