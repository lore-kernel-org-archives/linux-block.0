Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A43C10FC
	for <linux-block@vger.kernel.org>; Sat, 20 Jan 2024 01:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705712932; cv=none; b=KorqUzSZ07VaizJR24Jsy1vk4LPq08TpeqMUN4oPOduU42DH0iU9VBJ/jxy5gYP4jpb8hmK7KdKBFvlP29frlGpXW3BwSypG/VdUV23K+URyfxnOK/bFqmDc1YYVHQn1P82Ljq8oHWStqgNmtAxYfRLOzX/fSNNWv0B5aT9V/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705712932; c=relaxed/simple;
	bh=lZQiNZgacSuuVY81zUxInYKxrcCFl6nLvZFElxAfs0c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q+FlqquUd/9hIrJFeImfeK0b0FyevEwOLwF2yHtt5/Y4qwHNX3jw3OXMYXQpWapYCB81crTd5qDWsmsAO84Kv/9yhT3xjbfDR78CNgqJ7p6H37eetUbXyYZ+xw3ua5TpMMIpuIGxFgTh4yd699/+2qAygNRbX11ST4jJkIqOHKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Jj8Vv4fv; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Jj8Vv4fv"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d9b760610bso267392b3a.1
        for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 17:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705712929; x=1706317729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQpMBDa/SGuSKIQdLMIHYKIk+tXCd6t4BBAUn2QqMSU=;
        b=Jj8Vv4fvjgzXEl/bjXPvlcWAYOqrbUmo/VdthNNJJqnkrRZxUZwZM6jbZlnFo/raUk
         P1aOW1+kzAkUcfhYZToX2SIsk8eTJQ7TEQbTZSl4fmfZ/V0yvJUk47g61AZ3ncaE9ZxE
         L1sVk8nOIPjH6pwxk8ra7GkqP2inopfvZEotbqetDuhRsmuDeZCQ44S7Ybl9xfkJcRyA
         ynGo0Jl47Y+cIORINgkaq3zewpDXNNQywKrB6zah7mXOPV/HQsRe7qz7D8Gcw2XXpGfi
         7L2ysuPAnzVptUSa2yVZY9ejDwFqfEG5s9OpM8jYK0zhIRELr7jmK5kjdPNvkZIYvSOw
         uOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705712929; x=1706317729;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQpMBDa/SGuSKIQdLMIHYKIk+tXCd6t4BBAUn2QqMSU=;
        b=QsnhD3ZxfjKackCwW7c0ajkzf+mVYjxdDvcPRTblKvZHwX5bBPMZLwJlMNOreBEriG
         zsyI/hHTkFteCCCtIhUvfUvlmvUls/qLVCoaA7xpq+sRnIQem65bTFDGbw7bc0X9V2j5
         cBG2NCPoDNKNtWFQQRZXuSpj58HO85i4hwUhJFW9A0Xca/dIOseoymk6CY/2/vgo4NB4
         oEb6CNaahqKSFar+jNo0Ir4w6VGq3ED7LsipCrMmHWaS/hyAr4CUN4Apn9DfWMR4c70l
         ZQdkcJYdrI5N+myL4UiG3nvwTHuRvmGatRTAGtvqDZ/d9WYLQoJOcTrRPhAMzcn5G6eJ
         0UfA==
X-Gm-Message-State: AOJu0Yw926cNf8ipc94wWO16TPLw3+1FJ9/7l3B683cKiTaD/rclhJGU
	SJFV/cmyrmMW3PAxANaQvNj2Hj90jF4G6FXEXpTgmpwLEAXtEOE2C+z0ps+oLLzvClhzzq0R0yQ
	gSXM=
X-Google-Smtp-Source: AGHT+IE4vLPx8u6Hcm29S+YPOOx/pehQuvP9uVQgYFebkkeXDmYjGuezIkqhGc0qBOC3Wi6QLelqIg==
X-Received: by 2002:a05:6a20:43a1:b0:19b:7147:f7df with SMTP id i33-20020a056a2043a100b0019b7147f7dfmr1486502pzl.0.1705712929265;
        Fri, 19 Jan 2024 17:08:49 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id fn19-20020a056a002fd300b006dbcc97dc7fsm338162pfb.95.2024.01.19.17.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 17:08:48 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: allison.karlitskaya@redhat.com, hch@infradead.org, 
 yukuai1@huaweicloud.com, Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20240118130401.792757-1-lilingfeng@huaweicloud.com>
References: <20240118130401.792757-1-lilingfeng@huaweicloud.com>
Subject: Re: [PATCH] block: Move checking GENHD_FL_NO_PART to
 bdev_add_partition()
Message-Id: <170571292805.1346839.6434955686837656985.b4-ty@kernel.dk>
Date: Fri, 19 Jan 2024 18:08:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 18 Jan 2024 21:04:01 +0800, Li Lingfeng wrote:
> Commit 1a721de8489f ("block: don't add or resize partition on the disk
> with GENHD_FL_NO_PART") prevented all operations about partitions on disks
> with GENHD_FL_NO_PART in blkpg_do_ioctl() since they are meaningless.
> However, it changed error code in some scenarios. So move checking
> GENHD_FL_NO_PART to bdev_add_partition() to eliminate impact.
> 
> 
> [...]

Applied, thanks!

[1/1] block: Move checking GENHD_FL_NO_PART to bdev_add_partition()
      commit: 6a1cf2468a9ba1f56de7478ee6ad0d54e0aa821a

Best regards,
-- 
Jens Axboe



