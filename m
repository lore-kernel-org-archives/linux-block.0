Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E768C356A2B
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 11:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768218173; cv=none; b=YtVMttSqjPY+Qf32RNm/Ascrv0stJIR1LS7HhvMxkrSnVMDUqAWPJK/CZioiSTGNF6yL0CQtLUD3OYduHx8chKbtAZFUAzZ3Db9fLAtKBG5aZCrd2weGT97rG26MKtkDFyClfiT0zOt2YEwI6VwHp96Am2Gzk9Uh+HH0M8mQjm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768218173; c=relaxed/simple;
	bh=c95WO/l5Yh3ODJc5THKGAjEQryf6UWGtacSfjwHl9EA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eC/Z5f+Qoma6nEs6hbQ64ACYxi7oeXokKMd7iOSw+QN2Oi5Yn7Old5JKUkZonRA+WWl60C98tur+xWz97ACxhuXoFdYZrjzbHJKM0PBjcjYXuJ4WSXqHy44l3HXynoyIFBstlOl+4LAqIgAbWb05/HbFbdXcAZkMh/07QJdihjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hr7s7myz; arc=none smtp.client-ip=209.85.160.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hr7s7myz"
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-4ee24fc1c46so3806541cf.0
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 03:42:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768218171; x=1768822971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzFvHeJhDdP4ilFE2+bLWYgTIbgx2yUf1NNqPTKhjnU=;
        b=notURvSurmC0L7hdJmIN8z+nEY1b1UETVtSmEA/XLvLSlM0UPV8cfzygVjfqUW+Dut
         gJODrKIS+E2xxkgJqQveCBoF8t5axQUjFErZBVv4+OFvuaJ+DSZSRw9Gmk0Qyxml20HZ
         VrsQvrnv4zXtDYJDwVT1cjEXeATXDJUmevtq+st7CSIKxNiQaOrl0RdC3YixF2Uv7MVC
         9hEJOr0HK2gpTirtZHVVQWOZpRophUAl6DwDeCDIic+WgtPCkU8zIQKBq2FNUDRjPKgd
         o/V8CpqpEiYJTkq7u3kY8J2aRdQRVqfbRI2mAMiU+7lifvXE9DPLMOFg51FbIj6HXgyA
         HnwA==
X-Forwarded-Encrypted: i=1; AJvYcCV1Y76khVtMHxwQD+B5we82aUH12epR7LTzhZ01V3BskWj61GTCaRL7A69tA18kIkW4P6U7dHJBBszEvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZr83VJuhGEXoX0/xbFCeR6HF2ie/aYmbLZ5MmXg/f7Wnha/Gn
	erkb5bx4pbMLfNDhf/UckbAVSOgAWYeDJiPqXkqlXig846P9PPB28cIU+WfrFOhFt2tl/BeLyY1
	Z2L62OPVa+ntZPVydnMj2HWOAltPmdfWTrD8pORTKpyl0gCr9yoyT2TS2Ysm/iHBftDgQny1WNt
	4J1ZEkIczGD491EmIz1t890RjkOd5+8vJyUvEVtlkC/Uad/pKpT2CtIrCd5KK2ZgW/P9Y/TP13T
	MG/9bzXzY+8bUccyVG5GWj/0tRlVIitpB1fww==
X-Gm-Gg: AY/fxX741CL8wEg8os1YE2/gAym3YzmoiA3GLTJOoxIFvFtsBsheOiTUOwc1x/zhi1X
	AOrVgnT67JHGyFxdSUQX6c2ZGmu+Z2SspjPAQ9SbDKK2plvIlV5BFyy96meB23sqWE+olyQcwu2
	BEXDHxsc3VpUdI+GtlqQVZcS1+8NVPersmrEIAYwtD1B1fE4HZ+vB+KFEBF+91jU0m9rveVoq6V
	qMlfHLwdrwEuNrlIOa68u3Nkq1E5VqL/IAnBvrKUctJpU9eduINsYSXFavD2J6esDc0tHqCWFAj
	CVqLkFm4Kh1bK+9Axe2ak67vUglI+npuvPihNHyWDAhTy2OgqIX8XsnZKy8qcszw6WyRoEzd8zI
	8+P7klAocABFD0tye5keWOyo2bq9lhZmiZEZj9zjPCEV/S4tuRlziuEF+cyrRifR24vA7i4CeSW
	yu2SLcTwiinrvhMMbJjw22qnQ40p7CFukIC8zly5nHFFkPrWYx/TLF42G0sd8=
