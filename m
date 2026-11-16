Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794787655;
	b=y1Ls740/0BqVw80ybVfrlNxBYlxQSJFeWZH+Eg8PM84aMg+v18IFYz0vr74hod1le20W
	 ruJ2QSGEJGOnZvJj1C9wCqSv4ZthEKjgCUHJPb708ua8WuAdYRQU94LP6VGh59yK7TvhX
	 b5BuGg4CR2e+qF4SIHQdBm4a2JltuhNkX462y9JBc11Tp1UpL80SQWbAK1VwrPfOW+MPQ
	 +TprBY5sh40lovmQ5+xDnH2n6C6iT+ELxGj2njY29XqN/a7Tb82xfb5G+Xm9HW+6yyLC3
	 OW+967f5RckD/stxwMccAUn7aHwYqxuUUm8yk8wRAc9ItfilJoU52AV/e8xbavq9skg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794787655;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KynMk6tfaUF3/byRhIeOBBnOgXm4IwVi/zkKqYpvSGU=;
	b=mmWTIaUfTQhRh/HWkkYmMINnISTLjZK4uSQo2PII9+OHgG3Qj9yts65yBhbm+oq6xzHd
	 J4QClFAG36aKM6e9DauwCLPqMnQ2tEhsedB0LIC0stSZmFNiqcg/bwLt92H5tw09aCvuw
	 Jtt4CGTk7r68DU9WjV+bpcK6Vb1Iv2lzZe/wnjF1PyWAMxCXq9c97lUj512rt14nImK2j
	 WRNX7s8g8vCaCrUUAj5cJVjCMwRZ4AS+UvHNuQ98a2NnPBwQbKjo7/COwF/H2d8Mafh7z
	 VXEV93y1m0fKf3G9aAEhQdIPC33lT6Fg0IvFNGjXuPdzixiWASmPiCngEGYW8xqD22Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2zpy3vl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C0D606A31F;
	Mon, 16 Nov 2026 00:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2zpy3vl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8FA1F000C4;
	Mon, 16 Nov 2026 00:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794787655;
	bh=KynMk6tfaUF3/byRhIeOBBnOgXm4IwVi/zkKqYpvSGU=;
	h=From:To:Cc:Subject:Date;
	b=S2zpy3vlRQ9XEQjJUFEcHTyU3/jVmzyr9s1nHs+IsH9Fs3xd2z2qKzIYupzWO9NEN
	 cDfY2w5NQMb1byCrS7437tT5GcxSs9LMEiU/TO1VLcm8UcQU+S2lxd1p2kAlKeHPok
	 2n/blieiLnELfpeM1Sap0S5R/j6Y6HPnfmFmc6SvHAVZKSPTziLDzcm2ptsdnb0uuo
	 mSOAWyHacwJsdZMarTFxyEmw4Z8MpzEaWzo/QzFwZ6btor4HiaEZKeMsrZbDP5Gr6T
	 S0T/jWvu8QSNFh6YEkREPMUBrwKdnsb8W7gVnywuNXt48LCCL8mFSQ1+lrJ58BXo/h
	 Ip94XVT7EH5Cw==
From: Chao Yu <chao@kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] block: prevent reordering of PF_BLOCK_TS clear and plug NULLing
Date: Mon, 16 Nov 2026 00:07:23 +0000
Message-ID: <20261116000723.934826-1-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
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

From: Chao Yu <chao@kernel.org>

