Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22E64AA018
	for <linux-block@vger.kernel.org>; Thu,  3 Sep 2026 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440418; cv=none; b=f7QL152Zha42EwTNlgy8HTzsJyv8PwtloFiwp6XIcj+ZcteH7JMePuo4U0y6eN3GOlaJNG1dy6NUpWGih4iTfHBEJLSoxuMX13qp0hSEnhF5j+wb70wMrSLLBqC0HRX60IzgCkjwQeVt/nUm7p9nIRPnDPsuwn0JLdnuBSaDFLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440418; c=relaxed/simple;
	bh=06+qffQcwEwALMxBLy9dFemvnbiaogYHvKparT5EmWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cw1BnvrK3DiV8WdTOvJjUJF3wi/3HDQNW7kd0dWnlEF012wdY8joCnQB8SqIe8wfqcHPP1akinvQX7ADXxI7wIKBESIoKJD4oSm+bxuxX1Nm5sh2TStQn4NRXiORn54VHQriU42sv6Wil/+CRWskMCTLZqsfve1rZoMNMy+NL5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbSt71qi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbSt71qi"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8568e3ed034so1947092b3a.0
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2026 06:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788440411; x=1789045211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aNUKKLqZvrANPeHHYmjPL7ok/64poHS/mGT0EIbK468=;
        b=VbSt71qib43/2Tbef1LbeD/M8nDsImuyJRUhYtQTC6SWYMDYP0LR0xOxPnmuhhWgZv
         XU7P+gBE93KxjOsk0RT9majmDglzcbbPIDvaGkyvKCrIcOATUivGlMJVI3k85JRIB9ek
         yj9oNQgxUQxCw+zefldFKJSlD01AyBmlLsxa2czGCBipDZoqThrwPYZc+odDQdPScw89
         YyjaBDgpSiDybbByDYhNCL5a0OEEC7cYKSL5xPiaCxK+/R8STC/qpXpl4Zisi7+/V2zW
         caJOBEM6KIpsZr/8WvvI3rpnQt1GLfoE+JCKpUr7s6oAuZdDpidH4eMuTh0TJY59KpYb
         CTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788440411; x=1789045211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aNUKKLqZvrANPeHHYmjPL7ok/64poHS/mGT0EIbK468=;
        b=TgZIlplTdq+ady0hC64UrthA6dVmTgX5/5RmM2aCi/Kqq+f5Le6q+BCu43F5WHxXST
         y4o3YTUd931RdDPUjy9illMq79gwoQ40e4FOj+ZlRN4Vmy2hXgmIn+u+2bKdBpeHdtAy
         PicVabIFjBbMRQYdukjjxPwnkCgSkm8UMZM+n2pI4Wr1QakdUwzvdvfdGH6MbqT1x/z8
         kCvU46XCIo+1nH/h8NX8pJDb0rtOTGDTzPzlWuYE+a5kld+ZqWWGEoX4vL0p23+NDip7
         j5OlpW5e8QkK2ElfMA+JZrfqSr1YG05xnSGlWr3rvzdkW55XZ0YHtS0V6MXNbD1fIHsl
         uzFA==
X-Forwarded-Encrypted: i=1; AKwUvBwk/ntMWyZLAXKWAu/zyaraw2M4C1+l8cnBePlNkyNxKp2Wc3mNlT8Lnnxs5jTneAWCYpvDwWP1iB3+TQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kG87HN7rnRhd6BrpVvdd8vlzOOxZMjTgYbf9aiguGi+/ICK0Xe
	m7LatS8f0FPVe5b9TI/6Z3/v0GRrQOR+pWA/RpqKqF0+fyyNw476O6+u
