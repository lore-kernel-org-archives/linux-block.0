Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705C626563F;
	Mon,  3 Mar 2025 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019512; cv=none; b=jnHo90/jtN+z5FLonmafaPbJTNzYR2w9ixD6w7LY/R6p/i3dDQpmA62xIQxgqfV4AdWNSkmUVluz+3Di2JzUhjLOtjPcQyTGt5rvtaUAaHz9nx1ysIMlqBMgMVP74fHOssk+W0bUSX1rXUMh2YdJUClOglv4IIre0NKHjL+tcE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019512; c=relaxed/simple;
	bh=pamq55l0ANX25XM1RaeQViIltEvGjtHPIDspqp8l3C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aXPIMGi1/cYbeXCD3PmUHYvuXUFbZSZqxesTHjvUaY/tozRwVBVG0fIa3jemPKH6WIVh2lKgNEWE6u+HHyMjxJWS280bjSNk4EKtK/rWKwjGguZjoQ6Ybq2bvwTLT7WWIMxujEBvXBq8bnVk4YT52WtcJhOJu/lSDQUTZ7eaUkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hx9JHNKh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hx9JHNKh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23768C4CED6;
	Mon,  3 Mar 2025 16:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019512;
	bh=pamq55l0ANX25XM1RaeQViIltEvGjtHPIDspqp8l3C0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hx9JHNKh9guHLk06mMBW4AryvAyGe3KITLAc3nSvYRAvhxM2FMFQj9fBmph1rB3Vp
	 jEeI1yN0K/7P+2RspC8A/W+CtXqqaL8prvGHwrFRd35kzKNRZom6qjbaUSNH0bzJHQ
	 eqRT8HQYf5OpIo9N2sEmOCq4r72o1wne7tmvukRLSXwlNN9VkCaPlcS+RemATE8HM2
	 fvToxLCMtE57448Mel4JqPSK79vMdYL8GgpgddYRzjiQg9T+9ZEsqCRKx4nVLdr44c
	 iq1234kSMOCPUyLvoRMgdFz+dqRtwovD7CTn7wKRWWm/fE1gMgxe/7IoXmb5+3aaNQ
	 RjykoI5fLR+sg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 9/9] block: fix 'kmem_cache of name 'bio-108' already exists'
Date: Mon,  3 Mar 2025 11:31:33 -0500
Message-Id: <20250303163133.3764032-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163133.3764032-1-sashal@kernel.org>
References: <20250303163133.3764032-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.129
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
index 3318e0022fdfd..a7323d567c798 100644
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

