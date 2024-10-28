Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6CB186E27
	for <linux-block@vger.kernel.org>; Mon, 28 Oct 2024 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140532; cv=none; b=rBc8ncYC6exc/+M9Om9R9nVEa1MCg0A09GhYtEoBMISYqcqHecrI6f/8NI5thZTcKjcmrQJwhIig3EfGYCW/u1Fo8Mmh1ZbpmXl3eSNyiwwbf49704G5wZWZc5NeGdSguOxl29l6bk6jWTbOYVnQJpppujZ2iseL5m7uTuc23wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140532; c=relaxed/simple;
	bh=KuYeSJrDXJ6SKx7vrSQDxkJKT32dYHr+Xbohf/TPTyo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nsB3pgMDc1I0P/lFpDtnwFIoZq0EGBJKoDyFaBWUA0JlDtaTM8IExz1ceXy27UARJ4ZfrvZwD5ImCveteL2QFu20g176nmh2cBZF7UK5/nJDwXWNT9ZEa4GghK7gDxJlYsNU0xHG0EvEGANF5NfIq7wr5yg8IqJ3Yx20VJTvWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=H/S2bPDy; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="H/S2bPDy"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82cd93a6617so152687339f.3
        for <linux-block@vger.kernel.org>; Mon, 28 Oct 2024 11:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730140527; x=1730745327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHyZNGrjkSesiQYUObyNxk6ik5ez4+Sxy4cjfucDHhw=;
        b=H/S2bPDyiwb1IsGaFY3jNbrLVMk/HPkQ/SjDnkqojE6YrxK/aS/hHBQ8G6XDt8Bwmk
         lEF3tTM83ZuA/3tYiDo8MfTG7sCAgrUYVov27ejKOvPXhbxXKmSzvbOaUjwRZwwqK6OU
         xujYp+fuj8L+vNQMx6mafQHnwCu09ackPzdutFUCI7SYgRMXR9UbgSb05QeQPsLH1pti
         r8uVOaKJlig1ZMmDFGjTGwSXZm3hXoT9stXhwPUadpljDdbCKZkALorBqoqCNqB7tIe4
         8Ox1OTloQZdbDg5Gu4Zd9tBBAi8M+PXnEnit5WjAjfAGEFnjrf8CWsTWvw1NSSE2tykd
         HRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730140527; x=1730745327;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHyZNGrjkSesiQYUObyNxk6ik5ez4+Sxy4cjfucDHhw=;
        b=MehDhlxB3Dha6SOv+x+Oy27UrebDau8jPRWyRPK0KtTArFT8VzNTNthkxJINPBOEm1
         fuFmnyQ5NuXwACIYB7u92hP9NKqo8TmupXbMFYK63cNCEjVKvj9fHfJhHWGiDHNSdRos
         PsSIJVJEpVskNnWin4mDJKXUUSeH1OytWfaxFdOkI9rM6NMXB3cfROZ5ldrpRD9KDcJh
         PeACA0Lln+7pDa58hAewBcJF5dRADGTjCrqt7EoeBUtkZt1BOCw+GPAcWB60dAFvyqez
         1guZE2IRhfBw6OiAQTmPf4EUAnFSaWbLmwCUKKzAl+Li/HPKQTruNedoESOy+HAsUlK0
         90bw==
X-Forwarded-Encrypted: i=1; AJvYcCUsziidsprEs8Oowgv6W7sdxOb9OZd5WnD7RgjE/+/yY5+v16IEEOdVzwleC/GgbZNJkSGFRftyIKRZQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yywmy8MUxmhuOTQv4xH3frVsiq5VVYpmTsoIt5SbhpKq9ZnBXsx
	z7WCi7GwgGIbyK/gw3pMEhExXJr0HxYyg9M1GnY3SGlLtD572hAC9q7O4VM4YCM=
X-Google-Smtp-Source: AGHT+IG3j/nr4F3b2aVvgy+8vWqTxIdua7b/wMCOYJvtHNj47/wD0HwQdY8rrur4pP4/QEZB4oPSgQ==
X-Received: by 2002:a05:6602:2dce:b0:835:4278:f130 with SMTP id ca18e2360f4ac-83b1c5d43acmr635211339f.13.1730140527324;
        Mon, 28 Oct 2024 11:35:27 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc727506a7sm1802472173.85.2024.10.28.11.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 11:35:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: ushankar@purestorage.com, xizhang@purestorage.com, joshi.k@samsung.com, 
 anuj20.g@samsung.com, linux-block@vger.kernel.org
In-Reply-To: <20241028090840.446180-1-hch@lst.de>
References: <20241028090840.446180-1-hch@lst.de>
Subject: Re: [PATCH v2] block: fix queue limits checks in
 blk_rq_map_user_bvec for real
Message-Id: <173014052612.465142.7912214778947316662.b4-ty@kernel.dk>
Date: Mon, 28 Oct 2024 12:35:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 28 Oct 2024 10:07:48 +0100, Christoph Hellwig wrote:
> blk_rq_map_user_bvec currently only has ad-hoc checks for queue limits,
> and the last fix to it enabled valid NVMe I/O to pass, but also allowed
> invalid one for drivers that set a max_segment_size or seg_boundary
> limit.
> 
> Fix it once for all by using the bio_split_rw_at helper from the I/O
> path that indicates if and where a bio would be have to be split to
> adhere to the queue limits, and it it returns a positive value, turn
> that into -EREMOTEIO to retry using the copy path.
> 
> [...]

Applied, thanks!

[1/1] block: fix queue limits checks in blk_rq_map_user_bvec for real
      commit: be0e822bb3f5259c7f9424ba97e8175211288813

Best regards,
-- 
Jens Axboe



