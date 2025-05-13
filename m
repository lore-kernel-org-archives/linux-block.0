Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44E32BF962
	for <linux-block@vger.kernel.org>; Tue, 13 May 2025 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747156768; cv=none; b=sZuh/y61qFvsrI3SYa5qRpYxJWl0OGTAN0JepHFY7r8tFYBRme40UqesoWT2Vg1kVduoJKtfH5hh54mFi5kLJqDakp8daaFEaMJm67SglXfxjbthz1+AhO+t056VgIs64wcb/+SdfUntANkDXyFyDaOVoGdUzOUYm08cB2KlJjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747156768; c=relaxed/simple;
	bh=NWeqbvykOxvfLXz0Z7sRFvdkhnWXdiKkSRRN6EvsidI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+aMCFMj1KMLPH/6mvceru4Ykgfq1Ty3r/eD84M7MISl6YLM1uh3BvxHYIZPaPySrCLLpEC7yNRyIi86ZDVf7FLukCVRhB6Zt1S1HNnqadn8j0wQM4EQehxMJOLJ1fVGtYy3sibKzCsRGymAbIRRWODsB5oM/RtMXocBzkd3zM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=efA0gvJn; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="efA0gvJn"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b1faa09bae7so816896a12.1
        for <linux-block@vger.kernel.org>; Tue, 13 May 2025 10:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747156766; x=1747761566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWeqbvykOxvfLXz0Z7sRFvdkhnWXdiKkSRRN6EvsidI=;
        b=efA0gvJnjkLXEgito2sT3bVigQSdNN6nbc5NzxK+k246wDWG1W0gd/PMrKuu1K6khi
         zx6Vsa7twT0q4CPB1/5VeuSzkr+M6GLzwLZjmD45CM3o0tUOi1eL+GBWQYBGhgVf24Am
         nVeLdvdSzwSZ3GF8LdCac2ujBOsye5UDtd8kcVAgJS00gXUFaRacuAFwjSeh65q7XkMR
         0ApeD2zaam0cykTBJUCq3qw4up+/dPXrlPP/3kn4xxUgqo9g/MNW4y/0OKDaOx5x83jF
         gV1QeZsVUzSwkGgN150vIopFAZ2GcjuLFrss+ADcGt+rm1XexkH55Z4ox/+PEgpx+LRY
         wfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747156766; x=1747761566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWeqbvykOxvfLXz0Z7sRFvdkhnWXdiKkSRRN6EvsidI=;
        b=U69/fkptKamnEjQVoFCJ35wF4AyVpeeOH9FrBpyZZtw+7FD0NYRaFkLIC7ozw+0lmj
         kfeAGPlTbXcE8PiGj2jMzndnJAoQmW68/eCin2tycTPrKj6NHp0kLyN53fY2rhBUJ8TW
         b+qZLiN7HpyDXJWOLCL1oO+a5FnzcR9E1/s8vJ3G7FqnB8lq5qL2SJfP3+dPGCYqlSu6
         ilvVCttT6iqD4EV3ILLkqW9dPxU5LYz96tU5Yz+xkGcLtpXT226E+1riOeQFalvqedAg
         /JrYctwVcEU6q/rIkwDauya/csirsDhOhwnM41tmbuLpu4DyE4583mXZcQPowslY1Hwl
         MD5w==
X-Forwarded-Encrypted: i=1; AJvYcCUwPdACFQqjvY6bp63j+hLoDpZYicovHmY7qnFPRzbJ20EmEhU1oiClgUz/SV48qudzTouuWMaTCoguWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YytPDv52FpGvrkgUgZwWndYU/vO3853LUxKTbYdTgqiA96vqfvs
	q1P4Npm6NX45ACfEchYLBzxocN45RhOq97qC6SBwOhoG7LXV2iwHaOwrLALCkgn2VTa0tGKt9C0
	sGc7QCsWeXUe58tKlf3duntopa2Ki4Ax6SNuE1Q==
