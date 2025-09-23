Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2341D33987
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 00:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587634; cv=none; b=u2JrDBjYJ5U27KiuURaAUOLQHJb1Z3iUL8rCqiypmz++rd0VaL9ZI+urIjD6gm8h8fpGPElaTq+kmqPUVHKeKlkKzwpyLDZ/QB6P3qT6VK/shuzTaf9U9AuJsi4cngHNugcch2skmiNb7vZ/+bXFdDg8DsyzxNeWxpa/L1Dfm8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587634; c=relaxed/simple;
	bh=YgKyI+7nvFJd7hF9+aOKln99TqNiUDSyfSYZ4a5+f8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ob92KLZ2fqfI03muKyvaQPn06UHXjhDmULL2sVzeTx8vcGU8cq3ROrMurfHInTvNISSX9w68NQ1CP0G9ycUaTj6YzD4wD6/T4/oL4kr4PGZk+vjX6uP7cw9q0EtT1Vxbd6Q6WtbT4f6gg7yzeq+I6ZmN6KI4nz/YtTqen4a2CHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpCH/Kw6; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpCH/Kw6"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77f2a62e44dso2730530b3a.1
        for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 17:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587632; x=1759192432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Va/XHzY7dGCYy7r7QsvJz2VUIfq4Rs/aAgdBGRW34/8=;
        b=lpCH/Kw67v/yC4Hys4ko6NqSXFOS9qYxIyo3SlsoDJvJ5dnlLQi3+2TKKjFKTXg7bo
         EVdsKfboB+kFU6Tz4G71I00b8AEn2QxRxsQpJp7sRfooVAzLHQtKtjE1G8buwnxFLNPP
         GwzxUm7FUe2NaUR8qVvyui6Sphyf6/OcE1UlDpyeMUm7qrmJpt5LFnLxwlxKc/8P3JBv
         OpbbeQKbZ+nnAORG8NHiXo9EMt1XNvZCEFPr6gzdzOelzhzP+zQpIxyVkG9bopgpqLsD
         /GKoNLk8RLFBSd3tkjeCO+fDCabscSoanh7t/AReaiGarHRw+52+u4kJuJJPuqg1XKpk
         ysUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587632; x=1759192432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Va/XHzY7dGCYy7r7QsvJz2VUIfq4Rs/aAgdBGRW34/8=;
        b=oWtqrz7+t6HBHmb3G39mV6rHEkCL2I93s+h4i3LUNQBm+EQK4p3EVQPhsPJTP2r/X5
         9wNUrkUUi0eguHIk7oxcv0OIjTae5X9jw7jhvtvQ5gl5D+f2Zg4sYdSmfH8UZTHH1DQO
         hMg95lWHvOi4GFBIG5SljjIFcBSbX8dbZ4ni3ufGUAoI8wGbQvLRfxtylHqmCeQdMJ4Q
         IsTi2ZzRO5yvxuib4WZt/v8MbVRsKSeFIxfdoq29lSXCa4CMFVtTpm7XCBKMRozS2P5G
         rgeFwpV73fldW0kiqFVUwDmccMe27WNIrNkl9VjENMWYIYwzdhxwgN9qkCGe0oCkLGkR
         GBgg==
X-Forwarded-Encrypted: i=1; AJvYcCXDDOLxwoKsjxTRxIhBkGb6tRLL31q/EUAC9sXR+Qjxusd/LFlNiP2vdqTitLqwhCLoCDtZcBUzw3u1+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIIuYO4B0uEFa0a6N8mXCm0vgZwv4lC+3m2G9MdDyGHfKq3WTH
	vD0/fD/T32EqwlUFJd0nTiFe3fkEYrMR5L929/j12bBbPVWDR823l3HZ
X-Gm-Gg: ASbGncuU7tqogY1/rOnKXhddk2vmHkgzYjqWN15/dODceJ/2J5NoFwwelQXj5T/hU76
	XfHPB+T2xwX26QqzfpFaqXYUVkbfiPqxyezXfCesQgp3aQzpHFiikH+mxLUCZmLNHkOlNa1YII3
	2zM+CerSnLCZwDkIJgmHgIkJbNFOcixrnwisIc8Rx5cCMrKBTHyxaW3LMBWjFTS8P4T8fDL9tR1
	gjAX6lTVSSA7m+jt/WQDTBwSwUj/BKOT4ys06l0SfM2VZqMMCRHgg0FmN/Y6PUTTGAx4VUgck3b
	ydCuquq0a/6E/G+pSp/DnHnqSdfTsU4bSI63uWy2r7WmAeHgajf2yovce0LcVLc1q7LMlbwX3C9
	aggi3hHaZf1D/yefIVXZxi3mLM/dvtRzpDTTJQieQ4sZjzKTk
