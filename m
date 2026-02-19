Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD9728852E
	for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520551; cv=pass; b=jngqsGeRk3C2qN3kMeTCKgYCkSbd/Tn5sym5EKaOfNB9dLCP/hYEq/TBw4MO25ASNwMyV3HAS9iyudziliS8uV8ENezXvtrj1XTaUZ0ifm0Dj+t8qtTOviTKjkvB16I9YAePUYTca9PG3QooKUfMv1VWHT1kGnjL22vJ0cxke+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520551; c=relaxed/simple;
	bh=/zWJ+yo0uWyhP9CbJPR+V3kvYG8Kxn8fQw7DyIJ5tc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OPj0SUCjy6L34bnY3LftjI1cbDC38SNxIbGYIeJQgTmLEhttyAzF7NdBiRLInWUnF7fFORrd+1uZ9vY4f5Mi0FguLRpnVZmkv9GnpJPf36UmBPrKQKZ4VoL1IIBrLmbxItwD/b/plqs8WqVpR9c/PIAGkfnGLFOlM0B1yswfeK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qfkf32BO; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qfkf32BO"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-566fe6a4ceeso589049e0c.3
        for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 09:02:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771520549; cv=none;
        d=google.com; s=arc-20240605;
        b=GnL3bg6GMhoEDZmh7vRLdfkfC2MwAsMSrNb1ZmqC7VXPFs4a4vJGmU2K7Fmmqh+Fvj
         ckPDfkiBJFkxtn0MyitQ2wszlbgPP8HOFVoirCRldXsc7bf7PsGfUcBEgBR39/K/3IFg
         zAircbqo169QaWH6yRKRyno+AT1FlW5DnpyGrP6vtIaKgJdXJxtsAUd3+PpBq7LzHW28
         +WTcBTHrW5D5ID2mfj6YgEbztf4VXILBgoKalD8OK1TEAt3T0jOsIwcuJqjpX4+dHrPg
         nCg3gxAsIC7cdDG/ajJ3fW4pGtuDBeCPE+RYZNHYtop4MYRXYRu/XJrsW/F+IHuIPJqw
         qmEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/zWJ+yo0uWyhP9CbJPR+V3kvYG8Kxn8fQw7DyIJ5tc8=;
        fh=tnUOOH44wcfYxy3XRaAAXleGf5eFIvNW+6iLP9y8EBw=;
        b=es2z2vlmmxkegSZfUrTK1H1keNdyMq1RJPDfsBSY+yerid6RSKOJ2KB1oLnSUDuaJn
         ecPAzJnvMgQQ7KB2hW3tqSMH84b+xNeHFpHdbphw2p0ySqE6om3mwHOMH9FFCLk5ngpk
         H9d1aAfhOKGB6jYDAFxWy3YO9KY2rYdHdjBxv/8AtP7FssqmUZdZYk/uKwHH3BWAqoRH
         PiqZcpsNN1BNPAYSDTh65Vd9ZgpNp3Kh7NliROmvv941RDeqP03V0AR+Q9xR6EVC3225
         SEML0/pGqshDbN+wtstpQCehee4xhTyR5JrwZTD/0N4+DPlf8AaORsrJRF/F8cmYC2lO
         tBsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771520549; x=1772125349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zWJ+yo0uWyhP9CbJPR+V3kvYG8Kxn8fQw7DyIJ5tc8=;
        b=qfkf32BOgf5VmS5grdbbB8FaV8VTyDCM8lk0huNCQy1JWukEw63r2ntd7AKRSFGlLt
         KbAiB1ZMq7XIby2uvnqSwmWL8+9lIBPArDbb2mXqM1c31HdMmZnyRM7TcFd/KpEMIqRc
         s9QHm7JGjYT/Vf9OodwV2503xVA0wagAXcqZ5my9PLl7mOstZI00cYpYTiuRl8uVM1+w
         G6T0c/36yhgLU9Hjx7v8iwkZ43uQznDsGEi3muXCUI7AApr6HkNADPIVU44KImqQHdZe
         KCnoYGRoHc9K/dRm3mUWDeNk6nU6BqmshxnzkHrfeBjCd13dKOri6ULsKs1xIUaJOiGV
         wCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771520549; x=1772125349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/zWJ+yo0uWyhP9CbJPR+V3kvYG8Kxn8fQw7DyIJ5tc8=;
        b=IfECU11VtK6p+IWP1ZKUqk9CtH7jngiIGCctLQ/FK/0DX+C5A/gK/A2voDitGQrhmD
         9XMZWj0q2WhCZ0VZJujoX3yBmFSOMWgYwxbCh/8ce3P0RBM1tffNmGu+3tD4vEcZVc+l
         yHxkybFKmG/ISgrYNnWpSbDnWO8W8BiXGjbOjQ3RmA82t5CwbyydmHeYV38kw5pf2VoP
         ai/D/EZuIqgCy5LSOupmarMKlRnk4ASQo43LuiQ10X6KwcQWQDg4ugwWV6lH1jFGY+bC
         D6dnH3ERjrDwnmy+HV1uIwaoaio5stRqqrNoAmXAnmxylnpAyhBmzXcL/ctYwgw79+NR
         l1KA==
