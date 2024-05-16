Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC832F3B
	for <linux-block@vger.kernel.org>; Thu, 16 May 2024 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715841341; cv=none; b=pZY0d28yd8YKdhBzngP3V6c5FhNLDAXjANu0qt+Ou0eiA4w7uzSKWisW4N/ZHiTXiDwYr11gQo/hE68neEeN3cJr1uLD962C5m7xqlC2ultodPY4kk8oSoDpo7rTicvq6HoDDc+JZiPK20eR/bJL6d7trwLrkydcgGzcBqCA/X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715841341; c=relaxed/simple;
	bh=4qYPgB7w3VWHV5nxyHVEaF4494UUC1haBn1zRSaJ8Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcc2KtsFuIXdwZiaRSWkanphSK7fdPNnPlIRCP+9vpJzuzz0LNDNBXM3+RxSqKwvIF4uzjm9KDDGW+jr35r/hc9NoETIlqOGsEvHss8/pOBe38BkZnbDHoP4SZ7mP9dr3bsJsRNUC+R/fhoecUzzGaNdUB/LHgGoOf4yyCXgSbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j/fVSDIr; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/fVSDIr"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-47f43c742e0so2507264137.1
        for <linux-block@vger.kernel.org>; Wed, 15 May 2024 23:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715841339; x=1716446139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bmfXEWdtGqKswH9Xu4JgGerg0k5E2Nij58vjYt+4SMk=;
        b=j/fVSDIr1fv4dg62OLMX+mJF4ZPwXWPZzWV7Vk3yARcSBOKcIAlee4CEWYwIPp+O0b
         14TLIHZdOw4+Dd0x1I8ZQJBbpesP4eKBn9jb4KuwJl2Mfn4Y6NQtg4zRH3gaNEhdvbVm
         dQT+qSUuB8zWjXbDpA4LrTpA6vq9C6hAMDgrNx+kYiAYznBeElgj/QHl18gkoiZmgc8B
         VI5fLUxRVmOfr6fVLVjka7F4RUwc2/o/thg1wwOA8vuBFxf+BKmPRWFeWQUkHqaX7jjB
         +3u34d8Zei5zLf80rKcNtLtVWvUsV0oo8GrSkr5kIoanozzuvGX5MGhWi/SWSryKT2D6
         BLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715841339; x=1716446139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bmfXEWdtGqKswH9Xu4JgGerg0k5E2Nij58vjYt+4SMk=;
        b=TZJJ84Y2tEG2i+mG1+xKFDRdKa2wI/OseiWEXNG+TIPkp0OXsbnvIUn/TjPi+U47+D
         LPQVyxdz37IJxLxwKsoxm8qUmQYCVobtdx1j16KJ/wrHrHPPkT4W0xvg+WE69tzqvMjg
         rzoJOaazA0DQLzfpiaWBKThYRlR+/nJF8iwoXt4CeO7dsOmb7/Yca2OqYI/owUYHZ2NI
         TCrzk7IX3q3FQqnTzEKOtnpxBNlSm03Jy+PAN5DE8QkPLeTmZp76bb9oV0lnqndG8xya
         mWap/cOv+D+hmlh8i/NXf/iICdvCBahfsG/DkZoK1Qr6PckbnubpDM6PfNI4IxXnLjrT
         bIAg==
X-Forwarded-Encrypted: i=1; AJvYcCUvdcKZm/FyMo8oK/AqpbxrZRYUTMHQx157c530utijL5MSnzoEsPXZe/oOWwOkW02uTxoanKX+ub8Wm50Iw+zv8usQRxLuD7KiNJE=
X-Gm-Message-State: AOJu0Yw9V0e1nXwbWeeI0XwLNJnTBDyieTmShY4f42OfJPIKrNRR75Ut
	3jPqCddpDQBAA8XsFPT+x7+KF5REGQVOvVSU4t2Ab0kPPqVUT2GnyLqJ2A9PxHHeB4L1f8VKmM9
	iRN/Z4asBB+rWGVp4OPIqot3pI+n8COJds+jC
