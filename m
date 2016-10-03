Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43059 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752444AbcJCVUg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Oct 2016 17:20:36 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.17/8.16.0.17) with SMTP id u93LGccw024557
        for <linux-block@vger.kernel.org>; Mon, 3 Oct 2016 14:20:35 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 25t8tbef3a-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2016 14:20:35 -0700
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.223.100.99) with ESMTP id
 37a5b54c89af11e693a824be05956610-83ffaa50 for <linux-block@vger.kernel.org>;
        Mon, 03 Oct 2016 14:20:32 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <axboe@fb.com>, <Kernel-team@fb.com>, <tj@kernel.org>,
        <jmoyer@redhat.com>, <vgoyal@redhat.com>
Subject: [PATCH v3 06/11] blk-throttle: make sure expire time isn't too big
Date: Mon, 3 Oct 2016 14:20:25 -0700
Message-ID: <bdd738c6104cee359264cdc3ed4bf10d668c476a.1475529372.git.shli@fb.com>
In-Reply-To: <cover.1475529372.git.shli@fb.com>
References: <cover.1475529372.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

cgroup could be throttled to a limit but when all cgroups cross high
limit, queue enters a higher state and so the group should be throttled
to a higher limit. It's possible the cgroup is sleeping because of
throttle and other cgroups don't dispatch IO any more. In this case,
nobody can trigger current downgrade/upgrade logic. To fix this issue,
we could either set up a timer to wakeup the cgroup if other cgroups are
idle or make sure this cgroup doesn't sleep too long. Setting up a timer
means we must change the timer very frequently. This patch chooses the
latter. Making cgroup sleep time not too big wouldn't change cgroup
bps/iops, but could make it wakeup more frequently, which isn't a big
issue because throtl_slice * 8 is already quite big.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 41b75a3..778de0b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -589,6 +589,9 @@ static void throtl_dequeue_tg(struct throtl_grp *tg)
 static void throtl_schedule_pending_timer(struct throtl_service_queue *sq,
 					  unsigned long expires)
 {
+	unsigned long max_expire = jiffies + 8 * throtl_slice;
+	if (time_after(expires, max_expire))
+		expires = max_expire;
 	mod_timer(&sq->pending_timer, expires);
 	throtl_log(sq, "schedule timer. delay=%lu jiffies=%lu",
 		   expires - jiffies, jiffies);
-- 
2.9.3

