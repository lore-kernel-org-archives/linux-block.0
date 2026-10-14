Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B8252F288
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997546; cv=none; b=DQBM7NNi8rrWy1Ls9ebL/jgY0BltNGyozW4bRzJ3iJQMpBJZuuyDHS/Z2EGOSzS0XlZTbp+hpSgRuSGFhaXkVd/ipr8EUBTMQDsXJLvmTu2YI3TAM326la97u84GxiAeteG8qvnuBf6H+p/TwP+2ZZ82Z2PJXPQaF4K5FhitnTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997546; c=relaxed/simple;
	bh=/+VXd1ovnPLZdJQOqnh4F/q6HlFzJgF55EQXVEW4WlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P2evf7k/xELFRJINuzGPFORazSFMMFbmurreNUzJoZb+jS/789OEh/3Y+11z8iG4T+akyVKEMj18aTsoXFP8oiXXLUzbmTYrfyVvxtq+ol97scPNM9psJgNXBzIMQJ0VKRakqLVm85DVTBa6A/j/f5mRmoJXWDAvV56799c+3bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+k08sun; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+k08sun"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6afa651700eso6281811a12.2
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791997543; x=1792602343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vr2GQIRj+SVQDPhLexxv6L3pH5NTTn/hvbHQlNsKV1A=;
        b=H+k08sunZeZVkazljplEmZkBojSDOoVMKIB7wjd1TGi4qP3jf1RWEnOkLsnmhx/mFp
         WlzwwXilrvS2Cjpyer+/apeA2QA/WPNYFBW+rrAGuXsWgFQFVtQkAbux1cHXf4DwvvMd
         +owkgLcht7uSIlzSuTEkZttUIJApr744/fU4RtcxrO11aHPZBNuPa/cOOaGbZqv7WqZp
         aZQsJuoiAmUkAF39EpDmGaMEulpC9eWLNO1B13ytWQov5+vFy2yocQY+ArdcfWiVw5Sg
         RtXhTyL+kl0G17VZcUP4GdW5wUBLNjEq3aQZoX7uHaBxzRVKiHb3ZFJE1A8yBH2/R4AL
         qvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997543; x=1792602343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vr2GQIRj+SVQDPhLexxv6L3pH5NTTn/hvbHQlNsKV1A=;
        b=Z30++7cnNoElqzuCBvAIqTYefZ55fiywuyy6Evz6skjuQXnbRpW2DZ1bhQ8upan/Xv
         5jiv2ArkQ/1eIbHHwlbiNDp7KA7Jl5swvZzhcoJfDsU4G1Giq/MEopnzEk3lqa0ohDSH
         mUUy51iefK87zVjakzZtFEmmvTxvEgegH/8Rab6ZLWmYpMEEK7mDX6PJOI38ONr/P9vo
         yRwk/HrwAAdB5YuLEb/GzNgX2ohKJpr2tBjVqEtT2t1zdpur1VHK5/Qf3sIiZ4A85cQx
         I+D9PUTu9BicpqsujGP8Nkgzu0GDF+h6VcamR5HOWGNjzYRz/De2GqaxJROsoretmOmv
         tvTQ==
X-Forwarded-Encrypted: i=1; AKwUvBz7wZ5OA4uswPJqdk6yDNXOyRue0XnB5AqerwrySvBhp+HuK7dsteDM8XLJuyFFQPcc591RfU32bRWnyA==@vger.kernel.org
X-Gm-Message-State: AFq9FYITSXqUjhUiU96HrtulYcf9k/l3sNvO2YWziyx9c5gsQrpa/L/5
	WWIC4XYlCxOcq/wRSwyBGyvF8nkd6/p29yYNabZO7axTM6wNbA7x+xIw
X-Gm-Gg: AYBFou3n3SpdZKY/8fahGwLm2OCSMwecGiPBRULWOGIVP3tUNiLHGT8hgyTQYbpCbMS
	2BflUXYZpn4hBa5ZnmWI23wO3BTVRJyACN15uAg8NpV0Fj22eoH8FZmYTN4priXTmlZekP6YtxC
	ZyGEayt03aPcNDAJjblDZAjaFJjzUI3Qe6oQn3g/JKa65mGzGbFfST2z4GniEKXuUbWrnP1JOFL
	FjclKzz81BG5N80JOo4ywMNbJEPOcG8m89od4w8eQsQt7a8AFLFGA2F9h3mEHRY0Mk6j7pb6iJh
	otWyDb0g427PBeSPXIG4Y6XhmQiFZGjcxGtk4yTcLwvyL7eP/2s06zHNoWR0r0bd3EQIcyaMzrJ
	jjImP2OgAroRmNoRAvhQDYbqpRoR2KEsHYMk8zyfAWYNhBsZMgQ5qsl1KdEX22uqXj0SgxQYIzr
	DlJcQw/LTP6KK0o3PAr3LdIBykEBOXQ/UVrLlx/2wEgiMgAItrrPeIoR01ug0a+W0AOYI8yFyRO
	r5LS85CV56PZysrMMxT279DMp255N7Q42Hwox/sCURFWBRfCCtA1ZzdvlHucbqD41+I30mSAR9u
	S7uYv9L//m4zUO3sTscCkq6m76g0Vqom3DXbII36jSKc5PFxvuSEDvruM0iRIPNZKupckeZyHpV
	yi/4qYCxkEh97la37YBPvF4lmRF7tq0qvgVJpeVSFpG8=
