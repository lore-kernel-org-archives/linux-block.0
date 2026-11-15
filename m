Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794707935;
	b=qPzk7xCFRTjEku7qur/O1fBVT1ztwLGBZBKz0Q3xwydULb1frHwa9N0HKkwEWyKCT1/Y
	 q+XGx4n26Stj/bMjRwFd5/zMlj/QyoN0srivSH+89UbALRQb06M20j1bcbx7cFjBrUi1V
	 IPVp7n7/7o7n75uTgK14fhzlR4Ceh9EqsnCtUl+KElvTWf17RgxMPyl4lVP4aHfwJ1PJm
	 ++7RIPlVzfXiMHbunMKUSfpktFGxU9Dw+yyUpRZlNUo3Xc4mL280SA9951CjgMxOQvH8/
	 526EQpJovU+NZH+zgzrVqbIz0ZWIo9xKsmb/kjfSFbwe5nd6TYjQydKBIxb2lEPvj/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707935;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=zSLlH1+8TI53KOdsrYzM7XU090UA1Rg7WZRybXevBK4=;
	b=bb0h1tUIYy2cRVP3Y0z71TcE9WP9Jxa7ijMZYwMotFHM0kIfDghSgqUWSD/0hsfX3pKA
	 w0DWn8r/e6pSHXqzKrA6fX1+emN2qUo/M2PKjHwyeKXJsvTcW78BDjWUXA//zdM7NTAj/
	 +U/QFwIjCNUpy2LQLAIbrINOIiHu5dhYmpu60171I0garUXrvCPQ9o+IZkInfEtRsNMnj
	 vtVyrvIC6Zv1KBc0yTc42+WZvgiqizaqsqytvm24DyH/apkX9C57uliePTbSLG2BkJ1Xf
	 jQKLmREI7zzJDJfmzaRkqImevj5L9+vEZEnwMp+Y4ujRj9WZr7dB3mrk8cnP1dr3Rfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="Vu4Tx/hl";
	arc=none smtp.remote-ip=91.218.175.84
Received: from mta0.migadu.com (out-84.mta0.migadu.com [91.218.175.84])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97400606A323
	for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 01:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97400606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Vu4Tx/hl
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=V11mplnHq/41XhU0lFUSCmu5zG7zdMxvYQPTtuBjbKo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794707932; v=1; x=1795312732;
 b=Vu4Tx/hlOuTV+09NsrY2AdKBw2OddFvWdybxGL5BpchcN93XjLYe0LV32uE2RW/xpcbS4etN
 mS12eyJeKrhy8ARsvzZHjOtwjF+87ccioE2U7Ec3uzzCPPLH4YQrHU2WZ5We0psUrUadRRSYeps
 YX1Zbi5mWvltCKs2qWvvCZPo=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1802f018b1e4911a;
	Sun, 15 Nov 2026 01:58:52 +0000
X-Mizu-Trace-ID: 1802f018b1e4911a
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Sat, 14 Nov 2026 20:58:33 -0500
Subject: [PATCH v2 2/2] block: return early when the elevator doesn't
 change
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-bug-block-elevator-unchanged-v2-2-5a1fe7d72fa0@linux.dev>
References: <20261114-bug-block-elevator-unchanged-v2-0-5a1fe7d72fa0@linux.dev>
In-Reply-To: <20261114-bug-block-elevator-unchanged-v2-0-5a1fe7d72fa0@linux.dev>
To: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>, 
 Ming Lei <tom.leiming@gmail.com>, Nilay Shroff <nilay@linux.ibm.com>, 
 Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0

Writing the scheduler a queue already uses to queue/scheduler used to
be a no-op. elevator_change() now only checks for an unchanged elevator
after freezing the queue, and doesn't treat "none" on a queue without
an elevator as unchanged at all, so that case also quiesces the queue
in elevator_switch() and resets nr_requests.

Every such write therefore drains in-flight I/O and waits for an RCU
grace period. udev rules and tuning tools that set the scheduler
unconditionally stall I/O on live disks each time they run.

Check under elevator_lock whether anything would change before
allocating scheduler resources and freezing the queue. The check can
race with another elevator change, which at worst leads to a redundant
switch, so keep the one done under the freeze as well.

Writing the current scheduler to queue/scheduler of a null_blk disk 20
times takes (median):

  operation                 before (ms)  after (ms)  change
  none -> none                     9.11        0.08    -99%
  mq-deadline -> mq-deadline       9.05        0.08    -99%

4k random reads at queue depth 1 for 10 seconds, while "none" is
written to queue/scheduler every 50 ms:

  metric             before  after  change
  IOPS               340562 390392    +15%
  max latency (us)    16302   1224    -92%

Fixes: b07a889e83355 ("block: move q->sysfs_lock and queue-freeze under show/store method")
Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 block/elevator.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/elevator.c b/block/elevator.c
index 9d9b2e84a1288..549cf51543a8b 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -654,10 +654,24 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 {
 	unsigned int memflags;
 	struct blk_mq_tag_set *set = q->tag_set;
+	bool unchanged;
 	int ret = 0;
 
 	lockdep_assert_held(&set->update_nr_hwq_lock);
 
+	/*
+	 * Skip freezing the queue if nothing would change. This can race with
+	 * another elevator change, which at worst leads to a redundant switch.
+	 */
+	mutex_lock(&q->elevator_lock);
+	if (q->elevator)
+		unchanged = elevator_match(q->elevator->type, ctx->name);
+	else
+		unchanged = !strncmp(ctx->name, "none", 4);
+	mutex_unlock(&q->elevator_lock);
+	if (unchanged)
+		return 0;
+
 	if (strncmp(ctx->name, "none", 4)) {
 		ret = blk_mq_alloc_sched_res(q, ctx->type, &ctx->res,
 				set->nr_hw_queues);

-- 
2.43.0

