Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F3135CBAF
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122801; cv=none; b=ZrCf1hLVNwtyWsT2/nJlPiVl5iLZNP06zsF1ryruWPnHwnK77HF3M87nVcvS1Nat3D8itH2EJpG+pU29+LYvLeRGCF6R9sVHebH/HxyleDrdnvl5gLmxdhh2FjQIvtRuAz1hBQwlJmpnD/DEX0DrpYkZ5mGRTZ3hhhJIicl8a0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122801; c=relaxed/simple;
	bh=ZY4j4qcCxJcSxH819MVZH5zxtVuqMjM+bT7fAd9UgWU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=otEQDwY2hMnjOZO3qf1xxPkAOdDZf+q1Xpj+BJJ2DzlvpC8Lm7HWpKzHVVADg0j43BcSf6LApCo0AhWieMt7zBJA5w4UYPPhOfiEKAUKnl8oHaK5+Vzgk64fyvhYF9zIG+J1pEvfvV0eNvgRDdRkCs023EvpdbJ9Spq5ZoZLG+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zwqdg12p; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zwqdg12p"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-4330ef18daeso7782535ab.3
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 04:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763122798; x=1763727598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvGPnwIJ9UQ+3xbjjhhyEYoRm3l1sjhSWrnsi1M6ybA=;
        b=zwqdg12puqHPiZB6JD8zRR7uhdPy+tTrDEBbLt5BxdZt700MWXConrI649WC1u0vtq
         f6i4z5vHT2ke20KxRhzz1PfbOgH/VUWbjQhkcW8N09hP2eY80+26zrlXWqxfByKqgx4m
         /GY8IhvtqUwfjH6yXTtgyRJuRLQCmcWZsOI5K/U2j7+WfytT/npeUBuS+O5rUN1FQKCO
         lx4uyh6QY5ZGUJ4NEpNTiGdkbqhlSedQ89ZNoFQ+Hih+1IXXDDTdjGL2PAWEbmxY1m/v
         Jiwx3woPxOe7cloPYp0BjU0TmhsfludMKT0ik941/J2JD29ALDvkzxB5hb0BGrq8RUi2
         IGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763122798; x=1763727598;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uvGPnwIJ9UQ+3xbjjhhyEYoRm3l1sjhSWrnsi1M6ybA=;
        b=U1dPcU0cQYBKkOJZ9/ZgqC6Zsnm/hfXhYCs67YCjmUXb1OXQAfUPNwcCCX+HHugOiq
         E8+R0IVDr9KJr8Okj+mlPGYYyu8QV8sjD7KjbTDhteHG/DqluIejr5bzWWb1z4N6qYoJ
         lXrPVBpKy44Wtfu/zpLL25utdNq142OJJXZLyroEAhxoAS2pNZ5TEhIB2zyYYlcEsRrR
         XE0YF2Swchtho6ypQTnLpndaGIx2BSVqcfAf57SOpnbB51aLInQl7RZZcDg/SX9sb2BL
         aDu4zLGSE/dhBV/tnksCp1Fga9TYg/AAAs+cU2i2qzh0/KM7gFWBv0hXkJeWtCYo0SJQ
         KzPw==
X-Gm-Message-State: AOJu0Yxbr2N8Di9VNYP0hMMKjMPq9v5ey401dFBzGR5lntYFcRwzy4qe
	tUWD4QWvu5mLANw/NmQnBM1jpX7IAvxgTNEn4059Pj0dm3EzsTgUilkW/WT1zn95dWA=
X-Gm-Gg: ASbGncvjxSjGnCFlIAJNOb3+K1KG8PjwFy9kxu6fqSDzS1oeW8L3E10iWO4Ipnamlvx
	WaNQ5+6AXNvTumjzuGdOKv0F7VrCutNIF97G8dGxoUbPTMssxffHAtmBoS9RRF5WFAZeWzO5nRP
	uH7L6PcKoA6BxS/lE6tX4rhBFp83ONqSfT6HQSZRpDczF48cboItMFK3Pbxd81s/9na6QIKJoG5
	tLM00utqMFLK9oZTCLQQBsUJ5FOeuJsv4mG2R/zqwfBhTozhwX+h3eH5eM2bK6NOgRDg+fvUG+l
	LdL6qSl/dsEmnp8bySuPUUaRulJ7ukSzGqRNWNefQgjsvTOxOJuoIBZ5VIP9vVp4ShXX2Y+rmIx
	Q/eGPrs4BVg0uXo3GhECnSALx9vHOdCS+42aZogWFsYKRaXfWAvLuVeMsZ95TTEgXENhKoKV4S4
	DW1o2pY1JvPdTHiA==
X-Google-Smtp-Source: AGHT+IHwtGthrFFBC8JB1kEGmmsPtQ31Pwz0+G7f5ToInBYvE+tM3YbahqKyzO64P4TCNs1gtbOyDA==
X-Received: by 2002:a05:6e02:3113:b0:42e:7273:a370 with SMTP id e9e14a558f8ab-4348c87af71mr40523795ab.5.1763122797878;
        Fri, 14 Nov 2025 04:19:57 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4348398ff45sm23452835ab.17.2025.11.14.04.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 04:19:57 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
In-Reply-To: <20251114-block-with-mmio-v5-0-69d00f73d766@nvidia.com>
References: <20251114-block-with-mmio-v5-0-69d00f73d766@nvidia.com>
Subject: Re: [PATCH v5 0/2] block: Enable proper MMIO memory handling for
 P2P DMA
Message-Id: <176312279654.329326.7978292363976805159.b4-ty@kernel.dk>
Date: Fri, 14 Nov 2025 05:19:56 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 14 Nov 2025 11:07:02 +0200, Leon Romanovsky wrote:
> Changelog:
> v5:
>  * Rebased on top of 8e1bf774ab18 ("Merge branch 'elevator-switch-6.19' into for-6.19/block")
>  * Initialized p2p map to PCI_P2PDMA_MAP_NONE.
> v4: https://patch.msgid.link/20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com
>  * Changed double "if" to be "else if".
>  * Added missed PCI_P2PDMA_MAP_NONE case.
> v3: https://patch.msgid.link/20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com
>  * Encoded p2p map type in IOD flags instead of DMA attributes.
>  * Removed REQ_P2PDMA flag from block layer.
>  * Simplified map_phys conversion patch.
> v2: https://lore.kernel.org/all/20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com/
>  * Added Chirstoph's Reviewed-by tag for first patch.
>  * Squashed patches
>  * Stored DMA MMIO attribute in NVMe IOD flags variable instead of block layer.
> v1: https://patch.msgid.link/20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com
>  * Reordered patches.
>  * Dropped patch which tried to unify unmap flow.
>  * Set MMIO flag separately for data and integrity payloads.
> v0: https://lore.kernel.org/all/cover.1760369219.git.leon@kernel.org/
> 
> [...]

Applied, thanks!

[1/2] nvme-pci: migrate to dma_map_phys instead of map_page
      (no commit info)
[2/2] block-dma: properly take MMIO path
      (no commit info)

Best regards,
-- 
Jens Axboe



