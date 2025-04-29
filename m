Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F2515A86B
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 01:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745889272; cv=none; b=PghP+idzK4loD+rhaQ0MwP6mlk0xmotaW1v/ZLUrEZlNJyqiopYYEQ8/X8W73COymYqO9DYhelJZV/ZNEXC8ZpwK6uSROjSUBdzvw/MZM8Z/Pnb+j8bkn4pEofvBfW3ci5uhmMjWtsdU32JH9l3m8QyHeX7Vsj8MVaZKXjEnwmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745889272; c=relaxed/simple;
	bh=RBo2Mn2bHpGNB8UyjIFOM04DyWMkqTId8WGEcsfsEAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdFwpgZ3SKxCyqNoCsl3W0H3ZNf15DQqMcPhzadNEMy9KjuWlFFlfw92hGdYkuAD7G8+goBZ5Qp3LT5RAHA5zsSUTqeN2hwDfABo1Y5y2rdliD4ystt++TrLHVSHsGcityZrKWpE5VALHcgByCcpQMqR4UtK26JeL1+vb0/6QAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QsaoFzQ5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QsaoFzQ5"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22c50beb0d5so9816515ad.3
        for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 18:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745889269; x=1746494069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4vcXlfoh1sb5Lp53u4SYaNwf3Gog9dLAy0NFh4Rsl4=;
        b=QsaoFzQ5H4Rn0aMhF9c83w2g3l9VfJhGs7TrwZ3hU7+t1cP/kgxwG5J119zSDN7jXF
         yW9Ladf9geCrmFFhXqydUZ1W+68iSPAxfnmbwJ+bO21Cp/i+/o0eSEhloOetcvpYWb12
         EA8FzgixdvLLDTDB6OgPOMJC91GOrTk2Z/xuPJFHr1d/Vci9aigTvBis88Xs6RDTFt4Z
         FvByyg8+XE1SnC+tLQB3p6rdY5rBKSHGnGuMbThyCTNAX7SgUvwCJ//WIfYklklhEdR4
         Pe4Yc7nbSyOoKjy4I4Kg4w7THn1CGCDUnf52rYlmCo8LzRBBMo/wWuMMGBUoqjZILaaR
         T74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745889269; x=1746494069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4vcXlfoh1sb5Lp53u4SYaNwf3Gog9dLAy0NFh4Rsl4=;
        b=WhP2zn7bSoYlaQOuy0/OqPDrI2XVuP/VhaamYNHIZ3fh8d3y3r+wKMESdA7phkGi3+
         mVXmElbaO+vFl7e9zOfTp9bM5Spxz+9E67sPEr21eHsXw16klwAjDlsZGLzH/OqMT0JR
         aB9FP5JaPhCWCXi4MSLa3n7PZmkI7OKa0M9B98ks3JWZz4RSOybfnqiD9lDaTVjqliXU
         lZGLeWcW7PPQVUXROhif5aSIsayg+qH+QanbHDaPZXpNufZo0mmREgigM4N8xWmRUOnu
         cCGTRV4Ayx84pOBsJI6tdfQ8c8PrjPSaVf6ld6y2CMZ5pvvau1eWGJFCdhvsr/1ahAMi
         mx7A==
X-Forwarded-Encrypted: i=1; AJvYcCUrw5VdqTjC11t9d9MpTkNnDxeeC+iFgltotZi+F52obKJTPmjawGzStspzo0TZy5xgndFXoDxEL6uQow==@vger.kernel.org
X-Gm-Message-State: AOJu0YydzesGLJOVpFLu2VS+/WZli1SZ5vasBvVrgX2Orv+JaTdrLV73
	6Gh+66XhVwVA0eCKoUuNyNESNeMTJfPQGbgWBdP0p00F6j9Y+yBZ9NOObqY/j7FOaXvHkxgNKdW
	JbK+fE6B+miw8yfC2JAkKoYDZ/vg+FWVkn8Dv3g==
