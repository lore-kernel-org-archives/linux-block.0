Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59885610B;
	Sun,  3 Aug 2025 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754228489; cv=none; b=pTqGFP9v9b6Fk8B6M0Me2xgUT2v31d8qWJESLgnVeW9eim4oc1oCBAFwFxz3S1dZpvssyEhr+o2PG7s7rxUSuQADsbJp7FyCQQEDj38ybRw/7Ac3/Mr38q2sMThigWUHMS2MKVzS1mtNhEJVCQeWWxmVyB+1dXmaBUIYtZNTBZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754228489; c=relaxed/simple;
	bh=NzahJM/qXvaAtZPlWJSH7+w9oBiwFnpmsBYuEkm2tCk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wa1nY/D/RgPY1cj8hBCi9oZGjPKjzhhBkjdgdSGyZXWytdXtiKaYYRWtIz2eclaA5zuVLZ1kB51422mhQMnAdpRBms8HKHXQCE+AGHzqYnGxBa/nZo3yGwmeMxMjRxmzotRfJQ4ZTauCWoVFWIhY9Y4J5L2WBbS8jdvzndzeOVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YygKFdfC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YygKFdfC"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76bd2b11f80so2775960b3a.3;
        Sun, 03 Aug 2025 06:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754228488; x=1754833288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1SHdn/fg9AJZe+Y+Slue3r8BVmN7+MveNMTvGGD67uo=;
        b=YygKFdfCCzI5KupMwhHlb9NTH3X+BwerCjfyW6s/jZA9GMtAeYddOArWBhDJZV4DUU
         wO+9wBB75aBzpQ3DnFmq4xiq7MSPS1Yw2HHmj9pHuNw4OBHHao6hQ6Z3Rl0aoT5Ejn5W
         QCMTvibCH9jnsu7NV/0cen9C0ikMyQLLqJ5BqUNxSVjZt7fEYuFZHyBGC+bF9JvP7jgd
         2SvGkCYHhRF7aqYVHfIc+C51utQlRVAd7A+31PZbKQtGxrANXdW/1is0Tt97h1a8wVcV
         lsLN+Oxu4ddNA167y2TSpQvbxaZyY9TL6mdOYbrH5WSS5zG0yDZfbE8GTeAJSTef+MKY
         sbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754228488; x=1754833288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SHdn/fg9AJZe+Y+Slue3r8BVmN7+MveNMTvGGD67uo=;
        b=Q6SCLuLknf0SpyPv7hmvTfi8fpD6+2AEx3YT5KuGEmsJg8ni6QEO0kTXLiP570qjCR
         WdRDtLuGd1YGbuF0DKlBSc06imBn6+ytOzN1TiqgyRq+ILBbUsYdF5P6kZLKEiNmlOW2
         cv5HwbCgRjOV8xk03Xh8wzJsQZktRhUjj2Z3P0vm4lTmil0NPOxOjIdno0cJsIixKLwI
         JdayxWBnOXkes678FDNw3mAAh5sS//QPKLIJ25gTd1PVekjI0v6lAehARNcxjkDk9Oil
         7ct+JPtHFiyqnua4SlR55S9v2Iv2viEfDH30cQjyKil0jK8gMgcs8DymlbcC7bDAR3nW
         bP2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgFprA6cRYoF1bmEXcRv4bJW9hygPGZ/F6AjV2tTVFJTAct169zJeb3I2LigZI3tgfVe52iXNbqh06tQ==@vger.kernel.org, AJvYcCXbxToRbyMBWGuCaSmUVmFt2/eVnvHzsD23U2gTWFA5i/wQ0oORcffHQbyOX+I2rKAe5ayHg3Dr8ZPQjFF+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/AP7Y/Dfo43aJ86mvccbw0Q7hm4YvS0bSHkhU3RuqGh0M6UML
	ZHbWjmNdwsAuLNFpKo6x1Swa/qX1KrHtjg4vx2W221sAh2DE/DaHXZY=
