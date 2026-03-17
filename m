Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CC339184F
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733034; cv=pass; b=EZzHYSRRspb3TsaaVP3NTLNTj3WK6fPgFslO1qVmnFWERKkI4bDwsyqpgJndTLNH0/5gTuykkbeXcfZKZPKb4mCTHygamCVK2PBWKL25v4sru84z6P4SFuRzBhGDqsDouOwYQ8Uj0nzBlX++5Pe2kcT1yaY5DVRHLQSQYj4vLu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733034; c=relaxed/simple;
	bh=E0B6xp0wJyvQ6PdHIwJ2lqaw6PipcVBjD7iOAyWuQQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMTKe4T2Z18YhSPewvvyTSHry+1y5BDPrRWn2JRo4eAaGpSF+onTAO8tAcGfGTxXiKDDBKhi/QCx89/YJl+R+OjNqefzEid9IUYb0SiDbI3yk4hO9NcUX04LRNCOvYVBfmTJlV9vydYcOWvK54J/lBjjz88rtTax3Tkh6K9vGf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrJwNFv+; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrJwNFv+"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-128d600ad25so309356c88.2
        for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 00:37:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773733030; cv=none;
        d=google.com; s=arc-20240605;
        b=ctn3S0XP4p9xENVZ3qBCewUkWgcanQI1C+oVCZRc2KZnHk92hZ68lGjtGZxRcwDNO+
         EVo2/ueiI4Xv79b+kaWE3WQVT7U+Ey3uipgZbNR7m1e///FKaStxmBE7YCE4GEJXj5KW
         9dd4UehqroPczTQ/ik84j6PUXV2adFtQBu16peLtzOtNZ4j/RiN8bPzUO0ZkCuRNNmmV
         HGsYeh9aWNr+RjCquUEfj4iXHCLUxrFwsZ5FnS2OTLdJhjbMWHjqR8lVvp/34u3nPvtP
         6v0yj8cTJQj1iX/38bjdn7n+HAeOiW7QWrP8upXULtcbySlUseAI8hVJccqP93chHgYn
         MC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E0B6xp0wJyvQ6PdHIwJ2lqaw6PipcVBjD7iOAyWuQQI=;
        fh=SeyKegkbynttrYzC40mYacukPbd8O/xGJY5HRvhj4Z8=;
        b=iFXeID+KYkzo5zPzyGlYR2M6q2k5pWAvbqe1LNge1MNxeyp+22p8UL9MGyU8/sh99g
         s7GkUnDTnIF/+M7kMHUv/nJ9AMTezI+/N2zL/WlMKHZGgVkenMs4hVrRxX6BRHVYlIHM
         9Zd3cLW036Zrfh5A6AwA0DrkF02u9byqCkX6awN2hYVWIuLwrmJLfaqhdagI7jYvQcXX
         GWIjAws2NOzKBLl74VuU2gRoZtMPyczEXM86vBYAtUSU8sCPKm9r3G43Ig5e40gWjoz7
         72oEA1Pj+Ik/VZuxdrkl+4Y9XLG8bMEgqemZUHg6kSn2iSSFLu3Ln4m0ACSzZmUqe11a
         PzZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773733030; x=1774337830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0B6xp0wJyvQ6PdHIwJ2lqaw6PipcVBjD7iOAyWuQQI=;
        b=DrJwNFv+qJ+OkVj3u3T75e1Zwk5mDgFeoYXTSIHD1XHeqSpNxHpXkJ32aqxUf1MDC6
         XW3M130T+VkPLzZQbvFarB8MPLJxhORqRTTRayjFUHoyJK6I9lO+EQxVo1ctNJG/TkZX
         14L0SVjZM6uQP1gmimmOISU/QCMGoXTrTqfkJoZl/F8S2VUtVWc0YEFACfRN5bmkm2Eo
         TdrtnXb6f1A4rGWAhaTPUx3dBPt/VTZQ87SZM9YpmQ6IN6iVkYUGTqsLLD5mSd9tz1us
         WOqGLFUJ0oub2vkQPCYwW6BL7TSBKz5rjQgOQFLcAu+t4419Zl8SKhNMsWLv7V8Lukr3
         fPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773733030; x=1774337830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E0B6xp0wJyvQ6PdHIwJ2lqaw6PipcVBjD7iOAyWuQQI=;
        b=FKmF596PPQnbCEvzeTuo+J3Lz7rEjytigytXHyNk7SDSI0KQxLvwyMiWAaJob+inNK
         MVDMY4oX9TA+G9Xj8BHNCH9EOuOA5+hzUtvTTFfm4EGhZEO3aAn6UTf7Zklysegz6I89
         bdywsvW5n3rlIBpgXkKWI7E5UUfK8mh96/pqWl8mf7KIrvOtmVaoU7khXu7LOP5VV8ig
         4bfh9x5joqIpdOkgBobUPmAKMjYiim0oQ74HnfUZbIsTDj45cDtyGuZZ73zv4NQLH6Gs
         OJK494EPrVyjZKr79ygQ4Rzx/arhMgKdSAPQdxk0x5F7Oy3FkuaefKlhxlKqwbSOFA4d
         NCfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9Ft/aupv4QhlgYoADOt3KF7awQOisAHrp/rbbG03qmDV2x5uXc3riEE3mGH1oOpm0eaBKZJtDvo8LnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvL9kpqJPqozkxsYivmoU7K+hl425FNj3LsZsBgozlnTUlWFcz
	YSTAmuOVNS43D8hjT5y8LHoGIz3HtMMrd5e85OCFwmHPUwUgL622jdf0AIUrj+Ovc48SC3hei+J
	oMb9xtRVB7PQGn2Q5+bggi2vMBntTg2s=
