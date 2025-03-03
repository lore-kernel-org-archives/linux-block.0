Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAFE27C15A;
	Mon,  3 Mar 2025 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019556; cv=none; b=LA7ScH1fidjJpfkY1Rh4qj6JzTRItdbtxKlg2yQN295TVhq5U+BW3yLodmlnJ0pMcx15YPj6Xc89Id5rEbxmoZ+ePWej+xl+lW2ATThkh8xWFZKwKQBt0r5Ma6VsrCdzdJvz9eedjlVguOhu9OUmEN5b+GPoQOcMZluN7N9t54I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019556; c=relaxed/simple;
	bh=BjovHo68oZYSOarCRlTU07vBmWsubBFMlJwRwXudCBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k0X0jxj2fxSnsaaZCjce88eKnQvzNO6hgJW1nErGGPWLcUmVfclcYn9zEgcRvSgQVwE0UwcM6p3Xj823Sye6mws8qtw46tVgQhK4QDHwmQXsKzz3QPgRpeYZrvPOj8Dvrxg/nqBwF1bF8DP5RVhemWxl2hE/z8UcggN27K5j30E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQ444xxJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQ444xxJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB74EC4CEE4;
	Mon,  3 Mar 2025 16:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019556;
	bh=BjovHo68oZYSOarCRlTU07vBmWsubBFMlJwRwXudCBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jQ444xxJ6/gSE93dA042mF786W6Qvu9hi3Gz8TOR/lgPLL6Tks/vAgiqf0nZE+U+Y
	 OZ6vSvjK+ovXCi140mmlldh8TVqP216ULl3N3e8+ySc7Gn/LfWNgk2PaixLGA9v9YD
	 V4n3xvmrZYHKRd9ifut0b8LhJcTdSajtifQ6RN4ab+cSJy4KeZlMV+DJS98kbOtN7O
	 sN/718DRYnAFpF4p2d69EswmMVN/uI0WQ6BHZrXcFxwanSpGDNavP0lMC5cWy8Gz9j
	 I0Orsw45hGMqSfq3Gwm74SSXG9tMoy0VsswWsHpTbak/ddO5kzn5yoLzVS7wJDi96H
	 hdQlOak0ystIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 4/4] block: fix 'kmem_cache of name 'bio-108' already exists'
Date: Mon,  3 Mar 2025 11:32:27 -0500
Message-Id: <20250303163228.3764394-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163228.3764394-1-sashal@kernel.org>
References: <20250303163228.3764394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.290
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
index e3d3e75c97e03..239f6bd421a80 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -53,7 +53,7 @@ struct bio_slab {
 	struct kmem_cache *slab;
 	unsigned int slab_ref;
 	unsigned int slab_size;
-	char name[8];
+	char name[12];
 };
 static DEFINE_MUTEX(bio_slab_lock);
 static struct bio_slab *bio_slabs;
-- 
2.39.5

