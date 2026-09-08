Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2DC35C1A9
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 03:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788839768; cv=none; b=Sor9kpd9w19ip8ssgRS9c+sSFfbvhegXdWMWXapZU4uPisQqbgzHOEOD+OSMKTas92FCLzvtH4KFjB1CzSUvokSudbDInRhURWI7P2RVzwVs0+zzcZtDS3/Yj24VgBrgL8S8HLYrtjSDO79BK4bXc3dbt7yrTWcuwjTaHVXH2fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788839768; c=relaxed/simple;
	bh=RBvbdSUWh16JJLqlFGtsMwqalG7QCueBbVn0MBj5kWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBh7EhDlkuSqeE3eSqR7K4uqKqxI2yRSZXWKUYzvdFjaUW7rQJuJ//EICxaQGEJ6SftI32hEjYOfZkKkeEU7mZRbeh/UOEgyxjptYStT6+2xIT15cQvlmXzQeG86jlvz4PPetN6PFce+I8dj0hts9/rRNhyeYblDCuG/APGUbYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZPraXxV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZPraXxV"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d01663d816so28575735ad.1
        for <linux-block@vger.kernel.org>; Mon, 07 Sep 2026 20:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788839760; x=1789444560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sz3IhUKKAL3B7/uUvafH5XnIQ+JFZCBkf/MrLLBgC8M=;
        b=dZPraXxV94vP7nTEhBlS+wQ0CvfXzjLxc4HB3HMoBDgRDk4hDXbB2Gvm92PSmYU1Uc
         hjcKBy8V/Nz/6MfWzxt7RnfK1l7AO9vsChwXJLMPsJV8xnlQOS6YmHSncymXBUwmi/DK
         ufkWtEanLHKC/k7QEpaFHcLe3d3edhfCSkgjAzlQ8dxgX6elGxeaqk/xEruOuRL2qK5L
         id5GuvWsEmTd95T6Rh2Ehi6LTimkZwSzuQs2EaznnkOr7qLUexiYMB/JZ5ZGYGZJm8QL
         wpY96pdEHF50foeckDYosFJC9eSsv8BCoIPrwmIhXCtzcxc1DKj2/XoO6bAJzBBcIqUo
         85qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788839760; x=1789444560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sz3IhUKKAL3B7/uUvafH5XnIQ+JFZCBkf/MrLLBgC8M=;
        b=HfncgR/3MjtyvHj4g47JFVDSDbrBl9rAvPrOTrzaupXYjPsG2ySeWY++hKaZB8OkBJ
         tiQ2l2r/AyaeP5M5Bxl+kSDziyjUakyxqNW4KA1SzvmgXdvNDgNjlbEtzCdnX2ittamp
         fhmPTE0G4n3CBAM5HLL0A4RICkY+/b7oME2It0IFfs+a/EvE2ooikJPLpUMC/ECyFCdC
         7G/DqjCpnqrwl4gn9+ySHSXpWQQPIA35XgMH/Yuyl+5C2M09L/sN5ockG16FMLn+5Gry
         MfOOvMMVMOG1z9nPyMeY2Ei52xBSeVbKW1yfPhN9q4xDyJYjnoA+BE4VnYkOPfD55GFJ
         2X+g==
X-Forwarded-Encrypted: i=1; AKwUvBz6AlyPYhRo1J7yOB/MYU5316NEbXiI6OzfZsydTVWsjAuDbQGeKUQ8uNiyZ9hiRgnSYh/2L7mH89CyLQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mhawLqUgm6DfF9lEM9yS3siv8iMno4LdrVWID/osesMkH6u1Kd
	IOuF6MOPoVd5/TCfIxscWc75s2rwUmgVqRioEkYNbWw20mQEmlTnQj44
