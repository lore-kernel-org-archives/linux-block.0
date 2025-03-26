Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2065D1F790B
	for <linux-block@vger.kernel.org>; Wed, 26 Mar 2025 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007724; cv=none; b=IfzLC8FWqoINf5BCn3WOacaflAkrXhsBtqxwx4+fbs+tkbk1Jcj9REwN4hxv58dlO6ocCvOoS2Oc05RSvQjnAZfWLHuy/eKSDGk+zSK2e9Q74Ty6OeGpwL+f4L4nxeP8fmY0eT3Pp32Y29LMiwA8xr8SflAka48MlzMLKNPoW30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007724; c=relaxed/simple;
	bh=p/OaKL9Kn6kApSO4ooQ3KGS4GrLDdhLMGRXjeveabig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A77ZIlddWuOhraywcnTkrnaTOQQmF8iAduKy4fBZVH9clOTxX6SVUmBKxA5ToPj2VAIVNJPEhYW4XfAEvjA5Eph4dTyiAFHb3OHco6BLkosYlga68GcylYwOlkJqkvG61ZOWNwC517beFX2yfozYrg3byT6J3rfEjpNrZzgCn6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WD0czLY+; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WD0czLY+"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-301001bc6a8so1932391a91.1
        for <linux-block@vger.kernel.org>; Wed, 26 Mar 2025 09:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743007722; x=1743612522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Kb0867v9KiYCkSpsgeiAuGhvBV0zRRsrYk5Gph4h5Y=;
        b=WD0czLY+hLU1MwfypSMpWh6gd0FubgonyqHjUnhA/ImWmPDDds6FrS/qZC0gbQUBuh
         Dmr4Rla+l8MNuETw/N8dHc7A4aQyNI15OgcVg1Zme6KJaGW1sNrJ3l/Bn2SJl3I75FX1
         HFk3BGooycg/oDbslWohrsvSUUZNyngTIXoG2wDZBqSoUZOocFJPscWe5842BSzBxVpf
         lDqioL30H7QSnuXDif7XJKZ8/O8hm/798CqnGGH2UYMrdDuJW8Q6nWIhIC9V07kEuYOC
         xU4JZQwBaf2edME5OdXWDs2B5NSxD2zLofF9GPwFIV0qFrFvMYePL9M2Vw4BS4ArtIQC
         7fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743007722; x=1743612522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Kb0867v9KiYCkSpsgeiAuGhvBV0zRRsrYk5Gph4h5Y=;
        b=NS7NoXlCfWyzPtxsTYVz1BeDC2jNMyCS5p7MAIlfCk7P3/93+SgUw9i+pQ8YTtlg5C
         xOqvFONPWHzgl4XRBl46bZtoCmH51M+KwxTTTPHtbp7/kABgSet/16eklh5XaGuYM4ew
         wZQmFocTayYUX9rSXQO8WUe3tdn7ZYQ6MoT53ZSMAp8htxYeydK0IQ+zgs8JM3GCbspx
         cMChQv4H6bARoFDHH0K/6jg66YREdmod869/JOc6INd3yOrWYq0HTaKEyQCWx96WmknD
         eazprTeYrFlYSsYHbr48pG3+Zt2UfOby1jO9jL4ArPtUFIAeyZQW3ewwJ5//lgXbFunU
         Pa4A==
X-Forwarded-Encrypted: i=1; AJvYcCWwfToxXNbBcuiy4I4LjrFw2uV1ZBTpkbc9lzfcYNYQLkqiAM/2sevjjUMkU+hTzScdJZNjjeNSfg+PBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcnv8QlVQYdR4WyHmhz8t0sNuDZ5kMp0328tefPH2vK879QZns
	Nfz5syhoVAuJWYSP0MyvNHWCEa2YK/xtpvL5j6vKDPn9HgSUMJcxiehuqX2X9kteXW0K9yBv+Tv
	6Ws42v6zrJ0viCQcXgv4MPWl/EOZgDkDvSPkaimyHXTKhnXFVi64=
X-Gm-Gg: ASbGncs0HpQN98va6u/zBjdYOpm098YV0MVlkhIsaFlSKQ1eVmtfYYTb4YE+AjENS+c
	6IqpHShFTKeJtkF8Zkp3eyu/PZhuT2iNZO6ff1Ul200mRQF9FVgRcJQmo0zoCMeiWlbs95N0Z6K
	6pPmcP3hMWyd1xhlEiDEKfvAW0bekfUi9hQGY=
X-Google-Smtp-Source: AGHT+IHq+TAMKZd7fKu2lRSrTKNUk579TC1yqon/FvwGw3dhZAmZEmjfUHPBBEnizt4MlNoT4GU4L1pigvoDXkPdCvE=
X-Received: by 2002:a17:90b:1c87:b0:2ff:5540:bb48 with SMTP id
 98e67ed59e1d1-303a91b5a6dmr177736a91.8.1743007721970; Wed, 26 Mar 2025
 09:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324134905.766777-1-ming.lei@redhat.com> <20250324134905.766777-6-ming.lei@redhat.com>
 <CADUfDZquEOA7ckJVkBbcso2Paw9viSa9-5eQptgRgQRoxgvVqA@mail.gmail.com> <Z-NmobqY9C4o8ESL@fedora>
