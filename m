Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D8C2DF714
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763397757; cv=none; b=JMmAXmFhcOL1fYrBuCWIYYxxbVMOZz6s/LQPnDZ0YiffQ1PKsyABXkxkDeVUVg5Vod63l5LsVQ7xHlxro7JJV0HQ+T1qhcmrkSM1mBOQ/+twqMxXapCFzl/Rx5pY839o0/gXMxa2PU110g5kldpOJqW25K4uryAUiCaElA/PwMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763397757; c=relaxed/simple;
	bh=N557UI/PpmRz2VImJUy9zanLU3/nIBnFH+IwXpBLq24=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u02uO1hHHbTH6eKGSuSkMc6EtDP9mw9hnK0B/SGLOIXiLSbqqLRrpMyNcCKmoJSQnEFUlQVbe/B4YPPzz8lJbq7IGRgLiXqpDKOywSrTBSgFmmuXF1RWJDZ9UA2gTGwIrZuCvPp2GR5h/vbS/LgjICthRT6cypmRpEznmc8IIv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dOoJikVp; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dOoJikVp"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-4336f492d75so23321185ab.1
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 08:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763397754; x=1764002554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5Wp953EEHU7o1P9grFgRm3cDfisCBXs9FZ8SRXhEq0=;
        b=dOoJikVpqD4YIaVouvsFRfxFOkmfq2bWZ/xL9V1rNKOs5PuOqSRrTp/Pflz2dOd7LE
         heZnHCzGgX1/2VKcDp3h1eGmYTOTPfq81MfCzbnxBNIxnko/eA+hxLIOajfo7xNOedWt
         fiaQxiEzuC3EvIVIMrR7grBm65FJ1+XXFL7F6m4cFaOllReYMEwpYZhgz+vyFGhWN0JF
         1ZuCJPL6O5rjTBJuPhXkvP+V1wLKO1XetcsJG8zm1/TwerTAN1xdZObFwMgbTF9hnbwl
         3p4FzeS8by41bth4mSvMF86nCPTUXgJz92Hprb/KkapXs78k03ysA6TPO76sK4o6Q2Xj
         3d/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763397754; x=1764002554;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x5Wp953EEHU7o1P9grFgRm3cDfisCBXs9FZ8SRXhEq0=;
        b=IKof6HU0jlLCrbR+l1W5d9ND9muwaAasPpaBe63QdrW4DxS7Ld63Q3ywmAev6T+hd7
         Hp3NvxSTGXj39H1Y6+nP43kXj6P/oxMsVPPzSSnnHiw7UQcFxQdLecL7UQpedZsSlk7z
         dAr2wsy7BhMX0BURbNXNSySkO66Odcodmeu9BdL+FxzXhD1+nuX1bWAJkAiI6uIx4/2r
         LFnu9+SAL84GaDtf8fgDY5MYP0OgS4dBCt2TPR0hw93jzPaCYGfWGUmmIBjmjxbkKxrF
         jFXtz6+Uiqnb8ysY3LLNclISI2QpHpdyUzAP342JpvFrwZ10sTfa3+oYLbNxnCdbl+Xh
         byWg==
X-Gm-Message-State: AOJu0YzMUx7bWoHkt+Jsjuu0ck9ajaH2j0aYAH1ciEJ2AZ4pN3BmtbEj
	kSaVR+NRkXg3Q2UTe0ECe6XEGqckwpZVSHvNTXfLT7KV/8sd4IAykTFz6rM0uEBWOI0=
X-Gm-Gg: ASbGncuxqlZTIHfhOcj6qmtN07dVbtcRMGryRjwk7CU0+CCZcVMrWVIoXA8rst7ixCH
	ZUbmtLSwOBU4P5BJQR4VbO+xYEutn6vFXmh0P8LDhpnbR4kxGWhV4NYSn0USC5FOPIOyl06ARQK
	+nC6yXyU11zgHk9trQ0yE/FJDK0fz598b8TxlC0Y0ffAc7xY1tE5M+Xw1KJUkjkRLaAPo4ORaKY
	XBvHM6xxVlY7O9gLp3LBhAYkdfg2K096lWZPNOxmd/0jmxMhrnaIePZIEEPg1nrQpyI3wM/VY7F
	4HfZetBAXbquJttHfVTtiWgOTPtvdwZUmJjk6Mu2BoESlzV2bHELHVGKLmgmRqf1gSe3L9n18aI
	ccrwjR+yqVUt1jXb3mn2v0Z449ZbvcrmFczHXdd84gqOm8H1VDt/0Xy1aPMgQD4YI5Dg=
X-Google-Smtp-Source: AGHT+IHu9aboOqf5hOvEFQ87DG1B4ADMs0vMRE1oOnbZnpMmMZ3i5Td8ti6aRpG9/oPaddtIEODHpw==
X-Received: by 2002:a05:6e02:1d91:b0:434:96ea:ff51 with SMTP id e9e14a558f8ab-43496eb0168mr143282845ab.34.1763397754484;
        Mon, 17 Nov 2025 08:42:34 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd26e131sm4924100173.20.2025.11.17.08.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 08:42:33 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20251115121556.196104-1-dlemoal@kernel.org>
References: <20251115121556.196104-1-dlemoal@kernel.org>
Subject: Re: [PATCH 0/6] zloop fixes and improvements
Message-Id: <176339775341.116629.7410659905760396568.b4-ty@kernel.dk>
Date: Mon, 17 Nov 2025 09:42:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 15 Nov 2025 21:15:50 +0900, Damien Le Moal wrote:
> Jens,
> 
> The first 2 patches are simple fixes for the zloop driver. The third
> patch is a simple refactoring. Finally, patch 4 and 5 introduce new
> configuration parameters that are very useful for testing the block
> layer zone append emulation done as part of zone write plugging (patch
> 4) and to test file systems that use zone append (XFS and btrfs) by
> changing the processing behavior of zone append operations in zloop.
> 
> [...]

Applied, thanks!

[1/6] zloop: make the write pointer of full zones invalid
      commit: 866d65745b635927c3d1343ab67e6fd4a99d116d
[2/6] zloop: fail zone append operations that are targeting full zones
      commit: cf28f6f923cb1dd2765b5c3d7697bb4dcf2096a0
[3/6] zloop: simplify checks for writes to sequential zones
      commit: e3a96ca90462f80d9f58a1236514823334deef39
[4/6] zloop: introduce the zone_append configuration parameter
      commit: 9236c5fdd5a8bec2445e834e7e1bbefb2eb62f67
[5/6] zloop: introduce the ordered_zone_append configuration parameter
      commit: fcc6eaa3a03a0e94f6f1d0ac455209b520ef8024
[6/6] Documentation: admin-guide: blockdev: update zloop parameters
      commit: ade260ca858627b21be87711b1e12a7bf80c0261

Best regards,
-- 
Jens Axboe



