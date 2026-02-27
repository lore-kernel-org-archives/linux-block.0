Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEE134A785
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210496; cv=none; b=tFMH41rAbnrFZbHMRiT48AEa+Ciq4EKy46HPl0ikvJjG1cGaT5ETho0K9eivOJwFeZhW0YN95PWsu7e3h0RJKWFmJ2HHU7JAAyCAgzC1VF1RNbT+YqsYa/msoG08Ft3dCrWw2kc2OBg9vU+8Gd0fK4imgZUbnl1NC2MHW0Q56/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210496; c=relaxed/simple;
	bh=RY/e80+/kZp0ndnWK8kJgTORmskriDz0+BRBasqpa+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=imlRmSRuCPk1EeVfpFsvX4p1Ck34qe5h9uPvaRct/1vdKd5cSPlJPW9eaMGjs2TqJbUp0GHjz3pCi8z8WKAFLC7Lc/83M7a2/11CuRD8NJF1ZHyN53Rdayisjha+ql6PvG8jyNeEizZY8Xm60DKMOzs9Ohtm+XsSW587UTV4yvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=PTddOnLl; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="PTddOnLl"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RGNFuu2653994
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 11:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=kqO9
	qkRdVrAKYYgOAexi6ZPIdSHNelQDaN7QKT4AcXo=; b=PTddOnLlQSm+yYDiHtdN
	PTkRtJtY1GOXc7dzRBrSEut2qC0a5yoxWHLbFwBCXJNaXWQjRik3Q30/YoJAORs/
	tV8lysYFLlp1xdJdiQog0twPAOTDGBbUlCSYutNFCvkbYLj9+omnS2s47xac/ZPl
	XIUMao1s3jA2dOW9R0xlfNEVE0HSAJByDZZ/L5oHGO3KC69V0CGvYvveqjr6lcvA
	4uwVfEUMmU6zq2INQ6mjKFGjJJki+hAmHF6H6YzB1Ha9UXW9n0Mz4fbFHHg1LOWi
	bdKXXfabnIMKvxUYun8J0pi6dcYMwSKfMa7rBzNLgu5oGRom3FpR819asMlkhhyj
	Jw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4cju9xq20q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 11:41:28 -0500 (EST)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5033b4d599eso235938531cf.2
        for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 08:41:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772210487; x=1772815287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kqO9qkRdVrAKYYgOAexi6ZPIdSHNelQDaN7QKT4AcXo=;
        b=LsHMQP/8jUG73wA8m1TO6cOpkKei2gLUuhZxZ7z5UWWCQdGAsmt0nT4nRzEiF2orZ6
         ow2z+qvwVMtFpthIcb66/OFjU9G8nU2NXkcR8xA+Q75+eiQLtTIqMoDXDuMmeUPFC5vj
         uaW2FnA1JMfDmz7A+bHfDcRuyy6TaolRFcoF75dJy/V5DTJA/xONS6SZ8jufnmr4MXWk
         Cn6oUwEqxiqwS3Fusqm2tVThXf7jJcxFrhBy/ppFxuvOh8Y/uCXEkQfCSk0YGCVQxJ5V
         OFlgzo/14EZD9kRC3f2TscPTbIVHMw/weg8OmivjaWyT2Fkm26ZtUqCqopEHLeT1w6F0
         HyUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUADFV//HVGfUNbvxVd1X57J+wy8lKfZrUpSSO1AjvQUrXpAyyenAhvBP8xw4PbrNXpC3/CKBj5szx5yQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQp4oVde1tX/4XJB846J7mdq65HTutkoCi9gKfPuRu7fz8Wv9y
	vsn0KJP54lA2INXVggt0mhHcaB6LxyS9skEre0LUMmVYhyiOW8o57PTuSYs5/5lafZ7ifTmdd/5
	c8NI9by3mWqGrecv9d3P2wcudPoVjIOfAgAIANml9ma9ZotumTJZzg5YJFy4B
