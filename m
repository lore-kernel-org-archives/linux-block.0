Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C149429B8C7
	for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765436141; cv=none; b=XRm5eVuXTs8ipQZqT18kyFSEvSqPOOn0LpOOW2AM4yqmP1syxVY7SVQOqfHGrMvvchb+5wBsbw5+6Gtn+B24Dp03joqLY121zzzQoEaHM/vVMXtgWE94fuk96AcRn22+jrVK0J2qortXx/KH4mXORdBs4ZEwwMJQYJMJ6o/JLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765436141; c=relaxed/simple;
	bh=7fOMZWpqXC+kMdKkfgZWudYMG0UI77944jyl1GXS7Ps=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QY3HwPMrVM289TfsmNK9SYL0GtBPWxKwob3XZSn7BD5ykA2Z3Wwve/amgOAE4OYnw8JGD2vGzG8SkhB5JFgO6GB71ob74PhDFLqlRBt+nAw+UmZEehpUIvoZLaIXP8uzN+Uya8qjZ/hwuITDC+uA1cdTbo2GkI00bZbYoMuljV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hFXvkqGB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hFXvkqGB"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7bb3092e4d7so619673b3a.0
        for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 22:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765436137; x=1766040937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6t10daDk4s6MyC0x15QD6gZ8aKnvB29UsDlKWTG/k/E=;
        b=hFXvkqGBiBUrZybaMnV+2TUApt/lSyhI9Yl/bluropq7SAMeE4i6pMj91bY514EEOj
         bHOjiULr7buMK7lfIWFZAcYHtT08wxOgMVQ/Q20y4AJ1z+VB6OZMHhRqLUrlFxrtHDxR
         ag2nzagRpxxm9J93Ai/uXnLCzWpE/0DnGbT8+IGInVuXN940ylsUnBiy9MrFZp76ixRV
         eD5azTVPeNM1HSRC/iIEdYTSDRW4elFBPBlhQ0BA8rrskGwqvDa7lgFHdm0vXXajkh3E
         Stp9yD6nxHc190DfY9WkQvS/iFyBDbH1H0mHovqnGiazdQZnf/mzOY5bVLjYIJz/6RB5
         RNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765436137; x=1766040937;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6t10daDk4s6MyC0x15QD6gZ8aKnvB29UsDlKWTG/k/E=;
        b=XQSucwiSQaw0mRp34+wxGA1dpscwwagX5/uU+MdzYKErqNpO4HkpBKTGHb6uLAmSjR
         sBe0waN4KtZoi0QmbJX8TXUG5W433V8WyCW4gOn6BcxUxOUMhCKyHgAEFauSoGnx+OUz
         ImAM/B+c2AxMQxadycHOugKprT862DtdJnOV8z/1hq1ebSDneV3SHFXPemmRXPFaNR57
         +pPtf2oAz7q4DZpULbZrKRJ8G4GczgMAhzkJOfJbNuTFqbG+53qPemB2XdrtZIfNQF7l
         9Mi5Rl1aZDa7Fu1vJvE0Y1QknMv1CkjNa2yDC9f3MBvcmqLT3vDue/gWwrLJKk7b+I/m
         lJzg==
X-Forwarded-Encrypted: i=1; AJvYcCWxu799BUjbjTOdK8klVNwspitDXOxONnowIzow4JHIJSVDpB1gyCYyEwSG24M/ZqO/lQwR/MhjGzqlvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YweBtF4ZjFe4wm+bM4rkeyE6hAjv74qT0ka1JXfrNd6UWnKLgVv
	tkn0vkXY+PbYR9AYzkJzEV0PEHVx6lZKEl3HRNhNgbdupsV3ImmRyySV85k6GY/RaeiHPpb5XAK
	pAIDGXK0wOA==
X-Gm-Gg: AY/fxX56kikzldyGkkA1ahMJCJ3TTrhklVQEfBf2uc/9Qugbmeyuo+mRl+WhMIEN7Co
	wmTFej9eKwAiQshuXUYDh1cR7A4nt2B6arS+I5FgMhnrlyFwDvT7IX+Sc1HezqoXz/ZlRvx1ez3
	xon8JNjzljeW1NdhHEUlTUdcY+7AIPBCMPtSpCWc+2S/tixZzyQ5jRJLwfxEN6mi2E4HUuY8w1+
	pHE5QmlQvIq5mfZBPKaZxo5dKug9fvxUiE1Ep5oHIaC3mpxSFfdQ8EQ09CSAP7ppITBt/iWTe1x
	+Cs8z4589Pc8eGsUFVpZmVXrMTGB96UsTTk5c+vqioOh0HwL7n3fcvtkib8KJGOac6cAQq9fA3Y
	5iKvkdTnJbNYG6ExZj46a5050QNAhY0y4Wqh/emM9EYqY3CMGqJC57M3SK6acQyfbrDhE8cqNVV
	T55wkS22xvrfkM/fOTIDQ5lzhQ7Fk7FfS6t7PXI8y7amPcAQ==
