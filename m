Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D545C2E3710;
	Sun,  6 Jul 2025 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751786623; cv=none; b=eUPaxNpwIV1bMGQLC1w5GYrOehbc1o4o0gBs2MvpE8QsZijOVndyjEvO3SyE0HphpmtKL9Dnu9FJAxmtSRco5WtHGf7vEDZgLzssWdE4VGo2/H9huzISOxGCxHEWCdJaYvhZk9t+5h1ZpZSAZFBv7qfIZ/3wArEjM7bdy20x2wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751786623; c=relaxed/simple;
	bh=+Jpz5fT8UZI9h0JQ8Vd2p7U6j6ILiBAW8DawEZvZbNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q+eFCIk7Q+m9WKsVjBt7W68YTbSr53I1MiIUnqBYe0LkOufYKwWh6DrvPrrqlyRY+M3gS6/lVFQUgQE+DAdabmvUkgxAIMMB3X0cvSfYfOZm+3KTiIX6Plw9NiP8yOSDGEkslKEyFJnllanJLHpa+2mW0V0BS62JsooI1YUiwk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXBxx0so; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXBxx0so"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747e41d5469so2437637b3a.3;
        Sun, 06 Jul 2025 00:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751786621; x=1752391421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0F/piBOlPUmOPt5QqSaELuOTnzlcUBcvkKa6RjbsxuI=;
        b=DXBxx0soC96HmPuN1m10bUjzFxYnY8qvYoORCJniy36+okBUHWmC9winFuT0A4JluW
         aUXMOTBK7DaFEKsf6ASI4zu91IevFd/M/gkENIo49IfGzLUlBT7QZktj54E+n8YKLlaa
         5NcybcyINk7IXyUKSbpbMY4XScyqwMW9VuBv0HHawzjp5XkVBRWJY/Vrrs2Y6PP1bVC6
         2AxXd3KNEXtK6y32NoI/RErRvrJBAMtI4ajizEg1XHHK+5nF/VsUa+SfrBIg0u/LSARA
         LEricbsA8NrwXGPsnFYFpVMDH9VPSa5EpmzZjGyVtMmR4QKyLZ0DMS5BAkdixc7MA2xR
         VlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751786621; x=1752391421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0F/piBOlPUmOPt5QqSaELuOTnzlcUBcvkKa6RjbsxuI=;
        b=oiifbh4hWbFE+gx7+61eoYuQ40xeAmNgnh3qZYB65Vioi78DEvUCitc+8UIWijU/wi
         PqXyd8Y8iQNiOC93nr97n7A9ahJ7+5w4pNaPFpFhu5NYysUTrzvfcQpajmNFP2fag2fD
         b/vGMfvHw/Lt4lZPe0EPyTdeETJPblW0DwdFTmlkZmsvZlHCo++dAKpPR1oRwXbMdfql
         qkGyW7lCfRjpoAP8n4ix+OPzW4EXboU+d5pFIXdUH+/8RNiCnqxjJp2Et9nsoOHvJGwH
         RPcNP28XTvQz0OHuwyuOH6Lhlkz8PVjwVQapvP/8iqP6HBf91Ws7OYonMK5FPl/oixZq
         4L3A==
X-Forwarded-Encrypted: i=1; AJvYcCV/uxXxGOG/Zr6ZopXDAK378E3qfP3EneZGib+FPeQRuvQIZgEvfVGXvzTM6+yPuY87+TxufYYX4nLg6WA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoKewnl50ezw40MbiW4dQlv/ZB/X0n8Zaxa2yruZswKjyb5g0M
	PmOj6VYdg0PbZzucGTQitaeBM2BgaoVoLTi7ehV7B/WOCGgLUDTzlvgj
X-Gm-Gg: ASbGncuWY8Lmzbj6/RVjMCUGs+PKBIxE4Db84OaaABpXAxg5iNYCaCzLS2LtMwFiWJR
	gfP7gozxIJebLa6WyQe9wMfhHu2cmm+GIShiCrBj92r5LYHsjSu94jTkTxsDXLSnt7y3Ro0YcgA
	nrWcYT5ZDqrK0S7duoyoan6BKP5ZZhaWXVBpNjST/psgEamO2HdLf7JNT6Oop4EXBD2mLmOM1rX
	uAQ0ZJO9s0X4J7Md4b5W2KR6uuN3XIZb5PwHK3GLx0Y1Ap0dFcCGYSAKLgDwbxf42xmGrDABa78
	4u8MBWP1NzwTIsBY4uYEyET3ZqPZwjUXFa3Jk80zch7qsmHEUr29gowRex1BGP8ku4iz7BBZznn
	gDvR4OmwLXb4aTebcHrLijA4V
