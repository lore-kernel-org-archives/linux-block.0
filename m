Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E143911CD
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 07:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285517; cv=none; b=VEoXGZr3zL0l4FTKijhwC5W7Zhl+PVqfepICcAw9DX1dD9r1JjpBdzussPyGV5qaS6J75gCaR5G13GkX5721/HxerFtCxNs8AOnO5ZDec4wZQrDkFWske2XvPpuSIJOxISYfWrXnyAAuk2/UEcx8Eq0AayDHEGJx+ARduHNbC8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285517; c=relaxed/simple;
	bh=DMGdJcE3z8hvCuSvszfb7Rs3z2bPJVDGXAwuSFYF9hc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GD0nLJ9AXVjkyQHQmk0bdwJM+g9kYtLiVeaRUqFF2eJqnlrt0Eyal8CLfdEoBvXR6pOIRJkN8SMxieQD3Q15FxUQfDLFtZv/nQ7gy7cXWuZTDMZDCLmLso/Sq6Tur/H2b/OsIhVYdG0tPTpHP/IScXIDPOV/31DkCTPaJAy00zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PY6zaFXn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PY6zaFXn"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c7e8eea816so727175ad.1
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 00:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782285514; x=1782890314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L+leDuTudkdTGtZVmFZo9+uB5t3xUHqrHzg1AbR0M5E=;
        b=PY6zaFXnNufi6qACA50h49B2/4SLBUZ1UTLFKQwsmo7PCZM9/NRghg3liF2KZVT/4I
         grD1ZWK8oXDCss1zpHpoA5E2fXZceGO+G3nM9PxEKBKGCGITAMMUaYFPcvgAi6QFFMcm
         Vvdt6GCVq3E+fPos2LsCxJPA72jUZ0GWc6aJ+C2108WpTtN3Nd39weL5BcoM+O8SAKpT
         Zp5SPYw7vUX5Qkzk5vvxsM+51kMIts7iHiYSEBjPSO0aeqHUfGe0BJ96Q4xXHJjZNyr6
         L1UT9b8RqqJl98nIc/v82cN32StpKWLTjE9dAZeZ1S5TZFlpzLGNaoh0K29OmyRRy2Vx
         DNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782285514; x=1782890314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+leDuTudkdTGtZVmFZo9+uB5t3xUHqrHzg1AbR0M5E=;
        b=qkdHlXNYGPsBLLlSlGNmrbnb0Z0kloLpGRhXlZjgUwrdzRqTOjAIGIhBMvJdbWSobv
         JomQjCMq93qLw2AlPKGldMIEj/B4zVkYSx35GHQ6bR6fGE3x57kGPrdsi7veG1L3U2fF
         z1ZfeKsjJOUkSt9NqI/L9AXrC4jF0rBKMCE3raIrbfJrrBOmVpbldfhM5xG5H/1VwvvA
         jcmUVhRSumbzzTwx9n2ovT6URLlaZct6I8IDdh/eeYIl05T5+/IekQrQiWbrlNlRqvBP
         x8+4tQdU1YuS1nHqIyzPiG3LTt9dJymO2ZNX9xILKgtBRXwX7078tn3nFfYsFvU9Oh/Y
         1n/Q==
X-Gm-Message-State: AOJu0Yy3gh8aTILseDTB+PBWEt0YmAFMC9fuGV3iDc+k3lpylkabBfN0
	pLwb6XSfjfm9Y3hGNN8ns0+eKg02Usp6v3FLXf9QMLcHxW7pSU3Zpm8l
X-Gm-Gg: AfdE7ckA9Naq+vN5ciKoavmr6pPNaY0AzsXa2Wc+VIQjK8qJLyYK2WPbopUJwTrjrmt
	+wRw+m/81fxrJ8vJDhv9Owf9ZIKCMpKvOW0OrZjccPANqXXFJ39CcwToKQxbzl+uEHAWEcYBYQB
	GoCKSq0piNq/CJikiNsgudZTvwGJVny2KAehmpGxoXsU3wMQj1qK90xveaOrcrdhgjDmF7fpjQR
	tcfNq7z1UbHb54+AXYm74k+TaJ2kRw+cxkA/iRcFo5gKsOGKeqRROoWoOZIHtRuGmwzaNc1yLAd
	zVKB6mpU8TCP+W6TyJIMCE1dKa+QudwNfKlmtc5r08llbgKnpo7fdlO72KYpXnayYjVOFv4eAlR
	bDmjWdEc47iiC9s7iuzHf8PBmM+l7A70DDLu1yKMXMifSOSyNzyEQciwcokWx+7HWkYdi9qMESd
	rMOTZ5jJE=
