Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA28485932
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101081; cv=none; b=lBSSVqzsIs1Ghn9kT1ns6HRr1Pg5SqUNLYvMo6TUUR+5Oq09GgzOEW4IUArn4w5R/3TJs0/pr6+VazqOn2dugl65ocPkv6/FUX2gyUc2rgSlP/ZwZ3+zInPOuMgaEV35rWCx71euMjeGdJbgf9eL3CvZ+sfb5lGsls3OIWzNLXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101081; c=relaxed/simple;
	bh=qVh53xof9YtLsxERX5WdVctnj20aJtGQv3SxjunZ4W8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cuia7nCf13jiClmleZl2ZJik6ml943nUEVeJlkoclE9BJSFrWgbM0cjHbSvlG4QjQ1eBFdtFf9cnew1UST6uUJlsB0Wdqf2F2ho2HbaQs6DrenZjOzQyk7F0vIhaXLHG/DcLpgUeQHOlxnvrE9wPVfuzyInC0irRP+8aiQ/c6I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FLTdaTWV; arc=none smtp.client-ip=109.224.244.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FLTdaTWV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1790101066; x=1790360266;
	bh=R2AWk4XuXvi63kdcw95IUDiDYiYKT5vxzDeyoEhHOa8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=FLTdaTWVAk4a7E9be8hclqKxB526B2HXjsg/mnSo16q5jUQykoAIbxLCAlcwZZcPa
	 hgMo7pzRcHASfiYsC/GoTSZiyaappSYNcWpKvYMa4OHCLgD6lFCARf1Vh/bGlFhGli
	 q5B3eSnv0QHYlR1YlE+ML6CkJhO/f2txNgL3+pRzXGdfzrmCBumkkjjsnHaRHAku3X
	 pezKM3tynhvZS9CHNU4hLYO6Dau/+Pt0Nvn1DiClKInmBui2Tb4E6KA/H0GOjK07RB
	 /3Jm+Zs4J6tVH3uYkrnE/g2CkjFiQ1udrUdjCnNWJW7W9SlI65s6vaRWdfk8aLrUgJ
	 djFMlp6dZxhiA==
Date: Tue, 22 Sep 2026 18:17:43 +0000
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>
From: Paolo Bertinetti <paolobertinetti200f4@proton.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, syzbot+b48868c46e62c1c4cb2c@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com
Subject: [PATCH] ublk: hold RCU read lock in ublk_try_buf_match()
Message-ID: <179010105967.8478.2344875677216734809@proton.me>
Feedback-ID: 117280896:user:proton
X-Pm-Message-ID: 2b7476fdcee23772afd9bc0422ba2cdff982c737
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

syzbot reports a lockdep splat when I/O is dispatched to a ublk device
with UBLK_F_SHMEM_ZC enabled:

  WARNING: suspicious RCU usage
  lib/maple_tree.c:720 suspicious rcu_dereference_check() usage!
  ...
  Call Trace:
   mas_root lib/maple_tree.c:720 [inline]
   mas_start+0x3cc/0x640 lib/maple_tree.c:1250
   mas_state_walk lib/maple_tree.c:3006 [inline]
   mas_walk+0x1db/0x490 lib/maple_tree.c:4458
   ublk_try_buf_match drivers/block/ublk_drv.c:5639 [inline]
   ublk_init_iod+0x5d2/0x1120 drivers/block/ublk_drv.c:521
   ublk_dispatch_req+0x97/0x9c0 drivers/block/ublk_drv.c:1776
   tctx_task_work_run+0x73d/0xa80 io_uring/tw.c:96

ublk_try_buf_match() calls mas_walk() on the buffer tree without
holding the RCU read lock or the tree lock. Writers are already
excluded because ublk_lock_buf_tree() freezes the queue, so there is
no real race, but maple tree readers must still hold one of the two.

Take the RCU read lock around the walk.

Fixes: 4d4a512a1f87 ("ublk: add PFN-based buffer matching in I/O path")
Reported-by: syzbot+b48868c46e62c1c4cb2c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Db48868c46e62c1c4cb2c
Assisted-by: LLM
Signed-off-by: Paolo Bertinetti <paolobertinetti200f4@proton.me>
---
syzbot tested this patch [1]: the RCU splat is gone, but the reproducer
then hits the already open "WARNING in io_wq_put_and_exit (2)" [2],
which syzbot has been reporting since May on kernels without this change.

[1] https://lore.kernel.org/all/6ab1eabe.71f81b7d.15fa6d.003b.GAE@google.co=
m/
[2] https://syzkaller.appspot.com/bug?extid=3Db0d54b9e81de55179e47

 drivers/block/ublk_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 66eb55e71..7a64745e1 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -5628,6 +5628,8 @@ static bool ublk_try_buf_match(struct ublk_device *ub=
,
 =09unsigned long expected_offset =3D 0;
 =09bool first =3D true;
=20
+=09guard(rcu)();
+
 =09rq_for_each_bvec(bv, rq, iter) {
 =09=09unsigned long pfn =3D page_to_pfn(bv.bv_page);
 =09=09unsigned long end_pfn =3D pfn +

base-commit: 93f51579e7df248780214094418f205253383cc5
--=20
2.55.0


