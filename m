Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7561923C4F4
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756114931; cv=none; b=Iz2xa9M+9HgeradsW9T5cvp122hb2boTW9097VYOiAk/UkIs8yBbeGFMMwdPo+k4MIfFiwXk0WnTxPSrKwbCojR9qjwhLx75g8zbNPPoKyo+SjQ0df7sMyQetqcoM2zsATeWZvdYKE0ooiz9y20iVFA9q5bW6WWlgtq0EnQnniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756114931; c=relaxed/simple;
	bh=qSxAdEFkr92eN+3eEeJ9Yx+AdgaO5dXFSmZHlto/gbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHLyipijgHrFcZOOuQEb+zWpELiWpgsKqtZP6m2bRfAVqh5UorODiEnZiWJ/Hav26EigWBvSHz41OBeohYfnCUaLrxLzI7x3fIOM99E1Z/F+ajDd9yljPP3oy+8POvsxp8TfPlNEcOYTSsKusJhOFT3Hckyc/vaA7eT81MtnRW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=T7KT1Qha; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="T7KT1Qha"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-61da7b78978so1563148eaf.1
        for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 02:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756114928; x=1756719728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GRu22p3tVeEW2VrGOdoxPvOS1mLmNVegFteBbU78nI=;
        b=T7KT1QhaStHCSKMvU7GPD2OmBkxi0cCXr3UmxNrRBbY+rXsozpojT9GP0Oo0Avidn2
         LyZ/A9hDc7l6Ju4MGsoVGzUjGLfSzpnS9JMMdf4bUwNAlSQa3IIjieSIuyQJAkuoNwe+
         VYlCu6LKO8xYSBeXQKG4PSOVBkILLEyQKwPTaTnz7uJqdNz1IU6R1LM9ZSd8zr+ueqHP
         Fu2PWhU3GMy8CLg3kjKZ67D+afTpvCJnrFjq4/k5ZGFPSM6JWBB3wH3IeG4lSUPmra9w
         bGp9GUC+o5Vc8dvF8aDUhXGyzbBlkfZk3Z3PPyd4nrXI7UOhXu6Fs7Qkuz6uJa6AE2M2
         3UfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756114928; x=1756719728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GRu22p3tVeEW2VrGOdoxPvOS1mLmNVegFteBbU78nI=;
        b=Qk9MgFPrqQ0OLrurEzLfZ5ZuvQBYbvcCD7djb2eSVDh0Gd55mS5cEI77dWpsqhr8UD
         y+2T1Lr6EhNMR+u1Q7UIPjvPpI2yWUIIPLvAfF2/k9jaTqvcXXAvRjgCGB0ajOU4LEJ9
         YrERqn+A2ajdKjof5KUuYcAbYOcY5G0MuLNPH7az1J+UKwt4nfwXmNusD2eFJH44E7QX
         +gXaSXSqEhEfDWeOIeUwSglRaM5chVvzUQwmqQOljloUQF3FyWwTgQtG2kTTnbRrb1J8
         KcodwpgDkDotI/cYmgDVonbd5E8z2c2HIcef7md63JhwAhlkAmmp/K2KFC4bafklaBv4
         Tqfg==
X-Forwarded-Encrypted: i=1; AJvYcCUWeI9keLNA82y6dP4vG/4C0nGgq3Yyrv28jL+soL4c39JPdOmUdW05FuLFrBaAAIzMuM5Tsmul77+oMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwrbQG92S8rDOLl2BpyaG1VcFSVyHRow2SlmEOJ/A/KL1I37xA
	5Ogrmj55JsYcv1PRGimMzHMgBh9UtRKxiPNJIl4Ve5iIsvs73Uel4tmUiLklf3J7+//kHPldCWd
	vAdbVTTIJUA5jW3hibkUJPGqxVI/Ka2k5tQH17CLAkA==
X-Gm-Gg: ASbGnctfv6s1Noh/5Zf4fMWzL/zli18kRAt3zfZ8Oqsl88jjALzuoIWmxsCqDeLqLXP
	Flspxo6ykT4GygUavtRz4pyaiXWm+2v2QzmO8oz7lMfSoHjA34ZkF4wIodYYkuglXNgJm4jPX3U
	PdD0BAhs3csZcfdcanMOBeuhEV8FEj/0wAQm3KCaqut1p5PENr3aVVDku3ZL7rLrBvl34XjRgkM
	IFXhcQcdvFA
X-Google-Smtp-Source: AGHT+IH9whC+Nt+KP6zMOInVqQwfTRZ9vyaBO1gLszlXrDLuQ8rxx0C4w5IQE2c6Fn1IFfz6+QQxtpnzgbhuqH3KxgU=
X-Received: by 2002:a05:6808:1883:b0:40b:2566:9569 with SMTP id
 5614622812f47-4378525e610mr4960520b6e.24.1756114928355; Mon, 25 Aug 2025
 02:42:08 -0700 (PDT)
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
 <aKwq_QoiEvtK89vY@infradead.org>
In-Reply-To: <aKwq_QoiEvtK89vY@infradead.org>
From: Fengnan Chang <changfengnan@bytedance.com>
Date: Mon, 25 Aug 2025 17:41:57 +0800
X-Gm-Features: Ac12FXxB3S3g0sTu8keoah4lgnqnAcyUyXsuVt_e56y_rQP7QRz4QmS_1ZuROw0
Message-ID: <CAPFOzZvBvHWHUwNLnH+Ss90OMdu91oZsSD0D7_ncjVh0pF29rQ@mail.gmail.com>
Subject: Re: [PATCH] iomap: allow iomap using the per-cpu bio cache
To: Christoph Hellwig <hch@infradead.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2025=E5=B9=B48=E6=9C=8825=E6=
=97=A5=E5=91=A8=E4=B8=80 17:21=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Aug 25, 2025 at 04:51:27PM +0800, Fengnan Chang wrote:
> > No restrictions for now, I think we can enable this by default.
> > Maybe better solution is modify in bio.c?  Let me do some test first.
>
> Any kind of numbers you see where this makes a different, including
> the workloads would also be very valuable here.
I'm test random direct read performance on  io_uring+ext4, and try
compare to io_uring+ raw blkdev,  io_uring+ext4 is quite poor, I'm try to
improve this, I found ext4 is quite different with blkdev when run
bio_alloc_bioset. It's beacuse blkdev ext4  use percpu bio cache, but ext4
path not. So I make this modify.
My test command is:
/fio/t/io_uring -p0 -d128 -b4096 -s1 -c1 -F1 -B1 -R1 -X1 -n1 -P1 -t0
/data01/testfile
Without this patch:
BW is 1950MB
with this patch
BW is 2001MB.


>
