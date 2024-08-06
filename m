Received: from lounge.grep.be (lounge.grep.be [144.76.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718061D1F73;
	Tue,  6 Aug 2024 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951082; cv=none; b=cNwp1nn8pyor0RT3UKoohv+t6yadKAORLqxiB/kDs3NFnRXhfNn1frkIJZhks0cPUtuHjbF3+Z2M4FVRoQBSm0eSZLmA7Yw8/eYbbGg8esigby6wXoShftPeHCGEMbqVZArG43XvfjA/PcoZRxSGTyQeX8FVZy8QaBEZx/aGnOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951082; c=relaxed/simple;
	bh=TD20eceQmDWe+GB0izd/3j2w6czmpj6fF7AlDhyNu/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmdntl+EtFhcY+6WR1weT+3We1H2bv1yO+zTebh+JmIb0aYBqojcq3CUCkJ37WAGu453MsAwFZcVWCz7hFXQi4UirL2REje0mGNh6AJOqBviEUwvO0sVgF1jWbsfdhzLbm1t+0l6mvClcJBrGJiIHwC/df1bktPTeek0filWZ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be; spf=pass smtp.mailfrom=grep.be; dkim=fail (0-bit key) header.d=grep.be header.i=@grep.be header.b=d9IxhPod reason="key not found in DNS"; arc=none smtp.client-ip=144.76.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grep.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=grep.be header.i=@grep.be header.b="d9IxhPod"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grep.be;
	s=2017.latin; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Xcgcw/iQnRD6/Ii1rjeE6TECmbYw3NwUK+7/q09vO38=; b=d9IxhPodRH3LMsYIATXCjfU3CT
	DT8SPwh3xivwMv+k4bKHDIGVXBtpV+wSS/tJ1wvGBRhJjBXr3hOOHhVFKq8t5khsSaJsq1p3JUuch
	YLp8DLvA/k9fzq0rdRnQ2DrqSutWhF3aVPWl1fAzQ2OjOoBZYoZZT5kLg/6FOrYQq1ev9kerk4HeL
	WJ/6zP5yKx50qIvJcR9EkhoZs4ZXdUInxK0XZ55Z2auXdwfMfIOegOROEH6B7qc5jSXozIgWyDqs2
	d3t8gu21vq65+muvZziOTJd2toUC7MEzbNK62WFi0xHTA6uXDaxTCxF/X3PVr3rkjJKEsKbWFONPb
	HvsUYWhA==;
Received: from [196.251.239.242] (helo=pc220518)
	by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <wouter@grep.be>)
	id 1sbKHT-00HZHV-2C;
	Tue, 06 Aug 2024 15:31:15 +0200
Received: from wouter by pc220518 with local (Exim 4.98)
	(envelope-from <wouter@grep.be>)
	id 1sbKHQ-000000017kw-0HfU;
	Tue, 06 Aug 2024 15:31:12 +0200
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Wouter Verhelst <w@uter.be>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] nbd: correct the maximum value for discard sectors
Date: Tue,  6 Aug 2024 15:30:56 +0200
Message-ID: <20240806133058.268058-3-w@uter.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806133058.268058-1-w@uter.be>
References: <20240803130432.5952-1-w@uter.be>
 <20240806133058.268058-1-w@uter.be>
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
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 20e9f9fdeaae..1457f0c8a4a4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -339,7 +339,7 @@ static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
 
 	lim = queue_limits_start_update(nbd->disk->queue);
 	if (nbd->config->flags & NBD_FLAG_SEND_TRIM)
-		lim.max_hw_discard_sectors = UINT_MAX;
+		lim.max_hw_discard_sectors = UINT_MAX / blksize;
 	else
 		lim.max_hw_discard_sectors = 0;
 	if (!(nbd->config->flags & NBD_FLAG_SEND_FLUSH)) {
-- 
2.43.0

