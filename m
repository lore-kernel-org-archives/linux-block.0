Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1746316C86B
	for <linux-block@vger.kernel.org>; Tue,  7 May 2024 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088752; cv=none; b=Sp4SO1Yu/jcUcKrcuDNPdz0m3tzXNWhmQdpmU5Y8HJWNckHRwI/emfEFdAWrw9j/FNEGmhJIm6oVigvEdDz/rCMADIgoueIuXIQRPsQjbpcW16mfUnnSs/RQcQEX+aJkLJwfr7aiptavHeBuVs1l8uDDER4PxwJqk5BwY45IK+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088752; c=relaxed/simple;
	bh=KIRJRDa1gvyO+tBmFgCCfyHg5Usq9RjA8yXIGF3j01c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UJ6ODmoqlA4gvbQJNJ9ocSGpMXoqqu2sW4KPpJeTGsPQ1da5dY2C6OTTQIQTzcovmtTZ5Xd8mf5KVUJ7hYVTbzoNsDVVV9ksrJIHXGQOFncmBE1O2MId6BhO1Gw4njQ3ccwu49wXBO/BPNnCfF0o42lCW0Z7HJNclYUGSfj5TtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aAqzNXdi; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aAqzNXdi"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7e186367651so4676939f.1
        for <linux-block@vger.kernel.org>; Tue, 07 May 2024 06:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715088749; x=1715693549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wEpUHSgdU/K4nhfhPHL/T/9eC8GMc/mPSpVyaQLiYM=;
        b=aAqzNXdiXEh/bvlXtewdWv2VguKTpxhpoystxJuMLulDJpZLToDvdvIRe0L0J/GzSY
         ln3hMK9AsL5b9lSTHZmOp6AnHzCA7TCYQWZZsJ36Q1YrhuSjd0WwY0i7c573YbbcJ/qe
         olmo0vfAU49HQZyOWFA13p9V9dWNdiUlKch9JF25gPgOmBMvsGuIn222PdJTxtdhbQB3
         E951vulcZBagcA/6rWTXbWHzEJV4/3YFsh8RkWuzjwk1GG9ynEg766HxG5im3iS1tvKb
         HNXvVuBzovbadVPW5d2274R3ICqBNtXg7HQqjjTgRM1K4uiVWYA4XUMe0nCB2Bc1vdV5
         K/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715088749; x=1715693549;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wEpUHSgdU/K4nhfhPHL/T/9eC8GMc/mPSpVyaQLiYM=;
        b=wF3wJZjNnurl1geiktaJvAYJjaUs5R+lYucStieL64OV10VMdlKrdHauz7ZMWQC97t
         bmca95UoJZInveUaua0izyZD8/Wt3tZT7fnkFjpphIkYldKyxq7ecQdl7Zr8B/SRdveo
         Gk5gqhWpujuOkNRftk3r4GQ9dxpjpXAIcx4bh2iyJsc+Ij1EZhJaI3TET11FO7tinu1E
         t92hqe8rLoME8V2RdGPSC3k24OdwoMLN6fHHqWt7gEhKoMcmY4qhrBcQLqZD/8C5hswt
         QL9Q8E84WCaKWleWjUSDLbgj/lZOXjDpY/69wnSSZ2srvOHb4aRdlvKxSEDcMahi/v5d
         XAnQ==
X-Gm-Message-State: AOJu0Yy4qyb7wH7c8PfRFVubPmZCIinsjTmipW2qaYzZz7tMrMYKSA52
	O59gL3LdPSFehcIWgGllX4kMUe50YmNP07EGGWczjxNl4ZNnWdGgTiGqIaDsB08=
X-Google-Smtp-Source: AGHT+IF04Oo8ziX3v7vzRLo38KRqnxrxsDhJVppfzLrwRctcIFsm2uI/0CDJtecpHxmUUtUA9cN8/Q==
X-Received: by 2002:a05:6602:3f48:b0:7e1:8bc8:8228 with SMTP id en8-20020a0566023f4800b007e18bc88228mr626486iob.0.1715088749205;
        Tue, 07 May 2024 06:32:29 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id kw24-20020a056638931800b00488b8c8eae9sm727626jab.104.2024.05.07.06.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:32:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev
