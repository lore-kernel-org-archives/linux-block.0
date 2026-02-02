Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3C4367F48
	for <linux-block@vger.kernel.org>; Mon,  2 Feb 2026 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770041046; cv=none; b=t4kCn2Fsj2Dbfdx4b+Nh4zqA3Z2H+vJ4yuVBJK1CsHAdiYcjU3dwG3fKN/H1Q04ej6TjHANB8Q6CbljXaWKZPPzVLGZ0bm7u9oEffR4NFOgn66tG37yjXnSlmdJJs9Va8ftuS1zHyJ7qEkGX6j2MI2MjwWD5Ij9ldFoi3wvyrMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770041046; c=relaxed/simple;
	bh=UdTEU6rGmQGkueTBJiIUb3q5EpBCW9cJmVJIfS+ZJKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AT2qNNvyLvmieKdFTMedeV5t9G9MSRuuLQGPuDRauoyQJ+Bhdw2zDRTbS46WuczxYX0Nfwq1vqKTu0YxRZwBcrvRFTqDMOocSNMWx0FS3q9rMsYksR6u33EWTGJVYvdnm7Prh3YzPkZ5fPOL7+hX1dn/jS3K7geUH08uAnDdmPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FfL1FC43; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FfL1FC43"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7cfd9b898cdso2829753a34.2
        for <linux-block@vger.kernel.org>; Mon, 02 Feb 2026 06:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770041043; x=1770645843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdaCXIGmM5WY83Bb/BglAowZg6aPFVt0zQ+PsAhRpHM=;
        b=FfL1FC436eWBZ9+W8InhoWo0fgRNXz53F3BrI0JvNBmQdjfwkvHGOEPk/eVA6IktOs
         WQwkiDAmRjYziWKjM9Bq7xAwxrwjegX5i+3EOSaZjpi+Ug9CekloXaQTxI9Ke1pxiKG9
         zamR9ppjvame4Hj/xYU5ueCIQmq7Ji20fwe59NsNCyxAnVmC6pcisJl5KqHuHZW96WXh
         IcIynC50zTG7bEpCcYrQvTC2IHSWtBlHSlb6itTeeXyuKD5hqbX1Mw8JjZXTmo3d6/Jj
         17xo4AfgKttuXUB5va646d0y0wnAUWuUp+tZYVh/D1xDXUc6CE1RaNq0kBbtcvpq5JAq
         /+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770041043; x=1770645843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdaCXIGmM5WY83Bb/BglAowZg6aPFVt0zQ+PsAhRpHM=;
        b=aduBaFVrRlrjuNMqhfbLzMH7RJSeBSmsfT4E4BIPVP12We7eDLxkHo0iGmfZlza+FL
         YJPs7oUaSXxIGbs0eDvO7YdJ5uXRFyfH8KcUUQPNmy0dRqAlX58R0gBG0PfHUPb/XUIw
         5qDRVUzqyjAr297HH0zvNzmAo1WunR77+8fpN/ZxJJisx69IcFJWuNWF8+dumkqtszyW
         4u/QYxA9tfk/gHKDtA7EiMP9oEeLbxv6WsncU1tlcra4E2XxrcnFjkD1LseD3UbAN95P
         EW7R0l0a46VYrZkKqI7uKe6huEpYVXsKCmExOaIjQ8uVizqDlTFKoDDwvsW9nPX5s8CY
         POyA==
X-Forwarded-Encrypted: i=1; AJvYcCX7gTEbBmmikt2tl2hnYfjPkYEhmdGmbUjp5AWL9iFS3vzvDuM/3yaXstRsmTtxLCJN74j0eWaQhec7Jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzO66vrXnnu0aE7VTL+6F2hu0IczMD0sfEwYttLkxX8kvClJ8cX
	CEiIajSSJD0+anwN0su/teM9HsNAg7tNTe0dYedRwOWFwn4KT9k8vpM/Nt/ws58peFiyxKL4W2G
	ZzD7hV9o=
X-Gm-Gg: AZuq6aK7Rmw+ckO0H7VCOIK/Tb3QOxVF89ePYNt0wbt+2wvU2kEr3bBMA9zHow/S5yp
	2fQ2djgGkQZTn/kUsKUtTdYp3BpyQjEdLtJgCZI79iFHNT21LPfOqSjwkk/h8sPwjmXejOifpl0
	0CfMGxGzPKYIdo3/19ztz9UDSObkOHz25bXEFQ6A/4RLQYFRlySMk0qUm1O/NFCPfmenHQ8edh+
	bIT3Jz9LDe97Yx3/+mqMqVwFFL2p/e5z0vXVe3oBnMdllXJM+pLcRHAW4sdqfC6s+qgrtBmzgvb
	vgq1A/lqifTSE/leh8k/FuWgqB/wzLEt0uMZDXQ/A5Zu6vD/Xn3q+HLS1xiSOXJnQ76zFdJn384
	dSjtC1c+IVl1Q5J7UGyXJlxpgdJ5LQpgfvW8K2jA6KVivZY8CxuECKUKLwGLiK6F65YbnRJxETt
	TYChZ5+3f+49p6HCbNWCbOrEIgUbcYkoJWOr+t6cXJY0U1kCOye5QEA5Gq6FTJfUO3L5eGfw==
X-Received: by 2002:a05:6830:82da:b0:7cf:d9bb:63a1 with SMTP id 46e09a7af769-7d1a5299159mr7309387a34.16.1770041043430;
        Mon, 02 Feb 2026 06:04:03 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c7cf8d1sm10910727a34.18.2026.02.02.06.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 06:04:02 -0800 (PST)
Message-ID: <024b12ad-b4f7-41a2-a914-fde49aba4c86@kernel.dk>
Date: Mon, 2 Feb 2026 07:04:01 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-7.0-20260202
To: Yu Kuai <yukuai@fnnas.com>
Cc: Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
 linux-block@vger.kernel.org, Li Nan <linan122@huawei.com>,
 Xiao Ni <xni@redhat.com>, Zilin Guan <zilin@seu.edu.cn>
References: <20260202124236.4065531-1-yukuai@fnnas.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260202124236.4065531-1-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/26 5:42 AM, Yu Kuai wrote:
> Hi Jens,
> 
> Please consider pulling the following changes into your for-7.0/block
> branch.
> 
> This pull request contains:
> 
> Bug Fixes:
> - Fix return value of mddev_trylock (Xiao Ni)
> - Fix memory leak in raid1_run() (Zilin Guan)
> 
> Maintainers:
> - Add Li Nan as mdraid reviewer (Li Nan)

Pulled, thanks.

-- 
Jens Axboe

