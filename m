Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7051D2236E5
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 02:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765508285; cv=none; b=Ks/Ea40ykFAn2ZzxW9I3JBHwxzJ9CxWISMtJ4HnpqzTCn4+t45Zb+ORTSWtC5x2+sp9SfvS7ojd0Brro1z2i6ATYf8efU0s1Vr9UAnZe0egq0HAk2T49k6HX6jIaKCOOTrAIRs+z9FA1Min9lMI4+RTAFoKYq0Aet/CSoYUNlqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765508285; c=relaxed/simple;
	bh=cFZuvtZvFaPr5Nc2//tDXh2B5PTBSEiMM4gmTxZg2bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEf3Oc3vHaKn2PIK9FTD/4+SdEMH5TFLdgrjMUOniHF8w+AyNFKF0mJR/Q2hB1/026RcwDskZUHIYMuVtKqpji1PZYJl+WBpqGnFhmhdDz7ztJ6IKHyvL6720DeJLJzoj2fSlg6X0Zg8oVEP6SYl2YAY5w6f6fJ/6iUdEvjb0jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ChWrxq5X; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ChWrxq5X"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7f6282195a9so72105b3a.2
        for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 18:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765508283; x=1766113083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tZ2UhHZUn1dDxJ65xGh50oYYgaZbAZX6ri+8rDQnVY=;
        b=ChWrxq5XhFfxmJk3EQ2uxdHc0W8raNo+xXD50tkMYCzSnfOz2Wp9rMiIPHzuu7aJx4
         1b0Zf/1ykXIKHTFHTsKFaWoYdUaSqwtWull4frYlgz6WfAdJ2cbdZOIbXaVJL7xKhZ7t
         W2081ruh9yaPjmkEKgWsZ38iddX6UN8YFjcSgEGfBSOCTyE2hBf6Ga9uIHrSFPOL/9JP
         9DOjqvY6yv3KmADtKDlNlO9i/OtiL7MVE33AC7ijHybXiW0562ankeC+KrRuEeDqlT4I
         MuMQZlpVqbGAwToDoMlVG6OZU/ZypdWLb2SGzl9Fg8LXzVLznYR473kB6Eoj/XOcNEFC
         MYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765508283; x=1766113083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8tZ2UhHZUn1dDxJ65xGh50oYYgaZbAZX6ri+8rDQnVY=;
        b=mWPNC8FlkfNBKnFLQQJNZNsHCkxlE5X0PcrUPpNqZM9bmZdYsZFuqMq7Ke7KaQVhzD
         iU9MTG7C1mDogNaOyDjVAeqGJvmzyxNa1PrdikiS7fAJY5kdDSAbsQTlLk0L7mhQTZau
         FlO78e060c0Ybug74QhhsbzktgFyhKH/NJXzqkJ1eDfJCmgFJleYpD55XOaFWho++CtH
         333r0YVAjwu8Z6yIKjqSFFCYo4IRefPG9cG1jybZxukO3k4wNH1s98u00NZcytQSbf9y
         qS0kli8J9ye7aSz+L6r/cY6INXVZiV/cFfqeq34egqHgV14gGkOnRCotCGRKQi1zdg/w
         gpPw==
X-Forwarded-Encrypted: i=1; AJvYcCW5Uzpi1OxQDELwInyYcDEKfneRwA3eQMLi8YEZuMTZxYmOgGA5qdokmEq+wMbFB3jCRJIFw26sQospxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLTd6V2Nym6bI6DmFVPCZ/ll5eM20fHKPeQq29CDbaL6/jb97w
	UWqhW0iQhQsYIUbJ76zXzDPI9LtMipJijA/ZxU04cPFQpwhL/imh+KyyU8I4ft4mAiSVldvYJNN
	f6RdUKsb25qaJTymw2l+yz6wACrBR1M74S/gLV24Ijw==
X-Gm-Gg: AY/fxX74rvI2OhcfYWCVrxi/KVJxNJfsnxsXo6t5bGHOwiwjB3xAFIDhodAkCKqrVWb
	FNaQNDTfkSM3rjgolWFFP7De+lnUCzhbCFdBW8JxdQmB4rElxdmZ8jUkLwndP73CsArXdjvhAWQ
	O4JGXCEuUUCVQmvK/OVSj+/2YI5hn4ndqvHx/jHiKkQFeUH6ctIXqjz+UmJga1tHzPVR3feKTBH
	xMYNUAd/ea5DmBvvJN2CLTvI358PN6WBPmHjgKiHa4mFYnX1tlnhRaLx5buWvj5AqHCRfispxCD
	C1UIlVk=
X-Google-Smtp-Source: AGHT+IExE5ovBJ39/Yj2xRwH5EDqauq5UWLgEXD+pDVKooDfc2ZAP2BQoBeLcRWV/NlLVe5aV6z6L9Gem7bF+a0UiL0=
X-Received: by 2002:a05:7022:e1e:b0:11b:ad6a:6e39 with SMTP id
 a92af1059eb24-11f34c1c62dmr369491c88.5.1765508282564; Thu, 11 Dec 2025
 18:58:02 -0800 (PST)
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
Date: Thu, 11 Dec 2025 18:57:51 -0800
X-Gm-Features: AQt7F2pX2v3XK-TKVpiHRCDZMRmiui6JAuhNclVb-QEeu51knO_ITiRidetLKqg
Message-ID: <CADUfDZpaNEd2fq3_osmm4kvSevkbi_mo=5H1frXAHrOmQNc7tg@mail.gmail.com>
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

test_stress_02.sh ("run IO and kill ublk server") already covers plain
copy. But sure, I can change the test_stress_04.sh description to "...
(more features)" or something.

Thanks,
Caleb
