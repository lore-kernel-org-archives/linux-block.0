Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ABF1DDE9
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429246; cv=none; b=J5coJRrpzrTmVDbfTSdBSYynMtdLeyeXL3y+juDL1BT50Fbxz5yJlAZIIk97fiuMBf1yFD2ql7OjMvDO/HWskyZVRq248wfs7XyMzEwXK0bK9wxq4pIRxtgASfmGbjYV/7qSu2UzPuvahvfuxrwSZ3CVaIZhwcX+6fJCtqiYF4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429246; c=relaxed/simple;
	bh=na0qcNvQJYZarjhYVsaDNm+DNueOfC1mq9L1wdwqIWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iND67NiDnpOdLuM+v1hnGObm72XT6fkHcDfx501zqVcAgt8kKEk//9sp+EnS6geIu1wV5M2RnqZsKRPwv2q5nuB3WLI1fRXzxOIUHikc/X+tZVE2lRJC0E4+zLH3whz2l5CPwDYpguI695IXBZdMNFqwc7wTnSQGaL/BJl2P6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K77XlKGr; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K77XlKGr"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b60481d4baso30461721cf.2
        for <linux-block@vger.kernel.org>; Tue, 09 Sep 2025 07:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757429243; x=1758034043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIPTmtHCDrJgBeBgHlzsCibUN0YnxA4RCxNX1u5+HrA=;
        b=K77XlKGrJ9+ZRVxgSYlht55aLZoGcK0RmfEgbd5sF7KEg4DbwaUq8QmD3uBFel6gkQ
         AYwM8czCzwGvtM5+ZBY8JSOBDHX1Lo6n8NN6/2wXj4JdkFaNZPE24sSP9+XxBltFPwDv
         SSUbItY/QfF8CxcG27azsk6kOJyYj/e64KeBX+fh37BB6GMRlbAlVqc/o/84Erryngs6
         p+gQpRzvfpwQnemp+Xv8Gg4CFwtF9221peX/yALyP5RkVX3cBjcSLb7AmHju6PpnVnkc
         FA76j8wz7l884NOmDjEjK97jlPRnbDcEvtNso0XOzKBtU/covLzibeMCqu9j5jeiMRzB
         SykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757429243; x=1758034043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIPTmtHCDrJgBeBgHlzsCibUN0YnxA4RCxNX1u5+HrA=;
        b=CVSWDcZBEuhMX9a0PMRfJXpSO7LyD8LYbER8THrSYxxdm8WDAdvZRL4yYbk4GHW09E
         t/Qr8WVfboESNHQM8orRPss2MIv0pzhDOjrClGzBBWU7UfamCp2lcDp74oQ8H3bX65uh
         80nTJzjrgQ7dDCeYzthRd+CtwzGQ89OshMn/8S0SQFG7qZNZb3P715Fiy6E0BgoHaEv/
         jZ6SVCkwvNwI9OkWaLXoWWWgjamuZRLHQvjtuu9vzGoATi2HmIGLCOHbxoTiWkiKSFkQ
         xXFeAH7rKpiX4ukfNRp7JSJtXyXw69Pa3XhAr3L+YGGS/qjL1jneasXOI+b21IGSZYM2
         Ux3w==
X-Forwarded-Encrypted: i=1; AJvYcCUCzxFSZXpUbso5WQLoix5hwqaF25JjD4qLqTULyDapGeqm/7xwD6g3R70tRAPcf+U2ZJ64CsFDWyER+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1S8XCLWJMECiXOX4C4VnjTuWmEf6+yT8+PPMXMeoHAH3ZitMP
	SZYj3DReQaMIDeND3op6rLNCNaKPkxdYME34BjGZLNM0kWzvS4Ho5yhUR74rjZBoOwPUVrBB/Vf
	OCdQ2CC53d/X9uCni4K6tYp1aT/2UFe6NaWjlVmEm
X-Gm-Gg: ASbGnct7O4ooiRIqlCHsgXz26BIaHQ3yIY/SjyB//GDo+uEuIcrcKwOBuW4BScPxFeS
	lXFZqOYIgo8SpXFgB4nbWSIKvdIx0OCT7mzzTIvJFpCl7b4a7gxEDSwHn+cV2Fg74xCQcACehl7
	IjoiSTnVditeEIlOhHNv5IsM8bX679quuUsW10TCjjwr5ZiXH3bTg8YKvUXFBQWZEkqR+XUtfjy
	N6JoW6uxRXwK6xPgkomucEnPej8rEOcmLt3v7L7+3OtruUGIlfWzdyLM1Q=
