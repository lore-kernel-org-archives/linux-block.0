Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB1B1DE8B7
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174370; cv=none; b=pETKtLpTrDrRaDksk++c3W9HeXBT1q48FsKJsITw0z6eN+xlS5bdOjl2bngCMK2WaaGexjkkLEmBc9Ey6/D10dkJZYQmeWwWU9iKoFgNpHYEGPQbRCgGl5weMn54qLVACR0ZuBOtCXFMISiayqR8zvLKTSauhO7pJGw4kEnKaMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174370; c=relaxed/simple;
	bh=G1+zjPX7885GPQiGlzqYtPsxK5iAZA6xw5MJQTGzWrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eYiYHdRyyvuDYws2VXndGI1Jg850dtdyLWN5yKR3cyOJQWrs9SsJqZxJ+8isWwXgR0HlWqkJlbdje5LwuyDyPIEmTr1z3Wz2MrlFSpqDmLPXFHKmIIdi3lC4TIEtVeH6JG4Yig7Uvexa5nQooKuKhn3s2ZIXsX6w1TGID92F9HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2NSzFinK; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2NSzFinK"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-844e161a957so1137836039f.0
        for <linux-block@vger.kernel.org>; Mon, 06 Jan 2025 06:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736174368; x=1736779168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcrK4Dpqa9ZDQwida0k7qlvFbiQBsLXdNY1smYyaUXc=;
        b=2NSzFinKiXhfnD/R3gmUHnayKDLfYbw6D3DqCZz24qcQHNU+MqbT7S78Ik1eH3vmBH
         5s9nqL7cEXgaZ6qoWtEsd8UHmtfBxjO2ZejBj68WapFOqLdwueW83j5Kabz/fCwF3mPF
         wnxhgQVoo2lMednLBxZaMgXJCCWYBIqt/ZcCZH6yb8KViawBsbGKmkrLzc6NhzD7KFfI
         aSXJY2BPJqA1xpm1kIAdIQwTuVHYQg5V0MBSv+znizhzRCyaTYETKl4we9cSyWJzVTwD
         1k9UwNr1yDMWvzH3FmJyrqbBLeltCdSe7kj0IIP7EzUHiyJF6W9+ZISB6cHoGIEwy+Do
         +NWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736174368; x=1736779168;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcrK4Dpqa9ZDQwida0k7qlvFbiQBsLXdNY1smYyaUXc=;
        b=VECCzLP9OXcm8xOKV0p0IdbmAulIvDV4t7d1PNXOxu6EFT5AphlmL+SvEI+9ZgjnOP
         ekpVz++PtP0xdqFGiICLf5TgxSPPlaBnjutQcNB1oZCnXqXdYKujk8+3ZNJDsdEox2PP
         UnH8ys13Sv7BpjF+0qMDUcAcxgVWDfREZ79EZ6YSUJJt3EhN9WOoVg2KVB2KIqzRIAWE
         rMJiVlFsUBYUY8RZ7uqcNYeuQa7VPanVG79Qn+B9wYzo2zeOuXQUqbCMxbjBzIb6FBOW
         BN+QCYzj9CaJ4W/Xz4ziF9L7aGGeNMslBfSuFvFK+vMSXbuknENOZGbDJ/wIn3LfnEVA
         iScg==
X-Forwarded-Encrypted: i=1; AJvYcCUz33K+9yUAdDUwXkQDemPMB92wvv0zPe0830O4g7XORv8yKVyiJggTuCbrDa1m5Q/TxNRRlQCwCCBl4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy7RMAcBONSH7hy2DHRXLD7HN2VrCDlrzQHNbiF1MtGK7C6GnL
	dLt3kwA1w8eh1OiWs9vNRLaGhjykDWnPchKg21ZaSx60vrhL9LX3Wf9IhydNvYU7D4eaScIHWbu
	k
X-Gm-Gg: ASbGnctnzLu8C64Lrn9q0v6OXCEjWOlpaJWsMAyjSFfu1vwvT99qbT2/TYzBgFCNRUf
	yZK3xzq6cixOz/LVCToVM5SUb+WNYEdsFyJYHkXwPFiwNguwjvIax9MWVNSA09dwvp8zBs0gb6m
	BEm2LzkYR1NSJYkIUjBkYySlkzkQYVIeG/PXyUUh0ae3Q/2xsEcd8ZaVQc1nrpMrukwvMdkNtjg
	h9ta+ancOdfOcEApv+GSRLQZQqGRHCXF3xRQ7vLh4OYJtA=
X-Google-Smtp-Source: AGHT+IGdXOy9SD6etPUtCpoqcqSLh4iUht2hSsAgZw/AWPe7aVslTKPm0+/Zyaxhjsb8CSjSbsDFnA==
X-Received: by 2002:a05:6602:1594:b0:841:a678:de2e with SMTP id ca18e2360f4ac-8499e498f5amr5396126439f.2.1736174367740;
        Mon, 06 Jan 2025 06:39:27 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8498d7c8308sm879002839f.7.2025.01.06.06.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 06:39:26 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org, 
 linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20250106083531.799976-1-hch@lst.de>
References: <20250106083531.799976-1-hch@lst.de>
Subject: Re: more BLK_MQ_F_* simplification v2
Message-Id: <173617436596.57123.7517219481255873566.b4-ty@kernel.dk>
Date: Mon, 06 Jan 2025 07:39:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Mon, 06 Jan 2025 09:35:07 +0100, Christoph Hellwig wrote:
> this series removes another BLK_MQ_F_ that just duplicates an implicit
> condition and cleans up the tag allocation policy selection by using
> an actual BLK_MQ_F_ flag instead of a two-value enum awkwardly encoded
> into it.  If we'd ever grow another policy we'd be much better off just
> adding a separate field to the tagset for it.
> 
> Changes since v1:
>  - use a boolean bitfield for the SCSI RR tag allocation policy selection
> 
> [...]

Applied, thanks!

[1/4] block: better split mq vs non-mq code in add_disk_fwnode
      commit: 6783811569aef24b949992bd5c4e6eaac02a0c30
[2/4] block: remove blk_mq_init_bitmaps
      commit: 68ed45122249083bf45593ed635474282583352c
[3/4] block: remove BLK_MQ_F_NO_SCHED
      commit: e7602bb4f3a1234df8b75728ac3260bcb8242612
[4/4] block: simplify tag allocation policy selection
      commit: ce32496ec1abe866225f2e2005ceda68cf4c7bf4

Best regards,
-- 
Jens Axboe



