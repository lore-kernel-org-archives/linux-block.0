Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DB21AA1E4
	for <linux-block@vger.kernel.org>; Thu, 27 Feb 2025 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740700236; cv=none; b=ASc7n2fshjeYwdsq8Ac84k0BgXuJGBAoGSbZLqp7wXq4nrAs9FO7aQr2/gKyZDvzYgfLcDeY5gKU0JLGTnLQ0e0LJx7bz/z+FoEca+dhSh7u+qT8TEsslNZY8MxG6aB/w2F5mIeNt6Bb96GvvCL1NGHFB5GU5B+kPnYI8NPSxzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740700236; c=relaxed/simple;
	bh=5+iXgmLlQmW2LmSgyiBuDpzfwEE+8yVTlBsst65W1zM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLKd6yBbqVbopQiOZLMNvc6spNCPfyWudVt8VyTZTrRMpk1dPMLEcNEwFheCwf+wnbcPrIO3CeQcODA1iWsw5ipHuo2H7SVnG9BxpZf47sYz71599LPe1oV8t//cf0Gw0gEL/1zogCy5NcRZJ9h7GXQEMFz09kiTjIUPW4/pASM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nFTUKvGc; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nFTUKvGc"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso13188275ab.1
        for <linux-block@vger.kernel.org>; Thu, 27 Feb 2025 15:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740700232; x=1741305032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/MrW9oYu7MINLs/fTPWfiPiv9Pd0BlSPYSGo4GMsrr0=;
        b=nFTUKvGci2j1kLgKouJhNafbr9llxWfbrrdlFg/UI4BIZkcQMfWJHkUOQN5OOya43B
         14gW8Y+9a9kSDaAq/jKbah8t0KpTfmOq1hJ8c8WZFY/rBKlQtuNX09+rjSKANLwUkeyD
         6xi1EQdqTn/Kzg+fTmidVqsMjI7Tn1WWkkqVtEMrnaokI/77t1JG9mrB5FjX7OzAVO58
         LvVjWUAZ68wIfpPY1qhvRgz6e+1J3ugfoGTWRWBr1SbqOLMZKeOaYXM9cQyQ9oB9rFBY
         yjcJBGG7zv0k46ho3HzXovPcpiF9zXDg9g2DfkB/LlgTAYdDWogir261aPkeneobj7mA
         Jszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740700232; x=1741305032;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/MrW9oYu7MINLs/fTPWfiPiv9Pd0BlSPYSGo4GMsrr0=;
        b=caGvoWIt8NasoSCDoewavAeYHHkHXuNT7POqeVrXzuOI51t+gxJPZR2Z/QUL44rYL3
         udzfHrbkwqzEuUykQwBke8ABnhwRM7m4hjP5BOfnpvL1LPAxQfZL+V41A8vux8pEO824
         1PL3hCEEIO8OX/LXlF7MTUpvfxWKg6T6CSgf8c/YqSAeAJfV7R9FnQDcc4AWqqiRbNbS
         VrYtGsmFBkZ8c4v/oVqpmcrMNIJWd513u1dvC+Hx1pkPX5zinIy9a+Br+2nKPFQOVba/
         Z2xqvTKWupqGUQvcrrwrnGJXeHk76dQT0JQ9pqkgqJ+va+owLnOAM/rIWQnr32Ji0FH5
         Ob+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfl9JeAQmKA6AOiHo3SlZ4jJ4aLy9alaZsJCDYFYln0Lij1YIGIjAjASaFFmtXTaR5vLGGetZ5QtEKXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmM0PDEhqLbVC2CxonW21YWXH4Z0t1lGEuM6R086Ed5HbpRCjc
	iCq1o5dUtVixDeZkvhmViOgPcQWWMX4r54hTbj1DBZGj53BzvUMK1NJWogbs6lg=
X-Gm-Gg: ASbGncvIT2zIEhop0IIjZDVWArW32Z+Ehyfdjl72Dbk9OLrEi3YuNnY1mocuPzp/dx3
	2Au/p7Cgkbo5kCKpdQQ24OJc6fs2naZqUoVwsF9+skOOgAqsG+pBJ7boC85DCbXXY1zEFesbaaV
	ZQR7XEfRPheCpc5sJ4hvZqCHwq1ocNuZo6rw4QpDwmUjmew+Lc5Y13VqWdW/CWnToCGa7PC5vcV
	4TV6YGroNJ0UiYyhNBE8392+mGW5GtwHNQRu3MeHoO9iFedkNfWNBgUcZFGAjFiNtdFGL28+6Sj
	H1XflXwrxKQXpzOZmtg06T0=
X-Google-Smtp-Source: AGHT+IHSRlM3w45VHLLMK6HPiygexZv4dV4SqmsXYaIZxGsowPQTTGBfz1MH1pCv0maLCVB8fNpkuw==
X-Received: by 2002:a05:6e02:1a6b:b0:3d0:405d:e94f with SMTP id e9e14a558f8ab-3d3e6f51b7fmr14092215ab.17.1740700232541;
        Thu, 27 Feb 2025 15:50:32 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061c5053bsm601823173.38.2025.02.27.15.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 15:50:31 -0800 (PST)
Message-ID: <1855c57b-13c9-49fe-b7af-a277f8c8b2c6@kernel.dk>
Date: Thu, 27 Feb 2025 16:50:31 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 6/6] io_uring: cache nodes and mapped buffers
To: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com,
 asml.silence@gmail.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, csander@purestorage.com,
 Keith Busch <kbusch@kernel.org>
References: <20250227223916.143006-1-kbusch@meta.com>
 <20250227223916.143006-7-kbusch@meta.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250227223916.143006-7-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 3:39 PM, Keith Busch wrote:
> @@ -119,22 +137,44 @@ static void io_buffer_unmap(struct io_ring_ctx *ctx, struct io_mapped_ubuf *imu)
>  	if (imu->acct_pages)
>  		io_unaccount_mem(ctx, imu->acct_pages);
>  	imu->release(imu->priv);
> -	kvfree(imu);
>  }

io_free_imu(ctx, imu);

?

-- 
Jens Axboe
