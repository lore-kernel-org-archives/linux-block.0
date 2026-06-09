Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D156B383333
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987384; cv=none; b=QUYU5ydmeEk+4PIEgNM6C3SInL76c0elMj3cDaq5+hSYVH5MFJ5J5E3qeOJ/e0gCU7HU4oCdJy4Bl0yhaAfHPO/NaIIJCpluezTkTrWh97TsOsIQ/bCJoiiCXsBKIdE/SzZG3wb/2kWPfYWmFPUhIPelkuGIPdnWvsqmlvAWQDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987384; c=relaxed/simple;
	bh=ixUARLrsrzQUXfFOGl3Ttbl7wP5kUnmPB27ATBDfMwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DajEoSnZ+c9abkGQydhIV746TC9BAUww0hgjAimrKkf5L2KTWc+ZavipBlKKKFWr2py5QPL9V/TW464BU6MXZA5dr1Dlg7PCbsQ7+9qRMR1YV5SkkSTU5bHkbQuJsicpuWaumtNSrPSOXaZ025WMcFuUapNXncJl4pwFm6nUvt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uf7zi2A8; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uf7zi2A8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780987378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aY/Q2Y4YJZOouDOZHMnVH0A77nfCK6zvU7h1qy64BMY=;
	b=Uf7zi2A8S1Vt216no9vzZ3Kbmiu5WNcJlAjtZ2+I6gLXdoyBsFLfGuy4jDTTeA3xO1+pln
	Ds87oWHmnpQTX0CVJXI1T2pOOcEbz3YgF0qLAuuBFcwrnzZevA48QTk2qsWUyaePK41llH
	LokoxYxt8pU9/doCU/rEpYO3EWSrNiI=
From: Kaitao Cheng <kaitao.cheng@linux.dev>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Eddie James <eajames@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Waiman Long <longman@redhat.com>,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Kaitao Cheng <kaitao.cheng@linux.dev>,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH v2 14/14] list: Cache cursors in entry iterators
Date: Tue,  9 Jun 2026 14:41:22 +0800
Message-ID: <20260609064122.95825-2-kaitao.cheng@linux.dev>
In-Reply-To: <20260609064122.95825-1-kaitao.cheng@linux.dev>
References: <20260609061347.93688-1-kaitao.cheng@linux.dev>
 <20260609064122.95825-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kaitao Cheng <chengkaitao@kylinos.cn>

The non-safe list_for_each_entry() family advances by deriving the next
element from the current cursor in the loop step. If the loop body
unlinks the current entry, the step can no longer rely on the current
entry's list pointers.

Callers can use the _safe variants today, but those interfaces require a
temporary cursor to be declared outside the macro. That is necessary when
the caller actually needs the temporary cursor, but it looks redundant
and awkward when the cursor is only there to satisfy the macro and is
never otherwise used.

Add private next and previous cursors for the common entry iterators and
use unique internal names so callers keep the same interface. This lets
the loop step use a cursor captured before the body runs, while callers
that need to alter traversal state can still open-code the walk.

The safe variants remain useful when the caller needs access to the
temporary cursor or has stronger mutation requirements. Update their
comments to steer users toward the simpler iterators when that temporary
cursor is not needed.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 include/linux/list.h | 46 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 09d979976b3b..9df84a56a789 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -809,6 +809,29 @@ static inline size_t list_count_nodes(struct list_head *head)
 #define list_entry_is_head(pos, head, member)				\
 	list_is_head(&pos->member, (head))
 
+#define __list_for_each_entry(pos, next, head, member)			\
+	for (typeof(pos) next = list_next_entry(pos =			\
+		list_first_entry(head, typeof(*pos), member), member);	\
+	     !list_entry_is_head(pos, head, member);			\
+	     pos = next, next = list_next_entry(next, member))
+
+#define __list_for_each_entry_reverse(pos, prev, head, member)		\
+	for (typeof(pos) prev = list_prev_entry(pos =			\
+		list_last_entry(head, typeof(*pos), member), member);	\
+	     !list_entry_is_head(pos, head, member);			\
+	     pos = prev, prev = list_prev_entry(prev, member))
+
+#define __list_for_each_entry_continue(pos, next, head, member)		\
+	for (typeof(pos) next = list_next_entry(pos =			\
+		list_next_entry(pos, member), member);			\
+	     !list_entry_is_head(pos, head, member);			\
+	     pos = next, next = list_next_entry(next, member))
+
+#define __list_for_each_entry_from(pos, next, head, member)		\
+	for (typeof(pos) next = list_next_entry(pos, member);		\
+	     !list_entry_is_head(pos, head, member);			\
+	     pos = next, next = list_next_entry(next, member))
+
 /**
  * list_for_each_entry	-	iterate over list of given type
  * @pos:	the type * to use as a loop cursor.
@@ -816,9 +839,7 @@ static inline size_t list_count_nodes(struct list_head *head)
  * @member:	the name of the list_head within the struct.
  */
 #define list_for_each_entry(pos, head, member)				\