X-Google-Smtp-Source: AGHT+IHlDQ/eBAofLlOUojbiT4Ni38v9AQ8HQ8GEW7AT/J3jdp0eY8vVJPIgTi6v40/0Xd25DHGwDvZXK48eXKzavgU=
X-Received: by 2002:a05:6102:a47:b0:47e:ee4b:5e83 with SMTP id
 ada2fe7eead31-48077e87f61mr19122474137.25.1715841338556; Wed, 15 May 2024
 23:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c83d9c25-b839-4e31-8dd4-85f3cb938653@paulmck-laptop>
 <4d230bac-bdb0-4a01-8006-e95156965aa8@acm.org> <447ad732-3ff8-40bf-bd82-f7be66899cee@paulmck-laptop>
 <ca7c2ef0-7e21-4fb3-ac6b-3dae652a7a0e@acm.org> <59ec96c2-52ce-4da1-92c3-9fe38053cd3d@paulmck-laptop>
 <CANpmjNMj9r1V6Z63fcJxrFC1v4i2vUCEhm1HT77ikxhx0Rghdw@mail.gmail.com>
 <dd251dba-0a63-4b57-a05b-bfa02615fae5@paulmck-laptop> <CANpmjNMqRUNUs1mZEhrOSyK0Hk+PdGOi+VAs22qYD+1zTkwfhg@mail.gmail.com>
 <75421237-4c5a-48bc-849e-87a216ee9d32@paulmck-laptop> <CANpmjNM-Cg12qCU3WoLeBboogLQVgn4znFerRwD3BVAFMc9BiQ@mail.gmail.com>
 <d9df8351-7cc2-4562-a8b5-440344bfeb91@paulmck-laptop>
In-Reply-To: <d9df8351-7cc2-4562-a8b5-440344bfeb91@paulmck-laptop>
From: Marco Elver <elver@google.com>
Date: Thu, 16 May 2024 08:35:02 +0200
Message-ID: <CANpmjNO+WDF804s49VdCf2=3io5Uh=8ZbM_jiW5j1rcbcONbUA@mail.gmail.com>
Subject: Re: [PATCH] block: Annotate a racy read in blk_do_io_stat()
To: paulmck@kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 23:51, Paul E. McKenney <paulmck@kernel.org> wrote:
[...]
> > And I just checked the current access-marking.txt to see where we
> > might add more, and found the section "ACCESS-DOCUMENTATION OPTIONS"
> > already exists. I think that section is perfectly reasonable as is,
> > and it does explicitly talk about ASSERT_EXCLUSIVE* macros.
> >
> > Did you want to add it more prominently at the top? If so, maybe a
> > brief forward-reference to that section might be helpful.
>
> How about like this?
>
> ------------------------------------------------------------------------
>
> The Linux kernel provides the following access-marking options:
>
> 1.      Plain C-language accesses (unmarked), for example, "a = b;"
>
> 2.      Data-race marking, for example, "data_race(a = b);"
>
> 3.      READ_ONCE(), for example, "a = READ_ONCE(b);"
>         The various forms of atomic_read() also fit in here.
>
> 4.      WRITE_ONCE(), for example, "WRITE_ONCE(a, b);"
>         The various forms of atomic_set() also fit in here.
>
> 5.      __data_racy, for example "int __data_racy a;"
>
> 6.      KCSAN's negative-marking assertions, ASSERT_EXCLUSIVE_ACCESS()
>         and ASSERT_EXCLUSIVE_WRITER(), are desccribed in the
>         "ACCESS-DOCUMENTATION OPTIONS" section below.

s/desccribed/described/

> ------------------------------------------------------------------------
>
> Would that work?

It works for me, if we agree that "negative marking" makes sense: if
the other markings indicate the access is happening concurrently with
others, a negative marking does the opposite.

Thanks,
-- Marco
