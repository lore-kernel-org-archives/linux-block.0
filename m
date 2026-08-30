Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68D535F170
	for <linux-block@vger.kernel.org>; Sun, 30 Aug 2026 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788075223; cv=none; b=m2QmOszEtQTXomdfPoU3LmecH5OtWARqfayBd4XeRZZ601uPwkmV+nbhnhj9IS1IvyfqWDkyz8gn3+qFdo1MMI8tKqpqPmbmiQm3l/Hb6WFcEnYobtXzDmGE3pUSn3xOGL5TCrUYaPODkmt6oYBnP4Aex1x90AzpOcQ9klaFyx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788075223; c=relaxed/simple;
	bh=U41QKWCb5wZVT5AgkRyZK+w6MKjpL9Tu8ac+zzjqQUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZDod7EzFo5MTrcI7w2iTMIJxrBxkN1/3RA5TmwM0x5b/7AwLDAepLtN7x+KHuNTyV21Rw0PxqZX2awx5wq8tdLUA23cAJSiKxMdPxFj6lst/muF2rYAZWurqEj6YH7L1ZVNDLfj29H7ywloOXgWnLaQNMWm7GR/GYcCQDEPc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bT0hYlFS; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT0hYlFS"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca12086c06eso1907635a12.0
        for <linux-block@vger.kernel.org>; Sun, 30 Aug 2026 00:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788075221; x=1788680021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5hgvVg90KPg9PlOfVqdnTJqeAsOm9vQLV6x0bJ/G+8U=;
        b=bT0hYlFSkrmlQQSf7CERb2qkBx7IMOV25+c7Q5DEStmuuc/tT+BwOR4n91aMdVza+B
         s10wPY/67LVo59mo7y56DXSfN0h1ZpgwVdaT2OILKNW+swoVuGQ7nrwRFfimoH/Kj4yU
         pCPBM6vK+EQ18oG22YlDKj3OVgVGqGnWP+P9v7kegmnhxLF8xN/tS3VrHbr/IVu+mQrN
         yn+hxFxCJ/8mXRAsQLhCq8lNXXdal27sSkXG4ShUAEDbJox97//da3knloAd4cc4Xx5r
         shDJ2D2C2nlYK6UaO7DNkK3d77V1DD+Bd4z8JkLqp1rHk9NV58hY16ZDzG4lp5+WcH9K
         4IAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788075221; x=1788680021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5hgvVg90KPg9PlOfVqdnTJqeAsOm9vQLV6x0bJ/G+8U=;
        b=lkMb2x+VifdFgBgAdqwaghbZwJhnRQVsYgBHKUrx7tkoDoHDHS7IsTZKgz3fV5Wo2m
         ptyECXWJxe1me0oNqYBdMsLTzJpLUNVOiiv83zPzKBPEsI7T1YHHfNH+tMMDDqc0KiaH
         Nf2nm0BtfX7GlumqEmsjsi1FhxvNSVHVF2jqLmyRHoF9tGf0gzgu4bOVcMg/Xf5E6Cg3
         WzWE8z4UoeoVmMNzOrTRE1xWcc8mn8r3L6piQec8QgB2OnDjcMzPYNfj590qKyUEX9bY
         h2VOiQn8sFiKtWHaCIlfLJDyYGe+JtFKOxS96yIm51V3aWkeI35JxvKhYN8RnT8rBYg6
         AyHA==
X-Gm-Message-State: AFuF++lKGkvk+nsqR2HXjHXW5Y0FqDO6a/WEio1cpC6wpKG8kMs85UZl
	R5bp0cZqaIyWgnCpuZIbTNEow/1kc2wHIavS1bdsrqwX3jo/PuRLFNMJ
