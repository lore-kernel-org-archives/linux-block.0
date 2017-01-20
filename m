Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:1301 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751740AbdATLTH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2017 06:19:07 -0500
From: Hou Tao <houtao1@huawei.com>
To: <dm-devel@redhat.com>, <linux-block@vger.kernel.org>
CC: <agk@redhat.com>, <snitzer@redhat.com>, <ejt@redhat.com>,
        <vgoyal@redhat.com>
Subject: [PATCH RFC 2/4] dm thin: parse "keep_bio_blkcg" from userspace tools
Date: Fri, 20 Jan 2017 19:15:50 +0800
Message-ID: <1484910952-29820-3-git-send-email-houtao1@huawei.com>
In-Reply-To: <1484910952-29820-1-git-send-email-houtao1@huawei.com>
References: <1484910952-29820-1-git-send-email-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

keep_bio_blkcg feature is off by default, and it can
be turned on by using "keep_bio_blkcg" argument.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 drivers/md/dm-thin.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 8178ee8..57d6202 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -2824,6 +2824,7 @@ static void pool_features_init(struct pool_features *pf)
 	pf->discard_enabled = true;
 	pf->discard_passdown = true;
 	pf->error_if_no_space = false;
+	pf->keep_bio_blkcg = false;
 }
 
 static void __pool_destroy(struct pool *pool)
@@ -3053,7 +3054,7 @@ static int parse_pool_features(struct dm_arg_set *as, struct pool_features *pf,
 	const char *arg_name;
 
 	static struct dm_arg _args[] = {
-		{0, 4, "Invalid number of pool feature arguments"},
+		{0, 5, "Invalid number of pool feature arguments"},
 	};
 
 	/*
@@ -3085,6 +3086,9 @@ static int parse_pool_features(struct dm_arg_set *as, struct pool_features *pf,
 		else if (!strcasecmp(arg_name, "error_if_no_space"))
 			pf->error_if_no_space = true;
 
+		else if (!strcasecmp(arg_name, "keep_bio_blkcg"))
+			pf->keep_bio_blkcg = true;
+
 		else {
 			ti->error = "Unrecognised pool feature requested";
 			r = -EINVAL;
-- 
2.5.0

