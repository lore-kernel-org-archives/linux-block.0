Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAECD3FB26
	for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710518429; cv=none; b=FMyc18BVINqtmFQWBup4Y31WWrzMLK6pWOnO6N+mWhyeLT6JChMSxK7rhzKDO5LqmbZG6xkoqJTsuyCOlckUg7wGy398MyxeHfsN3HpQCc9iaeqfwR/dXlwJ/McUGooow9bVkSoi2MW6egP8uxi4wX13KiFtGiKWF2UowRdj0qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710518429; c=relaxed/simple;
	bh=dS257NMoQWn5pczHCLtU883bO4jf4jsc0GeE93LBSO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iq3D4t1QiAPowt+RPnLxnbDwsWDXIgsduFe1QnFcrTruiTtgmkv50F4yaFw2VA7y8LO1PxG3Y6LKGFpERbbPaa9syj2eVJEiHrlhKkhhVoIZZOuMERzr9VLZARFb0Dedp0Y9uQQS6sR+EG8Ss28sg8qOuCNwK/x6Yd+mSlNtjGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qRV3Xf9a; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qRV3Xf9a"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36649b5bee6so3254865ab.1
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710518426; x=1711123226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QSAiUQ/26gYGYoChbtGi36JWDBk8aj1qdbN4fCTUSOw=;
        b=qRV3Xf9ax7HRp4AaP3QNVJML8L8Dw5oCCIa45rHCog1QuxWlEBfT+bCEY870us2ud6
         kyhAH3R3UwsrBn9bibicZgi5mLgBUL/sIw6ab7RgdkX/7hF7VPsXM2KmTejx552rSDxM
         RB1h9PFEDPSvSpu5ivQ7LHLdtQ1CwKHjD0yUD2A9KahZ0K78tnLfJXwtysBUOURqKoRL
         XsflWCs2ku7QXvbZmoUcUl6UTJ/BxosVQQKPYP7LnunNyLrApYszGFtKdTnke0TOSNEw
         QF0lu6Vjjbg82sMC7ZDsMJBWva1M+a+atJBVRu5XXuCBY03X2WtNgc7/6mAAXlzKAZwj
         ltuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710518426; x=1711123226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSAiUQ/26gYGYoChbtGi36JWDBk8aj1qdbN4fCTUSOw=;
        b=hpwPsdiwFTCSr7gdrDBcVjiZfviKioywQL3hB3n4xDRRRu1KiTzhFZYHh9VBo9A3tO
         GxWsvAr4vafeBq/NxIC7mfYBsfFND4cG1qK3jAk43Ao7EPYJ3LfpkrznqmgvGvgifXE4
         V5qnFaTGMvPeYO7pPoIojHvQvSxKNULGanWja5yADEZpnRKy8J6bvTfL8Yi9+DSYoC7d
         mvgzkRWjyKE/dXDMFgEFbQrtVZEt5/rpxHfbzSOjMvJc/TqvHeQMSxizSfBhRCbjnCrY
         p2omtJWtFwfPFnNIxJPJ6f4YTpJHApKkw5Va9bHKk+VwE9kz1+slsPAc4oCO9rRC5S/G
         hVDA==
X-Gm-Message-State: AOJu0YxNkZgX+H1IuPrsudmtSP7ev+0OTema3Kh/Jleq/gfliDORLa2w
	nTevUhBMV1UI2zCBpKvfbV17vLuFHf5/WDCdmYO0M+CAqTLktvOO+ntaP0uua08=
X-Google-Smtp-Source: AGHT+IHK9IFfzOiTdqWihi8zayDhm30wfNbsdFZ00+1KyxfjhpAe+kATAwgjPeDurhqUfUmAMUAsOw==
X-Received: by 2002:a6b:6303:0:b0:7c8:d514:9555 with SMTP id p3-20020a6b6303000000b007c8d5149555mr2472641iog.1.1710518425760;
        Fri, 15 Mar 2024 09:00:25 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a5-20020a029405000000b0047469b04c35sm842119jai.65.2024.03.15.09.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 09:00:25 -0700 (PDT)
Message-ID: <971db084-0b99-4556-8466-9a1201f737df@kernel.dk>
Date: Fri, 15 Mar 2024 10:00:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] remove aux CQE caches
Content-Language: en-US
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
 Ming Lei <ming.lei@redhat.com>
References: <cover.1710514702.git.asml.silence@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1710514702.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/24 9:29 AM, Pavel Begunkov wrote:
> The nvme cmd change is tested with io_uring_passthrough.c, however
> it doesn't seem there is anything in liburing exercising ublk paths.
> How do we test it? It'd be great to have at least some basic tests
> for it.

Forgot to comment on this... Last time I tested it, I just pulled the
ublk repo and setup a device and did some IO. It would indeed be nice to
have some basic ublk tests in liburing, however.

-- 
Jens Axboe