X-Gm-Gg: AR+sD116r06DhSqyFFG3609C9p9ln3ItR6e6YOcrcC3AmKueW8TR1vPfz+Ooxpe3VsZ
	dv4LKUY/xqB78SfAnHO1c8viDdOG1b8B+Wq2itEqEkjJVH8WSwFzAZ0l1+c/U8biuxIlmnbc5Yu
	3AQ/Nla2FHKH3QxU5fNJKO4FK6fhYvLQ5amCThM2yH7LA/o/Q+XWvXOeR7zCylVgEAjn9C87ncG
	eOJfUlqhueZhfBq65Dx54kvN7l+lShB9Djs7HLNmefvoR5LSj+hdXRiESMv6ARn9jZQQYuxBPz8
	8/3WOqEutrkrlZlmcxxfwcAWQodz0Ipng3IH2bMsnx3DbMvbRUpkUsIrJM4of9gS67YlIyeJkGt
	ulZ+/xAk0srbz5pchp2LAXXaPorRR2KK12QmmtbmfqrpsYKhIXXwNH98oPetZkp/llFahCKt2Jz
	H+VqlWPR8IWXUFetMMtVgkWodISxih+eF+ItLQLMEv7SucePchys/dd39XS7mMUzSoDnbTp7FsH
	EHDirClw4q54Gqt17aL7DSnf42kNRe99xs0NX1opvtLQVYAGNdUZE3K2g+ryistlk213TdAEsE6
	7uOUr8fv9g7YsxALFb12oM/xbJu8Jq7DDx4zQd6i+cNtJrfSSEoeC8ZVpZ/mKlqvgEabJtUQd1b
	VmE3NLrfViU47jFxyn7wST0WeVYSDumVZNk1VUeLQ8IrV6iWW9S8wRwexzN3f6MZpeKmlm+vGeY
	JEVc9aU5M=
X-Received: by 2002:a05:6a20:43a2:b0:3cc:f008:8125 with SMTP id adf61e73a8af0-3d265a3d2a2mr28366450637.1.1788075220885;
        Sun, 30 Aug 2026 00:33:40 -0700 (PDT)
Received: from HEXER.localdomain ([175.157.17.45])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e41837c6sm17293131c88.11.2026.08.30.00.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 00:33:40 -0700 (PDT)
From: Kanishka De Silva <kpskanna1915@gmail.com>
To: greg@kroah.com,
	tom.leiming@gmail.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org,
	Kanishka De Silva <kpskanna1915@gmail.com>
Subject: [PATCH v2] ublk: clear VM_MAYWRITE on read-only ublk char device mmap
Date: Sun, 30 Aug 2026 13:03:31 +0530
Message-ID: <20260830073331.634-1-kpskanna1915@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083055-isotope-broiler-88e5@gregkh>
References: <2026083055-isotope-broiler-88e5@gregkh>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_ch_mmap() rejects mmap requests with VM_WRITE set, but never
clears VM_MAYWRITE on the resulting read-only mapping. This allows
a userspace daemon to mmap the per-queue command buffer PROT_READ,
then upgrade it to PROT_WRITE via mprotect(), since VM_MAYWRITE was
never cleared.

The command buffer holds struct ublksrv_io_desc entries that are
kernel-written ABI; a writable mapping lets an unprivileged daemon
process corrupt fields such as addr, op_flags, nr_sectors, and
start_sector.

Same bug class as the drm/panthor and drm/vc4 VM_MAYWRITE fixes, and
the 2026-08-13 ptp/vmclock fix (a5edadbae57e).

Verified via mprotect() PoC: before the fix, a PROT_READ mapping can
be upgraded to PROT_READ|PROT_WRITE and a write into the command
buffer corrupts io_desc fields (confirmed under KASAN). After the
fix, mprotect() returns -EACCES.

Fixes: 3fee8d7599e1 ("ublk_drv: add io_uring based userspace block driver")
Cc: stable@vger.kernel.org
Signed-off-by: Kanishka De Silva <kpskanna1915@gmail.com>
Reviewed-by: Ming Lei <tom.leiming@gmail.com>
---
v2: Cc linux-block@vger.kernel.org and Jens Axboe per get_maintainer.pl
    (Greg KH). Added Reviewed-by from Ming Lei. No code change.

 drivers/block/ublk_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6c5bec7..e5ba07d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2653,6 +2653,12 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 	if (vma->vm_flags & VM_WRITE)
 		return -EPERM;
 
+	/*
+	 * The per-queue command buffer is kernel-written ABI; prevent
+	 * the daemon from upgrading to writable via mprotect().
+	 */
+	vm_flags_clear(vma, VM_MAYWRITE);
+
 	end = UBLKSRV_CMD_BUF_OFFSET + ub->dev_info.nr_hw_queues * max_sz;
 	if (phys_off < UBLKSRV_CMD_BUF_OFFSET || phys_off >= end)
 		return -EINVAL;
-- 
2.53.0

