Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6E128725F
	for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201580; cv=none; b=CiBuzrlZUkfsg8snxYLRCYXaBGQ5IIuiSTKFRUpec57uxyyvjFe1KwTRfNx0x5hy1wO3Z1mRUSX6TSGgqkbHT+b1Mdw+5KPg38f0yrrrld1iOexW2ueDiHO92kMxC7bTWvzic2YeOpIPNfrWLQToPBY8howSjv++86ZThNHaHeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201580; c=relaxed/simple;
	bh=OPAZZxNYE58hJae/e/m2Tf7VPpzwodHhO2tzCOR73hA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+5Rdkem1qoNyK5bAwJix8VaNBp3pzFsPlVEsNx4JxmjZ522xgzlS7YEvOaQB56STq3m8Shl9dfsxiZjH9RkB+pA81ZUE+vffDeaDght0ac7p7RT5wsvR4hmKkn3dQyXApKhlLYu8VD7W+p+hREvgE4ylH1Dpwk9/FlGwEt95JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=POHt1stG; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="POHt1stG"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-437ba5e649aso610786b6e.0
        for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 02:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756201577; x=1756806377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGNJFCgl4cuzHPkyc+Ken0/krtCf4Ypf9u2DKlmbJSI=;
        b=POHt1stGUpr2mPxf57ewGczQRQR5qIsikpfCJZv9JSeBu2TCuJRoFmC6aY50IY7hDw
         VeT3BXLjvsRGKbMfNTvD9uVYz7WR70YarJoSM/PX/1eHHmtR3VkHpkcGtWP44z8yXB/G
         ONw/+Z/vWxZrtSTt/Y0KpUx7LTe8PCbZJwzsa0EhHHHtXRPRHUniGpjfHtMi1d/k9XIM
         AA8B/SRxjP+VkSJ8tuDrk22AeR2BMxtB1dYnsipo8TmP+A+F+izpMY+il6CFkAkXrgcS
         134WZwQGfMHz/KK286ZNUmbdlnyvgzKKPjS4ju+1r8ATk6LZEYFdkn54f86mE4NFWJIa
         zwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756201577; x=1756806377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGNJFCgl4cuzHPkyc+Ken0/krtCf4Ypf9u2DKlmbJSI=;
        b=JRvGnMsBFqGHvi53M6lsx9v49g+VRc1gCSWdF0F6cMQlzStRGmRdMOyosmX4Z2Fmvn
         tgktIZNf6tao+c11XJZRuOegS94PPSp43QGCdpkL7WH+dUDQg5ikhTTAw4oxzbGR2R17
         Fs+rICISmTXNnXkxvugAAHpno0XKCC11h/kmOBVqas6aduWSEyAGO/xB9MFwaLkEs2Un
         1xmxzI5jS/xiGLQhsm+4yWxTwgH9kgF5H+Zyr7NlZHENws/i6qAfqw2HlgHBR5M2ELcK
         09+lWoJoaI+cSwBth6JvBdLOce0lLFaMqmwMQIwyADhxDIh8l1a22PKCihJgMRL6U4f0
         AISA==
X-Forwarded-Encrypted: i=1; AJvYcCXWxAnnSxNIBzcZZlO7fRoNI88+T70pkC2n/ba5mqw4eS45wRku3+XG2n+AAEnvKdZSKbSkI7RmKzX68Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/qnRGtEQu77DTlX311wGUvi9y7UugdwqtUXXc8tOz8eny8VTQ
	xepEFp7HF0sRneUhpS5TSFVr/ym3m1ZnCTGkAoSLXz7iQS92imeUCp11ooc88AydbIGjDrZQ0kl
	GlOzVOgw3D3lLAohhVK2t2XDFn8uyuOvsPVpTTWmoYg==
X-Gm-Gg: ASbGnctogaBubY+nboNtbQ8s4rDcYkZkfCFGCTYuhoYn3YGjDm6CCpiS05pXPs+7qts
	GZnRqKp64q/cIkj/P0fK5QDnxr+tB/65OzZdbO8JqTggfslo3lhtKt2Xie3/nKgiSQRpyc6GXEO
	PUbKNt0AxplI5aUQchr3GKOWHiZ0BuGNEb4Yr+VLEX0OyOxfUtHab4ZPMqIchDUAAk6QLVOM9R6
	O4pgZkDZgBn
X-Google-Smtp-Source: AGHT+IF5+Gw96sL9RY4NRRpY4/PqOPO6y5oEcC2tJqWM/kg3CPBQzUej8mAwKMn7/3T/5r3lecdpgQOOx/9Rqy2e5Ik=
X-Received: by 2002:a05:6808:f16:b0:434:2d4:f198 with SMTP id
 5614622812f47-4378524c0fcmr7225038b6e.31.1756201577356; Tue, 26 Aug 2025
 02:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822082606.66375-1-changfengnan@bytedance.com>
 <20250822150550.GP7942@frogsfrogsfrogs> <aKiP966iRv5gEBwm@casper.infradead.org>
 <877byv9w6z.fsf@gmail.com> <aKif_644529sRXhN@casper.infradead.org>
 <874ityad1d.fsf@gmail.com> <CAPFOzZufTPCT_56-7LCc6oGHYiaPixix30yFNEsiFfN1s9ySMQ@mail.gmail.com>
 <aKwq_QoiEvtK89vY@infradead.org> <CAPFOzZvBvHWHUwNLnH+Ss90OMdu91oZsSD0D7_ncjVh0pF29rQ@mail.gmail.com>
 <aKw_XSEEFVG4n79_@infradead.org>
In-Reply-To: <aKw_XSEEFVG4n79_@infradead.org>
From: Fengnan Chang <changfengnan@bytedance.com>
Date: Tue, 26 Aug 2025 17:46:03 +0800
X-Gm-Features: Ac12FXwhbCfrLvQfnya8JqMdT-q61XbBqqnKzdiMRp9wFxXNvgUveywUyXpPL3E
Message-ID: <CAPFOzZuH=Mb2D_sNTZrnbcx0SYKcQOqMydk373_eTLc19-H+cQ@mail.gmail.com>
Subject: Re: [PATCH] iomap: allow iomap using the per-cpu bio cache
To: Christoph Hellwig <hch@infradead.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2025=E5=B9=B48=E6=9C=8825=E6=
=97=A5=E5=91=A8=E4=B8=80 18:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Aug 25, 2025 at 05:41:57PM +0800, Fengnan Chang wrote:
> > I'm test random direct read performance on  io_uring+ext4, and try
> > compare to io_uring+ raw blkdev,  io_uring+ext4 is quite poor, I'm try =
to
> > improve this, I found ext4 is quite different with blkdev when run
> > bio_alloc_bioset. It's beacuse blkdev ext4  use percpu bio cache, but e=
xt4
> > path not. So I make this modify.
> > My test command is:
> > /fio/t/io_uring -p0 -d128 -b4096 -s1 -c1 -F1 -B1 -R1 -X1 -n1 -P1 -t0
> > /data01/testfile
> > Without this patch:
> > BW is 1950MB
> > with this patch
> > BW is 2001MB.
>
> Interesting.  This is why the not yet merged ext4 iomap patches I guess?
> Do you see similar numbers with XFS?
Yes, similar numbers with XFS.

>
> >
