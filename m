Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F64A315790
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357512; cv=none; b=NflmMFFyW2XlQheyJ2T9Va/K3wJ6EZevglkzV9IwigtLEo8sZtOiAZdsOoFIVFjOGPESQbYuP2h5MPbWlpI6NULUmr4JwoRcdHdEJii1UCKl5MQv3LAUVET7Vy4G1c8fyFHVRt+s8RA6ABA/oiSq/tU7TljxWPTWm4BpFyPQKfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357512; c=relaxed/simple;
	bh=vBpIbHl5BJYu3GvhFAscHMjHAct8CImIgNJ4c1z/oeA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ICcnWs9Tcn5P5OGq5RxN0K9532cx1t+5h3HoBSulVHr7Mcg+3+KghHf2B7PAWxAleJ/9ax9pzMJNQ0SxF/qjjp5GpLfvPtDE/rAFrOjyU1ED5A2UZ4/ls83D95v+03T/3qSv5a7eowwCPWXsT1tjMr2EcCD7uSc8e3LbIshdQiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oXBG7qxR; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oXBG7qxR"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-4332ae0635fso30726285ab.2
        for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 07:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762357507; x=1762962307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmEA5UIRtFUkoJTebXPiJtfqEeDxZBhUOtjCk6lwm1Q=;
        b=oXBG7qxRAgxxpjvyoxPULOa1fgROdBp/4Z8g918iu8f5OrPjl3F4GHIx5MFNTDhIAn
         pqEWO68Dj3gmQhJr7qUItHwJwG64ld8NCI3MV7bCUWXu1dZb9kfWdGjqhLEvZ479OLxd
         7WiqKEvubQDho+R74G9Dyx22NjREEAjXzpV9A8ulR2vqMXlAUzbRrF27vJeKUN9IErWH
         nS5fM8dz6irJDPhN+oXQW2NNuh/Xd+GhLhTh5UE92ErPNvWvCwMnK0USG76HfdDLNIZh
         XCRNyUDNOSW9hHsEDGFGMI7ZCsw/O3VLkbMk72QQA/atz5Zr6aL5e+7DVF1PHSDpOj60
         NUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762357507; x=1762962307;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmEA5UIRtFUkoJTebXPiJtfqEeDxZBhUOtjCk6lwm1Q=;
        b=cuDeM1IXLc20aZrrVCj9egoSPf8okSUfDvzfjvdURQ1Kh0T+YAAW2/kfTieySNTjs1
         krC8y48aIOd8HE5li97oQQVnnkPppXvQ7FPFmipqm2WWkMlCR8btichlKPJWJZ+hNKb7
         fRmcJ4F2f2KzY5VmnN6JLLx3gQpsyJf6lVL9n9qvdXthLeUlXDmgmPVrm9/XqzBmnVjQ
         eHvVdX57oBbBK++0Z1rZTC2JfXSJK8mN8vfi4upi9cfAvDKW42ZHXjjZvbKqtA/RwTPj
         8wOnRC2zq0LN4kuUQx2oqMC+d5U0vTz9Quno9zAcmuSRS8N2eD+PdzxkcgVFVcL6erMu
         WZkw==
X-Gm-Message-State: AOJu0Yxbyn37VRJcMIvoLOekPxguBZZBEwj9yg/9cApSOI5WkJZR+iEr
	2ajYXXNYbwwgJ+yHEqRnWEQGZh6NRoDe5MPwO8IfO7MQZPo7lDe2bAdBtuMAFqZDvIRO6DH2g5D
	hztmr
X-Gm-Gg: ASbGncuk/5GcthwWQsa9bBk1f1M1mZYCkHrQOLKmTmOxuPI0zrvwa3pIZ2AEAbfYqdi
	v9HLs1A5KYXyLo2Jqc5G83HvM+GBFutkAY8/ZAFeMbmRLPb/bv3Ui/EwlFf9urhnDvKlomAS7Ze
	uNUXcDItRtQA5Z/qQT6OU4jpPBQPrxo/7rUqlD/yjotZ4b3AtoYCtx0Xg5tX3d/qCKjvbc7hBIb
	aZCjScqj5ZR0OcFrFm2mEgIkKcnPZY4HATn0FxzTz4MSVJ2Mfxr2+jrz6KrjX+eLR+BFxkExNoF
	xVoFsIDVEw0kqF4aSoVZbVI/JGczRYgbUMX9xvKXM5sGmNS/Bac7AEPaqsOku39adwEWJdC57Rv
	FDEo6aSDiHMHd/cLL3hS3uxskEI/XpPtNj6PWs+kAnpVFMKGh0AEh8/f9JWGlncniAziYMHannS
	TNew==
