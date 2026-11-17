Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.253
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884242;
	b=bHixEC//xzXmXZZcpCsHQg56wBEeWYEazXU99QksC3ZFc1OmtC+shgXxDZ1FQ4TGGIyQ
	 A613pfPEcg8k6IPnvt1gTyG/sOiu87VXcnIQfXp63IRBJLFWUiY1W2rkYIXwgIDxykVU0
	 EtrwV02KCiMB76ijOUNT296EN2YML7EyN7N96IJzRgqkWec4Ue8fL+GJb6KZnakXfUef/
	 6wjMyTzyXEEZFJ7FWR/RDSCvzSK26QNdgkNY+A+M5C00aN65j5cZDFBOp8faoHpIWcmuT
	 WNhKBlXbfbtnIxoMGUhyi/+tjEgg1enKIhfvkpsjzbuHRlCkpsUiWlElK6lRAbHSkHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884242;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=kUTY7GX5GD30WhGQ2btit16Qsi8UiYXaz7H10J36jhE=;
	b=XSbr8TuAdWjBlH9E51BuGQW1xgAgjcxGySRQSOB+s4maNo28FLtaAm/rKTWQZ5ObbZrY
	 Estjr+1OkEbyEbe6Nle0NPpLCOnjxpc9JZO2qBSwbKdG4R41UCOZEbkLRdpfVC1B6xoQy
	 AHEi/essUnuvN0TzsCJOYrqnjH50xx4lREhe5c0AcS+AFc/d6M5RiIjlc4s6d166ytgjZ
	 VQFOaPzJ2r6W7yQm51XprYYAEgwCFCMKa9p8l5dPYm0GdZXq/sSuqHepwQ4wYhx6GAwEE
	 TGfO28dVDMK7I4sqvRrHmXS0kzn0V5Evu4Rle0d6evBKa6V210d93PKe+tNFkOPirbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="k/2+dkv2";
	arc=none smtp.remote-ip=91.218.175.253
Received: from mta0.migadu.com (out-253.mta0.migadu.com [91.218.175.253])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2825C606A323
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 02:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2825C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=k/2+dkv2
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zdObEdJq/dgDB4uKt1JYTcwfGpRezzn/B6J5+MId4cI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794884240; v=1; x=1795489040;
 b=k/2+dkv2W9Kzyf7TaA81L1xSzwbYoE5Q0ESe5jDsf/lCvXkua7hXnAoLj/7zqcu7GdHBMtxl
 JY7O5coJPexTF9CD/3HDZ9gx3McpEDMGzIQEdfTW5lp8W10bW3jUYwQY90Hu6DNwJqZiDCjO9XL
 xBUzqfmqShIgrbNaTu3Gsugc=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 90ca01a9700af2a5;
	Tue, 17 Nov 2026 02:57:20 +0000
X-Mizu-Trace-ID: 90ca01a9700af2a5
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Mon, 16 Nov 2026 21:56:55 -0500
Subject: [PATCH v3 2/2] block: return early when the elevator doesn't
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
Message-Id: <20261116-bug-block-elevator-unchanged-v3-2-cb4dda2dadf4@linux.dev>
References: <20261116-bug-block-elevator-unchanged-v3-0-cb4dda2dadf4@linux.dev>
In-Reply-To: <20261116-bug-block-elevator-unchanged-v3-0-cb4dda2dadf4@linux.dev>
To: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>, 
 Ming Lei <tom.leiming@gmail.com>, Nilay Shroff <nilay@linux.ibm.com>, 
 Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>, Christoph Hellwig <hch@lst.de>
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

Fixes: af2814149883e ("block: freeze the queue in queue_attr_store")
Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

