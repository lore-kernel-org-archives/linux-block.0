Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED1A3E9F81;
	Wed,  4 Feb 2026 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770212938; cv=none; b=MIgt6G7n9ZInnrTHL0WvEZVUq2e82ObnXPVYsv+nTOKAe7XpF2fUKZHxk3wLeYsyAEVtXG/Q5toiFNrqIImZaVXu2X7+f/63oXjUW/TJonoflbS6di/5g6P+ck9buPYWlNgSjef58PQ34X0xe4VQJsixC2Z0GPEjuZb5NlG6KuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770212938; c=relaxed/simple;
	bh=yI1yoSsOchjOWEAHtf2popxAc8At7+pZlpyuxbns7p0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q7KDNJuEIVdijZIN2907rmDv6ys58i/VEbDoHAAZ6rrB1plMYqREW6nXzbSGd1jxtKfwD5QjE6sp4S20f+37TpdTH0iDrz2SLmDH2x3M2omPKwtGxGf2OSWc1JDuuxqFvCgFL5FoTLEfO6fdtvq4J21wlCiOCr16pT/V6YUPMK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbV6kZ+i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbV6kZ+i"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E336BC4CEF7;
	Wed,  4 Feb 2026 13:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770212937;
	bh=yI1yoSsOchjOWEAHtf2popxAc8At7+pZlpyuxbns7p0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RbV6kZ+ioHnttpsKJ0DrGQ7og9L4/KwT5U3pxWWYTm74ALcyc0WMd3uTjfhFmyxhe
	 /I00G61/LFLj7clm3zQnElaSoLWd7ELsEaZgqqtLaM7pmdKtLlwkwwInHk1C5ccHMm
	 wDx/dmBTjfm9CIv8CzemKaoULE3g/fYnRuBzYq4rvcAwuJBG5b7IiQ+lfnhInUTIzs
	 4+L/xAP/kESyfXCP8C9SI9YxsD+LltEYAl6bmXDpJPET4HKlZkUvWBwad0TY/CG0pT
	 uBMzqvzz6h1RUdUBLmh8QIohzYho9YP4AI2pH+S3ez26ilLjxxG/6jRkvhslFMg5eJ
	 fWlQwgrigVurQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6F8E83F0E;
	Wed,  4 Feb 2026 13:48:57 +0000 (UTC)
From: Jihan LIN via B4 Relay <devnull+linjh22s.gmail.com@kernel.org>
Date: Wed, 04 Feb 2026 13:48:51 +0000
Subject: [PATCH RFC 1/3] zram: Rename zcomp_strm_{init, free}()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-b4_zcomp_stream-v1-1-35c06ce1d332@gmail.com>
References: <20260204-b4_zcomp_stream-v1-0-35c06ce1d332@gmail.com>
In-Reply-To: <20260204-b4_zcomp_stream-v1-0-35c06ce1d332@gmail.com>
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Jihan LIN <linjh22s@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770212935; l=2361;
 i=linjh22s@gmail.com; s=linjh22s_machine; h=from:subject:message-id;
 bh=IFvoK5U+khkiAvwSnFIAQSJIRT0dcUrOwkW93SNRf6w=;
 b=PRv9qw5rfie6P+3wgDGa1Y91Sk+MwawKplgOLzT2zxS5CbI3eCVz/gR2pCSaq3p8C69gRoKHx
 bPeCX0RrFuJBRrmFtPfiOF+2E2LldwSB5WxN7ZXMx3Eh2i8nLEekB1v
X-Developer-Key: i=linjh22s@gmail.com; a=ed25519;
 pk=MnRQAVFy1t4tiGb8ce7ohJwrN2YFXd+dA7XmzR6GmUc=
X-Endpoint-Received: by B4 Relay for linjh22s@gmail.com/linjh22s_machine
 with auth_id=592
X-Original-From: Jihan LIN <linjh22s@gmail.com>
Reply-To: linjh22s@gmail.com

From: Jihan LIN <linjh22s@gmail.com>

Currently, zcomp uses a preemptive per-CPU stream model where streams
are allocated for each online CPUs and guarded by mutexes. The existing
names zcomp_strm_{init, free}() are too generic to explicitly indicate
they handle per-CPU streams.

Rename them to zcomp_strm_{init, free}_percpu(). This helps distinguish
them from future streams that may not be per-CPU based. No functional
changes are intended.

Signed-off-by: Jihan LIN <linjh22s@gmail.com>
---
 drivers/block/zram/zcomp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index b1bd1daa0060a5b437d947d504d9ee6b4a9ac152..1614340e81dd2bebb29373411c9d180446f78f4c 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -43,7 +43,7 @@ static const struct zcomp_ops *backends[] = {
 	NULL
 };
 
-static void zcomp_strm_free(struct zcomp *comp, struct zcomp_strm *zstrm)
+static void zcomp_strm_free_percpu(struct zcomp *comp, struct zcomp_strm *zstrm)
 {
 	comp->ops->destroy_ctx(&zstrm->ctx);
 	vfree(zstrm->local_copy);
@@ -51,7 +51,7 @@ static void zcomp_strm_free(struct zcomp *comp, struct zcomp_strm *zstrm)
 	zstrm->buffer = NULL;
 }
 
-static int zcomp_strm_init(struct zcomp *comp, struct zcomp_strm *zstrm)
+static int zcomp_strm_init_percpu(struct zcomp *comp, struct zcomp_strm *zstrm)
 {
 	int ret;
 
@@ -66,7 +66,7 @@ static int zcomp_strm_init(struct zcomp *comp, struct zcomp_strm *zstrm)
 	 */
 	zstrm->buffer = vzalloc(2 * PAGE_SIZE);
 	if (!zstrm->buffer || !zstrm->local_copy) {
-		zcomp_strm_free(comp, zstrm);
+		zcomp_strm_free_percpu(comp, zstrm);
 		return -ENOMEM;
 	}
 	return 0;
@@ -172,7 +172,7 @@ int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
 	struct zcomp_strm *zstrm = per_cpu_ptr(comp->stream, cpu);
 	int ret;
 
-	ret = zcomp_strm_init(comp, zstrm);
+	ret = zcomp_strm_init_percpu(comp, zstrm);
 	if (ret)
 		pr_err("Can't allocate a compression stream\n");
 	return ret;
@@ -184,7 +184,7 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node)
 	struct zcomp_strm *zstrm = per_cpu_ptr(comp->stream, cpu);
 
 	mutex_lock(&zstrm->lock);
-	zcomp_strm_free(comp, zstrm);
+	zcomp_strm_free_percpu(comp, zstrm);
 	mutex_unlock(&zstrm->lock);
 	return 0;
 }

-- 
2.51.0


