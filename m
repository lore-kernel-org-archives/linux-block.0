Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB70628F3;
	Tue, 13 May 2025 03:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747108166; cv=none; b=iPoWJ4/W1+xsoq/Fyt8q7NdWsBe0wGj4xR/F2/XgvKa5SQgMQFpdCTX12Av9caXqp6e2MeYJPaIRiQ2+0sVwecF38HK6HyrCAgg9co+TJN9LCBjVu+bETu3AOB6JUTPr8fPEk19BaSv1xAInp8gQS/8J8PmFye6GvN23qdD7oa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747108166; c=relaxed/simple;
	bh=B5emnEhV7rK6+h317wLkrvu0naAun4R/A9NHuDUw7EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyEm1DcP90VcCYVhOjlPiFYadC0om/TBDR/TiShCxTHwr1rje8faikIsFUhsgRk0AUTBJyRC1EVqkp/nmJPqDVKEDXFw3+WRA8zr3ID+/RTtGWicloqiBKJrm2xU6geiHj8JVNoQ3NZsTFD7s/HNsoGTvvPrXtj5TcRLxX2kV14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mq34X/uN; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mq34X/uN"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85e15dc801aso517579139f.2;
        Mon, 12 May 2025 20:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747108164; x=1747712964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kelwimxw1J10EuWJN16N1wQc1iJ7Z8c/Be+MQbkhh30=;
        b=Mq34X/uNJk3rHp+s1i+hkBiYIy/Hxil5rG2IuUVyGdApRGvZmoKo/uf5oHxkiU9wSY
         Hf5OhrEWrGCVl3DxmjiuQa6HMzc59xCOpbTv4468ML48SAOT504BMebRLLqZXHp2XLpc
         PYYBqmpZifg73FYkw7ngn0cWe2i0CRgFYqvMFjIftYIorg/7Df2ttfdqvWszzeGG1DDf
         sKwehd+TtrYzGXkgBEY7AxJcQnufRq9EQr8m97cmnZxSrju4jTgI9Br+1/vLnknYOI9i
         rIfqknNvdQsijsm7QgDoYlXNQeYGgKK/QorYhPhbamlBjq1hkGfTkG+TKuzuzTK5FGJr
         lnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747108164; x=1747712964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kelwimxw1J10EuWJN16N1wQc1iJ7Z8c/Be+MQbkhh30=;
        b=QdogOdr6PKuhcEqKPkOJOMCp5suF4WothMCWfKQ/X3TMrk/hdJfbGUjOBCce90XZ1x
         lNwptdqxWDaFPdbqIVwAs7eEWw5jagXXjEeQDCpbbwFuP5aY8+osRKQ3FYndCQOii1JN
         geZoNvJuRbitOAJeSMSaCkJwAxYOo5+9SRCZE2OgVERChwYW+3pMLP3wEo4W+WOzfuky
         9XEgXW+UEHvHnIAIC3m8ihvhnSd1/V7TmRaMA+JVAUlDzx2i8d1QfPW/PaDKRboXGEEi
         kr/82fRou9jyg0mgYQH5KFAXZgc2TIT4k+beP4V3Yymc59sdXxb/fxpEX7lnmqcbcFM/
         IfNw==
X-Forwarded-Encrypted: i=1; AJvYcCUx88gznZkm3ncmvUPYoXXKdf70qWpumNDW9qJaUxhMZ2qdzneVGOnnhOLwDz2gjZLmekeXJM2/eNVVrVJ19KPltZiA@vger.kernel.org, AJvYcCVPQ+vSVx3akGTrjYRjCCkfDhu8M1tSNAWmHO3KIxX6zHIyW99Pnryc3ZCsG9NXsZEdC/swGUkNvowIkA==@vger.kernel.org, AJvYcCX8nHsPXoxXj+oBMTuw0hgj9RPEmHP+17h6ECQDHr8jFTVLqnkyEF9RnLkPsRr1SGXIkiabRJtuAzmyPq7g@vger.kernel.org
X-Gm-Message-State: AOJu0YxJn8xvfobGLrKnXlsQ7raRvBT4F8uDfH+idnjF9ySgcWlXZiPS
	vOSW6QyfWWTK1DIG5EWe/hO948dB+IYU8oQMp62jFWEl55MmBGMzmAvM7xYHg7n85BT80lSmEf3
	mx6idINpHzUVusgaaH9wfaRs/h+c=
