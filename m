Received: from lounge.grep.be (lounge.grep.be [144.76.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122C47464;
	Thu,  8 Aug 2024 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723100811; cv=none; b=JVczRfMtYdzGps7obaRqF4qukzQfIP+rx8s7Zwquk4K60rrxzukgcLXrsNGNaHn01XNAr6MZTYomk4hxN1RB8GfiHIoZfCI25LzmU0Tc+3VcHxz/p/rvBbJ5VOLBSF5PFMLzxH1Ay6ip0civGmMJ4petut4VbgQ/K2AlJ+K282I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723100811; c=relaxed/simple;
	bh=WYdJjsUR0XcPAVxzn4RPM8KtaqCFZ5ZcWUHVmE5gdmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=id6mXVtK6dLFgUZLDWL1w1O67E98vEJnXoGBR96XFl46t32VhmUSoWqv9Pfcw6QHQmoDNPqTXEuS9aAi4loQ4zfm72GxUZEkMtUx84zZ1kyKipw3jzpZ5grLKV5BxVUY9HilQXpf35Gf5K8sgzuX83LVT2sFaFohr/CL5eb0BYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be; spf=pass smtp.mailfrom=grep.be; dkim=fail (0-bit key) header.d=grep.be header.i=@grep.be header.b=ckK2gKf5 reason="key not found in DNS"; arc=none smtp.client-ip=144.76.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grep.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=grep.be header.i=@grep.be header.b="ckK2gKf5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grep.be;
	s=2017.latin; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ar1LioCAReyFeveBmkcT8PsTVaYpzp50hAJKGqIzHME=; b=ckK2gKf5rNOyVze3rH/Zm0dKDx
	9IPPwIO2RxfdmW3wLKDwbfp1hhW8t9b3mWbKsCh2GFCe4avbX6T2XUrdLFsaByUUGnjSNNqZgYAiz
	NTzsh4Z98fSEhBdPyOMhBNLhDH7KIC+2UvBnbVKDZ27J/Mc2I0352mZcrozm/g9E3hvHH/eCYXccd
	0guZJRN5GXGUsDIs1cr5wf11Tz+ybqvFxoRiDS/+OkgyI5yE7AnvHOekAn1hu3zzWK6Y7anI6uL+W
	ep2sMWt0i1HcAuoTp2qLbMFMG/KP3CAqhYFt+mDohGn9J+6eMwQZGu9J31rbUa1yam9mYYoY4bNU8
	L95TvUBg==;
Received: from [102.39.154.62] (helo=pc220518)
	by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <wouter@grep.be>)
	id 1sbxER-002YIe-0q;
	Thu, 08 Aug 2024 09:06:43 +0200
Received: from wouter by pc220518 with local (Exim 4.98)
	(envelope-from <wouter@grep.be>)
	id 1sbxEJ-00000000ko8-3FhP;
	Thu, 08 Aug 2024 09:06:35 +0200
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Wouter Verhelst <w@uter.be>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] nbd: correct the maximum value for discard sectors
Date: Thu,  8 Aug 2024 09:06:03 +0200
Message-ID: <20240808070604.179799-3-w@uter.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808070604.179799-1-w@uter.be>
References: <20240803130432.5952-1-w@uter.be>
 <20240808070604.179799-1-w@uter.be>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The version of the NBD protocol implemented by the kernel driver
currently has a 32 bit field for length values. As the NBD protocol uses
bytes as a unit of length, length values larger than 2^32 bytes cannot
be expressed.

Update the max_hw_discard_sectors field to match that.

Signed-off-by: Wouter Verhelst <w@uter.be>
Fixes: 268283244c0f018dec8bf4a9c69ce50684561f46
Cc: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index fdcf0bbedf3b..235ab5f59608 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -339,7 +339,7 @@ static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 
 	lim = queue_limits_start_update(nbd->disk->queue);
 	if (nbd->config->flags & NBD_FLAG_SEND_TRIM)
-		lim.max_hw_discard_sectors = UINT_MAX;
+		lim.max_hw_discard_sectors = UINT_MAX >> SECTOR_SHIFT;
 	else
 		lim.max_hw_discard_sectors = 0;
 	if (!(nbd->config->flags & NBD_FLAG_SEND_FLUSH)) {
-- 
2.43.0

