Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C79B42A140
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785183183; cv=none; b=HN+07ZLzZPMSINGaABiKVaQYyRS3SrpmDxDvG5nX3w6rzmJFzcXcvFNGZfuiy1LQT0M3ATsHJAqDrS+WVNW8l0feJ605xvGhOAXpVH6gdk9SPbkKTWw9fyvEOW5avzQTjwR86jGlCdNRXIhTTUsr+YxcScUzFPCsvKOrQZDbfks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785183183; c=relaxed/simple;
	bh=docWMqbBkUFwWyy4rg9NlkSlcaz31+fJOtGssg3YJOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dfHHfhI5jLxeGIscw4ocfhC13w7bK+rIbIknjQwC5ufZpUczi4kuyycbPi+RW5LP21j+ec9iPRyvsEW8co8s0gvFuxexmJSh3ojxfqBOtp+Ks174QQmwpMP41cMksS7by3cpgtCh3vp/3ubDFefPWDErAjGkn+sGqhALRvEvQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oIqw6rIG; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIqw6rIG"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81ed000b507so24587907b3.0
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 13:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785183179; x=1785787979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tPyqnKihTlQFHdssVMVemAlIRLl39sgkift01DFBxTc=;
        b=oIqw6rIG8zWI12+vzexd6o7lTDbtvu2copD8NZqmp21S2kMazA10XZEk7rFhrSZyTl
         U6Q0DAFUKN4UGolc9NWIggCVFeXHJqnWdj8MwIhI9ohC9Qi0bssZLRFETaw6uE059wQP
         jSmoHFiEXeaNG1dE2WJba4hg6+zCFP6ol7MGHrTI8iOg8pJFZCYg5aIV6jD9tiX/vJrg
         URerTXiVB9rp9WNj00WH1feCM+u5OWAHmLOi9XodhwDk5sdwF1ZadH7O39K1Q+/skDhb
         VzMS4RXr41dftGwMiuZxp+oNYMkP7T5f+z0U5h+9zxa7jryuLPtO3+7GMwJCNRqjqQBz
         aTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785183179; x=1785787979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tPyqnKihTlQFHdssVMVemAlIRLl39sgkift01DFBxTc=;
        b=T6OyMQJJFWjo+yS/slheQ6aANXQYf1K7UsxGJssAtmg5O9j1Dy2APpt8NrOkkXb4ML
         SiHh0pYnbbk+8HIjtZA7YEEq43pHrVqDoxbc2Ks2EjaKRFT/imF6SgylHqtffIMiE5CV
         NwXXq/LGgIR1DUUNdeGDsI5n3XcdM1A8nEXhdyEE/B4X5qAvGpWCKQKbnnYytZZoqkfP
         rRRWFSHkWohpCpBTRua/JWPMwpCfV7k14nuAUqyDwgAdxIqDxIjrwFtl5cKuE8/OTRX8
         YiaZryg5FklaJHDTsw7B+cm7EF8BjA1Q/AjPFv61SpJNwTpwQkkrHHjS4wbs2WcZfU4j
         1ABg==
X-Forwarded-Encrypted: i=1; AHgh+RrEh3iwzFz9jO8q854aGUBniYKimLU7JZouVmZ/YWJbhMhPKHBj5SK0Lo9rPDtvMVqtiVAKus9tZB+iKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNJ9XNNG1D21poyYxvzgsxqhmhCqPEiby3rjRU42Tod8K8hz1N
	N5dZkJNxZ1UabPofFK/VykV4W1hRu/dZSPVU/AIKzan7rlX8hqKhkOMhpiBY0HeHij4=
X-Gm-Gg: AR+sD10+n7E8Hxj57qavD0mtJZ4qooh63+gBY6u4KKIVxnkUbBN4fsYS7Jrz3NrEeDx
	mQczhxR+KrKIIyMQukHevjlrAruURIxwHE5cw5r8X55549T8eqhkHUbE5Q5pWS7yuctdyGBrQWr
	a9jLA5xfenKwXQ3tI9swRXwn/DYFj/nfxIGmVUrHr77IsW1P7B7M7k9B7jQJcBDCYm+uRINw4SM
	UmPH9inFCpfh/3dsRsPDmvbi0wBXLH5y5LbRsJ18O/Dmmc4uzKEhuf8QMpTSx24kPc5euf6sRxR
	496lLEmZq9COsI1Mbfw6RY2OYyVqCV8mrTyN9c22HgVYBmqzwuozxZvMtIJPQuEtMgiM+Oab26M
	1yzOpVxcZhgAVXt+er4viwsCaRdkPZiDgqvmUT+LoCPo1P0L5Rt17naGRw5VVIDhpB5iyrfx7aE
	8Z8mRcs9/0bltWRCX+2jO5