X-Google-Smtp-Source: AGHT+IHUHHFmshekCKPGJ1PiCPmkblP2Uul/oBOBJ3dIy7RP641lQaQQSNppajm1f8fUHk1ABBOK0A==
X-Received: by 2002:a05:6a00:983:b0:7e8:450c:61be with SMTP id d2e1a72fcca58-7f22fed7cd4mr4627077b3a.46.1765436137376;
        Wed, 10 Dec 2025 22:55:37 -0800 (PST)
Received: from [127.0.0.1] (221x255x142x61.ap221.ftth.ucom.ne.jp. [221.255.142.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c2d4c2eesm1455791b3a.29.2025.12.10.22.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 22:55:36 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
 linux-block@vger.kernel.org, linux-btrace@vger.kernel.org, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251125075206.876902-1-johannes.thumshirn@wdc.com>
References: <20251125075206.876902-1-johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v4 00/20] blktrace: Add user-space support for zoned
 command tracing
Message-Id: <176543613568.585204.16743933013509349658.b4-ty@kernel.dk>
Date: Wed, 10 Dec 2025 23:55:35 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 24 Nov 2025 23:51:46 -0800, Johannes Thumshirn wrote:
> [ Aplogies if you recieve this series twice, my ISP effed up badly ]
> 
> This patch series extends the user-space blktrace tools to support the new
> trace events for zoned block device commands introduced in the corresponding
> kernel patch series.
> 
> The updates include:
> 
> [...]

Applied, thanks!

[01/20] blktrace: fix comment for struct blk_trace_setup:
        commit: 7d93035f63e95a9ff211689a5ee5a9647fe4539d
[02/20] blkparse: fix compiler warning
        commit: ab25c60d012adc83a21e2ba9f5b7fe977aed5a3a
[03/20] blktrace: add definitions for BLKTRACESETUP2
        commit: de46aab777ceb75c9742a09f687e27c602f588c4
[04/20] blktrace: change size of action to 64 bits
        commit: de7027a4c293112b58f27681d3aa2c1706f760ad
[05/20] blktrace: add definitions for blk_io_trace2
        commit: 26281f82c94178e4cd776cfd83b7f6aae61323c0
[06/20] blkparse: pass magic to get_magic
        commit: a40c8fb0d1a56b0fb9bea1c45dfefb3d8376807f
[07/20] blkparse: read 'magic' first
        commit: 43da1fe08510a1c12c15b7a5829e62cf5a1186f4
[08/20] blkparse: factor out reading of a singe blk_io_trace event
        commit: d627b9fd563dbee65a56745b27cd94ba2a5d89cd
[09/20] blkparse: skip unsupported protocol versions
        commit: c1b026f5a0d9f0a537f0e9bbc727893046515334
[10/20] blkparse: make get_pdulen() take the pdu_len
        commit: 5653f26bba9e4969d59907a03853bac6ad29bb18
[11/20] blkiomon: read 'magic' first
        commit: b86ecea48bcb71406df046a1ad2f07a202ac0498
[12/20] blktrace: pass magic to CHECK_MAGIC macro
        commit: 5a4b378ef389584299664ead32185cc42e7eaeb2
[13/20] blktrace: pass magic to verify_trace
        commit: 4475f0f7212d543e54515acb1227504887ebc296
[14/20] blktrace: rename trace_to_cpu to bit_trace_to_cpu
        commit: c79c9cbe395891c64dbfd3c8814144e44058ef90
[15/20] blkparse: use blk_io_trace2 internally
        commit: 7e0e7630d31925f412bf653112de4a3ebef4f169
[16/20] blkparse: natively parse blk_io_trace2
        commit: 294b572943f6cfb355ea941af159fb1e8be5d503
[17/20] blkparse: parse zone (un)plug actions
        commit: d302cb7c8cfcbd9599ec266b68cbfdc5f755e646
[18/20] blkparse: add zoned commands to fill_rwbs()
        commit: 614c58fc23934c77f6c54522a329637e00e72212
[19/20] blktrace: call BLKTRACESETUP2 ioctl per default to setup a trace
        commit: a7cd5b1b05e790c93894a4f00c548d214602d9e7
[20/20] blktrace: support protocol version 8
        commit: ece6cc27ec8b809a0227a9b2aa3ab229883793a2

Best regards,
-- 
Jens Axboe



