Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4534277031;
	Mon,  3 Mar 2025 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019547; cv=none; b=ld5RVc9Xop1HtxHpDBXtkx5E2ZGne7mtvCVHO13fdOAU4FC+FdFzDlTqe5YgA8e9/e0B+8aOFgK4Yyap+awNlnIBPCFhOB49VihbqULMuHFJDtYTknZlnAWBZJO9U1OlLk2Nhr5XjdtoEvnSkIgOaSCfbGFgcUeqPx+MiQ/0j0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019547; c=relaxed/simple;
	bh=rOy5hMmjF1kd8PTB/KewGJQdLsx+/oyJithouVDc6qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y5y8HM2o9Y4DBUQxyEJGQJ3pGY75Rt2r4fbVHPVB9P4YjQQuxda+Y4+lu8cYS2prenr0P4CTv/RqxwYquB80HZluJBO8kXHQ8uOCgc3zlQxJ0wbP7rPi0dt+YoyOBekveXx69MYGGgTpr5GFwK09NnCvWItadwDzBHinC5rXe1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ky5T+mUF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ky5T+mUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A1FC4CEE6;
	Mon,  3 Mar 2025 16:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019547;
	bh=rOy5hMmjF1kd8PTB/KewGJQdLsx+/oyJithouVDc6qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ky5T+mUFZLXnE79k/E7tVoYzt1WEZmjVrxh9RbQ4Fo8/S6A+B8CIZzH26qmizeBR8
	 mbAYuet6bIg35V9lfjnOlSIDv8MNKm1BszWb+ul5QFDabVJvzlTP+SpoDRoAQR9geO
	 Rbbn0W2CEFtB5bUjSNY2cu649EwuJuVxUqsuTWwl7sP2n1SpYr9yz1F6ZJkPAfS/4s
	 q71Y+jmSmhzEoFqIUvQCuhEMo1Qb095wO4ipkTMndYOiiwSOKwLF5ljSnWvFKsyI9P
	 Njg3kzCwMN9Mli9JQGlwsWw2JyCEu8MCHm/vJWmDl0blOGtNtmKBqGlYkQHI+iIjOL
	 4thN+f+HywukA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 8/8] block: fix 'kmem_cache of name 'bio-108' already exists'
Date: Mon,  3 Mar 2025 11:32:11 -0500
Message-Id: <20250303163211.3764282-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163211.3764282-1-sashal@kernel.org>
References: <20250303163211.3764282-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
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
index 6f7a1aa9ea225..88a09c31095fb 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -55,7 +55,7 @@ struct bio_slab {
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

