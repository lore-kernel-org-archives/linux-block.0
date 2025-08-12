Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2859228725A
	for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754999025; cv=none; b=U37KMuEvh7hDbv0bjRRLWsBcXpymYio4iHAz3/94YMsxFUL6isqWwoy8FMAR9FO98SVmDEXd3wxEFQfXAjfaNHtQQDgZYvOtWXz88Rmk6HVRvWoOFLak2CPJHN/XNzRVPwc6qB7SwEF1tBecXHD6niIMMDeahk/OCtenyJ5M1IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754999025; c=relaxed/simple;
	bh=Klard7EodHx0BuguwRKimp/xR9gKIXujt8Mznl3SBwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FGhtBIyd9dn/4fqO6X+z+CrH4qrI6dRa3Anhx6EKTxOR7B4r3KCRlxq3VG4WHtr2RF0pkQbGkhH1YnUuB4NqgQvSfHlAmQKFaeg+Z8vrGbOEUAzPl9kPa0e8ilOU1YhWBeQ2u/SawQVOiAyDSR7XoAbBPqfJB8c4/yhtfj7xWFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8nImP1f; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8nImP1f"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76b36e6b9ddso4531618b3a.1
        for <linux-block@vger.kernel.org>; Tue, 12 Aug 2025 04:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754999023; x=1755603823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4XtgVGWvwVfPQMmIu4LJkUy6MRizS23edvVNQ5h9lpk=;
        b=S8nImP1fWxj/yY03epIwzcCjPDjbHMy5VfdjDB7Otm72dpYPLzCWYmK+mDEJXQRneG
         7J+uwXr3+Na/OpQBdoBvMyzm12CWj5EsJfqqswUnmf29lXD6GYcLH9z5WPZThoQoMk1N
         Ojn7h2d/84ZrV42cSjCv2bbuT1as16JpNKUic8bcSNkxsF2Cgx5cq+Jiz95z28vlb6rR
         to3zIoJeOCYMdB02EBZV9a4GIMOBR3y/apQF14OLWM0+fkGaXozV0t2897RVpUxg37q1
         +IE3Wf70QoPknDfVtinjg8zWMX6lDl/e12yunvYIZXVtAYsL5jLkwGY1+Uoj4LwmNH//
         N5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754999023; x=1755603823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XtgVGWvwVfPQMmIu4LJkUy6MRizS23edvVNQ5h9lpk=;
        b=WhyFgif+8/bKxp5bYXzEUwNo6XJlnPTzHVNI7Np2bIjJjg2IjCsd28eDGe7f10a9sY
         GF8PBston3BTW5PxDMK/hut+pT9I0wfQNufDLE3FLYlAr7E4+DAncGWOOdBVIEVz41ug
         OsG5cCXQ0jDnlWQE5GRmv6JoArfUJRwnjkkJTFfRT/b0S/yZaIxPR6boDoxuyO9e4T9D
         OMVMQwqq7ioRSU7rgwSDj/SAVKIRNwr6qmadFIl8ydI0dDe+ByJmOtX1e5dNORC3Dhm6
         gOQM6DGjprs2mpC4wEAGo8nxv2ELxC2aW13/4DMCN6BiovRo8eTCfCsrNTgPjHn6tcDZ
         wgQA==
X-Gm-Message-State: AOJu0YzIrJsBghDNtTiWs0c7uhBm3rQXkNvx0OWY2yc5nAunBZ9cVwXT
	ki55lDQ+PyCvm7kzUK4x2B6/B0fZikjzc5X02R1HubvmDReEa7L5h1yRld+xK3uHWsM=
X-Gm-Gg: ASbGncslEtxBl730HLlGChmHm0V7/Kvpy/LbqPNJG46wMBQwBgqHQPlfOpaBP3yLIXD
	0YQj/OueFbkWJlHlgWv2EtLzLQgj1xmft2h8lkNkUxiwl6WFd2Skx+mJH8hQrli5asfK5xYqJS8
	3lH403vc8y0jg40QF/K4UMGnmRiKv1p4990g6L2nOur2+OUK3ARY+nzI8ub6+o+8E8hxk5zzFJp
	EabbSSH98nG5GA5NJY5rRWHVz3gmKCOrt5q/UDeCrLur83FDjDD9avb6BJ1DDSDtjAsuivUjTFX
	HtmIQ8kk3HVI9GpAdWsA5clQ9DY3A2Cz5ViAPVp8wD0hMFyue0v5xGoslcmAI3artICf0VHnc4L
	eU59zluFzK00Jm15WQ438BYorEe0=
X-Google-Smtp-Source: AGHT+IGQPQeHk++HXJbjfh7lgb4g3Bw01j92LnuTfJbLj4UN8VyQjJG4pIwNt0wd+N23FB6VqRP2XA==
X-Received: by 2002:a05:6a00:1411:b0:76b:e805:30e4 with SMTP id d2e1a72fcca58-76e0df724eemr4737835b3a.24.1754999022962;
        Tue, 12 Aug 2025 04:43:42 -0700 (PDT)
Received: from localhost ([106.38.226.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd174sm29250526b3a.63.2025.08.12.04.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 04:43:42 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
X-Google-Original-From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	Julian Sun <sunjunchao@bytedance.com>
Subject: [PATCH] block: Fix wbt can not be enabled.
Date: Tue, 12 Aug 2025 19:43:33 +0800
Message-Id: <20250812114333.1252987-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 245618f8e45f ("block: protect wbt_lat_usec using q->elevator_lock")
protected wbt_enable_default() with q->elevator_lock; however, it
also placed wbt_enable_default() before blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);,
resulting in wbt failing to be enabled.

Moreover, the protection of wbt_enable_default() by q->elevator_lock was
removed in commit 78c271344b6f ("block: move wbt_enable_default() out of queue freezing from sched ->exit()"),
so we can directly fix this issue by placing wbt_enable_default()
after blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);.

Additionally, this issue also causes the inability to read the
wbt_lat_usec file, and the scenario is as follows:

root@q:/sys/block/sda/queue# cat wbt_lat_usec
cat: wbt_lat_usec: Invalid argument

root@q:/data00/sjc/linux# ls /sys/kernel/debug/block/sda/rqos
ls: cannot access '/sys/kernel/debug/block/sda/rqos': No such file or directory

root@q:/data00/sjc/linux# find /sys -name wbt
/sys/kernel/debug/tracing/events/wbt

After testing with this patch, wbt can be enabled normally.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 block/blk-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index c611444480b3..eaa56040ae0f 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -877,9 +877,9 @@ int blk_register_queue(struct gendisk *disk)
 
 	if (queue_is_mq(q))
 		elevator_set_default(q);
-	wbt_enable_default(disk);
 
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
+	wbt_enable_default(disk);
 
 	/* Now everything is ready and send out KOBJ_ADD uevent */
 	kobject_uevent(&disk->queue_kobj, KOBJ_ADD);
-- 
2.20.1

