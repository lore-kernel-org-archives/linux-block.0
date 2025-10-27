Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283BC2E5B0D
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 20:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761596695; cv=none; b=iffNUc3FrAqfmiwOwl9lAbL0DeDSvuGdbIaanHxzRzq46t0yCzdf0aJeIYIzVSG/1BII28/OXdBrDxm9IJysqmIlbhNSy9cAMs7buFmfIwjtNAokb6zEeAv/cdv9nlAVvTl+zO1wYpR06vLNTNLzYjNRuO7+dvOBn6UovR/5X4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761596695; c=relaxed/simple;
	bh=O26YNzEdJ3QPI+0VWzw6KhHngkhD5YgkTZsq/NIar8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KkaeHojQuZWf4UldK/m0gWp2K5LRnnzYk70bqTmns5biUEcYwa8CFQ/dr4vPCW4YY5NmQyiHLKyibbqcnEo17fk6YCcime5RqI6AfvBHWJ+F8DgxM6RZzCYn38uBMPMDHFFhTi1PyNUN9ozNuIgimk6E+cZLsS4NEnAiRlDJDHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IE1kYpNn; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IE1kYpNn"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so3460203a12.0
        for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 13:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761596693; x=1762201493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgWagJo2YU/oFmsKHPKceT2jMbhn9OwgubjxZ/WaMPs=;
        b=IE1kYpNnASmzdMHFZ+P3Oh9wrlZ75TdhMaxHCviyH+A93AEvjG/WfIwcHkBHOv/NQv
         d6V+YZYSnTkMAEgdcykGmrnE1UKlqEBkTLYyC0jOJExxp0IR4NaEtS5wapNAWMF96UpS
         ExWDDtIHsW3/8i+fjrYQB24GQwR1tfWYorQo7gsNhI/yC9R1LaOL1S1q+hsjVup5zMeJ
         46TQ1NHXKRLOzkgjnkAVTIJ7V/C771lZXFZ+oEz22j6Gnk1LA5xCE2Se3jXDybNrdopI
         nJSZE7L4JCiUrbGi/+4Nb2ymSRk7AHYnnNMLD96YT6sy1qwVRWJ7PAILRVLDy31qHy0K
         kzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761596693; x=1762201493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgWagJo2YU/oFmsKHPKceT2jMbhn9OwgubjxZ/WaMPs=;
        b=PdWAk5sbYkV3X1Jt5bUZArdYl5bkXDy4ivcmLXvcLRnTsY5sQhaYuOsVVVncMR+KWY
         NKe3hphhRjO1VTIjj+gSp02HQgsQ5lOB3kQUDZuGbJVDdvG/ZKAf18Mz/KeSjgf5fsUo
         zBqmY8+b8O83SkmmbbzIw1FQ++0Jchhf9+T6yerFTbBbauZbvQNk47yrkozbUQe+C4HU
         aoj7cDu5qvNWXnKC7YyR126JuWERSTHw0SYpmp/xi/6kDaN0Ft8Z81fc4Q72Yf8kSLPS
         U5JmZPq/b2GQq1cjwOrVuBB5FZV+1Ar6J+8+n5qs5DhN8+EudBFo5ZpbN3H4UVlyFdxv
         5dzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3uo/+Gi6PS1o3H53TVkpc26hKZYkeGDE/5YpQmi1Ikq+ow/UOuyeAwmZZ42XYoU2oyghlBtJeojC/iA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXUcIK0h7FJmECNihH9sqJxjIzptH42ub9FevBfQD2EP+SBhrf
	19zS8YhPT9JJBBCtFSTduvj1/efIPcSiopei1he4DTE/W+dDXOMBqv1bc9JXvMTZbqzBOb/fS8H
	f/rAlUbppv7Wj2dpC2yNVXc4EQwoW/KPptut9nJBApJ+FXZigtZuiMg==
