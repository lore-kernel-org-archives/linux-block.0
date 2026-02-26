Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAC73B95F1
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120492; cv=none; b=qcBr8f94RzMro4xQHF5Kz/bdSuPEX78fgRxigjvSj8Kg5N+2Sxr2OzJSoM0fPetJtmbC6arTdu35MFODczh6hDTHfJF2SSK/2fxYNAIqyl6o2YzINO8wRbenftPaQvek2Nyt4PHaSZzVQi8nh7LgSqHqcKwhdBDQKYc6qO1JnFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120492; c=relaxed/simple;
	bh=Jry6WCkZJt8VKBX6UrnGtmlrGoPK52ERr93AfOBVj5g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CnoIOMQm8sZ27tZNFdUR9+zPoX2cJgmG/QFWhPfJ7yRbIOCc4PzEf9hryX+WaOxzeaItkVEDkqivUi570UblRp82j8q2tRBZ/LUTZyYDugA+yrkxQdQbLwIsnbWIkc2q2puaODV1xr4l8q+I0LSP702nDpMI/p3rgZPnuJ64kSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oLjNF8Fs; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oLjNF8Fs"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d1890f5cafso376518a34.1
        for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 07:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772120489; x=1772725289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7HOayF1h8DktJ0cz4nMEDuzZ+6gF+C9n5bCyyta3ME=;
        b=oLjNF8FshxLOL4/SdIIDbVkjldddSFGyV7n3ATsAS1iSvFioEKMyGoDElb11bgdgrQ
         FtMHkuBewoDOUud26kKYDMlD7Kb6hiUSxAyCcFAz/Un2twNf3UGXFllka0It6r/r+ODv
         WlTFdFCzxvXPziCbCnwFg3ga9Rd+MjEGtYfM/LEe4xQ3jPDcpQd+d4tjhbd0e6buGEdO
         HjpTqoXnj225wTx2Woi5Z4TusngsmI2qoj+lrjxXY3ldppr8gcn+aRntYIVes703DKry
         1F8CCeU4U6E/qOCV48TM/T1VRRiyMhyHYdRIEoUgcawQfhO8Ib+CqqLeXYjP+ecGosJC
         Cb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772120489; x=1772725289;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i7HOayF1h8DktJ0cz4nMEDuzZ+6gF+C9n5bCyyta3ME=;
        b=lxa/eIhyBmQ25u9SXDhq5S+Vpwo85hEohQ4C5HjoRhCLnwQNLyQhatr5XTmiKZKoSm
         tPN0FZbRDsbM1Q7xwYXd4Uv2GrbSGEPx95WebNx/S+lCkCHeMG458LwV1/lyZXst/vJy
         64P8qYfIdEa3ypi4r7f4dAyfW38rWkGLyCiPAX8yFyD7KTONv+J84HEnQDYHsEUcM2oA
         ZhKsq8CH5s/AzssCBCq6euPjAHp+79Tctf34nNQpBr0pdJHGmOXFauEOxWRF4zXCmGBI
         uAs/Ep2uFygoHBUUIcC3ng0PwzFNICJFEQCJTZiVa7o0amoWOB3GfFns5pN6ng/Lo/hG
         dgvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu9maGvY2ZlRV02HBPctfUCox2fl4j5CcKGJPvR2WJtpybxkT1+2tZhxszuTjcvybYf6BWrBpn1l85OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ+HDACHilJNexnjdPMQB+I41GbRQiNA2+eDnc6bGswMiuerwT
	kSFEe3PHMqwX4Kl1+FTD2IocUyaxTCEc1qDayObks2vOU6d/F16RK/IhZlxy4hUSwHeivinmdNZ
	fvSnI7rM=
X-Gm-Gg: ATEYQzzHd/7lqGOwjAFeeYXtW2MLecaIXULDAR3F1cqky4dxtHTtutP/c0uPlAEfTLN
	/FJ+VA4WBsiZ7et2sqh3QT74xWkCzEFKm+yPiTTHlmUgVAhuiJdZ8i2Ugz2A6+EsUUT3b8A8NZx
	W7uxV+G79CTzQ9oLBh2HHXX2W9LZCpbYhm93HDHFCdKs3ewGRSn0ArgGlNsJRlbLe0k2l7+7baF
	L3HyaAyW7yXP/jLH0bpRWgRnMxKPqY+FLtOxA0uWHAvAfcnx/OFiNZ1ZFVstYB0pMj/URhfHjeu
	ZpaN2ODo0qOjOeadr543Q4RdiR9CX5z6VCt4x9mOVxtvLsaoBD5fiD5b431YIoGwPj7kn1g6N46
	9B06nmm3AfOSrlTCYjA5VE3oKvFBFuvoSdSs0QRojlhnBRtQYojr2HlIwSoKc8pcECvmAv+/Has
	jZJjeh/NuqDEb/sBFC9CmQkcLaxiflivguGsXndahTAzgQDuisdj6L8H4ZqUHbYPAuICAOEHopJ
	6Eb
X-Received: by 2002:a05:6830:2b2a:b0:7d1:a028:4464 with SMTP id 46e09a7af769-7d582a92612mr2231783a34.36.1772120489482;
        Thu, 26 Feb 2026 07:41:29 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586626869sm1978963a34.16.2026.02.26.07.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:41:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>
Cc: Daniel Wagner <dwagner@suse.de>, Kees Cook <kees@kernel.org>, 
 Gogul Balakrishnan <bgogul@google.com>, 
 Arman Hasanzadeh <armanihm@google.com>, linux-block@vger.kernel.org
In-Reply-To: <20260225205107.2837665-1-morbo@google.com>
References: <20260219004940.2594201-1-morbo@google.com>
 <20260225205107.2837665-1-morbo@google.com>
Subject: Re: [PATCH v2] blkdev: Annotate struct request_queue with
 __counted_by_ptr
Message-Id: <177212048818.990177.5581263448487693184.b4-ty@kernel.dk>
Date: Thu, 26 Feb 2026 08:41:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 25 Feb 2026 20:51:05 +0000, Bill Wendling wrote:
> The queue_hw_ctx field in struct request_queue is an array of pointers to
> struct blk_mq_hw_ctx. The number of elements in this array is tracked by
> the nr_hw_queues field.
> 
> The array is allocated in __blk_mq_realloc_hw_ctxs() using kcalloc_node()
> with set->nr_hw_queues elements. q->nr_hw_queues is subsequently updated
> to set->nr_hw_queues.
> 
> [...]

Applied, thanks!

[1/1] blkdev: Annotate struct request_queue with __counted_by_ptr
      (no commit info)

Best regards,
-- 
Jens Axboe



