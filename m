Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3C021C180
	for <linux-block@vger.kernel.org>; Thu,  9 Jan 2025 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736434944; cv=none; b=AnCTThtPFTKTmyMwMxlnRnlcGKBWMilVq9YafvkKhcstAKv9ZKcLj0hcSBFzxdfZzqydT2vooHOyVZgd93rMQ1qbXmB4BVpqpAoXCsRoCUI5oW/C0jC4xc+K4JArw3ZoafzoUSLPAWxGBy/ZEgRlFkoX3HZfVTReGaSd8SfUxpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736434944; c=relaxed/simple;
	bh=Bm3USTPGU8ZwzzZeLYZOYCuMRn5v+GbpFizdZkmPpss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObpA7EwFOHdOy+SaFIU5/0w2QW34mkLZ+gbg0zaX3ciOOBTK7M3URrZWG9Vmhkj/T3w2T8EKijAzCEktVd+piYf2ht5YhUcoAg6Rl2SobdBSAf9azmVpUrNpT9gi/JyIxDLvOFcqbLG1ByEtz3ZaMLIbYUYwQ9O1DDAPEDcEO/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWlFy0sI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWlFy0sI"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee397a82f6so1822703a91.2
        for <linux-block@vger.kernel.org>; Thu, 09 Jan 2025 07:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736434942; x=1737039742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=On6gUqbHqnq50bUuhNL7KyH87lNu1/6Z7WKXoZ05mac=;
        b=nWlFy0sIVRinj1q2/pTYNXZTmx1U3IteDUoGivOeILYal5KVLvwQecikQZoRxDH4QB
         UPw6MaSAqH6MoTusdOFUQVCVYcgl6SPsK84MiS9npJ7AE0qELM6xSVeenZtnPfPBUENI
         Whw6QIYk0kx0I4Us6pHcH1lCP+8CEPnXVU8YpsVZ8vEQNlGDZtldPxQiNFl1eRud0HH9
         Ye/5cE3c7tLjke7EqIO7jnanXSYrIvzlJyndczDCuNeoFO0Ks8zLXhZ2PqnQdiA6+gR/
         8ZVP6Cvvg9UqkwHvMi5MQO61KPvggshFXEbTgp8c9yF1Am29YsonjtAxWCv0sg/qxv8Z
         Be9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736434942; x=1737039742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=On6gUqbHqnq50bUuhNL7KyH87lNu1/6Z7WKXoZ05mac=;
        b=t1axpJ99WysTRlupkj+9FBLy84ZGXf0+wVL8rYNb8USxICIROi3w0gt/iQ2Qumvaql
         WTr0yYohmn+DL8MOqpvcQASMAduR5/0MJwKIIzQVUpWTwyULo3hysTj8X5NpaaHmgKtX
         JDmQwQCkWFfseES5Toqe5ogjuWJOf0ntuU3bxjwJEVs3KH1Mxk9Ldxeo/uB5coGI/EiS
         PkcWGSdZm6pIdsUN3b4i9Ak4er8lbWYosNn512g6Zt8g6E54h6H7vpxfM8EQtYdqOmhR
         GUmyTMRc5Er6sYxFI/iiiSz1Mla0GhpNFzIQBWIOQ52qtSnUImAkvWkfHeUKBOlE6ain
         XstA==
X-Gm-Message-State: AOJu0YxStjF3W5sXaeHZk21QOVW4EljT9hLzKTTD/vSKwmCx8L/ZuumX
	G32vLM8cPj6RcLj6HUgt/VB/Dwr82dvn3QPTjuTsE4WmMy3wZsx8co2cdT5cjvDs5C/aArbkuSY
	QFEqgi226+ffYhVUBiXYKPoxNB9s=
X-Gm-Gg: ASbGncv1gVQDLvwimIM2VjI+R+3I+3tXJJPITfxH1/7fqKg0JR1MhedcQXuAtYn/VXM
	jbZE9qgQip9XAMrtME5KHYOw0Yz6RUR19Zqdo/ME=
X-Google-Smtp-Source: AGHT+IG9gewI8qk3H4xak82FBx0uVqOQbWiC4q5+Ll933ka5xH7q2RIDqfI8rLuz8GRhKcc3JtMffTfHek0SEH9qROc=
X-Received: by 2002:a17:90b:4d05:b0:2ea:83a0:47a5 with SMTP id
 98e67ed59e1d1-2f548f17337mr9957118a91.4.1736434942314; Thu, 09 Jan 2025
 07:02:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOBGo4xx+88nZM=nqqgQU5RRiHP1QOqU4i2dDwXt7rF6K0gaUQ@mail.gmail.com>
 <20250109045743.GE1323402@mit.edu> <CAOBGo4w88v0tqDiTwAPP6OQLXHGdjx1oFKaB0oRY45dmC-D1_Q@mail.gmail.com>
In-Reply-To: <CAOBGo4w88v0tqDiTwAPP6OQLXHGdjx1oFKaB0oRY45dmC-D1_Q@mail.gmail.com>
From: Travis Downs <travis.downs@gmail.com>
Date: Thu, 9 Jan 2025 12:01:45 -0300
X-Gm-Features: AbW1kvZbCQ2XhvyQvFcvBetrl-h_bhWG60fH3_8AV80K-ihMScSbi3JTQPr2Nt0
Message-ID: <CAOBGo4zdDQ+mV_5X1Y0J2VpV8F63RsBs66Xq4CHPtpBu9MFebg@mail.gmail.com>
Subject: Re: Semantics of racy O_DIRECT writes
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 11:16=E2=80=AFAM Travis Downs <travis.downs@gmail.co=
m> wrote:
>
> On Thu, Jan 9, 2025 at 1:57=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrot=
e:
> >
> > Don't do that.  Really.
> >
> > First of all, your program might need to run on OS's other than Linux,
> > such as Legacy Unix systems, Mac OS X, etc, and officially, there is
> > zero guarantees about cache coherency between O_DIRECT writes and the
> > page cache.  So if you use O_DIRECT I/O and buffered I/O or mmap
> > access to a file.... all bet are off.
>
> Thanks Theodore for your comprehensive reply. I probably was not very
> clear in the way I posed my question. To clarify:
>
>  - There is only one process involved here making all the writes
>  - We do only O_DIRECT reads and writes, so I don't expect the page
>    cache to be involved in the usual case (but we can't exclude it entire=
ly).
>  - So the question is large about the possible outcomes of doing a zero-
>    copy O_DIRECT write (where the block driver will ultimately be reading
>    directly from the pages allocated by and passed to the kernel by the
>    userspace application) in the situation where a portion of the the pas=
sed
>    pages are modified in a racy way by the userspace application by a
>    subsequent O_DIRECT write.

Sorry, the last point above is totally wrong (insert excuse about coffee, e=
tc
here).

What it should say is "...where a portion of the passed pages are modified
in-memory by the application while the write is in flight".

That is, there is only one O_DIRECT write here. It is issued, and before it
completes the userspace writes into the same buffers that were passed
to the O_DIRECT write, modifying some (but not all) bytes.

Do we have a guarantee that the unmodified bytes will be successfully
written? Can is cause some corruption/inconsistency in the FS or block
layer?

TIA
