Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5323E0C75;
	Mon, 10 Aug 2026 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369850; cv=none; b=HFl8MuQF0BQDIc+SciQFUg7ifxf1DMx6SeSXUbNfEp6D2NiYMHiyDvuPg5uiYGS4W/kRXTE5HEuCG6GfOG/xuEZF53aQMKC4G9Y2RHVea7Z0KdvJbhrxGiYo4Lc6AaL46cu/ShYGSowUwRFhiTo5LlS7p2k4Ke7rvC4XTlef5RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369850; c=relaxed/simple;
	bh=2c/74vcYuq3haLHE9qZ74R12UsGFitB4fgGT4P+rT4k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YIyhPN5UxTkElAY4lr45WSk1GL8u4JiuBidcra+1qonmCX+lrfPm2XA9l4Yya21IR4smpYSUYm+zA/eaw6qcP/9JpRVDQvC9ur6YP2UxiHi+B/Indr4SVVL5v/PBJMCl48S39uOqRDJGRHwJJlAxnag+J6ZpP3PSbKtdtepGLac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=LkgusO6q; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="LkgusO6q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nv
	Tv0ABNXhDdfal8hsXko1aeKEpgAMbDhnoUnQwh+0A=; b=LkgusO6qjGXgSJayJs
	dd0Uwlp1MNHyD58AR492u/aae3FzqT0txL6Z0BdCYGrnBnbuDOoI+QG/Euu/CFXV
	ODEsFXme5H6KGMytMs5JmgXYS3j7eM4SYh7/4M5DDWhskI99oKjfAU5KMt5Uiibi
	1+pVUb7tBnvCZnwIDmMdxfENM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgDXr4H21nlqU2ADEw--.17246S4;
	Mon, 10 Aug 2026 21:49:59 +0800 (CST)
From: Genjian <zhanggenjian@126.com>
To: axboe@kernel.dk
Cc: hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	schatzberg.dan@gmail.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanggenjian@126.com,
	Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: [PATCH] loop: fix memcg css leak on read-only I/O path
Date: Mon, 10 Aug 2026 21:49:05 +0800
Message-Id: <20260810134905.3230681-1-zhanggenjian@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCkvCgDXr4H21nlqU2ADEw--.17246S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4kKFyfCry7Gr1fXrWUurg_yoW8Ar1UpF
	WDKFyUGFWFk3WUWF47G3s7Wa45C3Wxtr9xK3ya934FvrW3JrnxAr45JayYqFWDJrZ2qa1Y
	9F4DtryUuF1YkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziWrWxUUUUU=
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/xtbBpgfvbmp51wchsQAA3z

From: Genjian Zhang <zhanggenjian@kylinos.cn>

loop_queue_rq() takes a reference on the effective memcg css via
cgroup_get_e_css() and stores it in cmd->memcg_css. loop_handle_cmd()
is supposed to drop that reference after use, but the early exit for
writes to a read-only loop device jumps past css_put().

When testing on cgroup v2, stack a dm-linear device on a read-only
loop and issue writes to it from a child cgroup, then remove that
cgroup: nr_dying_subsys_memory in cgroup.stat increases and never goes
back down until reboot. The same test no longer shows the leak with
this patch.

Fix by moving css_put() onto the shared exit path so the read-only
failure case drops the reference as well.

Fixes: c74d40e8b5e2 ("loop: charge i/o to mem and blk cg")
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 drivers/block/loop.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1faecef33009..66eaf912c013 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1895,7 +1895,7 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 
 	if (write && (lo->lo_flags & LO_FLAGS_READ_ONLY)) {
 		ret = -EIO;
-		goto failed;
+		goto out;
 	}
 
 	/* We can block in this context, so ignore REQ_NOWAIT. */
@@ -1919,11 +1919,12 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 	if (cmd_blkcg_css)
 		kthread_associate_blkcg(NULL);
 
-	if (cmd_memcg_css) {
+	if (cmd_memcg_css)
 		set_active_memcg(old_memcg);
+out:
+	if (cmd_memcg_css)
 		css_put(cmd_memcg_css);
-	}
- failed:
+
 	/* complete non-aio request */
 	if (ret != -EIOCBQUEUED) {
 		if (ret == -EOPNOTSUPP)
-- 
2.25.1

