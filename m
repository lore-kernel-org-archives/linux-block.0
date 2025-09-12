Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7512330E83D
	for <linux-block@vger.kernel.org>; Fri, 12 Sep 2025 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693449; cv=none; b=Lydc0AtNfqbD6QqGOFxqnUcxHrJfo/Pkg+Sc2FgdkgHrZgbJeKfDjjUnwobjtbp/bbdRUFk65OjzrsdiLEcBEQ6U27WnQjHImw+70vaY6IBU5GIlCcqwRglNpFxlqLkrUhOl3NndLwtQS1Fx/62d/7vsjY0S9Mi+18zyDqPvNo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693449; c=relaxed/simple;
	bh=0RHe6bpoJIZwIozT53G/9zPYXo1UJgO60j6sIrqFoa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKxpSKpOGEezql2j41dTc6FYOvUMIEd973ecK6yLpHQ6eEaqUJrgkK5pL9yVHbKVEIpQJ2HGKF+iDXAtyzLI3uUfC1BwLrid6vGkJg9SyFeIpRuGiUo1pKkHTynIb78Yv2Je47GVai/GD7Ezb20KsKXxzqWRmk04v1oFGjEX+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUnvxo3j; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUnvxo3j"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b62805b2a4so25339981cf.1
        for <linux-block@vger.kernel.org>; Fri, 12 Sep 2025 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757693446; x=1758298246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xwq/iCyIzHWorLG2Ir1bUT1FcNPCbVi//QRArwuSAcc=;
        b=GUnvxo3jTjQ98TYJtZYmV9Kp3cDyGCUaOA8obOqxRXsEfPttuobJObbWJInysARuej
         kLjLgS0Etct9lsAEpxFyFyYWAwSTNhCtVG2HV0uK5nmlk6gS9U/CYggSvD901gFcFaY+
         OiUX5S6iphlgsZOM65rHSx+SDdyhFb7TLmYID66oBiuc0HcegU4oHiLkS89B6pmtCFNu
         GJ/+hpZCA7fjF427b2mXBJ9Ab0gEDtB+IH1trHtrwAtXH4RLDoOFKgGGXpkNRrtjOUf9
         QhRPL1EXYlcYdKLAMZfm+5r3FvzL1gjFl2H8KCHnoKDaldP8pVyzzMpIdjbl7kGIOmnx
         ghyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757693446; x=1758298246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xwq/iCyIzHWorLG2Ir1bUT1FcNPCbVi//QRArwuSAcc=;
        b=OjyZXL77LWvwUK3ophQONpty9j15xKnPh/YJiOtZXWJ1v2WezMgh2A18ifNq93uCTq
         AxaXei+/6GJs2qFUQZy3gRxZ4h4tdOb97Qc1gAY+1bMMbOCA9UgD70OIye783CDRJrZm
         MzhTDGF5+E+6HsiiMtG3L7psImUnLJ6qstTMw75FS/deRCiw6uKsz4qc+iXD8cEfaWaP
         sJ73bfU1I0RBBMzv9eYMHjD+udILz1CCOyCWC4UA9RZs5XGEGGzkpRyHjwj5lV8761l1
         kan0kmi+CcorYRS5EwEuTllV6Kzh6oPZUGNHqmB3enhNSCFwYdf8VBMSF4PwPC6KBfwp
         ghxA==
X-Forwarded-Encrypted: i=1; AJvYcCW4L2GDXRjjXFEpZp7pOGKjTisZB+ZajZSg3e0eqayWUbcEn0rUj0AOf4ErGVGsI0zX20EXcljcSt2jHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsBafIITIK4qqPuHxUQPFxxyB1Bd2hhCI7zr4LBpvILvq/tNb5
	15+JswyGyyNQ5HiRRgPTHFpCNOR2M4f3coao72kZUKe95LiHoWNGNZJwHJ06uvu09BjDwKEuD3A
	wv0ZQ8NM0pHqROzCXnUl4StmOmV2S/c4=
X-Gm-Gg: ASbGncsgfOgqaoI+3tgOlSlGCPMOZBODcCPEjT/DuHAsMjKczuLp496Rqoi8JEbKqJw
	clh+YQarFt6CX+HZKAauXAS2t2xDkPjCaKPQGl4O8zFaSSFcUrQtBSXb9EItwK8lOnKbTyabHbD
	relBEeNoDfUFJ6qWga5n447ZUmm8dwLkaI0wAqjKscJdmeOz62oflnypnagckRblOOlZslkxAWS
	oECX9izwfLNBjkT2cVoon2l5wsuYfunEFzqwf85OLpgnyFfdKlw
X-Google-Smtp-Source: AGHT+IEW7Q+2d2hor5P3hr9ksasgPpy8ttcb/zSz69+p8aktjcDEYkFuq3rxTSdGTnR+6WW44n0sCoS+JUh7Itaiy9s=
X-Received: by 2002:a05:622a:4cb:b0:4b2:eeed:6a17 with SMTP id
 d75a77b69052e-4b77d12a30bmr47218771cf.46.1757693446130; Fri, 12 Sep 2025
 09:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-5-joannelkoong@gmail.com> <aMKudxVnwafaoqmm@infradead.org>
In-Reply-To: <aMKudxVnwafaoqmm@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 12 Sep 2025 12:10:34 -0400
X-Gm-Features: Ac12FXytydEpN3AbZfB7NDTCU5MSfYzu7GMuXUcwO8TmZQQa1qHB0P4yWy0TUqQ
Message-ID: <CAJnrk1Y6VZUA0g8223cPvmO_FjnKmemVGQck0_9DVcZkw-yGxg@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] iomap: store read/readahead bio generically
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 7:11=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> > +     void                    *private;
>
> private is always a bit annoying to grep for.  Maybe fsprivate or
> read_ctx instead?
>

I'll change this to read_ctx. It'll match the "wb_ctx" in struct
iomap_writepage_ctx.

Thanks,
Joanne