X-Google-Smtp-Source: AGHT+IGnqsPG1PhWGiaH85BJmsPiteZfa6dm23hIxNa5A/rw/nkEfXi0O9VQlYbmXpzO8GV9ZVjTsc2SKTXI
X-Received: by 2002:a05:622a:211:b0:4ee:2638:ea2 with SMTP id d75a77b69052e-4ffb4a73847mr186929081cf.9.1768218170638;
        Mon, 12 Jan 2026 03:42:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8907715cec3sm22585156d6.30.2026.01.12.03.42.50
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jan 2026 03:42:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29f25dbe495so17179625ad.0
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 03:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768218169; x=1768822969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fzFvHeJhDdP4ilFE2+bLWYgTIbgx2yUf1NNqPTKhjnU=;
        b=hr7s7myzXDppYeBDqEA5fUIGcoPByswxXfPxIojG06oZOGZ2UbehVKRzSLtnZiOxTh
         mNCQ82cn3Mi3UV+OXLwXEp2FEvaW23kPz2daPd7Z/A45s10k/chs9WzoX5xwpNhwOmk1
         jS4IC+P4pIuLBS3orwsEbQbRRsobQTC5q6z00=
X-Forwarded-Encrypted: i=1; AJvYcCUFsos7e0rYTtNE8WUfCCNisy3ZfTj1n6OarCJSjsMyU6YcGTZo60MC1EPjzyLOoJHfaJgyOwHKUIfp5Q==@vger.kernel.org
X-Received: by 2002:a17:902:ea01:b0:2a0:9424:7dc7 with SMTP id d9443c01a7336-2a3ee4917d2mr129653785ad.4.1768218169337;
        Mon, 12 Jan 2026 03:42:49 -0800 (PST)
X-Received: by 2002:a17:902:ea01:b0:2a0:9424:7dc7 with SMTP id d9443c01a7336-2a3ee4917d2mr129653635ad.4.1768218168930;
        Mon, 12 Jan 2026 03:42:48 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c48c0asm175905495ad.31.2026.01.12.03.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 03:42:47 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: tj@kernel.org,
	axboe@kernel.dk,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Laibin Qiu <qiulaibin@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10-v5.15] blk-throttle: Set BIO_THROTTLED when bio has been throttled
Date: Mon, 12 Jan 2026 11:39:36 +0000
Message-ID: <20260112113936.3291786-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Laibin Qiu <qiulaibin@huawei.com>

[ Upstream commit 5a011f889b4832aa80c2a872a5aade5c48d2756f ]

1.In current process, all bio will set the BIO_THROTTLED flag
after __blk_throtl_bio().

2.If bio needs to be throttled, it will start the timer and
stop submit bio directly. Bio will submit in
blk_throtl_dispatch_work_fn() when the timer expires.But in
the current process, if bio is throttled. The BIO_THROTTLED
will be set to bio after timer start. If the bio has been
completed, it may cause use-after-free blow.