X-Gm-Gg: ASbGnct6oi7iENMBBnZCKUsV5xRpcnI8GxulJIaYs3YBb4p3GMJU/xMklHPmCLUdMyD
	YX1+mb6LlY7904VXK8usTXp3bqGo9S5k5eNbMzHp7sj1Cy5/Yw33PBHf8POCac/kIOrUXJzvNJ1
	WqE8VPjxsJCQ5656UQsPU88p+APlHBdFw=
X-Google-Smtp-Source: AGHT+IHVOFib6ugRZl+kKAnXXQ0Sq+yuz7Tb6o4td3gVoT9CVRFilnBOFPQhM+uKjkCVZzTnAH2LBR08wEueZMolF6A=
X-Received: by 2002:a17:903:1b0f:b0:220:e98e:4f17 with SMTP id
 d9443c01a7336-2319810fe9bmr1450565ad.2.1747156765910; Tue, 13 May 2025
 10:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509150611.3395206-1-ming.lei@redhat.com> <20250509150611.3395206-2-ming.lei@redhat.com>
 <CADUfDZpf=dXnjo4Jpf+U33_H1OYUwvvDA4O=aw2xM9zZY7-rOQ@mail.gmail.com> <aCK2-MgeGZiBBzlF@fedora>
In-Reply-To: <aCK2-MgeGZiBBzlF@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 13 May 2025 10:19:13 -0700
X-Gm-Features: AX0GCFtMMio1r_FmRn2-GKzdsuYviyvTKKHIDT59ejW3kQyEJbQiRtD_Erk-S0k
Message-ID: <CADUfDZpxNGFLhik1MuDoFQTou5jddzDWiBmeMz8EQRpt2Cc86g@mail.gmail.com>
Subject: Re: [PATCH V3 1/6] ublk: allow io buffer register/unregister command
 issued from other task contexts
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 8:05=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, May 12, 2025 at 01:25:35PM -0700, Caleb Sander Mateos wrote:
> > On Fri, May 9, 2025 at 8:06=E2=80=AFAM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > `ublk_queue` is read only for io buffer register/unregister command. =
Both
> > > `ublk_io` and block layer request are read-only for IO buffer registe=
r/
> > > unregister command.
> > >
> > > So the two command can be issued from other task contexts.
> > >
> > > Not same with other three ublk commands, these two are for handling t=
arget
> > > IO only, we shouldn't limit their issue task context, otherwise it be=
comes
> > > hard for ublk server(backend) to use zero copy feature.
> > >
> > > Reported-by: Uday Shankar <ushankar@purestorage.com>
> > > Closes: https://lore.kernel.org/linux-block/20250410-ublk_task_per_io=
-v3-2-b811e8f4554a@purestorage.com/
> >
> > I don't agree that this change obviates the need for per-io tasks.
> > Being able to perform zero-copy buffer registration on other threads
>
> You may misunderstand the concern, it isn't for solving load balancing,
> it is just for making zero copy easier to use.
>
> Not like other uring_cmd(FETCH, COMMIT_AND_FETCH), register io buffer is
> for target IO handling, which shouldn't be limited in the ubq_daemon
> context, Uday did mention this point in above link.

I think we are in agreement, I just interpreted the "Closes" tag
differently. "Closes" to me suggests this commit addresses all the
concerns motivating Uday's patch (making that patch unnecessary).
Uday's comment in the commit message that "The problem gets even worse
with zero copy, as more inter-thread communication would be required
to have the buffer register/unregister calls to come from the correct
thread" seemed somewhat tangential to me. The primary concern is about
having to handle incoming ublk I/Os on a single thread or pay the
cache line contention cost of sending them between threads, which
still applies even if the zero-copy buffer (un)register can be
performed on a different thread. Maybe a "Link" tag would be more
appropriate?

>
> > can't help with spreading the load if the ublk server isn't using
> > zero-copy in the first place. And sending I/Os between ublk server
> > threads adds cross-CPU synchronization overhead (as Uday points out in
> > the commit message for his change). Distributing I/Os among the ublk
> > server threads at the point where the blk-mq request is queued seems
> > like a natural place to do load balancing, as the request is already
> > being sent between CPUs there.
>
> I do agree load balancing should be addressed, together with relaxing
> existing ublk server context limitation.

Agreed, I think both Uday's and your changes make sense.

Best,
Caleb
