Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DCC28937F
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643059; cv=none; b=jFLS1XiZ/DDGzjMMtDbFkSOoDo9DH07hnSMsy7x2BpjpZx0EL+0gME6d9np1YIgdOu209BgF5lu0UP2sfTKVa2wUugfxF8kDSRy3ursVwBMsncMKD2nymh/+uzG680FMtxKitS3lWNh6Pu17/az1mFvD71M2wvpMDv/ARmOIOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643059; c=relaxed/simple;
	bh=B3bBoKA1Lbhi1Cld60TcHrQLpRoP2XQUZxloQ5m3jN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHuMHAigEGh/NxtG8Pk/54x/WIjHzhcfaNJ1dOAi3UwbV/pZfGmChOkEIlEncDTlrB1x/yWX1d9IEGZVK6k/BQJWtuEabsoBClyYQQni8TThVKdoW5KfcIMqiy4wluUa5UUpLwQEKeUzffh0ROs3qNUY77Z9MTBwFzO11Fo3ddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZWv1xiGQ; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZWv1xiGQ"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-864a22fcdf2so9678139f.0
        for <linux-block@vger.kernel.org>; Wed, 07 May 2025 11:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746643054; x=1747247854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TEcI7sDX0OWA6gk5yPVb7rPX7fg7OI5cS235CBI5z60=;
        b=ZWv1xiGQQxY3+Dgxff+KLSQYeiCxFbkPMhtWkyGtqfwpffIaD8+Q5MwmQY+6u8ILjQ
         JnFEM5ZTdl+uFqkPN8CPVxunlrntzrw+ibbqmXNgsGVqB3p2LixevlGH+S2JgL64Jisv
         H8GJLo9Mx6SKvSc4AjoKpEeUErhoxeK0kEB5E69XmitDAOf/VYSinN0GwcoGqfmqtVYp
         hjQA5gyJCBALH1aW2Oxgeb4Z5g9ucltn3PMEi0bciq8+sWpIl41RftGwhX27mpB320jq
         UTNeQjFiA9Pyoorv53MrlSiEddexGM/ydx2EbqdIPLnl9SM+f1FfrCcYtc0CBuLoqX0b
         WkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746643054; x=1747247854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TEcI7sDX0OWA6gk5yPVb7rPX7fg7OI5cS235CBI5z60=;
        b=YXZJtGyqXPIiwiRwoMYP0cxtYzywRupJsPQg2yHXf/KzktXoOz9Yhdr8REasxu2152
         q5q+Z+06qorA5enmEiT521D3s4fscQWhk5mdP8Q/YBj0gT3ja5WuPmQcLla7vkWgHsE8
         zENifat1QQT5ZX/CZ9HdakY3JbZlXHbYYdroOPbp8q0ounuhgAQF5DRHNkrE93qpIeiz
         NtddkniGTmcP7z5CYP4/MkBeuQ+nDGncjHIPtOE+vMArbQQg/ua8pKvkX/H9bgFXlA/Z
         m0Jfub0aioMmXt1UhW4dDzxFMyQsiTVqJuPbe8V9E1zbJ+dBrWdHbEVf9To7nxC5EuwV
         QiJw==
X-Forwarded-Encrypted: i=1; AJvYcCUl8mtidruw+HUOi3g9e/C6SZsnVPDx+LrnCByvgXEQuSB/3kp8RCBb6A1lphJfcvVIGzqVOxZxuQwktA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhIDoOlOCdVXwkaOPMn1nmoAOhY+m9LvlWzO1PfxdAzGMMKRvD
	Hej6gIpMPodA48NVWOd+qjfydTtKt00wizPcPDFj39zEQo1MjmL5G5/L6H01/qM=
X-Gm-Gg: ASbGncsMnMP2FnIL9joxl75qacSx3TvjGJkqz9SwzyKFUgg/pYAUxhwVsA5Em40zK6g
	Lk7bA91PQMlW1bchRrzkkYlF0HGYy4VNriOscvcW/ZGvSX9WbEqs1epRcHNoQSfcDsiKX6BicOY
	Y4i8hvpgK2q17TVREMOZhAl//s74ogMSqgmpWuA6o93lzByCINiUiIYPPGYHrOzPQwg7zek56a/
	SZALADZVqBe1qNxHZePOK60dNtUoiZGzemG74QKEOwI46OyVIU1Ua8QeFm1yAwcwAgWnBJM9zxh
	gCZ/N+RtsJSkO4OQCZ5SvpVMJG98itVLWMmOLE8K+fvJsF4=
X-Google-Smtp-Source: AGHT+IHmhzsaM3dtqXyTjAWLIJ/GqFxmnMQ0emMAew6ONSaSkY4xnPFzS7leVgfuOfhwElDFM5ODdQ==
X-Received: by 2002:a05:6602:150b:b0:864:a1fe:1e4a with SMTP id ca18e2360f4ac-86754f9a09fmr90482039f.3.1746643054533;
        Wed, 07 May 2025 11:37:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-864aa585a1fsm269038939f.44.2025.05.07.11.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 11:37:33 -0700 (PDT)
Message-ID: <c74d4b0e-0c2a-4990-815e-479db037d4df@kernel.dk>
Date: Wed, 7 May 2025 12:37:33 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: always allocate integrity buffer
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 martin.petersen@oracle.com
Cc: hch@lst.de, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20250507153759.1199895-1-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250507153759.1199895-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 9:37 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The integrity buffer is mandatory for nvme formats that have metadata
> whether or not you want it generated or verified. The block integrity
> attributes read_verify and write_generate had been stopping the metadata
> buffer from being allocated and attached to the bio entirely. We only
> want to suppress the protection checks on the device and host, but we
> still need the buffer.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
