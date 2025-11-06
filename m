Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFAA309DD8
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 23:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471537; cv=none; b=iD/eBJom1ik3TGOTD/qNNoFu4BMWRMQulE4yaVV34AjLhby60m1hw7PrvIHmrcBFUWkMII3IjGtcp+86dOvnG3eivTCQ7+5Dcr65jyUQBxwJsZYw3salC4v1txLqAVHWMpWDUTVo81u1eqYuP3o49Bri2FWyWWOBcsPJKxaC6hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471537; c=relaxed/simple;
	bh=Sf4Cu8QJoEUJofuQ5riDXaCZMGewWTmYvh8kK9cPgpg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QEOlhTt6LCKiGzBeG8iDiQTnX6pwEq+Prz8P7/VHLaYhct1xmB87kz/QRiZ9KQaG3OLXoAnrOvfWbDD6d/uCeWBTVqyB7LD2eao3n8Bo1gcJkPbeYf70Ne3bOcf8ANpG4U2AjwcubXgJUKp1wOXZjbvz4xUPW/Jb761y4CC4onE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=POpKmMhV; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="POpKmMhV"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-87fc4d29301so2325176d6.2
        for <linux-block@vger.kernel.org>; Thu, 06 Nov 2025 15:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762471532; x=1763076332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYxoLkoyNivRpvxC2u59LNnMfyZBMhWIxsWOgwpE3PQ=;
        b=POpKmMhVC04isxmt3VUfkJ32esdkyNMrlhuxEp2vqMWlEhf8dmr1y4j4PGkqThUxFD
         u46kMy69YrrFRx3cLyY7DOr6Hq2hEL1xgDRPPptLeSBlXmDawyuaNoanC4BUf9xr3lE+
         JTPR3jlLhDm4L6pclNs/ds6ucQJ9NQcLyB828h/waEp59VqbX8qwn+7EzYi+/eO5HiZs
         0IbAmCmF9XeDXAmljk2yz5XHsqNio+gL4QUCN6zTmtlVx18ZHvpTMsXZ6ezo8rSExWVn
         mqK3m02SIEnAO0V+ivzAlUifD2keexz4MmX5EXibvm73q1dGHwPCZ0fE0y6AEXT2NKfU
         X2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471532; x=1763076332;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eYxoLkoyNivRpvxC2u59LNnMfyZBMhWIxsWOgwpE3PQ=;
        b=MOVV/pCN0tCDCNYp9uovvDsNn/qUVV3ejh3m/9V3Q81ayTj5W+z2qYE8EWE06NQgyz
         r81h42k1sUEVjr4B4eX5mXcbdGISlbfvaevMW1f8EN/6rNG9xbvzHYAi+GBViSIl8Cm7
         iAApx9mF/fI4he7zRs05dioRNEsodRZxIePOYncd6rBKX4sbJDrKM6pNVB4/3ONsVVqj
         Xva1OJozgD3CD6DDULb3UieMz1lJPwfLUBbtPXIY4t4HQ8S9F4sZz6GchUHI96KxyVEI
         DWqQt/grOK4AoZgJlHi+ThNSvAVGs6MiGMouUhVRWyizOtiPUJ4+wVzyToNz1OXCQ/sA
         bfNw==
X-Forwarded-Encrypted: i=1; AJvYcCU4AyiEK6ILN5NHHlPz6NPHkLH37C8evKzFhzvuTf32MmGb+uQ08xAgUtUnOkKW681gIO8dRoqRyQFuaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywufuq5vpar7PVtNI4aM1FG2R3C82M+I2jxNbvwLpcPE+f0PFkU
	vBREq08hNnsF2+HFLRkWQ5ptmqT8O5F4p3QdQvfDdCD8JB7e9LhfEZYGU3h758Yd6OXFvLYxZa1
	6NhsT
X-Gm-Gg: ASbGncstf0OtxuVhVtH3s/tZR5TUYkOYxTxKhtJJoQbI0Pq4SSs3We9XfFushEhJeWB
	vVuummRTTJ/juVm++56Rnr8d++GRWWbxswRH4AfHPislUBjgVZQ43HX4s0aMzVpUrmoVRmGIaH/
	eRv1ocwxfRi4t3nQcwSM97LKpq4x98mq3zVkXT4GlpoBfkW/0F58/6dReBJDigqQd3K/r8DiHgG
	rWkRw93ZIpRx/Sycb84tVcAGgX8tHz85PRJ2GOlZb2NpRAbm8bpbjZuGQaS4sYH5473qWqcUFEx
	UmoRP/fPOgX2a7dZ2udZXWvvJB5Kv6nlBI9mj4aoL8AekQIV8610zC3aTiNg8Mcz9io/2JpwTcm
	q8Ff5zb5nD/cBXmdgiAcCZ7R3rQVQbIblcfvLk2vAeth4/7+weJzqmJKNSA8+v1+UyWtaJPw=
X-Google-Smtp-Source: AGHT+IE4rjC4X8VndEvY56tR7jwcGj9r2cQHXHnFC0f34KE8Sg9giPGiFpW0zlMfPS0h/XIVT9v4ew==
X-Received: by 2002:ad4:5ecb:0:b0:880:498e:a63e with SMTP id 6a1803df08f44-881765c29ccmr18521426d6.2.1762471532088;
        Thu, 06 Nov 2025 15:25:32 -0800 (PST)
Received: from [127.0.0.1] ([216.235.231.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88088b7addcsm18224696d6.32.2025.11.06.15.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:25:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
In-Reply-To: <20251105195225.2733142-1-hch@lst.de>
References: <20251105195225.2733142-1-hch@lst.de>
Subject: Re: cached zone reporting fixes
Message-Id: <176247153022.289461.13704179002556804114.b4-ty@kernel.dk>
Date: Thu, 06 Nov 2025 16:25:30 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 05 Nov 2025 14:52:13 -0500, Christoph Hellwig wrote:
> this series fixes two issues with the new zone writeplug caching code
> found running xfstests on ZNS devices.
> 
> Diffstat:
>  block/blk-zoned.c      |   46 +++++++++++++++++++++++++++++-----------------
>  include/linux/blkdev.h |    1 +
>  2 files changed, 30 insertions(+), 17 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] block: don't leak disk->zones_cond for !disk_need_zone_resources
      commit: c6886cf610f4bb0b8aa6b88ab013a042e317f898
[2/2] block: fix cached zone reporting after zone append was used
      commit: 15638d52cbcf6e969f4a5e2757b118355db583f3

Best regards,
-- 
Jens Axboe



