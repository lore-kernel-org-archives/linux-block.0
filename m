Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BE1146D62
	for <linux-block@vger.kernel.org>; Mon, 13 May 2024 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588071; cv=none; b=o5kII4rp7NrL9uw4tQ0uIJpZZTdMqCqMXLX1PfbGazJlQFiyx6UlUF3qYVNYd7vc8aziHv+BmfA8YJkVoxQDROmg7El/Hk+88zMVTLcUnykQ4U51wSKibwZrspuZ411lS4PGg9CFOleLtuG/fdAjmuLoyl7mD1BUpqyLZzX0FP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588071; c=relaxed/simple;
	bh=12ml4wWfxQl4jhbhqgvB8GySKJX6FlqTruuxJO3r50s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XoVgh32CZsnNJlF1lE6Pc3/9Q/oaBvHaxd7bvznjmiRGzzCQSzOpkXmFmPaOzVyc0Ikkhiawfh6GjyB5u8CRz6mKGJuGe73wOG0el07lja6PorsD9RirvKJD2SlY5/La7boRE1awBYcKok8ZPDzmaVAyzTtMxP01f0Hq5+GUc2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mc6nznAe; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mc6nznAe"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7f34ebbcde4so1152287241.3
        for <linux-block@vger.kernel.org>; Mon, 13 May 2024 01:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715588067; x=1716192867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f0QsI6eg5FRHjsJ3EXAYkOdUsRM9QF3yW2xylikNfdY=;
        b=mc6nznAe164x80c7YoJMbtDNP7Os9yNeaBOuOgoZaxVmnTpTXhM7aXwA/BFq3OedU5
         ozmMpKEAjtcIUyHUS2E8C5Qu9VOhR49+rPByIeMFdjknlTmKXJpUjLA0foRWY6F8M0sp
         8nlnj6toixhcQdyJZcf+sKVX6kP2soHeskCQBs4a1kaysSECppmX5ikLPgM474QfHQ/N
         7ancMeBGBARY+K26FXcTt899+m5rFU0XBWPg1brekvl4RbVG9n3wgzPk5/nvfoNZGMs0
         SBvg/Js4n5la2qTIYka+5cqf1HqH2PRcgXeBWJ3aL1jtVKx09Y6wzpyDo1dfYYSLbKdJ
         rEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715588067; x=1716192867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0QsI6eg5FRHjsJ3EXAYkOdUsRM9QF3yW2xylikNfdY=;
        b=bkxdUlcOyrBWOsZ9t01IiZUyx/zxAMi1LJ1oBMK4Qy9SJxl+gyD8m+2hqHI0ilLk3T
         oLaLsm873LwI0PIrVIRB/re4Ie7WfF9Z2hZtlt4MiW9F/bq7ZMjgD4s6JAJ2EFtdUkXy
         8YhbYoHbcuy+HXTLddEMMhuQh5bmTO6PMH2NuSsw3jgb5OAF9TBHo/++ihbgjSzC9Y1i
         26NF8sLnabYAdM/bB0ynX+ivR/pq5tW/HT3/WwR0PirV71sE+Og6h9iaYtYJR9cj/LXL
         LTc5S7P/vV1qb+FBYg8La7wakaty9fBj+dLz1C0QX2L6rNCuwlxhNkk2SMsb4Zx0Z7Cl
         unQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5elLMiWyo6qxNsVSeJufHShaoS+wTjmwcNDirsDdShv5QuDdQhDBT0VjSTbAkK9diyg+TqCyoVg+eDdn05RmCuHXxhYM3E1NN398=
X-Gm-Message-State: AOJu0YyOi0EV23zpYvV5RS+n8SNcBgN/9QDXFTiGqo7jwHWlHFq+vfnF
	yZM4t+aQpdEIlNAl33hCrpO/Bzrxk5M/jRCm3y50xQXu89XvnRDCakuJU8cERbBcdoqt8K2gmdU
	uJmu9kQczJ3Gnx+oR2utxBxmRXpxpwCr7oX/alUhPUUTyn/BwQQ==
