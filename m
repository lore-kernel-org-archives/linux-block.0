Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63F52C234E
	for <linux-block@vger.kernel.org>; Sat, 29 Aug 2026 02:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787969620; cv=none; b=nRO1AjYndRKO4DbGxlXR10B0t+DGTUuc/oxQmD2syobWnXao3PHC5akES1K9/5rbZaDX6F/Jw1YeIO1CzJZ74qMG+esZU94MTTGZ9Zq/k6ncSKG+j6ftwrosDkUN1vjp1ZlwUogEl5uVHrI6U74+IwH9ZYefDa7mSOqITXPzFdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787969620; c=relaxed/simple;
	bh=5rv0FfyiYEvyvVwzL3LiWBygbPcujcnx1umZvHO9vBQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=nH6liclJAmCxLbLqSVgRRVe5FdwcGtErSgqjECVAXjK0Hv1ODjaWu1NUBvo/hBYhzNS2vx2jevqgIZ0Angm/bLbd4PA0WXwIOMb4mvyoCRtbq/EGUNmx3svRs4eohIMteW3vckUqBB9T6JmCbui/JgkFFyQw0KzJ1dbLRhkXZGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rjK7yde0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjK7yde0"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso18083915ad.3
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 19:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787969618; x=1788574418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:subject:cc:to:from
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ovGmNS04B5xvYEr6LE0aaw0+pimuQ4fxyRqoFUQTeKs=;
        b=rjK7yde0uBQrqGrYhS/8b4unVQRZEEyR9LCvOd8R2CUB35GH+z9m5MYrgJ59di1K+L
         oFogsD3Ill6upGMJKJGcRjvh4fn2o3ec92DeqWjqRPuunJCBIvyyUU9RfeVx/Vh9Hwb0
         N+0AlrJqTzlNbdlwcrB3CIvTxn+gnItYb5PuVDlp0K/t3jKMfnqda0jGTZsakQo8zWgz
         EGTlgunXuESMD8rwf0CBiMr90MqXpg4uDufIGh2Ti5QEhroJ7EBdwKl/eTfARekSA9aX
         mtwkmzw0P1lJM9wz4oW7dfE9ezFYSKdoKvxwEPwyzscelY2sonU84hZmkVj9lKFD9Yn7
         Porw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787969618; x=1788574418;
        h=content-transfer-encoding:mime-version:date:subject:cc:to:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ovGmNS04B5xvYEr6LE0aaw0+pimuQ4fxyRqoFUQTeKs=;
        b=N27PoNG/ca9fyihJMB9wPNQxj3QMLv7waKxhWwt+ZXgx8olqYCRhZE8Mpu0kivcvI0
         Hyx/UZfcPLpVY1nOufCb9RJFWQ4dQGZHbrsAJUU0I6XBtuNhzcHtJs97OeHe2MOAaGlx
         ADxfCpG73+0y2S3+OtE5yQd48dFYrFFnB/4VOx6zshCJYmRpadtjxYQGjVt7NICCSKjS
         ABcSeW5AC77Czd/SLR15Mo2atsZXkVL1NUS/W4x2bn8X6/EyN+xs5904MLIT5p/NTGCY
         9EAwTd7gh4vAZZi5dhwFrUyeZLAF2O1ONF0caxKroAZ7ARd42w2gM+LWhMsmSt0ChFjb
         7CKg==
X-Gm-Message-State: AFuF++l8rfSbmZObePT/aSvniKsloUkefki42fivKI8w4bxe1zSQAKiO
	bXPhnXj9j2uzcSh6pHY1hYneIMGn5KUxymmKKkZzLGonUh3T4FpWTb5GZCoiRMxn7D0=
X-Gm-Gg: AYBFou3/MvcGCG7ccfhbcFanSaHVEWstM1scrMXUCxiWvvtlE5d8PVuHszRS+nsBayh
	qcwWd1XFqiKW34nrPKcDubJ8ENGUbx1ZIY6WmdgJ/1cMX2b5x/1jyhxALTO1TbVfiNsEjpPAoUU
	cvs2QMzeVtf+uffQJJjH49oQw4oTXjCRKX32pf7WWhvGwjiGsunpcw9JW1FL5fU6FZGXSyQPXVE
	6vvd2RJkjAhzTiN+kWYYpx07oxOuSCvTKrwtiXE/+nLky9QRYa0Mz2iiQfNfcdqA23A6KA+btKc
	6GZXzQpuK7dfTfygPQR1fqW7WTitOMvNJFT7fgYIrfiT/MbgL243dkTCF4XEZkSmeG5ixPiLrOt
	qI33jVZEIl4KKXLLm0nb8FVMVClV3/ni2bRnJsQlHVkArZy52SBF8+jNSSm9o/Ys9HFekO4rs3X
	qtivhWbmRoaXPYaO3Tmfl9ex19Sp7o3ZMY1MksmqGxI93Jca41SJkLYesZfgGYyQDNHncQ32vGk
	ftN6LkvHMw=
X-Received: by 2002:a17:902:d483:b0:2d7:4b42:9352 with SMTP id d9443c01a7336-2d74dca231amr184313925ad.3.1787969618107;
        Fri, 28 Aug 2026 19:13:38 -0700 (PDT)
Received: from emedev.tailf75c28.ts.net ([148.222.209.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f995e60sm10164143eec.22.2026.08.28.19.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 19:13:37 -0700 (PDT)
Message-ID: <6a924051.e22746c9.8f0fc.bdc2@mx.google.com>
X-Google-Original-Message-ID: <20260828223000.ramshared-v1-cover>
From: emersonbusson <emersonbusson@gmail.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	linux-kernel@vger.kernel.org,
	emersonbusson <emersonbusson@gmail.com>
Subject: [RFC PATCH v1 0/2] drivers/block: add RamShared hardware-accelerated VRAM block driver
Date: Fri, 28 Aug 2026 23:13:30 -0300
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces the RamShared hardware-accelerated block driver
(drivers/block/ramshared).

RamShared maps discrete GPU video memory (VRAM) apertures over direct PCIe
DMA to provide an ultra-low latency, non-rotational block device with a
synchronous .rw_page swapout path.

Key Design Highlights:
1. blk-mq multi-queue parallel request processing with atomic gendisk allocation.
2. Synchronous .rw_page fast-path in block_device_operations for zero-allocation
   swapout under direct memory reclaim pressure.
3. PCIe AER error handling with pci_error_handlers to contain link resets.
4. Comprehensive multi-kernel compatibility across 5.15 LTS through 6.18+.

Testing & Quality Gates:
- checkpatch.pl --strict: 0 errors, 0 warnings, 0 checks.
- sparse semantic address-space analysis: PASS (__iomem annotations verified).
- Multi-tier saturation benchmark: 9,160 MB swap holding 40 continuous cycles
  over 30 seconds with 0.00 ms access latency under WSL2/Hyper-V.

Signed-off-by: emersonbusson <emersonbusson@gmail.com>
