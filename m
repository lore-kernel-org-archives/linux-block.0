Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AF636A03B
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 23:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713600; cv=pass; b=pjXiUX/43v1nBa0Zxlp1xcvMCok4zifgSFNsgI3F0twEKIHw6jMpci+F1asVwH7k/ob0wS5ck9qvTHuY3XYtvl38EhlY2rlKQ6VyxyT3+9KzndShExUu5ohg0rGn2oPrb4nXQYkyycfGjTvYeVi/jxOxV/n4Zj4k2FkUtTAXFiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713600; c=relaxed/simple;
	bh=weOp9VTapGovk1N0KNtBfrCHLWLy25I5ytzf4YzVTKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yq4dHSNQc03Lz+ITfyzwjFkQD7gKkznEsvP4R+Lw7hE8h06/z/fAmGvtislFprs+8HC96aE+BZJ9kBySxUqT+/tQllMfbLO9YJzJwFPsXaApjwEUqLcESgfsB1W/iqojnnKxzN5kj9y/6Z7Gol0Q7VCScmYjYYZUr2mD4LDqurw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q1B2JzBO; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q1B2JzBO"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12db2e415a7so5334228c88.1
        for <linux-block@vger.kernel.org>; Wed, 13 May 2026 16:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778713598; cv=none;
        d=google.com; s=arc-20240605;
        b=WfU/TNnVMfJF5E/K9M4djgfs0Ib1BgqIU47aOSkrYB9d+QOEkazobCLouiE3cax+lt
         jvSB+4HejJ86Wd2gnSWYL8DBmhcja9588WiD9TEqzRXIKcVvafxLQyMMZPjD5lEvsetP
         zGiBN0UvYK0bCgNqWd+m5NUm4xwsEEgz6iVUJeAR7IOqaaeG5kpDIjWD9KbhQPByOSRk
         Fxmw+V5qhbMMiOeS/3dHXFEznoeFT/rqH/jA3v1jU2YCG/QDwDd/9Ic6NwK6VgpT+o0C
         Q44Od6ov/kQnP5rU+8qXlsv8s9H/KO/hd4TM6pV9QO0erBpYY/ZXnnRhiGccOKrer6pA
         Mubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=weOp9VTapGovk1N0KNtBfrCHLWLy25I5ytzf4YzVTKk=;
        fh=O9Gxon1HFKdp/oZCLHHfjfMi6cm9cP4Nvz6sXEU0wwM=;
        b=ldRiIScZjaF95CbCm3k/X0pAue1NGaJ1Y0hhaWYIe5SxLVesSySqLQn3Mwtkp9iK9w
         yCBvbFtk07BLGZaBDn6GyyawB7ZatSTDSI8/wgJf8tQWaslchRLMowSPhwyBSvmjVlUq
         y2IRgr0gE1p6QCzEVwOSONUs2TEMniyQQdP+AMFbHGxS7sAmbriPrSLzDRz3vC4T6lFm
         RTwa1tsZQjbtvSZr6ijJqx5crmZ8f9dTm1Ct2hehIW19vq6Nwzdnssc7CMrblD/8dSiO
         AWsTW7lZT6YpSNxEMw84dl1iwul1phLowF8zk/cJ/PKe02M59+cVWC1Kmt1ol0M6KKH5
         qxMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778713598; x=1779318398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=weOp9VTapGovk1N0KNtBfrCHLWLy25I5ytzf4YzVTKk=;
        b=Q1B2JzBOZdjMVuVWrJt2qaa3kWMi3RZqiGWnu64BzqWJ2rJ7JH0Y8Ro72997i8rRJD
         NxpDeKhLkbdVt3LXQCWmP+m23s9rORTtVXvI0nu4Js0wP6Vgzm9/B2GKSE/khBWAmeHB
         JjY50pFnMVxZkaZBdHjPe+fguZqQW11R9IdY0cg01Yt4A5+EEUP1zXgrUj/hRdhNGcZq
         nnor9CN8I6E0O8H1g1GkbYjSwGrQ8do7JycX8iOX6OFghaS1ENnWrpEUDvTmTBwnrJXv
         4k/3UW6KquuYRj+R1cBK0CNCh3x/Y85evyQiR+C/Z+xbbOidcF2MSy06edJ7IOMaoI4Y
         wy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778713598; x=1779318398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weOp9VTapGovk1N0KNtBfrCHLWLy25I5ytzf4YzVTKk=;
        b=RUoBaUWjJPcx5Sk7ELdCGzFdl85Qvophr4+N4wLqKGFFx3WTNcfNneJHLeRq1FonT8
         ySbCFjrf8F4ITu86/vZP5uyB/onsd8Fzw/DOHjDPLLLSEH6+PrLOeH9FaMNSO168B2We
         gM6qRRQgmlQCNBYKuNl6WIu/QnkZuYrWch3WxnZSGfdjfOuYJkHfgDJoMUo9rjM8f3CZ
         7FDUfiQIvC/HfwjROUclsBa8kxPm2q4JqCAAIHLpO+4oaKq+uB5lBIXl3kSSXHDhmf8r
         uOY5IoW4glsDv7BYJW/8MBDVsJ0pWIaThgwXA0HknQH31FaOeAV0DQHuquI+dmmkyaf8
         rJuw==
