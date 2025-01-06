Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD041DACA1
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174370; cv=none; b=DDNS+piDQjRCxtEeQYCOX/lISoQiqplnRqd1yNmSqPJTz9JbKzooWkGvsDrXIH8o8k4Uqi/iBm/8gy84107w6pPbXlkK9/N9bNEZhUpCuSCH35HDyWxCQd/W+zXNHK7SZG52Qt/E0rcarLNRP+B2nzfxPKSEloLizLwmkMk4+3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174370; c=relaxed/simple;
	bh=TptJPJzX1Cvj0p6wPpQAPLrRFQohthFDKytgpUV+7Go=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IsudEaoHLpKZbukJP3PFr5W/MeCNZNsVedJw3k7iEYmMD8XZy0Iz/Kqjo2wyRt+GyElNcaqFz1gp/H+DpSPMJLz0p6jCPGXIyVSVXOAU602V6/0Q+F8vCieNpTA4pt22ucrizDzEY9Y4ES9m4QIncaND3E/L9DLIrESjdfprPCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=H6kMdYWk; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="H6kMdYWk"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-844e10ef3cfso1192397439f.2
        for <linux-block@vger.kernel.org>; Mon, 06 Jan 2025 06:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736174366; x=1736779166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZOSuns5unR7+mf+KRgIO/yEWEoBMhsir0rfrH5muXI=;
        b=H6kMdYWkpQFnTjl8NRpJ5I4JluTzJpEoSdK+A85/Qvp9ARX6SWtIylV+I9U7Z6k+Te
         kt/Yr53b1FEYjm5g6N18sR9Qfun2l9eAjJK1gCg0Su2z70KgPHZem0zCE0tSm/DyI92H
         qa5o8/iBzbYll0dB7YpbQhygaHR45/ImNKfOx7MGc/DKmMKBMUxF5zRjYcditaKKuZ6T
         BDAfsxx7IawpN5r46/kSfHjr91UP/3S3ddP1Y0wUVCAUuprv3SicKg1nZQr/rwEUe42x
         89O1jO1pVGsnNNs2d4D84FAVaocpWWcnXBBt477kULjj72rp4+mYSHAT2je1KwecRBjA
         4BQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736174366; x=1736779166;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZOSuns5unR7+mf+KRgIO/yEWEoBMhsir0rfrH5muXI=;
        b=V2nkN2U6G4lJERYzxPZasBpJ4a8uwZJ2NzUB1X/1Q6px0M+wYaozFezaQJHnPdopg7
         k3aPi/rpVLEvtR2Lke7gcpIZqiI+AFoV4fWs2HTudi92ylcwRFoOvDFq8dYOMZ+O9pC/
         0tTcvDeKCdFbYuUY6cEE3AH3hCjvVIthEWPdj6YY83le3+P3U/c2dbmkxvXBFZ1sicEw
         Nhe5IZmQnjhiaTxk68cViBR40BVHX96Tklu3Rus5+ZnRAGKilzKy5BLU+MsOsBbTJRcd
         g6aSndVwGIagTQm6zrg/rWokdDQ8Y72Ci8ZQrBb1tw0wJlnR/my7UySTykgFDepWNODb
         z8Tw==
X-Gm-Message-State: AOJu0YxNyNoK/+y/0Aq+KNeOQb1mO+XSqzN1dHK3pjS3Ue+IAKpc2AWl
	ng5mVXgdfMgYw7dzU7cBmcxFGrCnwoJeoJdHPQGtonS6E2efmENxcEXqzPxIvz0=
X-Gm-Gg: ASbGncs4GzWFJM8t3KS+il1dJkcDTrFg8KTovvDnu2Ew75G4NAuOnvUOuLR+V8aLPKz
	MdVfB5ePyIFs0F7g5BkXQMjGo+Ujib1zlzwL5UbWmw33F+qBMHu3+Bk//lDSsWwgixrKXOgFbyJ
	eTubkLuMjvbkxLAW0+jl5YFl8d/tz3Q+VoL2Sapd+HLsNEOq+0DypLFCI9apWAufuqwecWqBeg7
	KWu05bDcisO1IPqgY9I0kSgTdCLYiOA9RIEULPIy7loeOQ=
X-Google-Smtp-Source: AGHT+IEpckkQD3GqH5bfyhsLNRKQGEZuvZdDklDyxkSBTuH4Bo1Vi2GZBtfWPw61W7Mtda91SyXh+w==
X-Received: by 2002:a05:6602:4802:b0:84a:7906:d988 with SMTP id ca18e2360f4ac-84a7906dba1mr948770339f.0.1736174365877;
        Mon, 06 Jan 2025 06:39:25 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8498d7c8308sm879002839f.7.2025.01.06.06.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 06:39:24 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20250106081609.798289-1-hch@lst.de>
References: <20250106081609.798289-1-hch@lst.de>
Subject: Re: [PATCH] block: add a dma mapping iterator
Message-Id: <173617436455.57123.2311514332951539632.b4-ty@kernel.dk>
Date: Mon, 06 Jan 2025 07:39:24 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Mon, 06 Jan 2025 09:15:29 +0100, Christoph Hellwig wrote:
> blk_rq_map_sg is maze of nested loops.  Untangle it by creating an
> iterator that returns [paddr,len] tuples for DMA mapping, and then
> implement the DMA logic on top of this.  This not only removes code
> at the source level, but also generates nicer binary code:
> 
> $ size block/blk-merge.o.*
>    text	   data	    bss	    dec	    hex	filename
>   10001	    432	      0	  10433	   28c1	block/blk-merge.o.new
>   10317	    468	      0	  10785	   2a21	block/blk-merge.o.old
> 
> [...]

Applied, thanks!

[1/1] block: add a dma mapping iterator
      commit: b7175e24d6acf79d9f3af9ce9d3d50de1fa748ec

Best regards,
-- 
Jens Axboe