X-Google-Smtp-Source: AGHT+IHlZzmKAgOiJJH7iK2X2/0Mv1ZhYzEaMZg9FO5iReuXqZG+EqKn8QCxkD922bYIKmzkhhTsog==
X-Received: by 2002:a05:6a21:3086:b0:2cc:3e8:87f9 with SMTP id adf61e73a8af0-2d02084f104mr1034082637.59.1758587632427;
        Mon, 22 Sep 2025 17:33:52 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f188dd4a8sm8187594b3a.39.2025.09.22.17.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:33:52 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	hsiangkao@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v4 00/15] fuse: use iomap for buffered reads + readahead
Date: Mon, 22 Sep 2025 17:23:38 -0700
Message-ID: <20250923002353.2961514-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds fuse iomap support for buffered reads and readahead.
This is needed so that granular uptodate tracking can be used in fuse when
large folios are enabled so that only the non-uptodate portions of the folio
need to be read in instead of having to read in the entire folio. It also is
needed in order to turn on large folios for servers that use the writeback
cache since otherwise there is a race condition that may lead to data
corruption if there is a partial write, then a read and the read happens
before the write has undergone writeback, since otherwise the folio will not
be marked uptodate from the partial write so the read will read in the entire
folio from disk, which will overwrite the partial write.

This is on top of two locally-patched iomap patches [1] [2] patched on top of
commit 8a606bb102db ("Merge branch 'vfs-6.18.writeback' into vfs.all") in
Christian's vfs.all tree.

This series was run through fstests on fuse passthrough_hp with an
out-of kernel patch enabling fuse large folios.

This patchset does not enable large folios on fuse yet. That will be part
of a different patchset.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20250919214250.4144807-1-joannelkoong@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20250922180042.1775241-1-joannelkoong@gmail.com/

Changelog
---------
v3: https://lore.kernel.org/linux-fsdevel/20250916234425.1274735-1-joannelkoong@gmail.com/
v3 -> v4:
* Rebase this on top of patches [1] and [2]
* Fix readahead logic back to checking offset == 0 (patch 4)
* Bias needs to be before/after iomap_iter() (patch 10)
* Rename cur_folio_owned to folio_owned for read_folio (patch 7) (Darrick)

v2: https://lore.kernel.org/linux-fsdevel/20250908185122.3199171-1-joannelkoong@gmail.com/
v2 -> v3:
* Incorporate Christoph's feedback
- Change naming to iomap_bio_* instead of iomap_xxx_bio
- Take his patch for moving bio logic into its own file (patch 11)
- Make ->read_folio_range interface not need pos arg (patch 9)
- Make ->submit_read return void (patch 9)
- Merge cur_folio_in_bio rename w/ tracking folio_owned internally (patch 7)
- Drop patch propagating error and replace with void return (patch 12)
- Make bias code better to read (patch 10)
* Add WARN_ON_ONCE check in iteration refactoring (patch 4)
* Rename ->read_submit to ->submit_read (patch 9)

v1: https://lore.kernel.org/linux-fsdevel/20250829235627.4053234-1-joannelkoong@gmail.com/
v1 -> v2:
* Don't pass in caller-provided arg through iter->private, pass it through
  ctx->private instead (Darrick & Christoph)
* Separate 'bias' for ifs->read_bytes_pending into separate patch (Christoph)
* Rework read/readahead interface to take in struct iomap_read_folio_ctx
  (Christoph)
* Add patch for removing fuse fc->blkbits workaround, now that Miklos's tree
  has been merged into Christian's

Joanne Koong (15):
  iomap: move bio read logic into helper function
  iomap: move read/readahead bio submission logic into helper function
  iomap: store read/readahead bio generically
  iomap: iterate over folio mapping in iomap_readpage_iter()
  iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
  iomap: rename iomap_readpage_ctx struct to iomap_read_folio_ctx
  iomap: track read/readahead folio ownership internally
  iomap: add public start/finish folio read helpers
  iomap: add caller-provided callbacks for read and readahead
  iomap: add bias for async read requests
  iomap: move buffered io bio logic into new file
  iomap: make iomap_read_folio() a void return
  fuse: use iomap for read_folio
  fuse: use iomap for readahead
  fuse: remove fc->blkbits workaround for partial writes

 .../filesystems/iomap/operations.rst          |  45 +++
 block/fops.c                                  |   5 +-
 fs/erofs/data.c                               |   5 +-
 fs/fuse/dir.c                                 |   2 +-
 fs/fuse/file.c                                | 289 +++++++++++-------
 fs/fuse/fuse_i.h                              |   8 -
 fs/fuse/inode.c                               |  13 +-
 fs/gfs2/aops.c                                |   6 +-
 fs/iomap/Makefile                             |   3 +-
 fs/iomap/bio.c                                |  90 ++++++
 fs/iomap/buffered-io.c                        | 259 ++++++++--------
 fs/iomap/internal.h                           |  12 +
 fs/xfs/xfs_aops.c                             |   5 +-
 fs/zonefs/file.c                              |   5 +-
 include/linux/iomap.h                         |  65 +++-
 15 files changed, 524 insertions(+), 288 deletions(-)
 create mode 100644 fs/iomap/bio.c

-- 
2.47.3

