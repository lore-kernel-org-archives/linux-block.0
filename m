Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E09D2D1F4E
	for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765478013; cv=none; b=r1uKcp6KJXCaOo9HRBMqko9d+VK0/sloK+QxMp+vvQwvIh1w/WZCacJzHoxXreO9tIMJqJzUhnPUyXxL6c6VRm5c9U/6FFN61LGsaeZv93CjoK4YM0aQcPDc33FgMJImvf/AExmDxvHqt8vCu82L5abQZ8rmR4jG8XgF9xnZ5dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765478013; c=relaxed/simple;
	bh=qhjiVseb9c0hLpyK+o5KCT/BIgMrUwSPZsqP9hm64kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouvMWePqq9/Q5G3Rk1UBn+tBMG1viR7FsbcRX6eqUK9Ah+r0uEJrygXGXLeRfC7z9PHLuP21I6G+9CnJ4L2pro7+oZB1bLiojqD0dDJdeLbD/wyUzJ0o7ISQ1gj50i2yKUpqkCnlz45g0+gsfqDe3ZiozTATAgurO08voDfCVpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=K9eeiEQZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="K9eeiEQZ"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7ab689d3fa0so42863b3a.0
        for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 10:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765478011; x=1766082811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CzQllVsHaRnBu0YY1ocpoGP0GGD4RRsGyDLWa1TmlA=;
        b=K9eeiEQZTV5TDiS1YDREtRJ6YK4IYTEyaEySmcR6qIFLkXC9kZb9Mjk62VCP1u6n3r
         bW+O6OOY2ZwqpLH7KuRTMQYQwjOnHdi29VoMfSl2X+qPqvgak/xOfrDo/Dll8fsQRatM
         /2DNdYySM3FIPYzeSbwA1uTULxpV3bmHMld2Qq/kqZPsI2aZP/tPzWsiBHtltspHBp+p
         fgaNwRdTnCXI4yVOPxDEozw9lJW/AWXK/d2lcnA7EKuebh16P+AUCLiQAEh8RtRA9BIh
         sb1uN+wT3ssiCQkWyETN81nhnVse/ow3W46mQ2NuSVO0jzM8Xl7/iBvdl2AyDaN+OuSA
         qTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765478011; x=1766082811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7CzQllVsHaRnBu0YY1ocpoGP0GGD4RRsGyDLWa1TmlA=;
        b=Db/cxaMwg+mbNUPbkiuJWPFBcnuaYK/nHbTQziJA1aH+Q8Qanm2vkWkzB931I7oxDa
         NM72DjJx0kNQo8jHy+0i0D2MkYV1cddR9VuAxNU9VHmCxwZXRG28Fhn4KKCYTKlhvGYJ
         mHGFSKkIivxjqZf01cpqf71WmJWfzlLJXE46EdBoSs6tgHliv9/QpKVElHFeNPL9SlQm
         NwVNljMaaqB3AzyW/8KnkWWQl35CFQcYWhBjyCxoL+plJxY1dUOo8DVniNBgL6rBbcOR
         85JLMDzDjrjIEHaBda+ibCzUskg7nKHfvsndg3gUHJkLn6DNwzLUZekyR2oenFEdp+gu
         YzEA==
X-Forwarded-Encrypted: i=1; AJvYcCWzfBb4aitlPvsX/gBTg8KtdlXJrVI8iZYIPEGgw/EBxx9J+RqtrIhX4ilG0/71rHQTeXnN6FZcPJYBxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFNmOBsBSfLpg6pLGvlu1WwZYtAAQlLsokDbiX0NH8qwHOITg2
	16F5PFQGASbYfRxjQ3kpXFhQ9X/PVhijqJFt94kUaKM1npejdtHJzT46bHOcgyG7Uc6kebMm1VP
	kKsgNEz3OxRuMpI+4dw1TzXnQCXnudJNMEzTlgIVsuA==
