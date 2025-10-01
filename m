Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3383270EDE
	for <linux-block@vger.kernel.org>; Wed,  1 Oct 2025 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320634; cv=none; b=BVuil1bFrADo57rUS2pWf1dUXoPldrih3FqLAQeeSSJoB5NVhmgBXPLhFfSljQBw4PmTI/km3LQj/8FMQMAl2tBXiBD/WhijoG0J3W7StnvgNwPk594MrahN6G2W+9aqtnN6KVqvxYQ7v/mckccUd47loIWZFCuE8mGP6K3p2g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320634; c=relaxed/simple;
	bh=pvMGaqY63vMpQ2YYUKa3njQxeuJ6aYGwkhm8mUrKcsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qk+FxsJR9OxkJuPoiBFpy+bPqipV6J2PSF+zMz8mD2XE3D0GCnmlaO+ReYdRd51676bWaYJsfGmI9uWfhYM9rSGxBevVQo6zfukzOZANdO0+M/xnDB6gDjeUGIti1ohTxZLi9orjpg0L9/MatlQ0BmG97/5FGjbKsXKSX7/Sz/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IxmtHI7Y; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxmtHI7Y"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso45430935e9.3
        for <linux-block@vger.kernel.org>; Wed, 01 Oct 2025 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759320631; x=1759925431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yt2/RiqsQaPl/L3x5B+o48QDSFj5vHrC7SC05R42/Fw=;
        b=IxmtHI7Y69zAjJ/ziiSmBhgdrCkeVRXMqEXyJy2a/Ix8jn1NlGTTQRWSKvc0MnQzC2
         cLtCM559tjNu2ckFN/xBUiBzhD5QQThxV7HwGUFDwrn0GPhE+kCJNBjvH62sJUBtuhDi
         YbN/4dx9pSOPIb/P+G2iYvnLn3fEVx59So7sMeiH/INXclr8csTh/IB/GwsoUAq5XTDt
         59D0p/liLSCx32xAXIBK7vqanTk5f2OunXaOHeMaiGItIgq7UDx9UlHe4KY3n2aY1s/R
         DZcBFsBIa1t1HWuTJZ1lNk+xsfve+rG6IXpClj513KxKybUHANqI9wgL5yrthLhsiTKS
         DLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759320631; x=1759925431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yt2/RiqsQaPl/L3x5B+o48QDSFj5vHrC7SC05R42/Fw=;
        b=Oxi22DDcysK0EfNgS0l8oZhO+kzRfidkjVXb4C4QjDK2XfDBCoHr6g32Zf1GWq+6Rt
         gaoo3kujnHu7nr5gJ4minOqMR+1TEYLVNJeVBK/Y7jQ2Qk7Ns8WGQFKa0mRyld8wDTQO
         O1DapzLst/R59fxBZgFSDzyPn6zm3ytmyPWsb9sU3C+p9+0TGvvcOh1VZ+BG5XQ1JuIp
         X0J72jEQ/BUii7yO5X1+caMtRf978m4pfx2jZmyDQqSyxJ1yLKioyq8SAh1vig68e0Sb
         UJzvCVoGaX5Oxs6EEBs+/bg8bqSUTXy2+pec3jDBAxI2tlq4YpbH6PzDr7niIOOf/0ft
         UC6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWonS0yHd3xZbijNuMdsZG4MoI0E1UV3Ww3ZoVwMvcJkyKwbsrJ3Msx3GV45AbXjmuTzzb2nmNlWyZ8mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyWwAq8Q6G1HPfcr81DeSwDs0SbDDKtdlpnwM1CGB+o0uFtenb
	X7b6Dq6np15g7tL4d8M3JR7V/0R9d5Vuj8n2hrDfjPvBKOXhOcCylvx+z3FSNpSeJoI=
