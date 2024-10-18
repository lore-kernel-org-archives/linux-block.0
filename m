Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B9B2022D7
	for <linux-block@vger.kernel.org>; Fri, 18 Oct 2024 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729276666; cv=none; b=MpD0Vg/Vye0Yy8uj8d2Zj9BhwV79R4fUoRqr6p6Ngwmm9UFnAkUYEn8eUeKBXyc4rcx6tWGStKMJpQEGLiHTJEKnoBfDSZ42XSaDh70NfQiXeBewkKFyvWeoslXALThqeYeYcwv755idHvlNDQR6u0Q1r44AIE6w8z7VX/BwBgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729276666; c=relaxed/simple;
	bh=z8kDWqhG2fmnZedjpf541nKe3HliQPz2iUenl16evKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMz4BxJT8lJQ93BCQcvTdBULkw2GzrtZwbUWNU7gpawMQYSwdn7woMRtS44Fh4vCod1m6ZkuX6hFUjohvJkzjxk8PMeujMqISWOFhQ0y2BjKsoDvziL9qsL8lQPDyfGUvTSg+7Trmk+npPrfLjGFScp2NYwX0oKqabZjnZ3oCqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GdkdNWiM; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GdkdNWiM"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-83ab94452a7so54046839f.3
        for <linux-block@vger.kernel.org>; Fri, 18 Oct 2024 11:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729276662; x=1729881462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r55aFScCQCKYzeuHI9JCFe0M0hPUYU+7y9691CsGG+E=;
        b=GdkdNWiMXQhPQ6vVuxQnIEwkFTnTcFX/VqL13ys8Pnv7L3Hq+GvOHjNtJB65jfkPjt
         A9Tc8n8GP8DFplVx51ZETbEbSFRxAf2KuqhSIvrewFbYoi3aRi9yyvbaP4PP3/hm1IMN
         qeTaBIRL4xBDlLbfBxSoWetVbJRVNtxQHuQq+24IYhXJWy9mUFI/7YHF8QK1BVUYh4Dc
         B9nymh0e+Y+KJPomEG4IEymNoBuLfUlTXps1HFvU1wYGgJpB5hWY66uNpHnOUojPz11f
         d1rj0MgVhlpLiq6mYta9D6tHDH1WVfUW1DuEB0JZbgs5oC3pHEyu7niK0PHZKEDQnbBp
         sN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729276662; x=1729881462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r55aFScCQCKYzeuHI9JCFe0M0hPUYU+7y9691CsGG+E=;
        b=VnCqLysUZKFFqrt1yWEmT/j2zMFZAVHQ2XKA0gA3j/rVLFUqiKYBtQmPerzMdOTVQf
         K36VYho+dXzEVEkwSIyhEzVI68bKmTCIO5zFRF8hSne5CTTYXXJp4UElgFfwlVe4lq/r
         MAWyp0nzYqYkUe8POkug9l4sx8YQZGvOnev3fT9Hoy0WUnPbZvfSr3g7z0YK8hGOJn8Y
         bev4GtgWI4IOgR+99g5R62FiDQxZTQ8wl22YasFK+U8oDNFQdM7mp19C/VKM1MVOEgrn
         lqk0d0wk9yporovM6gwPdhqXygeqvYRVQoio+xe8E6kkKX9PVhLDMm4+Ykw9uR1IwuGL
         aZkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiyfvsGRkduwTyBh4Hvbj61nA0959hrMgebjwaL9eYG/IaXsdheWW3O033jdNz0hZU4dg4NDlesV5MaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2QR5bz0Ruv6i+A9ua26MV7OfsxTGigCBFnjtKfPNn95nUaVbK
	P9VBJw/DXzdrkOZ9mqIo8q2JxKDaGwqEhJIu7aAMQabOjcAGpjJqBPiFf08Xf8s=
X-Google-Smtp-Source: AGHT+IE7JQ6o6nHEPPiVQjaZeCUeX+uAosWMPjbh09es2FKmyiZvmZCyf8gQ5l035yHNKtbpYhbRJw==
X-Received: by 2002:a05:6602:3fc4:b0:83a:97e7:8bcf with SMTP id ca18e2360f4ac-83aba649c24mr274489639f.11.1729276661935;
        Fri, 18 Oct 2024 11:37:41 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc10b5b0e4sm550282173.11.2024.10.18.11.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 11:37:41 -0700 (PDT)
Message-ID: <17db11b6-16aa-499e-ad2a-da0575aaf334@kernel.dk>
Date: Fri, 18 Oct 2024 12:37:40 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next] nvme: use helpers to access io_uring cmd space
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org
References: <c274d35f441c649f0b725c70f681ec63774fce3b.1729265044.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c274d35f441c649f0b725c70f681ec63774fce3b.1729265044.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/24 10:16 AM, Pavel Begunkov wrote:
> Command implementations shouldn't be directly looking into io_uring_cmd
> to carve free space. Use an io_uring helper, which will also do build
> time size sanitisation.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

