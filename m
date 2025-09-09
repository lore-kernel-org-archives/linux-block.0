Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C289341652
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428563; cv=none; b=mTd4/DMCZK0HkWIZgEU7RfxW6ybOlaXglvVrC8XWzDMFFnAtKZG/v3UluspK4p6Nwzqck+apv5tq3UV0prkBJsfKM0IZ+02CachmrbqX02Isx64h0zJCUwV9i8q/fjTGcbAVqn26aUTyqoZ2rBQgwDsaMajqG5SnLYwRIm70gwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428563; c=relaxed/simple;
	bh=w6dVntwi3vOqnbpF7RfQzGrHtsQ2AQbXOFzdBAw2bew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1d3yjGf08vlNVV2nIpbAWhaJQdufEg5GJbMIhEZtCBS+Q4hRAU/xF6knC08ruvZIdUNJp3QStdas3/5oV5PG7Lw4vl5zkCzG7dO7wzlLhgAAWQqwMmikrJNf7kUre54fGoJoMjdqUQwpIIJZF2ucVJn0eCcn6hHKPLsXkdNHXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bUkq/IVH; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUkq/IVH"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-811ab6189cfso374130285a.2
        for <linux-block@vger.kernel.org>; Tue, 09 Sep 2025 07:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757428560; x=1758033360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HraNQc0UftoQGnAHFz41MD+6PWIU9oXjn/T/bod79Lc=;
        b=bUkq/IVHdirLJJAD9GoCtsBQyHtXMDJSzGjai0DW8i80nPAaB3j8OIR48i6vemFDxv
         OOj2ueEQcvuMguL70hflLOCbtEyOR8u4+lHkE/fr5XW+yuaWsDY92n19ZWMNfsUB8jNe
         9VR4Eykow9FDTm3kQ5WrW4ZtMY06Bx8YqMLZuK2byT2C2vFrkpDDc/tUj9b28hNI9Qxj
         K5AufdyL1VzVUIt2IS1596wOL8R6DoAOnSRxZ5jxAnMvpVaXQGAKchuKXRS86FCl8U1O
         lNXBux12xGOMOxjoQQYb1TgrOjvQfSvabL/mswz9Ae+zsC6iGjTTxSKA2ihEMmhyeVm6
         e8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757428560; x=1758033360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HraNQc0UftoQGnAHFz41MD+6PWIU9oXjn/T/bod79Lc=;
        b=Pu1Nd/IV9EY5Yrk5spH50ZDI2mb9LO4oPu9KXpnaKtcD15xwUX5yv385cGWCh3q0dE
         2XoL1mWjv9p0EchGs61w1Bpj7BDvep7d4Kl6Qz2HhHsZGKoa61k+6fL7Nzx7LPgVOCHo
         u1awuzueyfHBb53GRL6fKtxYSwphrp1XVlWjJg93wAQD1CHYrdzZjTFSTlFn4KRGc95W
         45O81DYDkZ4nGjQSqzyQwPYHCobm6wxKq4eKO63k+TyVIF6U4XtZ40Yl0+x08cGe9Za2
         sRY8dse2dl1+sv6x+oXX/GF9JG7ttSV46S4yHzNbGP8kpvCZ2mplodZJJOjG3p1KNhQM
         fc1g==
X-Forwarded-Encrypted: i=1; AJvYcCWgsTII14zxRkpmwlCo9pviMR8L6N2Wvg5qFn7IiIt7pcNb/4cffn+DLHIScpraMXTL4+k4+nRybcUZDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPWhsD39I1ywtKmPpKn3xTgk+j3BkmrfB3hkugHnSmK4VHak0E
	AyNN/IGHbD6GIvWfOzybu4/L2HLTC8veh1AdpeW283j8p4oT60XrlEqS/WetxKOVeTSO/t7zEVk
	WKqn8GWrES4zlDpxOnficIWZEzwGUx3jfikZQhKpL
X-Gm-Gg: ASbGncuEROnZfHKiTCrXlB2/R4l5UdZcvdvyalwS4V6ktRykRsD4Qwl90MtudB+oJ2K
	AVLdjB7ogGqLkDvh/mBazkQDWUdF3h0rvNFTiYjiKqWq06h1J0N1/0Y9H6s22DyQRBxgYJt/Okw
	dbsSWQKmyksaj6bP+7FiRkwTNMMnGfaOHMpRa8WYPN03H77rLHwOgXqfnkexvqrdmnKmeOzxr+e
	LVJ+hOEVEXxTbAEz8nlW3nYE7ZCvpB2zDlWfXF6aTtnN4ZA5vK5jIaAHKM=
X-Google-Smtp-Source: AGHT+IEcQgssG3xpRvjhJBiKRjyFcvptOCwG39IVu/CLtP2NQ1mCQBIQWJNjR4pgnF/UmTo5naxxM4HNF2TQoVznEMI=
X-Received: by 2002:a05:620a:1724:b0:80a:865b:41c6 with SMTP id
 af79cd13be357-813c2f05abbmr1254106885a.71.1757428559921; Tue, 09 Sep 2025
 07:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909132243.1327024-1-edumazet@google.com> <20250909132936.GA1460@redhat.com>
 <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
In-Reply-To: <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Sep 2025 07:35:48 -0700
X-Gm-Features: Ac12FXzzB88yrAkRmM86ZkLSUzK_othsjEAnd_7hIylswOuaxXv3xozERw8g82A
Message-ID: <CANn89iKdKMZLT+ArMbFAc8=X+Pp2XaVH7H88zSjAZw=_MvbWLQ@mail.gmail.com>
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, 
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com, 
	Mike Christie <mchristi@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>, 
	linux-block@vger.kernel.org, nbd@other.debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 7:04=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Sep 9, 2025 at 6:32=E2=80=AFAM Richard W.M. Jones <rjones@redhat.=
com> wrote:
> >
> > On Tue, Sep 09, 2025 at 01:22:43PM +0000, Eric Dumazet wrote:
> > > Recently, syzbot started to abuse NBD with all kinds of sockets.
> > >
> > > Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
> > > made sure the socket supported a shutdown() method.
> > >
> > > Explicitely accept TCP and UNIX stream sockets.
> >
> > I'm not clear what the actual problem is, but I will say that libnbd &
> > nbdkit (which are another NBD client & server, interoperable with the
> > kernel) we support and use NBD over vsock[1].  And we could support
> > NBD over pretty much any stream socket (Infiniband?) [2].
> >
> > [1] https://libguestfs.org/nbd_aio_connect_vsock.3.html
> >     https://libguestfs.org/nbdkit-service.1.html#AF_VSOCK
> > [2] https://libguestfs.org/nbd_connect_socket.3.html
> >
> > TCP and Unix domain sockets are by far the most widely used, but I
> > don't think it's fair to exclude other socket types.
>
> If we have known and supported socket types, please send a patch to add t=
hem.
>
> I asked the question last week and got nothing about vsock or other types=
.
>
> https://lore.kernel.org/netdev/CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzB=
cQs_kZoBA@mail.gmail.com/
>
> For sure, we do not want datagram sockets, RAW, netlink, and many others.

BTW vsock will probably fire lockdep warnings, I see GFP_KERNEL being used
in net/vmw_vsock/virtio_transport.c

So you will have to fix this.