X-Gm-Gg: ASbGncsBxjk08BUWigimiJ0TcwmFgiKxiTW5v21FXmcVneEIK3qGSsjHvCdifsHLsms
	Gjmi+7zUiYlsxrsZhiexLPezYiZX0diyuvrk2FDkClroVC/ZnA+iug9QlS42pLISIqYAMaiZn2/
	QsmdWgaCLbCT5oVB4mDJIxBO9qxQKSErcscRDy9dTkVV7ChpRcYVHMd5kxFZ6/i2J5h9KpQh/bk
	7sNVULPXlfiZbF9Ic570ETotjIRmkNYVHwDp4sNZB4g83w0XiOvoppzIfto9itULIGVHxHc1YlL
	1yWYq/YRhZTWD6ptcepIguH1iIf/2HH2eQhCLav+jyfY3q0X4hNwl8sQhtKwr5030VQqm9XRVKQ
	FGgP5iPMG63HLaSp9po62MwQdKl8z7/uP9+sBzT8loBBAJ/U3Ofc6nzF91BF4C5w=
X-Google-Smtp-Source: AGHT+IG4Fv3Ws0T0hfn9FRi9J8Hy8qhXiWqsQ+7mqBAvBUVbcM7w8H1ZOknsFTXOA3cvm76Wrim5lg==
X-Received: by 2002:a05:600c:8206:b0:45b:88d6:8db5 with SMTP id 5b1f17b1804b1-46e612192d5mr31099915e9.12.1759320630850;
        Wed, 01 Oct 2025 05:10:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fb72fb21esm26937295f8f.7.2025.10.01.05.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 05:10:30 -0700 (PDT)
Date: Wed, 1 Oct 2025 15:10:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org, Arnd Bergmann <arnd@arndb.de>,
	linux-fsdevel@vger.kernel.org,
	linux-block <linux-block@vger.kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: [PATCH 5.10 000/122] 5.10.245-rc1 review
Message-ID: <aN0aMyU1D3N4WQy4@stanley.mountain>
References: <20250930143822.939301999@linuxfoundation.org>
 <CA+G9fYvhoeNWOsYMvWRh+BA5dKDkoSRRGBuw5aeFTRzR_ofCvg@mail.gmail.com>
 <2025100105-strewn-waving-35de@gregkh>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025100105-strewn-waving-35de@gregkh>

On Wed, Oct 01, 2025 at 12:50:13PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 01, 2025 at 12:57:27AM +0530, Naresh Kamboju wrote:
> > On Tue, 30 Sept 2025 at 20:24, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 5.10.245 release.
> > > There are 122 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.245-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > 
> > The following LTP syscalls failed on stable-rc 5.10.
> > Noticed on both 5.10.243-rc1 and 5.10.245-rc1
> > 
> > First seen on 5.10.243-rc1.
> > 
> >  ltp-syscalls
> >   - fanotify13
> >   - fanotify14
> >   - fanotify15
> >   - fanotify16
> >   - fanotify21
> >   - landlock04
> >   - ioctl_ficlone02
> > 
> > Test regression: LTP syscalls fanotify13/14/15/16/21 TBROK: mkfs.vfat
> > failed with exit code 1
> > 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > We are investigating and running bisections.
> > 
> > ### Test log
> > tst_test.c:1888: TINFO: === Testing on vfat ===
> > tst_test.c:1217: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> > mkfs.vfat: Partitions or virtual mappings on device '/dev/loop0', not
> > making filesystem (use -I to override)
> > tst_test.c:1217: TBROK: mkfs.vfat failed with exit code 1
> > HINT: You _MAY_ be missing kernel fixes:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c285a2f01d69
> 
> You are not missing this "fix".
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bc2473c90fca
> 
> You are missing that one, but why is a overlayfs commit being cared
> about for vfat?
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c45beebfde34a
> 
> Another overlayfs patch that is not backported that far.  Again, why is
> this a hint for vfat?

That's test output, not something we added.  LTP tests can have a list
of suggested commits.  LTP doesn't know what kernel you're running, it
just prints out the list of commits.

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/fanotify/fanotify13.c#L436

regards,
dan carpenter

