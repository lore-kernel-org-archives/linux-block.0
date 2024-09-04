Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5551A1DA102
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456495; cv=none; b=rq02gW4YnMD5LQRyI0KTr/NaMhvkHkObaRjQ2kFd3KxA+Ln9HCfnokdBEV25XYJSyWOSkmXKexenuCEDy2pfmZGriU3/NyJaLJGPHqTOtCAgdgMxbuCSCIVOrh8OwqGrsgNO7kAQMHg/FUbi080hA8gFaA3lchmpATLvJrzYpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456495; c=relaxed/simple;
	bh=5YFbXaK2e37cwUOFYYEYte/sbTMnkGevU5gEwE9uVVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFwgFf7JYFDy+AQVz1M2QOWGszmqzgpvUTLWjn34eJ16cFDRNDw4eKpJKsixLwXbz7IQxZklTZUe6G7b9D3BjQTne0AV+MgkjdZBcFiaOMoYQogyPAg6LpLP207q2CUm5JvSLJDLz9YBraUZT8XjXYbjYRPlMt+mdMY+svltrNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=strY10ND; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="strY10ND"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso910870276.3
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2024 06:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725456492; x=1726061292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pfyKOuC6v7KZka9vQjXOlbIe47Aq4567KYn0BRo82Pg=;
        b=strY10NDpo+YLjfeuIKC35+R6r85gjUqYY3wDRyN77GKS7fvz9kCqg144J1jOiZHgE
         5yHn3i5bAyv1Ay5flKrd1hoj3aOwNQaoQh1DFmxGU1+2pnr904yIzABUKa+6tvKJ/+q3
         YWfqGTpu41yzE81+usN2q0Mkk+gWhzH7zud8e4y0KgdvZrsjmN/CumIb9pv7mlTwvI1G
         g8jkcfFo2GHIT7Org0iAMoSatLFfknKwyEinG+zNX6mpmVBDiVT5jG2foe1zFTqD5lkY
         ifkbe800Q7fY2a+meaoZIwhmEL6x6nl+kwt4pYLS0BE8Wo74zd1v0aqQZjbjJs+JEvce
         xCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725456492; x=1726061292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfyKOuC6v7KZka9vQjXOlbIe47Aq4567KYn0BRo82Pg=;
        b=R9VVUq500L9avlKUtnC3TeONmsNZkjXsWSzFNGAXjM+UOXBFgZD1ZisuYpbOCsx5P5
         yX7adD24k5fhdx175sO8LKJtKh8maTmBE//+Cg3s9QuuA/tD/jIPtyM9tfBRdfolJZW+
         oeOVFD/cp1MP7E8bwvvnQ/Ettx5m3S9i9PAMU1TLyqySogo8prgSL23cA8Zu2TSHymNp
         xVzUfoslFJlJUvPrIPtFueyREbo+ca/dwl6TvaxWhA7IkwamZSW87q3fmHSwS33lqqna
         L5bProPMBd5ixvxOqoUUl6tXHJGdil5xSTWuAFarY0brkZ+UQ0vr1RLXf9LAfzc1TKJw
         B63w==
X-Gm-Message-State: AOJu0YzwJ56DbIHyYUTpy62HBLO0xXLBNEhRWIwySpNV5rzK4wND3uOO
	qJJ+4kFTVcIm7/qzcHODTRyHVMm0ojNQqRAmL6jxL3UKdPbRX7t+4+UQObgIzo54PS811plrfDt
	sJc8zMIsbD7ezh0b2z9IarFuQXX7J6661C1wMMaDeIaRs3nPv
X-Google-Smtp-Source: AGHT+IESj3FOeYOZJDgKOy4V7XOvHJRsN//lwq5tx2RJ+Arb4aVqL2XnRp0wpbzwLFJDnsgtAl3l1HZV1Q2olkonVKI=
X-Received: by 2002:a05:6902:2606:b0:e0b:3863:bca7 with SMTP id
 3f1490d57ef6-e1d0e9ead72mr2475823276.37.1725456492186; Wed, 04 Sep 2024
 06:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6fe53222-876c-4deb-b4e1-453eb689a9f3@kernel.dk>
In-Reply-To: <6fe53222-876c-4deb-b4e1-453eb689a9f3@kernel.dk>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Sep 2024 15:27:36 +0200
Message-ID: <CAPDyKFoo1m5VXd529cGbAHY24w8hXpA6C9zYh-WU2m2RYXjyYw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: move the BFQ io scheduler to orphan state
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Sept 2024 at 17:54, Jens Axboe <axboe@kernel.dk> wrote:
>
> Nobody is maintaining this code, and it just falls under the umbrella
> of block layer code. But at least mark it as such, in case anyone wants
> to care more deeply about it and assume the responsibility of doing so.
>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

I haven't spoken to Paolo recently (just dropped him an email), but I
was under the impression that he intended to keep an eye on the BFQ
scheduler.

BTW, why didn't you cc him?

Kind regards
Uffe


>
> ---
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42decde38320..4a857a125d6e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3781,10 +3781,8 @@ F:       Documentation/filesystems/befs.rst
>  F:     fs/befs/
>
>  BFQ I/O SCHEDULER
> -M:     Paolo Valente <paolo.valente@unimore.it>
> -M:     Jens Axboe <axboe@kernel.dk>
>  L:     linux-block@vger.kernel.org
> -S:     Maintained
> +S:     Orphan
>  F:     Documentation/block/bfq-iosched.rst
>  F:     block/bfq-*
>
> --
> Jens Axboe
>
>