-	for (pos = list_first_entry(head, typeof(*pos), member);	\
-	     !list_entry_is_head(pos, head, member);			\
-	     pos = list_next_entry(pos, member))
+	__list_for_each_entry(pos, __UNIQUE_ID(next), head, member)
 
 /**
  * list_for_each_entry_reverse - iterate backwards over list of given type.
@@ -827,9 +848,7 @@ static inline size_t list_count_nodes(struct list_head *head)
  * @member:	the name of the list_head within the struct.
  */
 #define list_for_each_entry_reverse(pos, head, member)			\
-	for (pos = list_last_entry(head, typeof(*pos), member);		\
-	     !list_entry_is_head(pos, head, member); 			\
-	     pos = list_prev_entry(pos, member))
+	__list_for_each_entry_reverse(pos, __UNIQUE_ID(prev), head, member)
 
 /**
  * list_prepare_entry - prepare a pos entry for use in list_for_each_entry_continue()
@@ -852,9 +871,7 @@ static inline size_t list_count_nodes(struct list_head *head)
  * the current position.
  */
 #define list_for_each_entry_continue(pos, head, member) 		\
-	for (pos = list_next_entry(pos, member);			\
-	     !list_entry_is_head(pos, head, member);			\
-	     pos = list_next_entry(pos, member))
+	__list_for_each_entry_continue(pos, __UNIQUE_ID(next), head, member)
 
 /**
  * list_for_each_entry_continue_reverse - iterate backwards from the given point
@@ -879,8 +896,7 @@ static inline size_t list_count_nodes(struct list_head *head)
  * Iterate over list of given type, continuing from current position.
  */
 #define list_for_each_entry_from(pos, head, member) 			\
-	for (; !list_entry_is_head(pos, head, member);			\
-	     pos = list_next_entry(pos, member))
+	__list_for_each_entry_from(pos, __UNIQUE_ID(next), head, member)
 
 /**
  * list_for_each_entry_from_reverse - iterate backwards over list of given type
@@ -901,6 +917,8 @@ static inline size_t list_count_nodes(struct list_head *head)
  * @n:		another type * to use as temporary storage
  * @head:	the head for your list.
  * @member:	the name of the list_head within the struct.
+ *
+ * Prefer list_for_each_entry() unless the temporary cursor is needed.
  */
 #define list_for_each_entry_safe(pos, n, head, member)			\
 	for (pos = list_first_entry(head, typeof(*pos), member),	\
@@ -917,6 +935,8 @@ static inline size_t list_count_nodes(struct list_head *head)
  *
  * Iterate over list of given type, continuing after current point,
  * safe against removal of list entry.
+ *
+ * Prefer list_for_each_entry_continue() unless the temporary cursor is needed.
  */
 #define list_for_each_entry_safe_continue(pos, n, head, member) 		\
 	for (pos = list_next_entry(pos, member), 				\
@@ -933,6 +953,8 @@ static inline size_t list_count_nodes(struct list_head *head)
  *
  * Iterate over list of given type from current point, safe against
  * removal of list entry.
+ *
+ * Prefer list_for_each_entry_from() unless the temporary cursor is needed.
  */
 #define list_for_each_entry_safe_from(pos, n, head, member) 			\
 	for (n = list_next_entry(pos, member);					\
@@ -948,6 +970,8 @@ static inline size_t list_count_nodes(struct list_head *head)
  *
  * Iterate backwards over list of given type, safe against removal
  * of list entry.
+ *
+ * Prefer list_for_each_entry_reverse() unless the temporary cursor is needed.
  */
 #define list_for_each_entry_safe_reverse(pos, n, head, member)		\
 	for (pos = list_last_entry(head, typeof(*pos), member),		\
-- 
2.43.0