X-Gm-Gg: ATEYQzxuR7BXnsk5klTMLyVcGAGgS+TQsTNqwvu+NDxPCN4UWNvC0BD5AaN634UPYhI
	N+ew53y8V4+QuqvPEooffMAAJSjHjR669qkZfH6Wz0Q0+8emDznSk93EDXPKA9n+jQ/Hdg2N5H3
	IBzL3wbF9dtKGLaCbXKdJwmjxm/p1NE3gay36SYCMc0mWWkUW2xJr/TRWxZMO5xdMRjjmSlWmfS
	KRtki5QxlE0rc/SPh15Ubey+5s+ydeOpkxSoKszTZDuYKmWaoNVaoBlSI6xmptbPfPpNNNOBGD4
	KdbLuTMUoWCW5GYnTxoNjwTa/EAn+c00aCQKdQPGwprLdXvALwWkSwlF+Tn/DDO12xpbVvoDQPw
	+2DkAbM+XFrKNpyN3YvuiBpj9uA0JwzjWz0qxHSlelbiYSkKQDuQ52lh6RzGDzIcXSAI=
X-Received: by 2002:ac8:584e:0:b0:506:1f48:9ffd with SMTP id d75a77b69052e-50752982c2cmr45010251cf.40.1772210487332;
        Fri, 27 Feb 2026 08:41:27 -0800 (PST)
X-Received: by 2002:ac8:584e:0:b0:506:1f48:9ffd with SMTP id d75a77b69052e-50752982c2cmr45009771cf.40.1772210486660;
        Fri, 27 Feb 2026 08:41:26 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c716caebsm46535886d6.15.2026.02.27.08.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 08:41:25 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 27 Feb 2026 11:41:07 -0500
Subject: [PATCH RFC v3 1/2] filemap: defer dropbehind invalidation from IRQ
 context
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-blk-dontcache-v3-1-cd309ccd5868@columbia.edu>
References: <20260227-blk-dontcache-v3-0-cd309ccd5868@columbia.edu>
In-Reply-To: <20260227-blk-dontcache-v3-0-cd309ccd5868@columbia.edu>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772210483; l=7573;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=RY/e80+/kZp0ndnWK8kJgTORmskriDz0+BRBasqpa+s=;
 b=5GcYGdmdWtXfKAIurXREVpzuab/QFgffaUCQqEN5lF8DAh34Uoemq2/kit/VagezIlDEV6Sb9
 UKFtKpmhpV5CPnT03p8sgafLGn7XkDEwTt1k4s69nfd83MAmaDzml1x
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=WZoBqkhX c=1 sm=1 tr=0 ts=69a1c938 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=-hUk4XeFNW921M1lpgYA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: TwmhuKae6c9tKCCxcscKdPRZ00mM18Al
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE0OCBTYWx0ZWRfXyRzcme8dIpR9
 3fZSzZ4OcZQ0IPS4EAUqvzWInFyTgZW9V8Ox9wpZPDeimG67mfLXYx2eo8RaE51wnzVxBQyHqBC
 Kld+1wYcPoIPl+LDngASETav6X5WMKENLaToZPjHFubh8cqCf9G+6K5nS7oWGhasX28Q10zEyCn
 ungn6P+mdYjnhi0uH/X1DNpnTMZlqow+uhlugS7ZONgdDURFDPqvlJv4zIdbRtK1woVK9mbWYRh
 4rXFwhqkj7rkc5CotX3eJUDG2Vb5XAD3bWFpoW3zTvj3XBWp0ytwIJdNGU5vqauchTaLHutx3/4
 GMAA5nXHJzzb9MoY9nSxSLW5Y6lZNsNI9lt85Q5y2pUT1zQzhanOma3vbqz3cQZJS6oIeE9gqxP
 61qrrzmpuvbkfLGGe/wnpfMzh7/2vbFJyy2SNz4ouGxUaaZb1P0Lcz0nrUuV69of1BF8+l/j5/1
 xVn1TTcmqnH9/AR6RXQ==
X-Proofpoint-GUID: TwmhuKae6c9tKCCxcscKdPRZ00mM18Al
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11714
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=10 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=10 spamscore=0 suspectscore=0 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270148

folio_end_dropbehind() is called from folio_end_writeback(), which can
run in IRQ context through buffer_head completion.