X-Google-Smtp-Source: AGHT+IHFTdNX1cxiPV5k1Yfv+OFlG9FKw52ATRDTyKgWCRkhLxm9RzgLzYtpszckajz4u1AwmI9n0g==
X-Received: by 2002:a05:6a00:bd03:b0:736:35d4:f03f with SMTP id d2e1a72fcca58-74ce884debbmr10483271b3a.6.1751786620921;
        Sun, 06 Jul 2025 00:23:40 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.lan ([2409:4090:20a4:5c0c:bc44:62c9:acfb:7029])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce429a0b1sm6141794b3a.115.2025.07.06.00.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 00:23:40 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: efremov@linux.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH] block: floppy: fix uninitialized use of outparam in fd_locked_ioctl
Date: Sun,  6 Jul 2025 12:52:13 +0530
Message-Id: <20250706072213.14954-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix Smatch-detected error:
drivers/block/floppy.c:3569 fd_locked_ioctl() error:
uninitialized symbol 'outparam'.

Use the outparam pointer only after it is explicitly initialized.
Previously, fd_copyout() was called unconditionally after the switch-case
statement, assuming outparam would always be set when _IOC_READ was active.
However, not all paths ensured this, which led to potential use of an
uninitialized pointer.

Move fd_copyout() calls directly into the relevant case blocks immediately
after outparam is set. This ensures it is only called when safe and
applicable.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 drivers/block/floppy.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index e97432032f01..34ef756bb3b7 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3482,6 +3482,7 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
 		memcpy(&inparam.g, outparam,
 				offsetof(struct floppy_struct, name));
 		outparam = &inparam.g;
+		return fd_copyout((void __user *)param, outparam, size);
 		break;
 	case FDMSGON:
 		drive_params[drive].flags |= FTD_MSG;
@@ -3515,6 +3516,7 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
 		return 0;
 	case FDGETMAXERRS:
 		outparam = &drive_params[drive].max_errors;
+		return fd_copyout((void __user *)param, outparam, size);
 		break;
 	case FDSETMAXERRS:
 		drive_params[drive].max_errors = inparam.max_errors;
@@ -3522,6 +3524,7 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
 	case FDGETDRVTYP:
 		outparam = drive_name(type, drive);
 		SUPBOUND(size, strlen((const char *)outparam) + 1);
+		return fd_copyout((void __user *)param, outparam, size);
 		break;
 	case FDSETDRVPRM:
 		if (!valid_floppy_drive_params(inparam.dp.autodetect,
@@ -3531,6 +3534,7 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
 		break;
 	case FDGETDRVPRM:
 		outparam = &drive_params[drive];
+		return fd_copyout((void __user *)param, outparam, size);
 		break;
 	case FDPOLLDRVSTAT:
 		if (lock_fdc(drive))
@@ -3541,17 +3545,20 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
 		fallthrough;
 	case FDGETDRVSTAT:
 		outparam = &drive_state[drive];
+		return fd_copyout((void __user *)param, outparam, size);
 		break;
 	case FDRESET:
 		return user_reset_fdc(drive, (int)param, true);
 	case FDGETFDCSTAT:
 		outparam = &fdc_state[FDC(drive)];
+		return fd_copyout((void __user *)param, outparam, size);
 		break;
 	case FDWERRORCLR:
 		memset(&write_errors[drive], 0, sizeof(write_errors[drive]));
 		return 0;
 	case FDWERRORGET:
 		outparam = &write_errors[drive];
+		return fd_copyout((void __user *)param, outparam, size);
 		break;
 	case FDRAWCMD:
 		return floppy_raw_cmd_ioctl(type, drive, cmd, (void __user *)param);
@@ -3565,9 +3572,6 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
 		return -EINVAL;
 	}
 
-	if (_IOC_DIR(cmd) & _IOC_READ)
-		return fd_copyout((void __user *)param, outparam, size);
-
 	return 0;
 }
 
-- 
2.34.1