X-Google-Smtp-Source: AGHT+IHNkl4F/jlHneGYF/DVcUMGaWB8Yx5qk0wUjgE1GPGbrefbzEWPV3RJqRwpMoeMSkvolvqz8buuDcIXFrAO/fU=
X-Received: by 2002:a05:622a:28a:b0:4b5:e600:3d4f with SMTP id
 d75a77b69052e-4b5f844d163mr132837011cf.41.1757429242916; Tue, 09 Sep 2025
 07:47:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909132243.1327024-1-edumazet@google.com> <20250909132936.GA1460@redhat.com>
 <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
 <CANn89iKdKMZLT+ArMbFAc8=X+Pp2XaVH7H88zSjAZw=_MvbWLQ@mail.gmail.com> <63c99735-80ba-421f-8ad4-0c0ec8ebc3ea@kernel.dk>
In-Reply-To: <63c99735-80ba-421f-8ad4-0c0ec8ebc3ea@kernel.dk>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Sep 2025 07:47:09 -0700
X-Gm-Features: Ac12FXzNtkWC68OEJylvLMh65_Zd3JlyhYqvJ9DDcC2NpONUi_gkcjAG5cZuFt8
Message-ID: <CANn89iJiBuJ=sHbfKjR-bJe6p12UrJ_DkOgysmAQuwCbNEy8BA@mail.gmail.com>
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
To: Jens Axboe <axboe@kernel.dk>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, 
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com, 
	Mike Christie <mchristi@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>, 
	linux-block@vger.kernel.org, nbd@other.debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 7:37=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/9/25 8:35 AM, Eric Dumazet wrote:
> > On Tue, Sep 9, 2025 at 7:04=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >>
> >> On Tue, Sep 9, 2025 at 6:32=E2=80=AFAM Richard W.M. Jones <rjones@redh=
at.com> wrote:
> >>>
> >>> On Tue, Sep 09, 2025 at 01:22:43PM +0000, Eric Dumazet wrote:
> >>>> Recently, syzbot started to abuse NBD with all kinds of sockets.
> >>>>
> >>>> Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
> >>>> made sure the socket supported a shutdown() method.
> >>>>
> >>>> Explicitely accept TCP and UNIX stream sockets.
> >>>
> >>> I'm not clear what the actual problem is, but I will say that libnbd =
&
> >>> nbdkit (which are another NBD client & server, interoperable with the
> >>> kernel) we support and use NBD over vsock[1].  And we could support
> >>> NBD over pretty much any stream socket (Infiniband?) [2].
> >>>
> >>> [1] https://libguestfs.org/nbd_aio_connect_vsock.3.html
> >>>     https://libguestfs.org/nbdkit-service.1.html#AF_VSOCK
> >>> [2] https://libguestfs.org/nbd_connect_socket.3.html
> >>>
> >>> TCP and Unix domain sockets are by far the most widely used, but I
> >>> don't think it's fair to exclude other socket types.
> >>
> >> If we have known and supported socket types, please send a patch to ad=
d them.
> >>
> >> I asked the question last week and got nothing about vsock or other ty=
pes.
> >>
> >> https://lore.kernel.org/netdev/CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+n=
dzBcQs_kZoBA@mail.gmail.com/
> >>
> >> For sure, we do not want datagram sockets, RAW, netlink, and many othe=
rs.
> >
> > BTW vsock will probably fire lockdep warnings, I see GFP_KERNEL being u=
sed
> > in net/vmw_vsock/virtio_transport.c
> >
> > So you will have to fix this.
>
> Rather than play whack-a-mole with this, would it make sense to mark as
> socket as "writeback/reclaim" safe and base the nbd decision on that rath=
er
> than attempt to maintain some allow/deny list of sockets?

Even if a socket type was writeback/reclaim safe, probably NBD would not su=
pport
arbitrary socket type, like netlink, af_packet, or af_netrom.

An allow list seems safer to me, with commits with a clear owner.

If future syzbot reports are triggered, the bisection will point to
these commits.