X-Gm-Gg: ASbGncvj86SK4nh7uv5zPFRBxXbCzSNVZ3XmR3o8r7ZcglG++VxPQDWnVA0hSARwnra
	U4iV6zhyCFfbjWSluph1u9xUQ+tFpo8WyiP6wamAoNVxnJTx1/h0nBghZFjFx4CxhKSOYMtbil3
	ME93ecJKpyxgdbw7E0M7oEBFdVW2ZUuEqG
X-Google-Smtp-Source: AGHT+IFjE4FbRR/B8od/jgDW1SV6SY3oauWIMT351boohnWbN7HnY+B9vHiMvhPZCtIpx+vClsUD+E5FWaAU6tEmsGk=
X-Received: by 2002:a05:6e02:1fc6:b0:3d9:6485:3a03 with SMTP id
 e9e14a558f8ab-3da7e1e1905mr169654485ab.4.1747108163755; Mon, 12 May 2025
 20:49:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512024935.64704-1-kerneljasonxing@gmail.com>
 <20250512024935.64704-3-kerneljasonxing@gmail.com> <20250512175156.7d3d4db53d40c7a34c1f68d6@linux-foundation.org>
 <CAL+tcoDk2TFwAWPwBN+dQQ+guxe71F_R1rFX_f9wozjPpujBAQ@mail.gmail.com>
 <20250512190427.b7fb67f6b78fd8699ea2811d@linux-foundation.org>
 <CAL+tcoD+VrRfAGMjj=9uAbanMO=W+cW0xgxMzVwrpiTgagmQ2w@mail.gmail.com> <20250512204124.5f201b7bcc394f773f2d40b9@linux-foundation.org>
In-Reply-To: <20250512204124.5f201b7bcc394f773f2d40b9@linux-foundation.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 May 2025 11:48:47 +0800
X-Gm-Features: AX0GCFs2F_R-Ar4I-kMwOiHRqfkRg38oeoffIIbXFDYnprxeRzCgc0CI1SjEfdA
Message-ID: <CAL+tcoAQ9MMXC1sMvFrdMhJWTooshODxoaz8Ew-hP5+V3TN9JA@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] relayfs: introduce dump of relayfs statistics function
To: Andrew Morton <akpm@linux-foundation.org>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 11:41=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 13 May 2025 10:26:45 +0800 Jason Xing <kerneljasonxing@gmail.com>=
 wrote:
>
> > >
> > > Maybe we don't need to check !chan either.  Can it be NULL here?
> >
> > It depends on how users call this. If users call this without
> > initialization of chan, relay_dump() can avoid the crash. It works
> > like kfree() which prevents the NULL object from being freed.
>
> hm, OK.  Generally, I don't think that kernel code should be very
> tolerant of bugs in the caller.  If the caller passes us bad stuff then
> that's the caller's fault and the caller should be fixed.  If the
> client code responds to bad input with a nice solid oops, then great!
> The caller will get fixed.

I learned. Thanks. I will skip the check for that.

>
> > BTW, should I merge this commit [1] into the series in V2 so that you
> > can easily review?
> >
> > [1]: https://lore.kernel.org/all/20250507134225.63248-1-kerneljasonxing=
@gmail.com/
>
> That seems unrelated to this work so it seems inappropriate to combine
> the two.

This series is built on top of [1].

>
> I skipped [1] because I'm waiting for overall clarity on what's
> happening with relay[fs].

Do you refer to this thread[2]? Well, that conversation/reply made me
feel lost. I believe you've already seen that. If so, it seems we're
working on the dead code together....

[2]: https://lore.kernel.org/all/70293376-71b0-4b9d-b3c1-224b640f470b@kerne=
l.dk/

Thanks,
Jason