X-Forwarded-Encrypted: i=1; AFNElJ8AC8iX7xsO3IzLJ2Kxt9IraYCAajtaomMCqoMMoqvRE3OOvcXHzrrtl+Dji9ibB/a1VYrIykOF9Z244g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTRTqX2HsH9cON5cuFsHkYPdW20kkJYxGxddwpGWnU7plseIKC
	hwWNFt3hLRfxM42t3Qac69fBXVYyk/5WotXx3WJGraEaybV66OV3WE5dmrO1JLYw0nx3VJs0eUx
	tInSWMhbqiBNTWJrlVfeiudVzhAvhBeuA1XPlOt1b
X-Gm-Gg: Acq92OG71CDN5m293DiK6LjBtGX4nIZUJRItkTw3nppCB2D3AVZnSyTAmlP+40vs5/P
	ThaBLvk4EDecxCQWzHOSkjpThl4g1yYGC2/AAjbxOmTPSXZ4FUTVtrvNn0/C8tLD2HLKd2Ol+CY
	g0l8P6i1oY8QOvfsc6tROk4wUQI72nuXtjAF4u2XvRVrAcUuDnvo5GaV6oh01uOCgolYBXMDArB
	Y8fTTzLeECov3xnQfd4Fd2xxZCpWMnZmQPSo3UbFB+hpkrtFQwmCXXl2ACuPJghWlZ635oDim9Z
	PqfRR/TmW98Ck78TiZtgcnifeifIwSswOTQlEu5i8erj12a7qPALOQOjkl6G
X-Received: by 2002:a05:7022:522:b0:132:5d96:3c0f with SMTP id
 a92af1059eb24-1349ad7ed3bmr3180062c88.31.1778713597456; Wed, 13 May 2026
 16:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511163100.1887263-1-bvanassche@acm.org> <20260511163100.1887263-3-bvanassche@acm.org>
 <CANpmjNNMDY=gB23ejdDYZg5yYduup_iXE1FAWC-fghr2od7Hwg@mail.gmail.com>
 <56a1f905-2348-483b-a79e-5b3ebbd3482d@acm.org> <CANpmjNM_rCMzbz88SSmmQU2h0+OvjoyN=VapkBc4OEwF=fRcvA@mail.gmail.com>
 <20260513133614.GA703152@ax162> <e6dbe36b-7bd3-4848-91e1-9c84d421e1ee@acm.org>
In-Reply-To: <e6dbe36b-7bd3-4848-91e1-9c84d421e1ee@acm.org>
From: Marco Elver <elver@google.com>
Date: Thu, 14 May 2026 01:06:00 +0200
X-Gm-Features: AVHnY4Jb_K9GccYsiYjRWPhHZSdtOBPW-R2yzTTEtjo4oJbUcaaptcZNrIvWhHU
Message-ID: <CANpmjNP7JQq5X6bheX58bi2A5XaChkGSXs6+uQK2kiwQeXBvdg@mail.gmail.com>
Subject: Re: [PATCH v4 02/12] block/bdev: Annotate the blk_holder_ops callback functions
To: Bart Van Assche <bvanassche@acm.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 May 2026 at 00:14, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 5/13/26 6:36 AM, Nathan Chancellor wrote:
> > While doing a dynamic check is more expensive than a version check, I
> > would not worry much about that overhead if the check is worthwhile or
> > valuable. In this case, I tend to agree with you that it would just be
> > better to bump the minimum version of Clang required for context
> > analysis because of the improvements (other than the function pointer
> > support) that you have landed in main since release/22.x. While I am
> > always sad to see support for older compilers dropped, I don't think
> > clang-22 is widespread enough for that to really matter. On the other
> > hand, I do worry that if we do not have a wide enough window of
> > supported compilers for developers / maintainers to use, we won't be
> > able to uncover potential problems to address in the compiler (I feel
> > like getting __counted_by deployed was particular painful for this
> > reason), if that makes sense.
>
> It seems to me that increasing the required Clang version is the least
> controversial approach. If nobody objects I will start testing the patch
> below.

My patch which is more complete is still floating around:
https://lore.kernel.org/all/acqELlVC6vEeEF-W@elver.google.com/

Peter is probably still waiting for Debian to upgrade the clang dev version.

Thanks,
-- Marco
