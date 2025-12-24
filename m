Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53C2286897
	for <linux-block@vger.kernel.org>; Wed, 24 Dec 2025 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766577200; cv=none; b=aqqEqe2ZXN5NmQdJiyHBzt0ruY/aabD4hFAErzrM6amdogQUzWte3gI6C4KMKq2S+lbSC4j/VN9zjtQ6/BvE6JbWU39fL7XYLDkY4NuVQ1p0gFFXjLJCAnZojmFwtzjg0rJT3SyjgY56021nE0YnLNnXy5ZXqc+YyQ3+zYC6CoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766577200; c=relaxed/simple;
	bh=VghBC1b2o+YSQemYhQvg+LW6HMuJevii9eNd832oz1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DVDJZneEnckMcHWYC2oUmqX4p8GxzGyQxEAJH7ydXdd0rTUndARvv2CEzmY9VevwHHjiyosp8o5TmhiHxj7/VUqDH1/4cnoFUKK6iM5lcKZWlL0cfgTeURz2HqUvqKP8e9biqea7ENCkM9bKjgWNu42ZWozrZyXrqMIvwATy/Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1SOw21c; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1SOw21c"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59431f57bf6so5894862e87.3
        for <linux-block@vger.kernel.org>; Wed, 24 Dec 2025 03:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766577197; x=1767181997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V8YUcaf/+H/QKaxsmZyXiuyc2oeBQf4LAuC8T+FhL/0=;
        b=D1SOw21cHBDLHtpE4FEUXE+cqGeqpmgLiWll8IF3xju42Z2W7L3RXBL3Rh4eji8YU8
         FdABoo2KvGDv6axDCgacV7Z4bf0MsOZsmz0MupbjaoHhpnXDPFMFcPWhGvRIT8BXuDRV
         8RyZMBFSm8p2LHVD5CyMrOsES1PnxVMMyh6hiV4rpGFb7in5n3ZE40+Z3aHW5p8ZsOqk
         rouTY+robbL60OhHZ93IAC4MBDJ4BY02EgJ0fGvF7iQx1qmWfBEGItGlzkfcSCmhiRiO
         GyuEJlB/+2jJaQ8pKprP+791oNucI0ctjfV/T9S7C3jYGTHJJq49Te33RkXsD+diBSkm
         gMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766577197; x=1767181997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8YUcaf/+H/QKaxsmZyXiuyc2oeBQf4LAuC8T+FhL/0=;
        b=LfemAY0jOk7YFiUJhv2hbgnmUVo7YjFPh1fY3F640BFqwoug+564CQxUgRDtOnw9/l
         ryoQ61KQXeRrsAa6QK4VdL4fDVBZkEmFO9Uk8u/wqyqv77f3RYoh+ShBH+xa0zZx5dB9
         O0SXtojVtmussSqH/bj3o9RD06PkL/xzTqMIDK0zlzAxFeaC+k4NKZEEVBwRvbrYg20Y
         LbcWIB8RsTLxhwj+SXdodX2CHQqXamyBvk8qI0w93xYzY7DZtkquw8Va+alyoWB5owFy
         M6RSLbi45PoLtDblwzzz6Gh24cIBi6ynw0Rh2gZT0Jyb6kLmxjjs3oQTBZThVt6JJOdX
         fyrQ==
X-Gm-Message-State: AOJu0YwiUcaFEANpHQy/D2gKXcXBTkUkIcGQStO27MxiEFXxpaArJK+9
	xkEOKKi/tXhtweBMFifqVhk8UcrPDdtlmyXJBkYODmTbzv18RfLct30EozOAjvFO
X-Gm-Gg: AY/fxX44lWALCniPrC5ftOlbMROJa/CpZXW1sgFbyX+ACPLtSl9PQdkpyX0m8xINE9z
	tMfCwmpcUslJuZbxGFp3jjlTBe7O9ApkCf8kzG15p/GkYQvKfMjX2BS8da7zRR630unu27MUgb8
	RTYarVszIkMh/hgWEiw86l9YaMxyG+52MynBsAUSgHowGnkfJoJzcWZ9jaQCNU/lDdHbKVg6Av3
	JGMfiOhpkoD1/u6hp2GD2lIPxETZD4SAdWptZ05VlYLIAPU3mjJFsaE3dvuDCMgUBnfYwMJvUSo
	lcS/oRmbN1EZOSNOzjCAx287Y3lMNSg3TZz+qHW7o/+TbgNXt5n5qTk4RdMYpMnOtLohZZW0UQv
	Ok5dzQvuww0Ve9cq61bxw6tXA1R27phhJhZvdUaaMkFM5Qy23sTRx/z4nMlMTUsbORV3LF2wK2s
	3tYfs3eJ5QAW6AdbvCo1r7FnPe0Jxdr7QtWzNLNl8V+LsP7qUio7AvPAA=
X-Google-Smtp-Source: AGHT+IHl8Eo9AGUWnMOS6OLlY8nnfRyvT8wSGm+8a+ZcGoLGwGz2KeB3ggknYBIzCKI0HX26v2IIwQ==
X-Received: by 2002:a05:6512:39ce:b0:597:d765:19f9 with SMTP id 2adb3069b0e04-59a17d057c9mr5575656e87.4.1766577196486;
        Wed, 24 Dec 2025 03:53:16 -0800 (PST)
Received: from mismas (filipovv.starlink.ru. [77.50.205.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5d7csm4847935e87.20.2025.12.24.03.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 03:53:16 -0800 (PST)
From: Vitaliy Filippov <vitalifster@gmail.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Cc: Vitaliy Filippov <vitalifster@gmail.com>
Subject: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
Date: Wed, 24 Dec 2025 14:53:12 +0300
Message-ID: <20251224115312.27036-1-vitalifster@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic_atomic_write_valid() returns EINVAL for non-power-of-2 and for
non-length-aligned writes. This check is used for block devices, ext4
and xfs, but neither ext4 nor xfs rely on power of 2 restrictions.

For block devices, neither NVMe nor SCSI specification doesn't require
length alignment and 2^N length. Both specifications only require to
respect the atomic write boundary if it's set (NABSPF/NABO for NVMe and
ATOMIC BOUNDARY for SCSI). NVMe subsystem already checks writes against
this boundary; SCSI uses an explicit atomic write command so the write
is checked by the drive itself.

Signed-off-by: Vitaliy Filippov <vitalifster@gmail.com>
---
 fs/read_write.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 833bae068770..5467d710108d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1802,17 +1802,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 
 int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 {
-	size_t len = iov_iter_count(iter);
-
 	if (!iter_is_ubuf(iter))
 		return -EINVAL;
 
-	if (!is_power_of_2(len))
-		return -EINVAL;
-
-	if (!IS_ALIGNED(iocb->ki_pos, len))
-		return -EINVAL;
-
 	if (!(iocb->ki_flags & IOCB_DIRECT))
 		return -EOPNOTSUPP;
 
-- 
2.51.0

