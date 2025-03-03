Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0B12566DC;
	Mon,  3 Mar 2025 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019466; cv=none; b=pCEtJbsPhGdHKiXIZ49gMEorfjUQucL6grEYsCJIx9KyPY8IlE8dzSgNPxVBEyzixw7nw5Y4vVZgaiuqo/Uuinq/YWXDFBRZW8kMQez9YA/T0szeWn5GbZbw4N7sFyAFdNdpaaOW4wgkXHR8tBtaPe11famBq7yPrNpkITXz1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019466; c=relaxed/simple;
	bh=KTcV9V8+JgBuCHgkTTGINcMwCwPMTaH2dar9BWndPLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jRTBvpOHWkh8uVGmEIw9YDxCndl7RXxXDcvFZohR6eKM5fhp+ejx5aHFH9ZJYS7SpyHWfoWY/oNNpo07HmfCjVGnu0BnNY8KvyiYTzommJeiRd3PlnymYQv3zwUoR2ll9dwXsg5m0gEMnAWnsbMbgzu0pQ4SljYW0E3xRxBMUmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzmvVTbD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzmvVTbD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82666C4CEE4;
	Mon,  3 Mar 2025 16:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019466;
	bh=KTcV9V8+JgBuCHgkTTGINcMwCwPMTaH2dar9BWndPLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dzmvVTbDobnwAKrPiKDXmZ//s2xaNVYUfAMM/Ix7o63dPWEi4CpJwEnDtLMJI7jKH
	 3nte809jvz+8+WSrCFpDgjQeRXlYn+mxzD2MEsgz3JKxADsjd3dZJo6UkoQS5sDa0v
	 2xELwBzaYfysQCrd6qHd6beGu2iLXvH7Gt8dnoMgxKEssyc/gY9GTvzzY+GaKOHL8y
	 WG9Mb402SOZuQ/Qr2k2HbMtPCK9kG3nJCbQjErJSYBW+fB2/++LRCoxmlXLP4t5XjJ
	 vaqMOua63YJ/v4UQrcOGfEekXOD33yCswCPgEu+2c4QlLoGnY3YG7QqJPpd1taJSYr
	 JxvnVWKWcqMMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 16/17] block: fix 'kmem_cache of name 'bio-108' already exists'
Date: Mon,  3 Mar 2025 11:30:28 -0500
Message-Id: <20250303163031.3763651-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163031.3763651-1-sashal@kernel.org>
References: <20250303163031.3763651-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.17
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit b654f7a51ffb386131de42aa98ed831f8c126546 ]

Device mapper bioset often has big bio_slab size, which can be more than
1000, then 8byte can't hold the slab name any more, cause the kmem_cache
allocation warning of 'kmem_cache of name 'bio-108' already exists'.

Fix the warning by extending bio_slab->name to 12 bytes, but fix output
of /proc/slabinfo

Reported-by: Guangwu Zhang <guazhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250228132656.2838008-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index ac4d77c889322..43d4ae26f4758 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -77,7 +77,7 @@ struct bio_slab {
 	struct kmem_cache *slab;
 	unsigned int slab_ref;
 	unsigned int slab_size;
-	char name[8];
+	char name[12];
 };
 static DEFINE_MUTEX(bio_slab_lock);
 static DEFINE_XARRAY(bio_slabs);
-- 
2.39.5

