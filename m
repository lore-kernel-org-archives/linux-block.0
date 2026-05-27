Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DD43C9891
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779885863; cv=pass; b=m7ufXGtDGHimSp7oBak1wd4SZusolfDSGt84WxAI55auZWgJ0s13L/trPfP8a86atTBhfcri5ets7bpIcLel6dgkSIJZkuSNxQirf/x6YiC1xW0sE/164PbY4jCJX7key+tM/KvLCnXXJs1V9oKCKHXx07B30ZGW2SrQrrBDp/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779885863; c=relaxed/simple;
	bh=rKGbXXnRzWeaQEyHC0cf0kemgdpBvit5j2YSNFR8sD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ebya5Fo8eW4seQPFWK3ZdsO/1mihz+uYmiHjLQcSwZ8Mlyl9cErjXT5yBYkMD93/yrzK9MzhPakLLdYEEL6IRQrkD19X0X1DKv6cAazkX9dP6ppoXXv0kS+cD8A2iB7SrBKcC9t2hOEbBQakAtIHT2rt511yHk01jS0sPIWVC5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Rq96XAjY; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Rq96XAjY"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-393800f638bso86379791fa.1
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 05:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779885859; cv=none;
        d=google.com; s=arc-20240605;
        b=VTO0TfBYIZmiVT7D0Spf0Cq4tahqNx7mfYP3mEjLzBMB6EMge8/5plO6bzMc2AR9po
         QPnGusKxbfCfi8ZLhGYLJNPf7jnukv674TFhYCis/TokNpNzWLtFh6mHdyNG2Ds6nQvb
         1xLctR/UIYXLgzY8nFcIOe//F/YEzd1hor2syVR1fcBEKcxm+4Zkz6xnY0itn9UIwWCD
         qqtTqj0Gpc9nEnf2EfidORj3+jndZIsBR/tJ8OuayOjkTdZOHbkov5SOcUkicigw2Uvp
         Xe1USjjzFlFpJNKnYrFbY/RAINZ/69MAiLrVbm76rn4N18d/0MXspX9RhQ/JYJA2bF54
         cNKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qYq2RP7F78uUAT5YOZEmhrXVmYdKWobwZFZG/FoawmM=;
        fh=yLNc1XidA814+sXQvhZiz4kF9KdVgIGZ2k2PcwTCG54=;
        b=FzPupDH323nlWeC/7vkAz/0uq/Q/NCdfoUwdlP+LJtC1NbnNAZXN+umsmmTHweiv1J
         0po8xMM0V9fS6N18D3j4XWXQOqvLcz7VIE8+lWbdnReb3CFCiV3kATDdRBTXr4C1fsA1
         DH46U8EqJ6eSQgU4HFu9dI26eaDO0LDjTvFYeuecCWwv5TkDPAbcE4UlXJY8JZJDvHGD
         HZaGZkHXo6Ko3xvrkd/eaYKTR+AllPheRB7NdPP3lrBLJlQ1gQ2UiCbnLPJyAOfWJZlx
         A2PYBpDRXqMIz4qlhCXQDRtu/cosD/3B/v+8q2u9wPe5A+WgYg/0QtBL2K1M2gedkseO
         Igmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1779885859; x=1780490659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYq2RP7F78uUAT5YOZEmhrXVmYdKWobwZFZG/FoawmM=;
        b=Rq96XAjYJ0bCmfwqWVKdMxj8UkueOC8qrqieEVn2pQIDXzhAf/6B3fzbc1AEegOkec
         eaPiO3DDX9n/c2rWRwdt9R8ge2/sfBYaIXSmLGHs9ncjEhnAEdniuSbzADTDk/0U7FBG
         z+oKYrzdi7EAdYdKKq3JFw5/vykWSRkFvbhusqi52uertqJXqR56CiIfE5A3Aa4OPxdh
         +ZDto/1W0cdBwES+bNcq1pmyh3Yz3/oKkPV5GfaGQwjaCaHU8VjXPz5OQUHq8wnEYpg6
         20HqOSJPReM3fpSOxMrbdPs33YnScokzQPKDXeThnFnXRuxqJ3WuikgkqYdASmM3OFbe
         i+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779885859; x=1780490659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qYq2RP7F78uUAT5YOZEmhrXVmYdKWobwZFZG/FoawmM=;
        b=BGuRK/24gJjIunTsWZqa4fSvrQyFSlYYJQRCtomd4WyDqex/IG9XX5JnvzvDKVb2Bh
         5BUS06hoVsTwoPQ+RyDgoUYTzDP+IGfacK4OH3vjmjo549yKqjsMntchfYzeH1uq6jdb
         D4qI/YJWtSMddcy17AVRnshbKSS/v8SZIGXP0DTNKwTy3w5KJayQHTKjXc+j07R0Ca62
         0phhJfEV0b6TUFqD/6OxpOG6XRiCRFIfjg2RiOrIKAm7miPUry3cfSHUphokJa5b0tNO
         WDOCJ/vFh2uCNXDtdxd1x8XKUDGILS2QRUcqlLiHAm0skFL01DFq2PsvnzhTX611jmRT
         0Ngg==
