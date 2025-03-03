Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3BB269CF2;
	Mon,  3 Mar 2025 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019530; cv=none; b=t/MoBGDfFOB3VcTyr4ffqD+5SpzUqPhlzr+tw4iIG0aW5YXroKnFw5rPQbIjPxN34bR7qY9YEwZ+XrdcGvOx5ru8PGL7DEsvPdpdp3FO9cOwqJg16Yls7f5CMqj4bchrKFrN2z7dfJU73jswGNU1bH/rv4lXIrQyYvHz7PBKx0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019530; c=relaxed/simple;
	bh=FDyFc1JaM7FrQnRKj9W1IyD+VmwABk6Uqh9IFMTn7RY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bb93le0mhd8L/WX0/ht+Qmqz7MP4FKSuVeuSKDd2i+pIU9o80CmYO91BFwYI1N7m4m+wSCIPb5qvM3Qajjy6mEeaFV2aeOkA3+5+cbtvU7HC0Y8uI/FuWKd8Cewp1kf39mTly3mvZhFcSWZ6MHyYmyEqxCkss9sdF0B6N/rUJYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBJu1jV2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBJu1jV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C496FC4CEE4;
	Mon,  3 Mar 2025 16:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019530;
	bh=FDyFc1JaM7FrQnRKj9W1IyD+VmwABk6Uqh9IFMTn7RY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aBJu1jV2JyrK9E164EwF8cGMVSoWv8SfKrdBZ1x6mZ1EKoPx7jGHkLNs0ekhWkQIw
	 qsNRAqwyVqO+y2cNoAqF4QNeluiZG/gj3zMke+YHRvUC79cR6T/0S68q3vQX8aCyTJ
	 SeISgRcyWV5QYeKK8ybcAOquZeL8S3Qpd0BJdGXv4B/D/f/XzHnbVqB0CaTVgPcEWA
	 0ZEnhDDChHKSwQnEWs8bDgKqgM8UOgsgmI0GNgDAeVSwKahj4NldPfJD8dyokXx9K7
	 MmvjYFY9jDHn9MW9jZBIFqkOud28UNbKTZ2NFZ5ktV2g4Lk+hS5Kct7gHNLMaqY75n
	 CHXkpC0nxxeYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 9/9] block: fix 'kmem_cache of name 'bio-108' already exists'
Date: Mon,  3 Mar 2025 11:31:52 -0500
Message-Id: <20250303163152.3764156-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163152.3764156-1-sashal@kernel.org>
References: <20250303163152.3764156-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
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
index 92399883bc5e1..029dba492ac2d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -73,7 +73,7 @@ struct bio_slab {
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

