Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB6726159B;
	Mon,  3 Mar 2025 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019493; cv=none; b=JJGw82XnBf9u/rzNbhvMAKRBSbuWlVxDe/6wYOOjABvEfeK9N/8HmjhvgfwOr2h16O24bhjvess4Kgu+X9h9eK6+QB+tjxlhNfAY9YjK/ZUO9a/k3ba5BCsFSSd41+HEYbN5jmBA6lleKKa+yiPeTfkXgwkJzlpqw8Lo2ZIQBDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019493; c=relaxed/simple;
	bh=wIW1mXe4MK1bPn//bUmz40Ab1vZR/KxUpO0K2Gv94+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j9PPNi3UuP9K8Cpt4fFNvOPBxwuwF8Kad2ky1Diovcy/P1CNF29KJxHu86Ao9Wli3tEdulaysQttATc4tM9Q3U8ZJwsudfcIZZN0CbQCDmIFihDczpgWMhyUR0pPuAg9wdzLtEJvhyYx2kpqMh7oOOWeiVSrWj4qJOoA9ut9WgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcBcTdf2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcBcTdf2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D340C4CEE6;
	Mon,  3 Mar 2025 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019493;
	bh=wIW1mXe4MK1bPn//bUmz40Ab1vZR/KxUpO0K2Gv94+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TcBcTdf2NxlFsu3VsBjV6swA5tkvGYbBhsR98AnKlNz5dxmInfFELWRA7ro4oHkqn
	 kkE3nMgX+jaN0URdgWW72xpxzZQo3HTRw+QislM7FPmOd4+ARKVU51YNZnHC3wJuCN
	 71OuUMc+QtKIKgDs58WC5IvPVcC8A0uQvKzCx9N0uAUEyJSMEYhK1b8UvV88SQi5eA
	 lJJAe++LILG7xWqNG/a0uG1vKzJESijhOzGXw2q1xSL9e3gaiU0FVGaqRzffTObH4W
	 im6iA/Phf3hiZRQGOfcy/qdp9QDeelKMvjTU2PQNsG2cGfdsQgzeBGSoadey+KswNK
	 5z6rx0e+4EqCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 11/11] block: fix 'kmem_cache of name 'bio-108' already exists'
Date: Mon,  3 Mar 2025 11:31:09 -0500
Message-Id: <20250303163109.3763880-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163109.3763880-1-sashal@kernel.org>
References: <20250303163109.3763880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.80
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
index 62419aa09d731..4a8e761699571 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -78,7 +78,7 @@ struct bio_slab {
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

