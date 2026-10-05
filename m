Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id F3EE7476074;
	Mon,  5 Oct 2026 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196929; cv=none; b=C7odAGyv2qULHIHzrYGuo5yWvHv1LXZarM4iGlI9ReDaBz1YITbnBCKqHsx8v/nUqOZMtKYSPYvKuKTuOcaFJxbf/wlCzMM/c3sdcaTMMRE3zRiqFCWWvScL4jEXZif29E948nEW60POipCcKKoH7GVT1RNa95nEnoCxkQPYYc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196929; c=relaxed/simple;
	bh=cFRXjCyCKLwgZ9Ciphpk4T6X3+FfggMoNBULj+b9Uzg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r6E1JWDLv9DkVqitgmD53OAIeAJjVO6Zw3h4F0PU01kz1KLX6Q+If7S+Xr+t4eUp40C/ggmLhDRMlWUNQgmp6l2zisBY7HWRD4wUBGMX7bS2940WhgP1gFv+0GjfckB82sK0StYk/n+Pflz5yMVGsy+JupJAeoO4NOPivc1U5fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=XNUGYZ5c; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="XNUGYZ5c"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Yu Kuai <yukuai@fygo.io>, Jens Axboe <axboe@kernel.dk>, Damien Le Moal
	<damien.lemoal@opensource.wdc.com>, Davide Zini <davidezini2@gmail.com>,
	Paolo Valente <paolo.valente@linaro.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] block, bfq: initialize active lists for all actuators
Date: Mon, 5 Oct 2026 18:41:42 +0800
Message-ID: <20261005104142.1871-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc9.internal.baidu.com (172.31.3.19) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1791196913;
	bh=u72lnYnxiPTqf4Tu0gVWfJ2mqBuag2BucdLy2h9aGgs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=XNUGYZ5c4s9yecgKKJYSqVxoULitCSQy0pPHIk2x/2Y/6KJURw0ZdMPaL4rEhpXt6
	 gbFdSydN2G6AFTf3hHg6tB1Hui4ZWVkz0/ZgFJO4f8uNJBqjujLuqI+UijGCoNjOCj
	 YCH3COM5/KzsWSL6gO9qAwRh35/owchXoJLr7epSp2QU6bz8r/uFDpBNtrsh013iaO
	 DWjoPufvLs24eXWVsFijX2sLXcykv0BlqikVv234gHpN0AT91ORLe6hy+3Kx+kke72
	 jQ6MPTEh2EEasbUJt6LQtVeTwesMq/wu5lWUztNT/qsosv5uutWfa4p3WXVPfuoUZT
	 b5XzhhhbfQMgA==

From: Li RongQing <lirongqing@baidu.com>

Commit 2d31c684a053 ("block, bfq: inject I/O to underutilized
actuators") extended bfqd->active_list from a single list_head to an
array indexed by actuator, but bfq_init_queue() still only initialized
the first two entries:

        INIT_LIST_HEAD(&bfqd->active_list[0]);
        INIT_LIST_HEAD(&bfqd->active_list[1]);

For devices with more than two independent access ranges, the remaining
list heads stay zeroed by kzalloc() and are never set up as empty lists.
When BFQ later adds a bfq_queue to one of those lists, list_add() writes
through head->next, which is NULL, corrupting the list or crashing the
kernel.

Initialize every actuator's active list using bfqd->num_actuators,
which is already set up earlier in bfq_init_queue().

Fixes: 2d31c684a053 ("block, bfq: inject I/O to underutilized actuators")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 block/bfq-iosched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0f75301..b21ddba 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7273,8 +7273,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
 	bfqd->num_groups_with_pending_reqs = 0;
 #endif
 
-	INIT_LIST_HEAD(&bfqd->active_list[0]);
-	INIT_LIST_HEAD(&bfqd->active_list[1]);
+	for (i = 0; i < bfqd->num_actuators; i++)
+		INIT_LIST_HEAD(&bfqd->active_list[i]);
 	INIT_LIST_HEAD(&bfqd->idle_list);
 	INIT_HLIST_HEAD(&bfqd->burst_list);
 
-- 
2.9.4

