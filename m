Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712412;
	b=LXjfYQmL9rnqbkTtKCHYLQSyMOaBjN5n51+UzRULxI5H8PCyj8AbWLiMjr7AOfeue87l
	 MjidO/hMZT+cbum9w8cO+AdC2+9NwN70Qs10sYOki9uG2dqMb8kuRXyB4l2U2CDdA3BWl
	 dO+CVShWPdK186llgR7U9gwui76F0vt74mE02nEXf21ZdtZidRjjtVDQKk7dKy8lO0x1b
	 kv8F49VhwNQWpj4+C5snf3jqkZEP3e6mwSeq5v+sX4jCW7A6gdVJlAyT3rZWqUkDR6p5v
	 gV35yNB7pKP18d0hVrONE4JE77CcbY3me8kSQ+p/G5lTDpLXlt9kCXHoQTDuKa+zTZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712412;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=neAJm+++/l6tyg3K8NaZC7Ajvxa0Tbh1k+Yccrfz724=;
	b=cY1yQsBydRlPKrXiOB4pL/8DDes7oep/eg/b1UFusklAeHSdeMEwKrjuy2OXP+ukYlLh
	 XGcNbfhaJSSxakmjctJaBSLO7xXbhNZ+kRpv4b6ivtjpcoyeVyX4lzH0ldfH2wadGFUz9
	 ja6OC0jjA2PnnbywmkX9alA7rY6EpFzz2/Rn1tEEN8fBBlOdFRRGqhpyfS2GyNESFuzrl
	 5kEGWWfcjfZy9VZDKpsJcCsB3qnOg5X7cnRvftZgjT7ifr3hNa7GrJBiW1yqhqItWbEDP
	 aKjkz0aGTniLrjpCWfk2llnzDVdhS38o6XOAhaEDYWhVxbgMd2NWiEPbUpxraTFjptQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rNmEiXYC;
	arc=none smtp.remote-ip=95.215.58.48
