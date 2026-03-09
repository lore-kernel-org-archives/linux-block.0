Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8BA3A783A;
	Mon,  9 Mar 2026 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058987; cv=none; b=JC4lDk1iAnB9G3NBFwH/X//p43c/Uck75bEx5jELHgsxqUy4JI8iAwOJ4KG4fm4/UO4xJK6IqFUtMgqIJFPraVl98SFVkxd7uQm3l89wJ4DYG0D09xyxf0wJDsQCYP/3Zvq8gFxjObkD97UmzQXZ4FnXVsGPlxqvMWrrn687pRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058987; c=relaxed/simple;
	bh=71ESfdSg+vVssTEg35xko5ianl6haG2mwXQFB0fQSp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ljc9+VP+WhpgTzt0d7Uzyg1yoFKMgo3JXphr1AI+IRgs7cw7Ca6Is45l6ngy2O4/gLjZz9OszhK2vuTdrzgM303g2uRcOzisprdH8HJV7kIDD4+HI7qCyz7ttd6MEDws1rqp9LtCm1+mYSCZUJ0dNZE4UrAd+TIpOCe9VL9UX0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dl4blc3y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dl4blc3y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BE6CC2BC9E;
	Mon,  9 Mar 2026 12:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773058987;
	bh=71ESfdSg+vVssTEg35xko5ianl6haG2mwXQFB0fQSp4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Dl4blc3yxl/25n2L0iC+ggJiPV2jXjI7jJ0BczQpqHY4fJdMmzUG4/MsKpaN98u7I
	 F0WO7nB4lnJ2h+0Lw9iUD5vsOspONHcnfe6xvVCYfKn6W5fMgW9EHpMtzLUeCXFixC
	 HTrpyFEJPC8H2Dg2QjG2AZAhVFDSY6JZVv8E0vgEJxZmAQtD4V+sdKxanxH7T78lgG
	 yYlzDB/fDcXdIhYTeNnPRrcF280mPrYdnfqWs6Kfpv73zfdjqzBsE/d6fRo8zajNfn
	 juBt2VgKRahwxifB79PGurdat8DRbUy0ekDyVH++7y9m9a6eCrM67WFBOCrjtWdOsb
	 YaIqJRITLREEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A90CF3C244;
	Mon,  9 Mar 2026 12:23:07 +0000 (UTC)
From: Jihan LIN via B4 Relay <devnull+linjh22s.gmail.com@kernel.org>
Date: Mon, 09 Mar 2026 12:23:04 +0000
Subject: [PATCH RFC v2 1/5] zram: Rename zcomp_strm_{init, free}()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-b4_zcomp_stream-v2-1-7148622326eb@gmail.com>
References: <20260309-b4_zcomp_stream-v2-0-7148622326eb@gmail.com>
In-Reply-To: <20260309-b4_zcomp_stream-v2-0-7148622326eb@gmail.com>
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Jihan LIN <linjh22s@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773058983; l=2360;
 i=linjh22s@gmail.com; s=linjh22s_machine; h=from:subject:message-id;
 bh=Z2zJlFN5o7oyquHJ77E4RHCSdek+XUnL3CmLTthvZjM=;
 b=60RfqiIrFqgkbjJHEzlPVUfSgzje0OaCeVfWhVW0yzCJ1g61IfSGi9uq3jbZYOonDXdkf8B+0
 rp4e3qlG1BzB+qfCMewviUA3L2jBR7El3My+vbv+GHRKbS074zs+KyU
X-Developer-Key: i=linjh22s@gmail.com; a=ed25519;
 pk=MnRQAVFy1t4tiGb8ce7ohJwrN2YFXd+dA7XmzR6GmUc=
X-Endpoint-Received: by B4 Relay for linjh22s@gmail.com/linjh22s_machine
 with auth_id=592
X-Original-From: Jihan LIN <linjh22s@gmail.com>
Reply-To: linjh22s@gmail.com

From: Jihan LIN <linjh22s@gmail.com>

Currently, zcomp uses a preemptive per-CPU stream model where streams
are allocated for each online CPU and guarded by mutexes. The existing
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
index a771a8ecc540bad8bf535ec87712da694e34a1d3..f2834898d3b700746db7bd2296ea9f4186e183c8 100644
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


