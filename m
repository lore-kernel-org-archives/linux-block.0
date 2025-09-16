Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0E2E36FB
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758007660; cv=none; b=gLyaGQrD0BWvldQ8RPYxITpExkQ0P7KeIvlkRXFbXp5Ta1wqFCqSAGJpWQhIn1ffCpWy7tWI1C6N7P+RdFRKESEjGTv9EQQSqMaKWJ0PwEiODwNLYXQe6caEerHuZB8JH/Jl/WeL32p3lJC8Oi5uEIOvAgL7QgSoWVVWJeyMkd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758007660; c=relaxed/simple;
	bh=F9b2EyhEO6rGTgADu2vlV7ZYUMvWMAZOSNB2YByeOEQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HbMXlfDxPXuDxvnSBO85qTsoL/5sl9ez0cftfSO/NfwnQ8tmIG0K3VO8nHkmaT4yTqxwFsosi1LsrOC85k7rjpPQHRcSJXpNASjfYoW87lLvc6A3G+AkHSuubjWCeYcBfkF8cbATM7y74N8VdOpjplV3bkcXMNetAUsjcHal4gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cK6bTLES; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cK6bTLES"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-266fa7a0552so16636545ad.3
        for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 00:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758007658; x=1758612458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YdzUgBNm+Fykgerb+7FYicUv4mSP6WHZUtexZFjMOI8=;
        b=cK6bTLESUs2Iulj9mXcczqVlJ0+e9+ajybZFCW8UX16X85+39TkvjfVaesdgUNATw5
         6MJDXn+xPw384Z944YQ95XQwseK4ggaI0WRbswSw8JcnLRIW/bXDy6d12IWsRexJ+pgs
         t6qByrq2zQ9ThoAM08OnN6/ReaNqq4KPN0Cjxy1RKvEt8C1b1a69/fWhN7alO8Ss1+hO
         NQhCWvAetHG/BCQ3U10Oqnpq41GcCMaG2aKTqYaf6TAf6I5cR8UwkjXXHB9y9WZ4bjeM
         MKBxsP658VKTDpra8iI0uVWskCkkjj75Dnoxu4BVr+9/f98YA9nj6jbZjptDPBXQhAVp
         /nmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758007658; x=1758612458;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YdzUgBNm+Fykgerb+7FYicUv4mSP6WHZUtexZFjMOI8=;
        b=Ig3FjFzz9G7otO4YyYjOvk1xLaTIfHox2zEQiersCArhdiJ9A1gK0c/6YbcFrl34MG
         vfJZUyZtO7JLrllMfxrXc3V0Rhef1MUfFT6VPWmARgl02TB0NTsiPQHsKt8gEUCJ4Hyg
         SF9786u0ahZLWmA1Vn8fM3u84J5Vu6OdPQAtmwJ/ASz8CCalw1rmoBka6lm5ZYvGNYcg
         rVlzQf+h+xQxLft4ueM/t+j4wrUoajZizOGt1R4Ahz/jgwGhH6QfocjRk/uL7+vnDn/V
         CiG4d2BRUT1zXEqOk4CesVZ+57jzvWBfGfpZKNT22xM/su8qlcDky+oD5M5T5cJB3/QG
         OPZg==
X-Gm-Message-State: AOJu0YzxxfDZU89ewQL43hY6e7IdCKmqSv+tmh7a6zV3RM+kere9Y0Cs
	U34+we1hbPB/xTMr7ChssEfDShnYPafF6QbKaYdSCTyvSq0VGUERIqGtpNa15RqdiDplFGF/pHK
	n7xU+vZweE4NnZcUEyVDyn87GplCIwQ+gaVzdLFq3AWIsAX8/KZDe0uI=
X-Gm-Gg: ASbGncvxABiRYsbY0+yA9tTlZ+byw04222fObTAzJofqq7LHPIzxOQq3Cs1jiocjye7
	CTS6fl4qaUmqhm9hM0D35ogzC3HlnNzStPy+J6yOek92M4Lanis//HmULsTPmOmzT1nEhkfbcSV
	hwHxwntYIFcCPo1fm29/+l1FN0qVY4DQDHmdkRxIUdzsSMhKL7DNwzqFiYQFftWi77Obl6HHQWM
	nE77GyLXtB9wXGwADApz66vHHs7ryZ+echNAQlfCu4cgezV3yNKc3nSASkbKmO060Z6ILG4
X-Google-Smtp-Source: AGHT+IGaVagTx8hEuPpGoL7AEHAise+m6cLY73KC6Dl72g9vxKRp51S5NCherF7SA2OcxJNUcL1e+yLHf56LlaRQ9wY=
X-Received: by 2002:a17:902:d58a:b0:264:c48:9cae with SMTP id
 d9443c01a7336-2640c489f42mr117753185ad.38.1758007658046; Tue, 16 Sep 2025
 00:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 16 Sep 2025 12:57:26 +0530
