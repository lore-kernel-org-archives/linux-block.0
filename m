Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB6219BBA
	for <linux-block@vger.kernel.org>; Sun, 16 Jun 2024 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718573457; cv=none; b=mo8jtjoyARxn+6BoMV45vHwMm9XhSIDFgicXaG5L2sMRBr++X/oHxRgIIg6MIUXFDmpdsaTjYi96fZC/UdtyOmXLbbV8GFZE12EzsHxgQrBvZHZ/a5xXQ9DK3RicINxp8Yl7/TRG+iJpK8gWqPWzEacp/Ko+DuLWE8UcLIN7Lgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718573457; c=relaxed/simple;
	bh=FIKoZwBEvvITzeAEwHf9UM0IMTE3gBDTcnLA/ddszps=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hLfkTotKIdWA0Y6rj7F6oPctBBZgP/T3lotXVkeQixI2z6QCz02Ubt6JSURAlEqWdc5hUPFlt4XVgL6LAFbHPCrW6WERBMPOUFebvo/jghi2cLKi6bFAIeRtzEIIsGV28mrcVdcvKKZPvIP5wzfGV7C0ZDA/X3u7iNjdyEoeBfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=U1bpNWzT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U1bpNWzT"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c4b8d8b8e0so715538a91.2
        for <linux-block@vger.kernel.org>; Sun, 16 Jun 2024 14:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718573453; x=1719178253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQhrXwUi+OvcUMAXue/hmuLunIoA1lw15kWxV8BcvyU=;
        b=U1bpNWzTRjLH+7/053HSeTIiTQKgbAxHVFZQP3cZMwxxjMvfSjICqkbVuZfe/aqeeq
         Q87XFw/gC5a4tWjq69/2budA0hWWTJ7xX+TuGP3u2pNXuF3pB81x8i8tE2LbfkHUjst3
         EAB4cbUfJn54h4k+qKKFkx9zwKSfG6s6QcS3iPeyqRxTw2ENdzivLjuGWI/6+dxksNM1
         A+evYltWAdUSayqu6v7Zrp/H/gzgMYeimqxkz+Le+J9bipZt994HZFT2cQ3r7SeqhdKq
         amWUILORuQtQJAnvc3F2bH3qZiUIZXFRtRM1xkm/5D+TW5iIhn1ZhDa2cHozQwvlnnpj
         LIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718573453; x=1719178253;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQhrXwUi+OvcUMAXue/hmuLunIoA1lw15kWxV8BcvyU=;
        b=PSiYcQPEaNephzSE9JQxBPMAMTPRs51glY7bu/DR0DxwKtbHFtRbbr2OYIbB5pzIqa
         OOnb1cZZxnKRrg1K5+jTcNJBR7sufcKWfzOVuLY/cT6aKRko+BywHFANLl5vCb7riNEw
         DSGWIlmKcWm9ZqTrgwjv4MMZFGp8IT1Y2GPMOUZSm7XNTRAnvXPfbQdkFEz6ulanJdgb
         xz7UZOvQ+ohZ5FnoD+pvNMMy3V+B9z/lrUtCDYyBouqnomwF1G2wfLSkcjx+wF8J1kXe
         b7PKg4OIG08T4qvc2CIx3YG9J0SKsX6xjubpSL/EskBXAqk0LQNdn9O+dElzJfnqDumt
         Zrhw==
X-Gm-Message-State: AOJu0Yys3yGKm7JMGiVk1Mo0pIAKWjK7hM8XD6vpGFxmwBZGpXf2+8qv
	FjEn2et3Q0P0i7zMfshEykHVt6jyqaTcFjkqRHpdKl3Qf91bSppCkUy50vQGIaWMbBoKF3kTsLZ
	C
X-Google-Smtp-Source: AGHT+IE4hzpSWBVBfSDYsNo/W5vH/86czlhT5zRgnZoFcPfJy/8xeB1f14SB8dEZkLpYN5NNo/SXEw==
X-Received: by 2002:a17:902:eccc:b0:1f7:1a37:d0b5 with SMTP id d9443c01a7336-1f862c30f6amr97176705ad.4.1718573453246;
        Sun, 16 Jun 2024 14:30:53 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e71a15sm68092885ad.83.2024.06.16.14.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 14:30:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: paolo.valente@unimore.it, John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 jiapeng.chong@linux.alibaba.com, hch@lst.de
In-Reply-To: <20240614090345.655716-1-john.g.garry@oracle.com>
References: <20240614090345.655716-1-john.g.garry@oracle.com>
Subject: Re: [PATCH 0/3] Some block sparse fixes
Message-Id: <171857345207.18332.15693298636377250623.b4-ty@kernel.dk>
Date: Sun, 16 Jun 2024 15:30:52 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0-rc0


On Fri, 14 Jun 2024 09:03:42 +0000, John Garry wrote:
> Branches for-6.11/block and block-6.10 both have the following sparse
> build issues:
> 
> block/bdev.c:388:17: warning: symbol 'blockdev_mnt' was not declared.
> Should it be static?
> block/blk-settings.c:266:9: warning: context imbalance in
> 'queue_limits_commit_update' - wrong count at exit
> block/blk-cgroup.c:834:5: warning: context imbalance in
> 'blkg_conf_prep' - wrong count at exit
> block/blk-cgroup.c:965:9: warning: context imbalance in
> 'blkg_conf_exit' - wrong count at exit
> block/blk-iocost.c:732:9: warning: context imbalance in 'iocg_lock' -
> wrong count at exit
> block/blk-iocost.c:743:28: warning: context imbalance in 'iocg_unlock'
> - unexpected unlock
> block/blk-zoned.c:595:30: warning: context imbalance in
> 'disk_get_and_lock_zone_wplug' - wrong count at exit
> block/blk-zoned.c: note: in included file (through include/linux/blkdev.h):
> ./include/linux/bio.h:592:9: warning: context imbalance in
> 'blk_zone_wplug_handle_write' - unexpected unlock
> block/blk-zoned.c:1747:31: warning: context imbalance in
> 'blk_revalidate_seq_zone' - unexpected unlock
> block/bfq-iosched.c:5498:9: warning: context imbalance in
> 'bfq_exit_icq' - different lock contexts for basic block
> 
> [...]

Applied, thanks!

[1/3] bdev: make blockdev_mnt static
      commit: d9c2332199d073c5edd7163d64fbdee6224d8c08
[2/3] block: Drop locking annotation for limits_lock
      commit: c3042a5403ef2be622023fcc3b11fc1aa08ba7fa
[3/3] block: BFQ: Refactor bfq_exit_icq() to silence sparse warning
      commit: 66088084fdabb6e5075cd19e8ffe15b8bc7e3708

Best regards,
-- 
Jens Axboe



