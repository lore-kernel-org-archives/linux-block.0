Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F4E3D8116
	for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265063; cv=none; b=RqmBBRkdKNvKqOZ1QyhEXRvukQW6973gKGGGxYjL7cFnk0vOM5NC7jtJkvju8tUl+6RGZRa/MwCZRPObr7c4TEPEqGbpZ0Ao7IYEXNDafxcLCEQrv7D3BV5B911CnTqGCkJIobzflqBDBmALZzHW+c8r89cu8yxjqrfCyWzDHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265063; c=relaxed/simple;
	bh=oRPVzB//4GPr8E0X8MsyD2ixptlJ7tiaxlRsENmd+80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k3ojqAIBk+mMAGv4p9hKBBiyXevhjgZhLM/nOa4XjCLTpEwnwL+G5amNtNp1YueCjPKe3vYnoW/qkzLWe5HrGbNQNaVJY3B17GzZG3GddTPMX8f/FUBD+V9cXDjnzHOghd997jY5pUr9kZrus6fi9WPj0WxNnWrpVexpgjVDbaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOo/peUu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOo/peUu"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ad21f437eeso40968865ad.0
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776265058; x=1776869858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s9z9SXjdbKZ8KdYoMVn9DyECDnpTcqUx5ESLC0ZLnEI=;
        b=kOo/peUu2Xf/w1s6n+FKrKJxtDH71Dk/JwWWrAPcUs9hxeI14ZAEK1Kd0oBkfTA3El
         1RDZrRimPW+9QVHU1H8n1RUMsuWHrD+AmTGQrZpPKcLkYMEGhpsDKFo8LyNAfXfse9m7
         XhsByjdXfwrf0GDR1LHZ2zraToMh19nEGk7gWvlhojfetEkNV1rnmj9PK/hGvxvStWy6
         3Ty9igVKzQkBi+sICugpvHp5d1EBOhe8+ZQT807ViNY8oPz/BAdKj60P+sTcij70IPfs
         WfFn95u0z4K5gs+pEgXisSraczBbe0ApgKiyUFZyqtKZlHE+khAXSki7tCQgzcSkcNGp
         kEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776265058; x=1776869858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9z9SXjdbKZ8KdYoMVn9DyECDnpTcqUx5ESLC0ZLnEI=;
        b=ZMmHJ+iu3n8g3GEzg/qfW1ZeIfRQS4BAyky1RHY3YLcXJz8v0g8l7lXp+18iQvtGBw
         xXmOFiAZMYSGfXckrqd4ycE+Z74+Vr8Lbh7AvG/49GUQTz2mtN1heVuJs6NJYLRhQ4xb
         5Ll2EsWE21YIGpQRxO91Cx6JZD4Lia3FnHDUMPm4kiPetwzsIxN0IcqaDxS3A/keKwA3
         HYupaFoBqppZ4/a5WBVO0dRrpfT7Y/UBOcopsEUZrqirwliT1M5h/88C9dyV/WK2Mmcs
         gJfcd5q++jLJNR9OUOsmQFQkeQ8kWyvBelS/D0QYgQAxtIbd4UfOfRRzIgmAsrkPJ5kj
         GpJg==
X-Forwarded-Encrypted: i=1; AFNElJ+O7VgSUbsMm1lWICzLOtPILBZxd4+B7aZjARA48nK2Pp58/WXOOGEb8fq+QrZNfLSohk6HIEJg4ONsAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwR+8hqt4dM2/kaevM4eIt9a10cD26KtMdAozRjbzdLtvPZJwyx
	itNH2VegdeZdnPL6gHQiKr7PYsns4X5LUP2QIDaTzJkB0Yl2H0hV/kpd
X-Gm-Gg: AeBDietwcEmdXGsbrnUkg4aB2lJozUym0Zpy/r1nX1Z/M+Enm4ymTm710Uf6xvOzngz
	d2s5MdlF8YJ+WEvd8DUBk1Qd4L5zGTOjegUh0vBpnGgZqDiXWs0Xbe222lZd8p5vAjBrITOaeBK
	0b+gaIS4UuGU36fo41a8MS4nzXrJBqal2lmhFhMgDfNmovfkIJEsHykpV/2AX2EUGu1LcHzSTZ+
	Bj7bBgyjTyM7NCOXS9yLOTlY5MGETUMOZJCSO9PEuTnan7XS7ZBHnUg8pUced4zF41LoUZqj1jj
	GcDqMDADMq8VoWfq5v6Ph5J0a1JzY5Nn0Qm4dyy/UgjgAT9xoXAQOZueoMFMXZYborRP2QkL4sa
	rob0sHkQQ8CG2m4WqBk69j2nwWyZFUfkeIoMYgwcu/gh6/IBLHwYkYEFvXzUcNUYkKkpDjRUo59
	LqjC3ISveSaD8R0G6C291TxbuLw0NBkViN
X-Received: by 2002:a17:902:f64c:b0:2b2:53f5:461f with SMTP id d9443c01a7336-2b2c7384aadmr230409305ad.25.1776265057864;
        Wed, 15 Apr 2026 07:57:37 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782abd6csm23426605ad.63.2026.04.15.07.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:57:37 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Denis Efremov <efremov@linux.com>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] floppy: fix reference leak on platform_device_register() failure
Date: Wed, 15 Apr 2026 22:57:08 +0800
Message-ID: <20260415145708.3331818-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When platform_device_register() fails in do_floppy_init(), the embedded
struct device in floppy_device[drive] has already been initialized by
device_initialize(), but the failure path jumps to out_remove_drives
without dropping the device reference for the current drive.

Previously registered floppy devices are cleaned up in out_remove_drives,
but the device for the drive that fails registration is not, leading to
a reference leak.

The issue was identified by a static analysis tool I developed and
confirmed by manual review. Fix this by calling put_device() for the
current floppy device before jumping to the common cleanup path.

Fixes: 94fd0db7bfb4a ("[PATCH] Floppy: Add cmos attribute to floppy driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Replace put_device() with platform_device_put() in the
    platform_device_register() failure path
  - Fix the device_add_disk() failure path by unregistering the current
    platform device before jumping to out_remove_drives


 drivers/block/floppy.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 92e446a64371..461e14d19422 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4724,15 +4724,19 @@ static int __init do_floppy_init(void)
 		floppy_device[drive].dev.groups = floppy_dev_groups;
 
 		err = platform_device_register(&floppy_device[drive]);
-		if (err)
+		if (err) {
+			platform_device_put(&floppy_device[drive]);
 			goto out_remove_drives;
-
+		}
 		registered[drive] = true;
 
 		err = device_add_disk(&floppy_device[drive].dev,
 				      disks[drive][0], NULL);
-		if (err)
+		if (err) {
+			platform_device_unregister(&floppy_device[drive]);
+			registered[drive] = false;
 			goto out_remove_drives;
+		}
 	}
 
 	return 0;
-- 
2.43.0

