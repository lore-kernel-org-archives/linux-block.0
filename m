Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C48325716
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440084; cv=pass; b=KxTrtihF3BnDtly5RE7B9zTtvR78QUqzddf6oHsGe3xBXDRbCYXm3rUzzW/wvFea+v+looClw6R7uaELKgERhObX+Wo5M06bwZcWQNtgT2e6zGlfSWu0W9gzN5DQAAaSD1LoSF36r2+1C144btiTUbcYRAME1WULu5losM+quaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440084; c=relaxed/simple;
	bh=zKyD1uZIv6o9CJr5h7yGV2+l3/ZLwRVWMPaAQ4gjTlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDTePbDTlgMR2OlZ4sQdAlse0PWxDqh6yDK/ussoZT0IX6vgNhg4sGWsEZdsIkzlP47qwIud+BRVyx82r2zpuQFLYgm+uKJBDOQ4x0GM8aN+UXLh9rKqKu/RxgGjQMN8015Ny3oEH4veKgtzX1nCP8WNW9AkDZOv8R/mXvE6RpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Eeav3oxN; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Eeav3oxN"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4231d1dc4deso172284fac.3
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 08:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776440081; cv=none;
        d=google.com; s=arc-20240605;
        b=jHPoZp9iCM+BXiTQiziZnqwhbNvC/5lIAsbsiGBL2x0ohhfozrdxN0ey3V3FKHXMux
         S7sNYWoi8UTmeSVqDvjssGHzTYX0mHFUai9jcxBu4QDh/931T7/dAlAvAA07Yp8oUVEn
         XWlRy1AF0vkmpI/qM8f40/iqSicrXb4OzOKNBdNMfd+JVQwUw7hh62bsJ75V9RWS9aDV
         gn4s+uo3IBtWh6s2uuGP5IQ5d4PGIriEY+pH2t8rynOpIsgoXCBipMzSOezJ7LLvKmF0
         aVijQpHRg1Bnf4pUiTsMlTnGgFcxR8VsMYMrXVc/e3+tE12xEcd78HzlmYVGVWaQhmRO
         Ne+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JkQP/Op6Y5Z1wRIhwNfpakFYrsXLzQfwEJFWfCp/q1M=;
        fh=yfgc+5mdkG6HRMC4T1acGlUMysTVRZjz5nszcTIXPdk=;
        b=iDevU7zCyfhOBynA+LnfM7OY5W90XuXg1QBcHC9XNoQf89pJkajb9zfo+Q7XDDhlTT
         VsYHfWBQMZVM2+3tiXQ/+OhdhSGiN+JMfgsDJfCvRRmfOb4t8Unu/IGGs4RujuhrCpLu
         JH3BkgaH8KynECbTCVoAApXPGI5+HRL3a1sMEtune07MdqzDXlqRMg2MwN3s22Gn0R3d
         SOcgATHFk4aecUSl9QZUdS4dT9fGvqUXx1qVhqvmgxHpeXFhZu9lqnf3vO9WPw8RsALh
         fjMZM646jLz8HXalcoDbg5TOAcVaWxJ9ESdk4UXjzgk4Lv21Y7SeAETTESHgEJ0FMtvf
         BgTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776440081; x=1777044881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkQP/Op6Y5Z1wRIhwNfpakFYrsXLzQfwEJFWfCp/q1M=;
        b=Eeav3oxNFM5AR4tI4592sfVhNVd2g5c4+sNtXssS/PmijvpD4Uk8Tu7I3IqHkHchmE
         xpL+rwEZzua+MAqp9ar05vPqlySrrEnxKwfMIujiLRUAh3wKhz8ivMd9LBe2CTagOTNa
         lImE/cLRSGlyvg1fwNIyMV0TA8HDE/0E1ZHGId6TcD0UnhmiJVRIEWP53PNT6uDGZcK0
         v5Zk2usf0DfWJujpbNIqG1++7IWXaRiomOq+vm9YXDo1+esjtccTWhOgOy3kxO9QNori
         AgwNG8GUNc5nLbv3xb/39WMXqk9+ETqSp7pcw1ljwyGkeYnCnAxSMQdMRNm4aKRxfR1H
         vnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776440081; x=1777044881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JkQP/Op6Y5Z1wRIhwNfpakFYrsXLzQfwEJFWfCp/q1M=;
        b=jBG+emF8UGhHk9B6dhlfTTtpPwpfvSpeIKLvvMR/JpoWIZ50icljubuDZMKU//21cJ
         MCS9jXCMSILdKYafcGRTAKDm+i8jjz6AmvpXM87udIOk30SfXBKUwMpKLf1RpcBW8aKx
         HrjREdgKOPDB2FpiT0OPT4H04ENoPPXv7A4mIz2KOcqY7gQc9/iEoZrFkNwt4CFxjNPw
         mG7L67sv7nrtibREb9BCq7iOd5k6Uv7x7254EwDkK3CIyu7va/OnpVRyPBd0o1jqlguf
         hjosEfif6yzPkT3KKdB3ty+iTeCMYMXwmoNejVjkAJeHVrJgl9a61RzVM7mTbiQRYarm
         4c0w==
