Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0934D4A99CB
	for <linux-block@vger.kernel.org>; Thu,  3 Sep 2026 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440425; cv=none; b=FNMPI90eHH0Vv9Q2CTjL4TXR09Weiq0Z2o3qYVljJz4oX79H2yGmhZWGVc03HNysIK4Sncae+r2o0Bk19NSDPAfMgQUKQ/NEwO4nRnxp7t/GapdbtzfEmhoGuFqJV8JcYAn1Gk+V3Mol4ZJ8+g7ArkVbwrnGJarhvWDRECa92Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440425; c=relaxed/simple;
	bh=jIu+OlxanokFLSfiquBpo8YXaj6PW7O81zppVlD1xwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONcOh0JvFoNFzyH4tCuMmE1gkNIlCnQ0yN/OdrO2ZG/hY8X5r1/5mEp9UfI6A/cy/QYky9f+9ik6zPg+qI5azUf6yKAONMh6lwb3U+z0XaGkgZg86KnlfNExBo0L6Sd6yjI0txdirmrHeezS91liVSnWVyVSdQAN/h0srFPn5Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mma0Uzwk; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mma0Uzwk"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-85339ed040aso1924525b3a.1
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2026 06:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788440419; x=1789045219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A7QKH2r7d66SxSFJm8bjz6ZBcyuRFjzyujOBEDXlc4U=;
        b=Mma0UzwkG8xdTwfb5jJvwaqAGSgzGlon5iJSbIfZHE7aOiBS5BkrAAGIdtXw+ZZnJI
         bsMOnhT/8Dt4ESWQCNeabTfU6DJH6nDwYZfiAbp7doDCbdly05zXPw6Mt1DbWq2x168p
         9t1vu0CxqB8uhPQxRQIhW3U1HACEsgRD3FD5aJE8X2l+8uWcY2uCpTDO3BwkB4//R3Wk
         V8shx2IszUFho3C+p1s/mM5TpAxsN25aw6jXfKPxE1McPCSR+1BQmgFI0HvqEmQYf8Qg
         b0dkYmFG4cSwWOAJdxd6OKyj9gUYQlCEnCykWDfcgGTpYasySjS1TVHHgLGYtloWzShM
         EZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788440419; x=1789045219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A7QKH2r7d66SxSFJm8bjz6ZBcyuRFjzyujOBEDXlc4U=;
        b=nRtRQXC/YY1hWOyx3Uka0fh754yCc8iFuQ/3iyRkclnEHcMKFwalUIkHzAWIrmRkQu
         MIlon5fpFZid9fa5FajnYAHdXwLU4zA3WFr+dcGgCE6SBrRHmdWLA7cF2Yms46N90LDW
         8YcchH38181qezDHxzWbh1dt+0KyZNo6YEnh7MByScA6J6km/WfqqCDuVuuNMeaTFOTu
         TK6mjiYN9whe//Ttpkzcg+OB0OrCpX6alTpyRLN4+qXINQo+rYMbntCJ2XCnKDAAmgZy
         PYNLbrhOYhkYv7f3vQuTD6wFiiO83bkHixxFEnnqFKX8GJ4nxYFNY4VHl8OQBjyDt92Z
         jMeg==
X-Forwarded-Encrypted: i=1; AKwUvBxC+M41RBp5T6/o0szI3z2zcW2I4akRZ9jkjxG4Kt+bfj130MVcmawuBZpUpM2Vul9jRBIUnJsFRmhWEQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nAqJeZGuC8zPPINW2FiFa/yLCoqTs/B3EINsV8zcUPUoMVXU2O
	nYXYgizgr5Js66X+ArF0SO+3TRPupImGvgpOBF+qADYy1BvbNKqkhwQs
X-Gm-Gg: AYBFou3cuANChjG0Qv7bsZZNEF8nFbPg2LQ/ViRW29DQuD4LpKhbZHlk5QFbEGg/6xs
	q+4TNGSIWCfht2EUhtKTc0XMHEofZd874zp04oo17LcppH26J0g63vRPMAkMLgk/aV+FqxQq65i
	shIWYa5AFafSM6EvkWD8SgLF8my8/lWfMGacu5scNKzwHl6j4nFgbd3izfzlXsfI7Z3OROk8MPp
	+H7efKZvR3+coTanoChepr4ahRiu7/evwMw+R+ZIF+zLfFL0GwkeTqXQalQGH8B+KiBudMvA0pH
	qyu3ljKePkhtpOJToTPOFGUUVnat5wNT5/IqOf8BAd6183y/cmCdjibRiqsIesIWABlUS7hOarV
	bRV2RST3J65lYJDb4Ck+x/c5dbzvbbExTAAykT7BgVkpO8wxG4XIcr/MEOEqGr2/6Nft+8K/THc
	n1/7H5UVv/Mi4TQ6uyaRYnUVv94nGrqqFZ2fya1/WIfzZnqgc2TtRxgsDN5Cwq66h+NU5Jsidlx
	OewxZGenytIicesh0O/L3tv
X-Received: by 2002:a05:6a00:1a0d:b0:85f:4255:59a8 with SMTP id d2e1a72fcca58-85f42557303mr14081961b3a.10.1788440419002;
        Thu, 03 Sep 2026 06:00:19 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db23f7bccsm2980946b3a.10.2026.09.03.06.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:00:16 -0700 (PDT)
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
Subject: [PATCH v4 2/2] f2fs: enable buffered RWF_DONTCACHE
Date: Thu,  3 Sep 2026 20:59:53 +0800
Message-ID: <cd5bc4fbb9000e5936dfc96e97ed1e8ab94d0a94.1788438786.git.qiwenjie@xiaomi.com>
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

Pass FGP_DONTCACHE to f2fs_filemap_get_folio() for IOCB_DONTCACHE writes
and advertise FOP_DONTCACHE.

Keep the F2FS-specific lookup because write_begin_get_folio() adds
FGP_STABLE, which can deadlock here.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/data.c | 9 ++++++---
 fs/f2fs/file.c | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b0fedacfd12..6e816c9349a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3884,11 +3884,15 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct folio *folio;
+	fgf_t fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT;
 	pgoff_t index = pos >> PAGE_SHIFT;
 	bool need_balance = false;
 	block_t blkaddr = NULL_ADDR;
 	int err = 0;
 
+	if (iocb->ki_flags & IOCB_DONTCACHE)
+		fgp_flags |= FGP_DONTCACHE;
+
 	trace_f2fs_write_begin(inode, pos, len);
 
 	if (!f2fs_is_checkpoint_ready(sbi)) {
@@ -3934,9 +3938,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	 * Do not use FGP_STABLE to avoid deadlock.
 	 * Will wait that below with our IO control.
 	 */
-	folio = f2fs_filemap_get_folio(mapping, index,
-				FGP_LOCK | FGP_WRITE | FGP_CREAT,
-				mapping_gfp_mask(mapping));
+	folio = f2fs_filemap_get_folio(mapping, index, fgp_flags,
+				       mapping_gfp_mask(mapping));
 	if (IS_ERR(folio)) {
 		err = PTR_ERR(folio);
 		goto fail;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index edc352569e8..570244ae4fc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5909,6 +5909,6 @@ const struct file_operations f2fs_file_operations = {
 	.splice_read	= f2fs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fadvise	= f2fs_file_fadvise,
-	.fop_flags	= FOP_BUFFER_RASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
 	.setlease	= generic_setlease,
 };
-- 
2.43.0