In-Reply-To: <20240507-b4-sio-block-ioctl-v3-1-ba0c2b32275e@google.com>
References: <20240507-b4-sio-block-ioctl-v3-1-ba0c2b32275e@google.com>
Subject: Re: [PATCH v3] block/ioctl: prefer different overflow check
Message-Id: <171508874856.11829.2888197344803458968.b4-ty@kernel.dk>
Date: Tue, 07 May 2024 07:32:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 07 May 2024 03:53:49 +0000, Justin Stitt wrote:
> Running syzkaller with the newly reintroduced signed integer overflow
> sanitizer shows this report:
> 
> [   62.982337] ------------[ cut here ]------------
> [   62.985692] cgroup: Invalid name
> [   62.986211] UBSAN: signed-integer-overflow in ../block/ioctl.c:36:46
> [   62.989370] 9pnet_fd: p9_fd_create_tcp (7343): problem connecting socket to 127.0.0.1
> [   62.992992] 9223372036854775807 + 4095 cannot be represented in type 'long long'
> [   62.997827] 9pnet_fd: p9_fd_create_tcp (7345): problem connecting socket to 127.0.0.1
> [   62.999369] random: crng reseeded on system resumption
> [   63.000634] GUP no longer grows the stack in syz-executor.2 (7353): 20002000-20003000 (20001000)
> [   63.000668] CPU: 0 PID: 7353 Comm: syz-executor.2 Not tainted 6.8.0-rc2-00035-gb3ef86b5a957 #1
> [   63.000677] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   63.000682] Call Trace:
> [   63.000686]  <TASK>
> [   63.000731]  dump_stack_lvl+0x93/0xd0
> [   63.000919]  __get_user_pages+0x903/0xd30
> [   63.001030]  __gup_longterm_locked+0x153e/0x1ba0
> [   63.001041]  ? _raw_read_unlock_irqrestore+0x17/0x50
> [   63.001072]  ? try_get_folio+0x29c/0x2d0
> [   63.001083]  internal_get_user_pages_fast+0x1119/0x1530
> [   63.001109]  iov_iter_extract_pages+0x23b/0x580
> [   63.001206]  bio_iov_iter_get_pages+0x4de/0x1220
> [   63.001235]  iomap_dio_bio_iter+0x9b6/0x1410
> [   63.001297]  __iomap_dio_rw+0xab4/0x1810
> [   63.001316]  iomap_dio_rw+0x45/0xa0
> [   63.001328]  ext4_file_write_iter+0xdde/0x1390
> [   63.001372]  vfs_write+0x599/0xbd0
> [   63.001394]  ksys_write+0xc8/0x190
> [   63.001403]  do_syscall_64+0xd4/0x1b0
> [   63.001421]  ? arch_exit_to_user_mode_prepare+0x3a/0x60
> [   63.001479]  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> [   63.001535] RIP: 0033:0x7f7fd3ebf539
> [   63.001551] Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> [   63.001562] RSP: 002b:00007f7fd32570c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [   63.001584] RAX: ffffffffffffffda RBX: 00007f7fd3ff3f80 RCX: 00007f7fd3ebf539
> [   63.001590] RDX: 4db6d1e4f7e43360 RSI: 0000000020000000 RDI: 0000000000000004
> [   63.001595] RBP: 00007f7fd3f1e496 R08: 0000000000000000 R09: 0000000000000000
> [   63.001599] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> [   63.001604] R13: 0000000000000006 R14: 00007f7fd3ff3f80 R15: 00007ffd415ad2b8
> ...
> [   63.018142] ---[ end trace ]---
> 
> [...]

Applied, thanks!

[1/1] block/ioctl: prefer different overflow check
      commit: ccb326b5f9e623eb7f130fbbf2505ec0e2dcaff9

Best regards,
-- 
Jens Axboe



