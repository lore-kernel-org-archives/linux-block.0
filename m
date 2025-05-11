Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70BE2111
	for <linux-block@vger.kernel.org>; Sun, 11 May 2025 00:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746923761; cv=none; b=F5SgyN6qVnpKLy9v+Wd3STDm0ZUUUssfEHraPU8LP/0TBwRARh1K7YGdqB3yzd1AGbG0N9P0zcWmxWGU0pUx33FllQNKsCYRQXWLxGusrdj8PDSlx/a4F2HyQFWC3R3nh/Ldl0eDSanNJXnyZoW06X1o+NQChjJL6Ux7V1YdvOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746923761; c=relaxed/simple;
	bh=r03nLJvgUgmrXUBp6pwwH1baawwiopAwlukRYtT8E8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJY7jkGXwJjHWtxtO8JPvEQPzt3JfJD1q9RK+q34fdCyKOFOlohPr5LocwZ1Sp0i+g3ApEOYIXr93nTgaXGeaFI4C9HTRCGSdWSzT2i4Dg+OBBXLe4NZEITvPmII8NMGc0G0cqr0eM493wwBzm6VO6gKFxoXndbCh3LO+zLKX4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YBKcljK1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YBKcljK1"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7423ee0e42dso383310b3a.2
        for <linux-block@vger.kernel.org>; Sat, 10 May 2025 17:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746923758; x=1747528558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtRaVsiUBI+SZ9IP8U8WDTO4rTZdygKMrFtkoyTuE/s=;
        b=YBKcljK1hLQ/txMdxQ1bK1cdOGHYDVulrCIfYr6zlA6qpQcrIlDwsulYknuGx7HFl2
         UuV5kF2t7r0BEerB+2rwnefXHqPkA3F7WgBlxBHLnq6wSQxgm/Dwg1BdNyT4rTSehxyS
         JQeruB4lNcl6A+tr9j5SA+n5t1wB7vEeZT+y0I0TMHACuOubs61o5yPSincVRFORTyIp
         yTaHyaB1w5FesWJVlcoPGFH7e1GhqLZPFJnG6rP7uuecSBp7com0PP+Y40d1c+bp4IXc
         9OtM9Xn9POU2FM+Z2uw0R062OZawBGEfDETnYlkvZYwwgSI4vBgcksn3D17NPBV52/fg
         s3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746923758; x=1747528558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtRaVsiUBI+SZ9IP8U8WDTO4rTZdygKMrFtkoyTuE/s=;
        b=XrAfC66VrKqdgnRH9rQRe6/YQrzJoJsbAC2j1jwafa/CEYYTbyX7cApUmH9GmXnWFf
         nQqyonlAPeXMYq3pPQa2CeAoqfj6dhRxkLBwoFFr304rkXC4S1kFN69gCQpanqsHvkhO
         9wgzIHYkmhznw/Z2gZXqszhNbKzIAB6DgYn2VtYF3ioNKfV1t/Nb4zUzDM0FHFNAKOAK
         b1vKEsU0M+wJRPmT5zijgLWk3pd5BreivooBkclT/2OeG6C8OfB8Sfvd52FiC453e/fl
         nZVgOmknmVZ4GC0xKfsEkKjkEj6b446g42qfSF//eChv0428OchTTmulVEdFFeAlLTSe
         vANA==
X-Forwarded-Encrypted: i=1; AJvYcCVMyzQrdA2jBQnIMmPBU2KfqciOZ7qoZXQffHscXKqBD2aTX3YEfCp2DpHaUq2YiSGmiv4RhV1oArtykw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUk1oV2AEmv4CQXpQulM79l8LulOVzZHazhaw/XRV9ja/rAU/B
	YCmzNIiMVy3DFDJT7nt0qo//exXdvuJ3mHDwwZxFJBohbj3boASpUysMlGky9wD6QWqpnj2N8yA
	+BQ6hnbPDyrxsTCULAsV7eyr0LD6jqQLAguwi4g==
X-Gm-Gg: ASbGnctP7J4/BQuJZP8bgbuvJte4WR4Scu+/RahXx5mh5t90hTWNkDnKmwjwhclWslV
	Nulyz6kGDHN2QMr5fTW1yvNVf1sLGuT5wTcI7eDBvqGzWH9qaQ7YnKwpzuWD/Lv9MQdZcvmEfOB
	+x4Dmye0dQH4J34R1GrSdpaawmmwWmMNY=
X-Google-Smtp-Source: AGHT+IEQchr0wi7aB6E+8gcZ5oqBZRv0bHhEJAH4Nl3ce9Fg2GOxYYgtWBIB9g4f0p6+kGvZGmGTGjU/TmWpKmQUugs=
X-Received: by 2002:a17:902:ced0:b0:224:216e:38bd with SMTP id
 d9443c01a7336-22fc8b3b40fmr53521885ad.5.1746923757953; Sat, 10 May 2025
 17:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com> <20250507-ublk_task_per_io-v6-2-a2a298783c01@purestorage.com>
In-Reply-To: <20250507-ublk_task_per_io-v6-2-a2a298783c01@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 10 May 2025 17:35:46 -0700
X-Gm-Features: AX0GCFvq5YiYiXLcLb8hsdNH-xK5jnR1e6XUTmKox4Zk6Icabgf3xuys_D3kZR8
Message-ID: <CADUfDZrhsQfx6nyCZQq=8HDZLysa48uBWuENY6oKnFuayt-wCw@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] sbitmap: fix off-by-one when wrapping hint
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 2:49=E2=80=AFPM Uday Shankar <ushankar@purestorage.c=
om> wrote:
>
> In update_alloc_hint_after_get, we wrap the new hint back to 0 one bit
> too early. This breaks round robin tag allocation (BLK_MQ_F_TAG_RR) -
> some tags get skipped, so we don't get round robin tags even in the
> simple case of single-threaded load on a single hctx. Fix the off-by-one
> in the wrapping condition so that round robin tag allocation works
> properly.
>
> The same pattern occurs in __sbitmap_get_word, so fix it there too.

Should this have a Fixes tag? Looks like the off-by-one wrapping has
existed since 4bb659b15699 ("blk-mq: implement new and more efficient
tagging scheme"), but it's only a correctness issue with round-robin
tag allocation, which was added in 24391c0dc57c ("blk-mq: add tag
allocation policy").

I don't have much background on blk-mq's round-robin tag allocation, but FW=
IW,

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  lib/sbitmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index d3412984170c03dc6600bbe53f130404b765ac5a..aa1cec78b9649f1f3e8ef2d61=
7dd7ee724391a8c 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -51,7 +51,7 @@ static inline void update_alloc_hint_after_get(struct s=
bitmap *sb,
>         } else if (nr =3D=3D hint || unlikely(sb->round_robin)) {
>                 /* Only update the hint if we used it. */
>                 hint =3D nr + 1;
> -               if (hint >=3D depth - 1)
> +               if (hint >=3D depth)
>                         hint =3D 0;
>                 this_cpu_write(*sb->alloc_hint, hint);
>         }
> @@ -182,7 +182,7 @@ static int __sbitmap_get_word(unsigned long *word, un=
signed long depth,
>                         break;
>
>                 hint =3D nr + 1;
> -               if (hint >=3D depth - 1)
> +               if (hint >=3D depth)
>                         hint =3D 0;
>         }
>
>
> --
> 2.34.1
>