Previously, when folio_end_dropbehind() detected !in_task(), it skipped
the invalidation entirely. This meant that folios marked for dropbehind
via RWF_DONTCACHE would remain in the page cache after writeback when
completed from IRQ context, defeating the purpose of using it.

Fix this by adding folio_end_dropbehind_irq() which defers the
invalidation to a workqueue. The folio is added to a per-cpu folio_batch
protected by a local_lock, and a work item pinned to that CPU drains the
batch. folio_end_writeback() dispatches between the task and IRQ paths
based on in_task().

A CPU hotplug dead callback drains any remaining folios from the
departing CPU's batch to avoid leaking folio references.

This unblocks enabling RWF_DONTCACHE for block devices and other
buffer_head-based I/O.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/pagemap.h |   1 +
 mm/filemap.c            | 130 ++++++++++++++++++++++++++++++++++++++++++++----
 mm/page_alloc.c         |   1 +
 3 files changed, 123 insertions(+), 9 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ec442af3f886..ae0632cfdedd 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1260,6 +1260,7 @@ void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
 void folio_end_writeback_no_dropbehind(struct folio *folio);
 void folio_end_dropbehind(struct folio *folio);
+void dropbehind_drain_cpu(int cpu);
 void folio_wait_stable(struct folio *folio);
 void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn);
 void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb);
diff --git a/mm/filemap.c b/mm/filemap.c
index ebd75684cb0a..b223dca708df 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -49,6 +49,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sysctl.h>
 #include <linux/pgalloc.h>
+#include <linux/local_lock.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -1085,6 +1086,8 @@ static const struct ctl_table filemap_sysctl_table[] = {
 	}
 };
 
+static void __init dropbehind_init(void);
+
 void __init pagecache_init(void)
 {
 	int i;
@@ -1092,6 +1095,7 @@ void __init pagecache_init(void)
 	for (i = 0; i < PAGE_WAIT_TABLE_SIZE; i++)
 		init_waitqueue_head(&folio_wait_table[i]);
 
+	dropbehind_init();
 	page_writeback_init();
 	register_sysctl_init("vm", filemap_sysctl_table);
 }
@@ -1613,26 +1617,131 @@ static void filemap_end_dropbehind(struct folio *folio)
  * If folio was marked as dropbehind, then pages should be dropped when writeback
  * completes. Do that now. If we fail, it's likely because of a big folio -
  * just reset dropbehind for that case and latter completions should invalidate.
