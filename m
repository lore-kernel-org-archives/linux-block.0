Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400E5469D
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433190; cv=none; b=guEsXSdJAe43U8k1GeJwqlIgSzRUez8nQ4K0D04e4kL0Q1+uM5ynfudEYJ0uBNlB3Xb9vFmfPnxFeCZVFXh3v0qezxrLLNMXvkkKTilAq+rxId9oWZXbmIl4Z82OTv59b6h1NP+RF//CWPsop1vyKII7i6xTZKxYcRFyRI0Wu4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433190; c=relaxed/simple;
	bh=9FTBOSdhT8Fk49aybKjxWWzf6EmwXh52+BABmAiLiFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNnd6Z5DwrWSZjNopmMJ/EOAQ0KxG+MGoCJk3qJJmCLktpZVf/pKG0qa9+rQlv0YFdajljpJsbtx0a2LSe5Cbp5ms+ef7jBlzNJeT+Bqgrii6upqTuISKiSNzlxz/s2H1g2Wb2bm6MQCrH/5mvFTi9kbGj2JZY+GnDOqPr2/fXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Wt8iXrEu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Wt8iXrEu"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220c895af63so12639275ad.0
        for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 13:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740433187; x=1741037987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbT5GxY7U8d29szFcIEb937yeprNIBlLXP0MxBpt1uw=;
        b=Wt8iXrEuMVsAb+Im1xMoSggQl9BdKe5nHqgzSldeJ8HNPNGZVroA1CkFvWAo/uQ2DN
         8jaBoJY1PTNRPr8GMBrGm63SqKDguqNggbRiX/IdwkBnnw/4a+ejxVb0AExxnNi/682P
         WAo31zjd53E5rSc3U2WFrwwQiIveUPPBSuCWcPk8uv99b802wJELniwRsIS/xQF0x+F8
         N1yUaiqfmK8eM0xca4uziVunqBxLONnxkRFV6JJ47Y2BEuCGskAy9pv9sK9Z1xLvv2IH
         XXUIqmA08E1rG3mVcZatDhfBcwH/fFoG2A74vsNp6Fxxc3oGDqWLyRno66aqTGJjoW+T
         5CZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433187; x=1741037987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbT5GxY7U8d29szFcIEb937yeprNIBlLXP0MxBpt1uw=;
        b=T21GyNewwrjmdvnUajdEHq0PgX5C/pEvctRfJ0YU2+B76q9k9b1N9ZQaUYg5crNu5D
         p6zdIUnDUP7cmXk2MJM0xI1JUoxhJKGiWDrGaQ7qQsIXvztLKKBOQhFT8zQoiDGzT+w4
         U0E1+CwTN39jZbAWODiuH1ch926EVe4J7kQ+OVdu3YduQLTHDdGkeTf/He2pqvG+1tm0
         5BmizsHQ8A9vFv3Fnlmlo+sg5McCQ/UXfCVsHHvHlWmiHYbVRsyomvf7wCqnxEUjazhB
         bVkEOo331SgwEfgWwr5esrqZDpINXk4AHEjtzuXYlWRT+7wCSWEROeBcL+lE9fA8Pv2I
         Qeuw==
X-Forwarded-Encrypted: i=1; AJvYcCVD4sLQauS8LphsuW229+s6MsKTpQNbheAXXBikZx/o6+OU9p2nqicuNLkVyc5V0h/L6+qoU6kpSqiNgg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy75FyiToKII4z9Dwws12q+0O3y4ttIInEIsh9ze1XPZn8dtLs8
	L7jwM6f3sMZFWOs0NLAh4cRB5SbnmqeAd3vUtJxR3IA3SqP4y2vZ97vxKtB0PVrysLl1J5g9Hr4
	WaT3oA+KQzWJto9+5RbrZRG7ENm3eE/XiRcjkut2i1kuhZPLp
X-Gm-Gg: ASbGncuvX9gJN5x91YqwMiyEl9Jn8hyc/6WVOtKQOU9WIBaLhhxznWODYuKfsDdRWMs
	jvyAi9VqCM7JIy+/fjkm/xzGlkwpbbUKUbZkLlxt54h42q1z57xD68sp+bO8yknjlEtDw2Kt6XD
	dEZq3yvOA=
X-Google-Smtp-Source: AGHT+IH8rrLIdP/vBzrKzcBOAgB0iZOygLzf1jzMPI39fpDZZ3eZVixpVuQWLyQGQvndxOTo31U7KHyiT902oOEaGTM=
X-Received: by 2002:a17:902:e884:b0:216:3dd1:5460 with SMTP id
 d9443c01a7336-2219ff4e2bdmr91667145ad.2.1740433187429; Mon, 24 Feb 2025
 13:39:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218224229.837848-1-kbusch@meta.com> <20250218224229.837848-6-kbusch@meta.com>
 <CADUfDZq5CDOZyyfjOgW_JE_A_GWLscZkbJDgQ-UKTbFC66FjKA@mail.gmail.com> <Z7zeNLEnZqsniK69@kbusch-mbp>
In-Reply-To: <Z7zeNLEnZqsniK69@kbusch-mbp>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 24 Feb 2025 13:39:35 -0800
X-Gm-Features: AWEUYZlp7pcVXtW5Q-RqbTsTSpF0m36Os2YU2YRa2vl7senSIcqny3nHoyNmlGk
Message-ID: <CADUfDZqF-AV7MfdXHchxgQRLMFuLvbOoWkzZmki4_L5upKcs4A@mail.gmail.com>
Subject: Re: [PATCHv4 5/5] io_uring: cache nodes and mapped buffers
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com, asml.silence@gmail.com, 
	axboe@kernel.dk, linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 1:01=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Tue, Feb 18, 2025 at 08:22:36PM -0800, Caleb Sander Mateos wrote:
> > > +struct io_alloc_cache {
> > > +       void                    **entries;
> > > +       unsigned int            nr_cached;
> > > +       unsigned int            max_cached;
> > > +       size_t                  elem_size;
> >
> > Is growing this field from unsigned to size_t really necessary? It
> > probably doesn't make sense to be caching allocations > 4 GB.
>
> It used to be a size_t when I initially moved the struct to here, but
> it's not anymore, so I'm out of sync. I'll fix it up.
>
> > > @@ -859,10 +924,8 @@ int io_sqe_buffers_register(struct io_ring_ctx *=
ctx, void __user *arg,
> > >                         }
> > >                         node->tag =3D tag;
> > >                 }
> > > -               data.nodes[i] =3D node;
> > > +               table.data.nodes[i] =3D node;
> > >         }
> > > -
> > > -       ctx->buf_table.data =3D data;
> >
> > Still don't see the need to move this assignment. Is there a reason
> > you prefer setting ctx->buf_table before initializing its nodes? I
> > find the existing code easier to follow, where the table is moved to
> > ctx->buf_table after filling it in. It's also consistent with
> > io_clone_buffers().
>
> Yes, it needs to move to earlier. The ctx buf_table needs to be set
> before any allocations from io_rsrc_node_alloc() can happen.

Got it, thank you for explaining.

Best,
Caleb
