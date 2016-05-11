Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52732 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753094AbcEKARE (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 20:17:04 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u4B0Gvbs018072
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 17:16:59 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
	by mx0a-00082601.pphosted.com with ESMTP id 22usuar1v4-6
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 17:16:59 -0700
Received: from facebook.com (2401:db00:11:d0a2:face:0:39:0)	by
 mx-out.facebook.com (10.212.236.89) with ESMTP	id
 a426851c170d11e6a00f0002c95209d8-9c4f7c50 for <linux-block@vger.kernel.org>;
	Tue, 10 May 2016 17:16:43 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tj@kernel.org>, <vgoyal@redhat.com>, <axboe@fb.com>,
	<jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH 09/10] blk-throttle: make sure expire time isn't too big
Date: Tue, 10 May 2016 17:16:39 -0700
Message-ID: <40b42ff504ad8f54251ca4b8c088f217410aa791.1462923578.git.shli@fb.com>
In-Reply-To: <cover.1462923578.git.shli@fb.com>
References: <cover.1462923578.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

cgroup could be throttled to a limit but when other cgroups are idle,
queue enters a higher state and so the group should be throttled to a
higher limit. It's possible the cgroup is sleeping because of throttle
and other cgroups don't dispatch IO any more. In this case, nobody can
trigger current downgrade/upgrade logic. To fix this issue, we could
either set up a timer to wakeup the cgroup if other cgroups are idle or
make sure this cgroup doesn't sleep too long. Setting up a timer means
we must change the timer very frequently. This patch chooses the latter.
Making cgroup sleep time not too big wouldn't change cgroup bps/iops,
but could make it wakeup more frequently, which isn't a big issue
because cg_check_time * 8 is already quite big.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 0aed049..a5f3435 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -632,6 +632,9 @@ static void throtl_dequeue_tg(struct throtl_grp *tg)
 static void throtl_schedule_pending_timer(struct throtl_service_queue *sq,
 					  unsigned long expires)
 {
+	unsigned long max_expire = jiffies + 8 * cg_check_time;
+	if (time_after(expires, max_expire))
+		expires = max_expire;
 	mod_timer(&sq->pending_timer, expires);
 	throtl_log(sq, "schedule timer. delay=%lu jiffies=%lu",
 		   expires - jiffies, jiffies);
-- 
2.8.0.rc2

