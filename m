Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA6346A0D
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432021; cv=none; b=ZxrpzAAkTRpxf7HSvpGNdfwANUUhH370yHDDEY1qsiF+F1ppMl6m7R2NopLeyvE2ItOi+qhJPkfo6r2YP9rH6ANcDnZrZ2nmMZDJJO+LK795UHqm5KvRbqMd6vv+5PgfPX027yQh8w3EolHtKRpekXCY7F7PkKkpYSNJ5VOIQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432021; c=relaxed/simple;
	bh=eXqcsEVT0O/GOfA/Ca74pae233qQpT8kMZ1DFItem6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LW4M439EruPUAOZWmIagyPIJpyr33saeuoq9TO5keLA4sHrhuK9P815k7B1b3ozqJ34O33hVVakRlfspxTf9ygZhXhG5K9kdM3n0sbZfR73XLmLTGSRRKyW3ZzQCcmY50fS/cdTAMmVlBAiV/6nYkEzcooDUvETuOnVREF6gR5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z+nXkTF9; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z+nXkTF9"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b5f3672cf4so27355751cf.2
        for <linux-block@vger.kernel.org>; Tue, 09 Sep 2025 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757432019; x=1758036819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LH53MCx6ogN1k+/cTYDbkLwp7+QCPYAr+PyETboPxPU=;
        b=Z+nXkTF9JfnULQd3XbzxXlfRdTzzgDr49lrdpLuq3FXi+I/MaDoS4jQRaHR6rOOQhF
         B/3pLnFn9bjNO1++zCzgpyqUfunnQ07fMWf37xR7NueFFIvkF8T6AyvbM8opEwlS5JYW
         kftTpR7HzlG04ODQ9DSDefG6P1JtarUJ7noZfTTsRAT+2cyAFzKhTqtrWkC246XJVNDK
         2lbhqkoG7F7JofQnoDh4ZAXllkj5suioJJJgj4lQ+kCnZy78NO7ZhbLTAYWxzNXIljS0
         CJDlBsbb5hEYXEBsBz2pMD3UgpBP++xQ+cDVAKmfcuauQ9+AYTYweAyb1aCkekZ3oPTJ
         corg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757432019; x=1758036819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LH53MCx6ogN1k+/cTYDbkLwp7+QCPYAr+PyETboPxPU=;
        b=MTGYhz8b8IxxOuea8idQdpuzNCBoEi31ucQAqLE773IjkPbFnW9vsuIrtd3WqX94H9
         r69ryTYuZDvyg7yxCJcjRRrVgnNHjKS72szqivA+oiZbZ7+RgYikubHewmmgNhsiau5e
         Ib9BqGihm2tX7eaef7PT44tGBOW4DnNX51D/KYQeWpliXwGpiV+uSXJBeb0lI/fU7boP
         BDpKX3+B9PVZHlaKcizrvVaXBYGZzEnLHwq9CKqy60zA4XJuwJDsv0cYE9is4kbCM7Yb
         B8NNqkpRpFLsNyOKYufaYQRMMyMmt7qeayFyDTGTYMCZbUN+cR3+9ZwguI9U8Rrwex5o
         Qf0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmm3if1oYvnlQOotZwLxoOcXb0kxGzlDNaM86QaaYaad/QnBjxa9T2w2iX7GEI3Z6QsbXf+4ccupwOMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ4fB963TUrN4r+QuYaNvdoXD5cmvWh4h8RXNRJiQ8tekRbSIp
	4i/J7/TvQiZv50Ri0hgePA292GGBAGZPhS9lAsB4ylai6n/rRw5Ad0VOE+zVBpgvEqSPcBYnw4R
	ghH15nYOBFgTG7uJ/H5GuCxocxL60NeYHLYetJHn3
X-Gm-Gg: ASbGncuz7OAvPnjSMlNPOzkZdiVOpdbp66gU51o02biNBRliYC+dVBj6luFOCFhf34m
	wfqlwP17M16A7evFl6P2Ste/SFC3O+RKUBZcu8glmPOp63LIhltY3uCftkuk2Bfcf99UO4sD1IY
	yhUzlowZxS3pDbzoC56PRUMTpHT9ImnhO0BCth6h9xUIBr9oAObk/3Q98+DZr5t3cyqbe+SE+Pm
	Ukn4t4bG/kHEpSJGek4ZjT2kJw9ViC1vUsspYC5JYnY9dFLABjloqCqY8E=
