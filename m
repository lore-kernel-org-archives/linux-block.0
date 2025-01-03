Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AA51FCF5B
	for <linux-block@vger.kernel.org>; Fri,  3 Jan 2025 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735929908; cv=none; b=AZUknq9SvEyZTz2hws0vjCbUE906g6xmDb6EHAJP7Ws6ZrAgWsu4aUnmBxL51Qc6Yck9xOdRPsewe8QFwJx19jTwJKPQ7nzAwKlH3troUpvtXGkQ04UUuVEJqSJZoJutxBTL8/Sn/TDBuRCxupJxkJPYKxReJK0wKcAWeejgWqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735929908; c=relaxed/simple;
	bh=2e0YWJMlQEGzPtx9dzVLTteFmyqY7Rxm5spSQr3urlI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YnFS5Y+f/2LdfvgDcd8p1Zi02msZkJl70zNi8iBIlbxKaHkxDIuOHGCLRFOXUlpjCwK0I4Qu+RsKTmzuGklq9haXak0DkKVZ1fZaKGjxp/8InmtK8sXTEqwHzmrFA0YelrFAqNdlSYvC6TovW9HjpGZ0ZgoA9aBkvxiB0TYEIao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nc22skpJ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nc22skpJ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2165cb60719so177880025ad.0
        for <linux-block@vger.kernel.org>; Fri, 03 Jan 2025 10:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1735929904; x=1736534704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNzWV7r6QlE5J5hntqDG/cQdQm14gKFqlvsZDr4yzsw=;
        b=nc22skpJZ/bzfANGC7CgKSqPt2K6tRNtOl6JBUiEa2LVhljOmZdjyuxEz6afBJLePd
         6FG8x5PRYNI601FBEBJpj2DGVYY6JmHsV0Y7/7JeMa4BoipkZKEs9rbQrqddzQKMIsjC
         QjVqc/N2VfJfuOvxDC7rvPttrpmz0ZhvDVcQilg0VIOHVXOaiyR14PLHF8ZEuWUfV2IC
         ZOl0ZuyZQLDHtw8QQBmeXA43PjevbSTCuU4ulBYk4xd1zrKFZI0V1X3TrDcceLaOOzkr
         PXNg5fBX39EaklTLGo9K2UVZm+FIKe1yqWbL+CQOP4VHDBOrtRKguaH39v11p+k6WwZk
         Bhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735929904; x=1736534704;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNzWV7r6QlE5J5hntqDG/cQdQm14gKFqlvsZDr4yzsw=;
        b=dwZc1Mq17MlB1j/gksRHe3faH9hIuUCCXHkH86lh5cdv7cdW4FPl9HICdQVdnENgkG
         JPt4rNG18hx5ZpvTtk81temk33gRX0lx4uD1r0naEirX8nAreX16RFudfG0HMLrLUq9U
         lmx4IVdxgCCY+cmIBDS6oqreIljx2B8JuujD5xhb4Hm76WwFiRRlvvj9UPJF2iraE+/i
         6ogyAjkTqe0M/mHM995ANG8INv3nPlZOSFPUfN/gXVk2aXo/xfPt8h8qr8xZJ7W/sXe2
         /2cZsx3EDZApWgCEjTP370cGym0Wz6xxFGObXOwSUOcS0EFuFWvsbpJlSXniaTR6bd9/
         9tlw==
X-Gm-Message-State: AOJu0Yz/OZQlg7FD8CwAkSmmS80LWZV+54UVbgf1dCJKot8s7/rXJBJ3
	TIeAcsC5cKMng3v+nORdfFqfMRvIjmgz0clSnVAVj9Rxsi3VJn+vr5sDEGIqNiqSFoR02ZJtT/Q
	Y
X-Gm-Gg: ASbGnctwmelEeKzrDAakFQJAPGXyzEyk1Of9ZmaRlpo0slEgSggbvEUWruYq3nA45y2
	RRymVrt3JAH7gNloFsOhaYROCHgZ4rA0D6u14wYjMHMIT0gdXu9CJbgtfQSxItWzh2SQR7gRTO2
	1H5fMB9BiIIHs8RTelYZrrgHEXLDvaBDiaJ1i3jSvIGkvz6H0LZq6D/B+8SozOvwKXU1f4vJViw
	lAhW4uG0rQ4g7GqCoeZmAjDa9JUuXR/nr/MwpMXBPiNZ336
X-Google-Smtp-Source: AGHT+IG+j6U5xg5Kjxuv7DHaKSkKpUO6IpFgfSkogVagQ4AXH7ohNpnKD63glTSBPv6nABV7yQfOsQ==
X-Received: by 2002:a17:902:f681:b0:215:4394:40b5 with SMTP id d9443c01a7336-219e6f0e622mr710948065ad.43.1735929903892;
        Fri, 03 Jan 2025 10:45:03 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f6951sm248655295ad.171.2025.01.03.10.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 10:45:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, Yang Erkun <yangerkun@huaweicloud.com>
Cc: linux-block@vger.kernel.org, yangerkun@huawei.com
In-Reply-To: <20241209110435.3670985-1-yangerkun@huaweicloud.com>
References: <20241209110435.3670985-1-yangerkun@huaweicloud.com>
Subject: Re: [PATCH v2] block: retry call probe after request_module in
 blk_request_module
Message-Id: <173592990256.170261.11603243277598977825.b4-ty@kernel.dk>
Date: Fri, 03 Jan 2025 11:45:02 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Mon, 09 Dec 2024 19:04:35 +0800, Yang Erkun wrote:
> Set kernel config:
> 
>  CONFIG_BLK_DEV_LOOP=m
>  CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
> 
> Do latter:
> 
> [...]

Applied, thanks!

[1/1] block: retry call probe after request_module in blk_request_module
      commit: 457ef47c08d2979f3e59ce66267485c3faed70c8

Best regards,
-- 
Jens Axboe