X-Forwarded-Encrypted: i=1; AFNElJ/9Xd9rMsrJVwhxsaVGqLmS2ZZzxbhKF738hIOGpw6oCgtxL29f8kbXPbc006ZVCbnScMWLxHCuKnwhYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJhlsRWd4xYpdhqvNzNyhoyj7kGveRiAz6YlxZJ1VVqZjFHwo3
	ZEeD+BknM3f4GxrygJDjgdC5NqBcq9d3xRO/X9wieFC/hbYnUXl1AzDICAIGiFAyE1OYz2QIQjm
	TAsIYfBk2JO1aalAqp+XwElZRt9f4eHyIAZ1tD1tUlg==
X-Gm-Gg: AeBDieuzXPNpP54MwyOdQyrCtwXQ7eX4lxhQv6tQ4WkRI9Sp2DI5A4d7XrbtG2eA393
	LEKkEA/FJ4I184odq50GiNxwLtb+f8cIUGwHm1+odANLnQOsTg/j5RsiJsYIysU/IS77XE0XvUg
	Wku6I+UjDoDE3twXfhHfNM2GjncVfbmZDMFfDFWYDk0m9FpWq6ZtoKTq5+hTbMFuDuQnb9uRaVx
	sa62rE0Bykbl1GC614yAxIhIjyVPyGsA6esFEmEPPqH8N+Ap90GlZnXE7boAMuDaaGM+TOhlXci
	4wGUdLfRnSQ4mLOMT/j0ljyA+FtMoA==
X-Received: by 2002:a05:6870:d96:b0:423:cf4:d224 with SMTP id
 586e51a60fabf-42adecdee50mr1162451fac.3.1776440081481; Fri, 17 Apr 2026
 08:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415210847.1730016-1-csander@purestorage.com>
 <aeBxOVmQ2bLli78f@infradead.org> <CADUfDZpcNG_GPpZYh9tWKEBjKHD53DVCmQGTrXKQvBpP7PCqsg@mail.gmail.com>
 <aeHnx2GcBmutcsBW@infradead.org>
In-Reply-To: <aeHnx2GcBmutcsBW@infradead.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 17 Apr 2026 08:34:30 -0700
X-Gm-Features: AQROBzD7aoyy57sjpID_8cikega5fTi6-amAA5tn5yqH3pE9JF8grsSBhvm4UbU
Message-ID: <CADUfDZqDz9a4yBOq77mTOjQzNEwra6eh6oZFng-mzjmC5ivD8g@mail.gmail.com>
Subject: Re: [PATCH v2] t10-pi: reduce ref tag code duplication
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 12:56=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Thu, Apr 16, 2026 at 08:38:07AM -0700, Caleb Sander Mateos wrote:
> > On Wed, Apr 15, 2026 at 10:18=E2=80=AFPM Christoph Hellwig <hch@infrade=
ad.org> wrote:
> > >
> > > On Wed, Apr 15, 2026 at 03:08:47PM -0600, Caleb Sander Mateos wrote:
> > > >  #ifndef _LINUX_T10_PI_H
> > > >  #define _LINUX_T10_PI_H
> > > >
> > > >  #include <linux/types.h>
> > > >  #include <linux/blk-mq.h>
> > > > +#include <linux/wordpart.h>
> > >
> > > We must have already gotten this implicitly given that the code
> > > already uses lower_48_bits.
> >
> > lower_48_bits() is defined (and only used) in this header. Yes,
> > wordpart.h is already transitively included by the other headers, but
> > I think it's good practice for each file to explicitly include the
> > headers defining all the items it uses. It reduces the risk that
> > refactoring the other header files in the future will result in a
> > compilation error here by dropping the transitive include.
>
> In general pulling in a new header when no new user of it shows up is a
> bit weird.  I don't want to hold the patch up on this, but there are

I'm not sure what you mean by "no new user". There weren't previously
any uses of items from wordpart.h in t10-pi.h, but now it's using
lower_32_bits(). Personally, I think lower_32_bits() seems excessive
when we could just cast to u32, but I was following your suggestion...

> folks out there actually dropping not needed includes from headers as
> it can significantly reduce compile time.  Now this is not a heavily
> included header so it's unlikely to make a difference anyway.

Is a file being included by the preprocessor multiple times really
that expensive? I would have assumed it would be cached the first time
it was included.

Best,
Caleb