X-Gm-Gg: ASbGncssfn5fkji7nKaAEdl0JEgdx+q7g5k0ZJ7T7nHRPoG0zu+VXSGj+Yj/kH571O7
	USrOr1Bq0pO3gugFycFsSmb5BdfoBxpbHqfG5IeQ0P2HctUY1NY9HKh6xdwkcldY0EsBNG0LSxI
	q9yf7qCkFtdRCgHkv3BWsQ
X-Google-Smtp-Source: AGHT+IFMpUZdt5lXnWrFzoh8OA7WWo+/2IpzA/SAH+spW51gqncIW/npr13RagDrKvIc6dwu/oIwOxqV/BuZrVE8xqo=
X-Received: by 2002:a17:903:2a88:b0:223:28a8:610b with SMTP id
 d9443c01a7336-22dbf740e51mr76238555ad.14.1745889269544; Mon, 28 Apr 2025
 18:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com> <20250428-ublk_selftests-v1-3-5795f7b00cda@purestorage.com>
In-Reply-To: <20250428-ublk_selftests-v1-3-5795f7b00cda@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 28 Apr 2025 18:14:18 -0700
X-Gm-Features: ATxdqUGVIUaNR-zw5kYKAKCRBndgFNnTDWO54aCDFlmFpL_UjMXcDrWJSBCI0n0
Message-ID: <CADUfDZoKictpMvAgu9FPbHRLVns4HvBgwddsCBgHsH9nhiK4AQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] selftests: ublk: kublk: fix include path
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 4:11=E2=80=AFPM Uday Shankar <ushankar@purestorage.=
com> wrote:
>
> Building kublk currently fails (with a "could not find linux/ublk_cmd.h"
> error message) if kernel headers are not installed in a system-global
> location (i.e. somewhere in the compiler's default include search path).
> This failure is unnecessary, as make kselftest installs kernel headers
> in the build tree - kublk's build just isn't looking for them properly.
> There is an include path in kublk's CFLAGS which is probably intended to
> find the kernel headers installed in the build tree; fix it so that it
> can actually find them.
>
> This introduces some macro redefinition issues between glibc-provided
> headers and kernel headers; fix those by eliminating one include in
> kublk.

I'm curious what symbol was redefined. struct iovec? Anyways,

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  tools/testing/selftests/ublk/Makefile | 2 +-
>  tools/testing/selftests/ublk/kublk.h  | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selfte=
sts/ublk/Makefile
> index 86474cfe8d03b2df3f8c9bc1a5902701a0f72f58..feca641635d706a856898f8e2=
2a630f5f47361b6 100644
> --- a/tools/testing/selftests/ublk/Makefile
> +++ b/tools/testing/selftests/ublk/Makefile
> @@ -2,7 +2,7 @@
>
>  CONFIG =3D $(top_srcdir)/include/config/auto.conf
>  WERROR =3D $(if $(shell grep CONFIG_WERROR=3Dy ${CONFIG}),-Werror,)
> -CFLAGS +=3D -O3 -Wl,-no-as-needed -Wall ${WERROR} -I $(top_srcdir)
> +CFLAGS +=3D -O3 -Wl,-no-as-needed -Wall ${WERROR} -I $(top_srcdir)/usr/i=
nclude
>  LDLIBS +=3D -lpthread -lm -luring
>
>  TEST_PROGS :=3D test_generic_01.sh
> diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftes=
ts/ublk/kublk.h
> index 918db5cd633fc1041e1e0805142f00e7e4f28bf7..4b943e57a890e5f14fa11dd19=
d67c4c8684c4417 100644
> --- a/tools/testing/selftests/ublk/kublk.h
> +++ b/tools/testing/selftests/ublk/kublk.h
> @@ -19,7 +19,6 @@
>  #include <sys/inotify.h>
>  #include <sys/wait.h>
>  #include <sys/eventfd.h>
> -#include <sys/uio.h>
>  #include <sys/ipc.h>
>  #include <sys/shm.h>
>  #include <linux/io_uring.h>
>
> --
> 2.34.1
>
>
