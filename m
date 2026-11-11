Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379628;
	b=XrZQZ40a5k3s2ePcngBbAcAEREP6UCER5EK/WnUY5kq2qDh6rH3glSNusw0h/XB2jwue
	 ACU9VJUJihrQ2yZpx27R9sr7wKfjUenjKdlk2+hokdZcO+je8IzWCx6UJP0Qa7Pos1EV/
	 X13KzwunjQv+NgCxzUPzOEjThCOC808yLVu7GyDokaXM+OdIV32b4Hl/OFXg3MWAfGzUz
	 wzVTT6XuAtDHLSkAx2nrEQOcR/onZHDNo/h/vlXmCKvsxFqHxorZ2VWvgkNjM/rKJh3nt
	 BEBlgSKcBo+Qgz+yZEhv03rjN/nqaCHpVmODawN7hH/N/upDrxgzLu3yXX1N4454+Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379628;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jkuvQWeb+HW4Y4pz1WYjjKD3eYhvVBj62Pvn+FtH4Q0=;
	b=2eFywH32GpS0QEoJJP5APXiExJFyj2W3yZU43Zo/kD+PHCQ2eVU1Hf6vIx0PszscbF9c
	 rcn+0lvoVxaTcV2kSzbuZI1Im6u/lkNxqCi9tJdxlcu94SgnnFtAIdYMbXZC6e2Xnvf86
	 SWhsuxtuE8cwn7IMqq1gC6KrIl90SkgMS7t4YVCBPhvxAhprBcf6V1/PJ82YVOPGYQL96
	 ygi7JjSLfpsKUT9+ODrqLX2DgAxt/Hxyf1zmyQL9yyIYB7CMOuOnUA1kohMrNV+c5j4cQ
	 tRDPqDKcL+8g5C2+EPuI+C7of/2noGzqnbWYCkgkp5XwFKKK6fuchkJODU56A7j6H+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=MLPQpuXR;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F73606A320;
	Wed, 11 Nov 2026 06:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75F73606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=MLPQpuXR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=MLPQpuXRH6ZvJbFXrg+L1aZmwwkCkFJ3nLiL0azp4W6oO7d7/XXPcXEeEAcjPStN6fdO8ThgKMt70
	 Lydp4pj1QP+tfDc7A889xeQ2zf9OvuffqUkftcWtfecpbxyjTxjmmZ3VeFJ3GgNyQYlkkvll9wgtcr
	 nLtONevsRhmBVhBw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af40f69192-7502d;
	Wed, 11 Nov 2026 14:47:06 +0800 (CST)
X-RM-TRANSID:2ee46af40f69192-7502d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af40f68770-d1961;
	Wed, 11 Nov 2026 14:47:05 +0800 (CST)
X-RM-TRANSID:2eea6af40f68770-d1961
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+5d380c3d6727a9581fd4@syzkaller.appspotmail.com,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] block: annotate the approximate block device page count
Date: Wed, 11 Nov 2026 14:47:04 +0800
Message-ID: <20261111064704.17144-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nr_blockdev_pages() holds the superblock inode list lock while summing
mapping->nrpages. Page-cache updates use the mapping's XArray lock, so the
list lock does not exclude those updates and KCSAN reports the read.

The total is an approximate memory statistic. Annotate the intentional
lockless read with data_race(), leaving page-cache synchronization to its
existing locks.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 block/bdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index f20f91b3176e..cae291d4893c 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -564,8 +564,10 @@ long nr_blockdev_pages(void)
 	long ret = 0;
 
 	spin_lock(&blockdev_superblock->s_inode_list_lock);
-	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list)
-		ret += inode->i_mapping->nrpages;
+	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list) {
+		/* This is an approximate snapshot, without the XArray lock. */
+		ret += data_race(inode->i_mapping->nrpages);
+	}
 	spin_unlock(&blockdev_superblock->s_inode_list_lock);
 
 	return ret;
-- 
2.51.0


