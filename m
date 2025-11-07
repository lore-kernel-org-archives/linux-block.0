Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7C5286408
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532915; cv=none; b=cuZ+DqFFjC4tEidqw+qFew2mqjpmKbW0OUWT1MfvviZJfdzqq9TdrcFunWgltE9l+6F2mMT4A8j53GvdTroS0oMyk0oYk+2Wks25By1L9yOonmVnzemI3Q6xbmRQXlalt4qRioYFqgr2lSo4k9aZu5Qd5VPiyNhD4MbHTyQSwas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532915; c=relaxed/simple;
	bh=GU9i+cSHYeAmfgu5QgUvOaQ/EYfB9seYknc41Y1q2Xk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pXDijd5xY1QUolPnoyeaCZXsWJs8od+OaMsUp/SWE4kno7DurhfzCUveRn4F9fZlwCR+Bs8tO2xLdIPMEdr8MIYkhzLvVlkbbgJKQch3Bz4KcGEEP3IG79gNuvbrK1nwHiC2CJnZURNItNoQafCaavhaIdLrtIh97xiLreHWEVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mJdQfiwM; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mJdQfiwM"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ed8e22689dso5798641cf.1
        for <linux-block@vger.kernel.org>; Fri, 07 Nov 2025 08:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762532910; x=1763137710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P14HrSOAwtoffAEwKkFFjJLaLN+ZlqobXY/qFUNR2g=;
        b=mJdQfiwM3nfs+ZmeNTML3oaVToDLYS1gcefbhJ4fx6h6fGCbVusj0gcjPoq3AMxCI1
         DpPqJYX2eZpfdKKywIpyLCXJ7nauqJxnSJZYqJrk3C7/ayzOiTcy8T+XqMBwfXy44My6
         VK2tOPC/5ygt2vpPPHA6TtBsjprAFalasT7ycs6Waq9Ge/TTY/6TprHF2+zvxT7N911v
         oK9YQNB/Lw30sZbp5i9vLK3nHBLgPodZnPUjMgCVvvtKe5koQlt2HTURF/xwOhkkNBBj
         jwlGHijwFq7lTCDT/0iy+486D06uvTK6d0RhChB45tIegpFfuGuJtus5cyIOBvVodq1t
         n1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762532910; x=1763137710;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6P14HrSOAwtoffAEwKkFFjJLaLN+ZlqobXY/qFUNR2g=;
        b=KHja6kdIXFUR0R1L1RwaDDOI1xSaTJTujQpbD3GIhE9+wFBXTktZH97Ou2RbngVk8Y
         Dn0gUJci3QMjRGrwSR0E8QeYuga3663wZAvCK8bwfx/60frJ8NFS5YMC7YJTDG9/BOOI
         HvRS+dxjQo5qU4wq9FadwHRHTVG7ktoWbplTNdT+uCMK0xek5QT03/1+M5AKBo4N/Srv
         Vxyccor11wKR2AP/0T6PWn8XPgeA+eOQxnA0yCzq9FYKemiDGxmbOaPLiTo+8aZDSC45
         76S5ekRS4rq35R9BYEyhpf4NEgJF+g5v9rXE09jQx/B9Oh5NKhed7beZqUKBDh7t2x7v
         Aqbw==
X-Gm-Message-State: AOJu0YwsfWXdvHTo5jHCCsONjoQIeW7PO/DurjjDU4ouTiVB79XqkIr3
	J0giyzckEVhl/I6821g6zwi6eo6ZamKVSB+TAsQJ4uFOZjIummrPzBCoaGByIywoP1M=
X-Gm-Gg: ASbGncsultLFPjhuPD23od0boAFs5t36ERhnvSFaNgjzn7ktEaCNR9A6yRxsIP46hKp
	ft7qLmhqLoiJ6aFoI0UJo4XAbuQCpepuGMlVCztNRDKBVpeSr1goYQjxbsbCZYwc8k9vH4qe5KF
	UY1sHJOZ9UJr65yqDONh89w+bC7DTKtMd5Clxa+CsfTIM1tZsiJl+30D10Ck2o8z/le4oxCUsmK
	GY7SnkIdsMj/DOfxDcfg8qJI/mcidNkwf56ywejJ5FtAcefw1u2IJ6FH1OkwGQy9lm3hvGmOLSV
	5sL80IpSPSFotxPUqZyYRtC8xf0ltP5Fbz0L2z/CeasLQewc4u/zveWTVV5qirGe6PG6jmF7+LN
	O7vDRWsEopfR7VIFAMFNBj8FIB9kOs34oloSUMLORylDtQhBCeBMUFfw1TEO1CHQ4u7jRrLy+p1
	2IdFc9LcU=
X-Google-Smtp-Source: AGHT+IHZazYd2NvyUtFipfvLburkKBnoPfQ/XZtRCCSd2tkD1A94ImezLGmro8U7f0hJ0367J0nhiQ==
X-Received: by 2002:a05:622a:14d1:b0:4eb:a10c:de05 with SMTP id d75a77b69052e-4ed94a66ae5mr39495061cf.55.1762532909587;
        Fri, 07 Nov 2025 08:28:29 -0800 (PST)
Received: from [127.0.0.1] ([2600:380:1841:97f9:e336:e121:5b93:f02e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed8131b371sm42119581cf.8.2025.11.07.08.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:28:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20251107063844.151103-1-dlemoal@kernel.org>
References: <20251107063844.151103-1-dlemoal@kernel.org>
Subject: Re: [PATCH v2 0/3] Zone related cleanups
Message-Id: <176253290817.22541.15432277161231584094.b4-ty@kernel.dk>
Date: Fri, 07 Nov 2025 09:28:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 07 Nov 2025 15:38:41 +0900, Damien Le Moal wrote:
> 3 more patches to go on top of the cached report zone support (and its
> fixes from Christoph)..
> The first one improves blk_zone_wp_offset(), the second patch refactors
> the use of this function to simplify the code a little. The last patch
> introduces bdev_zone_start() as a replacement to using ALIGN_DOWN() for
> getting the start sector of a zone.
> 
> [...]

Applied, thanks!

[1/3] block: improve blk_zone_wp_offset()
      commit: bbac6e0fa57f6624123edf20ba8f9b7c0e092117
[2/3] block: refactor disk_zone_wplug_sync_wp_offset()
      commit: e2b0ec776164c11569ee021fac89596a2642654c
[3/3] block: introduce bdev_zone_start()
      commit: 25976c314f6596254c9b1e2291d94393b7d5ae81

Best regards,
-- 
Jens Axboe



