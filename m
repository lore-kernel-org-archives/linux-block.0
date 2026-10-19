Received: from outbound.baidu.com (mx15.baidu.com [111.202.115.100])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 7A922476CCE
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 05:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792386724; cv=none; b=GsDnGyWF961qSSl9RW2iXVSudMVahnmug3WuNmhF44IfB38peixtX2fW256dWlj4skB243XFTGlxbp1aMRreP8pj/si0oO4wIAU+L36eQ9ol802TJppXET9geFTuYR0NYgQXIA7TgjqcrRwTDMewjSxR20CO5ubY7QqjhRY5XS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792386724; c=relaxed/simple;
	bh=cEXt/JVgCypoBAjgiUK9Rqg7EM2h0mxGxHa9WwFHetE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r1ztasnQlE0Oz3Mm2eG7o+/wQDlQFwh9J2A/KZWQQhZySe7KkOW3r8qDTU2BI1rOXPrlMkJZpMu8jGG/ceA15zPrU9KY17HQDL0jJH85W0CjDYWlx57jDLyR1sseXogExzeXWOFS0nWCog010dFTslbsDaTK1Om5BOtdQoWQC00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=i0K5jHjd; arc=none smtp.client-ip=111.202.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="i0K5jHjd"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Yu Kuai <yukuai@fygo.io>, Jens Axboe <axboe@kernel.dk>, Damien Le Moal
	<damien.lemoal@opensource.wdc.com>, Davide Zini <davidezini2@gmail.com>,
	Paolo Valente <paolo.valente@linaro.org>, <linux-block@vger.kernel.org>,
	<roy.qing.li@gmail.com>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH RESEND] block, bfq: initialize active lists for all actuators
Date: Mon, 19 Oct 2026 13:11:37 +0800
Message-ID: <20261019051137.1715-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc7.internal.baidu.com (172.31.3.17) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1792386707;
	bh=LSPs1e4RgjY4qHd6VVfGSdzLF5S5bK/qHLLD0cKdy1Y=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=i0K5jHjd+f/twAZCEGhMWUFYfL2M7WU+xxz6qNlCR5SJh5G6QMHHE8pd6wKhI8AkR
	 wqoREcHZBjV5V9G8fcNc6wmeNohCFaZ/urDcV9uBVp2Q/ZwSrNyhmdkWoxxq0JDIb4
	 p4175B4yoGtnk011owRPkE3AInEWLGpy5YVIeqaIf3Lvpj8hijnUCKCTdBsJYEkyWu
	 CGB21IWB0ILVPaq/DHIuwgECbUT/r1ebF2mvSfe+PuelhuKF7tuj+DrleH3kQtAMF7
	 y/fuqEhtjfpCa8Baq3G/hWyKzv+BRTgDkNl4JvTTH/9vwSN5vs6n5x/76PktJRClec
	 IS2fhbZ/h7M6A==

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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Yu Kuai <yukuai@fygo.io>
---
v1: https://patchwork.kernel.org/project/linux-block/patch/20261005104142.1871-1-lirongqing@baidu.com/

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

