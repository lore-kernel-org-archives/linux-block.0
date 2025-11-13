Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1223624C8
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051984; cv=none; b=e2qZWYzB5JzM4JHTLgkOGChJoDFrj/Qx/LkVBY7FRh1n5FjA316uZoy5WVztkJFGGyHs0SZeRH5DUV6lRsCYIJN84Qk31CMaCkAlWn+4eCjW+x74I73lx/VLykba6Lm5hR+Tzkr6ESEv7qVrcqGefWSLti68Y9ndtlxnee3qSRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051984; c=relaxed/simple;
	bh=k72pYZwFQ2V3zxmVhhX4AUxj4txODChO9HtKLZFMgtw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FvWR4paPfGqqKlP4nn2eaYF4eFyJL9emm+pNy+qqz2O+chc6/7QUqAcMbaUOEYCWz40JVcKygmoFxLL7Vj4UYdJmaDUbvtp5N8i4/LYa0JzthH0BvIs0YzJzhPSyKqFdQx9VR5OMdh76dhHk8ylBAgPfEjliGLACAV/lVZlBuzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SRXNNkn2; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SRXNNkn2"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4505ade79c2so457746b6e.1
        for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 08:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763051981; x=1763656781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acnorco3r1OWVqxwisFCZtNNuSVKZYX9Y3wyP7m23lo=;
        b=SRXNNkn2B5TjjwiVNkf5ekb6H2aCVQQnTA/BzyfmSMsOvFthwkDx0XB11Wzchdg88p
         xu10GxlGrvMwLe4squ7aumhWsSE62bGUkvVGlEb3W6bWKH//3DZd1s6fPswKqy3rkynD
         Ho03AgV94CTpMVcXpyY+MTncNh0c6eK5DZEY9Er+Jr/6PwsRC3PmhwSGpCVTHhRmiuO+
         5tFWGqNMStG+dwx+ONiMXYlrOyTzJurIWgtCsmmORQQDsnh5iVsmTd61kf13lj4rTrZi
         yvN8CEHdP015IpHmrMmG/ZeBPcipbBsg3ZBU8wljo3y9Q49s6JSc6GngUocc37sPfwzM
         kAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051981; x=1763656781;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=acnorco3r1OWVqxwisFCZtNNuSVKZYX9Y3wyP7m23lo=;
        b=vh/ZCRI2j1R65FliF9SKNiHizr9ven/4o8ueYyC/eey4J/uJ90tLcms9XpM0W2bCHV
         lJoKihRdG87CskjVgCJ0pohNUZYE79taJkoVoH0AwdvqZvS+/1D3Ign7gx9yNvFchlG3
         H8RJlny4KdH6tAiBoki1CG1aSl87KYbpHl0evDSi5MNdyTP5bgntdESCLY4SfEtAlDsC
         Zme3d+dgyYX5xrltVZcHdrbhMksEfpvJcYLnv6ESyqPlimDTczIMvzJ2F1XTAso7l0w9
         ErnV37JLy9RENxvxWSy2P6ZiqVLLc8q65jFdPApBrX4ewr2MZyUfam/XiYvbuBEHtJrZ
         3zPQ==
X-Gm-Message-State: AOJu0YxUppDX5SxEBtCs0gGNb4hI1pYzLKr1O3U0onedgCYJ8/+tC73T
	C3j7f8r2SU9OjBuAM+f+ClCHHt/5MVDU9oWgm0Bd66YwnlLUNFvFg77dEE6dhYQ5Xbo=
X-Gm-Gg: ASbGncvH7nHr6pN/rhrgWTt6xN/k40Mt3t7fcv2xF/Qwkh43oNdYrZuSTL+YpFaAfeq
	yWZb9qELT+N6cnh3CZVFavdVefIdP//SmSZkNwfeX/42JWn13dwQ/TQXzh5gnlfsN8BxOmwQASY
	uzy45V4LZuD8/DvLOvLlqz1HrcxlU02ue4SKfzeWrRIoQWVRl/7dq/qiAV49C7pc9mpwGNwLPRE
	G+GlI6Rf1x2Iqx8f18385uzrERtItnXwQhjCYnTLlsG0jcUJD88l7pU67uiuC8OuWsvUEcJraQF
	Jv3xOc0DHfHt47J/LXhLMneoPI/uJ8H72bGVSb+kjsWS7p9ksJ8vZiogwKu0aoFot6O6INSQBrK
	S5mVGEl6CzrMoWsw0q2Z7pcYtYo48yrxF1S3daFjiCn/p2K6NM+JLgBcRskreod4/9eI=
X-Google-Smtp-Source: AGHT+IEN9Kca9UVNMkaDQH4sixh1UDXbVuoaQZrNLuxjjpOlBG92d5Tw7nSUHhmYRwVQ4lVJgFmtdw==
X-Received: by 2002:a05:6808:d52:b0:44f:e931:38ab with SMTP id 5614622812f47-4507454af73mr2995413b6e.43.1763051981315;
        Thu, 13 Nov 2025 08:39:41 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd35c5f4sm852672173.61.2025.11.13.08.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:39:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org
In-Reply-To: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for
 P2P DMA
Message-Id: <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
Date: Thu, 13 Nov 2025 09:39:39 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 12 Nov 2025 21:48:03 +0200, Leon Romanovsky wrote:
> Changelog:
> v4:
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
      commit: f10000db2f7cf29d8c2ade69266bed7b51c772cb
[2/2] block-dma: properly take MMIO path
      commit: 8df2745e8b23fdbe34c5b0a24607f5aaf10ed7eb

Best regards,
-- 
Jens Axboe



