Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4F5237180;
	Mon,  3 Mar 2025 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019427; cv=none; b=FSxQRl5p00euLqsY6DSaK+a3dWXDIXout8Ml+n7pWVHWjA4xuGEjia6U6en5QuL5LTVpM9A7vDUjL3Prgpkxu9ZtfVt43ZQ0KbovPgD2V6pqjYw3cCNZRjJ/sxexS3RsZ19VAglzfTkoUf8JuCenNYZHi/ES2qZjOrqawEnBIkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019427; c=relaxed/simple;
	bh=D1PfnMHjXec0jX2k9ntUQpXIqwTP3Jt7slxUP3yTq7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uspCoibGPtwf5rmNvfY+vt1/stpFkBttb8jb5vOWaikPYqJZpk2W6EwzB1XbJXS/Zk7I7QDMmwk03heUh8U7DCgJDk2OtkWLkrWECv7b3tPPrrxjUDh0NZ3fIlEWDeFMepffWF4sMbUVqXT6TfSZX/DS+nz9Um9EUS1TDvDMNyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oM0/7ihC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oM0/7ihC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EB6C4CEEA;
	Mon,  3 Mar 2025 16:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019426;
	bh=D1PfnMHjXec0jX2k9ntUQpXIqwTP3Jt7slxUP3yTq7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oM0/7ihCPplckIQNK/HPNkLF9Cr5e0rYeWO7K4zPshAN2xS4Lv1O/T7hdgHZxEP8b
	 U0IFXNaATqFDrn762IScc5be+so4zsr2/9uTzpFR8B7FGnynz6MWAoytajoSHtgBaK
	 OuEjzHD+POtbS2xRBbi2MXgDpX+7mO6XuvkdjidAYjqaFHGjXxAeZagZaqRuYmRt0v
	 9FMzRV7G2TcQslovGWSXpMMR56uOIH4P7bSug062S41AzhRHKaclAkUk5gVmeMSvcB
	 R2y3shWZTRDCIfIdOUFUzQo4PehALmdBQrNAHYo1uP/1sSBjRtzx9TCtFOJxl/0Mql
	 VW9YzLCYyTx/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 16/17] block: fix 'kmem_cache of name 'bio-108' already exists'
Date: Mon,  3 Mar 2025 11:29:48 -0500
Message-Id: <20250303162951.3763346-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303162951.3763346-1-sashal@kernel.org>
References: <20250303162951.3763346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.5
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
index d5bdc31d88d32..f54e8572affc1 100644
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

