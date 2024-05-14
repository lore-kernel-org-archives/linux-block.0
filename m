Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8431E536
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712506; cv=none; b=aGVYOlY/w3sgC6FXACOr1/BNcVXxlkhEjgemGqWXYx5aY659pSDcQADLqADUFMFzvEmbUz6VgiHSmFFVJLA/lnFYKhHtSzWHudZPxjyXBqNEX6sGKIpqS+Eq3Jdz2rsiQ+MIsaItfKJQT/Yz+hZD3zUWbBZJXyR8DzXIKprhzGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712506; c=relaxed/simple;
	bh=C0Cvf2cgFTZ2g2ohjesNm08j/GKLNg1KUc+rfT8Dr5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7P+4I04GZ8hgiCNyCn9hOawnBZkdADhUQR2YcNMrYOFscyzO7PQ9SQnWAycw5xhuuTTiz/mE3roxtVfmWnr5MMrFB1BO2/st2D1DEdSBAr50OAH2d7QjVVxtnFCofsSxuVgQPaJ981HxGlHgvhZNH4ZikWpbq/ZiKKYJHlgzm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmKmaPHd; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmKmaPHd"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-23ee34c33ceso3764886fac.3
        for <linux-block@vger.kernel.org>; Tue, 14 May 2024 11:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715712504; x=1716317304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vm7+VMJI/p0xhaVdX07ViEoUrsc6h67q1AxKlBgBZ8=;
        b=FmKmaPHdnTje/yi9EeYDywxJtIidXsNQtYr+4RmZQkI2P8OrUUZ7t88n+W7gY5DsDL
         8FhMQbh0s9h+agUoxJDNMoZtZKNpTpLjhJ0dDoZbXty6s5u40LAx3EuFXzjC8lbz4eKT
         ZxIulMffLK6PRak1o2shXqElL4rfM3fTdOjsXHNX1fk3vvN/AhrWSyCDiLXVY+lyo838
         X577/Eth/7NyP5fjsLLtYJV5bd2XF92EegUK+wB95B80LVWQD/dQ44/6QjKTzPYu+faS
         paT1duDsmdf9FQVJ2LslvMN5QRY54avTBCo/4BmzoKMVZ2gzb2+8CEmM1RlW3bjm2sjm
         qReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715712504; x=1716317304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vm7+VMJI/p0xhaVdX07ViEoUrsc6h67q1AxKlBgBZ8=;
        b=kFvEVWrTVFncqk+KjLN7P51j/LN7DHvvJdXahCjWaLxYvF1OMeCCNFwm6oOKnFnLlX
         yJhC5/Tr/NDhuZbqzrASIrE+XsrJHP13L97y5XZOwBCaDC5rGn78l3R2AOExjugkQOie
         HNGYJIhwe3vwOdiJpSqUe3Q7yb4OvHeqK+ZzG1ZYhleSVtpNIsWgxftvu8Ljp+KoI9xU
         3QwtQD+Y7eP53S8F8L3l5dxNFsfdT7sBMLUvXUaQV1RIOQRkYCOoYk1ITSxQzqIa1XxW
         b/PpTk+uXb4T//bmvUGLxvZ94ymRGdJlC4bDvxdWb5gWStf/d7zMCbvE5gYkXKAIcWhW
         DRmw==
X-Forwarded-Encrypted: i=1; AJvYcCVqz3eh7fkxOf6Qs5GCPwx2ILEWkEA3x5V+2tlrbzOmgijpi2y5BwhuS6IBMf2qIaQfR1YGa3o6ugZhUm2cJ2H7duKDSmK/tKSXO04=
X-Gm-Message-State: AOJu0YwrSWAyDilYSfGG1+5SITz2donuh28dq3Jo/vsnXFs8wcp+G7Ab
	UVw3L3fVYMoTfnVOW+Q5rUeqyeBJ3dOOolwizTKdF5Ws9MwNv16tkhK3k7w0pv4YJP8e1ySapju
	3iZJkz+VjgWCKwI/6R0wKJvzFFL4=
X-Google-Smtp-Source: AGHT+IFTQ7WgnbVLfRh0vq9jLeG2jKiPAvDtPHj0qMEaP/Z4591SQ00dylSYeDQjDQGRWtYT5tsDRKs6U0EZSj2FSxw=
X-Received: by 2002:a05:6870:c0c8:b0:233:b5ef:3bab with SMTP id
 586e51a60fabf-24172a3d9famr14795380fac.3.1715712503908; Tue, 14 May 2024
 11:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41@epcas5p2.samsung.com>
 <20240510134015.29717-1-joshi.k@samsung.com> <CB17E82F-C649-4D13-8813-1A6F2D621C51@dubeyko.com>
In-Reply-To: <CB17E82F-C649-4D13-8813-1A6F2D621C51@dubeyko.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 14 May 2024 12:47:57 -0600
Message-ID: <CA+1E3rLxUnuv9E_BxCFj1aodOTp3yrOEh7cFYt_j-Yz+_0q29g@mail.gmail.com>
Subject: Re: [PATCH] nvme: enable FDP support
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>, 
	Bart Van Assche <bvanassche@acm.org>, david@fromorbit.com, gost.dev@samsung.com, 
	Hui Qi <hui81.qi@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 2:04=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
>
>
> > On May 10, 2024, at 4:40 PM, Kanchan Joshi <joshi.k@samsung.com> wrote:
> >
> > Flexible Data Placement (FDP), as ratified in TP 4146a, allows the host
> > to control the placement of logical blocks so as to reduce the SSD WAF.
> >
> > Userspace can send the data lifetime information using the write hints.
> > The SCSI driver (sd) can already pass this information to the SCSI
> > devices. This patch does the same for NVMe.
> >
> > Fetches the placement-identifiers (plids) if the device supports FDP.
> > And map the incoming write-hints to plids.
> >
>
>
> Great! Thanks for sharing  the patch.
>
> Do  we have documentation that explains how, for example, kernel-space
> file system can work with block layer to employ FDP?

This is primarily for user driven/exposed hints. For file system
driven hints, the scheme is really file system specific and therefore,
will vary from one to another.
F2FS is one (and only at the moment) example. Its 'fs-based' policy
can act as a reference for one way to go about it.
