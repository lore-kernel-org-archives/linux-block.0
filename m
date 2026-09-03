Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152BE32F764
	for <linux-block@vger.kernel.org>; Thu,  3 Sep 2026 02:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788401395; cv=none; b=JK3NiHfMDP7M7JegxvSaaDb4djNUNFCYmSBvxicQ+j/9zVz3hnaiSrTKz6abvmd/PZfmEv9VPkfAksiE8C/pPhFcC/wBB+ve6LSeyeyDqsbl6/VU2F7zSEklQhcbh10oywlbJdAJVvIXq/yPP2Slh3j4527ms62PvNrpDi+UvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788401395; c=relaxed/simple;
	bh=94kJM0CGMA3CGbfIpLlEPghK0mnhcD+knhs6qcR7Om0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cVO5tps9Fqh9Q/z+4yhbWDF4ly4UmAmS/EJ0aJtmY7hd5BY8oebvHXZZWy7bLfVCs3TuQ31ZC+wXgft0LolifI7ylzg1NC+sJWs+xhdFEoiMb21c97udN77oBKw222iD8g8VWYcHgSShpDy7VFOTAGbMvd1ZjozKl3ElaQvyNOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsTBh7AV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsTBh7AV"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d715f4a587so27593725ad.2
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2026 19:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788401393; x=1789006193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xXWZQGX2IRpUhasiZLHJhXX71kDpLGpLEL+iB+A8DS4=;
        b=hsTBh7AVgFwHjF0mfzdsfhY3aPFSVUzeOfb6y1BWFGeXOR2BU19uChYPmkG6deN91w
         BjoX8H/dWwHHNmOYWtTsmLb22Gwe5LNnsZrzNTC3ptgk+fvuI2xwbyNAJYPjfDZNyG5R
         MKEjAIFBMGJQrcngskN7KCs0UgSvVhD9IjoUO0Anb/fVFEmJ7UJsBjoOD6S3fLZ7ZMx3
         PlxTo6L6gDyA4mTBYil3q6UlyDuFvY8r+DwccH+OPwQkfZ1845DK8DC4DU9DuR+G4QaW
         vSVphyLDpJlvxM62spmExwTMpMeRvRhx2LEpwaxicbilfheJ8Kg7vqO//SbMnZ/+TVhy
         rtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788401393; x=1789006193;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xXWZQGX2IRpUhasiZLHJhXX71kDpLGpLEL+iB+A8DS4=;
        b=TG6sIaK4TkX1CTxzwaMSi08nGYX7urNbML4zlglD49hlENipc+xLiGjN9hBPPeNQeX
         lI6Kiti+2kkMwOALPiQZTZAGaTZj1joklffAAFyD0FdCHpwSNphHq/oKp7O1rACR452s
         W7Qyc4JqOCRpHUe6kVK1g/5bCHHhnUvy85oqPDeSUpjuGH2JWzrsSBNEluVSoYCKxVy/
         3HrltaYVMr5HO/zInL9QGfNAAwLWccw+l7BZYxPQdaVnMlXCN/PNuvWFaJtiYmBlMnkI
         kB0TcoiB9PP8bG4A6bojl6zZl5WjhetYqJ6XQQvZeST4kGbbg61OaVyD60GkABSyP5Jm
         vGOQ==
X-Gm-Message-State: AFuF++nm6Z76bvpZVnUu8PlCYHYK4yXEdz1ugCI6Ej60W854+y640xFc
	BLKHH8dyaAVhxG8nz+imnKrxiSRCrdjQnwk138UukAANMMF+XcQmqdc0nA1olSfY
X-Gm-Gg: AYBFou2r9A9AxJJSj2ntchEDOlYvipgSlL5k+ptABt5Wt+SG6ivYNtIWRwG0yMKB7BV
	3YJCtC859J92ZrD56FWXlyjCG+KtHx3H835HvwYywNb1TZXm7s9ASqV7+egFQCB7F0edh1BiNyB
	PvdVZV4/0LcaRIwFeNESexFQrY+xMhmiizBrSQvdPhSi4Pr8fSuHI1Oz+Kx9rDRCzuJ9f79OiUe
	OQnkzvjKoXJ9+l+zyYkRmJO6BztiGoxbQpR75LD3ERmjAUIGxF+LZokCwUt/3+c6V2fBLkcI8Sd
	vJg4xSJN/U9Va+S+xux0Hw/6GBK+beK+BA1U2JZjTKdWTsMnU/TQcBBcKrA9g9iIODNznVnmc6Z
	ZwDnMfkNLsuMlsOnbl2DhKX5hfPdy49uSAQKt9LCduez9o7UlyNkKqPkL2e0/QMoUBgQXiAPpxV
	8giOq91XyKBG+LLuaW3tK//BXH22fxRX0gBowMfIF2Nv/RbSV2F4uUyA==
X-Received: by 2002:a17:90b:3d89:b0:398:deed:6e1d with SMTP id 98e67ed59e1d1-39aedf89bc9mr13978891a91.5.1788401393336;
        Wed, 02 Sep 2026 19:09:53 -0700 (PDT)
Received: from unix.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14319922eb4sm1705721c88.7.2026.09.02.19.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 19:09:52 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH v2] block: loop: restore backing file state on loop_configure() failure
Date: Wed,  2 Sep 2026 23:09:48 -0300
Message-ID: <20260903020948.47045-1-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If queue_limits_commit_update() fails after loop_assign_backing_file(),
restore the backing file GFP mask, clear lo_backing_file and lo_device,
and re-enable uevents before unlocking.

Scope the rollback to a dedicated out_restore_backing label reached only
from errors after the backing file is modified in this call. The common
out_unlock path is also used for early validation failures such as
-EBUSY when lo->lo_state != Lo_unbound; in that case the device may
already have a valid backing file that must not be cleared.

Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
Changes since v1:
 - Drop the brd xa_destroy patch: xa_init() does not allocate; there is
   nothing to destroy on the blk_alloc_disk() failure path.
 - Fix loop rollback scope: do not restore from the common out_unlock
   path. That label is also reached for early failures such as -EBUSY
   when the device is already bound, where lo_backing_file belongs to
   the existing configuration. Use a dedicated out_restore_backing
   label only for errors after loop_assign_backing_file().

 drivers/block/loop.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6f12976035b0..aec7fbad1903 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1085,7 +1085,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	/* No need to freeze the queue as the device isn't bound yet. */
 	error = queue_limits_commit_update(lo->lo_queue, &lim);
 	if (error)
-		goto out_unlock;
+		goto out_restore_backing;
 
 	/*
 	 * We might switch to direct I/O mode for the loop device, write back
@@ -1122,6 +1122,13 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 
 	return 0;
 
+out_restore_backing:
+	mapping_set_gfp_mask(lo->lo_backing_file->f_mapping,
+			     lo->old_gfp_mask);
+	lo->lo_backing_file = NULL;
+	lo->lo_device = NULL;
+	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
+
 out_unlock:
 	loop_global_unlock(lo, is_loop);
 out_bdev:
-- 
2.43.0

