Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0A531AF37
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447560; cv=none; b=jbs/SwHKZpTMYIB8BAq/SV8ZKhFJZibKv/DWqmW5zZmZnEBlxM7vPXs8rCxRfks+qKwqncTy3Cw3kf6c42g6+jLg3wLLejg2Aa80V+7KxZeKFYFdGslmqEvWodwxZ1QukGTMnTb/8BjvoK+mWUaDZl0kdPBWJOiP7YELrN7kWlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447560; c=relaxed/simple;
	bh=wPVpg0XuqdKGcb3Jc2tIdMZ8FpNDQWGxENFEVQ2G2UU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i2tYolU2OFv0hcjqtNptfjXmOTielgy8kN89pvbZux90Ybdowy2iVm/eqnQ4sFTV1CjCRnoK/lSVMrNAZKrWlUPcbygn9GOi7cgHcb2JJB79EGy888XQvmlVCAKK0LaoKQxFvU9+XkdExwOdA7cY4p5sp0YDYnweRL1+66iMcls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vkv8Z3yF; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vkv8Z3yF"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-92c4adc8bfeso474805439f.0
        for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 06:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1760447557; x=1761052357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VS5Be9yPc+7WU6uXFWGGZsRUoddSQqWhILzZ+pltJMc=;
        b=vkv8Z3yFU3UXnJpIXEP69Iq3W0jCOaG5zxh3jiXRsZAqqmo4RxmJ2D6Kffi54APoEC
         QAjZMuAc7UOKPAH4OWhmoJC5egR+SbvuHTOMjPnmu+RI7pbgHi5AFbhhp3F4ZrWxIuvW
         XR+PYVkZlprMuSa03zZ2GY3GFCg3ijQ96TISjBWIkKLP1Ql0h4UxJEJs+FiLLqa3PvnG
         k96TiKfTnLu62wlN/1+vUch0xNPShkL6M3O+bk2bzIidjajjEzP3TbS0Ins9Mnc2F6LH
         lTE9Rtakqgnk9RGBFd/I6rP09t7oP0N8UC2rA9oOGM/gER+926n1LPi+5IvjUk7ude+Q
         kGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760447557; x=1761052357;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VS5Be9yPc+7WU6uXFWGGZsRUoddSQqWhILzZ+pltJMc=;
        b=a5tRUwQ+ye6VKGwp/xiygFnjl5m2K3UQGYLhUb1/WArYOYc6h3boNyaLqbhxwKdmYd
         fn7T3BrZmFM2/43kStK974vKwS7NPT10pdirenVP3D2OQ2iR1ZOaTuPhiSq92FN6d8Af
         F7CDKU4GVKHkRmXQo4DST7kjqW1OAi/9hMaj73qtb81A056U/XxNYDnvxe9JaJx7GuOR
         u/RId6nmwPsrfQeHYLovsqWY0C79xrwGVk3xitVbM2/FovHyHY1zopiwhtspLKoy2qCB
         NPnHzxxQ41QycsfIvoxr+pZtzZpa6Gs7LB/UxKOLLIo2/3k2FEPk5/9WCSz6+3G0WYd7
         clZQ==
X-Gm-Message-State: AOJu0Yw0u4xEzrm1aXKntewt6E+tqckcKBd+7bkyI2shhibKQuar1nTI
	Tv2TcQCPWJaspjDhyDV+6A9ttxJNyS1VtVs/hs7jUz6PoYT506CFDIfwz/zdmdop+7xJ0fyFkua
	OyTwAXYg=
X-Gm-Gg: ASbGncs5M9nCToW7mBGzsPAO37z7HPqZOBo6reUdJTkz4YCQXyThJ4L6jAjcj++JEmr
	rYrmcj5Ej/NUOgqVkKbpV9AitaJTHZJh2+8BF0RuvNLFUKx0HT+Eyb+IytbtWolZz+awj5NR6mu
	9ytSGQVPObT7Rp8j4aKYmgU3WZI0dvGtUUwjqbp0+veS+FhSknDtM92K66GTqzeHSk7MWNFdHFn
	uaHCLxI5lVmzVfS+Zv7S6DdqCrv6zg69etFw6Lj5MZ2e7xtbYAtdr1WFYIdN9D+DeupHgtF8Ige
	xxpzQ5G2O+YMs1MPknpP9AvLe5AkndLxsivgJ1/GGrOES2tZi/G1wOYg3ksI9BkifC9FPsFA3uC
	qkGzxYQu6VUDkPP8/VYgVqYPpVmXxw0PZH0StWEI7+lKP
X-Google-Smtp-Source: AGHT+IEzfAq1f6vaItvXUtyUwlw+jUWrtjFtxvQsG/dBK8zM27vR+ylO8U/SZzNQfFkCmBy5xOW0Pw==
X-Received: by 2002:a05:6602:2cc4:b0:93e:32ca:850b with SMTP id ca18e2360f4ac-93e32ca862emr1257992339f.7.1760447556867;
        Tue, 14 Oct 2025 06:12:36 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e25a39134sm484423939f.12.2025.10.14.06.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:12:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20251013192803.4168772-1-bvanassche@acm.org>
References: <20251013192803.4168772-1-bvanassche@acm.org>
Subject: Re: [PATCH 0/2] block/mq-deadline: Fix BLK_MQ_INSERT_AT_HEAD
 support
Message-Id: <176044755550.107826.7770170204307889174.b4-ty@kernel.dk>
Date: Tue, 14 Oct 2025 07:12:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 13 Oct 2025 12:28:01 -0700, Bart Van Assche wrote:
> Commit c807ab520fc3 ("block/mq-deadline: Add I/O priority support")
> modified the behavior of request flag BLK_MQ_INSERT_AT_HEAD from
> dispatching a request before other requests into dispatching a request
> before other requests with the same I/O priority. This is not correct since
> BLK_MQ_INSERT_AT_HEAD is used when requeuing requests and also when a flush
> request is inserted. Both types of requests should be dispatched as soon
> as possible. Hence this patch series that makes the mq-deadline I/O scheduler
> again ignore the I/O priority for BLK_MQ_INSERT_AT_HEAD requests.
> 
> [...]

Applied, thanks!

[1/2] block/mq-deadline: Introduce dd_start_request()
      commit: 667312e1c0c091bd6d62cabd3d6e03e0a757d87c
[2/2] block/mq-deadline: Switch back to a single dispatch list
      commit: 2f52aa87a0b7da80f50aff13904b82d24171d1a7

Best regards,
-- 
Jens Axboe



