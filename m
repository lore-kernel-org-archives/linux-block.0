Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB641836DA
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720029122; cv=none; b=dSXKtIRJhqR4kiZpqP40iTGIda61joayTXBp7ftw530fdIqbla0mvBXkHHCi15ohAyshy6Q9yRFifcrvec4VQuT+/djM3D+JgXklRkHMtMMLYhRmhNUU1tRFCrzK7/D7aG0iSSecSwyVot6dkVxnbPcBvMbWXIwGOlOxjJsXN9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720029122; c=relaxed/simple;
	bh=I/SyeQYOGfLQAUSaryB4epiEujHxOBhpHqyBsKYQnmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noYkLLrJmeRJ8k79a5cets0XDM3ElMdj3a1c3Sulp0L71vBQkBQlE0FQhlXdBSAQ6Akj+fh0ite1CvfgwK0wL1OOBfHMlvHYf2MvCKJsw1M0vxKtmAKqiLQxtZJgxd56LFytbw4vVcCnH2UNJjNOdyylg1rvU/TZfTwHdHYnfcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vsssUqfH; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vsssUqfH"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-48c2d353b01so1937970137.2
        for <linux-block@vger.kernel.org>; Wed, 03 Jul 2024 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720029118; x=1720633918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i8jcvDGwHGDOUPj1r3ad1ZdHqvoFYLPPd5l4l3bI77w=;
        b=vsssUqfH9ffgsx3yjTvNTWTN5YxgiyP0EO0n6BcdTHelomytRQavfMYdDosTo+DkIg
         slq2uc+0JAAvN082Z4Uet6rzEeE/7W0/bQ+lE7ix4rwI4PugwtabNJcc3BPIKSQqH93u
         J9+72jM3ECC96zFkTkqHb4bUhP5yM9xhoBk+N7kKVzZY+PDE2oiwgDLjZzSCWEjdtBxO
         z1hVkJvDaAyNX9CCZnyfueChL+HHpX81M9G1+/7vfdA25Vw0SzB1/TBdzOONKPgVFZl3
         xqSQJQGxe0i/PBMwZv60j8bxaFymgSJhWAAjpBsdikcgfNxWqBOlUxzaLE9K19WR+0rF
         mX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720029118; x=1720633918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8jcvDGwHGDOUPj1r3ad1ZdHqvoFYLPPd5l4l3bI77w=;
        b=FmuSZl2hEDPrv87wSmZwQ1//tJKBT2QQaDZGhkufDUGsKokAvPgdyh1MFQy1iEkWxc
         5lwqAB6OxYcjQ96gdxfhGXZUst3Wm7T/9PScqSdZbPzkIkvcJQQrOdQ0OQ3KRLhpWllL
         +ASIcg8Iyc/+nJI0KtT0a/+9OTGzu+AqkwWx3WIIpETpv7eWhMLEPsXX22c0f0JHMf/V
         ZUdYV02nrTz6KlbbduWpga4xIW9jzphdh2xg5EPIs6GM4qPLMyxVdrcSt2un5UMMbBKt
         iJxqWu5Ud8fqKYKTAv5GOy8m11aIxJiVg4khRB/lce9sIS/iq/REN7Vi+l7F5ygOEyaU
         hTvw==
X-Forwarded-Encrypted: i=1; AJvYcCU06MMIQOYOWB1eoQb6YqroMvshDiKjR1nAZC70wTJ1FDczASCLkbVZ9mZ8/ZTHGIrAUJ1BHMscRycCkRXXHuEqutcWJa1BwjQ+ri0=
X-Gm-Message-State: AOJu0Yy1f9Jz6wPfiEkD2vxyp3B4+O5Dver1AzdhTQ8aDYrySUUz6rRS
	wHQsiBbZLMvrgPt/SHJV2HJNgfByZjRmRc/ihUmersAcQ8ji3OqmHNIR1E1/Z0GTKEClY3eAdet
	hemEQcMgbz0UnEzZI/DvLtHJ0VeIVaNVnPkCoqQ==
X-Google-Smtp-Source: AGHT+IHhubxatrzSaA5HKwryk/uHLQRo61FC6EY73fx40maWnrKKGtHLfWp7my6T+SlQSv0KB+ZvBb6CauO9auPbwxg=
X-Received: by 2002:a05:6102:e14:b0:48f:9751:198b with SMTP id
 ada2fe7eead31-48faf12de8cmr14916609137.23.1720029118386; Wed, 03 Jul 2024
 10:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702170243.963426416@linuxfoundation.org> <CA+G9fYuK+dFrz3dcuUkxbP3R-5NUiSVNJ3tAcRc=Wn=Hs0C5ng@mail.gmail.com>
 <c440be12-3c22-4bb6-9a10-e3fd03b87974@app.fastmail.com>
In-Reply-To: <c440be12-3c22-4bb6-9a10-e3fd03b87974@app.fastmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Jul 2024 23:21:47 +0530
Message-ID: <CA+G9fYtuiiV0FDFoSZOaKQbKiQYw+SphhWZDjK8R-bH7dBfs5w@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/222] 6.9.8-rc1 review
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, shuah <shuah@kernel.org>, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>, 
	Jon Hunter <jonathanh@nvidia.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>, srw@sladewatkins.net, rwarsow@gmx.de, 
	Conor Dooley <conor@kernel.org>, Allen <allen.lkml@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Can Guo <quic_cang@quicinc.com>, Ziqi Chen <quic_ziqichen@quicinc.com>, 
	Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 14:55, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jul 3, 2024, at 11:08, Naresh Kamboju wrote:
> > On Tue, 2 Jul 2024 at 22:36, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >>
> >> This is the start of the stable review cycle for the 6.9.8 release.
> >> There are 222 patches in this series, all will be posted as a response
> >> to this one.  If anyone has any issues with these being applied, please
> >> let me know.
> >>
> >> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> >> Anything received after that time might be too late.
> >>
> >> The whole patch series can be found in one patch at:
> >>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.8-rc1.gz
> >> or in the git tree and branch at:
> >>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> >> and the diffstat can be found below.
> >>
> >> thanks,
> >>
> >> greg k-h
> >>
> >
> > The following kernel warning was noticed on arm64 Qualcomm db845c device while
> > booting stable-rc 6.9.8-rc1.
> >
> > This is not always a reproducible warning.
>
> I see that commit 77691af484e2 ("scsi: ufs: core: Quiesce request
> queues before checking pending cmds") got backported, and
> this adds direct calls to the function that warns, so this
> is my first suspicion without having done a detailed analysis.
>
> Adding everyone from that commit to Cc.
>
> Naresh, could you try reverting that commit?

I have reverted the above patch and boot tested and it works.
Since the reported problem is not easy to reproduce It is hard
to  confirm that the issue has been fixed.

However, I have submitted jobs with and without the patch and
running tests in a loop.

>
>       Arnd

- Naresh
