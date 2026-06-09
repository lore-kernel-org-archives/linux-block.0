Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8910D3D411A
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 06:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987360; cv=none; b=ZmqVqh2RP3VfF1m07L5s+IuhrdgMYunHtSyDehrZEesZgjAAPcj79DoWJUwbMpKhTcD8lzING449Xu5/ADISlLfMnm1hU60sNg1eWjdznGS4iQwwAZ7iMISnC2DCpZ1rluHcem4VsZKPZSfTZZL0a4hH/uOEJi3UKgBrF4oosm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987360; c=relaxed/simple;
	bh=tNgMvvM+CiASJY4sOEMxFckQKiwCHdQCqyU1fvL1LkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iI/w1pVLrMrpCmtf1Zf9G55H8sgk5+jC4pX91PC8Lp/Q9QvLrQGqgH4CJC03sw1B64YiCyL5gH4qkc6NhS0dZ/UAnkyWaFKoyamhUuraX9c+R6ebxjBPkDISTZO8IHvHyP/8DthEoCQnOmEyblYvIsuEsycoIE0lEi3drRbwbBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r9H+J3Ut; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r9H+J3Ut"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780987356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=okGbZnshQDiTOCCUcLiGWJ/vXeEA5Q7ST0C3mLZj8lI=;
	b=r9H+J3UthvdbJqCWseQmPy/6Gw04t2MD3O/3QZkG+FrfACMHjoHmAZhEA7T2/P7rXoTaRj
	flnwXmsam8NnpyHmx73y4wEmRAzWN+xVg1sMhEn7tyW9qKpEVePYA4xXwp0ikhd+ORVe1t
	m7DPL598qkuZ4CAlEebaO3UEKtTEsyk=
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
Subject: [PATCH v2 13/14] ASoC: dapm: Open-code widget invalidation walk
Date: Tue,  9 Jun 2026 14:41:21 +0800
Message-ID: <20260609064122.95825-1-kaitao.cheng@linux.dev>
In-Reply-To: <20260609061347.93688-1-kaitao.cheng@linux.dev>
References: <20260609061347.93688-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kaitao Cheng <chengkaitao@kylinos.cn>

A later change will make list_for_each_entry() cache the next element
before entering the loop body. dapm_widget_invalidate_paths() appends
newly reached widgets to the temporary work list while walking it.

Keep the work-list walk open-coded so the next widget is looked up after
new widgets have been appended. This preserves the existing invalidation
traversal semantics and prepares the code for the list iterator update.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 sound/soc/soc-dapm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d6192204e613..5bd921fca132 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -255,7 +255,9 @@ static __always_inline void dapm_widget_invalidate_paths(
 	list_add_tail(&w->work_list, &list);
 	w->endpoints[dir] = -1;
 
-	list_for_each_entry(w, &list, work_list) {
+	for (w = list_first_entry(&list, typeof(*w), work_list);
+	     !list_entry_is_head(w, &list, work_list);
+	     w = list_next_entry(w, work_list)) {
 		snd_soc_dapm_widget_for_each_path(w, dir, p) {
 			if (p->is_supply || !p->connect)
 				continue;
-- 
2.43.0

