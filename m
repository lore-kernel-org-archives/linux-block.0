Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBF63FBA5
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719526272; cv=none; b=fKMaRHoQrkLOKRMrUAj6GSNKW/owegXAKn84izHdXvOMtl1s2av2u02c7Ukb3vyMHuDfGU+PYoA5somOI+kRojRXfrYCC2yRyo6K1x/mP9QjViFJ8J9DyDAZRtZuBScPqAlGoTD3WZhSFq8eE2HizReI11InsUUa0a88oQlEcTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719526272; c=relaxed/simple;
	bh=EX9aKmROo4c7JTykDxscjYtpoG74oujWzENK0S/GbtY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AMskLIDIVq9Uv2+WiwW+CoLZria/S3C5fJODrylVScxMj49TVfbNxtPw7qj70/16T/GE4DS1WL4uMk0/5Mwohr29vj+42gpLCb1Udkyofq3w5+TAqpW2XU01kZDimmJ5ZNqcRFMNyrDpRuSx2q6ov+lXlwIioQuH3XEeLx9eNoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fOmYTlZX; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fOmYTlZX"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70675c617e7so3780b3a.0
        for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 15:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719526268; x=1720131068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5GFwm9HJor8xNvkgSFItuQKSYYaP3ZZ8yGVfphSv6w=;
        b=fOmYTlZX7goNeCk1TEU3kl24uqggWMeeT7oq/cqLEAls/uhrnnFMLU+GiASH9WVVqY
         CP/kaZkNuN8Ggtp4A7psfTZxYkqjwP02zizzkvcaZANYHgzMFG9SKNuvZ5EhhSiIL0J7
         i4qd9Tk6uLgIrIWzz/TziJJXIKEgfJ4Lq7HrEKUSEoMjHfoXje8H6lTGTwpDguToiDYP
         Z5JtMbfRUr5EGhmbG+RyINQg2VtYyhDIebLYLrXNMUYSpR7GGshsEtgqMAxX3fSLl28J
         S+E1gzfssUzRRWUV6wIHCyjBwcdHSphCdq9UJJ13Ig2NojKhBMa6j6GAGsdR8R5/rG3Q
         sStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719526268; x=1720131068;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5GFwm9HJor8xNvkgSFItuQKSYYaP3ZZ8yGVfphSv6w=;
        b=gRtsuMMlqtIrHD277qSRXL6vOt1LV1+1N1snzfmBfQxUz2xeVTH78/Jd/8IFOW4yBk
         3LXPBif6oTKlsEwKmaQfQDxu21ltr56lBQaB3OAq39oTao9ksoGXuP+McYUw8wugL93X
         O503KcgfM5KYrjICDuu3UhlsojfEfumoWGDTwGrdR94vb491kL59KRTxmfXbX8DouNvo
         Vb5m8rQv6pdcT8vR5JCeqah7RUDtSCtxd/xZGQSZ1Nk+Edd/SIZmxHBqEEs/KAAs3RHv
         CgidGlQ+2t66AJSBugBHCihOnsmJpXO4WZX3dOtOc+OQDONc8yS+PCTJoV+5XIHFmGrm
         VwbA==
X-Gm-Message-State: AOJu0YxsOLdjjMz67jAl3qBIW+hKJTWGah3YeaE6B9btGsr1PtNviyQG
	2xNWKe475xJ7dOeVPWMXDesD9FUcNCbQS0RUsFoD5UUukUxsQiVMfkWDlR8siRk=
X-Google-Smtp-Source: AGHT+IFUl3MslHmav3EUFv7d0OGnZ8VHPIYeWottgX6C8d0OfiFEQ8tBj7Mf7BiRIXxv3qMjKqj6bg==
X-Received: by 2002:a05:6a20:a10a:b0:1be:c7d9:ecd6 with SMTP id adf61e73a8af0-1bec7d9ef6bmr5393570637.0.1719526268056;
        Thu, 27 Jun 2024 15:11:08 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac156957fsm2513215ad.228.2024.06.27.15.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 15:11:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, hch@lst.de
In-Reply-To: <20240627160735.842189-1-john.g.garry@oracle.com>
References: <20240627160735.842189-1-john.g.garry@oracle.com>
Subject: Re: [PATCH] block: Delete blk_queue_flag_test_and_set()
Message-Id: <171952626715.874041.12006671061451213287.b4-ty@kernel.dk>
Date: Thu, 27 Jun 2024 16:11:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Thu, 27 Jun 2024 16:07:35 +0000, John Garry wrote:
> Since commit 70200574cc22 ("block: remove QUEUE_FLAG_DISCARD"),
> blk_queue_flag_test_and_set() has not been used, so delete it.
> 
> 

Applied, thanks!

[1/1] block: Delete blk_queue_flag_test_and_set()
      commit: 63db4a1f795a19e4e12f036a12a5f61c48b03e5c

Best regards,
-- 
Jens Axboe