BUG: KASAN: use-after-free in blk_throtl_bio+0x12f0/0x2c70
Read of size 2 at addr ffff88801b8902d4 by task fio/26380

 dump_stack+0x9b/0xce
 print_address_description.constprop.6+0x3e/0x60
 kasan_report.cold.9+0x22/0x3a
 blk_throtl_bio+0x12f0/0x2c70
 submit_bio_checks+0x701/0x1550
 submit_bio_noacct+0x83/0xc80
 submit_bio+0xa7/0x330
 mpage_readahead+0x380/0x500
 read_pages+0x1c1/0xbf0
 page_cache_ra_unbounded+0x471/0x6f0
 do_page_cache_ra+0xda/0x110
 ondemand_readahead+0x442/0xae0
 page_cache_async_ra+0x210/0x300
 generic_file_buffered_read+0x4d9/0x2130
 generic_file_read_iter+0x315/0x490
 blkdev_read_iter+0x113/0x1b0
 aio_read+0x2ad/0x450
 io_submit_one+0xc8e/0x1d60
 __se_sys_io_submit+0x125/0x350
 do_syscall_64+0x2d/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Allocated by task 26380:
 kasan_save_stack+0x19/0x40
 __kasan_kmalloc.constprop.2+0xc1/0xd0
 kmem_cache_alloc+0x146/0x440
 mempool_alloc+0x125/0x2f0
 bio_alloc_bioset+0x353/0x590
 mpage_alloc+0x3b/0x240
 do_mpage_readpage+0xddf/0x1ef0
 mpage_readahead+0x264/0x500
 read_pages+0x1c1/0xbf0
 page_cache_ra_unbounded+0x471/0x6f0
 do_page_cache_ra+0xda/0x110
 ondemand_readahead+0x442/0xae0
 page_cache_async_ra+0x210/0x300
 generic_file_buffered_read+0x4d9/0x2130
 generic_file_read_iter+0x315/0x490
 blkdev_read_iter+0x113/0x1b0
 aio_read+0x2ad/0x450
 io_submit_one+0xc8e/0x1d60
 __se_sys_io_submit+0x125/0x350
 do_syscall_64+0x2d/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 0:
 kasan_save_stack+0x19/0x40
 kasan_set_track+0x1c/0x30
 kasan_set_free_info+0x1b/0x30
 __kasan_slab_free+0x111/0x160
 kmem_cache_free+0x94/0x460
 mempool_free+0xd6/0x320
 bio_free+0xe0/0x130
 bio_put+0xab/0xe0
 bio_endio+0x3a6/0x5d0
 blk_update_request+0x590/0x1370
 scsi_end_request+0x7d/0x400
 scsi_io_completion+0x1aa/0xe50
 scsi_softirq_done+0x11b/0x240
 blk_mq_complete_request+0xd4/0x120
 scsi_mq_done+0xf0/0x200
 virtscsi_vq_done+0xbc/0x150
 vring_interrupt+0x179/0x390
 __handle_irq_event_percpu+0xf7/0x490
 handle_irq_event_percpu+0x7b/0x160
 handle_irq_event+0xcc/0x170
 handle_edge_irq+0x215/0xb20
 common_interrupt+0x60/0x120
 asm_common_interrupt+0x1e/0x40

Fix this by move BIO_THROTTLED set into the queue_lock.

Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20220301123919.2381579-1-qiulaibin@huawei.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Keerthana: Remove 'out' and handle return with reference to commit 81c7a63 ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 block/blk-throttle.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 4bf514a7b..4d3436cd6 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2216,8 +2216,10 @@ bool blk_throtl_bio(struct bio *bio)
 	rcu_read_lock();
 
 	/* see throtl_charge_bio() */
-	if (bio_flagged(bio, BIO_THROTTLED))
-		goto out;
+	if (bio_flagged(bio, BIO_THROTTLED)) {
+		rcu_read_unlock();
+		return false;
+	}
 
 	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
 		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
@@ -2225,8 +2227,10 @@ bool blk_throtl_bio(struct bio *bio)
 		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
 	}
 
-	if (!tg->has_rules[rw])
-		goto out;
+	if (!tg->has_rules[rw]) {
+		rcu_read_unlock();
+		return false;
+	}
 
 	spin_lock_irq(&q->queue_lock);
 
@@ -2310,14 +2314,14 @@ bool blk_throtl_bio(struct bio *bio)
 	}
 
 out_unlock:
-	spin_unlock_irq(&q->queue_lock);
-out:
 	bio_set_flag(bio, BIO_THROTTLED);
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	if (throttled || !td->track_bio_latency)
 		bio->bi_issue.value |= BIO_ISSUE_THROTL_SKIP_LATENCY;
 #endif
+	spin_unlock_irq(&q->queue_lock);
+
 	rcu_read_unlock();
 	return throttled;
 }
-- 
2.40.4

