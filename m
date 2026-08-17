Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F5337DEBC
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996725; cv=none; b=QyVhG3gy/O7iPSUJG5E0NuzOG96ne6zls0bGoAYMWKpyB1VQE8MPDbn+J5++87XVBTePQ+cuaW/f360wZXnf+0iO/3egCtva/CfqtxDbbDkYDZob2fIRgAdhYjue0D5yaRSnnsIm0yMYc1fogjN4+AWMlxxBS9YYIWjDfiISBmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996725; c=relaxed/simple;
	bh=3kdGur1RV6b92ftSlCHAV13+42PYybUnG0pG+ZcVj9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fxGlQjMgXJpCwX3Tap5dNmJ5VK16Hd45uYSHOoptRHBHpMtAt3trtO7II6DXs9pvKAQA3Fe2Uj5qunAj3GUWVkOlFyJ4N6MC+uLFwZcWhbAz8Tp5MKQ8Pwbkbpqjp6Jbu4MYf/FIgbHB7UrzjmnVjPIhBUpVi89wSKn17cd9+Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6X6SXYK; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6X6SXYK"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66bd7857841so2853394d50.3
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 12:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786996723; x=1787601523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DNgthOkzOIwSYoONFQE8WtRQQRfyd1d/NaQ7aCZcivc=;
        b=U6X6SXYKISsrmEBmieGTzaG2qy/PLzxX3ziZQzUZCqLrd0CCoaJ2AVM6I67b9IMZxX
         hSGzclkXTzgaAr0vqh8A4zSxcVbHIAKYl/JX9WmB8tR3ARlOEgel2mOQLO5iUnFe5tAm
         /pteWoWam2WllVB/XvgWpwLUJGcPCbvj+7aJT7Mt1FY1jpa6xcvuWwlgsVckg2lwbJiU
         ZFAmimkx4wqbVnI5T2MuoVKLFUvTRGs7rYIv335Vf9xS7YSzn2HSdiF1KmjHoVVgxRJJ
         U0hm7MOKl+yaISjvjkzH/TJkmeVck1BuijV0x3NqU+R6vcjxGyUBXCBtgoI6lp2vCq7l
         +S0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786996723; x=1787601523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DNgthOkzOIwSYoONFQE8WtRQQRfyd1d/NaQ7aCZcivc=;
        b=g0JV/VafhzcCr8ZW9ZBiJ2L0lGicXZRqgT6sD+PCacTF2CQV+0bd4AmQCgkBvxS/Cd
         00f5QMMPl//DCzmib0H8HriIJQeuiu+ogU5GLhYuvOn0211usgIkKOSSKsTW5HKdui7X
         ybzyLF+dLgBZteJNLeNff4MGLIgNZT11PP+5ScnXsqIchAO6aQpAhOsIq+DEfl90DvBs
         luMLu/hATTHrQ+DlBcu/71u2/LnDV00q1P68MY7JKg7Kg9tFnDOed2msrbrWXmEibHT2
         5SWIIACNqOtIHMsRz5RRUxgu2LR/+SHLTxGtZ8pSFL74cfPmvP1qvJOT4z2qeg7otyI8
         IDVA==
X-Forwarded-Encrypted: i=1; AHgh+RqhWH8zO91pW6jpnaKbT2wNAulh1Zn/zGpzmSQ4l4AH+sRvM/ho1t4qpsL1WcuxI0bgfXa5GyT/8woDxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDWf4BtEhbw+njUTp7sueN0W3WfHmb/D40C4dPTh6g2zzGQkon
	AieXF18+K+yvfVmp1GvK0CxlYKQEiveuh8OcfKDTjqbtxg+fNRq3pEDEYtwKY1nw
