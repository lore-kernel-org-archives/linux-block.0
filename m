Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699D12F5326;
	Tue, 12 Aug 2025 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013385; cv=none; b=Dr4pc617Ct0y1BHJvLFaj48gYpgjn1F+znnlcyADdDlbMaWw4HijUH/dYYsUEbdUaPTqtNEeSNBxniEjj31uUbzeZL+vwygxaKFEtZXWMyugOFV8n3wMs95hG3eGQ/wOaG1p/reI/x8aVfoS2klYmHwSiv/muGwiQXm8BypWBV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013385; c=relaxed/simple;
	bh=4KwjGWINkvuaTEm3Y5vsr81fdJDEP3gscF5WZRv+MQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NJSzSIqt+fffLsIF8OlcBjcN1fcAUPkYW4Gb5MH6pMZjmC/pqCClfvGUkz6FyH3X2jO74fO0t1jwIxJAU8+THAhhXZ2JU45XpgmyCft0zgmq9Mde+ZD/DVbga4eFMtpzq335wIcevvBRiu9y6uVXolizIeVlo8jOD1OviGlzfws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9+g9b4q; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9+g9b4q"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76b77a97a04so5171199b3a.1;
        Tue, 12 Aug 2025 08:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755013383; x=1755618183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5TlR2dm45zB3zDxV9k31EaXpgNol1Ph4sZyH3/scZbw=;
        b=G9+g9b4qrMntZFOkojOcjvYPRwb/32ZfFyJx/XHBmHrLUPfVY7cwIbCUu347wQhmY1
         CO3JnBl9ElTpZHFQAbskRH/LL/LzC9oM8BUQ9iFr6/ZFGxjiQRofJXwrhW30NPWzDDwF
         dFTuJGhj/4SKzrS77t7GBdDS0phLAgJLLo2y5LsKs66364npyEPSxfPQUqg6H9l3oOvj
         JRajPa9XWrq4fAP4sMrKG6XkJR8Mn3yZPmmDb4a4M+S7o61eFF8b0YzdWAZtt8gZz0fU
         maXL2EhsiN75g3zuu3MmfEC/HcQCUivcCZwePG6AEtA9sdT5yDPddnBaGoHkMW0D7XP3
         J6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755013383; x=1755618183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TlR2dm45zB3zDxV9k31EaXpgNol1Ph4sZyH3/scZbw=;
        b=JCuB9705QUdh+Eg5OJWeJPrVIKVQw1/CAcHyJUxgZrorgBVnH2/mgwhyl2d/IoKlYG
         ashL5b4PK2Mp2ktlws8fPbGK3syf7OELIeRTUXErqabIslZQX6uVKTU3rOr0hqQZPG3F
         JRA8jtVVZ7BrDieAooDv7AU35XU8n2YTeccVceJIeQr/MrOYETbWgMcfWUAhLYWasb4E
         Z8040yP8Pvu/MEhRe/HAE5jNWSzVSRIKJ4RxPRsmDjIgPZzMzP6TJLLmiXXkDiABieEM
         I7NxUsfV07O6BRw+Pl+z3GWazq/yY0swZVl1VG/VWWc/tRbvLMmZgILMAmOveN0o8D4n
         t84A==
X-Forwarded-Encrypted: i=1; AJvYcCWZFjOuelPb0I5AICNUWQ1Jmk+JfjJIjYuIxjpKHaWdwI7ivg5Seiclqk9GzLooEjkCLwLVRb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUMykB866QH9FgQLBnKxRloRUVhWJFflm8RLFin2UrLe2cv1y9
	+FE21UqvIUygP+CEDiUi86FCcKI5XJX2BSfwrZd1zX2ymPyc0MvHs2H7Cmyq1jS5JOg=
X-Gm-Gg: ASbGncvOY5nX7pNA2H2PpMwcCvDTx4OJ9K/rm3+sWjLUv/wG8B6KIGMiXEdkDt/vJrr
	8j/Kf6HheW2auqgVKNlSpeFN8PTgBj4Za0Xx4oz6R3iX7kAm4I//tK808X4CXz5Qowl2IAmIb0x
	p0aRuOyClRxD4WMOlfWOoG37fGzL96qTE3ygjb2E2GqcYcEmFW6DD+J0etFqPpg2CBqWm6aWVgX
	R3ZPJpUhPaQ7Mg/23gfYjSb0eEjyzv691jmrVOG+euxP7erT74Y+cLb5ZZvw2jZXvW9+v5C/Kcb
	6x+b6gTvk5zHaiHGx0gbhhirirYZsbmDjgZocZNC5pYKZYciBVMe6XwNcoDqC9iNGzyLxGFHkG0
	jZyiDpR8lIwahMNS/053ncBPg6w==
X-Google-Smtp-Source: AGHT+IG4BZ8IR5xS4UjYPhb4pAe8SqTn4uufDEIytT+ZLG2o2fNILp7p2TDdhh0IxCmthRfKc2jeRA==
X-Received: by 2002:a05:6a00:3d4e:b0:76b:f24d:6d67 with SMTP id d2e1a72fcca58-76c46193b4fmr24071426b3a.13.1755013383244;
        Tue, 12 Aug 2025 08:43:03 -0700 (PDT)
Received: from localhost ([101.82.110.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f319sm29815344b3a.18.2025.08.12.08.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 08:43:02 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
X-Google-Original-From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	Julian Sun <sunjunchao@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] block: restore default wbt enablement
Date: Tue, 12 Aug 2025 23:42:57 +0800
Message-Id: <20250812154257.57540-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 245618f8e45f ("block: protect wbt_lat_usec using
q->elevator_lock") protected wbt_enable_default() with
q->elevator_lock; however, it also placed wbt_enable_default()
before blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);, resulting
in wbt failing to be enabled.

Moreover, the protection of wbt_enable_default() by q->elevator_lock
was removed in commit 78c271344b6f ("block: move wbt_enable_default()
out of queue freezing from sched ->exit()"), so we can directly fix
this issue by placing wbt_enable_default() after
blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);.

Additionally, this issue also causes the inability to read the
wbt_lat_usec file, and the scenario is as follows:

root@q:/sys/block/sda/queue# cat wbt_lat_usec
cat: wbt_lat_usec: Invalid argument

root@q:/data00/sjc/linux# ls /sys/kernel/debug/block/sda/rqos
cannot access '/sys/kernel/debug/block/sda/rqos': No such file or directory

root@q:/data00/sjc/linux# find /sys -name wbt
/sys/kernel/debug/tracing/events/wbt

After testing with this patch, wbt can be enabled normally.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
Cc: stable@vger.kernel.org
Fixes: 245618f8e45f ("block: protect wbt_lat_usec using q->elevator_lock")
---

Changed in v2:
- Improved commit message and comment
- Added Fixes and Cc stable

 block/blk-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 396cded255ea..979f01bbca01 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -903,9 +903,9 @@ int blk_register_queue(struct gendisk *disk)
 
 	if (queue_is_mq(q))
 		elevator_set_default(q);
-	wbt_enable_default(disk);
 
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
+	wbt_enable_default(disk);
 
 	/* Now everything is ready and send out KOBJ_ADD uevent */
 	kobject_uevent(&disk->queue_kobj, KOBJ_ADD);
-- 
2.39.5

