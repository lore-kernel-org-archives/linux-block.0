Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7A5025C
	for <linux-block@vger.kernel.org>; Tue,  5 Mar 2024 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709631609; cv=none; b=h9fHQ9oDJqAHh59fIOrPJ/bO3FYEpXN13/ICAHQhyH1mFBHMaHRrw5Yis0tuUjGFgdK2hWt30Md5bQnR6TDXF2YajLrWQagBTbO5UDYL6/OxAv1Z7g/hgbNWoCZUgfcT49CcH+f5JvaaMwP5KweMBvVdAwUPz2UglMwsKNnGy/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709631609; c=relaxed/simple;
	bh=epZZpCQ08Wke+nh++t1X7t9VgckTi+/6BTOZTBIdq6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJP96rYjpEzaWYm0WQad5Q5jhYvVto668cIUbZpsg8IxFKKFLfnD3UfBuq9gpkJOw/V7oQOSLgFv0MX6muxyN5ZtLwfMehSqF1ohWBS+kC3cQM0jAfWc2ZtHgU/MPJvAmxH0UhR8pxAlWanXl/7ahXXNTnV4aO25AG5n6ae9o/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=p5QBfDRa; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="p5QBfDRa"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso2299279276.3
        for <linux-block@vger.kernel.org>; Tue, 05 Mar 2024 01:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1709631606; x=1710236406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epZZpCQ08Wke+nh++t1X7t9VgckTi+/6BTOZTBIdq6Y=;
        b=p5QBfDRaTAFGFxokBJBw5Kg8HdaHTTfNBBEXVm5zsXIRHyvtQEavRvEw0OGdn3TW/T
         SsYN59perGrOaYcuM3qdiVu07x2D0l61stn5v2qmIYo7O+smxMkFlFvN8k0904o8LN5X
         PSJhHqBk44fuvWQH44286S6/egsmUkiEogipr6UvhYhjEnMsM++04CgLfWaRemBL4NYp
         wIDVIRPRe8jkcwGnT2vwzZzYirAvP9hAorcH9B4HQ5WAtDBXqYQpfCP9IGlVTcNT2PE2
         EiJc2N/N169u7vWT2qj6zefK0aABFeOssBbI0Jk3Kuz+p1RPCWuw+hPnvaMtfrUPwS9C
         TGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709631606; x=1710236406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epZZpCQ08Wke+nh++t1X7t9VgckTi+/6BTOZTBIdq6Y=;
        b=aJ+9e8szMCgl8BfXWnuTMP5u6FhA/EmpEBZFE+N3vQXawgsw7N52q+jDW7QYROhWg0
         wlZzZOGHNgRaDkRC+MQ6Qmxp3FG6a6+UYiTE8924U1GnH3zwJXTJ2mravOLqxGOUYWy8
         a15P4ONvUnoF+Z+3T9Juncm6KcOJnTQbx2TAYWPJZXcNWIzPuAEVjnfvKaLYHTfFXzm6
         CKTRZsIS+oVByQ04sYlmJdW/+U0GzxIILBhwMP3/n83ZfsSt7HfbI2jJbfolUsCr8jx+
         PnYTCeiLYw5Arli32XNZ++b+R6IJzwTdNJ9TQ0SXZDGkYQJ2/Zn+KUDe6Ttifu1a1PZR
         z3Cg==
X-Forwarded-Encrypted: i=1; AJvYcCW/IG+m4275N52Z6AE/I+wa7yj0zA8eZ25KBmwZzsxo6j+hpW9F6fhvXh6f2K9hO9nsbdHgSBAHF04JlYMqI81K+JIW5Udb/cesZIQ=
X-Gm-Message-State: AOJu0YwkUjG+ln9wYoy7PNicaQJ7qf3A4EPg6u6S9HQZt432hPxzmrT4
	TrGSZnzaFCF6rOTDClRz1xYJae7EaP9wHbS0y8TdvgvcErQcdSPmlSS4yaCq4YG/Ip1PfLzJ/hO
	mzdVNTEg5Paw2wSU07n+xz5M00YUpzH6ul0urCQS+i+19Auoo
X-Google-Smtp-Source: AGHT+IGj8sN1qs2du7u/sf6LL7Vm8gU82+4T5TaNsBgbICpftuyrF9gXqiO4N71B4imirDYr19iczOkN0ZcnWji+qoY=
X-Received: by 2002:a25:fc23:0:b0:dd0:39a0:a998 with SMTP id
 v35-20020a25fc23000000b00dd039a0a998mr4546185ybd.6.1709631606556; Tue, 05 Mar
 2024 01:40:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226103004.281412-1-hch@lst.de> <20240226103004.281412-11-hch@lst.de>
 <20240303151438.GB27512@lst.de> <CADGDV=XqJ_3biGx-rX0jMMue4-dTg=J8NjyHOU-Ufonv4QiJ-A@mail.gmail.com>
In-Reply-To: <CADGDV=XqJ_3biGx-rX0jMMue4-dTg=J8NjyHOU-Ufonv4QiJ-A@mail.gmail.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Tue, 5 Mar 2024 10:39:55 +0100
Message-ID: <CADGDV=WJWZHj89rebvNJ2BOhuqG=_Nr5S3+QXp6LTEGGKyzuKQ@mail.gmail.com>
Subject: Re: drbd queue limits conversion ping
To: Christoph Hellwig <hch@lst.de>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>, 
	=?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
	drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph,

we are fine with the queue limit conversion as you did it. Lars and I
reviewed it, and Christoph ran the tests. All fine.


On Mon, Mar 4, 2024 at 4:31=E2=80=AFPM Philipp Reisner
<philipp.reisner@linbit.com> wrote:
>
> Hi Christoph,
>
> thanks for the heads up, and sorry for not seeing it sooner. We test
> it overnight and review the patches tomorrow morning.
>
>
> On Sun, Mar 3, 2024 at 4:14=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
> >
> > Dear RDBD maintainers,
> >
> > can you start the review on the drbd queue limits conversion?
> > This is the only big chunk of the queue limits conversion we haven't
> > even started reviews on, and the merge window is closing soon.
> >
