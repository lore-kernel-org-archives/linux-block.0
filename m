Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A780DC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 08:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AC9218EA
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 08:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="pyVgXo0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfB0IFv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:05:51 -0500
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:32789 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726791AbfB0IFv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 03:05:51 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id 62EEE20736;
        Wed, 27 Feb 2019 11:05:45 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id K6C4IRiGWa-5jVKc9Io;
        Wed, 27 Feb 2019 11:05:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1551254745; bh=uje9cOqkSF4MsWapz7kByCQVbrgZbvE1xFNEZzdfCkI=;
        h=Message-ID:Date:To:From:Subject;
        b=pyVgXo0DU98oiz0JlDZoUXviuXZj0POotBfGERsT1RoBY0FTaF77OABMy/qmtoOkB
         TrB8qiNy77jU1XAAEq6OX2qtyDBUIgzisHLWcg5k2B04/bJ5aVtYvba8nNIxn9/yxo
         WlU7/gHEdZvvufGnQHSu25nkGmo2175udw1UTU9I=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8865:6f76:e76b:3fab])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id JjJAERalmz-5i94qtrV;
        Wed, 27 Feb 2019 11:05:45 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] blk-throttle: verify format of bandwidth limit and detect
 overflows
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org
Date:   Wed, 27 Feb 2019 11:05:44 +0300
Message-ID: <155125474480.292717.11530762471075713387.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Unlike to memory cgroup blkio throttler does not support value suffixes.

It silently ignores everything after last digit. For example this command
will set rate limit 1 byte per second rather than 1 megabyte per second:

# echo "7:0 1M" > blkio.throttle.read_bps_device
# cat blkio.throttle.read_bps_device
7:0 1

Cgroup2 interface has the same flaw:

# echo "7:0 rbps=1M" > io.max
# cat io.max
7:0 rbps=1 wbps=max riops=max wiops=max

Also sscanf does not care much about overflows.

This patch uses modern function kstrtou64 for parsing.
It rejects trailing garbage and detects integer overflows.

Also this patch handles iops limit overflows for cgroup-v1 in the same as
cgroup-v2: limits >= UINT_MAX becomes unlimited.

Fixes: 2ee867dcfa2e ("blkcg: implement interface for the unified hierarchy")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/blk-throttle.c |   40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 1b97a73d2fb1..ce00060b3a48 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1433,8 +1433,10 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 	if (ret)
 		return ret;
 
-	ret = -EINVAL;
-	if (sscanf(ctx.body, "%llu", &v) != 1)
+	/* remove trailing spaces, kstrto* are strict about them */
+	ctx.body = strim(ctx.body);
+	ret = kstrtou64(ctx.body, 10, &v);
+	if (ret)
 		goto out_finish;
 	if (!v)
 		v = U64_MAX;
@@ -1444,7 +1446,8 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 	if (is_u64)
 		*(u64 *)((void *)tg + of_cft(of)->private) = v;
 	else
-		*(unsigned int *)((void *)tg + of_cft(of)->private) = v;
+		*(unsigned int *)((void *)tg + of_cft(of)->private) =
+							min_t(u64, v, UINT_MAX);
 
 	tg_conf_updated(tg, false);
 	ret = 0;
@@ -1609,23 +1612,25 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	idle_time = tg->idletime_threshold_conf;
 	latency_time = tg->latency_target_conf;
 	while (true) {
-		char tok[27];	/* wiops=18446744073709551616 */
-		char *p;
-		u64 val = U64_MAX;
-		int len;
-
-		if (sscanf(ctx.body, "%26s%n", tok, &len) != 1)
-			break;
-		if (tok[0] == '\0')
-			break;
-		ctx.body += len;
+		char tok[8];	/* "latency" */
+		char buf[21];	/* U64_MAX */
+		int end;
+		u64 val;
 
 		ret = -EINVAL;
-		p = tok;
-		strsep(&p, "=");
-		if (!p || (sscanf(p, "%llu", &val) != 1 && strcmp(p, "max")))
+		if (sscanf(ctx.body, "%7[^=]=%20s %n", tok, buf, &end) != 2)
 			goto out_finish;
 
+		/* skip this field and trailing spaces */
+		ctx.body += end;
+
+		ret = kstrtou64(buf, 10, &val);
+		if (ret) {
+			if (strcmp(buf, "max"))
+				goto out_finish;
+			val = U64_MAX;
+		}
+
 		ret = -ERANGE;
 		if (!val)
 			goto out_finish;
@@ -1645,6 +1650,9 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 			latency_time = val;
 		else
 			goto out_finish;
+
+		if (!*ctx.body)
+			break;
 	}
 
 	tg->bps_conf[READ][index] = v[0];

