Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2EC3A1B6;
	Mon, 13 Jan 2025 01:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736733527; cv=none; b=UvqcfYrHeREdZen/nIGAhhUD5hppWxYwrp1oIPzbcGWp3u9u/RE7szTzrDKUmfoWQcbY/4ocXlW3+nIeoKpcFKuByCI0FWnpqLrL3N61qJuktlWR4Y5x6x6uNFw4YA5aHTXUjquByHeXPliXpO2CBFndqs8y9kx/quZh+ZDr+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736733527; c=relaxed/simple;
	bh=9aCUv+nII+odgNdk1JJZku5rZHttRhgQ4QJRP4yEPbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HobUl69UAgmGGmXXIMdU6v74snDjYWwJffEcvPthlDt5gnxsCRuY98hHkIIBdZrswLtAMPlrr2Un8/VVRF+e1vzBQ6bMzizgaaXX1wVGGk86KfPPNS8jk+wGkL6xZAeXZJZ6nLvryIHG75NXoJQfDnEdGWxGgnybQlg2AZDIj8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7Fo+oED; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7Fo+oED"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21675fd60feso86639555ad.2;
        Sun, 12 Jan 2025 17:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736733525; x=1737338325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xvFctOzfkbM6YFUaHGSAdmurfkwHLGW3Ooy1E278+YE=;
        b=h7Fo+oED/Thsw8VGRWZyDagQ5LH3rfzWf4WN5Svo+vRU40M2pbRF4dAQt546l+Qj60
         YiDeibqxJUK5YxpFyVe4vDOB6gtlYVhrfCpB5zvqChdhpSV6TtUUgUiZZKhymLG0sRVc
         QGaH+gZKeiqNSlqLEX2tzlsu8Rf7W6i8p9+ey1JveH3TfbVf2rRrPdXKoBNkA93QOPfJ
         rIRvANYiFAeEa1QFCH8EL8X/cD9YUv8BGyDGOS8OLe/xWZaV5nEEdaVFnpQKGgfT1fPQ
         /zpb45p/av8ZER1UwmOB0Tfx++zvFMiKomgmP79a5r293ky45/9BCHYBcaJWWZLZnw9T
         K7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736733525; x=1737338325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvFctOzfkbM6YFUaHGSAdmurfkwHLGW3Ooy1E278+YE=;
        b=AEwIpVvgQ/gDY+jiqCTv5wcfkzBpAsS8yHJxhXqH5o/CacBmpujTtfAnHy4lGWcMOd
         zcqpmUQSXXoJENoJxoEDepoI/lYK7Kdwee/0ajedS4ucKj6icLQu+vb13aTS0S4AcPeK
         eJZmj2GtRlWVxPveuTuIJGVFdwoUhN/cy9p33hW9UmN6OErsuUkxaIiQzfACQ3VutjxW
         G23meperr3vzhB3sC0cFXf/sGVuctPU4dSw1RrW/PD3WcqJpwnLwHpuht1Kl+Gkj0BXn
         Lve//OqDI6FdGcHOIA/OLz1aq6LHDOZXDGuXyKt97idxuYCnQS0HwsZlvEShLx8YKFLB
         xShQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDy4ddo2Zg0v5/cDRHDntAtd0G1MFD0+SbKmI7Az6QKI3oE2iF5R08+k9rz/wdEdwL1PGWiwQ3@vger.kernel.org, AJvYcCXjaL6jUjYHZyNbkLgKSMoSj3BnXf8J859lq1uVySBBxZVKs+XLHwYMxzUUudChL0gvXDeKmuxM3d5E9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUWwSOCOD8rMdeLtlTNyOufvHWcRVflbuowH1vrroZPPIf7OrT
	brfMAfSHOdMTuEqMAOitnWKBICkjCpSdxv837vXRy3Q/9VSaCJi3
X-Gm-Gg: ASbGncvfCWtJz/I9F44synwGa7GSkGu0xAJly2I/ehO22nXiM56C/uTofu2gWRNir27
	w4hzdw5MLrOlo51l7xt6eE18HcnUL30izJB6nallSzC9RCNb4HdE2nhR+8wYMvugk4wRbZGrJXZ
	MyWbmlgoVqoMgfY1x+4vA1lLpnUHq1Wcn0X/zeI6++7uhVl3Dl7FgC1cPaE6zi4y71GhJLhEH0T
	/sxH092NLGCj4ObNVzoHYwz5dywUytlHMfHv9Wbkt9x271n8Ec6J41ACyQJBY50pg==
X-Google-Smtp-Source: AGHT+IFPsGTN1Wgb5SXcwLhJac/YvmAIbK+bXhKuNAOvTk0WJqQXzZwnfQki7/ONQ9UoIUQS4I6TCg==
X-Received: by 2002:a17:903:41cb:b0:215:6e01:ad07 with SMTP id d9443c01a7336-21a83f48e7bmr226936875ad.6.1736733525101;
        Sun, 12 Jan 2025 17:58:45 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffaa:4903])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21a9f12f93fsm44380355ad.65.2025.01.12.17.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 17:58:44 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
X-Google-Original-From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] block: mark GFP_NOIO around sysfs ->store()
Date: Mon, 13 Jan 2025 09:58:33 +0800
Message-ID: <20250113015833.698458-1-ming.lei@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sysfs ->store is called with queue freezed, meantime we have several
->store() callbacks(update_nr_requests, wbt, scheduler) to allocate
memory with GFP_KERNEL which may run into direct reclaim code path,
then potential deadlock can be caused.

Fix the issue by marking NOIO around sysfs ->store()

Reported-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e828be777206..e09b455874bf 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -681,6 +681,7 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	struct queue_sysfs_entry *entry = to_queue(attr);
 	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
 	struct request_queue *q = disk->queue;
+	unsigned int noio_flag;
 	ssize_t res;
 
 	if (!entry->store_limit && !entry->store)
@@ -711,7 +712,9 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 
 	mutex_lock(&q->sysfs_lock);
 	blk_mq_freeze_queue(q);
+	noio_flag = memalloc_noio_save();
 	res = entry->store(disk, page, length);
+	memalloc_noio_restore(noio_flag);
 	blk_mq_unfreeze_queue(q);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
-- 
2.44.0