X-Received: by 2002:a17:903:1b4c:b0:2bd:d6f1:3388 with SMTP id d9443c01a7336-2c7c41180e4mr54616165ad.28.1782285514045;
        Wed, 24 Jun 2026 00:18:34 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af585sm131154135ad.5.2026.06.24.00.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 00:18:33 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Genjian Zhang <zhanggenjian@kylinos.cn>,
	Hans Holmberg <hans.holmberg@wdc.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Kees Cook <kees@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Kyungchan Koh <kkc6196@fb.com>,
	Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] null_blk: cancel bw_timer on add-device error unwind
Date: Wed, 24 Jun 2026 15:18:25 +0800
Message-Id: <20260624071825.357098-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

null_blk starts the bandwidth hrtimer before the later add_disk/device_add
failure points. If setup fails after the timer is queued, the shared error
unwind frees struct nullb without draining bw_timer, so the callback can
run on freed owner state.

The buggy scenario involves two paths, with each column showing the order
within that path:

null_add_dev() error unwind:        nullb_bwtimer_fn() callback path:
1. Start bw_timer for a throttled   1. The hrtimer expires after the free.
   device.                          2. nullb_bwtimer_fn() recovers the
2. Hit a later add_disk/device_add     embedded owner.
   failure.                         3. The callback reads nullb->dev and
3. Free struct nullb.                  nullb->q.
4. Release the remaining queue and   4. The stale owner storage is used
   disk resources.                     after free.

Cancel bw_timer in the shared error unwind before put_disk() and the
remaining frees. The normal delete path already uses the same
hrtimer_cancel() drain.

Validation reproduced this kernel report:
BUG: KASAN: slab-use-after-free in nullb_bwtimer_fn+0x13f/0x170 [null_blk]

Call Trace:
<IRQ>
 dump_stack_lvl+0x66/0xa0
 print_report+0xce/0x630
 ? nullb_bwtimer_fn+0x13f/0x170 [null_blk]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __virt_addr_valid+0x20d/0x410
 ? nullb_bwtimer_fn+0x13f/0x170 [null_blk]
 kasan_report+0xe0/0x110
 ? nullb_bwtimer_fn+0x13f/0x170 [null_blk]
 ? __pfx_nullb_bwtimer_fn+0x10/0x10 [null_blk]
 nullb_bwtimer_fn+0x13f/0x170 [null_blk]
 __hrtimer_run_queues+0x172/0x810
 hrtimer_interrupt+0x377/0x7f0
 __sysvec_apic_timer_interrupt+0xc3/0x390
 sysvec_apic_timer_interrupt+0x67/0x80
</IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20

Allocated by task 529:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0xaa/0xb0
 null_add_dev+0x4f9/0x1d10 [null_blk]
 nullb_device_power_store+0x25f/0x320 [null_blk]
 configfs_write_iter+0x2be/0x4a0
 vfs_write+0x604/0x11f0
 ksys_write+0xf9/0x1d0
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 529:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x5f/0x80
 kfree+0x307/0x580
 null_add_dev+0x1272/0x1d10 [null_blk]
 nullb_device_power_store+0x25f/0x320 [null_blk]
 configfs_write_iter+0x2be/0x4a0
 vfs_write+0x604/0x11f0
 ksys_write+0xf9/0x1d0
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: eff2c4f10873 ("nullb: bandwidth control")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 drivers/block/null_blk/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index f8c0fd57e041..8f1ad76710a0 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2062,6 +2062,8 @@ static int null_add_dev(struct nullb_device *dev)
 out_ida_free:
 	ida_free(&nullb_indexes, nullb->index);
 out_cleanup_disk:
+	if (test_bit(NULLB_DEV_FL_THROTTLED, &dev->flags))
+		hrtimer_cancel(&nullb->bw_timer);
 	put_disk(nullb->disk);
 out_cleanup_zone:
 	null_free_zoned_dev(dev);
-- 
2.43.0

