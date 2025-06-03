Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7677C2528FD
	for <linux-block@vger.kernel.org>; Tue,  3 Jun 2025 23:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748993920; cv=none; b=oYjki7xiSYMa6vHgR+EhHc3y0Zn/dyhdN+WE8AjU8gwU0KlkQYSYancn/iUYx+/G8pFLl+AMuXPL7cHeYM2RSGX/Ol25vxWYApE6FiGbd7xLm1Omhzc+u+DkbgXzwPS5UyfWYbUE8UJOwomFjrsq0L8yPrhFxjproNzkPuP+OPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748993920; c=relaxed/simple;
	bh=GRKko8U6tkBwoDvqev25212EMIC0D1LUxb+uSFlHjvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gus4EBd2PnrRF/ZfYOloBITVY1G/LOQA15W5qAQjyY/CE+ab9ejXYQiypsdmAFTuB7XgCERzDc/fiwILSp59bJNh5jSqRV1FRap5rls8MUkbwftsRVKWbqPjPPtxCPeBS17R6ZP7KUNxlLt6aSwFznmnvmxV7ymWdn9OA0weRC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KTM4WEDp; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KTM4WEDp"
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-86cdf8349ecso147712039f.2
        for <linux-block@vger.kernel.org>; Tue, 03 Jun 2025 16:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748993917; x=1749598717; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/R0RpgCFKdTj3IOKRqUkoQl1YyksTGBaXOZihTi8ctY=;
        b=KTM4WEDp1d4DHkOu92A6lL7h/GBr5zNy5dZ7BMk2MYTg+ip5aeLGTRcY6XgT5Iy+xx
         +uAA2thmT0uoHnNf3WrcliZN/ririxeGYhzprzlazkTRGT2UFFuONWR8GxtIax1AAS6P
         PSzSdGFOM8R4rg066jLU9ZD9OQLc/Ag6ew0ZQRolvZnItRC14GaVXNMVhopVdj+2eEQc
         TpksRpE0IPQi8iUcQLbVuOTWr8i68ip8SHJoaQCqM/LfXV536e232lyIjQWn6qmoneCu
         mzo0+6x/aCp8vKr+qZGf6/SDKmrZWg2QUsx7RZXVxUaDZTnzvvc4X+Uhw8gOEJ2WsRpr
         xL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748993917; x=1749598717;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/R0RpgCFKdTj3IOKRqUkoQl1YyksTGBaXOZihTi8ctY=;
        b=Lb248+5nx0syt9QYm+wqpU0v4f5uvpJenewu/x/D9oiRemquaNPLU1zHtVeQoZXnRi
         410gwb/IsciMbNTTznLbHp/edop7VHyV5aUZdcLxlQZg2t+WIwR61nHL/VDeKSnSDj+N
         jTMivZ1H6J3saIxW5tGy3YJJSKqoPS2jz7zme17+SdoL2uVUHh6OAnQJpWPySUN7B8my
         G78l8mnD4eUQzh3TVTlzA+BNxfLkpiDmIHzrvkpH9DSfGHj/gFoZzrcEgj+qvuCYRm6S
         vhsmiytrZPE77wugDHd6Mn40wR1gBtkLivDd3+WtQZShc9VaXBxofjp9+qogzh4Lh8Hm
         H6qw==
X-Gm-Message-State: AOJu0YwSJrRkra4/vkLmorMNOGaJKlXXRVlljTZTsgIBDGKeywBuMpzX
	yM9nv/WBksU8IFLtfxNJFOj6aBPEAspqxHEVItCtS4GbTH4K9TaaUR1NCX9KKNDnVHhmghLK3MA
	gKMd94QXybzkwBaz4pAQ4sXtC68uCMIQpaGkG
X-Gm-Gg: ASbGncv87nh+VeLfcxN82WFU8Bb84uY8fwN7QqZQFXHuDNg53fJJK3i3MJbIaDX7Rn/
	K0uGGBZ2OoNZBqKLFGuZ1rLj5oy8T/mCzPzX1Lpc3X/o2UjKJ+pRqigw+0yRSyAXY0eJ11aDH6V
	YDgrMU2job7m4GztC6xTvI9P7FYClb6NOrmm6F/0tmvUu32scjBtQFW6Q963xpmfJKqDK3FKZjs
	JAWkFZzj4f4KoDQyK9npP0IZ3NfL/2LcT8cfnHrr0kxmbVS08Iy9KISkzZ485fm7gMjcd+yfA+9
	X99C0TTzD8SAZIva3n4AlSb+mo95C4/+Z8t9/+ZtK0uYaw==
