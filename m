Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EC41F6679;
	Thu, 15 May 2025 23:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747351638; cv=none; b=rIO53PkDiDzgs9+HNGX0zD0MXM1IMBQp9f4rcUmvGCLq8GH+OV8ox/m9cNNc6ClQKNxMg7DstUVo/xOV3Mc58+ETGCiUQL6lm6r/FXBO5wjxIRY2IWAv79Czi7dYJP9NhpIiXXNxLagA04MQDKiOGxVb94V8NdtLcsb8VWvDFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747351638; c=relaxed/simple;
	bh=Pgu2Y6SESaYpP1jqivqgblNQ4Ifsz5v7aJ3n6jeq+Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkSrQSzmgr0mV+c91CF9bTJvNCJd8X3c2kdsIchNa468DOhC0NLCljLirJmxDnLFsGH9VD9idDYjL7i/+l6UK9vJTQMO7XKho4m+1NuDrOLglJApHiE/KwxNl8BfwZ/AcJoORYzwctDdPhhM7Kc+lHQFt52FZjJB3MpC6+kHrnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICkzPb5N; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICkzPb5N"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3da785e3f90so7218945ab.2;
        Thu, 15 May 2025 16:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747351636; x=1747956436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pgu2Y6SESaYpP1jqivqgblNQ4Ifsz5v7aJ3n6jeq+Bw=;
        b=ICkzPb5NDvFpyhIq/PxhMY0osvHGOb85tbLlUg6ZZgkBkYSNZ4mhBZ7fT8Vl90UUkW
         VVIaDqFrhxTP2y38Me7CJ9CokDKdD/PebJ2VzUNG/xBYiIUas0fUSH0RvKIaTDMBixQj
         0uEy8trUrq/Ezk9FzGQjUJ/32jjgueP1RdIFVJ00Lel3YsdR+Cbd+lULo+A0ZX92jNei
         c1IgHu6A3Hw7lZOatfJVfdu+i7gatMyZkuo8Oe5xg9cDBtuVYLTSqjC6ZOTK5XNXdeRH
         OLzChsjUXSGdnBPmDXGUje2t1I7jnV+6qrjgv66U/Bj8SVv7m4X5G3Wt6rLoKUuldPWy
         opLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747351636; x=1747956436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pgu2Y6SESaYpP1jqivqgblNQ4Ifsz5v7aJ3n6jeq+Bw=;
        b=u5b7VqxJzZQKS+jlVxXaUYKmxYmoi7fMxGqWR0QYjhiWc0CNNKYtNNfnJz48ocXVL/
         fKVDhKGK3UEy1fbyobnMR5ylIRyQJZjpU/mOhk0Rfmimm53acUNuLTVrCYfb2IPvcVk6
         4vKm7NQAWDNHoSsgU+gnSvfp4LSFkT/QyNuo05b6Tv2526AZ6NjNeHeCR7JwOtimrylY
         PJJVNdICoLEAXeCjHZ78u3ib+pEeU1E0piLW+pIaWmNaBSKhAFGvA2kRMg9FcU+AtBml
         IN3zgda5DVyROsvOj3y6pWBObaWi4xO87XN4DDGe/M1Ut9xOlJZKM4dDc7S6jlUvxe9Z
         yRIw==
X-Forwarded-Encrypted: i=1; AJvYcCV7WSmig292LZJwSowruE7Jdk3pjBu+sFkRPtFzvNti6JbZA+wNO/xkEJjsMKRNP/AIGWOr3bGN3R/gBQ==@vger.kernel.org, AJvYcCVNlmC6OQE4nFY5SSCWRHs5t0LsHSrV3s49nToriIhEXimwDp3ZSgHBlapOlfF4Sp/4s8d036/jcfMAytQV@vger.kernel.org, AJvYcCVzx6TIO2u0jeRpAbo8gBC85P2xlzCrP7P6ECmNduXuA1gMvgS+09SLOZfhWC4ZwkfVMYYD5vC6QdC56SPh6GlHzKIv@vger.kernel.org
X-Gm-Message-State: AOJu0YwhGx54UNU3Cjn2K/Rf/e+0whV5ft2JiQrfUEpqbEF/Fq584TZJ
	ssqyFbHEgj1pZNr7XITucV+kERnKNPGMKzWziv6z3IZpxf8Oaa6SUUAuToGaK7bCAisFR9laNLr
	WXUN38iJKT64V1fDEuciYqHlcd72sbTQ=
X-Gm-Gg: ASbGnctL1HW/ptybqtIxPyHag4hNuN7Q65z1+yFRRhnVEn0RI8ExaNrXxpSwHW2Eac1
	Q0s2QyUcLB7VYf2cVbqLGzI8gczaW/DTD38MMw53Z1kaJ3phPsJVsFqquettzPoj7WqyAJMAxbf
	hiRTrRjiF/mnydc/lPKYIY8Hf3wFlwtu4=
X-Google-Smtp-Source: AGHT+IGMfInsdd4M86V2Nizwia98eN9Cphdu9Ifp0c4g8ILD/M5kt5/nqFyr5+vgxMpx7sYVOFj4slUTcZjlKV1jb40=
X-Received: by 2002:a05:6e02:1a02:b0:3d4:2306:a875 with SMTP id
 e9e14a558f8ab-3db8573b7f2mr6272255ab.8.1747351636199; Thu, 15 May 2025
 16:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515061643.31472-1-kerneljasonxing@gmail.com>
 <20250515061643.31472-4-kerneljasonxing@gmail.com> <543ef493-a478-4e92-b384-f6ff299b11fb@kernel.dk>
In-Reply-To: <543ef493-a478-4e92-b384-f6ff299b11fb@kernel.dk>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 16 May 2025 07:26:40 +0800
X-Gm-Features: AX0GCFsN5GIaAdgN6g5NVxIIwO__es_7OFWs3t7NcNFhfUkgfO8Q1iiiqvjpgUg
Message-ID: <CAL+tcoCLu5PNvfs=_HDfy8NdNj5N1_h5dt4GjVCvB9qSt0EYyg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] blktrace: use rbuf->stats.full as a drop indicator
 in relayfs
To: Jens Axboe <axboe@kernel.dk>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 2:21=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/15/25 12:16 AM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Replace internal subbuf_start in blktrace with the default policy
> > in relayfs.
> >
> > Remove dropped field from struct blktrace. Correspondingly, call the
> > common helper in relay. Through incrementing full_count to keep track
> > of how many times we encountered a full buffer issue, it aids the user
> > space app in telling how many lost events appear.
>
> Forgot, I'd rewrite this, "telling how many lost events appear" doesn't
> make any sense at all, as these events obviously don't appears in the
> first place.
>
> By incrementing full_count to keep track of how many times we
> encountered a full buffer issue, user space will know how many events
> were lost.

Oh right, I will adjust it!

Thanks,
Jason

>
> --
> Jens Axboe