X-Gm-Message-State: AOJu0Ywcxljy6MJ98JhxNcUKfIgE3P5lNAEt/E+b9xzlanQc4j/MqdPU
	qicmu1bvRyroiv4o2WEPEHdc8zjF4U7AX7qbX01ommUF8cSWsaTp1Z01rYK5HgENv36fLIqzhfx
	3V2IqIgOV0XQ5GoyDauBop++5bBbec+8qregAnE/oNoD6oGLv+pEvpvJusA==
X-Gm-Gg: Acq92OGFk/3H6O36Zg9qOxWQsiOB8l5ro1FbJcq6nBUSlDYp2A++DOphHMD3LmiCwtE
	GE2C9YKwFmFvG1+FTisZh2XAwZktsPEZYWzr6Gtfh0au3gvfPvXIcYFdKSJfpyGnhleWj6VyE8c
	xudGV9nUDorNcQm1wbkI3vBY/PasoctsXFoMtKWGp4uK5s1F7DThYjROEfHvzpj2j9bdLKGrShu
	zuRdF1WY6faH2Bina97WWyrOn5RdipA/YZAYbFtyUfSVDEnAizMCgm7krUuBHN7PNgz+Z+vDSOl
	sMJvX7rVYU2jtAIDLqr2cn67AnbGJt/uPVrGZjgCTLbjKkmI1w5AOXrDcqd/JzKq2BIQfoJVjlY
	3Gr5dvmWH8MCJRC/XFjbjAV7vg/n06gQkcg==
X-Received: by 2002:a05:651c:32d4:b0:38e:97c5:fe20 with SMTP id
 38308e7fff4ca-395d8d8d349mr56711231fa.23.1779885859193; Wed, 27 May 2026
 05:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505074644.195453-1-haris.iqbal@ionos.com> <20260512103424.GR15586@unreal>
In-Reply-To: <20260512103424.GR15586@unreal>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Wed, 27 May 2026 14:44:08 +0200
X-Gm-Features: AVHnY4JbIzKW-7wrGTUabsud434YAg-68Z5-lM-9PCK-aByORojgnGaXhVpogZs
Message-ID: <CAJpMwyg-6Qxskq2ktuhvf46yD5848J9BYLMPPfBLjg2Uzs=xnw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF RFC PATCH 00/13]
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-block@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, axboe@kernel.dk, bvanassche@acm.org, hch@lst.de, 
	jgg@ziepe.ca, jinpu.wang@ionos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 12:34=E2=80=AFPM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> On Tue, May 05, 2026 at 09:46:12AM +0200, Md Haris Iqbal wrote:
> > Following a conversation with Bart yesterday, I am sending the RMR+BRMR
> > code through patch for easier review.
> >
> > The patches apply over the for-next branch of the block tree over commi=
t
> > 07dfa981ca3
> >
> > For context,
> > RMR (Reliable Multicast over RTRS) is a kernel module that provides
> > active-active block-level replication over RDMA. It guarantees delivery
> > of IO to a group of storage nodes and handles resynchronization of data
> > directly between storage nodes without involving the compute client.
> >
> > BRMR (Block device over RMR) sits on top of RMR and exposes a standard
> > Linux block device (/dev/brmrX) backed by an RMR pool. Together, RMR an=
d
> > BRMR provide a single-hop replication and resynchronization solution fo=
r
> > RDMA-connected storage clusters.
> >
> > My session is on Wednesday, at 12 in the storage room (Istanbul).
>
> To summarize the discussion:
>
> 1. Move as much logic as possible into the block layer; RDMA should serve
>    strictly as a transport.
> 2. Identify another in=E2=80=91kernel user of this functionality, and add=
 support for
>    it if required. At least accommodate potential users elsewhere in the
>    kernel.

Thanks for the summary Leon.

The main logic which handles multicast/replication legs, missed I/O
tracking, re-synchronization, etc are the core parts of RMR.
If we move those to a separate module, there won't be much left in
RMR. RMR already uses RTRS from the RDMA subsystem as transport.

Having said that, I am not against moving RMR out of the RDMA layer.
It can serve as a reliable replication service/library for any other
user in the kernel to use.
Which subsystem (block or something else) would be a better fit then,
can be discussed.

PS: Would this be a good candidate for a session/discussion in the upcoming=
 LPC?

>
> Thanks