X-Google-Smtp-Source: AGHT+IEBSJFGC5HE816C89rHJ7brsZIZ78JEBVc19MhZewWuyBdDU+KpX7j08rvkOLFoUtfGNDkZcsKLsSZemorc0Ok=
X-Received: by 2002:a05:622a:1887:b0:4b5:ea94:d715 with SMTP id
 d75a77b69052e-4b5f8390522mr114936061cf.1.1757432018215; Tue, 09 Sep 2025
 08:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909132243.1327024-1-edumazet@google.com> <20250909132936.GA1460@redhat.com>
 <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
 <CANn89iKdKMZLT+ArMbFAc8=X+Pp2XaVH7H88zSjAZw=_MvbWLQ@mail.gmail.com>
 <63c99735-80ba-421f-8ad4-0c0ec8ebc3ea@kernel.dk> <CANn89iJiBuJ=sHbfKjR-bJe6p12UrJ_DkOgysmAQuwCbNEy8BA@mail.gmail.com>
 <20250909151851.GB1460@redhat.com>
In-Reply-To: <20250909151851.GB1460@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Sep 2025 08:33:27 -0700
X-Gm-Features: Ac12FXwmsBi8N5rZnVovo52dil5DJvY7h1QqJGILCkzQ81ibk4sKlJtshywQWDc
Message-ID: <CANn89i+-mODVnC=TjwoxVa-qBc4ucibbGoqfM9W7Uf9bryj9qQ@mail.gmail.com>
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, 
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com, 
	Mike Christie <mchristi@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>, 
	linux-block@vger.kernel.org, nbd@other.debian.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 8:19=E2=80=AFAM Richard W.M. Jones <rjones@redhat.co=
m> wrote:
>
> On Tue, Sep 09, 2025 at 07:47:09AM -0700, Eric Dumazet wrote:
> > On Tue, Sep 9, 2025 at 7:37=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wro=
te:
> > >
> > > On 9/9/25 8:35 AM, Eric Dumazet wrote:
> > > > On Tue, Sep 9, 2025 at 7:04=E2=80=AFAM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > >>
> > > >> On Tue, Sep 9, 2025 at 6:32=E2=80=AFAM Richard W.M. Jones <rjones@=
redhat.com> wrote:
> > > >>>
> > > >>> On Tue, Sep 09, 2025 at 01:22:43PM +0000, Eric Dumazet wrote:
> > > >>>> Recently, syzbot started to abuse NBD with all kinds of sockets.
> > > >>>>
> > > >>>> Commit cf1b2326b734 ("nbd: verify socket is supported during set=
up")
> > > >>>> made sure the socket supported a shutdown() method.
> > > >>>>
> > > >>>> Explicitely accept TCP and UNIX stream sockets.
> > > >>>
> > > >>> I'm not clear what the actual problem is, but I will say that lib=
nbd &
> > > >>> nbdkit (which are another NBD client & server, interoperable with=
 the
> > > >>> kernel) we support and use NBD over vsock[1].  And we could suppo=
rt
> > > >>> NBD over pretty much any stream socket (Infiniband?) [2].
> > > >>>
> > > >>> [1] https://libguestfs.org/nbd_aio_connect_vsock.3.html
> > > >>>     https://libguestfs.org/nbdkit-service.1.html#AF_VSOCK
> > > >>> [2] https://libguestfs.org/nbd_connect_socket.3.html
> > > >>>
> > > >>> TCP and Unix domain sockets are by far the most widely used, but =
I
> > > >>> don't think it's fair to exclude other socket types.
> > > >>
> > > >> If we have known and supported socket types, please send a patch t=
o add them.
> > > >>
> > > >> I asked the question last week and got nothing about vsock or othe=
r types.
> > > >>
> > > >> https://lore.kernel.org/netdev/CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A=
12+ndzBcQs_kZoBA@mail.gmail.com/
> > > >>
> > > >> For sure, we do not want datagram sockets, RAW, netlink, and many =
others.
> > > >
> > > > BTW vsock will probably fire lockdep warnings, I see GFP_KERNEL
> > > > being used in net/vmw_vsock/virtio_transport.c
>
> CC-ing Stefan & Stefano.  Myself, I'm only using libnbd
> (ie. userspace) over vsock, not the kernel client.
>
> > > > So you will have to fix this.
> > >
> > > Rather than play whack-a-mole with this, would it make sense to mark =
as
> > > socket as "writeback/reclaim" safe and base the nbd decision on that =
rather
> > > than attempt to maintain some allow/deny list of sockets?
> >
> > Even if a socket type was writeback/reclaim safe, probably NBD would no=
t support
> > arbitrary socket type, like netlink, af_packet, or af_netrom.
> >
> > An allow list seems safer to me, with commits with a clear owner.
> >
> > If future syzbot reports are triggered, the bisection will point to
> > these commits.
>
> From the outside it seems really odd to hard code a list of "good"
> socket types into each kernel client that can open a socket.  Normally
> if you wanted to restrict socket types wouldn't you do that through
> something more flexible like nftables?

nftables is user policy.

We need a kernel that will not crash, even if nftables is not
compiled/loaded/used .


>
> Rich.
>
> --
> Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> virt-p2v converts physical machines to virtual machines.  Boot with a
> live CD or over the network (PXE) and turn machines into KVM guests.
> http://libguestfs.org/virt-v2v
>
