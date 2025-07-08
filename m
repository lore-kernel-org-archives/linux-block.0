Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28025207E1D
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979515; cv=none; b=C637UDnuuE82dPTQVwL5QYjNtW00RfhxqLje87rf/W82jXzD5j8XeKrJBU0XWQ6UJNwabKfh7kFzmNDyva+79LzxqeZN9J63+UqmSsR4FGFf9Hl2HmLsVn++FVFc3yusXaRfKyhpXRdhOPNhzBG4FUQOmImK4u62ofhEMbH2MEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979515; c=relaxed/simple;
	bh=GFp21yRRDHkZr4cCjY4/NQ6IGi4IO90BeOiQ8FLxxNM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OOSugFDpApSHyIZV0ySJ70Cr73dmFbbKwG9lD57gC4lkUrLkdYmn6rbBt4YVqGneggrHoBRfiDMHkjTJ1mcy8mR35m6An+IQgSKD070e0A/comCP22rYSlg0UhS1dLfRhm8KJC3RMiPvnMRknesXWCSkLqkyYWRvHqFvKn/GveE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UDiYgsJ/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UDiYgsJ/"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b321bd36a41so3700770a12.2
        for <linux-block@vger.kernel.org>; Tue, 08 Jul 2025 05:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751979513; x=1752584313; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+X7a8SwyNPxgnTjPQjoQvFIKm71E0lpWMhaVdYWW8Ws=;
        b=UDiYgsJ/fbsKPpi0u1S+3EnJEqHbcvV82whIEThUOPjtStoZtMF0sRlzIuXLt32vcL
         ux5VfNln1Mzq0iD9ojv3EADPdr2HuwJBdaE7T8zWjGLix/ZzOUeuSZj1YdHyBhkbZeow
         fg7g7B/+D47SSnrhui9wlTvq2bT+R1hWKelP9IuvJkC0dqxzUAxPpmP8FuiRnO8bGdaY
         0I0w66v0uCMEpeQe+UmZh0t4OeIXv4u7kNgYeHAo2Z1ZHllrR2QNw9P83eR8mOEV6izd
         AB4Lx8Z2RBSC08a5scoVwyBOrQCXwfrn7ByZCI0pCF09uzsN2+SgCKItCHyIEKCffAax
         OFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751979513; x=1752584313;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+X7a8SwyNPxgnTjPQjoQvFIKm71E0lpWMhaVdYWW8Ws=;
        b=ornFFHTuQb/yzT1Sv1OdTMWlPR2NSIDQWwW5hmUJFNUlKy4oLpxncqnQqf8CH2Y7Ve
         ufy28wReQDcPCFn3D0zqUt0hB+LLdFS1ftvg9JRXu9yraR2oETiQGlFK/UTBubg8uzXU
         DESzNyoNLtV5ZHAFCVi5ipwwhJbTSHN2Ol0ogF2GH6h5xcDAnJgo8i7LHheOrGlfwRzD
         1gyrTvZZisMQ/9z71jSV4Nk3a6dbAPOuvBivbintwDO9kdAhQ7bmnnF58HwG4hc9KxYg
         zCIxZhHDcl4BllhTflIAeb3rkjA+58+rudeSNJYrWJCYuDQghz2ps5pPQotDAJOJENfY
         Df7A==
X-Forwarded-Encrypted: i=1; AJvYcCWBkXgYEjsxwMSTfYMg7o25eIpkhkeXT8RiMJfgVoPElb7d8+mRvQ1s04+xw46tOdWf+FafqsRvVYMJIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS5MhE1Le9ppYTxr7pruEq6bIhOmAgtM67iwY5uDoqG57ShajB
	Sr+23H2wUx/USumy6t9047rbo42VRyQ/KdEXNoCuRc/3Zo/pCnbuf3Giwb5F2Dt+9orQDAZsyxh
	/pit1y84VOS2Fqf7lkJdzq8l17l4UmwLmI0kjMXJyVw==
X-Gm-Gg: ASbGnctUTZ3E2krTfZvpjAg30dhiashxePIw1CEcd0+bZ7NU6lda7BQcKlssTR7ZXSE
	oqNKvr3Q6thPPS5/wRBvg5/YlQjfmQTVAzgKB2GB7Bl0X/Fy9MTxR/OEeSGf3DWJhQn57dV0f4A
	ioE9u6a+yr813UFSuqA3+s9ZgU0pPj0cP/WQ31iYuVSGpiMvhe0f+v4EUV92gMqle4NvnyNZwa7
	g==
X-Google-Smtp-Source: AGHT+IEAroSV9QM2u8Khd5heAl2VGKIwbciV1NozFVDk7m9ivDnulTuum/WrPGnR1hmbsA4sVwMc5gI6C1gsYlXHc2E=
X-Received: by 2002:a17:90b:3c8f:b0:313:1a8c:c2d3 with SMTP id
 98e67ed59e1d1-31aadd8535fmr18954212a91.22.1751979513324; Tue, 08 Jul 2025
 05:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 8 Jul 2025 18:28:20 +0530
