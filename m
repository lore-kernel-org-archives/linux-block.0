Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C83419DF4D
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 01:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765503319; cv=none; b=auvARYsM9b8RwEdQC4fib+n1J5I87Kcku3BzeWEgnsxykB8hHWrk9xb7qpUErnOYlU/P9dZABWwNzhF6be5zs/1iD2AeVFnfnY5XkFhTOm3nFPZZX8cf0tDClC9vBaIzmXfzwI7EHXImylZjtKCzbhXlAjR4vUdpI9i4zbgUhAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765503319; c=relaxed/simple;
	bh=GKjysckQ91RPf5OUfeXUZ32Qa1ZdrmYSP+2jV8iq6OY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=huIM9vNIYVJff6tM6ARUFGsMKx4CQMYi35aQX4a9t0l13sz2vyYQLFaRuAnEaiL9CPRkflSV0nZFZWbHEhUZGCo/eYKeC9zDt4g4DXf74/0Ab3DhiSs9vNpJuleerocN5KIqv4gEeCph3MGuwXs6pSF1VPNqk9jjOrcdEDvdoRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqqgfwH+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqqgfwH+"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29558061c68so8851835ad.0
        for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 17:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765503318; x=1766108118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JVqlRPLB5QUg+qJdqqbHPD9JOQ5gxpvvpJ4JkAESAyc=;
        b=MqqgfwH+FReCJW5fDZsHwg4BwA1ti7ubO6EtLRZ0CtdmkoI7t2LIVZ3hl06Z1z3jBS
         cTnydTvsou6rrmETHpUUBd3w+ysTb6l7BTcnukOvLGcqQmfcXj94xibuhM+sOrhZzbos
         S/pnIbrFi8QsAhwxYbGPEVX2cPP8YBHA8v5eVKMqNC8B30uN+cQNlZRNzgy/rllrLN55
         yhe9cbgfyY35LjrIQxJSO8g+zP9bwmKfkg/zc4w7f1+f1SPI85SlOWtOcQkCAXk9fgWO
         NUDPXwbkWdDL2f99NPuwwLSjKN0WMLI/6bWbAp5HZLawHR/WCqs0OlSYVm9ONOC4JS1p
         /KDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765503318; x=1766108118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVqlRPLB5QUg+qJdqqbHPD9JOQ5gxpvvpJ4JkAESAyc=;
        b=hIabhgfiBZ3BhySD//0+pWrZ1MayAZNFTEC0TryDlSVpXodrNKzR8wiAancUWWQTpe
         SsoerJnZW0wB5D1Fyot/lJ7u69URWEhwm4eShcK+d0VNRRWhjURoCEe4ZsQZwsaKat1u
         TgT033uVKIXUwxYSvxkFzRLjiNz0QNwcGICZ25vdXw0taQgGHXAQ3V4Jb604Q5tWgV7f
         cCEyN9pupFECPUAZDWva00BkWYc0caje8EO3UqyD8o/cnZIiMQ2QYVh4ubv5RQaXm70q
         gKXgrDiwfBktDdyTd2oMSsd1tFtPiT+VCk3lgra27H8YDnHw5cygxZRJRzRRakIiyGNI
         fuqw==
X-Gm-Message-State: AOJu0YxbRLj5j5k8N2lSE7uPF/3AF2nHb8bbMNT+pM3q2eRBvfVJFdIQ
	CRVZm7I0GA4dc9W7NtYqhNrnHSIlAi7m690abgP6qjxQ5lth2Czu10X7
X-Gm-Gg: AY/fxX7eVB9UWlyWMcZ1FOiE4alRjT8tnwuPbY7GZVWkhyBe7DPsp5TyRkPEC80VWTO
	Mrh1bwemMpK8TIBjeYCrBVpr4W9/djHylFL3N4O4wGWxFd4wxmdPKA4fSSgByLMhjANk1QVRb30
	/whRbgVly5CvJJQsr7EHbIOPiO7Oc/He9pj8LCBj0huKi8NDd098Y9RyzL7iiGtucg0zpHfsrQu
	gdSLXj5NJ41O5VXT8qnPJscvYxrim/yr/n5IWegsCj7lsVdrraOREaO4hrgmlkeM2GfIsqJNCOe
	clWv7V9t/f5tDoh9H+r4a7JDznJvCuXce/wu2of1s7PwPv3ev1U4a03aHcDfLOv9BwQe1scLS95
	doPYMOIeflkPrRVGLYEwcXS9MkgldF/t9UPthL/didGGvlSy0P90QsA/mZfsksUqoC0gBP2f9Mz
	BTNwUIa3o8p/o5VKRT5gphUXnYsJcppLn56YvnL7CJAKcKt+mSUhd2fxt8lJa1DbzjFfo=
X-Google-Smtp-Source: AGHT+IG5OBwmyhV8Xg09t2GMUwXjTYJLb6+DktyU8tWPFE/56t+QdE1rA06Fv7TsiAJ8YHijViSCGQ==
X-Received: by 2002:a17:903:380b:b0:29e:76b8:41e5 with SMTP id d9443c01a7336-29f26eb34acmr2087275ad.30.1765503317859;
        Thu, 11 Dec 2025 17:35:17 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:8924:b5f2:ed79:957e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9b376e2sm36857985ad.14.2025.12.11.17.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 17:35:17 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: axboe@kernel.dk,
	stefanha@redhat.com,
	martin.petersen@oracle.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+660d079d90f8a1baf54d@syzkaller.appspotmail.com
Subject: [PATCH] block: add allocation size check in blkdev_pr_read_keys()
Date: Fri, 12 Dec 2025 07:05:10 +0530
Message-ID: <20251212013510.3576091-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blkdev_pr_read_keys() takes num_keys from userspace and uses it to
calculate the allocation size for keys_info via struct_size(). While
there is a check for SIZE_MAX (integer overflow), there is no upper
bound validation on the allocation size itself.

A malicious or buggy userspace can pass a large num_keys value that
doesn't trigger overflow but still results in an excessive allocation
attempt, causing a warning in the page allocator when the order exceeds
MAX_PAGE_ORDER.

Fix this by checking that keys_info_len does not exceed KMALLOC_MAX_SIZE
before attempting the allocation.

Fixes: 22a1ffea5f80 ("block: add IOC_PR_READ_KEYS ioctl")
Reported-by: syzbot+660d079d90f8a1baf54d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=660d079d90f8a1baf54d
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 block/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 61feed686418..3e9e4257569f 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -443,7 +443,7 @@ static int blkdev_pr_read_keys(struct block_device *bdev, blk_mode_t mode,
 		return -EFAULT;
 
 	keys_info_len = struct_size(keys_info, keys, read_keys.num_keys);
-	if (keys_info_len == SIZE_MAX)
+	if (keys_info_len == SIZE_MAX || keys_info_len > KMALLOC_MAX_SIZE)
 		return -EINVAL;
 
 	keys_info = kzalloc(keys_info_len, GFP_KERNEL);
-- 
2.43.0

