Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289747;
	b=44cCb8TU5lEOR6sk7wYkPyg+G1DU9mlwHWlQpfrD9Mo1Eh6Jk5GIQ8GcqdOZl8QJ/KaI
	 kxJwql+G3ifIZ3pRNvJRqikLF9EhpnxBwb7ezxUhshMPkVgrQ4hO6jXMz/gchYCFnqO12
	 4qGjVbo6wW/S0Fh0DI+aIXEyutRVCfyJ5IIhu6qso2TThivESk/C2DU/Zz3Gt3UyF/se6
	 NILJWU2PeoiPsVJqf7DRETab6Hf41rYTPVUt9RDJ2rdH1dSSpzKrGWFFbJEh21SXJBeJv
	 BM0gvYy31/mLiMWJlgjzIAPesPBLGm3wqTcjMbgWPdazi4c35mD3h5WlpSEkEtcmdDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mw+D+bJ+3Noc/aZs++CvNqR5iNHaaWdAu9wnY20WtvY=;
	b=LAJVWvvVXvi61qazT3YrmyyhTL2toJKAK+qCDagi4JaOzMA7hRFfLK2VUwW6L5q+oCIt
	 4gte6v91jQ6hWOc2NBMB066ziPGtjscm/8JMTWAO4S7Qb1ileIE+VpuxzpoWO7Svv+8mH
	 EphWUXd+bD1mhBbmA/PTiy8jnO2hARhRZU2I+5dL1LS816ZakrlT35jHVuPOz8rNh/uy2
	 naE3XAr1yeg9ybQkpgWeSneCqKr83PmaMsXnHpvZy9vjIUt31H1+vaU5gtLSd3aKc09yZ
	 wF4dbiQmK9PXfBSYWKtLBFuKBnRJDeWEJ2w48dTQyN2t+RorFpYLmmJ/SgQzmtGIGWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KFU83Kpc;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB1E60A2625
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 05:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEB1E60A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KFU83Kpc
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b8ecfa886bso742348b3a.0
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 21:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794289746; x=1794894546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mw+D+bJ+3Noc/aZs++CvNqR5iNHaaWdAu9wnY20WtvY=;
        b=KFU83Kpc0iJ8WkYn5i1oIurqszwzvl+btKAQE/lifusXqac4vu5FHzr/tO39ON79O3
         f8VdJ/IPYAIPXVxFa1m2gMubstFs445BMqK00DdyJE0kQR5OTybQ8qabuiYcw26hserq
         L1V38PA9xvsTUuDQ3phOPH85Xh7+zNlYBuSAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794289746; x=1794894546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mw+D+bJ+3Noc/aZs++CvNqR5iNHaaWdAu9wnY20WtvY=;
        b=uaR4sFjBmt801gX1jJ1aEoWuG58RF+nWgZShhFUO5r4MxUNr/CqRGalf81fEhra8A5
         P0u52pEsID6R9Cne7lrmXm77lCSspfQERkmkkl2Y59PnNTuq3lwZcUuPAoigQnMxGs+E
         T1kaDPMx5mDIBFM/pIi+X3hx4bEJXKt+W9hsERd4NVdKkZHTPff4Gjh7Ov4V/dcsDSRB
         uehAGDa+gkMFRSF08/dgX3d05BQGmSVhYlz6fpqLpUpYdVXiF48IHK98b3x4wQCEgkO2
         Mu446S+B+U7Qmls0QRYBmcZtltQEBtxYhF0g4kThzVIxKF2WMd0pvX/0ZGjK+VlXcSTW
         AVLQ==
X-Forwarded-Encrypted: i=1; AL+hErFp9MciQdwJ+GKfPKex2Z7zCSP7AT2aVH1BzJXk4gzH80P2VPh6zxe0Ha94caf/EHAi93P2nTWt7ZIQhQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8B/bc92PG6UhpaL6XB08Yif9du/if7OsV1IXCa25/pGUnwU4JK
	gBM4lqTvLdYKJblKWQ0SIM4n+CfNVU89HaAKLMvsOZxeWgIgbSkibooSbWglFqm29A==
X-Gm-Gg: AYBFou3KFkOqrVSFOnogennyLFaUvf0AxaHNRhnHSxhmtd/fymzVXk8yHdlte7rRoxR
	VnvqFwpgvJiAEHvUjvrt06goUdkUG1kLWq8bl/W5ZMCsjyJ3w7dhFkzBewnA63R/v2BO1tTSyuM
	BiYJbsqKHUsgY8wh4rdBlwreLscTHS5J5BjlsfeKcFZc6r1kxyeqQ4snNuZsg0P2ZaoBaZd1G0F
	ANaK6FMY4/LDdPcCdP75eGRlnwTx6Pg4QL5ciq+6kfZQMQj71otCZqH1YwIfZPvvRuYwWb37PEr
	S07xZbQ5peuKQSOFWA8VlyNX2S5vrGYqQ2SoYpanfsKZ/Gzt0QA5UUzPOvrnwVHDsG1RUPPW6pn
	ZrssB+qwZBhjhrM8ibnujNwesqiv3zRSnqkdG4XhvjFbiBrNMAaYqGmbKVTwctru5GwrlTBr5d9
	z3VuPYTCtbonT7j03frJav75pKRJ65NJL+f/cIsoreiO64INFH/t3Zsz7wgzxkIpBHIJxuf1E0f
	JsHIyadUWmOGpti7HV4s1jjQdJLSknO9uaITX5gtIhzU6qgC268Wx5FfJRow7KWmQhacX6mhbfY
	txjywrtncizL24HWX8wiEJRDksQFNfYVY5LYqGfq0mBAzzAXOl+tEk1C542TkPtaiXwkt2bzBJ/
	DQ0wtbiJeb4NRT228Wg==
X-Received: by 2002:a05:6a20:7d9f:b0:3e2:8c65:b229 with SMTP id adf61e73a8af0-3f172725e87mr1467840637.11.1794289746035;
        Mon, 09 Nov 2026 21:49:06 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d67e53asm444634a12.5.2026.11.09.21.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 21:49:05 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 07/11] zswap: do not free the entry if its pool is NULL
Date: Tue, 10 Nov 2026 14:48:12 +0900
Message-ID: <20261110054836.1515030-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261110054836.1515030-1-senozhatsky@chromium.org>
References: <20261110054836.1515030-1-senozhatsky@chromium.org>
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

zswap_entry_free() warns if the entry has no pool (which should never
happen), skips zs_free() and then frees the entry.  A subsequent patch
embeds zsmalloc handle into zswap_entry, so zsmalloc object will point
to the entry, and we cannot free the entry while the object is still
there.

Bail out early and leak the entry, its cgroup charge and stats instead.

Suggested-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zswap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 1160bd34e289..dc0400d7e1a3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -787,10 +787,11 @@ static void zswap_entry_free(struct zswap_entry *entry)
 	struct zswap_pool *pool = zswap_entry_pool(entry);
 
 	zswap_lru_del(entry);
-	if (!WARN_ON_ONCE(!pool)) {
-		zs_free(pool->zs_pool, entry->handle);
-		zswap_pool_put(pool);
-	}
+	if (WARN_ON_ONCE(!pool))
+		return;
+
+	zs_free(pool->zs_pool, entry->handle);
+	zswap_pool_put(pool);
 	if (entry->objcg) {
 		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
 		obj_cgroup_put(entry->objcg);
-- 
2.56.0.506.g506a7eabc5-goog

