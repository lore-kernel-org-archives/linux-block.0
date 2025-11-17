Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A3730EF6D;
	Mon, 17 Nov 2025 05:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763357662; cv=pass; b=WHQRMqA81QG7fL19autWaCjXqfkzROM8G2pwKYyqCHCo/Tj5M1osKVS4sFrl6AOCfxv/ykNEe3qyrmqWHJg53wkyHGv9Xy+/DRSUy+utUm41lVpDiRpbjHKuEiRfCnZg7ELsIMwlOKT1JLlpD8xeutAv6rLfLs6Ht9iuVPU5+ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763357662; c=relaxed/simple;
	bh=eJEr5axAgO3pW3woAtrNRmdLqMTSHdl2NDrZu+GGVTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h83enjrtlNwVFMmrdvgyPVF3lwTXvCMzBiBwRBYqg1IHh6RnJYV59QED9zQDRgAopz+M93msWj7plIWMQBeFSqBHvTkMgNSpLhRUiEzgYqYSRkhu9SfWPELF6s3VsgKZeP+ETqieQJSl/w9iaspPphdEBNf0Iv6ZfeGhiU5EW4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=myaOtPV+; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="myaOtPV+"
ARC-Seal: i=1; a=rsa-sha256; t=1763357655; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ve/zxr50tLIIBD8bFEze1IFjasqsfE+O1SOmaSZyNIDlHAYt8qch1qKUJysmjJ4HeE0mGxgBxEHDwL3JcfD80EIz5MP4t/vbv4YAXLIDtsCdYguRRACQh0bZgnYESoY+QbAMXSkhVqzAKbxL91342gXmkbwirc6ms3KXj6ba1P4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763357655; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zz9E27inqmhoKRBcoJiCQ6d56m1Owtm9pkDIt5HNN9s=; 
	b=nbVzdh05W+EEA3sYctbaeNnDFba9G9KdP1JMo/kj6VyiFmZEEqcBZYLJSnOQ9CBfJbQpxHQZJMWP2S2/JyQ3Fo1LBURfZdC484M/INbk9p2F5t4olfLhlcS8Bb/wbKjXwcVDbxsHQk57F5MJ3L0WSbhQ0WF7PE6JZydVt9oTSuk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763357655;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zz9E27inqmhoKRBcoJiCQ6d56m1Owtm9pkDIt5HNN9s=;
	b=myaOtPV+EESPwtU6nlUPK9o3qRN7CaE4o4yCivyjzFHoFkGrse1RC8pmPNZDuHzo
	l7gUSk73uslalxrJollb8kdHsIkbb6QgISoT05PmJHLmfq5IT94ZMk8SDRRSDn/TX9H
	Rjwo666D481NxqDgGrmSfeeBH93Gx/UYdwRtsWdo=
Received: by mx.zohomail.com with SMTPS id 17633576523032.890278833137927;
	Sun, 16 Nov 2025 21:34:12 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] block: rate-limit capacity change info log
Date: Mon, 17 Nov 2025 13:34:07 +0800
Message-ID: <20251117053407.70618-1-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

loop devices under heavy stress-ng loop streessor can trigger many
capacity change events in a short time. Each event prints an info
message from set_capacity_and_notify(), flooding the console and
contributing to soft lockups on slow consoles.

Switch the printk in set_capacity_and_notify() to
pr_info_ratelimited() so frequent capacity changes do not spam
the log while still reporting occasional changes.

Cc: stable@vger.kernel.org
Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9bbc38d12792..bd3a6841e5b5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -90,7 +90,7 @@ bool set_capacity_and_notify(struct gendisk *disk, sector_t size)
 	    (disk->flags & GENHD_FL_HIDDEN))
 		return false;
 
-	pr_info("%s: detected capacity change from %lld to %lld\n",
+	pr_info_ratelimited("%s: detected capacity change from %lld to %lld\n",
 		disk->disk_name, capacity, size);
 
 	/*
-- 
2.51.0