In-Reply-To: <Z-NmobqY9C4o8ESL@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 26 Mar 2025 09:48:30 -0700
X-Gm-Features: AQ5f1JoGPZkfcL7HHhDZkEDg41fJYNn0RvkoQMedEKPCFlPxtVKx2k3wDH831mo
Message-ID: <CADUfDZrkDsyqdeuAgzoDFeANwFqw=djuSObAm3kPwimG0SHx9Q@mail.gmail.com>
Subject: Re: [PATCH 5/8] ublk: document zero copy feature
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>, Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 7:30=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Tue, Mar 25, 2025 at 08:26:18AM -0700, Caleb Sander Mateos wrote:
> > On Mon, Mar 24, 2025 at 6:49=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Add words to explain how zero copy feature works, and why it has to b=
e
> > > trusted for handling IO read command.
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  Documentation/block/ublk.rst | 28 ++++++++++++++++++++--------
> > >  1 file changed, 20 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.=
rst
> > > index 1e0e7358e14a..33efff25b54d 100644
> > > --- a/Documentation/block/ublk.rst
> > > +++ b/Documentation/block/ublk.rst
> > > @@ -309,18 +309,30 @@ with specified IO tag in the command data:
> > >    ``UBLK_IO_COMMIT_AND_FETCH_REQ`` to the server, ublkdrv needs to c=
opy
> > >    the server buffer (pages) read to the IO request pages.
> > >
> > > -Future development
> > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > -
> > >  Zero copy
> > >  ---------
> > >
> > > -Zero copy is a generic requirement for nbd, fuse or similar drivers.=
 A
> > > -problem [#xiaoguang]_ Xiaoguang mentioned is that pages mapped to us=
erspace
> > > -can't be remapped any more in kernel with existing mm interfaces. Th=
is can
> > > -occurs when destining direct IO to ``/dev/ublkb*``. Also, he reporte=
d that
> > > -big requests (IO size >=3D 256 KB) may benefit a lot from zero copy.
> > > +ublk zero copy relies on io_uring's fixed kernel buffer, which provi=
des
> > > +two APIs: `io_buffer_register_bvec()` and `io_buffer_unregister_bvec=
`.
> >
> > nit: missing parentheses after io_buffer_unregister_bvec
>
> OK
>
> >
> > > +
> > > +ublk adds IO command of `UBLK_IO_REGISTER_IO_BUF` to call
> > > +`io_buffer_register_bvec()` for ublk server to register client reque=
st
> > > +buffer into io_uring buffer table, then ublk server can submit io_ur=
ing
> > > +IOs with the registered buffer index. IO command of `UBLK_IO_UNREGIS=
TER_IO_BUF`
> > > +calls `io_buffer_unregister_bvec` to unregister the buffer.
> >
> > Parentheses missing here too.
> > It might be worth adding a note that the registered buffer and any I/O
> > that uses it will hold a reference on the ublk request. For a ublk
> > server implementer, I think it's useful to know that the buffer needs
> > to be unregistered in order to complete the ublk request, and that the
> > zero-copy I/O won't corrupt any data even if it completes after the
> > buffer is unregistered.
>
> Good point, how about the following words?
>
> ```
> The ublk client IO request buffer is guaranteed to be live between callin=
g
> `io_buffer_register_bvec()` and `io_buffer_unregister_bvec()`.
>
> And any io_uring operation which supports this kind of kernel buffer will
> grab one reference of the buffer until the operation is completed.
> ```

That's definitely better. I think it could be a bit more explicit that
the buffer needs to be unregistered in order for the ublk request to
complete.

>
> >
> > > +
> > > +ublk server implementing zero copy has to be CAP_SYS_ADMIN and be tr=
usted,
> > > +because it is ublk server's responsibility to make sure IO buffer fi=
lled
> > > +with data, and ublk server has to handle short read correctly by ret=
urning
> > > +correct bytes filled to io buffer. Otherwise, uninitialized kernel b=
uffer
> > > +will be exposed to client application.
> >
> > This isn't specific to zero-copy, right? ublk devices configured with
> > UBLK_F_USER_COPY also need to initialize the full request buffer. I
>
> Right, but it is important for zero copy.

Sure. Maybe change "zero copy" to "zero copy or user copy"?

>
> > would also drop the "handle short read" part; ublk servers don't
> > necessarily issue read operations in the backend, so "short read" may
> > not be applicable.
>
> Here 'read' in 'short read' means ublk front READ command, not actual rea=
d
> done in ublk server. Maybe we can make it more accurate:
>
> ```
> ..., and ublk server has to return correct result to ublk driver when han=
dling
> READ command, and the result has to match with how many bytes filled to t=
he IO
> buffer. Otherwise, uninitialized kernel IO buffer will be exposed to clie=
nt
> application.
> ```

Thanks for clarifying. That looks great!

Best,
Caleb
