Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9E03C5DCD
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813447; cv=none; b=L/6GdfmnSQbZHtskzSYqci+Cysq0/iGiXzcgoDC0D2xPx3b6Ems7SuL1iS2/mGyi8R2TEdygbubmhFELTTj/ySuXxsl411dzXFbDDn5tTtdqfaH2ivJy/UiIeFMByFUkTv7+ZgkrWOMjvA31hKao192OqmGIqECnRGphCxV46ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813447; c=relaxed/simple;
	bh=2EeXpqQDt+Fd1xdkcAs9Zp3fbvTTh/2xP1kDKJJar2o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IuPIZ6zIjMLPBdeFhy4CZVNyvL6eRWQOxTUK1SSsQZ2OLOp6rv9FWrDqqruURTw/HdcpYQqt1R98aeUjCxDJpsL5R+dh0pEilG5hKmV2zYKXX/bZyM9ZPB/NcakH/Nm8p7S4UpCjG1rY4U00M0DyAMjc3YiHx9xZHv376tlBtSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=bhb6clff; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="bhb6clff"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-43b8a96ff5eso2272032fac.2
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779813445; x=1780418245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbEyVDKYB6brZVOZVveRW94ChbWHXbhuaSGALUdMmOo=;
        b=bhb6clffjPZ33hypi328fsDoxxGGzo/mTIj2rr1QZbav0ouH+QMlwrL2Mq/VWQUYoX
         JHqQWpDqmXNH5CFER7V7c5GbSVXJhhcQaFCf02ADG0aVAdh7u4NbJ03kUpZn3d/n8hPs
         ES4K3VRZpEYKe+5itpRZWP4pWnyBFudG6LvAgir0R+chrb5SXpXEZ3WZr5nVjR6esOTC
         NSIU0Jh4j+WApsL16FMACve0ZFznPxwcwpLi6gt6zCYgIm4Td4JYgTJVIT8yCt9jvagw
         yX/a66GLQzJDG+fcqAuDMlIx7v1CLaMe2oEuYOsgvG9jxRjF4XR2Z7kG/2kOW5SDeDe+
         hErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813445; x=1780418245;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CbEyVDKYB6brZVOZVveRW94ChbWHXbhuaSGALUdMmOo=;
        b=TnPjKeRwO2PUOYfBxl2fh3RJl9HFv9qQME5JXdzT47wfndL7QaKWROHRCQHsbFykS2
         DUWBbo5erJo8laAF+U0nxpTjf5p9obkot2alcE5odc9vGaELKgR7VZxwSlkmrOMJuSGg
         10PcbbXju62cOXJXag0SjS5kgniv1IorKYMnSrT6QsBiG7Mg+17iQoP/Wuw4uH3NCMPX
         xWyAow+lOFb+UrWiTtHK7TQS8RtTEcmdMCjnGwnMHAZs1rPzM7KoTF8pzJIj38rdZZCf
         OAQaHoOx2A0DLr1y0Ia8EZPauwpkde+e0aA1e5VZR7J9OgU4CqMxn+qVz8JMIaPHbNU0
         Lh+g==
X-Forwarded-Encrypted: i=1; AFNElJ+9fSY4CFil2BUA2/9sDDTxLbEx1td4gVDfx3GnpbLprd+AsykCDoscIJIxbs6KoDkl8qgxzRhK5mwZWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWvnW2fDkbXRXuevydZRXfh5tnvd10Ol8Z4FZafqxEmN/sCsjz
	3bNxBYLeZ6vbJMB0hNMSXO9Itz5rehrjAwHUK5wwqJSjTdCC/LbX/CVYnT4QkttFgkY=
X-Gm-Gg: Acq92OFSLbQT6E0GqpX1eiuGd9zN4TzJpBJ0TfIV/ptCWTVhkEXwvabG5adZZgn0bBn
	jsJ9jH5SV1hkf1lfuZku3EIVYTacXQlYevdy5d/rS17yBP/eHosJK6Il0w10KW3Ue+Nd0nPCcND
	EuwPUkEPXZ49So5K1Lz939WXQwYTghnyIdkSGzkUZNrrMXC4D7nf99X7Jw5zMzHNJ7RGGgVohFF
	f4Q+BY10bu9+wWYBnBitJn0EgQKaD/h2QlveEV8qAY/j0pcyRZ8Ahy1NLiXMwRTZO50DMJm5cPL
	tTRBJIfKh2cQMXllFTk29WPzal7zj0sVd5S2uE/QHuRo7AbFyHbzSejmB6nHP0RDT34LOwT8JM8
	roj15AssNLMoEImE4Bb6+kLdMIIqODQLWK3p0o5K7W8Resx4qs1Jkio9eBFOjthlPxJn5MIx/dX
	DxoKUiAHwH/YwXQ7kRgtRsxWQRfvCfxlR+QwD/prknFBPo96x787t3SVYWrs/tf+bvzMxzSwL76
	hgv24yA01eUrWT5o+L7QyOq
X-Received: by 2002:a05:6871:289a:b0:43a:5cd0:db00 with SMTP id 586e51a60fabf-43b5adb7a25mr12258063fac.23.1779813444777;
        Tue, 26 May 2026 09:37:24 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b639fd7adsm13561265fac.14.2026.05.26.09.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:37:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Sung-woo Kim <iam@sung-woo.kim>, Josef Bacik <josef@toxicpanda.com>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, Ulf Hansson <ulfh@kernel.org>, 
 Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Justin Tee <justin.tee@broadcom.com>, 
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Thomas Fourier <fourier.thomas@gmail.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Luke Wang <ziniu.wang_1@nxp.com>, 
 Kees Cook <kees@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nbd@other.debian.org, 
 dm-devel@lists.linux.dev, linux-mmc@vger.kernel.org, 
 linux-mtd@lists.infradead.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org, 
 linux-scsi@vger.kernel.org
In-Reply-To: <20260523125210.272274-1-mateusz.nowicki@posteo.net>
References: <20260523125210.272274-1-mateusz.nowicki@posteo.net>
Subject: Re: [PATCH v1] block: switch numa_node to int in blk_mq_hw_ctx and
 init_request
Message-Id: <177981344077.464267.4670805396521914701.b4-ty@b4>
Date: Tue, 26 May 2026 10:37:20 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 23 May 2026 12:52:35 +0000, Mateusz Nowicki wrote:
> numa_node in blk_mq_hw_ctx and the matching argument of
> blk_mq_ops::init_request can be NUMA_NO_NODE (-1).  Declared as
> unsigned int, NUMA_NO_NODE becomes UINT_MAX and walks off
> nvme_dev::descriptor_pools[] on CONFIG_NUMA=n [1].
> 
> Switch the field and the callback prototype to int and update all
> in-tree init_request implementations.  No functional change:
> cpu_to_node(), kmalloc_node() and blk_alloc_flush_queue() already
> take int.
> 
> [...]

Applied, thanks!

[1/1] block: switch numa_node to int in blk_mq_hw_ctx and init_request
      commit: 65e1c8f96ad1a1f3b72e8a91d1341d570f91d985

Best regards,
-- 
Jens Axboe



