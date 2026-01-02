Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECFB20C488;
	Fri,  2 Jan 2026 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767365380; cv=none; b=LsGap3QoM94GJVC9sp1/fRxj/Cbndu4QcPQSCzQR2+4Gec86OK85+zsjd5dHI0jBDkbnOSVrMZeAoVo/NAB/uvlK0zRYAd+5hZ9Rwst4p50zKohRFUiJLc6ulBYWl5NPrLeFW8j/+bgT2rkqEFiDWXvtYn8BaxzT2eCS/B4y4Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767365380; c=relaxed/simple;
	bh=qZZVe7dI5RoV7ypfn2BCqByQl/Rrfb6IN8o30oe5hfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KN5YZ0vKOhfeKsLgOjSe8ZtfIWDiVgWozk+zlrYNvg8p/3dx3bqm7LDmWVfbH7DXdnE7Iw7OCnFZeb5Sg0wqnXflUQdKcTz2wqrTWvjKsvbqNkdiZ2imxVg84dqpuSeIMwxBocWUfzL9xGIGo7yRb1FTOZd3R8obI2jtQ40P1V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=seVnVSHi; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="seVnVSHi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=IN4ZPEM2XJumj6U3hK6l0T7+VyujQJ17XVJbwsFxc0s=; b=seVnVSHiKS2K32
	sZ0LGNS7eqki1O2IyxS11970Xo/zJ5tJCmye3Ojz0knjjTwknwKkoftgdCdvb0+z6StErHBxNN6M2
	rl4Q+iXWrO4jIrSqYZhTLo/XRDGFVqkTgdVUyk9agUgjjCxegy/ClsP/WiKApja2eqE2UAO2DElHn
	wNDcs3as0nZkIcZNydKgrMVMa29euo7eeA2skv+hOLmKh507NZ3/Yj4JUCfy9wMgj+LG0cQEQZRHM
	8gsQXCKTfeaUlJelOoZJIz3966mOEqzAYpjY6TI231LJcK6MDMJIM3kMUanVjj6KKZcl/vwcxznoP
	EGm4f8bxWR8PziA9IziQ==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vbgT8-0006BT-B5; Fri, 02 Jan 2026 14:49:34 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1vbgT8-00000002kko-0UCa;
	Fri, 02 Jan 2026 14:49:34 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] block: fix type for printf argument
Date: Fri,  2 Jan 2026 14:49:21 +0000
Message-Id: <20260102144921.656362-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

When making the block-%d id, the type should be %u. Fixes:

block/bio.c:92:62: warning: incorrect type in argument 4 (different types)
block/bio.c:92:62:    expected int
block/bio.c:92:62:    got unsigned int size

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c278..198b966d71b8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -89,7 +89,7 @@ static struct bio_slab *create_bio_slab(unsigned int size)
 	if (!bslab)
 		return NULL;
 
-	snprintf(bslab->name, sizeof(bslab->name), "bio-%d", size);
+	snprintf(bslab->name, sizeof(bslab->name), "bio-%u", size);
 	bslab->slab = kmem_cache_create(bslab->name, size,
 			ARCH_KMALLOC_MINALIGN,
 			SLAB_HWCACHE_ALIGN | SLAB_TYPESAFE_BY_RCU, NULL);
-- 
2.37.2.352.g3c44437643