X-Gm-Gg: ASbGncsgK3XFeQg4PIS3vJlmu4G2EPU4WwP8lw9wUIgcWTwtF4SvKEgK7gjTuIbZ8uA
	7PHr6CNcdipuKNGjhCcjBqde0A0tT3vuZhgbRSU7PpmTB+XJfIisu97v3sScXRmSVsk7cWIWwIi
	NdLoQVfprQm+Td1LVz69qi/lo71RMVE54+6BXEvZtfGKiom7gp4W7nQuXYmpJYrHcDZkkgeaNyH
	ZxBROdBhpkZNyhA4ANacAYRdrpwOMdkM6ve1JiV78L6k6lO42Z01HfZUFvV
X-Google-Smtp-Source: AGHT+IFDV3g6ErN3yxsEWnHW1/CkPBxwftrCLJfB2QJuWDrssPOc1igql1P21JcoH56S8Ml7SDBpIHdU/bMeTDi6Uzk=
X-Received: by 2002:a17:902:f601:b0:272:dee1:c137 with SMTP id
 d9443c01a7336-294cb384b88mr11688695ad.13.1761596693344; Mon, 27 Oct 2025
 13:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <37fb8720-bee9-43b7-b0ff-0214a8ad33a2@kernel.dk>
 <CAHk-=wgZ9x+yxUB9sjete2s9KBiHnPm2+rcwiWNXhx-rpcKxcw@mail.gmail.com>
 <aP6OJTTWPQBkll56@mail.hallyn.com> <CAHk-=wjE5t6=eO90iXqEsw6yMGfE8Y6=THP0dqXUJHvNQ7=gMg@mail.gmail.com>
In-Reply-To: <CAHk-=wjE5t6=eO90iXqEsw6yMGfE8Y6=THP0dqXUJHvNQ7=gMg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Oct 2025 16:24:41 -0400
X-Gm-Features: AWmQ_bn8BYWuSBwc_rGyFbpuoo8trBAKKr6VahOoiHX2AiPEdC3J7WklfW7oY2w
Message-ID: <CAHC9VhTTaMe3ezEiXUwLfgCMrp7-of_K-9HmHk-TKApq4sGbfw@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.18-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Jens Axboe <axboe@kernel.dk>, Serge Hallyn <sergeh@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 6:57=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, 26 Oct 2025 at 14:10, Serge E. Hallyn <serge@hallyn.com> wrote:
> >
> > The keychains are all NULL and won't be allocated (by init) without
> > copying a new cred, right?
>
> Right. As mentioned, 'struct init_cred' really should be 'const' -
> it's not *technically* really constant, because the reference counting
> casts away the const, but refs are designed to be copy-on-write apart
> from the reference counting.
>
> So whenever you change it, that's when you are supposed to always copy
> things. So that  prepare_kernel_cred() thing exists for a good reason.
>
> But the pattern here in nbd (and the other three usage cases I found)
> is really just "use the kernel creds as-is".
>
> They don't even need any reference counting as long as they can just
> rely on the cred staying around for the duration of the use - which
> obviously is the case for init_cred.
>
> > Now, in theory, some LSM *could* come by and try to merge
> > current's info with init's, but that would probably be misguided.
> >
> > So this does seem like it should work.
>
> Yeah, I can't see how any LSM could possibly do anything about
> init_cred - it really ends up being the source of all other creds. You
> can't really validly mess with it or deny it anything.

This came in just as I was logging off for the weekend and I've been
kicking it around in my head and I can't think of any *good* LSM
related reason why this should be a problem, however I do have a
somewhat generic concern about potential future issues caused by
someone choosing the wrong access pattern and causing an odd bug.  In
theory, a const attribute should catch a lot of that before it starts,
but that assumes we don't have some casting somewhere doing odd
things.

If we care about this, and I'm not sure we do, or rather I'm not sure
how much I care about this, we could create a new cred instance, say
'kernel_cred', that is purely for things like nbd where no changes are
expected and it can be accessed directly.  This would limit the
direct-access pattern to just kernel_cred, making code
inspection/review easier and leaving the door open for WARN_ON-esque
assertions in things like prepare_creds() and similar*.

* This reminds me that we need to talk some more with the keys folks
and see if we can get rid of the ugliness that is
key_change_session_keyring()/security_transfer_creds().  Jann had some
patches for that, but if I recall correctly there was a concern about
backwards compatibility.

--=20
paul-moore.com
