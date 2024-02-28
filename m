Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321B9157E9C
	for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130148; cv=none; b=gjJrYcFVBqAH7dL2w3LcKdV73vydP85JxtTrj8JGGU1FVWpvb6qwJOb38xMBIVJvhutnMLsf2lIuFo9jf6dk7rcNcGyDpZBSjqoTEVO277iWOXtcCdjk8nYqHEiTbBmObas+f2kXyY+g4KtPfnfQ4wc58vgzXtWS3hOWkmAYLVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130148; c=relaxed/simple;
	bh=OWxzfJ4Cx4Zq1b/YQYPtpK/GpJEEIDQXMs7+HO45ze0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YeJ4X5zGuT3CDJyvjABN/WO/+abuOgWgmA6jAYzjZG1zgr5bt7axdes61ddixFub2Opde8aVUxDQzgz3J6n7jgTfQ7KeNRsRE6jcT3Wt5Ldzkn/qf1K+nf4YsR0/2Sc2nKKgGupuHbpjya9c/brw8B9d8o9r/8etXO55pjQ8GcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZNb+dTuZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZNb+dTuZ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e555d6adafso80440b3a.0
        for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 06:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709130145; x=1709734945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXBbRw/kuY1Rx/1FaqjwOtMNC3Ij1f/dIXdDCQAwBqs=;
        b=ZNb+dTuZKeO9i/Htn0aZ5CxmKJNSQYrE0yFH7nYOcQ6cgh5gxSBSEPtohV+6a4OARl
         xbUz9hfKakliJTSb8ZPFbA1oHOv3UaO4AlSkJ0GhrbTuc/zYN/08QfljKpIVVQY7vbbP
         WUiXobhoBHttM7KTIGOkhMUUjG8Q9oO4xSmY9HCkrkrMSIcik4f/IMcQonmh7EYT/UgN
         aAniOJeuI9syWDUx7LE9M33NT4m1eeNnbgSHAndLx8QA6Hq8tmj8gWLhDOLYDFEdQaWE
         m+ShXpjYwzaMNkshc2/kBMAbtc5TMNxbsi7eJ1918um1uBR/zDKfmEHZAKtVMgcswf64
         NzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709130145; x=1709734945;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXBbRw/kuY1Rx/1FaqjwOtMNC3Ij1f/dIXdDCQAwBqs=;
        b=MjNjAIsnc2dewCix0tkQnfLsf+9sL2ha3EtTTrLJrwtX/37k3yFtIHBAU5VN8dvVk0
         QJLYzFxDf5jsUsO2Ci3Y4/R0zVydkA4ZCkV85uWOaCU/yRIvxHJTEuhwaWfaG6QyMbhA
         I2s1TvbEBGJaJa/ZvWpayW+KyCr5BTO9BsXO1A4Z/UHME7GG4xG6AjSpWLnT38pWN6tn
         FuheAUjKPOnPq9+ArFcPhRTy4G3Ln1sY++X0nFZzPiMJRBxcNuF0Oy1aN9ZI2LZE04/G
         fThr1cAJJb1qaIqszFHHmJrGLemli8LPIiHVxd2eQxNgWcZhC/kxkRlMigzfXmGrtRHb
         8i8w==
X-Gm-Message-State: AOJu0Yz9EUaS5dMZOj5G8/EEf/obuT4dKvPTeNn/29D9nVNfOsRyk663
	fTa1ckP84r/IU7rkfhKOU2sQwrDI/pT7aT1RUZIoLxHWDnm5uSzerSV7DrwCRqVKEvA+YS+Vwjn
	Z
X-Google-Smtp-Source: AGHT+IGhGnxugQhFKueYLCNcvhGUaE8pAyATg+NwLykmIr/kx2GgEuHq+lwQSd1pIQNcQ2SZhNHd+A==
X-Received: by 2002:a62:e303:0:b0:6e5:708b:d811 with SMTP id g3-20020a62e303000000b006e5708bd811mr882659pfh.1.1709130145005;
        Wed, 28 Feb 2024 06:22:25 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id r5-20020aa78b85000000b006e4cb7f4393sm7842218pfd.165.2024.02.28.06.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 06:22:24 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Wen Xiong <wenxiong@us.ibm.com>
In-Reply-To: <20240228040857.306483-1-ming.lei@redhat.com>
References: <20240228040857.306483-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: don't change nr_hw_queues and nr_maps for
 kdump kernel
Message-Id: <170913014407.169596.7112362264029827538.b4-ty@kernel.dk>
Date: Wed, 28 Feb 2024 07:22:24 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 28 Feb 2024 12:08:57 +0800, Ming Lei wrote:
> For most of ARCHs, 'nr_cpus=1' is passed for kdump kernel, so
> nr_hw_queues for each mapping is supposed to be 1 already.
> 
> More importantly, this way may cause trouble for driver, because blk-mq and
> driver see different queue mapping since driver should setup hardware
> queue setting before calling into allocating blk-mq tagset.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: don't change nr_hw_queues and nr_maps for kdump kernel
      commit: ec30b461f3d067bd322a6c3a6c5105746ed9bf14

Best regards,
-- 
Jens Axboe