X-Gm-Gg: ATEYQzzDwKb4JDzmyiMBY08l0jSUT7Q90+XK+gPhEwfsTMPI1LEjzFPbo1HWH6edzGs
	mFUDQFvVsw8yREXEh9uWYgG606IayohrdaGB3x2NP9aUD6JnL1Pk7Jd1PXr2nbaZmpB7T5RvN/W
	GMfTnpR2EjmXGJPgFiGCqmtQMPlwPdi5EeQf8Mu0XWeoINMsw+fS8+e/X+VZEgZBAwPPfL1VBTw
	uWqH5KxJnMCyLazZXGAaaDKIJLG8yicnv/VZQs5aUd9/hyeC8mg+B8PepINFwsp3dhC/AsOLq4W
	9fmqMhyjiLWzh8P8s/3i+LPFo4prs9IJq5V8Ke6yo154bCpem0aJZXTFNNkInaULj4rNFGDz4Of
	AjXXdecrIcpsQ4VUr+l/0VbM=
X-Received: by 2002:a05:7301:fa8b:b0:2be:1946:858b with SMTP id
 5a478bee46e88-2bea5537069mr3995398eec.3.1773733030216; Tue, 17 Mar 2026
 00:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878qcpbux5.fsf@kernel.org> <87ikb2mrib.fsf@t14s.mail-host-address-is-not-set>
 <abiXkTSpZ8CWbJVx@kbusch-mbp> <7a4dfa82-41af-401f-aa92-5bd19fe6f654@suse.de>
In-Reply-To: <7a4dfa82-41af-401f-aa92-5bd19fe6f654@suse.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 17 Mar 2026 08:36:57 +0100
X-Gm-Features: AaiRm53AuTsuPzxhbX3fcIx0pIKfHjonAsAVpgz9qlBMfy9W6L4Yw7Mbrtmdy1c
Message-ID: <CANiq72mMtRqXxeCsa1ys8YbxnH5-fm6SsdbD7TPFOsttdytadQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC][RESEND] Status of Rust in the block subsystem
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	Bart Van Assche <bvanassche@acm.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Hans Holmberg <Hans.Holmberg@wdc.com>, Jan Kara <jack@suse.cz>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, John Pittman <jpittman@redhat.com>, 
	John Stultz <jstultz@google.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Ming Lei <ming.lei@redhat.com>, 
	Niklas Cassel <cassel@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>, 
	Oliver Mangold <oliver.mangold@pm.me>, Pankaj Raghav <kernel@pankajraghav.com>, 
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, Theodore Tso <tytso@mit.edu>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, gost.dev@samsung.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 8:18=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> While I do see the original appeal to have a rust-nvme driver, having
> one will just lead to confusion on all sides, especially for distros.
> (Why is it there? should it be preferred to the original one? Do we
> have to support both of them? Are there features missing in either
> of these drivers?)
> In general we are trying hard to avoid duplication in the linux kernel,
> especially on the driver side. We constantly have to fight^Wargue
> with driver vendors why duplicating existing drivers to support new
> hardware is a bad idea, so we really should not start now just because
> the driver is written in another language.
> (That really might be giving vendors bad ideas :-)

I think when Andreas refers to "reference driver" he may be referring
to the https://rust-for-linux.com/rust-reference-drivers framework. If
so, those are meant to be exceptional, temporary and well-justified.

So vendors cannot use it as an excuse to try to duplicate stuff (they
may try, but it should be clear it is not the same case).

And, for users, we should make it so that it is pretty clear they are
not intended to be used. Perhaps they could be gated behind EXPERT or
BROKEN or staging or similar. Perhaps even a new Kconfig option to
mark the ones we have (proposed in the list and in-tree) and that
allows to easily grep and to tweak the conditions under they can be
enabled etc.

Now, with that said, like Keith mentions, it should nevertheless be
clear what the final user of the abstractions are, i.e. the goal is to
bootstrap other code which will not be dead.

I hope that helps...

Cheers,
Miguel