X-Gm-Gg: AR+sD11LukD4IR7zJscizjZY7fR+3byVTHPRXZh6VsDrpNKxRzen1jrLjIWNdvRT7e9
	Qgv1+JTtLVvKDVIE9IARCzo6Is0N6Qr4+DbKSP/Zh75bpbLYUZCfd52P91HbJFRVHOy/CHjZszw
	mo4ajQYeD3UqYzqOkuwPIQQPQt+gkX+2ciHSbjBSc5qWOgPS6h1jPulyHkwJwWOTyKBwGC8yOuj
	vQbYZudjo+prnbLCsBJXuTKgJMpj6wvgWF55g3gmTadKntOsap54obdh2Gk/myQVs262oSNJvFp
	Z6ZGO/Yu82ttBiZxdnsaFeCteu4NevhP4yhvoqidQypcFP2xYXlCMziJT0NNb4aKLkcE+0XUmTf
	WnXM0YakuOYr/mtrAKKXmv+ojDDNvWmOkQgFmJ+TnBuyXFhM+dqQBcFORcE/T+mcUipanQ6KQhU
	ke9leqGpH6dVbH8nJd2baZnRFvX5ABXNRzgldPCJDHxXDfAQ8zEVaPwlBWva46V9K/B4kEBBBKM
	afgC8s=
X-Received: by 2002:a05:690e:150e:b0:66b:3633:c31c with SMTP id 956f58d0204a3-66c72d2e7c9mr8499167d50.46.1786996723031;
        Mon, 17 Aug 2026 12:58:43 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cb3eb8367sm1280628d50.4.2026.08.17.12.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:58:42 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Weidong Zhu <weizhu@fiu.edu>,
	linux-block@vger.kernel.org
Subject: [stable request] block: stop the timeout timer when releasing a never added disk
Date: Mon, 17 Aug 2026 15:58:27 -0400
Message-ID: <20260817195833.2971170-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please consider the following mainline commit for the stable trees:

  26cb8ebbfaf7 ("block: stop the timeout timer when releasing a never
  added disk")

It first appeared in v7.2-rc6 and shipped in v7.2.

Why it should be applied
------------------------

disk_release() undoes blk_mq_init_allocated_queue() for a disk whose
probe failed before add_disk(), but it only calls blk_mq_exit_queue().
Nothing there stops q->timeout, and that timer rolls forward: it stays
pending until it next expires, not until the last request completes.  So
if the driver issued any I/O before adding the disk, the request_queue
is freed while still linked into a timer wheel bucket.

That is a use-after-free.  With KASAN it is reported in
detach_if_pending(), enqueue_timer() or __run_timers(); without KASAN it
shows up as a general protection fault in the timer wheel, in a task
unrelated to the driver that leaked the timer.

  BUG: KASAN: slab-use-after-free in detach_if_pending+0x30c/0x340
  Write of size 8 at addr ffff888004d71310 by task kworker/u8:2/37
   __timer_delete_sync+0x156/0x240 kernel/time/timer.c:1621
   blk_sync_queue+0x22/0x40 block/blk-core.c:222
   nvme_sync_queues+0x100/0x150 drivers/nvme/host/core.c:5362
   nvme_reset_work+0x138/0x930 drivers/nvme/host/pci.c:3264

nvme reaches it because nvme_update_ns_info() submits Report Zones or
FDP io-mgmt-recv on ns->queue before the disk is added, so a later
failure lands in put_disk() with the timer still armed.

Which trees
-----------

All supported branches from 6.1.y up: 7.1.y, 6.18.y, 6.12.y, 6.6.y and
6.1.y.

The regression was introduced by 6f8191fdf41d ("block: simplify disk
shutdown"), which is v6.0, so 5.15.y and 5.10.y are not affected and
should be skipped.

Backport notes
--------------

The commit applies cleanly to all five branches (checked with
git apply --check against block/genhd.c from each branch), so no
backport is needed.  The two helpers it adds calls to, blk_sync_queue()
and blk_mq_cancel_work_sync(), are already called from block/genhd.c on
every one of those branches.

Thanks,
Chao
