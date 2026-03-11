Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697F63B9D93
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218615; cv=none; b=qc8U4TpiLGM54Pf0+xkQZtPmlxvkGQeA7TMGI1XHnEaGZfmQYhWcGSNQK3TryTWqq9SPQro/RKqKB+7IxhP4iWeXeggVK+1PDmTZGyHGZTCYT7G0HAngJJ69SkKm5tZYUIvUcEdFp+MuEnZeNbaTvpYwLXoPqhFh4jjwnNgY6Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218615; c=relaxed/simple;
	bh=wNYksE5WPX3rlYFfd/ky90h+hP0Lo/p41dqbB811urU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRAk7pRRxBb8hbCa0szlsn75KessvnXTjwLBkTnzVcKkFwIzjTZbmly6Q/JNys+GAvNbfnlSNo+umkdL6W6krJaXbn31Idvd2GMm2nA8v6oDXV9fwc34B7AMf0lhMk+0ZtWa0HSNChRqqsD3iGeIg7/O9nQCmY+ZsnEjjlKu/j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S/T822Ds; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S/T822Ds"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae4d919f9bso63408665ad.0
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 01:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773218614; x=1773823414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQanG0Ycz+PQWOQ4QkKwzQajwhv3TLjpxD3lKKqkSl8=;
        b=S/T822DsMybpY0AMRgkVBRZWNcHICOGpeP2d/MfyGhHQUTpBxoswanxB2IFxrIKpPu
         ddIcP3I2b13uAQ0N0mM9K+c/C950ZjiAdBVn9XKEGYqUXkK4AVcqrzcAja9IRNp6RDfS
         2jebtYQMSD348mPSemLrfQW+WDDW0F391qQAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773218614; x=1773823414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YQanG0Ycz+PQWOQ4QkKwzQajwhv3TLjpxD3lKKqkSl8=;
        b=TxaxOIh7CeOYS/JsLVtUv1mZJ/lmVnGz2KwoxMaQSVwsCZeQlAWZPvxapXaKE+KMBV
         9pPi8Cda8oYr1v+VUlx2Xyg9Y91IkScP19CaltEmv5scJzSWr9sIm11iReo2y3PNRJ1/
         9I7h13XoNavRLJf+6Cyjo0OD7/+9w916Voe1iBv3Emqh0jmmdJQZ5BqYekuXDhkcU6Du
         x6ICcIkguIk9LlsCJ/nq2ctAKxzt2/l9AqckId7D3IGGoM8qr/7DuR+RFw1wigVhc6Si
         UK4Zl1ySpaikDtOc+nfNnxHtbnUJjyOQ/zb+mW9q+PFUK/SU3G1WHBGTNu7c4+k1tnpv
         nnQw==
X-Forwarded-Encrypted: i=1; AJvYcCVXC/waE/621UNQD6ART5BZDFJBUulmhaEtRO+gdiZ+AfUU98aLf6prmWvi1e42efN0fpxAJsgJRjn9uA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWPkIZIaEQBYHUzUOsh7+sNTbmRhNtovs3h9uTvbq1hrTyRMT
	aEMMRenua6r+NRToB+JLF9Y04D5oEgXspAGsiJwBpGlaXGwDTg3tudEcNoykEN+k8w==
X-Gm-Gg: ATEYQzwLBrQ+WaEPJaqq1FIpd6Y5rfsKWJEUwUZse7gCsfK442dKTG5hdA1Z3EgLLI6
	8HDbFZIg05b4ulzqANU0zh7Voz0eDHbJEJ2ItpnrBTpFNupJmR0E7bZsH6HSRSsw99liFTAe2iU
	dNp6DrrGJ122rGW8SM+UJ8ubELlWk3UxJxzvWMoImOiqoIViwSF4IV62qh1peBZVfmIYgYClg6o
	kgXqevr3xL1Wl+ju41v/a2jeOGrS8sDRIncLeEsxTziY6EXIYyntIJJDOoHqRTMyxT475RMvdyO
	QL7CpHZqvGpxxYsyjVsofoU/8vSBk07PP9qUIihBIru6JMuQj31QhSX9F/Htpn/UYYh6ow1wBiG
	Oavt1BC8L5Cno56xSGuDzgmPFmli23jj9zrjqp3/xrRCawfgKDfLyD8XmmsmeMtUhifXDTxYQ5H
	nu1O5SlsBG4A9RRFxtwOinT1d4OKUXpKhX/Kpznvi5F4LskP5eGQPNK2tUfgCCFbX91T7so3R6T
	HLXfmXiBlvL1YVi8AcTXo4W
X-Received: by 2002:a17:902:f651:b0:2aa:e6fa:2f6c with SMTP id d9443c01a7336-2aeae7d8961mr18404595ad.24.1773218613744;
        Wed, 11 Mar 2026 01:43:33 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:93a4:8281:fe98:426a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae261077sm16062035ad.40.2026.03.11.01.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:43:33 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v2 2/6] zram: do not autocorrect bad recompression parameters
Date: Wed, 11 Mar 2026 17:42:45 +0900
Message-ID: <20260311084312.1766036-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260311084312.1766036-1-senozhatsky@chromium.org>
References: <20260311084312.1766036-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not silently autocorrect bad recompression priority
parameter value and just error out.

Suggested-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index db862179cf59..add3291ff27f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2528,19 +2528,16 @@ static ssize_t recompress_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t len)
 {
+	u32 prio = ZRAM_SECONDARY_COMP, prio_max = ZRAM_MAX_COMPS;
 	struct zram *zram = dev_to_zram(dev);
 	char *args, *param, *val, *algo = NULL;
 	u64 num_recomp_pages = ULLONG_MAX;
 	struct zram_pp_ctl *ctl = NULL;
 	struct zram_pp_slot *pps;
 	u32 mode = 0, threshold = 0;
-	u32 prio, prio_max;
 	struct page *page = NULL;
 	ssize_t ret;
 
-	prio = ZRAM_SECONDARY_COMP;
-	prio_max = zram->num_active_comps;
-
 	args = skip_spaces(buf);
 	while (*args) {
 		args = next_arg(args, &param, &val);
@@ -2590,10 +2587,7 @@ static ssize_t recompress_store(struct device *dev,
 			if (ret)
 				return ret;
 
-			if (prio == ZRAM_PRIMARY_COMP)
-				prio = ZRAM_SECONDARY_COMP;
-
-			prio_max = prio + 1;
+			prio_max = min(prio + 1, ZRAM_MAX_COMPS);
 			continue;
 		}
 	}
@@ -2613,7 +2607,7 @@ static ssize_t recompress_store(struct device *dev,
 				continue;
 
 			if (!strcmp(zram->comp_algs[prio], algo)) {
-				prio_max = prio + 1;
+				prio_max = min(prio + 1, ZRAM_MAX_COMPS);
 				found = true;
 				break;
 			}
@@ -2631,6 +2625,11 @@ static ssize_t recompress_store(struct device *dev,
 		goto out;
 	}
 
+	if (prio < ZRAM_SECONDARY_COMP || prio >= ZRAM_MAX_COMPS) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	page = alloc_page(GFP_KERNEL);
 	if (!page) {
 		ret = -ENOMEM;
-- 
2.53.0.473.g4a7958ca14-goog

