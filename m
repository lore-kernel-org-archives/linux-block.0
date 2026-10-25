Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792958864;
	b=HgQzeDYwhaUttoJeprQMCwZn86FZpPjeVxOQaJL0t0iPbb7LDDK3P6I+kXlV0E8zc7e2
	 fqyfDbum1PcEkCPb0jJMrOqbkyJ4rJW1zPNNQ1Y/K5u8SZ3/G5P2W6tGU814ZSMQr3Cf5
	 v+XsEosQdhlXBWKd40/bhlaMa9zlTeodBXPgRalPWspz+vucdJgay2bpy4eDDKqaoI8Nd
	 ZwPewiAyF7ZkzCc0yToUW4hOb40lAoPiZyrQ7wPwSfjlL+G+2CyzWwO4SErv+XE7g/+KJ
	 PycWGep9pWB9w1GT6z6mJpp8EAWqwMnYqDBsrOX+7sGkEGbV/SXlq6byksTAWTyJcqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792958864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=MzytXk2ucTXq7xaBiZmGqb6fwOw5jzYzbpff0nGJjCQ=;
	b=D0lKQw0UzY/hYq/jfeGmv32SsdWjyM6OfqW1GjbRgY8QH+18bgJ2lylpwXBFMBS++QbD
	 DYkTI5z93zvdD3mfexgnWH1ZIrwMzQXvgH+KhntrXUZycCQC6YX7UXFX6Y2IifoFFMO8h
	 G0mIL27uwq3mTVDWOKF9E0j67SzA06Wl2VDqXkjujQITV3HcuKQXOy4BDKimBFbK8X5Jj
	 rVOkzRMZEVFSCaeFq0Wud4MBbovmnx7IAK8VRV5Q6URWyfqz1IfvY42LSg0GYYxGDBQbe
	 o9JC96GP2O4IzuSH5yWbzD4wBQQiE4UwjzfjiO9j84P/GcfZUwOM13AffgzukzjWYhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EOxhFjqU;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A48606A31A
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 20:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9A48606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EOxhFjqU
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a028616bebso18121035e9.1
        for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 13:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792958862; x=1793563662; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MzytXk2ucTXq7xaBiZmGqb6fwOw5jzYzbpff0nGJjCQ=;
        b=EOxhFjqU5fR+gODdq8/59frgVMkTz+mcNgqolbG22dTDIFndjertYT+TXJ4wx+FZjg
         xBUfCnmbfoRpbOoETVn60vzIHOnqRp9iWuSG8h91tqMPZ0ZTQRmV1iT47+oaSXWjj7xI
         n0JvqEHcT8xsqHrBZEY1wg98bWEoaCrdiSuN7jEkhLmWipBUIbj0xsnCki/OHLnD8CKx
         qgppBRz3cSeCZmJukamcC6FqNgT6tYLNdBvnYJBPcVgQtC0fBbQ4xaFIzt8vt6Y6MKLZ
         9q3YANikhmFwPqpru+CuKB6Ht6xOGmN6HioqYGNmIjUq/L8BnuEJH/arI0/mtGYkT+oT
         Oelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792958862; x=1793563662;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MzytXk2ucTXq7xaBiZmGqb6fwOw5jzYzbpff0nGJjCQ=;
        b=InngeDUr0dHvquiRMF+Qkx7fC7kC83l/M8CkyxmcZKb4Gp5QI4APRoUR4SPnzNzyRj
         Ifh8uBZHyKqOB4tvrNAzBtUO7JrWQgBl1QUqmQBFPwEFD5iOJMNYRiu5GPOI1STkAYGQ
         luTeTZf/vn5rt5e5iuzh55C/4cQgXGT7MoFPhyrojuLsMvjtH7Y0kMe7HKM5crGkEgOc
         9z5Map4Yu4GrFkJe92ntA+t2gjPGONNDA3DM68bsuUHM9DrfRcISVkMmrDTyF/GsVYGY
         p0/IhXZUyrg7h+MfztQdUGE1lRZKBtNtKZkMOlO6DafJiET+NdApp7OQmgwCu9R1LBZX
         HCJA==
X-Forwarded-Encrypted: i=1; AKwUvBwYt+Vs6CSkGBLxuj04YBRCefAiYgcJ89FJtgcK+dJrAesnjeMmFGCH/bmsjLMubx2ixtTjzB4UM/1iZQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIhHbIUWCyYc0iGGKh92k4Lj9COO7MWRPbpivL0drdJboQDTns3
	9AzDh8MUcVoP+YIQ0MS5vO/mKXqnxuf6rYvIXgA2otEppdZSZsDOADtJXm05kmGEorvKT8cVHA=
	=
X-Received: from wmgi18.prod.google.com ([2002:a05:600c:2d92:b0:4a1:d943:b7d5])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:b99:b0:4a1:efba:511
 with SMTP id 5b1f17b1804b1-4a35acba31cmr80538135e9.35.1792958862050; Sun, 25
 Oct 2026 13:07:42 -0700 (PDT)
Date: Sun, 25 Oct 2026 21:07:40 +0100
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261025200740.2064379-1-dmnk@google.com>
Subject: [PATCH v2] loop: check for read-write open mode on LOOP_SET_STATUS in lo_compat_ioctl()
From: Dominik Maier <dmnk@google.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org, dmnk+artist@google.com, 
	Dominik Maier <dmnk@google.com>
Content-Type: text/plain; charset="UTF-8"

lo_ioctl() checks for (mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN)
before allowing LOOP_SET_STATUS or LOOP_SET_STATUS64, but not
lo_compat_ioctl(), the handler used by 32-bit user space on 64-bit
kernels.

As a result, on 64-bit kernels with CONFIG_COMPAT=y, a 32-bit
unprivileged user-space process holding a read-only (O_RDONLY) file
descriptor to an active /dev/loopN device can issue a compat
LOOP_SET_STATUS ioctl to modify lo_offset, clear lo_sizelimit to 0
(exposing backing-file data past the configured limit), or alter
lo_flags.

Enforce the same (mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN) check
on LOOP_SET_STATUS in lo_compat_ioctl().

Assisted-by: ARTIST LLM
Signed-off-by: Dominik Maier <dmnk@google.com>
---
v2:
  - Rephrase commit description of lo_compat_ioctl() and remove
    inaccurate Fixes tag per Bart Van Assche.

 drivers/block/loop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 758c20678bf6..f15a5cae5c63 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1708,8 +1708,10 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 	switch(cmd) {
 	case LOOP_SET_STATUS:
-		err = loop_set_status_compat(lo,
-			     (const struct compat_loop_info __user *)arg);
+		err = -EPERM;
+		if ((mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN))
+			err = loop_set_status_compat(lo,
+				(const struct compat_loop_info __user *)arg);
 		break;
 	case LOOP_GET_STATUS:
 		err = loop_get_status_compat(lo,
-- 
2.56.0.257.gf7497c7d27-goog
