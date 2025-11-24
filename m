Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84C29E114
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 02:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763953073; cv=none; b=j4CBA4AMoT7vQIf7SuCNZRQOQ3qKpqlSQfSwjs+HIIyhZ9HwJeslWISKf352z13HD+WokrNcsjutzNFz18aPlrEq+05XmOutksbKzjs263ToQZLYxqo2HAUg39sbr3b3fwUyELCjhhYw1016xaWZ42P+pXQ+8Sn7TnnC3OfL/hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763953073; c=relaxed/simple;
	bh=rrj2tkBOa+tDueLpfke1EhQT6rpNTZ2snUg0Jqjwd8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fVCxdpoEOwW3QiKOJjyvefb2Hds9zUFa0fAzg5tRyZrPpkN+JTNTfqpM6vloGhDYssdDux2yZ0vvSMHWW7pGBgcIT0fXdBfyo+nKWZtaIMTOPCMSXXQk60f8gaOU7AjwDB86NjSiBVbDJZlGrlC/+gGmzTuoDpj9wSDPBP9OhwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQ/bF+sK; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ/bF+sK"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-11b6bc976d6so4809637c88.0
        for <linux-block@vger.kernel.org>; Sun, 23 Nov 2025 18:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763953070; x=1764557870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wt4l3Vmobq4GuuMyFPJBgrWPvgmrjYhaZwLaOIoKCQ=;
        b=PQ/bF+sKOVTPV+FBrh9+gMAXMBO5MVWSsP6S+IvgmpQZH4MtrfojXoB5YGJMNqTZOA
         ycf8CywrZXBuN3mZFs2XvYzEr2eJ0nEZNjXEzQQ4XV4/tK6WCOGmjlsVbKLEuQKFmooA
         vOLEXK1/ZMFdHs248T851l92fV6XEXeCtVvCe/wwZPgz+vn3Dk94CEvbOPEuDUns36gY
         MiBqbfsPIO0uWzi+ZM6Xoj50jvnT9CV3lxEqM9wZyXJAaiTi9kcwELgAeYYLCs5rqGpG
         CZO3v/SE9T0Mt/VLObVGTt0Jy3Yb9E4rfqx+Ny6sxYWUrVtNgFrZMJ9UASllSB/iuqDE
         PvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763953070; x=1764557870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7wt4l3Vmobq4GuuMyFPJBgrWPvgmrjYhaZwLaOIoKCQ=;
        b=VPGZQsifZtUhaOu7K4mtTYFIlY9jqA/9rkfzfj7jVEewYnwq0hKgqL8pgCvYo+strm
         Sz34ekSGYJc98TtXVitaz8obFai3U8cvlmG2W/Szkp5e7Jh+EbNQ6ioOqHTaNWOORvC0
         DA49tYoJJAngWsGVOzFNwWfXssI1OgdPzly6Km+79K8KgjzQWhfT2v1jfLwpbeyCPGUR
         vq7kH9pSA7l57/Yi9n6BIVLs+GzZ9lq2mMDtTzGV+uaAWZUskniW5wjzqeZLqsNouLEf
         veFwysTqmmyiZ53zFv+yOyg6bmV3hhJbczSxggyu007XQ5lRsk0gAsv+nBOjXoeYq4kO
         a4HA==
X-Gm-Message-State: AOJu0YwULjFfcWlwG6JTMBZzFUsv9EJiw81yiGdfy5UtQdhubsJTaiJh
	4nAskhh70Y0fdMd+//hXkbXYcmICXxXpIRc5M/sxjCU4L3KrBsX3sKT0YEev0Q==
X-Gm-Gg: ASbGnct3iupQ6GX8Oht4aSRwU0EbA+lQvGUWO+grX/6kQC5wr4UsmlUGK27rha1xCbP
	+vZSpB/8Tg5sKQ6XH6JRLyoY+L4ORvA4qMnNG5JQwa5b/zYy0hxthiERJvLvjW0KCEXwMAimrLj
	2QKUTSCvaxS1Vi04LC/scOOJn8ltJXxdtN7XGZdeovpg4coimyVubk1oeQvOkrZcUD5sYVkem7d
	cUSqA69B7MBFmF27W+G53wSEK5Q+KVnESn83zyIQ6QddqfMIxNBafhjzn3yqcRf9VIP337W/6YZ
	hqHgXnx1Qgom86HmWvYANhrJESn+WW1M+Q4EVx/yh1xjuN/t+RqS2+iJePY6cVMsC4k5Q6iRwVT
	OTKthaIFW/DlOgl6wooeBczKuGSh0bKHyGBDWCvNPsvftnHDI59mRH2s1nur0+o8MVJncrWxtEr
	2Q0jxqV0iaZAGAc1WVy8TiBQaY2K5N5RGAQDrl0DXOoyhPpoPZIS7BwDSs7g==
