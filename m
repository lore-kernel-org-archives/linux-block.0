Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E47F1448E0
	for <linux-block@vger.kernel.org>; Fri,  5 Jul 2024 07:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720162993; cv=none; b=p66TAtZe+gVOdI43LGkmalWOet3VPed1BbLSqISRGOZU51gLLAG+ZrlViSXt9ZAGxoGakXusxcffZs3uTLOO9EGJpdQASTFpwM9PZfqQnMuPg0FECoO4V4M7dVOJbIDogf5cFiyBT2sqqlXGlY1KVuN2JvqqEVW7NqLpEpowzKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720162993; c=relaxed/simple;
	bh=rxaavTr2I9nl3fSrmr6ylQi37pJsR83Anc77isEaRlk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P8S+lG1QeZ809/PvoCWtwBoM6nHSNT1sU3vqD9/pmxZrhBMEZCmGCsDswED3vVyM3n2w6yxXr/xEbxgecJUdvsU9LpHFsyLMXz+YHkJ6Clp4nu5ZwJC6lRA1a1doWP8SCpCzhfIbJrJ2/tBiwhSS5iDQYSe1vAkNf/9yTZ6VwQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mkfzFs1m; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mkfzFs1m"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52a559e4429so98664e87.0
        for <linux-block@vger.kernel.org>; Fri, 05 Jul 2024 00:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720162989; x=1720767789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tGYR6LV3kb22UuES5i/CxEB1mMcG3Owc6N4vso5tYIQ=;
        b=mkfzFs1mDaQokkMSY4Qhf2AddThOlGqX74mE66v8GbyRr0FwVf2YzoQDPSMN0WtOHM
         7RxfCDCUcT0KBz2dCebXnoZJU8MoJRqmb72qKceYljOwsmuSxcWUgWRigatAKw7JOQEc
         OUdYTpgKrGOmxxgi5cBU2nMvu3sejYrvYEcVyJPa+7ZIc5a1I5sF8YhuOSSuAw+ph545
         P1c94ikXeLFl2J2syZgOIvxz2XESESC252HZ9QsP1xDGEnvHV+e67rcuabFuqntImEdD
         hFmnV6pcvLbjfFzl55+4y3ggZ8IowgQdSHBD9aM5xo+tN4Ol6n8ELBkGmtmDfCJNrwHU
         ThoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720162989; x=1720767789;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGYR6LV3kb22UuES5i/CxEB1mMcG3Owc6N4vso5tYIQ=;
        b=jp32jpkWRs3de1IcVx1j6njQPlZl+nYR+/lCrIhRxfk96GmdxwscucXpHx/KOUToIx
         bZEOpbeJChSFKZZZQJtKsShVJv/kZvcBr19UC/nZ0VZpXeBkglCx0cD03Sl1KuFoAiE3
         YcovFb8cfc2+Zm3NrYeivZ6imeSKD4GK0+VSFO0LeRMTmIHa/qb48i4LO2Try1xRgYAV
         J7TPK5+5giH8vEWrRzbGp5L80lzpRx7VGBG2ugUdaJpO+xHR97e1iyrdMjH/AqrNGydU
         jraNZVl6Q945tkKUtXRJO6UhUUUDLpRjoHqlFlhiWUeMtJCx2sW4ePwgNRCWvFCzvgFJ
         7+SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPxU0uz5H4gY27PowjHKp5HOAjm+Ot4tQVmy82R1NspsdjCqW9QCAunXHBgds7uIq2nAxz4OjNSWzJ6S5vbfYoCS+pj0+LvcyCJkk=
X-Gm-Message-State: AOJu0YzZ4sY//6m8SotelT0NsHprP8E31KIrILH5KEtzkvAiMJNLEPKf
	mUmwf7DPk/gRI+EOlXdsfpPq7VjfoSzf+93jbBTWclzYQ7a8YAlNns8+ySN2QZU=
X-Google-Smtp-Source: AGHT+IGnWKiTVywt8pQ6SRb7v9O5oNkOKR3YWTKskwtBydCui5N9lMxR7u1GI9ud38OZAu9sDGe+TQ==
X-Received: by 2002:a19:6b1a:0:b0:52e:93d9:8f39 with SMTP id 2adb3069b0e04-52ea06bca91mr2289303e87.3.1720162989347;
        Fri, 05 Jul 2024 00:03:09 -0700 (PDT)
Received: from [192.168.1.68] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab3b1f3sm2740066e87.256.2024.07.05.00.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 00:03:08 -0700 (PDT)
Message-ID: <5364ce86-1222-4f30-bb8b-42e68846a2e5@kernel.dk>
Date: Fri, 5 Jul 2024 01:03:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: make secure erase and write zeroes ioctls interruptible as well
To: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Conrad Meyer <conradmeyer@meta.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
References: <20240701165219.1571322-1-hch@lst.de>
 <b4940767-b5ba-477d-98c6-a9671b2bc290@kernel.dk>
 <20240705065053.GA12771@lst.de>
Content-Language: en-US
In-Reply-To: <20240705065053.GA12771@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, Jul 5, 2024 at 12:50?AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jul 05, 2024 at 12:45:08AM -0600, Jens Axboe wrote:
> > In lieu of that, qemu does support mmc it looks like?
>
> Hmm, I can take a look.
>
> > Wanted to get this queued up, but would probably be best to have
> > that tested first.
>
> The write zeroes patches do not depend on the secure erase patches, and
> they are what people really care about.  Maybe just skip the secure
> erase patches and apply the rest for now?

Done - please just resend the secure erase bits when the mmc side is
happy.

-- 
Jens Axboe

