Received: from mail-ej2-f0.google.com (mail-ej2-f0.google.com [74.125.228.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9833741B8E4
	for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785229638; cv=pass; b=lZnWXoWyjt/FxRUyXp8rsEEnVDdeTLNqT6TXoz7JlrBlBvqw3h/0gelOqOJ8Tm8z9EMRk5Qj5WhuhI2ujL1NdrqkagqWRVKRusK9Vsq57QxC6B4Hm8qjguNhIYV4mpAKeWhcZpa5p3M6UXNBZMqlLW3tXhzfiKQgvyekmHCdhVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785229638; c=relaxed/simple;
	bh=BzkmVaQlvoaPSg4R5e0sey1WW53XOeb6fyPbVfEuu8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpwB6HK1C/V6VfUl8JgNxmVl3jeZn877npijkk9SD75DgxDe/ReUf2YaXBsWjc7R1UzqTW0dyodMABwKIdpWz2wrJ72ZM2W20d6VfHS4HOuoK2D+xdRHZFdzJqmDqOsIAQv+uUMiG2RAWaszWW457yf4KYcbFykdR85TswhYn9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8UGApZr; arc=pass smtp.client-ip=74.125.228.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8UGApZr"
Received: by mail-ej2-f0.google.com with SMTP id a640c23a62f3a-c1c28af7b68so49448966b.1
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 02:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785229635; cv=none;
        d=google.com; s=arc-20260327;
        b=MxTu5DhrMY1u0TUwBMCW7AzXltDwoaSYbO3ZRu2IBI3oljQ1AlF7zOYIMnuwoffe4z
         rIzKj72jRHmHUjGFJD9yelYDjCeETZvw0MI9QVknjrHuaoBYcOMtu4ofvx2ZgRpV5M6L
         TeaU6LJbjvVNegyBsjvzm1TzQ+aMpdgiPCaqvcVLI7eMM97LpTJaRdfg00XXiCDE+Sgd
         RQJHcU5rDSRghyRRyhEQ50Owy+nMlxB4E3PuxgKJAc2NusIzGGSaVOwtRu369EG1OOH8
         p8GorWLxQpWdNx9koPeYg+q7em+Ihy9UFKMjWt9V00QbF/d+znEMBkmsLiaMqYRByzMH
         QYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lwoHhkNHWjMmK3fIidaZwkzYoYsP+0pbejgNyK7X5ao=;
        fh=jduQmgjBzVdayYGDz/tKSbCD3GM4dJOn7Se0tlR7xhk=;
        b=pzE3VpxAhcqmHwdN7tAIQbPE9eieCb3JR4VInl//udq26lQORbUDVFHyhxgSobgaqm
         2nidV7QM2pcuc+/imbGUwz3N/+c7Ua8710rLxdsy0RvjP4z2KDd4a4OoXch1uuCxYExH
         3BoYdt7u/xtwRIKx5KZ5At2P3ldfPIQEMJEWREnJPYwA0h3mpYed/xUmJZnMOz9eljUT
         qRzKPKi8zqKdjEwpMN5AUsMRsxxflvuwT0InaPzXQsk9gWZv09jcNm4KrBxFASbG20KD
         Oqyd/BFIs3u3so75AsgDlwOmLQlp8jaNOvaAhn3nfOU/mjl4yU7kvBoizeTtzR32PWRy
         bBbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785229635; x=1785834435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lwoHhkNHWjMmK3fIidaZwkzYoYsP+0pbejgNyK7X5ao=;
        b=B8UGApZrzBCFRPTyD4tPkNXXgNqi7ijG5CXMAg6bUbxU+DUNKT8vZUA4Bbyp1b82Dj
         s7eyxc1i4ECR+S/ao5PFCSTpzMBiz/HdqLV67ih54p8ot1q1ms1FVXq6URluDlIPkQIA
         I248cNE8aPT5APZ6q2XtJay/5k579FfvfVNDmihPZcTGYJUDLZqurrblTijf8tyhO+iN
         pzW8vBg/+ha43PdoGXeSY+4JAnIMz3AXMv+Y+A2cXRQ95Y7kHH7q/HE2dbiZDIKXNUGv
         sXrrqUKhfFYwf/mhGOBA5DXpn42Y6MolOueL9k1ap8IaVIXdm0cpG+Ym9B4kUydfp8xO
         aXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785229635; x=1785834435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lwoHhkNHWjMmK3fIidaZwkzYoYsP+0pbejgNyK7X5ao=;
        b=IcabjF7ui4ET3wdW7KMws7cELEJdFxXfJZnJ6qwUCwc6GeKP2NLk1KvfRKq5gDUZ4L
         uPh9l8rPHW3t0ythsLTwrZX6/dPr6H9dCRqypG0xZyROT+M9jrP74XMUEWaRxG1wQnBO
         dYkkhnMs5O34+C8PPkTsxEmgLBCtEoynNNDYu2mQjP+i5hktIKnfo7nUqLN/WhZ0jCy+
         Oxw/sbsTqQNj5Ms3XsjrfH4eC/t0/XA+Jbp+YVQF5YcPkAeWAtdKkCF9R4hcR75JUpFO
         nZPK1aZNpJEWNT5NUzDtZtSRwu+fcAZPotAmT+vR0CgzNln2XTLlykNqE6jqcNj+qIuC
         DT9g==
X-Forwarded-Encrypted: i=1; AHgh+RovHO86IKDhruVX7aN9VmFgMDByYKwlrNKfPpruUDhlLG8qTIcB93dNUsVNbZJoNzFW7vsNb7O5MlvTgg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb3Ec/8i4bo/PpthRebovUaOqjaNm/hBlJuFzaQRnKRFxVqwJ5
	+302tmA3pDy/j/NsMBHxioOcXJ+AdK1msG+Hypas+4OM2zV/Y3AG8Fn11PYNJN6gYYtogA0qNkN
	rfu4FiL5E1JhWc7cufQXaYvvoqDH1oI8=
X-Gm-Gg: AR+sD11QmqxdD31ZK/78WjyFKBUuFsLFWFbDNPcwt+6JERJ+mXBfBJnGvF4et2FFQvZ
	o6ZMMqiuRdBrU3Nt2Mp1QQ490Sfuay5W4kJarpBrDGhyk8b8c5bmtSEzLPPXLX5yVP8SDKj/cgu
	WH2OEjspXGCB3V42qevMP1VRIg2rvtv/E2hds9oLRtEDNessJEJ/WGRNfCzyhrSTYLrtXbGGdhB
	Jwk6YOaX3IAAK9cvbRaIb4IEyhGxtHkWxZhfiLA0qklY5QJJSuo6hDE5XoqcRA=
X-Received: by 2002:a17:907:7a89:b0:c1f:6539:3cac with SMTP id
 a640c23a62f3a-c1f71ca3465mr76349966b.12.1785229634516; Tue, 28 Jul 2026
 02:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260627070216.13511-2-haoqinhuang7@gmail.com> <amL1-Q-HGLJj16rG@google.com>
 <CAEjiKSknejc9biofmnJu_3xamZj8kuvbxiPuKp6phQJdGwQPCQ@mail.gmail.com> <amgB3pPhKEmFkMEQ@google.com>
In-Reply-To: <amgB3pPhKEmFkMEQ@google.com>
From: haoqin huang <haoqinhuang7@gmail.com>
Date: Tue, 28 Jul 2026 17:07:03 +0800
X-Gm-Features: AUfX_mx0pjIBAsoVkv4saK4NSXbSdxJsHGr2GmiDvL7l9y0ixXCDEbKN8E8OiBE
Message-ID: <CAEjiKSkZp_EL5j7=fYWfp+p8FPOQKeT8v6-Bzfe44vwaGgkHyw@mail.gmail.com>
Subject: Re: [PATCH 2/3] zram: add per-backend capability flags and validate
 parameters early
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: minchan@kernel.org, axboe@kernel.dk, terrelln@fb.com, dsterba@suse.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, rongwei.wrw@gmail.com, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 9:19=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (26/07/28 00:50), haoqin huang wrote:
> > On Fri, Jul 24, 2026 at 1:28=E2=80=AFPM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > >
> > > On (26/06/27 15:02), Haoqin Huang wrote:
> > > > Writing dict or level parameters for algorithms that don't support
> > > > them was silently accepted but had no effect.  Out-of-range levels
> > > > were silently clamped by the underlying library.  Dict read failure=
s
> > > > always lost the real error from kernel_read_file_from_path().
> > > >
> > > > Add caps, level_min and level_max to zcomp_ops and validate
> > > > user-supplied parameters in algorithm_params_store() before storing=
,
> > > > giving immediate error feedback. Also fix comp_params_store() to
> > > > read the new dict into a temporary buffer before resetting old
> > > > parameters, making the update atomic.
> > >
> > > I probably would prefer not to add this.  Again, zram setup is almost
> > > always automated, you figure out what you need to put into your init
> > > script once and you never touch it again.
> > >
> >
> > That's a fair point. The sysfs validation is admittedly defensive.
> >
> > My thinking was just that without any feedback, a misconfiguration can
> > be hard to notice. For instance:
> >
> >  algo=3Dlzo dict=3D/data/dict    -> setup_params() silently discards it
> >  algo=3Ddeflate dict=3D/data/dict -> same, silently ignored
> >  algo=3Dzstd level=3D999         -> silently clamped to 22 by the libra=
ry
> >
> > All of these succeed without a peep -- not a crash, but also no
> > indication that anything was wrong.
>
> We were thinking about moving from zcomp to crypto API acomp.  So I'm
> not sure if we want to invest a lot of time into zcomp.  If you want
> to have it then I'd ask to split caps and kernel_read_file_from_path()
> zero i_size check into separate patches.  We also probably want some
> pr_err() on failed validation, because just returning -EINVAL doesn't
> explain the error and doesn't help the (supposedly) clueless user
> who attempts to configure zram by throwing random numbers at it.
>

Sounds good.  I'll add pr_err() on validation failures in the caps
patch and post v2 with the split series.

> > > The 0 i_size for CD-dict is something that simply should not happen.
> > > If you insist on handling that then we can replace "sz < 0" with "sz =
<=3D 0",
> > > but that 0 len dictionary case is something purely theoretical.
> >
> > That's fine, I'll use sz <=3D 0 in v2.
> >
> > Anyway, let me split the original patch so the non-controversial part
> > stands on its own:
> >
> >   [2/3] zram: make dict update in comp_params_store() atomic
> >
> >     Move comp_params_reset() after kernel_read_file_from_path(), so an
> >     I/O error doesn't leave the old dict freed with nothing to replace
> >     it.  Also preserve the actual error code.
> >
> >   [3/3] zram: add per-backend caps and validate parameters early
> >
> >     Optional -- happy to drop if you still feel it's unnecessary.
>
> Sounds good.