X-Google-Smtp-Source: AGHT+IE2Clg33E/8c+qwuR12THXL4yJ4NH4pmMoiTeWYcHOgHxUyzjy7wBBi6+80u6OaDk7frWPxrt/0AjAt
X-Received: by 2002:a05:6e02:3989:b0:3dc:7fa4:832 with SMTP id e9e14a558f8ab-3ddbee093d0mr9255995ab.9.1748993917492;
        Tue, 03 Jun 2025 16:38:37 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4fdd7e3ee09sm297542173.37.2025.06.03.16.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 16:38:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id ED38C3401B8;
	Tue,  3 Jun 2025 17:38:36 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id DBCA5E40EF7; Tue,  3 Jun 2025 17:38:36 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 03 Jun 2025 17:38:33 -0600
Subject: [PATCH] selftests: ublk: kublk: improve behavior on init failure
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-ublk_init_fail-v1-1-87c91486230e@purestorage.com>
X-B4-Tracking: v=1; b=H4sIAHiHP2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMwNj3dKknOz4zLzMkvi0xMwc3SQTSwtLA1NDU8vUJCWgpoKi1LTMCrC
 B0bG1tQCSUc+VYAAAAA==
X-Change-ID: 20250603-ublk_init_fail-b498905159eb
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Some failure modes are handled poorly by kublk. For example, if ublk_drv
is built as a module but not currently loaded into the kernel, ./kublk
add ... just hangs forever. This happens because in this case (and a few
others), the worker process does not notify its parent (via a write to
the shared eventfd) that it has tried and failed to initialize, so the
parent hangs forever. Fix this by ensuring that we always notify the
parent process of any initialization failure, and have the parent print
a (not very descriptive) log line when this happens.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index a98e14e4c245965d817b93843ff9a4011291223b..e2d2042810d4bb472e48a0ed91317d2bdf6e2f2a 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1112,7 +1112,7 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 	__u64 features;
 	const struct ublk_tgt_ops *ops;
 	struct ublksrv_ctrl_dev_info *info;
-	struct ublk_dev *dev;
+	struct ublk_dev *dev = NULL;
 	int dev_id = ctx->dev_id;
 	int ret, i;
 
@@ -1120,13 +1120,15 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 	if (!ops) {
 		ublk_err("%s: no such tgt type, type %s\n",
 				__func__, tgt_type);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto fail;
 	}
 
 	if (nr_queues > UBLK_MAX_QUEUES || depth > UBLK_QUEUE_DEPTH) {
 		ublk_err("%s: invalid nr_queues or depth queues %u depth %u\n",
 				__func__, nr_queues, depth);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto fail;
 	}
 
 	/* default to 1:1 threads:queues if nthreads is unspecified */
@@ -1136,30 +1138,37 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 	if (nthreads > UBLK_MAX_THREADS) {
 		ublk_err("%s: %u is too many threads (max %u)\n",
 				__func__, nthreads, UBLK_MAX_THREADS);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto fail;
 	}
 
 	if (nthreads != nr_queues && !ctx->per_io_tasks) {
 		ublk_err("%s: threads %u must be same as queues %u if "
 			"not using per_io_tasks\n",
 			__func__, nthreads, nr_queues);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto fail;
 	}
 
 	dev = ublk_ctrl_init();
 	if (!dev) {
 		ublk_err("%s: can't alloc dev id %d, type %s\n",
 				__func__, dev_id, tgt_type);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto fail;
 	}
 
 	/* kernel doesn't support get_features */
 	ret = ublk_ctrl_get_features(dev, &features);
-	if (ret < 0)
-		return -EINVAL;
+	if (ret < 0) {
+		ret = -EINVAL;
+		goto fail;
+	}
 
-	if (!(features & UBLK_F_CMD_IOCTL_ENCODE))
-		return -ENOTSUP;
+	if (!(features & UBLK_F_CMD_IOCTL_ENCODE)) {
+		ret = -ENOTSUP;
+		goto fail;
+	}
 
 	info = &dev->dev_info;
 	info->dev_id = ctx->dev_id;
@@ -1200,7 +1209,8 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 fail:
 	if (ret < 0)
 		ublk_send_dev_event(ctx, dev, -1);
-	ublk_ctrl_deinit(dev);
+	if (dev)
+		ublk_ctrl_deinit(dev);
 	return ret;
 }
 
@@ -1262,6 +1272,8 @@ static int cmd_dev_add(struct dev_ctx *ctx)
 		shmctl(ctx->_shmid, IPC_RMID, NULL);
 		/* wait for child and detach from it */
 		wait(NULL);
+		if (exit_code == EXIT_FAILURE)
+			ublk_err("%s: command failed\n", __func__);
 		exit(exit_code);
 	} else {
 		exit(EXIT_FAILURE);

---
base-commit: c09a8b00f850d3ca0af998bff1fac4a3f6d11768
change-id: 20250603-ublk_init_fail-b498905159eb

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>