X-Google-Smtp-Source: AGHT+IFpsDs+kXmQXVU6E1/nGle2v7URUru8XFd/49TW2BQ+0epIeeb7LYLuuNciA5YRvlLXxX79hA==
X-Received: by 2002:a05:7022:3d0e:b0:11b:3eb7:f9d7 with SMTP id a92af1059eb24-11c94b601c2mr7020409c88.14.1763953070114;
        Sun, 23 Nov 2025 18:57:50 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e6da4dsm58917652c88.9.2025.11.23.18.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 18:57:49 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai@fnnas.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	jaegeuk@kernel.org,
	chao@kernel.org,
	cem@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org,
	bpf@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH V2 5/5] xfs: ignore discard return value
Date: Sun, 23 Nov 2025 18:57:37 -0800
Message-Id: <20251124025737.203571-6-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__blkdev_issue_discard() always returns 0, making all error checking
in XFS discard functions dead code.

Change xfs_discard_extents() return type to void, remove error variable,
error checking, and error logging for the __blkdev_issue_discard() call
in same function.

Update xfs_trim_perag_extents() and xfs_trim_rtgroup_extents() to
ignore the xfs_discard_extents() return value and error checking
code.

Update xfs_discard_rtdev_extents() to ignore __blkdev_issue_discard()
return value and error checking code.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 fs/xfs/xfs_discard.c | 27 +++++----------------------
 fs/xfs/xfs_discard.h |  2 +-
 2 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
index 6917de832191..b6ffe4807a11 100644
--- a/fs/xfs/xfs_discard.c
+++ b/fs/xfs/xfs_discard.c
@@ -108,7 +108,7 @@ xfs_discard_endio(
  * list. We plug and chain the bios so that we only need a single completion
  * call to clear all the busy extents once the discards are complete.
  */
-int
+void
 xfs_discard_extents(
 	struct xfs_mount	*mp,
 	struct xfs_busy_extents	*extents)
@@ -116,7 +116,6 @@ xfs_discard_extents(
 	struct xfs_extent_busy	*busyp;
 	struct bio		*bio = NULL;
 	struct blk_plug		plug;
-	int			error = 0;
 
 	blk_start_plug(&plug);
 	list_for_each_entry(busyp, &extents->extent_list, list) {
@@ -126,18 +125,10 @@ xfs_discard_extents(
 
 		trace_xfs_discard_extent(xg, busyp->bno, busyp->length);
 
-		error = __blkdev_issue_discard(btp->bt_bdev,
+		__blkdev_issue_discard(btp->bt_bdev,
 				xfs_gbno_to_daddr(xg, busyp->bno),
 				XFS_FSB_TO_BB(mp, busyp->length),
 				GFP_KERNEL, &bio);
-		if (error && error != -EOPNOTSUPP) {
-			xfs_info(mp,
-	 "discard failed for extent [0x%llx,%u], error %d",
-				 (unsigned long long)busyp->bno,
-				 busyp->length,
-				 error);
-			break;
-		}
 	}
 
 	if (bio) {
@@ -148,8 +139,6 @@ xfs_discard_extents(
 		xfs_discard_endio_work(&extents->endio_work);
 	}
 	blk_finish_plug(&plug);
-
-	return error;
 }
 
 /*
@@ -385,9 +374,7 @@ xfs_trim_perag_extents(
 		 * list  after this function call, as it may have been freed by
 		 * the time control returns to us.
 		 */
-		error = xfs_discard_extents(pag_mount(pag), extents);
-		if (error)
-			break;
+		xfs_discard_extents(pag_mount(pag), extents);
 
 		if (xfs_trim_should_stop())
 			break;
@@ -496,12 +483,10 @@ xfs_discard_rtdev_extents(
 
 		trace_xfs_discard_rtextent(mp, busyp->bno, busyp->length);
 
-		error = __blkdev_issue_discard(bdev,
+		__blkdev_issue_discard(bdev,
 				xfs_rtb_to_daddr(mp, busyp->bno),
 				XFS_FSB_TO_BB(mp, busyp->length),
 				GFP_NOFS, &bio);
-		if (error)
-			break;
 	}
 	xfs_discard_free_rtdev_extents(tr);
 
@@ -741,9 +726,7 @@ xfs_trim_rtgroup_extents(
 		 * list  after this function call, as it may have been freed by
 		 * the time control returns to us.
 		 */
-		error = xfs_discard_extents(rtg_mount(rtg), tr.extents);
-		if (error)
-			break;
+		xfs_discard_extents(rtg_mount(rtg), tr.extents);
 
 		low = tr.restart_rtx;
 	} while (!xfs_trim_should_stop() && low <= high);
diff --git a/fs/xfs/xfs_discard.h b/fs/xfs/xfs_discard.h
index 2b1a85223a56..8c5cc4af6a07 100644
--- a/fs/xfs/xfs_discard.h
+++ b/fs/xfs/xfs_discard.h
@@ -6,7 +6,7 @@ struct fstrim_range;
 struct xfs_mount;
 struct xfs_busy_extents;
 
-int xfs_discard_extents(struct xfs_mount *mp, struct xfs_busy_extents *busy);
+void xfs_discard_extents(struct xfs_mount *mp, struct xfs_busy_extents *busy);
 int xfs_ioc_trim(struct xfs_mount *mp, struct fstrim_range __user *fstrim);
 
 #endif /* XFS_DISCARD_H */
-- 
2.40.0