X-Gm-Gg: AY/fxX7gogBFCQsO2srNJnvGXtFONG64LgA8xwE96qBc+mSi+azZFFQTDuXXHwV/zTo
	CExhHVrp6Tc+3zkUsInv/Z2iD8qb3hqA1gQRBI6z5nQHSM+HtLlwItdFv+p8OUJX10hnUEMFacw
	DoElpb/byZVaYnCyglMkg1nQDwst3+2yFdVz+GYvdBsPMUArMNg3RltT6HZutlZ9d4O+F2mA368
	Ql4OAV+Jg3pGezwp2QWlfI50zQFfyKvisBTYHg4/JAMb6yXQLLXiI6TOfLQ7OJ3c7cusW0+
X-Google-Smtp-Source: AGHT+IEnzofhaGpknRdQ2QdNah+srHyc+T63C+jDiM29jp7Hmb402KAGyfqR1A5FayMkz52y+HZmzmPERsQjGGmQx4U=
X-Received: by 2002:a05:7022:458f:b0:119:e56b:c3f3 with SMTP id
 a92af1059eb24-11f2e81ca7bmr1526033c88.3.1765478011340; Thu, 11 Dec 2025
 10:33:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-5-csander@purestorage.com> <aTqJlLbAiup38hTI@fedora>
In-Reply-To: <aTqJlLbAiup38hTI@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 11 Dec 2025 10:33:20 -0800
X-Gm-Features: AQt7F2o-hWdcxVymG0dLZ78o8WjpIr9G8DrWTyDujeKgh4l9X4PsnM6RHuAhKnM
Message-ID: <CADUfDZrR=4RhHa+wFTXMzqEMmCBcRKuAxY0q20PahjPFptNouw@mail.gmail.com>
Subject: Re: [PATCH 4/8] selftests: ublk: use auto_zc for PER_IO_DAEMON tests
 in stress_04
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 1:06=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Wed, Dec 10, 2025 at 10:15:59PM -0700, Caleb Sander Mateos wrote:
> > stress_04 is described as "run IO and kill ublk server(zero copy)" but
> > the --per_io_tasks tests cases don't use zero copy. Plus, one of the
> > test cases is duplicated. Add --auto_zc to these test cases and
> > --auto_zc_fallback to one of the duplicated ones. This matches the test
> > cases in stress_03.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  tools/testing/selftests/ublk/test_stress_04.sh | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/tes=
ting/selftests/ublk/test_stress_04.sh
> > index 3f901db4d09d..965befcee830 100755
> > --- a/tools/testing/selftests/ublk/test_stress_04.sh
> > +++ b/tools/testing/selftests/ublk/test_stress_04.sh
> > @@ -38,14 +38,14 @@ if _have_feature "AUTO_BUF_REG"; then
> >       ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_f=
ixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> >       ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fa=
llback &
> >  fi
> >
> >  if _have_feature "PER_IO_DAEMON"; then
> > -     ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tas=
ks &
> > -     ublk_io_and_kill_daemon 256M -t loop -q 4 --nthreads 8 --per_io_t=
asks "${UBLK_BACKFILES[0]}" &
> > -     ublk_io_and_kill_daemon 256M -t stripe -q 4 --nthreads 8 --per_io=
_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > -     ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tas=
ks &
> > +     ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --=
per_io_tasks &
> > +     ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc --nthreads 8 =
--per_io_tasks "${UBLK_BACKFILES[0]}" &
> > +     ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --nthreads =
8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > +     ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --auto_zc_fallb=
ack --nthreads 8 --per_io_tasks &
>
> I'd rather to fix the test description, the original motivation is to cov=
er
> more data copy parameters(--z, --auto_zc, plain copy) in same stress test=
.

What about the duplicated "-t null -q 4 --nthreads 8 --per_io_tasks"
test case? I can't imagine that's intentional...

Thanks,
Caleb
