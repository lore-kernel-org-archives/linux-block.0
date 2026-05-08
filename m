Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2865B3D8130
	for <linux-block@vger.kernel.org>; Fri,  8 May 2026 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778257170; cv=none; b=Nu8dq9aZnl51TpwG6sv02aUuVn0THKZKWKE4pGikPTWRlJ4/TuErvEv8IDkqtwnJXx5lIvj2MPAxBsSMjkYeBL3ljcuhcu0ckJZLpvlIleene1758lltpF32kED1BVBx0kjfP3ZmXYq7POh03jOa+K7Sbe98nvFgvyQOGOSwe6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778257170; c=relaxed/simple;
	bh=yz0aEdBoFQqGSJX0HiGqVgBm+sbHw/7SyJLG1RG1HoU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YQbMxxxXLtL/IisRbucGlpVdF+NRLMKRm58zPa/L8d/LKMpYxOtHLQ4ke6X6Cj42rixGURXPNh0cJ2ecQj/boWS3194TakPbIEhilwL6Q64u+/VZXd1TzF8xGtdKv/rSUV4PI6V7j3Z+10zCG9P8K5l+9Er9Rs/c3TB+d7iCC0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=toSvJca7; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="toSvJca7"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d55b97f358so1491176a34.3
        for <linux-block@vger.kernel.org>; Fri, 08 May 2026 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778257166; x=1778861966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upg31F/n2Z+rcKb9LE7KdyLW427RKKaAvveuxIXMB5w=;
        b=toSvJca7KyGlu56I9XPZdjm7sNQDAvWZ2s6+34Ig8IRTEC9le0Avz7dBYlz6R2/Swy
         6Oabu8RgKWohPXEsnUDRY52Gv9YjE1bbg2UcCHddI7PsnRiSVI4wORwKwuxJiqG7VuRE
         N3c7eITe/deEyWp1AAyZ+s5X3jrjgyM3tyA58EAq56fuTOGAA284ImYIxdJysoMXMnCz
         XmD61VdhsUoHQogjtE8bV7IYNVgp7HR9IxlxaXx2vRXkAK6hyE4FBYiu8BjCdkKlzS22
         n0wlOEaMDgalWmEWETXwj2BhzvAhHqB/7bFycAIYDvPyVjFkYViJvm8/gAQ/j9pJNwXA
         cE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778257166; x=1778861966;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=upg31F/n2Z+rcKb9LE7KdyLW427RKKaAvveuxIXMB5w=;
        b=mjUsUBIUCyGcC/5rB1sU2O4Zc3G6d2tQxpI2GQMyJgQrwxdhvFVmEL54TSNTbYBhMo
         sBgEeT1Ndy4h4MpUO6lTCeyHT1t2BpkfXINA2Cdo69/nWlH5575H23KeurCZgojUHJw5
         +4A7MOiaSz/OiLVg0rt0wdjL6dfMpDl41u2srplbCwnnpUi3sN9KSDmXagaw7VaUysG/
         mwUjOKCm2eWX/Luu11nibgYa4Y6mOfhY+o2HOMfObaTzDYEtm0C556XZwUAlHIv/QLRj
         T1fRtUSnKX2/LAYvBSHDCW3TSnoqjrwuQ7MRdAcZJOn4DQ80LLl8b6Fb5h6kXhd2YcCB
         7ivA==
X-Gm-Message-State: AOJu0YxPNRKQrVsv1xMTOcnIpa6+Iq2zHG++XZVDy/eqrCIZY42fOUCW
	NZX1N2nqAnucMyWOUwn1WskbNOku5QhwZXHSiaQqBIOAlErNRf80Xfi+O+7y/5el2yf5YGO5g9y
	pCw03
X-Gm-Gg: AeBDiesAOhcie4TGhSEOoA6CIMZ3+LzZqxOZeEOulw2xedPwOPjKxZr+6nGo/XrW/Tt
	HSTJt5WD+qA//8tnw01PYaS86yjfAv/WYF3uzKxi+YvgCe5+sk+3OoFqKDmJXFqMKt5sfuTgyuW
	2Rttw2HrjaBdIa2DfnfMnaOE+ROQlMRXQKxfegrsF6FfZqUk9QTsT6vhp9I8pbSe6GePJMiNvO2
	8Xgdd+bJ/H8tvBQwRxU9/hki2FTgigjHwlHLhDyL+SFg86Y6N3EqWbDzGaklUX5dOVu1bmp6XBn
	hg55bLw5V5QbNNL46QvAa0EZSFsqlq2Fe8mh1wfLvrjB7WAewLjC2VASEurnrMLrxZctTXWOdl/
	+RC3vVmBmOrTk/znIWUou6kAwf6i8tOkwF59SdpJPgv1qv82BdDcBYIT5I5Rld16v2zz7N1+c0L
	pnGrwENZkTcYCZBu77HR1tvaN0PyIe73XZuapAR1/XDvLEZoaFna584bHKQ39ZHor8bSSEqR18h
	Zq3uTUEYcFG49I=
X-Received: by 2002:a05:6830:2785:b0:7dc:e0d4:70c5 with SMTP id 46e09a7af769-7e1df1c99a6mr7589171a34.25.1778257165677;
        Fri, 08 May 2026 09:19:25 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d8ffb7sm1419233a34.22.2026.05.08.09.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:19:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>
In-Reply-To: <20260508123746.242018-1-tom.leiming@gmail.com>
References: <20260508123746.242018-1-tom.leiming@gmail.com>
Subject: Re: [PATCH] ublk: fix use-after-free in ublk_cancel_cmd()
Message-Id: <177825716482.321260.11080356571964047235.b4-ty@b4>
Date: Fri, 08 May 2026 10:19:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 08 May 2026 20:37:46 +0800, Ming Lei wrote:
> When ublk_reset_ch_dev() clears io->cmd via ublk_queue_reinit()
> concurrently with ublk_cancel_cmd(), ublk_cancel_cmd() can read a
> stale pointer and pass it to io_uring_cmd_done(), causing a
> use-after-free.
> 
> Fix by synchronizing the two paths with ubq->cancel_lock:
> 
> [...]

Applied, thanks!

[1/1] ublk: fix use-after-free in ublk_cancel_cmd()
      (no commit info)

Best regards,
-- 
Jens Axboe



