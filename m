Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E74531691C
	for <linux-block@vger.kernel.org>; Fri, 17 Oct 2025 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684108; cv=none; b=CgCSDl4zuHKZNLEf8P76Hb4RDLg5qgoF8s5RkdbEr7B6ZLvzekvGMDZcBBFEA93qZys1XE+FWFeZrXRKEiuowWVN+GX+x4N97CNXL9CCEhX4NrbUg0PLb9F2DA1rTYvIafTIo+kvzeBIEfQ73JCh9drTsI75KXcdqD+hqWrx7/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684108; c=relaxed/simple;
	bh=8tn0gsWadcmuVvf+2fan/jdMsAl0+pqxz9YytNP2Gok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvEfOj7Pfeo/1Hcu8I0pAObRjUNvwq7dXbImSMcEvu+q3mwUJRMnLIXWeSCh1cO7uwLu0ngxaaaqmEeMzDUjUvs7WQ9QeKHO6MQ4Q2ILIHnA4I0EcsX0iRwcXt5XzGGQ1fVgg+leXpTAse9cdDH69XV97LEeh1/SCA3o5xNAxdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTaWssND; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTaWssND"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so1056822a12.1
        for <linux-block@vger.kernel.org>; Thu, 16 Oct 2025 23:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760684105; x=1761288905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAqfv53kZsbzluNJMMw+hqN+0n9Obgjt6ztN3dEZZ3M=;
        b=VTaWssNDzmVvKZR3UXVprut0l4vOhrLgflFvQZV7740D+i/vXESZM+WJmEEBZU48kU
         vJSzqR/c+I0Xz7+OxJl/erepGNNP09oE30+1GKGtyLgPjR0aZoP/7DmP4L8hTJl+Hxwv
         HKgljNr49VBtWPM+cxK1jZOnK791/EMuBCQljRwl45WoKHidiYKUcwEj7r8ZSYQ3pRI6
         kC9rsMSPxjO1VZfMFGWEh3ocABHBxc2EZ38ixgEdOc20lkBLkcZ3LLkXhBARs2GEUq1j
         Tfut44c2d4xwqoNrLPmRlMxp3YUA5qPnN9QyxM5g8F01uo3T0jMevQs62jO0Vc+eYuKJ
         n8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760684105; x=1761288905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAqfv53kZsbzluNJMMw+hqN+0n9Obgjt6ztN3dEZZ3M=;
        b=tOZUFzjhJ11KzsGJcDOsLNPhMfDRdeYp8qX9y4viSFCFK4bC/1l5nnWqbJ76zwrdSf
         Glmt3KXNmlNgyr6/5WQQZFyfdjPD5jxifvnT816ZCUs0QYzx4UU+AaSKjoG52X4qjubK
         fcbyStKRHQwHDsg/N41Le7N093MZpJYR9wcIsEMfawsicVL2qaXm4aSFX6R6tGd+Bs6h
         u3FNErT1fN4x02me9OgLBlhKrrbL1FrCqCPRYmuLQWc88bDtXbUa28/6cCaac3uMpXv/
         tAqqxpb+li37sKTHT5/5SDxVDP37/Je6n21tCq+mlM7qEjilp/smnrdE0KjXKoo9tfmT
         CDhw==
X-Forwarded-Encrypted: i=1; AJvYcCWLVCAz5OudsI1uY7wbmgYS7MKKPc30pv6IlzYdKZm+tTkDty/sqpKbqv4eKClFfcu1vHSPBl7gu+ctPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVVEMESlcluqZw2LFvTdOWpQykMEhHswE0hEqfmhCSMWeKBEpj
	oYMy88grUCStT+LEE0tm/MX3qEyZcAUh1VZ7U8Ec7azk6DORE+zdmcOj9hirrIKvgr1RRI+nMqh
	RtUxCtr7ewGP2OshA7YdJBu8BJESh7Jw=
X-Gm-Gg: ASbGncuNeBxfbuYXtG/UxXIwXVm4mS6q4Qdcj4V0jlwNSW3tKADtZdnMyAioS/oNRB3
	nkdqC1AiTGxTrRwGhLRYM8tNXwxhFeALxcg54scRCEWQwuxXdZ+HilWBssg5O0TUaifZPkPfRqR
	/UJy3EoDt9Ys/QP4eNdbZSlSJt4Igq7gvOgO3mOzEmzYOvMKLhTb8CMryCMoHqclh0zDVrvN8D6
	jiAB93MH8/lWNL0UU+SKqfdxDtl/q/YGa0mYQsB1/Mdjsb96jdrVcow+7I=
X-Google-Smtp-Source: AGHT+IFA1wbUFs0rKwKqAf6a9VqNqes/rB49gdi9wcqB+3od0alN9RlDJV05z8oscCylAZCpE64BJvJsh33fzkKAz/E=
X-Received: by 2002:a17:902:ccd2:b0:269:a23e:9fd7 with SMTP id
 d9443c01a7336-290c9cf2d7bmr32033405ad.26.1760684104996; Thu, 16 Oct 2025
 23:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016131651.83182-1-pilgrimtao@gmail.com> <aPHh1eTQRDO3z6Yb@infradead.org>
In-Reply-To: <aPHh1eTQRDO3z6Yb@infradead.org>
From: Tao pilgrim <pilgrimtao@gmail.com>
Date: Fri, 17 Oct 2025 14:54:53 +0800
X-Gm-Features: AS18NWDZdxBzJF4fAJo9f2GgN5oBARXmET52Mi5LxrI2DP2bqSoRyMbXbjTk_DU
Message-ID: <CAAWJmAZDt4yiqNr0246Pu3WQZBG11Wnhkk1VB9fxTQLg0+qwvg@mail.gmail.com>
Subject: Re: [PATCH] block: Remove redundant hctx pointer dereferencing operation
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, dlemoal@kernel.org, yukuai3@huawei.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chengkaitao <chengkaitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 2:27=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Oct 16, 2025 at 09:16:51PM +0800, chengkaitao wrote:
> > From: Chengkaitao <chengkaitao@kylinos.cn>
> >
> > The {*q =3D hctx->queue} statement in the dd_insert_requestfunction is
> > redundant. This patch removes the operation and modifies the function's
> > formal parameters accordingly.
>
> What formal parameters?
>
> Basically you're passing a pointless extra argument instead of deriving
> it locally.  Why would you do that?

The value of 'hctx->queue' is already stored in '*q' within dd_insert_reque=
sts,
we can directly reuse the result instead of dereferencing hctx again in the
dd_insert_request function. We can eliminate an LDR instruction.
--=20
Yours,
Kaitao Cheng