Received: from mta1.migadu.com (out-48.mta1.migadu.com [95.215.58.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FDC6083604
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 13:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48FDC6083604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rNmEiXYC
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FXDoKt976her4x+XK+WEDsT02owvJSSv0gOgMbNHAU8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793712409; v=1; x=1794317209;
 b=rNmEiXYCu+gXVc/Kr5H3WYVsPb/F9q0xO3fy/vG/E//rp8Z3zKUaAyY8c9CzPxc1V/fmzYUv
 gT06ZGqnjVK9Y52JeH37E26jVoPEVleDMFzeaTVsuZJJXXLxSjoJ/oc/+8VnJzcds5zKeG0c7vg
 LIWxcOVAKtdTb3uBUGnYrigw=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bd64c7a0f7c80953;
	Tue, 03 Nov 2026 13:26:49 +0000
X-Mizu-Trace-ID: bd64c7a0f7c80953
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	josef@toxicopanda.com,
	axboe@kernel.dk,
	alexei.starovoitov@gmail.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	linux-kselftest@vger.kernel.org,
	cui.tao@linux.dev,
	cuitao@kylinos.cn,
	ameryhung@gmail.com
Subject: [RFC PATCH v12 2/4] blk-iocost: add iocost_ioc_tick tracepoint for per-period device summary
Date: Tue,  3 Nov 2026 21:26:11 +0800
Message-ID: <20261103132613.1952975-3-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103132613.1952975-1-cui.tao@linux.dev>
References: <20261103132613.1952975-1-cui.tao@linux.dev>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

Add iocost_ioc_tick, emitted once per period from ioc_timer_fn() with
the overall controller state: period_us, vrate, busy_level, active iocg
count and usage percentage.  busy_level, cur_period, nr_active and
usage_us_sum are complete at the emission point.  usage is wall time
over wall time, summed over iocgs, and is not capped at 100.  vrate and
period_us reflect the current controller state, which an io.cost.qos
write may have changed mid-period.

The event fires every period the controller is running, including
steady states, plus one final tick before the controller goes idle, so
the transition to dormancy is directly visible.  The active iocg count
is only gathered when the tracepoint is enabled.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 MAINTAINERS                   |  1 +
 block/blk-iocost.c            | 17 ++++++++++++++
 include/trace/events/iocost.h | 43 +++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aaf2825ac945..25cd7cd4f17b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6832,6 +6832,7 @@ F:	block/blk-iocost.c
 F:	block/blk-iolatency.c
 F:	block/blk-throttle.c
 F:	include/linux/blk-cgroup.h
+F:	include/trace/events/iocost.h
 
 CONTROL GROUP - CPUSET
 M:	Waiman Long <longman@redhat.com>
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 22a3d7eb3b1b..8b624654992b 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2349,6 +2349,7 @@ static void ioc_timer_fn(struct timer_list *timer)
 	struct ioc_now now;
 	LIST_HEAD(surpluses);
 	int nr_debtors, nr_shortages = 0, nr_lagging = 0;
+	int nr_active = 0;
 	u64 usage_us_sum = 0;
 	u32 ppm_rthr;
 	u32 ppm_wthr;
@@ -2546,6 +2547,22 @@ static void ioc_timer_fn(struct timer_list *timer)
 
 	ioc->busy_level = clamp(ioc->busy_level, -1000, 1000);
 
+	/*
+	 * busy_level, cur_period, nr_active and usage_us_sum are complete
+	 * here. usage is wall time over wall time, summed over iocgs, and
+	 * is not capped at 100. vrate and period_us reflect the current
+	 * controller state, which an io.cost.qos write may have changed
+	 * mid-period. Emit before the refresh and the period transition.
+	 */
+	if (trace_iocost_ioc_tick_enabled()) {
+		struct ioc_gq *active_iocg;
+
+		list_for_each_entry(active_iocg, &ioc->active_iocgs,
+				     active_list)
+			nr_active++;
+	}
+	trace_iocost_ioc_tick(ioc, &now, nr_active, usage_us_sum);
+
 	ioc_adjust_base_vrate(ioc, rq_wait_pct, nr_lagging, nr_shortages,
 			      prev_busy_level, missed_ppm);
 
diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
index eb711343ce4f..fb0be4b8c629 100644
--- a/include/trace/events/iocost.h
+++ b/include/trace/events/iocost.h
@@ -181,6 +181,49 @@ TRACE_EVENT(iocost_ioc_vrate_adj,
 	)
 );
 
+/*
+ * Periodic per-device summary, emitted once per period before the vrate
+ * adjustment and the period transition in ioc_timer_fn(). Unlike the
+ * state-change events above, this fires every period the controller is
+ * running, including steady states, and carries the overall controller state
+ * so basic monitoring doesn't require drgn.
+ */
+TRACE_EVENT(iocost_ioc_tick,
+
+	TP_PROTO(struct ioc *ioc, const struct ioc_now *now,
+		 int nr_active, u64 usage_us_sum),
+
+	TP_ARGS(ioc, now, nr_active, usage_us_sum),
+
+	TP_STRUCT__entry (
+		__string(devname, ioc_name(ioc))
+		__field(u64, cur_period)
+		__field(u32, period_us)
+		__field(u64, vrate)
+		__field(int, busy_level)
+		__field(int, nr_active)
+		__field(u32, usage_pct)
+	),
+
+	TP_fast_assign(
+		__assign_str(devname);
+		__entry->cur_period = atomic64_read(&ioc->cur_period);
+		__entry->period_us = ioc->period_us;
+		__entry->vrate = ioc->vtime_base_rate;
+		__entry->busy_level = ioc->busy_level;
+		__entry->nr_active = nr_active;
+		__entry->usage_pct = now->now > ioc->period_at ?
+			div64_u64(usage_us_sum * 100,
+				  now->now - ioc->period_at) : 0;
+	),
+
+	TP_printk("[%s] period=%llu:%uus vrate=%llu busy=%d active=%d usage=%u%%",
+		__get_str(devname), __entry->cur_period, __entry->period_us,
+		__entry->vrate, __entry->busy_level, __entry->nr_active,
+		__entry->usage_pct
+	)
+);
+
 TRACE_EVENT(iocost_iocg_forgive_debt,
 
 	TP_PROTO(struct ioc_gq *iocg, const char *path, struct ioc_now *now,
-- 
2.53.0

