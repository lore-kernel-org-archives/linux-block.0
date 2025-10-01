Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635C827E048
	for <linux-block@vger.kernel.org>; Wed,  1 Oct 2025 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321385; cv=none; b=Kp07/8i47FzfM4PVRLByo+nt44sPomdzDDFDKRej209n1IpBYcnJC13auNPQDrfvnTvJ+FvOBSHVnYCb8fMB1UpEFvhuYOR/8vY3GTI0FDTCMEbPA/bmYKNs2dE6CS/C5qA1OPN5V8ZqSi7BBG0McnI5yQiKpTm3zVtuik75/Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321385; c=relaxed/simple;
	bh=jm7QjsEYN3o9NREvDIVoGhoSvlRo/JHErcAuGoWOiRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MK4JH3WwQXs0DFQEwpbPSMb/li6AY7j02nYshhTMGlSuQk6CsQTLEImPLKm4AdZia6atjsk38aTFt0ko3eAw8WRnnSzacvfJewLjPQVEhNQGljwdRvo9LHB+xX2u1tbXSFh1KZ/KTOkd8lw6ZMJMv4s9jM+ShB+DUHvFnuDQC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dhAQPDxD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dhAQPDxD"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-782e93932ffso3861250b3a.3
        for <linux-block@vger.kernel.org>; Wed, 01 Oct 2025 05:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759321383; x=1759926183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G6ekdHDmWVv9FcHQZlrQj5iI/vOkg8zYvOska5GK10c=;
        b=dhAQPDxDfgnqpA2S01DC+hFkGDJRYz3maVwiXV/VKcI5p+YhACTvwHXZLyb5sCHB0I
         up1nksKL+rcClHSn+vb7AVgYcGHNcYgEI3/cBU959c7+XgA/+yCCoQSyYp/LAVTUExus
         NsitKrWlltZd/w8x/BnWkyd9a9O+0jgAdpcWeeBdt/lZilo4RZGic1umn6IsN6gnbB7W
         MWTKrA96PgPf3iSkUWbW8Hz5kNiahCigYvLlU0BTAduyrZXo9sNhPgXTKqhTAoAn6ESY
         iM/g38tSRaBgdii0dTbqux3RpNyFBQ1cOE0mNh3ki2DAVPS7mbBpVzY3YQNcPs9GTY63
         0Tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759321383; x=1759926183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6ekdHDmWVv9FcHQZlrQj5iI/vOkg8zYvOska5GK10c=;
        b=o85CJOLTOkHRA9jmUyBVQk0zcRTTjGERSmaAjKd4SMNZ+pP97TRPiQEIFtjBeMwjJZ
         btD18R77NFhp7cd/omVG//kRVge79YmY7DTik/tu5q1aMl3x2E1LIG+CBsEGFSWrqb95
         WrbC+OIydVTdvvv48qazflnoDtNrPSaYMKkHOaNAGxEzSyuDzBoZhUOtNV/ReSOnKAlE
         opBrGGpG3siQiYEhBESrmarZ8F/Ezfl8poiWzYEBhyWU4QXjcNAT+y7UXoQjYS4VBZ11
         D6qmbneHkNZkr4EnEG3VsSzussv/FjYCfYza+/y4q4pyLfhYLOlCrZLRsrY+7D9WMIOy
         2mQA==
X-Forwarded-Encrypted: i=1; AJvYcCU3vERYX5sL2tvSKseO+YQsrE9WlmcGkj2xqZiL8gI320DAh4MY+XRNBKDK11W2LCbIAJ392/Gz9TEbdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJM9uF+PC0EYMsYsQHvqnKuI+4ZfIavCh5XNNagl41u/dIKT2M
	9T4F+NdTv2JgmzGiGovdoKWm8JyjdMY91XMOkVV/LItXWYifzTSrAFDpoENo4I9k+mxZKNTJZVW
	P8gaTjNM62qU8JWDBtiWnMo20tdjNVwbzGs7id9I/YA==
X-Gm-Gg: ASbGncukvsRofB5bAv3Y3arV/y5fIvEs05y8Vljr4HDvkTSBe0itLx402qYcAZ3MWdt
	R3vvWH/94UWPK5gTwh/AOKpdWxQMnefX2YCMJFaZVd98JTlt0H0bUkdArekc1y+R6ZAVTW5fqMI
	7kc4FsYAcukokjRGvkfTWJ/u6DcLxahBsrj4TxXvg28vzjD/HFc9qpFl8rzidJRXQn4eHaQRtSP
	c2EFrcUgjCa8JnzHWNDOoso6tdd378pDFDzPwiNvMS+qQxX2tuNI50CVDdo0n6IyhE4MoW87wlS
	gDjB1dRTvWxB5oJaTYCt
X-Google-Smtp-Source: AGHT+IG3y0LpyILSJk25wSg4EzJQnje8BCP0qYej1zbXdtuiF/6h3Ys2FwvbgoPmiH3pc5MHl/M3OJoRN2I5jM7mBd8=
X-Received: by 2002:a17:903:1b2c:b0:27e:f018:d2fb with SMTP id
 d9443c01a7336-28e7f27db93mr43354285ad.6.1759321382673; Wed, 01 Oct 2025
 05:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930143822.939301999@linuxfoundation.org> <CA+G9fYvhoeNWOsYMvWRh+BA5dKDkoSRRGBuw5aeFTRzR_ofCvg@mail.gmail.com>
 <2025100105-strewn-waving-35de@gregkh> <aN0aMyU1D3N4WQy4@stanley.mountain>
In-Reply-To: <aN0aMyU1D3N4WQy4@stanley.mountain>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 Oct 2025 17:52:51 +0530
X-Gm-Features: AS18NWA6cyT7LVY1PGpPsb3wxOlSJ03i0aRVQJ0RG446XB-O0skidiXBbZlceZU
Message-ID: <CA+G9fYsRCN8f5n4dsbQAq73t7f5pzbHVT5Hp1rxYQzpxqvLWXA@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/122] 5.10.245-rc1 review
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-block <linux-block@vger.kernel.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 17:40, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Wed, Oct 01, 2025 at 12:50:13PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Oct 01, 2025 at 12:57:27AM +0530, Naresh Kamboju wrote:
> > > On Tue, 30 Sept 2025 at 20:24, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > This is the start of the stable review cycle for the 5.10.245 release.
> > > > There are 122 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.245-rc1.gz
> > > > or in the git tree and branch at:
> > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > The following LTP syscalls failed on stable-rc 5.10.
> > > Noticed on both 5.10.243-rc1 and 5.10.245-rc1
> > >
> > > First seen on 5.10.243-rc1.
> > >
> > >  ltp-syscalls
> > >   - fanotify13
> > >   - fanotify14
> > >   - fanotify15
> > >   - fanotify16
> > >   - fanotify21
> > >   - landlock04
> > >   - ioctl_ficlone02
> > >
> > > Test regression: LTP syscalls fanotify13/14/15/16/21 TBROK: mkfs.vfat
> > > failed with exit code 1

I have re-tested for 12 times and reported test failures are getting
passed 12 times.
However, I will keep monitoring test results.

 - Naresh
