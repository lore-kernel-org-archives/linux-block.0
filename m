Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0C82DCC05
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151315; cv=none; b=SaqfoWJ6IAV2AK7VxYqBM00gIiKmEjgajEC1V3T6bqX9peiwQ92M0B+/ch4RoV0GWWNhQIQ0nQOqG9DmDpQz/BJXd5c69bszFqjKJDG3MzQXivDU7+JO3vIni9syyG9lDdieyBYXfqvntAdYceH7p2xOW8I2MhYhEDUSbeJmpDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151315; c=relaxed/simple;
	bh=EcYgA1Dp2f8fgnuyFgD78VApES3CVJQ6ODo7jPzfgGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U46eKiSVVEWpyQFRYXGtK2W564c35M3ubmfgVNAQGgnwWzw/7Kccb6Bby1tE5Gqplrah4m21749TJwAC7nXXRoHY+jBIVkTihnfh43F64ewBFlu4W+ZLb0iAdJklGjb/uaKPm+DgYkrxxI+0Lpb+9bR8MfscOsyMmxZ9qOVwrFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcCo87Yq; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcCo87Yq"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so1469745166b.3
        for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761151312; x=1761756112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcYgA1Dp2f8fgnuyFgD78VApES3CVJQ6ODo7jPzfgGI=;
        b=TcCo87Yq/iqTvWnBnXr1s/sb405+ysTLf/84TAuBDnKBBDUXPhVcnrRzwWKSmvJPHM
         sHvLDJy4H+au5p0MkDVRxE9dBRvvR5TXtEajr8oGykSgG9bDfoNc0SlJdAn0+tOvZfUF
         nDkYKnfeNYvxMDaPVIu7RTFhe+JFog3XitWtISUFtnLJq8yv/Ie79MJmif4ot1haGFCd
         eahrAgwlG3DgFuB8g1YM9qlrtpgocKryspGEc8RduAwwVtt+k5wKIBMXCj03ujxrfucx
         vvNSnbdMyBfFKGJkyK/ZXqMenwgzukXmQnWfk2h2YtnVuv+LJSuNRCoU/aN8C5Nys+E1
         YxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761151312; x=1761756112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcYgA1Dp2f8fgnuyFgD78VApES3CVJQ6ODo7jPzfgGI=;
        b=rTGpjH75qy0HIFegsD9NPvzgZCyfBM89YHkUClW4nuH1AwQ1iuLMW+a1LqsLhQgSd8
         fbkLuA2Pq0jFKYpuRcb8uiT0Y7FVgaPnGQuIjYXjvodV8xNo6+h6Db9kuxKMK4ecpnBD
         Kg8jgw1wNDOgBq2b1Ra1OFJ6NQXF7nJHcWKlZl/zsGA5UxmLytusmtGSLAbqEl8N/H7X
         EWZpZVyYEix2O40nQVb7N8oAtiFcM7nqH12+oYuBJkiL51Zs72t058fe0t4fLy45o0Ce
         k50s1FXOUgaR7oU0dgDLAQqnwhB91Tn+SylgF5MxO9Pr1RAfoTpGARmACeHwanF0az+2
         knvg==
X-Forwarded-Encrypted: i=1; AJvYcCXfw6U9vf5UWYYq8BCVkjNIs3g8Hxga1OyJY5Is5f3xvsNAvXLLZUtCCTd2TbFQIC1yhJm71URHt8ySZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2xPfNVXq6XHS3f2hLvw6sZA1CpiuBTt4A4JIqcg5FadOgaXrV
	0ch3vwsZircFkL06pXhP15YxFOvODr/phTc7vTOocQQmgBLH2AMTZHYApI/QbGDUUq1sJiDK0tl
	I6B7hze1OTJEKlSd0xAIs/tX8MSmsv5M=
X-Gm-Gg: ASbGncuOz82f8p4zXhci61RgSWUbTufaijLYGXdCmAEEurNsSqT6HoOXNuRq4eKszNx
	Gm1KxZSUZUWGX3CglkPD7NBBbA8EyZaEQb5TIoTOUwzQluhz9+oeu1CKemx2E9XxzXRb1Hf9Mfi
	lDmRlgHnNF/8oaGz8zMe4JHWqSSY68gyXS94lSamlD4+bcFgnKWyMj9MTLrObh2h7AxFozTE4dE
	9hoyPc2Sdpg6q2gVrpRJ1JB0Q7M9sZhZmgAWKQUw+r7c+RIlcOfut8z2WwtUYKnkEz7XYos
X-Google-Smtp-Source: AGHT+IHkWGnG06JOtYFwx6WKEecUCCr1fs/y3xfoAi4lziINz4JBVkxPbzc5Y9qrcmqbPId7dzqQXzuYY7OGWY5xDrg=
X-Received: by 2002:a17:907:c11:b0:b32:8943:7884 with SMTP id
 a640c23a62f3a-b647500ee9amr2300275766b.45.1761151311555; Wed, 22 Oct 2025
 09:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aPg-YF2pcyI-HusN@archie.me> <20251022080626.24446-1-safinaskar@gmail.com>
In-Reply-To: <20251022080626.24446-1-safinaskar@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 22 Oct 2025 19:41:15 +0300
X-Gm-Features: AS18NWAouNqJg7toJrl3zFJYl4AxgHZN6-E0xEGlNVrmOGgNKVxnzpVBWI-jPi8
Message-ID: <CAHp75Vfb5J9P1vhSWkGy_j+ter_774ThBJHZuSp=r583xGP8Cw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] initrd: remove deprecated code path (linuxrc)
To: Askar Safin <safinaskar@gmail.com>
Cc: bagasdotme@gmail.com, akpm@linux-foundation.org, arnd@arndb.de, 
	axboe@kernel.dk, bp@alien8.de, brauner@kernel.org, 
	christophe.leroy@csgroup.eu, cyphar@cyphar.com, ddiss@suse.de, 
	dyoung@redhat.com, email2tema@gmail.com, graf@amazon.com, 
	gregkh@linuxfoundation.org, hca@linux.ibm.com, hch@lst.de, 
	hsiangkao@linux.alibaba.com, initramfs@vger.kernel.org, jack@suse.cz, 
	jrtc27@jrtc27.com, julian.stecklina@cyberus-technology.de, kees@kernel.org, 
	krzk@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, monstr@monstr.eu, mzxreary@0pointer.de, 
	nschichan@freebox.fr, patches@lists.linux.dev, rob@landley.net, 
	thomas.weissschuh@linutronix.de, thorsten.blum@linux.dev, 
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:06=E2=80=AFAM Askar Safin <safinaskar@gmail.com>=
 wrote:
> Bagas Sanjaya <bagasdotme@gmail.com>:

...

> > Do you mean that initrd support will be removed in LTS kernel release o=
f 2026?
>
> I meant September 2026. But okay, if there is v4, then I will change this=
 to
> "after LTS release in the end of 2026".

No need to mention "ater LTS release", we all know that this is the
last release that made the year in question.

--=20
With Best Regards,
Andy Shevchenko