X-Gm-Features: Ac12FXwWrUCbiwerbOClJgpOYjoDYvos-PTDZgR-SJk-i4t_-gCTbszd43doxzs
Message-ID: <CA+G9fYvk9HHE5UJ7cdJHTcY6P5JKnp+_e+sdC5U-ZQFTP9_hqQ@mail.gmail.com>
Subject: LTP: syscalls: TWARN ioctl(/dev/loop0, LOOP_SET_STATUS, test_dev.img)
 failed EOPNOTSUPP (95)
To: LTP List <ltp@lists.linux.it>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-block <linux-block@vger.kernel.org>
Cc: Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Petr Vorel <pvorel@suse.cz>, chrubis <chrubis@suse.cz>, rbm@suse.com, 
	Jens Axboe <axboe@kernel.dk>, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Regressions were observed while testing LTP syscalls cachestat01 and
other related tests on the next-20250702 Linux kernel across several devices.

The issue appears to be related to the inability to configure /dev/loop0
via the LOOP_SET_STATUS ioctl, which returned EOPNOTSUPP
(Operation not supported). This results in a TBROK condition,
causing the test to fail.

Test environments:
- arm64
- qemu-x86_64
- qemu-riscv

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

Regressions started from next-20250702 ( next-20250708)
Good: next-20250701
Bad: next-20250702

Test regression: Linux next-20250702 TWARN ioctl(/dev/loop0,
LOOP_SET_STATUS, test_dev.img) failed EOPNOTSUPP (95) TBROK Failed to
acquire device

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test log
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_cacQ9AfS0 as tmpdir (tmpfs filesystem)
tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
tst_device.c:190: TWARN: ioctl(/dev/loop0, LOOP_SET_STATUS,
test_dev.img) failed: EOPNOTSUPP (95)
tst_device.c:362: TBROK: Failed to acquire device


## Source
* Kernel version: 6.16.0-rc4-next-20250702
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 50c8770a42faf8b1c7abe93e7c114337f580a97d
* Git describe: next-20250702
* Project: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250704/testrun/29017637
* Architectures: arm64, x86_64, riscv64.
* Toolchains: gcc-13 and clang-20
* Kconfigs: defconfig+ltp

## Build
* Test log: https://qa-reports.linaro.org/api/testruns/28986655/log_file/
* Test details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250702/ltp-syscalls/cachestat01/
* Test history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250704/testrun/29017637/suite/ltp-syscalls/test/cachestat01/history/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2zJjY2EmRMul6P0UgjdOm4Ssiqh/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2zJjY2EmRMul6P0UgjdOm4Ssiqh/config

## List of tests
  - cachestat01
  - cachestat04
  - chdir01
  - chmod09
  - close_range01
  - copy_file_range01
  - copy_file_range02
  - creat09
  - fallocate04
  - fallocate05
  - fallocate06
  - fanotify01
  - fanotify05
  - fanotify06
  - fanotify10
  - fanotify13
  - fanotify14
  - fanotify15
  - fanotify16
  - fanotify17
  - fanotify18
  - fanotify19
  - fanotify20
  - fanotify21
  - fanotify22
  - fanotify23
  - fchmodat2_01
  - fdatasync03
  - fgetxattr01
  - fremovexattr01
  - fremovexattr02
  - fsetxattr01
  - fsmount01
  - fsmount02
  - fsopen01
  - fsopen02
  - fspick01
  - fspick02
  - fsskipig01
  - fsskipig02
  - fsskipig03
  - fstatfs01
  - fstatfs01_64
  - fsync01
  - fsync04
  - getdents01
  - getdents02
  - getxattr02
  - getxattr03
  - inotify03
  - ioctl04
  - ioctl05
  - ioctl06
  - ioctl_ficlone02
  - ioctl_fiemap01
  - ioctl_loop01
  - lchown03
  - linkat02
  - listmount01
  - listmount02
  - lremovexattr01
  - lstat03
  - lstat03_64
  - mkdir09
  - mknodat02
  - mmap16
  - mount01
  - mount02
  - mount03
  - mount04
  - mount05
  - mount06
  - mount07
  - mount_setattr01
  - move_mount01
  - move_mount02
  - msync04
  - open_tree01
  - open_tree02
  - prctl06
  - preadv03
  - preadv03_64
  - preadv203
  - preadv203_64
  - pwritev03
  - pwritev03_64
  - quotactl01
  - quotactl04
  - quotactl06
  - quotactl08
  - quotactl09
  - readahead02
  - readdir01
  - rename01
  - rename03
  - rename04
  - rename05
  - rename06
  - rename07
  - rename08
  - rename10
  - rename11
  - rename12
  - rename13
  - rename15
  - renameat01
  - setxattr01
  - stat04
  - stat04_64
  - statfs01
  - statfs01_64
  - statmount01
  - statmount02
  - statmount04
  - statmount05
  - statmount06
  - statmount07
  - statvfs01
  - statx06
  - statx08
  - statx10
  - statx11
  - statx12
  - sync01
  - syncfs01
  - umount01
  - umount02
  - umount03
  - umount2_01
  - umount2_02
  - unlink09
  - utime01
  - utime02
  - utime03
  - utime04
  - utime05
  - utimensat01
  - writev03

--
Linaro LKFT
https://lkft.linaro.org
