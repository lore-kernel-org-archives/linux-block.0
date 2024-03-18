Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 33532F4FB;
	Mon, 18 Mar 2024 02:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710730557; cv=none; b=ZR3sLWa4jBBawn/KJZqkBDS5dB52YI9lThpbVKjTBTgJjidb03ImJg9hg5hj4QNSOZGeXZkw4I5w6jZ2CmvGLoqa5+h6rUcoGQkwmoc1ygNPbLs1AL6qLWnzCbHKARP1BkJS/2j5a2xuEB14Md6sodSJA1GoAj/EhBICEsnjWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710730557; c=relaxed/simple;
	bh=fkonxBgMRMtaBISYWJpW0F8iOBDGTSaRz61X99BU+Cs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XmNkObOce3+quYFFhNBHiMkqbv7jfEyvguClWzWxYifF/anKuavbokJxIo/Q2YYqwIWKVKJTzUGFubKf4UEtmQ12x/t6uqUO33mni4zap++BS7cKAgik6tghNNZFpMCcBwWm9k7ZAnJeOsNuYlB/atLWzSIjeXBK1PSg4cH3DJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 355EF6027FD66;
	Mon, 18 Mar 2024 10:55:32 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?blk-zoned:=20Remove=20unnecessary=20=E2=80=980?= =?UTF-8?q?=E2=80=99=20values=20from=20ret?=
Date: Mon, 18 Mar 2024 10:55:25 +0800
Message-Id: <20240318025525.16439-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ret is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 block/blk-zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index d343e5756a9c8..6633e95bc7858 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -255,7 +255,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
 	sector_t capacity = bdev_nr_sectors(bdev);
 	sector_t end_sector = sector + nr_sectors;
 	struct bio *bio = NULL;
-	int ret = 0;
+	int ret;
 
 	if (!bdev_is_zoned(bdev))
 		return -EOPNOTSUPP;
-- 
2.18.2

