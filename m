Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1C839F168
	for <linux-block@vger.kernel.org>; Sun, 14 Jun 2026 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781451341; cv=none; b=VYmAc2VmAqKX3WTSdjGvHuAuBMEZTerSQNXyRd/83yRptM3O9hHImJyH4lxL8Ea0+61c1vginF7Cmcdx9lI7LfKFqYnY6uZWpulISgsOx8jaNixQnmZQyQQIxuPCm+IYRne19o5T3tR20uclWeAdw/yP5P6u4wlV5A5SbCl6Y3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781451341; c=relaxed/simple;
	bh=YipMZO8vcbHpc9Uwgtl34KMkub+gxp1VqBvE4Awkxbs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DcvSMBgKlwVEiGrBmzJg8vOBtiG8/bS879yTklI7oJ+Azjwy6YvqoU7sPaq6SFMqUouJEWDCtpXEBEZqe4T5ian4WPJhYeq5INealtq/HS4pwFdgdQ+PTXEY20UKtwbiIDG1pkr9QNQO/U+imQQqvzlYJQdpyhlG6X+8tXTtmQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjQ3bxJD; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjQ3bxJD"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3074adb8fcaso3051010eec.0
        for <linux-block@vger.kernel.org>; Sun, 14 Jun 2026 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781451339; x=1782056139; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pR8769p891UZMpH2W/uEW47L6qds0Zm441UJr101ko0=;
        b=TjQ3bxJDzYcUOmMTJOpZ4H6fngnPEjLDNuLI/+pVANMM1nlcrXJ8IoeUXrUJ+biVMP
         zxb9+PZp42x6FWZ5PQDiHJPKBjXyELd+Ext7SQgYQ0Lvsaz7KGHLdlsLHJIBkW7zGsEI
         xdDDtQJWyzV9v4pQjgT2Z01P7EP63wZCTc2W5aSnysMBhftDkPQM0RgMERNZAmpOoeAA
         4Uq9wP3W8TNuIUnN1RG9ku2Mj8yVLoqsvqi62AEuILrYbeoZCdQC7Q8W8J6s96265KZO
         yH4IeFFZuSXNpJ798ItbVxDVyrVa3q4YEuSItXCXBwx9KAmowBXir22tevssOaiUOVaq
         OVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781451339; x=1782056139;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pR8769p891UZMpH2W/uEW47L6qds0Zm441UJr101ko0=;
        b=kusUdr4mXDdPswRJclmZOiCqHFz2JrRm5SWUCA9fZ+EAOQRCaeI/SyBOTrfuY3Xqrl
         LwAaoYYoXF6GpYiVB4/Td/wCBQoFp3qE39eE2in9izjSqnabNVBKIy2mTnQkad0UN32X
         c3jvJyzDdq/Z2nNabmTSxM2t7+FvwWQNI+ZT+rRrYRrjNGQCNsSnrFJh90qAxPjlriea
         PI8TvcrER3oVfZH53f+SxUQGZZdGBiBxzs/ZNMLnikhXhvHb1gDcePMoSEubodWZ7Mie
         Vz1l8cTR3NcFCCjkt+FrevCLURE2hyYwE0uz8ex/FR/jaNDtFahGTvCk0gRVqppEcF/D
         UsoA==
X-Forwarded-Encrypted: i=1; AFNElJ/gvEmZFBi4rmACs3wNKWWnczSUY2pVYeZoX+S2axgv3nXlhyonzo6aDKkouYE/sKZnz8phhAfsh6j4hA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmMbi0fz+/kRw3UsfvIBMD4rOqjzkn1xlX3Ad/lFUPr8QqTVZM
	rCNGOmb4756cQW5idjHYPe/sEN4Ta1+4uewJ+Lk1NZ3qnNzRDc6xspjj
X-Gm-Gg: Acq92OFKas2GLpMlpEkKA2oSMAURNVA6gkaIap9C4OwGVz/OuzbucO23ifR++OArg0U
	OBjp7cZykWWhc5zpOrDYF3er6k3q4hwAYmuNsJAPinuyqwyNXEsZkbUGl0L4ocLRz4mryRr3She
	vx5YCfCPTUvllClGiIoTYOwCn405k2x9Yl5mYkdXmjwKRF+RUIfAmHUmjfUjr+qUh39AwrwoKl9
	zrmHzezFr9LxPIjh34B3KJvhFeDcsr4vVm2WO3koqUn9tr+ve2XpUC0IX0Yht9+4b2rjHHWIAab
	sKgmLMTZPvb/F4pWKeE2uk9BkxeTutd7oNOSw10dDkpdy0ogZlsNTWwL+eY5KKLgv/7Ur80za/O
	wpGB3C3soWAaxBm5yqBiRYG0sXdQgbFrdrC7Ad/ecdUoeKsVOQBOiMFRh6NNRhm9/gwD4MDbp1X
	svr3FZ6oI+zfQDzH9pmB7EuX4CD3NOMZk7sX7NJfhb5aXDNm8xuPmlzufxN/NUPiP4VvU98ghXu
	g==