X-Google-Smtp-Source: AGHT+IGRprlY0B/j7MFC0euD5DLU4VAIhfixS9xB+G6Pb3CIfQJOwUgjuW1G2xa98UfKd2ncVWvKMA==
X-Received: by 2002:a05:6e02:1a85:b0:433:2957:2e87 with SMTP id e9e14a558f8ab-433407d98e4mr47454155ab.28.1762357507117;
        Wed, 05 Nov 2025 07:45:07 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b72258d4e8sm2521439173.3.2025.11.05.07.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:45:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>, 
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 "Martin K . Petersen" <martin.petersen@oracle.com>, 
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org, 
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org, 
 David Sterba <dsterba@suse.com>, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20251104212249.1075412-1-dlemoal@kernel.org>
References: <20251104212249.1075412-1-dlemoal@kernel.org>
Subject: Re: [PATCH v4 00/15] Introduce cached report zones
Message-Id: <176235750606.190479.10317258805246349798.b4-ty@kernel.dk>
Date: Wed, 05 Nov 2025 08:45:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 05 Nov 2025 06:22:34 +0900, Damien Le Moal wrote:
> This patch series implements a cached report zones using information
> from the block layer zone write plugs and a new zone condition tracking.
> This avoids having to execute slow report zones commands on the device
> when for instance mounting file systems, which can significantly speed
> things up, especially in setups with multiple SMR HDDs (e.g. a BTRFS
> RAID volume).
> 
> [...]

Applied, thanks!

[01/15] block: handle zone management operations completions
        commit: efae226c2ef19528ffd81d29ba0eecf1b0896ca2
[02/15] block: freeze queue when updating zone resources
        commit: bba4322e3f303b2d656e748be758320b567f046f
[03/15] block: cleanup blkdev_report_zones()
        commit: e8ecb21f081fe0cab33dc20cbe65ccbbfe615c15
[04/15] block: introduce disk_report_zone()
        commit: fdb9aed869f34d776298b3a8197909eb820e4d0d
[05/15] block: reorganize struct blk_zone_wplug
        commit: ca1a897fb266c4b23b5ecb99fe787ed18559057d
[06/15] block: use zone condition to determine conventional zones
        commit: 6e945ffb6555705cf20b1fcdc21a139911562995
[07/15] block: track zone conditions
        commit: 0bf0e2e4666822b62d7ad6473dc37fd6b377b5f1
[08/15] block: refactor blkdev_report_zones() code
        commit: 1af3f4e0c42b377f3405df498440566e3468c314
[09/15] block: introduce blkdev_get_zone_info()
        commit: f2284eec5053df271c78e687672247922bcee881
[10/15] block: introduce blkdev_report_zones_cached()
        commit: 31f0656a4ab712edf2888eabcc0664197a4a938e
[11/15] block: introduce BLKREPORTZONESV2 ioctl
        commit: b30ffcdc0c15a88f8866529d3532454e02571221
[12/15] block: improve zone_wplugs debugfs attribute output
        commit: 2b39d4a6c67d11ead8f39ec6376645d8e9d34554
[13/15] block: add zone write plug condition to debugfs zone_wplugs
        commit: 1efbbc641ef7d673059cded789b9c8a743c17c9a
[14/15] btrfs: use blkdev_report_zones_cached()
        commit: ad3c1188b401cbc0533515ba2d45396b4fa320e1
[15/15] xfs: use blkdev_report_zones_cached()
        commit: e04ccfc28252f181ea8d469d834b48e7dece65b2

Best regards,
-- 
Jens Axboe