X-Gm-Gg: ASbGncvYXx7bD3f8hrtwim14j3JrQIFDOvzHoYwo1FcnkaumMK1WIeMKstDvJUfjMvp
	HYNkuyFTPpqoh0/VtYFuTwiR3O2KK29T1yh/YzyDFQvVBwR11AN+3SAQv+UImbSIyDNZlFcEIo/
	IHOSOm5bD/tF1Ln+t2LQ6pKvhi3mnWH2Wg16dk7hBoDQ+p+xmvUq6FaqaZAEXzMMt1/QQNY8tww
	Yj+uFA2zIZ249T6vKxSKsRh021vKypI+hA7PUYptIN1I4/yxcKQn5hMRM/gjpjvr3PqxEfI1Jbf
	u0a0j0IFZSajqd45vH/rQk6QoeTUKFUgs/uSWLz7SzXekMxyCEmTIEcHX0PusRvEXrcmzeA+Ex9
	3/sKmFB8FGtU04mUscds0ide+sL33KFRCXyYm+d37XAiF
X-Google-Smtp-Source: AGHT+IHYuhegANMq8LgpfY3tGBWYgpoyv2gR6tEBT0MlkRnU72IUaj3FllTqOJ/0pHOMqNu9mqApjg==
X-Received: by 2002:a05:6a21:99a5:b0:220:764c:9edf with SMTP id adf61e73a8af0-23df9151731mr9277531637.40.1754228487577;
        Sun, 03 Aug 2025 06:41:27 -0700 (PDT)
Received: from debian.ujwal.com ([223.185.131.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccead450sm8337537b3a.54.2025.08.03.06.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 06:41:26 -0700 (PDT)
From: Ujwal Kundur <ujwal.kundur@gmail.com>
To: axboe@kernel.dk
Cc: ming.lei@redhat.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com
Subject: [PATCH] block: prevent deadlock in del_gendisk()
Date: Sun,  3 Aug 2025 19:11:14 +0530
Message-Id: <20250803134114.2707-1-ujwal.kundur@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A potential unsafe locking scenario presents itself when
mutex_lock(&disk->open_mutex) is called with reader's lock held on
update_nr_hwq_lock:
       CPU0                    CPU1
       ----                    ----
rlock(&set->update_nr_hwq_lock)
                               lock(&nbd->config_lock);
                               lock(&set->update_nr_hwq_lock);
lock(&disk->open_mutex)

When the gendisk is added back concurrently, a writer's lock is
attempted to be held on update_nr_hwq_lock while holding other locks in
the call-path, becoming a potential source of deadlock(s).

Scope read-critical section to blk_unregister_queue, which is the only
function that interacts with switching elevator and requires
synchronization with update_nr_hwq_lock.

Reported-by: syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com
Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
---
 block/genhd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)
 mode change 100644 => 100755 block/genhd.c

diff --git a/block/genhd.c b/block/genhd.c
old mode 100644
new mode 100755
index c26733f6324b..b56f09f5699b
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -696,6 +696,7 @@ static void __del_gendisk(struct gendisk *disk)
 	struct block_device *part;
 	unsigned long idx;
 	bool start_drain;
+	struct blk_mq_tag_set *set = q->tag_set;
 
 	might_sleep();
 
@@ -740,7 +741,9 @@ static void __del_gendisk(struct gendisk *disk)
 		bdi_unregister(disk->bdi);
 	}
 
+	down_read(&set->update_nr_hwq_lock);
 	blk_unregister_queue(disk);
+	up_read(&set->update_nr_hwq_lock);
 
 	kobject_put(disk->part0->bd_holder_dir);
 	kobject_put(disk->slave_dir);
@@ -808,20 +811,15 @@ static void disable_elv_switch(struct request_queue *q)
  */
 void del_gendisk(struct gendisk *disk)
 {
-	struct blk_mq_tag_set *set;
 	unsigned int memflags;
 
 	if (!queue_is_mq(disk->queue)) {
 		__del_gendisk(disk);
 	} else {
-		set = disk->queue->tag_set;
-
 		disable_elv_switch(disk->queue);
 
 		memflags = memalloc_noio_save();
-		down_read(&set->update_nr_hwq_lock);
 		__del_gendisk(disk);
-		up_read(&set->update_nr_hwq_lock);
 		memalloc_noio_restore(memflags);
 	}
 }
-- 
2.30.2