X-Google-Smtp-Source: AGHT+IEN0CwwIMvMPcNvYrtwL0GHvXK2FmCEs3NcLvhxj5VrVLU78hu+gqQv8TlnVYs4qK+0BgkSJwJf7Ph04NygmMk=
X-Received: by 2002:a05:6102:38ca:b0:47c:2c87:f019 with SMTP id
 ada2fe7eead31-48077db706cmr10268656137.5.1715588067255; Mon, 13 May 2024
 01:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510141921.883231-1-leitao@debian.org> <ef8c5f6d-17e3-4504-8560-b970912b9eae@acm.org>
 <de92101c-f9c4-4af4-95f4-19a6f59b636f@paulmck-laptop> <d037f37a-4722-4a1d-a282-63355a97a1a1@acm.org>
 <c83d9c25-b839-4e31-8dd4-85f3cb938653@paulmck-laptop> <4d230bac-bdb0-4a01-8006-e95156965aa8@acm.org>
 <447ad732-3ff8-40bf-bd82-f7be66899cee@paulmck-laptop> <ca7c2ef0-7e21-4fb3-ac6b-3dae652a7a0e@acm.org>
 <59ec96c2-52ce-4da1-92c3-9fe38053cd3d@paulmck-laptop>
In-Reply-To: <59ec96c2-52ce-4da1-92c3-9fe38053cd3d@paulmck-laptop>
From: Marco Elver <elver@google.com>
Date: Mon, 13 May 2024 10:13:49 +0200
Message-ID: <CANpmjNMj9r1V6Z63fcJxrFC1v4i2vUCEhm1HT77ikxhx0Rghdw@mail.gmail.com>
Subject: Re: [PATCH] block: Annotate a racy read in blk_do_io_stat()
To: paulmck@kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 May 2024 at 02:41, Paul E. McKenney <paulmck@kernel.org> wrote:
[...]
> ------------------------------------------------------------------------
>
> commit 930cb5f711443d8044e88080ee21b0a5edda33bd
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Fri May 10 15:36:57 2024 -0700
>
>     kcsan: Add example to data_race() kerneldoc header
>
>     Although the data_race() kerneldoc header accurately states what it does,
>     some of the implications and usage patterns are non-obvious.  Therefore,
>     add a brief locking example and also state how to have KCSAN ignore
>     accesses while also preventing the compiler from folding, spindling,
>     or otherwise mutilating the access.
>
>     [ paulmck: Apply Bart Van Assche feedback. ]
>
>     Reported-by: Bart Van Assche <bvanassche@acm.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Cc: Marco Elver <elver@google.com>
>     Cc: Breno Leitao <leitao@debian.org>
>     Cc: Jens Axboe <axboe@kernel.dk>
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index c00cc6c0878a1..9249768ec7a26 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -194,9 +194,17 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>   * This data_race() macro is useful for situations in which data races
>   * should be forgiven.  One example is diagnostic code that accesses
>   * shared variables but is not a part of the core synchronization design.
> + * For example, if accesses to a given variable are protected by a lock,
> + * except for diagnostic code, then the accesses under the lock should
> + * be plain C-language accesses and those in the diagnostic code should
> + * use data_race().  This way, KCSAN will complain if buggy lockless
> + * accesses to that variable are introduced, even if the buggy accesses
> + * are protected by READ_ONCE() or WRITE_ONCE().
>   *
> - * This macro *does not* affect normal code generation, but is a hint
> - * to tooling that data races here are to be ignored.
> + * This macro *does not* affect normal code generation, but is a hint to
> + * tooling that data races here are to be ignored.  If code generation must
> + * be protected *and* KCSAN should ignore the access, use both data_race()

"code generation must be protected" seems ambiguous, because
protecting code generation could mean a lot of different things to
different people.

The more precise thing would be to write that "If the access must be
atomic *and* KCSAN should ignore the access, use both ...".

I've also had trouble in the past referring to "miscompilation" or
similar, because that also entirely depends on the promised vs.
expected semantics: if the code in question assumes for the access to
be atomic, the compiler compiling the code in a way that the access is
no longer atomic would be a "miscompilation". Although is it still a
"miscompilation" if the compiler generated code according to specified
language semantics (say according to our own LKMM) - and that's where
opinions can diverge because it depends on which side we stand
(compiler vs. our code).

> + * and READ_ONCE(), for example, data_race(READ_ONCE(x)).

Having more documentation sounds good to me, thanks for adding!

This extra bit of documentation also exists in a longer form in
access-marking.txt, correct? I wonder how it would be possible to
refer to it, in case the reader wants to learn even more.

Thanks,
-- Marco