X-Gm-Features: AS18NWAma5_BQDQUJLHrWh8m4zqOKBnCdl8KRwcCODUf5Yb_JGvr-6H4NUsMNP4
Message-ID: <CA+G9fYuFdesVkgGOow7+uQpw-QA6hdqBBUye8CKMxGAiwHagOA@mail.gmail.com>
Subject: next-20250915: LTP chdir01 df01_sh stat04 tst_device.c:97: TBROK:
 Could not stat loop device 0
To: linux-block <linux-block@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	LTP List <ltp@lists.linux.it>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following LTP chdir01 df01_sh and stat04 tests failed on the rock-pi-4b
qemu-arm64 on the Linux next-20250915 tag build.

First seen on next-20250915
Good: next-20250912
Bad: next-20250915

Regression Analysis:
- New regression? yes
- Reproducibility? yes

* rk3399-rock-pi-4b, ltp-smoke
* qemu-arm64, ltp-smoke
* qemu-arm64-compat, ltp-smoke
 - chdir01
  - df01_sh
  - stat04

Test regression: next-20250915: LTP chdir01 df01_sh stat04
tst_device.c:97: TBROK: Could not stat loop device 0

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test log
<8>[   53.655971] <LAVA_SIGNAL_STARTTC chdir01>
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_chdm4pHJb as tmpdir (tmpfs filesystem)
tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1953: TINFO: LTP version: 20250530
tst_test.c:1956: TINFO: Tested kernel: 6.17.0-rc6-next-20250915 #1 SMP
PREEMPT @1757983656 aarch64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
which might slow the execution
tst_test.c:1774: TINFO: Overall timeout per run is 0h 28m 48s
tst_supported_fs_types.c:97: TINFO: Kernel supports ext2
tst_supported_fs_types.c:62: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports ext3
tst_supported_fs_types.c:62: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:128: TINFO: Filesystem xfs is not supported
tst_supported_fs_types.c:97: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:62: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:105: TINFO: Skipping bcachefs because of FUSE blacklist
tst_supported_fs_types.c:97: TINFO: Kernel supports vfat
tst_supported_fs_types.c:62: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:128: TINFO: Filesystem exfat is not supported
tst_supported_fs_types.c:132: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:62: TINFO: mkfs.ntfs does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
tst_test.c:1888: TINFO: === Testing on ext2 ===
tst_device.c:391: TWARN: Failed to clear 512k block on /dev/loop0
tst_test.c:1217: TBROK: tst_clear_device() failed
Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 1
tst_device.c:283: TWARN: open(/dev/loop0) failed: ENOENT (2)
<8>[   53.679564] <LAVA_SIGNAL_ENDTC chdir01>
<8>[   53.708246] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=chdir01 RESULT=fail>

<8>[   53.933883] <LAVA_SIGNAL_STARTTC stat04>
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_staPDxElt as tmpdir (tmpfs filesystem)
tst_device.c:97: TBROK: Could not stat loop device 0
Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0
<8>[   53.947889] <LAVA_SIGNAL_ENDTC stat04>
<8>[   53.974024] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=stat04 RESULT=fail>

<8>[   54.048075] <LAVA_SIGNAL_STARTTC df01_sh>
df01 1 TINFO: Running: df01.sh
df01 1 TINFO: Tested kernel: Linux
runner-j2nyww-sk-project-40964107-concurrent-0
6.17.0-rc6-next-20250915 #1 SMP PREEMPT @1757983656 aarch64 GNU/Linux
df01 1 TINFO: Using /tmp/LTP_df01.7pcwUXe1CN as tmpdir (tmpfs filesystem)
tst_device.c:97: TBROK: Could not stat loop device 0
df01 1 TBROK: Failed to acquire device
Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0
<8>[   54.060936] <LAVA_SIGNAL_ENDTC df01_sh>
<8>[   54.087630] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=df01_sh RESULT=fail>

## Source
* Kernel version: 6.17.0-rc6
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: 6.17.0-rc6-next-20250915
* Git commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
* Architectures: arm64
* Toolchains: gcc-13 and gcc-8
* Kconfigs: lkftconfigs

## Build
* Test log: https://qa-reports.linaro.org/api/testruns/29896973/log_file/
* Test details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250915/ltp-smoke/stat04/
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/32l4Vv9hKep2EcmS18u3NBtmoAm
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32l4UF8KltAzu6kUpW3hXaYRWjZ/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/32l4UF8KltAzu6kUpW3hXaYRWjZ/config

--
Linaro LKFT