X-Received: by 2002:a05:7301:9f0a:b0:304:dfae:68a with SMTP id 5a478bee46e88-30820213e52mr5158364eec.28.1781451338754;
        Sun, 14 Jun 2026 08:35:38 -0700 (PDT)
Received: from NV-J4GCB44.localdomain ([103.74.125.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm12580632eec.7.2026.06.14.08.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 08:35:38 -0700 (PDT)
From: Jianyue Wu <wujianyue000@gmail.com>
Subject: [PATCH 0/3] mm/zram: route block swap I/O through swap_ops
Date: Sun, 14 Jun 2026 23:35:28 +0800
Message-Id: <20260614-zram-swap-ops-block-register-v1-0-6c1a6639c222@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEDKLmoC/x3MQQ7CIBAAwK80nN0EKJDqV0wPCyyVaEvDNmps+
 nfR41xmF0w1E4tLt4tKz8y5LA3q1Ilww2UiyLFZaKmddMrAp+IM/MIVysrgHyXcodKUeaMKqLw
 OfTRkkxOtWCul/P7317HZIxOEMs95+6WD0cmqSBjRGXMeTJ8GpXxCrcn2DqVCsiiDOI4vt8GwP
 6kAAAA=
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Chris Li <chrisl@kernel.org>, 
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
 Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, 
 Youngjun Park <youngjun.park@lge.com>, Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jianyue Wu <wujianyue000@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1781451334; l=2936;
 i=wujianyue000@gmail.com; s=id_ed25519; h=from:subject:message-id;
 bh=YipMZO8vcbHpc9Uwgtl34KMkub+gxp1VqBvE4Awkxbs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgW51Zh3v9nG0Wlld2Ti8ylp1TnO7yB
 H+z9CbXty/WEAQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLdreTA16fucfMYtRCr0kKLCyUAAQoxuzmykekFWnqFYKkGLmaOZIoZGMb0x7xF17AyieFiOMQI
 NKjzX+rxzaQU=
X-Developer-Key: i=wujianyue000@gmail.com; a=openssh;
 fpr=SHA256:gVWBPJbHGWlCIw+V8F63Ff0k21S7AB5+rZt8+huemvg

This series builds on Christoph Hellwig's swap batching rework that
moves block swap onto struct swap_iocb and per-backend struct
swap_ops handlers [1].  Christoph's patches unify batching for
ordinary block devices and swap files.  zram still needs a custom
path because swap slots map to compressed pages, not disk sectors.

The first patch adds swap_register_block_ops() so a block driver can
install custom submit_read/submit_write handlers when swapon targets
its block device.  The default swap_bdev_ops path is unchanged for
devices that do not register.

The second patch registers zram_swap_ops at module init.  On write,
the swap core still batches folios into a swap_iocb.  zram maps each
folio to a slot index and stores it through zram_write_page() instead
of building one bio per page.  Read handling keeps slot_lock and
mark_slot_accessed() in one critical section.  Writeback-enabled zram
falls back to swap_bdev_submit_read() for ZRAM_WB slots.

The third patch moves slot_free_notify into swap_ops next to the
other zram swap callbacks, and documents the locking contract for
that hook.

Applied on top of Christoph Hellwig's "better block swap batching and
a different take on swap_ops" series [1].

[1] https://lore.kernel.org/linux-mm/?q=better+block+swap+batching

To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Chris Li <chrisl@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Kairui Song <kasong@tencent.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Youngjun Park <youngjun.park@lge.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org
Cc: linux-doc@vger.kernel.org

Signed-off-by: Jianyue Wu <wujianyue000@gmail.com>
---
Jianyue Wu (3):
      mm/page_io: let block drivers register custom swap I/O ops
      mm/zram: handle swap read/write via swap_ops
      mm/swap: route slot free notifications through swap_ops

 Documentation/filesystems/locking.rst |   5 -
 drivers/block/zram/zram_drv.c         | 215 +++++++++++++++++++++++++++-------
 include/linux/blkdev.h                |   2 -
 include/linux/swap.h                  |  47 ++++++++
 mm/page_io.c                          | 187 ++++++++++++++++++++++++++++-
 mm/swap.h                             |  18 +--
 mm/swapfile.c                         |  17 +--
 rust/kernel/block/mq/gen_disk.rs      |   1 -
 8 files changed, 414 insertions(+), 78 deletions(-)
---
base-commit: 842f51deada6449843f811bfa22e536a01ae5a0c
change-id: 20260614-zram-swap-ops-block-register-a1b2c3d4e5f6

Best regards,
-- 
Jianyue Wu <wujianyue000@gmail.com>