X-Gm-Gg: AYBFou05los6NeHguEw68vOFjT6g3npJJMcTu3FtPANzKyprVnLBRgd22h7/rr5Qo/B
	KIKSfQvmGtRcm0JHpHa7TbzTPrLFCJrglPybtOWv+Zdk8YmdfrhcXNY4Q3RIxG3o8pwLzSJgom/
	LwL7s64BHE/5W5RKaKi41cepSt8BbAumsLaC4c2FdYauEKxvkLvqmXuADIjZwNrp4hPeJ6ebjmu
	08BCmGDOUuVaM84/ij6+BeJAx548ht1qj6AeXeaZH7oPfme/1R4jznsFwuFdSB8+zwWFng5Mt9Y
	rHdDymoctb7AewY+C28xUBwHhjSldTNHvt2MIrsd4D5YAiqEqMmZqp/UY8u7VdXUd12kbrJbezS
	iAGtCEjk8gzBWZIdhgDCtvGERmhulM3eGwz9+H/0hPV75e/K+lX0JTdEwqR8B3GBH55FSnZTKG4
	CsJmxsUrhWNOs8iXiOBRTnptK68E/u43Z8/YnFY2gJ+74Veszu0hb+gh32SSiFCwfViLpV6Rc9M
	x4K+9+WFL92ik+Qg6SA/Im9PlGtg+mtzGE=
X-Received: by 2002:a17:903:22c8:b0:2d7:5ebe:a588 with SMTP id d9443c01a7336-2db126d6e31mr380270745ad.13.1788839759881;
        Mon, 07 Sep 2026 20:55:59 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14aeaf74sm51899295ad.81.2026.09.07.20.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 20:55:59 -0700 (PDT)
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
Subject: [PATCH v5 1/2] f2fs: complete dropbehind write bios in task context
Date: Tue,  8 Sep 2026 11:55:42 +0800
Message-ID: <a3c3c000656d3655512c979d2b0c803ba4ab2f99.1788795700.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788795700.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com> <cover.1788795700.git.qiwenjie@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Buffered RWF_DONTCACHE writes invalidate dropbehind folios at
writeback completion. Mark these bios BIO_COMPLETE_IN_TASK so the block
layer runs F2FS completion in task context when needed.

Normal folios can safely share a bio that needs task-context
completion: they do not carry the dropbehind flag and are not invalidated
at their own writeback completion. Follow iomap and allow otherwise
mergeable normal and dropbehind folios to share IPU and OPU bios.

If a dropbehind folio joins an existing bio, set
BIO_COMPLETE_IN_TASK after the add succeeds. Classify the original
page-cache folio rather than an encrypted or compressed replacement folio.

Keep the existing large-ATC completion path unchanged.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
An F2FS QEMU A/B ran 80 untraced 1-GiB formal cases: ten
counterbalanced pairs for each OPU/IPU and 4-KiB/64-KiB profile.

The primary write-plus-fdatasync mixed/segregated ratios were:

 Path  I/O       Mixed/segregated  Interpretation
 OPU   4 KiB          1.133       Mixed was 13.3% faster
 OPU   64 KiB         1.021       Mixed was 2.1% faster
 IPU   4 KiB          4.469       Mixed was 4.47x as fast
 IPU   64 KiB         1.063       Mixed was 6.3% faster

A separate 64-MiB IPU/4-KiB trace observed 16,384 segregated DATA bios,
all 4 KiB, versus 117 mixed DATA bios with a maximum of 13.21 MiB. Deferred
bios were 8,192 versus 117.

Changes since v4:

- allow normal and dropbehind folios to share IPU and OPU bios;
- set BIO_COMPLETE_IN_TASK monotonically after a dropbehind folio is
  successfully added to an existing bio;
- add focused segregated/mixed QEMU results.

 fs/f2fs/data.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ebb0275aa8f..fc48a752fe9 100644
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
@@ -865,6 +867,8 @@ static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio,
 					fio_folio->mapping->host,
 					fio_folio->index, fio) &&
 			    bio_add_folio(*bio, folio, folio_size(folio), 0)) {
+				if (folio_test_dropbehind(fio->folio))
+					bio_set_flag(*bio, BIO_COMPLETE_IN_TASK);
 				ret = 0;
 				break;
 			}
@@ -1100,6 +1104,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		__submit_merged_bio(io);
 		goto alloc_new;
 	}
+	if (folio_test_dropbehind(fio->folio))
+		bio_set_flag(io->bio, BIO_COMPLETE_IN_TASK);
 
 	if (fio->io_wbc)
 		wbc_account_cgroup_owner(fio->io_wbc, fio->folio,
-- 
2.43.0