We hit below kernel panic while running fsstress on f2fs on an arm64
Android device:

 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
 Internal error: Oops: 0000000096000046 [#1] PREEMPT SMP
 CPU: 1 UID: 0 PID: 9196 Comm: fsstress Tainted: G S      W  O       6.12.96-android16-6-maybe-dirty-4k #1
 pc : __schedule+0xeb8/0x1de4
 lr : __schedule+0x7b4/0x1de4
 Call trace:
  __schedule+0xeb8/0x1de4
  preempt_schedule_irq+0x48/0xa8
  arm64_preempt_schedule_irq+0x30/0x48
  el1_interrupt+0x48/0x8c
  el1h_64_irq_handler+0x18/0x24
  el1h_64_irq+0x7c/0x80
  blk_finish_plug+0x70/0x18c
  f2fs_write_data_pages+0x1bc/0x14f4
  do_writepages+0x98/0x1b0
  filemap_fdatawrite_wbc+0x60/0x9c
  filemap_write_and_wait_range+0x7c/0x210
  f2fs_flush_buffered_write+0x24/0x50
  f2fs_file_write_iter+0x650/0x798
  ksys_write+0x2d8/0x500
  __arm64_sys_write+0x1c/0x2c
  invoke_syscall+0x58/0xe8
  do_el0_svc+0x80/0xb0
  el0_svc+0x4c/0xd8
  el0t_64_sync_handler+0x94/0x10c
  el0t_64_sync+0x1bc/0x1c0
 Code: b4ffa688 97c33675 17fffd32 f9454e68 (f900111f)
 Kernel panic - not syncing: Oops: Fatal exception

The faulting instructions are in blk_plug_invalidate_ts(), which is
inlined into finish_task_switch():

	ldr	x8, [x19, #0xa98]	// x8 = current->plug, which is NULL
	str	xzr, [x8, #0x20]	// current->plug->cur_ktime = 0

blk_plug_invalidate_ts() assumes current->plug is valid as long as
PF_BLOCK_TS is set. However, in blk_finish_plug(), __blk_flush_plug() is
inlined, and the compiler is free to reorder the store that clears
PF_BLOCK_TS after the store that sets current->plug to NULL, since
nothing tells it there is a dependency between them:

	str	xzr, [x19, #0x20]	// plug->cur_ktime = 0
	ldr	w8, [x20, #0x44]	// w8 = current->flags
	str	xzr, [x20, #0xa98]	// current->plug = NULL
	and	w8, w8, #0xdfffffff	// w8 &= ~PF_BLOCK_TS
	str	w8, [x20, #0x44]	// current->flags = w8 <- blk_finish_plug+0x70

The race is as below:

- blk_finish_plug
 - __blk_flush_plug
  - plug->cur_ktime = 0
 - current->plug = NULL
					: IRQ arrives at blk_finish_plug+0x70,
					: PF_BLOCK_TS is still set
					- preempt_schedule_irq
					 - __schedule
					  - finish_task_switch
					   - blk_plug_invalidate_ts
					    : current->flags & PF_BLOCK_TS
					    : current->plug->cur_ktime = 0
					    : NULL pointer dereference
 - current->flags &= ~PF_BLOCK_TS

Commit 691b052139c9 ("block: fix race in blk_time_get_ns() returning 0")
already added a barrier() on the side that sets PF_BLOCK_TS, but the
side that clears it in __blk_flush_plug() is still unordered against
current->plug = NULL.

Fix it by adding a barrier() after clearing PF_BLOCK_TS in
__blk_flush_plug(), so that the compiler can not move the store of
current->plug = NULL in blk_finish_plug() before it. Both stores and
the reader in finish_task_switch() run on the same CPU in the context
of current task, so a compiler barrier is enough here.

Fixes: fad156c2af22 ("block: invalidate cached plug timestamp after task switch")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 block/blk-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 8836c7028568..65379d5a1686 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1283,6 +1283,12 @@ void __blk_flush_plug(struct blk_plug *plug, bool from_schedule)
 
 	plug->cur_ktime = 0;
 	current->flags &= ~PF_BLOCK_TS;
+	/*
+	 * Ensure PF_BLOCK_TS is cleared before blk_finish_plug() sets
+	 * current->plug to NULL, otherwise blk_plug_invalidate_ts() can
+	 * dereference a NULL current->plug if preempted in between.
+	 */
+	barrier();
 }
 
 /**
-- 
2.49.0