X-Gm-Gg: AYBFou3an3tBs4wU5yke+6y+5/HqBE97WuzvKIJ3l6wFcH/ws6o8cv0ijXpIOpbc2lD
	6sujpRF1ia195Be5hJsyJnE71Hl1urK2v47J0JkbV5QkRrBmec7agDasg+bCil0fiAicr67cylZ
	HPDB+JJMTlILwt5tNl/rcBzJSj0hYowq+Ina3ALBkHi31C7+FzZ4Hj/4iv59nQv/64bBdhCjJOX
	DKqyDY+0+Ju7s2oLzm/c10M7fQ+PlKAAD7qrzGvrY6bB0XxHFxqvO+p0OzGDv2Tpm2+z6IYyrx/
	kIWCoHWSHwIHXMYFRimfF2jSyhwjJPG9jvnrB7WhJU5GWPpFBSdSs6rsNASldhO/+AzCyyuqJwp
	Ywzm5ywOG+7mrmy7a64ZINREFRjO2ygH/bwuzWctux6YlZHP4aUpXR4hsWEoB8e5nen7fuYPUbT
	ctfvdi5eIZ1QTFWA/8i8wZHn6/K4H2gLX5OXHXfvGWx2kod6EfUSKBt16c1ZYhCpnmwMrDseySK
	4iTDdC0kmDIAi05qnReU0/v
X-Received: by 2002:a05:6a00:1408:b0:852:3726:dfde with SMTP id d2e1a72fcca58-85ed25e2492mr15794500b3a.9.1788440410410;
        Thu, 03 Sep 2026 06:00:10 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db23f7bccsm2980946b3a.10.2026.09.03.06.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:00:09 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	jack@suse.cz,
	axboe@kernel.dk,
	tz2294@columbia.edu,
	baohua@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: [PATCH v4 1/2] f2fs: complete dropbehind write bios in task context
Date: Thu,  3 Sep 2026 20:59:52 +0800
Message-ID: <c4e69fb1ffd6c6fd968683c690ba29f2b98c9fa8.1788438786.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788438786.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Buffered RWF_DONTCACHE writes invalidate dropbehind folios at writeback
completion. Mark these bios BIO_COMPLETE_IN_TASK so the block layer runs
F2FS completion in task context when needed.

Use the same flag to keep normal and dropbehind folios from merging in the
IPU and OPU paths. Classify the original page-cache folio rather than an
encrypted or compressed replacement folio.

Keep the existing large-ATC completion path unchanged.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/data.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 21f396ebe22..b0fedacfd12 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -503,6 +503,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	bio = bio_alloc_bioset(bdev, npages,
 				fio->op | fio->op_flags | f2fs_io_flags(fio),
 				GFP_NOIO, &f2fs_bioset);
+	if (!is_read_io(fio->op) && folio_test_dropbehind(fio->folio))
+		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
 	bio->bi_iter.bi_sector = sector;
 	if (is_read_io(fio->op)) {
 		bio->bi_end_io = f2fs_read_end_io;
@@ -793,6 +795,13 @@ static bool page_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
 	return bio->bi_bdev == f2fs_target_device(sbi, cur_blkaddr, NULL);
 }
 
+static bool f2fs_bio_dropbehind_mergeable(struct bio *bio,
+					  struct f2fs_io_info *fio)
+{
+	return bio_flagged(bio, BIO_COMPLETE_IN_TASK) ==
+		folio_test_dropbehind(fio->folio);
+}
+
 static bool io_type_is_mergeable(struct f2fs_bio_info *io,
 						struct f2fs_io_info *fio)
 {
@@ -985,8 +994,10 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 
 	trace_f2fs_submit_folio_bio(data_folio, fio);
 
-	if (bio && !page_is_mergeable(fio->sbi, bio, *fio->last_block,
-						fio->new_blkaddr))
+	if (bio &&
+	    (!page_is_mergeable(fio->sbi, bio, *fio->last_block,
+				fio->new_blkaddr) ||
+	     !f2fs_bio_dropbehind_mergeable(bio, fio)))
 		f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
 alloc_new:
 	if (!bio) {
@@ -1086,7 +1097,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
 			      fio->new_blkaddr) ||
 	     !f2fs_crypt_mergeable_bio(io->bio, fio_inode(fio),
-				bio_folio->index, fio)))
+				bio_folio->index, fio) ||
+	     !f2fs_bio_dropbehind_mergeable(io->bio, fio)))
 		__submit_merged_bio(io);
 alloc_new:
 	if (io->bio == NULL) {
-- 
2.43.0

