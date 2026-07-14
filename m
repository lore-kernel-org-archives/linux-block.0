Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB62317A300
	for <linux-block@vger.kernel.org>; Tue, 14 Jul 2026 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025381; cv=none; b=dlq1u+506USj9DTeOYReqRLYJhMCA8w9uchrWA6UdWkoWNQvB9/GBvwSMyRyoGjfL7wH35aOXLuY/NTHQjD7z6iG2coSn5j1HHtaax5d8rsn9NWyNkOh04JQuOuFpx42aY2+BcLCgv0HVCvTlPFfZkRHPj1U6oY4VK4FUmui41c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025381; c=relaxed/simple;
	bh=SOND1/Cxd1OOLqvNiLextOeAYdI//+q16RGWGj0LE+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mfzp1jKo47hWLLI4KG4mA3+HpnjB7MYu6JhXD9oSf1oG8MlkrXwuZ/pKkkMCFQ8LKhQKoVYEZdGFWq8QQuVjF3HubMKJoNFJ0s83/6+xQKW7St95mskwRq2u1vdrHTRFnlUYEsnzhM0a3whj1Q3x0M2AYHsZ0GFJASu9eUYt7X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SuCwnIiX; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SuCwnIiX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784025367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NEYNgmwx4kxnQMtFaBoS8gmVo4HcRL7TLFRWxtR0Xb0=;
	b=SuCwnIiXtg5Xp0cr/kgIQLrJZmbpj1YOkcyXYs+9nolJRnYFghnR71L9q9MViEB/AonSnk
	pS431YofVAEAkixQ0OqNZgPmLm56M52fv+ox4DMhISvNkRvloYzlPHad4PU9aWwTndgVVI
	n8WvmfskHNqAtcQxaJBkiaVULvgJV60=
From: Tao Cui <cui.tao@linux.dev>
To: axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] blk-throttle: fix divide-by-zero on legacy iops limit of 0
Date: Tue, 14 Jul 2026 18:35:52 +0800
Message-ID: <20260714103552.1335658-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

Writing a multiple of 2^32 (e.g. 4294967296) to a legacy cgroup v1
throttle iops file (blkio.throttle.{read,write}_iops_device) silently
truncates to 0: tg_set_conf() stores the sscanf-parsed u64 value into
an unsigned int field with no clamping. The cgroup v2 path,
tg_set_limit(), already clamps the same kind of value with
min_t(u64, val, UINT_MAX), but the legacy path never did. Note that
the "!v -> U64_MAX" mapping only catches an explicit zero and does not
catch a value that truncates to zero.

With iops stored as 0, tg_update_has_rules() sets has_rules_iops[] and
the next IO reaches tg_within_iops_limit(), which computes

    jiffy_wait = max(jiffy_wait, HZ / iops_limit + 1);

triggering a divide-by-zero oops.

Fix it in two places:

  * tg_set_conf(): clamp the value to UINT_MAX, consistent with
    tg_set_limit(). This closes the truncation root cause (and the
    general silent truncation for any value above UINT_MAX).

  * tg_dispatch_iops_time(): treat iops_limit == 0 as unlimited so the
    divide in tg_within_iops_limit() is never reached, defending
    against any future path that could produce a zero limit.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 block/blk-throttle.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index ffc3b70065d4..3f3c1374f4b2 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -883,7 +883,12 @@ static unsigned long tg_dispatch_iops_time(struct throtl_grp *tg, struct bio *bi
 	u32 iops_limit = tg_iops_limit(tg, rw);
 	unsigned long iops_wait;
 
-	if (iops_limit == UINT_MAX || tg->flags & THROTL_TG_CANCELING)
+	/*
+	 * iops_limit == 0 is not a valid limit. Treat it as unlimited so we
+	 * never reach the HZ / iops_limit divide in tg_within_iops_limit().
+	 */
+	if (iops_limit == UINT_MAX || iops_limit == 0 ||
+	    tg->flags & THROTL_TG_CANCELING)
 		return 0;
 
 	tg_update_slice(tg, rw);
@@ -1386,7 +1391,8 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 	if (is_u64)
 		*(u64 *)((void *)tg + of_cft(of)->private) = v;
 	else
-		*(unsigned int *)((void *)tg + of_cft(of)->private) = v;
+		*(unsigned int *)((void *)tg + of_cft(of)->private) =
+			min_t(u64, v, UINT_MAX);
 
 	tg_conf_updated(tg, false);
 	ret = 0;
-- 
2.43.0