X-Received: by 2002:a05:690c:6f13:b0:812:a680:e10d with SMTP id 00721157ae682-81f69cdcb6cmr36911227b3.12.1785183178724;
        Mon, 27 Jul 2026 13:12:58 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f6592ec1asm36564237b3.45.2026.07.27.13.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 13:12:58 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Weidong Zhu <weizhu@fiu.edu>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: stop the timeout timer when releasing a never added disk
Date: Mon, 27 Jul 2026 16:12:57 -0400
Message-ID: <20260727201257.211635-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

disk_release() undoes blk_mq_init_allocated_queue() for a disk whose
probe failed before add_disk(), but it only calls blk_mq_exit_queue().
Nothing there stops q->timeout, and that timer rolls forward: it stays
pending until it next expires, not until the last request completes.
So if the driver issued any I/O before adding the disk, the
request_queue is freed while still linked into a timer wheel bucket.

Commit 6f8191fdf41d ("block: simplify disk shutdown") dropped the
blk_cleanup_queue() call that used to stop it.  __del_gendisk() and
blk_mq_destroy_queue() still do; only the probe failure path lost it.

nvme gets there because nvme_update_ns_info() submits Report Zones or
FDP io-mgmt-recv on ns->queue before the disk is added, so a later
failure - a concurrent reset setting NVME_CTRL_FROZEN, or
device_add_disk() failing - lands in put_disk() with the timer armed:

  BUG: KASAN: slab-use-after-free in detach_if_pending+0x30c/0x340
  Write of size 8 at addr ffff888004d71310 by task kworker/u8:2/37
   __timer_delete_sync+0x156/0x240 kernel/time/timer.c:1621
   blk_sync_queue+0x22/0x40 block/blk-core.c:222
   nvme_sync_queues+0x100/0x150 drivers/nvme/host/core.c:5362
   nvme_reset_work+0x138/0x930 drivers/nvme/host/pci.c:3264

  Allocated by task 34:
   __blk_mq_alloc_disk+0x33/0x100 block/blk-mq.c:4462
   nvme_alloc_ns+0x290/0x3870 drivers/nvme/host/core.c:4146

  Freed by task 0:
   blk_free_queue_rcu+0x3a/0x50 block/blk-core.c:254
   rcu_core+0xc10/0x1730 kernel/rcu/tree.c:2857

The queue being synced there is ctrl->admin_q, only a victim sharing a
timer wheel bucket with the freed queue's dangling entry; other runs
tripped in enqueue_timer(), __run_timers() or blk_mq_timeout_work().
Failing nvme_alloc_ns() with a debug patch makes it deterministic: one
leaked timer trips KASAN within seconds, while 1987 patched releases
produced no splat.

Stop the timer and the queue work items before blk_mq_exit_queue(), like
blk_mq_destroy_queue() does.

Found by FuzzNvme.

Fixes: 6f8191fdf41d ("block: simplify disk shutdown")
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 block/genhd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index df2c3c69b467..e8ce0cabf392 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1281,14 +1281,18 @@ static void disk_release(struct device *dev)
 	/*
 	 * To undo the all initialization from blk_mq_init_allocated_queue in
 	 * case of a probe failure where add_disk is never called we have to
-	 * call blk_mq_exit_queue here. We can't do this for the more common
-	 * teardown case (yet) as the tagset can be gone by the time the disk
-	 * is released once it was added.
+	 * call blk_mq_exit_queue here, after stopping the timer and work items
+	 * that I/O issued before add_disk may have left pending.  We can't do
+	 * this for the more common teardown case (yet) as the tagset can be
+	 * gone by the time the disk is released once it was added.
 	 */
 	if (queue_is_mq(disk->queue) &&
 	    test_bit(GD_OWNS_QUEUE, &disk->state) &&
-	    !test_bit(GD_ADDED, &disk->state))
+	    !test_bit(GD_ADDED, &disk->state)) {
+		blk_sync_queue(disk->queue);
+		blk_mq_cancel_work_sync(disk->queue);
 		blk_mq_exit_queue(disk->queue);
+	}
 
 	blkcg_exit_disk(disk);
 
-- 
2.43.0

