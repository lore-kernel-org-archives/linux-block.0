Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1313E41C85
	for <linux-block@vger.kernel.org>; Sat, 29 Mar 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743249463; cv=none; b=sOz6uLY9i01Quct/PxzWsCFtE77B0KrsOwKkW/WEfcprdNh+kyVOXED+cqf6HvbZD9y/BTTarFhux8MhK4D6vfHZuHQH2W/rRTABkT70bMwzKsPf3/1KH5No1YGP92wLw3LqAz/F49svIhVTzTZaUTWKObGp5P0fGlEV9w5I1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743249463; c=relaxed/simple;
	bh=e2538gtUpQ42rrCf6f3RRClLcz0Ugt7JJeP9VY7Pvjk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iJpwjFhuPPIPokEW3fqsjRjhb05eVrTuPSNm6qzGVQ6cX0UuDNSbAXaAZnjbuVT9+KjsounzXldhQNR/EWq3ju6BjS8FBsMYgn3Q0eKsInr52wqAnFIgEnEroSa4+CzSKMeGqwV/cxJD1jV9xlOu/9SSSC4TdB+uZVlcYW0Acsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bTpdGO+6; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bTpdGO+6"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3cf8e017abcso11017085ab.1
        for <linux-block@vger.kernel.org>; Sat, 29 Mar 2025 04:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743249460; x=1743854260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxX3ANr6NSvvPmsJnkIgr64FYB3lilCLAO/JftDlNQg=;
        b=bTpdGO+6yu6mWaar7hVxou5cvrMtdtuDcfwcsGiv2MpCxa9rsk/7RwdTomPxqWDKue
         vz4l3U3y0/G1axtwPuS23wHXNcwwEqhOG0FC2KRyK3dTI7r8z+ESSr/Y5vTvtru64U0C
         w2axtgc3DW68p5EYKvYgzXCWCJrTqtggUyKonQcy5pY1zNazHz1sxfcRxz08ONSk6PLm
         pzmYOFX42w3ocjUDI33Tit+BBiEEmDRkkCUkFMPB1xAk7NWdpF0qKXyawXKSC9yONga6
         vwkHOTUPllUrakvXHJv0d3OnHRhJ7pVRF8O4qXa/Au4UarR4XIq5k4PFMvbiKbaYr4i/
         Uf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743249460; x=1743854260;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxX3ANr6NSvvPmsJnkIgr64FYB3lilCLAO/JftDlNQg=;
        b=vATi3EBk0askF69uoEv6KRXWRsMFdg057pa10xJJ0w5UfuvpE9b+tZXsTiAO+i8QjQ
         5J6FruUruCXGLELiLP7J0ZKAzc6wFaW++qTYvG8XDBMw3uTbIf+ZUGgNyhD0Hy31GSq+
         HP9yHAF9dCQuNuvCSf9SU4OpqGdQeIBAhyh6JoX8IAaMheoPylpQPZk+U937S3CHlbSD
         F+Y/ApWihqFhRKDWohtv/yL+iV4h1fvOgLpVGmOVMDaQFvUw71TWGS8X6gY1w+RzBrLm
         PvQKXppVGL6tku0mrcMA0SO/cLPWBu5rtBL6Dk3D8OF7+GQyle+Q9f0d7bcgMOEA1QP3
         DGAw==
X-Gm-Message-State: AOJu0YwuSiFHdwO23P2nzrqGOJfB0YEYV1pBRjnYNSCgflkjx2XuFw2q
	jFjEP7klvqXliU67G7d+Co7DPuyba7sCm/mFWP5pSTAc5yVQb5WTvIl8c6udcnA=
X-Gm-Gg: ASbGncu7bi35PtseMDSaOBg+7eYc++VL876ykiDT/poX+EeSUKmpPmoJJx8+lmq3uL+
	XMsEkq1CSk7bG9b9pysUr+B0iaPrWySFy231NddNqATUhTo4qffNBeHzwWszsBfJv5NHWE42Lu1
	KLXoLtXRmh92BKGv6Dk7SccDbvbmirCgXX/rCemeJX641SXhlJpSu/JGcDsSYmJVsJbVKq++92C
	ZkAo0drQGngybeXSap6qlI/gPcM12HbKJHtGJsFQWvdcmp5TRU0Sc7liHa0UoqJhz+k6Gw42jWC
	5WWxwpzy6aIWvX1lS2C6q+qZVm8DpgMYR/UY
X-Google-Smtp-Source: AGHT+IFTVZKYFNe6UA85TvVbckIVybnZWJ6eZNQXCHzFACulSzjpoYCh0/bq1dgaV0YT6sDI9LHHKw==
X-Received: by 2002:a05:6e02:2144:b0:3d4:6ff4:260a with SMTP id e9e14a558f8ab-3d5e08e9ecdmr27404885ab.2.1743249459868;
        Sat, 29 Mar 2025 04:57:39 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d5d5a6345esm9616765ab.1.2025.03.29.04.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 04:57:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250328180411.2696494-1-csander@purestorage.com>
References: <20250328180411.2696494-1-csander@purestorage.com>
Subject: Re: [PATCH 0/5] Minor ublk optimizations
Message-Id: <174324945878.1614213.14704274208444492991.b4-ty@kernel.dk>
Date: Sat, 29 Mar 2025 05:57:38 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Fri, 28 Mar 2025 12:04:06 -0600, Caleb Sander Mateos wrote:
> A few cleanups on top of Ming's recent patch set that implemented
> ->queue_rqs() for ublk:
> https://lore.kernel.org/linux-block/20250327095123.179113-1-ming.lei@redhat.com/T/#u
> 
> Caleb Sander Mateos (5):
>   ublk: remove unused cmd argument to ublk_dispatch_req()
>   ublk: skip 1 NULL check in ublk_cmd_list_tw_cb() loop
>   ublk: get ubq from pdu in ublk_cmd_list_tw_cb()
>   ublk: avoid redundant io->cmd in ublk_queue_cmd_list()
>   ublk: store req in ublk_uring_cmd_pdu for ublk_cmd_tw_cb()
> 
> [...]

Applied, thanks!

[1/5] ublk: remove unused cmd argument to ublk_dispatch_req()
      commit: dfbce8b798fb848a42706e2e544b78b3db22aaae
[2/5] ublk: skip 1 NULL check in ublk_cmd_list_tw_cb() loop
      commit: 9d7fa99189709b80eb16094aad18f7e492b835de
[3/5] ublk: get ubq from pdu in ublk_cmd_list_tw_cb()
      commit: 6a87fc437a034e4be2a63d8dfd4d2985c6c574bc
[4/5] ublk: avoid redundant io->cmd in ublk_queue_cmd_list()
      commit: 108d8aecaeeb52f5fbe98ac94da534954db1da44
[5/5] ublk: store req in ublk_uring_cmd_pdu for ublk_cmd_tw_cb()
      commit: 00cfc05cf81f58b1bc2650e18228350a094b1f6d

Best regards,
-- 
Jens Axboe



