Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D431B3731BE;
	Mon,  5 May 2025 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485222; cv=none; b=LlsINTEAPmcjZWh8K9vFQ82ta7oJwAaO25r6Lher3EmCCMczp5DMjNapqqjwzJ4osxFxMelpxsTiZi1OlzL5iH2imITTePysG1qw8HP8RZBobTrJY6ZIh4BAF1L8rZOSGUTEeJjoxnqbXj5LQQAE8DSzCs+/mDYIFRV+JPTEl1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485222; c=relaxed/simple;
	bh=bJPC8aEH45sWOWUt08yBygJpgHxGSQ08PVjPaYXWK/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QTG4Z912lWyK+/LztciEjfvY3QLqFaAz+T+Md+LYsbAchWcsF2SCq4cMPkDl5sW61VOaEmedgIsUgNjngKzvbL+vX3WoQfK1ljzTsNS6E6onCm5z8TNVsaWh3MHRo//RS69Z4aTS3Pr0n56mVIDLkaLzYbY+G0W1fIxjPQ+5A88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bc2NPgeV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc2NPgeV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3682EC4CEE4;
	Mon,  5 May 2025 22:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485221;
	bh=bJPC8aEH45sWOWUt08yBygJpgHxGSQ08PVjPaYXWK/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bc2NPgeVDpJd+ScN7PxGmV1bq+bsah+O5W/eFbq2hxEGPPArddLHEbEXufdjAh7Dg
	 LD5pSppp7pYxNN83fSxdhbpQ96U/y80TuSUDrRvUhPSddTP237P6sc1VmCTlTrNkKA
	 cQoQSkrLSp8UdX9TUQPAhqy1wgWmztC7hmzjQpPkV1mzTrp0tyDw0HL+v4zlwRVwjy
	 frt5CV2L/RQDskKv+BC62igkd1oMJuCbHJz33oXhI93N4HztnLJrKoxWEzAuoH6ews
	 2mkyVHVyCIq2+UjrivxVkD0UaWa1E01xQ80gVRBMPeatV8C3KBnxRcCEUU/sFcMBbf
	 uHyv6hgMriHzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Anuj Gupta <anuj20.g@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 218/486] block: mark bounce buffering as incompatible with integrity
Date: Mon,  5 May 2025 18:34:54 -0400
Message-Id: <20250505223922.2682012-218-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 5fd0268a8806d35dcaf89139bfcda92be51b2b2f ]

None of the few drivers still using the legacy block layer bounce
buffering support integrity metadata.  Explicitly mark the features as
incompatible and stop creating the slab and mempool for integrity
buffers for the bounce bio_set.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Link: https://lore.kernel.org/r/20250225154449.422989-2-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-settings.c | 5 +++++
 block/bounce.c       | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 1e63e3dd54402..7858c92b44834 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -124,6 +124,11 @@ static int blk_validate_integrity_limits(struct queue_limits *lim)
 		return 0;
 	}
 
+	if (lim->features & BLK_FEAT_BOUNCE_HIGH) {
+		pr_warn("no bounce buffer support for integrity metadata\n");
+		return -EINVAL;
+	}
+
 	if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY)) {
 		pr_warn("integrity support disabled.\n");
 		return -EINVAL;
diff --git a/block/bounce.c b/block/bounce.c
index 0d898cd5ec497..09a9616cf2094 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -41,8 +41,6 @@ static void init_bounce_bioset(void)
 
 	ret = bioset_init(&bounce_bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
 	BUG_ON(ret);
-	if (bioset_integrity_create(&bounce_bio_set, BIO_POOL_SIZE))
-		BUG_ON(1);
 
 	ret = bioset_init(&bounce_bio_split, BIO_POOL_SIZE, 0, 0);
 	BUG_ON(ret);
-- 
2.39.5

