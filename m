Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D912A25566
	for <linux-block@vger.kernel.org>; Thu,  8 Feb 2024 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417173; cv=none; b=UWiSfhLMwsjhf0hwomObO+RB9o8ZxKXiB/8JISWIqdOeiWuRUd8qHImuvgAJeLgPbMUMPBzXA+ARr0tUohHiFBRkZZSGXUcK+7ySnOjPBR38/2QXJkX2UwGVSVFGaYXMGOnuMV+rtjxcJ1gkB+fwPYy/wcYPZWIAGMTiNuK7eSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417173; c=relaxed/simple;
	bh=et0/tcKqv4OjukO/wlzilEs/NLE4dHHwM7paCdfbTwo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Cer2soSPuJINQC0hRMNVnZVX5axTnFD42AIIcD9dwthEFoJvOExAK868n3cuBSP0WLXv5xZ9N/djEDICY63B1QfndAUaPEHZgllk41/+/nn/rLpXE2bpkMgF7R3PVR7zzI61bYu4Ea6sa+gOqXcW0cu4iu0phrA10C/Nk3ITaDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UDqOm7CC; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UDqOm7CC"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso755739f.1
        for <linux-block@vger.kernel.org>; Thu, 08 Feb 2024 10:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707417171; x=1708021971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AMYCnkNAeWqR3OZOrLtWcFnZIPd0BbcDf6ZXB/5DiE=;
        b=UDqOm7CCSeEYk34dWxJUiXxYnbZ5GucK6poKy1j4pLTGpuVJWotaUTbE6v/dkzwnkY
         Ra7dR6Trm4XDA6iUgJxFxytbYEsi9aqbgWX12dGBJQQ41GxJxII/XCh7XSAz0LeQwZna
         OSkQOabqP2QzmLMJVno8ODRuCC+fgX4FyDbwXeuZPJRmB7k/7zZiNgfvMLv7uMR1bVgt
         I3wSReOR2kmLBNqWSk1z81nIHx1ww80VFpAU+ncJ1ac8F78OJpcUUqsajz+d6gyC2PN2
         JgbFnRnmQ5Y4I4e1BLau2dJECeTdXbEcgmmyrBKd5ABeXKiSQIKg0k9IUfZUl3h76gXU
         qhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707417171; x=1708021971;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AMYCnkNAeWqR3OZOrLtWcFnZIPd0BbcDf6ZXB/5DiE=;
        b=g7L0NOAZlk5hANffMc1aKEPI3Or68JQVx/TdFpvCxwkGyPn6ej4/kLGHDxNUQy8Bf8
         FUJt8QrT/VfCYNbg+SxvS0WpXaxwWiHq6eRJ0F3M8tc+E0z5CVMx8W2Sf+z8tzTT9JaH
         EXKdV9zPxGD3rvGNhneDrYM+nlYWiwKpc/c/2Fz1H7SfUXoRkt3JuAiNEt4/VYAiHN3E
         A/DQA4pvQRHSNhcC8xQHzV86T09/T0YTYU51radHMvfDbl2MSSaf4WX++76FrsEG4MQL
         y5BenGACgO/wC2aOCQD+Kxob35l56xPum8NB/yQJciALUaDiiV7C4CZjDN3551+U6lSl
         94NA==
X-Gm-Message-State: AOJu0Yz5GR6e+Fgpys5Enk6VCnWlu0jepfom5do6mf3VY/fwhh/CABN1
	5joA09aXIt70Koj+PcbnXo1k/VrTMxEo5oQgPnwm52qcDsNavuv/T8OCHjqQfyc=
X-Google-Smtp-Source: AGHT+IEP5En2kvqX46Jkt9st7Hi7arU8KkVgrl8uEuqgwi8cDOknhdvB7B5Sjg1wTD8cubvn67jNXA==
X-Received: by 2002:a6b:dc1a:0:b0:7c0:2ea0:b046 with SMTP id s26-20020a6bdc1a000000b007c02ea0b046mr453669ioc.1.1707417170893;
        Thu, 08 Feb 2024 10:32:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0ef+rIZK7uAZMbywMxiTQ477OE+BF+n8ftmFZfNroPnDUSx8NbnmmFSoTGjDCgasZHmOA4x5eaWvwYCfXl3jOexrWt78t4Lr8Lqw=
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t13-20020a6bdb0d000000b007c3fbe781f2sm50823ioc.5.2024.02.08.10.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 10:32:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
In-Reply-To: <20240130042134.2463659-1-shinichiro.kawasaki@wdc.com>
References: <20240130042134.2463659-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH for-next v3] null_blk: add configfs variable
 shared_tags
Message-Id: <170741716951.1391883.17733703768547012457.b4-ty@kernel.dk>
Date: Thu, 08 Feb 2024 11:32:49 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 30 Jan 2024 13:21:34 +0900, Shin'ichiro Kawasaki wrote:
> Allow setting shared_tags through configfs, which could only be set as a
> module parameter. For that purpose, delay tag_set initialization from
> null_init() to null_add_dev(). Refer tag_set.ops as the flag to check if
> tag_set is initialized or not.
> 
> The following parameters can not be set through configfs yet:
> 
> [...]

Applied, thanks!

[1/1] null_blk: add configfs variable shared_tags
      commit: 14509b748ff58df3f0980b1cd70ade0e4a805e99

Best regards,
-- 
Jens Axboe