X-Forwarded-Encrypted: i=1; AJvYcCWqhNvb5hKw6r58a11t+PVBbfgbi+6VbYWyr0jwtnMXA5FiiXyCKxCcFM/ja33z8wNcB1SSjaPxJCijMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzX/8UwPQd+MpaAISMla3R6CjjuPxMfSSQkLhyAH/RAbB/3QxPM
	CqwStJJIpz2FYOi3C4TFC9JrOVS6TnUKN409dRM2szw4BjsZ5wF8jEfbR+rKNEzzqScSP2/tL8x
	oL+1+JrE8fk2ZT/bSsHUqXN9WVG5oykCdxycK5o4=
X-Gm-Gg: AZuq6aIE3ufOpY7vebzB54/n1qn2aqg0K7VDBmIGZglYgvMwGAftxqnF0DVr3urgs+v
	IH4u/oGji1EKzgUYUxvMH55xLZAYkxIgzNIps2XCCqs+hDc5OyCkrxSNFvSbmdo7nCRu4vRwTVS
	9gB/Duvxs4jCyx5N9vLPqtO2UcuA68uk8AdWCAOktR87YhCNOL4mAQxijLj/K4jhW1weSnKm60a
	sIudBSitGnpB4QRnQaKmCFeF1kezKNNQDE3I97+bNyYcx55L6RNzRmkI+csNSUJa7Fq3zSE1L/6
	0+1qivmbxCRlfe6LFpRvskhzGytZivUnxsjcNo3dt3nkfAM2DcYDaMumtMADKm6LzV1P0YM5Ukt
	s1eTGcwRVqTEWsf8=
X-Received: by 2002:a05:6122:4697:b0:559:58a5:f6cc with SMTP id
 71dfb90a1353d-568ca05a44dmr1524327e0c.4.1771520548717; Thu, 19 Feb 2026
 09:02:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219004940.2594201-1-morbo@google.com> <9b7a107e-bc07-4a75-86b0-2685d4c78bb9@flourine.local>
In-Reply-To: <9b7a107e-bc07-4a75-86b0-2685d4c78bb9@flourine.local>
From: Bill Wendling <morbo@google.com>
Date: Thu, 19 Feb 2026 09:02:12 -0800
X-Gm-Features: AaiRm52K2phby6B0LVCfjC84-04vACxNG1HiAWWFfdJSIXimlGnCZ2cIAgOG_uk
Message-ID: <CAGG=3QXcA7et9LmZ+Cu8zn1yBXrPizL7BhYFvfFZpWA7aUR3xw@mail.gmail.com>
Subject: Re: [PATCH] blkdev: Annotate struct request_queue with __counted_by_ptr
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Kees Cook <kees@kernel.org>, Gogul Balakrishnan <bgogul@google.com>, 
	Arman Hasanzadeh <armanihm@google.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 4:14=E2=80=AFAM Daniel Wagner <dwagner@suse.de> wro=
te:
>
> On Thu, Feb 19, 2026 at 12:49:35AM +0000, Bill Wendling wrote:
> > The queue_hw_ctx field in struct request_queue is an array of pointers =
to
> > struct blk_mq_hw_ctx. The number of elements in this array is tracked b=
y
> > the nr_hw_queues field.
> >
> > The array is allocated in __blk_mq_realloc_hw_ctxs() using kcalloc_node=
()
> > with set->nr_hw_queues elements. q->nr_hw_queues is subsequently update=
d
> > to set->nr_hw_queues.
> >
> > When growing the array, the new array is assigned to queue_hw_ctx befor=
e
> > nr_hw_queues is updated. This is safe because nr_hw_queues (the old
> > smaller count) is used for bounds checking, which is within the new
> > larger allocation.
> >
> > When shrinking the array, nr_hw_queues is updated to the smaller value,
> > while queue_hw_ctx retains the larger allocation. This is also safe as
> > the count is within the allocation bounds.
> >
> > Annotating queue_hw_ctx with __counted_by_ptr(nr_hw_queues) allows the
> > compiler (with kSAN) to verify that accesses to queue_hw_ctx are within
> > the valid range defined by nr_hw_queues.
> >
> > This patch was generated by Gemini and reviewed by Bill Wendling.
> > Tested with bootup and running selftests.
>
> There are some tests in blktests nvme/* which do change the number of
> queues during runtime. Not sure if selftests have anything which is
> related to this code path.
>
It's normally fine to change the queue count just as long as either
(1) the pointer to the queues is also reallocated, or (2) the count
never goes over the original allocated value. (The second one is more
difficult to check, of course.) The bounds safety features that Apple
developed, and which are slowly being sent upstream, enforces (1).

I'll run the other tests, but I'm not familiar with the blktests (I
downloaded them but haven't looked too deeply into them). Do you have
some pointers on how to run them with a newly built kernel?

-bw
