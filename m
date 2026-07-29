Received: from mail-ed2-f0.google.com (mail-ed2-f0.google.com [74.125.228.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2EF2E738C
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 04:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785299140; cv=pass; b=tASEj+AaPy1uPDzXQXM1nSN5P+00wA5Xro+W8ZK+R9KNmYub+anu06FZrh+wH7KKibQk/te8b5sPzOvraox/jrb/1SSsCOa+6ywuj9yU5ldqmocMC8npqMwq1CwZqTSeTnQMtXsts39+9s2E0hrnYYzcAvpRM0rS4HR8srPe1KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785299140; c=relaxed/simple;
	bh=8SgI6SWa6CcPUq4s/IHE4WKcXu0Y0JOx4DOCGfadhSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovqb+Aa15Gt96RYcPbRVYBHzypSJDaWJxVuPQESwV3RyNTr8/OLGq+ZKnVd3LZ8ZRJo+95JpOzfroYmmV6DlJ5K92qRkrmINwHPER3URB2UQ9UqDsspIx/Wm9PDnH0BhRhSkwmvwi6Xxgd4oJg74DGUabO1VKuuIZgM/RX0nOOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POBq/QRi; arc=pass smtp.client-ip=74.125.228.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POBq/QRi"
Received: by mail-ed2-f0.google.com with SMTP id 4fb4d7f45d1cf-698447ea5aeso182697a12.0
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 21:25:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785299137; cv=none;
        d=google.com; s=arc-20260327;
        b=DY8ILDS7k0E56SF6B1+gkKB7vyRx46Gk0CtM+cSKC2e/8Afonhu515cKJM4rqSx4/k
         XVvgBidRN+eNOKdNqE528UZekyoRiSwyfOFnoAYEgAgXpFkXT+/JCQ/vRKcUx/D1+HrI
         dewSX+ANWgr0rS7lCcBHbEcBDHga/XZLL/qnm6l9cHZbJZJ1/Mhz2mXvh5ZW3B0BBVNz
         l+xoXxqmozlnakXqlxwKXnQavB8eMkkjAwrTIOjH3DaIONtv2awTFAXRRwfgFtHzJlKK
         c9mMko8dv1y/xA7bDrYt8PkicgqqMBymXDSoilcDnud66S/p52d+WJwZqACpOa9sV34c
         e8XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a9DT/U37lv32n95vDYPp+7XoaPzW0M/vlvn0D07QY/M=;
        fh=BafWhCzNvtfW9sj/Qx2CKjQk+fuEK3toMlQQK/HBvFs=;
        b=efM0Ihgt9i5bXpELkhTp7qGgF3xHMxkYhacaZ/+PreDlidDMXloMYXcy9pN2ioXFVn
         oChY11tXFDVaOrmsit2ztdeZ9uyM+cDRRG+QLExm8Fgv2Z9AqicPhoCiBFM89Ht56Y4h
         9HoZu9RICCGBTTvIVE6xeKAHas2UFJVJNvq90TSkfh+9MB0c3hSxFqpYTgr4ngObrB8+
         vStMmqGwRY9wpQpnV52jS7xNCK9RoEGV/cF4m9Nu1yA03p2eOJyRCjAp64PEcLpHb0rQ
         5EjRDaZlQqi/WQtCP43Eahyvs0t6ZJ6VD6i6UnHdse35qq4zYbujcwU86q0SiLmaHB72
         VXOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785299137; x=1785903937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a9DT/U37lv32n95vDYPp+7XoaPzW0M/vlvn0D07QY/M=;
        b=POBq/QRizFzBWhwwH7NQT4xvRm9yF7quM8Wae0yd/ejg/LEgu7FFdZOtF72PnBiVER
         G42Of5VAGVJxOGwtDfM5fmJfoj4cKh/iN2jmvLjcicRVZgRjnzFAWxwY0+s3u9yj+4jw
         ue1PTbnREu1pkudSK8OC0bRYOBbZm3HLDa7uw3NE4JmoSApk/NBIjIMfFvqTV/c8jvaf
         /XDsusMsRvfTNRM9io22PnFsU+e/Cjpsqv8cJAGYoSlPcoVNITKk0HQ6Afvuk/+XtKom
         onj40cXBKlxeFK6bbspjUAmGewYdfWLVR+R/3xwF0+k281kFj9kLSbcFKwsP33XrXeD4
         SZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785299137; x=1785903937;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a9DT/U37lv32n95vDYPp+7XoaPzW0M/vlvn0D07QY/M=;
        b=CflO3sskXbfEX/S5EwIUzeC6ueOA+trsVPUN5ub7rgRVwx5kyNIIiWhswzA9L3ZSUP
         EBgKSlce05BfcCziCaTPWy/PYGO+QrsZdzisXgfjw9ygG6bLuGGICMIOwuVueojJWV7q
         j3iANoNTUN1k4/W/zk/6py3Womj4RGRsabjzsNtJDtYh8TATSRehLvB+Rr1vdUkl9Grk
         U/EPupQmVaxSTWmkzAashSc/h6kW7eRolG5qKiGNQJFU7kTB9UZydXdNz7BUDH9Lm/LZ
         YNDM//GXK5s72drmBT39iYI7L/pMLi2WLOyj/c+xT0C+GBF5SpkOhABAVSjtwuQtuSTY
         BYOQ==
X-Forwarded-Encrypted: i=1; AHgh+RpbvAk6RzxgTDE+8cZ6T9YDyi4FwUfi9yiJ7Yt8ixEHGrZvuDJgulMwal03E6YKzW2t66MilwXGApiATA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtHymAPooJ9yjA4WfixWwr5Q3egYcejqrnI2d+R73f/WNAIGlz
	5xjHfCegVFra70jzQLLxCbBUq8Mv32cvcleBrq5dCXIg8vUhtsvT1Opdkb6NlyCPn6B/oHPLIik
	QX6VurMvOD+I9AGvVwREmgrH1RiYUZ8Q=
X-Gm-Gg: AR+sD11+3E0umEXhl09MzRfij0LSkbmS2tA2OkWW72c+g7Ob1YAzyn7GJHqUZImHpma
	nM8jxPrxq7e9xeucqEmaIPYY7ni3B7QfpjNFH8bTrCrDFn/1HQDB3qZLuE4JOKKLOiBD6mXjH4Z
	atT6eX6aE5KAOc93SRJ3arA7gVEC28bGmezSyCw3ULy68hY0I0oqkyqXgMRxI/k4UaeywwNKhl9
	wV7rGutm5KVBnaVk6AlGc6AWMiRmKwyXIKuZQ2Q4Q/kzhZBlFxI/t8gG4SbbxEktKH3QVtm4CTh
	eoS9ripwDyrNvTZLd8buXv3xre/qheRIo3lmg74WKI80jQ==
X-Received: by 2002:a17:907:94d5:b0:c12:86a5:3ada with SMTP id
 a640c23a62f3a-c1f72142f16mr296693466b.36.1785299137194; Tue, 28 Jul 2026
 21:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com> <20260728092935.31139-2-haoqinhuang7@gmail.com>
 <amlk3lqSbtfEOkbs@google.com> <CAEjiKSm_q1X4O9H44raKYYo8WQRxNRBUN4VFi7+-JW_JkWkbVw@mail.gmail.com>
 <aml9GPvZ3lUdnd6I@google.com>
In-Reply-To: <aml9GPvZ3lUdnd6I@google.com>
From: haoqin huang <haoqinhuang7@gmail.com>
Date: Wed, 29 Jul 2026 12:25:24 +0800
X-Gm-Features: AUfX_mzAte1rkVeXrYroIkGrwE99yrOx4hbStb9LMtbvlKUL1Vw05vtdxXl63Zw
Message-ID: <CAEjiKSnj3C8n6CMrzyweMAYYv5qNAsd4iPk4zCbaSiwJqMUtmw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] zram: make dict update in comp_params_store() atomic
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 12:16=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (26/07/29 12:06), haoqin huang wrote:
> > > On (26/07/28 17:29), Haoqin Huang wrote:
> [..]
> > > > @@ -1699,21 +1699,23 @@ static int comp_params_store(struct zram *z=
ram, u32 prio, s32 level,
> > > >                            const char *dict_path,
> > > >                            struct deflate_params *deflate_params)
> > > >  {
> > > > +     void *new_dict =3D NULL;
> > > >       ssize_t sz =3D 0;
> > > >
> > > > -     comp_params_reset(zram, prio);
> > >
> > > I don't see why is that a problem.  All you wanted to do here is to
> > > handle zero i_size.  Why do we need dict setting to be atomic?
> > >
> >
> > comp_params_reset() calls vfree() on the old dict and resets level/
> > winbits to NOT_SET before reading the new dict
>
> But what is the scenario here?  Who would have several dicts?
>
>   echo "dict=3D/etc/dict.foo prio=3D1" > algorithm_params
>
> and if that fails then
>
>   echo "dict=3D/etc/dict.bar prio=3D1" > algorithm_params
>
> I don't think this is something that we need to consider.  What am I
> missing?
>
> [..]
> > The "atomic" in the subject is about all-or-nothing semantics: don't
> > destroy valid state until the replacement is confirmed good.
>
> I don't think that "valid state configuration replacement" ever happens.

You're right, the scenario I had in mind was a bit far-fetched.  It require=
s
loading dict_a first, then trying to replace it with dict_b before init, wi=
th
the second read failing:

    echo "algo=3Dzstd dict=3D/path/dict_a" > algorithm_params
    echo "algo=3Dzstd dict=3D/path/dict_b" > algorithm_params  # fails

comp_params_reset() would free dict_a before dict_b fails to load. But in
practice params are set once before init and never change.

I'll simplify this to just the sz <=3D 0 change in v3.