+ *
+ * When called from IRQ context (e.g. buffer_head completion), we cannot lock
+ * the folio and invalidate. Defer to a workqueue so that callers like
+ * end_buffer_async_write() that complete in IRQ context still get their folios
+ * pruned.
+ */
+struct dropbehind_batch {
+	local_lock_t lock_irq;
+	struct folio_batch fbatch;
+	struct work_struct work;
+};
+
+static DEFINE_PER_CPU(struct dropbehind_batch, dropbehind_batch) = {
+	.lock_irq = INIT_LOCAL_LOCK(lock_irq),
+};
+
+static void dropbehind_work_fn(struct work_struct *w)
+{
+	struct dropbehind_batch *db_batch;
+	struct folio_batch fbatch;
+
+again:
+	local_lock_irq(&dropbehind_batch.lock_irq);
+	db_batch = this_cpu_ptr(&dropbehind_batch);
+	fbatch = db_batch->fbatch;
+	folio_batch_reinit(&db_batch->fbatch);
+	local_unlock_irq(&dropbehind_batch.lock_irq);
+
+	for (int i = 0; i < folio_batch_count(&fbatch); i++) {
+		struct folio *folio = fbatch.folios[i];
+
+		if (folio_trylock(folio)) {
+			filemap_end_dropbehind(folio);
+			folio_unlock(folio);
+		}
+		folio_put(folio);
+	}
+
+	/* Drain folios that were added while we were processing. */
+	local_lock_irq(&dropbehind_batch.lock_irq);
+	if (folio_batch_count(&db_batch->fbatch)) {
+		local_unlock_irq(&dropbehind_batch.lock_irq);
+		goto again;
+	}
+	local_unlock_irq(&dropbehind_batch.lock_irq);
+}
+
+/*
+ * Drain a dead CPU's dropbehind batch. The CPU is already dead so no
+ * locking is needed.
+ */
+void dropbehind_drain_cpu(int cpu)
+{
+	struct dropbehind_batch *db_batch = per_cpu_ptr(&dropbehind_batch, cpu);
+	struct folio_batch *fbatch = &db_batch->fbatch;
+
+	for (int i = 0; i < folio_batch_count(fbatch); i++) {
+		struct folio *folio = fbatch->folios[i];
+
+		if (folio_trylock(folio)) {
+			filemap_end_dropbehind(folio);
+			folio_unlock(folio);
+		}
+		folio_put(folio);
+	}
+	folio_batch_reinit(fbatch);
+}
+
+static void __init dropbehind_init(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct dropbehind_batch *db_batch = per_cpu_ptr(&dropbehind_batch, cpu);
+
+		folio_batch_init(&db_batch->fbatch);
+		INIT_WORK(&db_batch->work, dropbehind_work_fn);
+	}
+}
+
+/*
+ * Must be called from task context. Use folio_end_dropbehind_irq() for
+ * IRQ context (e.g. buffer_head completion).
  */
 void folio_end_dropbehind(struct folio *folio)
 {
 	if (!folio_test_dropbehind(folio))
 		return;
 
-	/*
-	 * Hitting !in_task() should not happen off RWF_DONTCACHE writeback,
-	 * but can happen if normal writeback just happens to find dirty folios
-	 * that were created as part of uncached writeback, and that writeback
-	 * would otherwise not need non-IRQ handling. Just skip the
-	 * invalidation in that case.
-	 */
-	if (in_task() && folio_trylock(folio)) {
+	if (folio_trylock(folio)) {
 		filemap_end_dropbehind(folio);
 		folio_unlock(folio);
 	}
 }
 EXPORT_SYMBOL_GPL(folio_end_dropbehind);
 
+/*
+ * In IRQ context we cannot lock the folio or call into the invalidation
+ * path. Defer to a workqueue. This happens for buffer_head-based writeback
+ * which runs from bio IRQ context.
+ */
+static void folio_end_dropbehind_irq(struct folio *folio)
+{
+	struct dropbehind_batch *db_batch;
+	unsigned long flags;
+
+	if (!folio_test_dropbehind(folio))
+		return;
+
+	local_lock_irqsave(&dropbehind_batch.lock_irq, flags);
+	db_batch = this_cpu_ptr(&dropbehind_batch);
+
+	/* If there is no space in the folio_batch, skip the invalidation. */
+	if (!folio_batch_space(&db_batch->fbatch)) {
+		local_unlock_irqrestore(&dropbehind_batch.lock_irq, flags);
+		return;
+	}
+
+	folio_get(folio);
+	folio_batch_add(&db_batch->fbatch, folio);
+	local_unlock_irqrestore(&dropbehind_batch.lock_irq, flags);
+
+	schedule_work_on(smp_processor_id(), &db_batch->work);
+}
+
 /**
  * folio_end_writeback_no_dropbehind - End writeback against a folio.
  * @folio: The folio.
@@ -1685,7 +1794,10 @@ void folio_end_writeback(struct folio *folio)
 	 */
 	folio_get(folio);
 	folio_end_writeback_no_dropbehind(folio);
-	folio_end_dropbehind(folio);
+	if (in_task())
+		folio_end_dropbehind(folio);
+	else
+		folio_end_dropbehind_irq(folio);
 	folio_put(folio);
 }
 EXPORT_SYMBOL(folio_end_writeback);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cbf758e27aa2..8208223fd764 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6277,6 +6277,7 @@ static int page_alloc_cpu_dead(unsigned int cpu)
 	struct zone *zone;
 
 	lru_add_drain_cpu(cpu);
+	dropbehind_drain_cpu(cpu);
 	mlock_drain_remote(cpu);
 	drain_pages(cpu);
 

-- 
2.39.5

