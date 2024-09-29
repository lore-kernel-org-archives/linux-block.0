Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1034C69;
	Sun, 29 Sep 2024 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727648510; cv=none; b=T8Nf/EMel+YNGziBgLBHoALOTPyQ98rr97IVf37+LPPJpV5g1MNAmmAWEovcLodarLenPvMS0Ozu/r4/tAXpg9NbCq1vpvkspc96S3kyS0JtP5VV0rN3N6DB2qxRPn7xFXttLsn8gKrXdEiCQmpWMwYijmWuYHLT58zmxuCVLag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727648510; c=relaxed/simple;
	bh=YNHB2K8Lz6uaot70hZOhnrmxSavlfHa3X3Km+vXArwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9r8Cw+LPd3lElHXB3wgDP/FUj+4QIk5Zr88z8g90rQMJf99oycYuHRV+IkAE/9nSev5h9k8kAjg6XOUwXmoZttsmJnGQjTYamjWceqwHhYtiwRxcvaPWXiw4NUk283wnCO1CWnY/el9RSi6OxTEFwgZvN3BBshO5Gih07AkN6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQNCTcHy; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQNCTcHy"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-277e4327c99so2107067fac.0;
        Sun, 29 Sep 2024 15:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727648508; x=1728253308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNHB2K8Lz6uaot70hZOhnrmxSavlfHa3X3Km+vXArwo=;
        b=PQNCTcHyxbnNfe0fm4Wg1wznJ4OIvR5MwUrrFY7SSi/713bXSS7J8krdkaEdEVN43n
         YgJxfAKyQzZXKuZmcr2jkneappW+qRWxO2ex0xe21vdCphi4Cc3DB3s4iVRERWYzNRvn
         Bs2Cmcqr1Hzr2IV9AEYt4IPqYTdHKJNY0jPN7/VkTFBHXu1IH8fg43GAV8U6j7TLZ40G
         UJG508gQ38Ofbac3rOLgPON115v4zNOgD0apSSDbPCed95IAZjlBncQqHupJKqM2YB+A
         btHgYUI7Okp9fx4EV0+BOjkvCkuL2enomGmWpgFX57CxGOipRRuMwh/Tg9SHres8eae+
         xfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727648508; x=1728253308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNHB2K8Lz6uaot70hZOhnrmxSavlfHa3X3Km+vXArwo=;
        b=RSDYIyLb1Qq3zM3sBNnJC8rRFwBRRg8Amp2T+63OacCJy+/yc821Tz6fFgRW9ieh6Z
         kXov3BqhjOYhINsA+imsKNdps4OAxOleS5N1GPBtnovMs1jamrMIv5Oa+AvevGEsBuS8
         Wu8IwiKhBdNp91AOX0OGJzj55khhxrbPvBBrV848dijqPKO0yViSzilrYUd43k6hZMKC
         Wdxv+VGmA+QnQkU/B+dCZi8Mk+0dlSk6DN9BTpbEROFEaP5In353e17bFkKTYZWXI/+W
         1+BfKC9E9o3QmJu9XAUE6C+kAHjsRn/3O5TvbyeUHPZutcEC7V7qGTqR6Motlu2PhhYh
         phbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2Fnm23DpYRQQ8E3SxrvuhKBw8crBCLYRnEcgaBa44GK5x8zC0u6RDw/dRIS6miz7nKdsa5L2/BamN8g==@vger.kernel.org, AJvYcCXvnxrDg5Fz2Tmu0cfWZznf6FtZRKhEUtJLg4HSc0Zo4W5DqAZBzD5yYA2lsKjqvmXFIyTqb2ynAfvnpD0D@vger.kernel.org
X-Gm-Message-State: AOJu0YzrSGkg+Nbz2mcjLJUgpPkTHG7kRcXqBVfG62xu1feVJQuMlw60
	2WhMtWA2yDzEHnerF4PYKVR56iJEW34nCGYJomkz5+VyQ6vkJHYUj7vBBQaW7k/FXyofn+EkPa2
	0B/cvpZrnczu/0mq/Z/xbIlHS9Zw=
X-Google-Smtp-Source: AGHT+IFJRYzQ7U0PGNZlrvybSMs9yWqPQ5waH00dYQRvv4jGDUcgiYX9Sh0HTg/PnWmg6KySpfvicsCTkTvBG1Zvp+M=
X-Received: by 2002:a05:6870:ab06:b0:27b:6e04:d13a with SMTP id
 586e51a60fabf-28710aae385mr5630584fac.26.1727648508236; Sun, 29 Sep 2024
 15:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230919003338.GA3748@google.com> <20240925155314.107632-1-jassisinghbrar@gmail.com>
 <20240926043358.GD11458@google.com>
In-Reply-To: <20240926043358.GD11458@google.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 29 Sep 2024 17:21:36 -0500
Message-ID: <CABb+yY0geOHVz16PsZMbk2OWuJ91Cg-EBvKWfosxe7V5c-EBkQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Improve zram writeback performance
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: axboe@kernel.dk, gost.dev@samsung.com, kernel@pankajraghav.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, minchan@kernel.org, 
	p.raghav@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 11:34=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/09/25 10:53), Jassi Brar wrote:
> > Hi Sergey, Hi Minchan,
> >
> > >> Gentle ping Minchan and Sergey.
> > >
> > May I please know where we are with the rework? Is there somewhere I
> > could look up the compressed-writeback work-in-progress code?
>
> There is no code for that nor any progress that can be shared,
> as far as I'm concerned.
>
> The most recent writeback-related patch series (WIP) reworks
> how writeback and re-compression select target slots for
> post-processing [1]
>
Thanks for the update, Sergey,

Minchan, if you are not pursuing that patchset anymore, is it possible
to share the last version you had? That could avoid re-writing from
scratch and, more importantly, straying too far from your preferred
implementation.

Thanks
Jassi