X-Received: by 2002:a05:6402:915:b0:6ac:6b18:3475 with SMTP id 4fb4d7f45d1cf-6b17c246377mr15246408a12.21.1791997543177;
        Wed, 14 Oct 2026 10:05:43 -0700 (PDT)
Received: from Ubuntu.tail0f733b.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b203863511sm1407133a12.20.2026.10.14.10.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:05:42 -0700 (PDT)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot@lists.linux.dev,
	syzbot+e90526cab23b9efcd03c@syzkaller.appspotmail.com
Subject: [PATCH v2] blk-mq: fix out-of-bounds read in blk_mq_free_rqs
Date: Wed, 14 Oct 2026 19:05:36 +0200
Message-ID: <20261014170538.1089448-1-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A KASAN slab-out-of-bounds read can occur in blk_mq_free_rqs() when there
is a mismatch between the number of hardware queues allocated for the IO
scheduler (et->nr_hw_queues) and the number of hardware queues in the block
tag set (set->nr_hw_queues).

This mismatch can happen if blk_mq_update_nr_hw_queues() fails halfway
through (e.g., due to memory pressure during
blk_mq_prealloc_tag_set_tags()). In this error path, the elevator is
restored with a larger number of hardware queues than the block tag set
actually has.

When the elevator is later freed, blk_mq_free_sched_tags() iterates up to
the new et->nr_hw_queues and calls blk_mq_free_rqs(). In blk_mq_free_rqs(),
it attempts to access set->tags[hctx_idx] to get the driver tags. Because
set->nr_hw_queues was not updated due to the earlier failure, set->tags
still has the old (smaller) size, leading to an out-of-bounds read.

BUG: KASAN: slab-out-of-bounds in blk_mq_free_rqs+0xde/0x680
Read of size 8 at addr ffff88818d67fc28 by task syz-executor117/5839
Call Trace:
 blk_mq_free_rqs+0xde/0x680
 blk_mq_free_map_and_rqs+0x40/0xf0
 blk_mq_free_sched_tags
 blk_mq_free_sched_res+0xeb/0x280
 elevator_change_done+0x1d2/0x5c0
 elevator_change+0x34f/0x480
 elv_iosched_store+0x504/0x630
 queue_attr_store+0x207/0x2b0

To fix this, explicitly check if hctx_idx < set->nr_hw_queues before
accessing set->tags[hctx_idx]. If hctx_idx >= set->nr_hw_queues, the
hardware queue doesn't exist in the tag set, meaning there are no driver
tags to clear mappings from. In this case, safely set drv_tags to NULL. The
subsequent call to blk_mq_clear_rq_mapping() already handles a NULL
drv_tags pointer and will safely return.

Fixes: 04225d13aef1 ("block: fix potential deadlock while running nr_hw_queue update")
Assisted-by: Gemini:gemini-3.5-flash Gemini:gemini-3.1-pro-preview syzbot
Reported-by: syzbot+e90526cab23b9efcd03c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e90526cab23b9efcd03c
Link: https://syzkaller.appspot.com/ai_job?id=827b5760-86a0-4f44-9c69-430b572eac12
Reviewed-by: Nilay Shorff <nilay@linux.ibm.com>
Cc: stable@vger.kernel.org # 6.17+
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
Changes since v1:
- Drop the additional blk_mq_alloc_rqs() claim, as that path is bounded by
  set->nr_hw_queues.
- Add Nilay's Reviewed-by tag.
- Rebase onto current mainline and refresh the recipient list.

v1: https://lore.kernel.org/all/c92b0c7e-17fb-44c8-99d9-59d45004d05a@mail.kernel.org/

 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 025a799f35b92..259a5705efb79 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3484,8 +3484,10 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 
 	if (blk_mq_is_shared_tags(set->flags))
 		drv_tags = set->shared_tags;
-	else
+	else if (hctx_idx < set->nr_hw_queues)
 		drv_tags = set->tags[hctx_idx];
+	else
+		drv_tags = NULL;
 
 	if (tags->static_rqs && set->ops->exit_request) {
 		int i;

base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
-- 
2.53.0

