Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D72937CD5C
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 06:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986480; cv=none; b=lYmbo7uN1h6gruLf0few0gSXvna2IC8AyGLtpJyTVjxOvZK3rUSTDW/jEgvUgPobjG/Shgfea98MYmYxiVDqBc7IGDwiauoWkhFCg6AZodBKWBf0BALWOEYo10nz0IPhDtiJMYOv29YUkILOJbe9AEfeDRdkmxN+hvhbcSkCmeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986480; c=relaxed/simple;
	bh=hwcvq5LadA4W4kWgR6utNp96c590z/YCSqK7XcKljno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSFBw8gP6UNjSXupBqxAPt/fotb/ncBeBBBrah1KttzIGj5IUN+P2pbmhwjOAnoGBs2A7/uc7am8gPaxHyLK6U6BgMMBl+LR8L3q1VeKFgUD8suUZmsu/iQpRtwOypyYjOWEeU0pOOR6SHHDNLxqy6AxpgP+FIH5YwxwuiukNW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nQkQ04Hx; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nQkQ04Hx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780986476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pVP90aZfoMU3nDWsWVHDnmxnGfHB/XcgdiFcpaREBAc=;
	b=nQkQ04Hx7MJOzmWhwtxPMaOrKg3/OyhY75/K8lNIYoyIka8WsaFwgxUMtN9Mm0pmMaudPz
	wyWVT2+Hedpjo6PWVVc+59wp0b7AsRtjuz6XrSyPbd3VaG/lB0q4BDKFXJ8GHwRDncPhrx
	rt1hq3RzreC8SzsEbAT653uUHfoFEaI=
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
Subject: [PATCH v2 07/14] spi: fsi: Open-code message transfer walk
Date: Tue,  9 Jun 2026 14:25:19 +0800
Message-ID: <20260609062526.94907-5-kaitao.cheng@linux.dev>
In-Reply-To: <20260609062526.94907-1-kaitao.cheng@linux.dev>
References: <20260609061347.93688-1-kaitao.cheng@linux.dev>
 <20260609062526.94907-1-kaitao.cheng@linux.dev>
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
before entering the loop body. fsi_spi_transfer_one_message() can combine
the current transfer with the following transfer and then advance the
cursor to that consumed entry.

Keep the transfer walk open-coded so the loop step observes that cursor
update and skips the consumed transfer. This preserves the existing
message sequencing semantics and prepares the code for the list iterator
update.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 drivers/spi/spi-fsi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index f6a75f0184c4..44999f00f5f6 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -434,7 +434,10 @@ static int fsi_spi_transfer_one_message(struct spi_controller *ctlr,
 	if (rc)
 		goto error;
 
-	list_for_each_entry(transfer, &mesg->transfers, transfer_list) {
+	for (transfer = list_first_entry(&mesg->transfers,
+					 typeof(*transfer), transfer_list);
+	     !list_entry_is_head(transfer, &mesg->transfers, transfer_list);
+	     transfer = list_next_entry(transfer, transfer_list)) {
 		struct fsi_spi_sequence seq;
 		struct spi_transfer *next = NULL;
 
-- 
2.43.0

