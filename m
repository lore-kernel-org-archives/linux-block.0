Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487D738B12A
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781260609; cv=pass; b=ICFiU60+ulKeOPbtLoTFfy4EkLwd8Ad/5jomn9C1N3HlFu60wfBI7askyFramTcEJOns4yNok2NP56kDwDhGloc3e/jTFXksmxdJ7Up4XV2tiEfNiUfLQAIPpSAInika8vLi4CXCSauMHB/5zwiZZAtNruMxceYz2qfzMKDcQ1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781260609; c=relaxed/simple;
	bh=tpqD6dEgKwpDgTt1o9eFgCfJTmaToJVb/2vuyaplCfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vd5jqBLrLAtOL9GqTunWNrP3h8Qr38+6RzGZdZyesVFnaXzBaD3INsLeFWM7YLu9JOOw0OX3GdlVR8UiknBcf/TGInpUBiDEux4JE3VzMZTj65XcnH/iHzE9PPYgxgi+89fgaDvV1+W6gKoN41ZGOE5dALk2UWNve5AN6J7LYBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=LzJiviwc; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="LzJiviwc"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39697a4e16cso7132931fa.3
        for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 03:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781260605; cv=none;
        d=google.com; s=arc-20240605;
        b=lEgEtD8WkesaGYhYFis7/gMHQmStFvCoaU+DScAwNIdRE6OecLsLj4RcqAj3oFGHjy
         SdOmOtIXDw1BrXezJ5AnhZTfoV/tdDTMPQfYfVDcqvgujJUecf2cmd0lLcL+91+Cout3
         AU8qMNUNenvAnIh9IEqQ/B05m4cSOdmWCIJHEtyOMj5vQ83YjoZQtDStdX/lGhs7YU0I
         z4DGTosLT14WK0nvBQKBtikDGtSkqZ81yDXX/T+tgHIHgTsdnccKbzQPoJAuw1WHJDMQ
         PT09VXL2ynQC4SQQy9FbkDOaGJbFmNJ5m+fqGQO4npax4oQEHFjT/dDXfEUAzf3AB/Ns
         pTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t8/MJrALaz6S8qNbsg31/wcn5U1Sj+Gpvh/chh0VHc4=;
        fh=yLNc1XidA814+sXQvhZiz4kF9KdVgIGZ2k2PcwTCG54=;
        b=DSciMHa6RHc167pg3X0gewrgc9D9U8Pg5BJCCdIN+u5XoE8t8HQzpeTvni3a4qhQOL
         q6skiHd4/UOmtbiCY7UlV0QqlsgzdQLxPklLl9117qXE2iSG4qpoil7qrq1I5B9sk1Y9
         d8G7pE1ihAC5KwXgTWGxoWOavs24qbFJ5MNY1cbvhGulMpuHDJLND0ITOCf9zAhMN666
         Lywha1k8jBv9vVKIVtFUsLxhoqeMR9Js7/NASLlFLx8J1d1j+qncBRQT5r4TPMbTauIk
         81uxmOfJwE2mYZuNFIJPpsyHsOFLpvUMazJXeeY/vTOKKAzbPAzqfjPLuTJi24Yn2EB2
         LEHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781260605; x=1781865405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8/MJrALaz6S8qNbsg31/wcn5U1Sj+Gpvh/chh0VHc4=;
        b=LzJiviwceISAohEOtNC4PCyESDuk7Id7bvpl7o8L4RP6BlHos0fn8TpndiONXXjZgX
         udRjnpgvScN8U9TUs9hs9vkCVIqUWx8yhOFY448gfw6B075gsvtk0Y7xaCEaEAI7Opek
         N+TEcWDspniRhHsOa4Ny6+Bop6TjSvRgPXsq9eEUz6QJIN+cziAuatzWBxoYMk5P0mAi
         0Gh4qFq8eeMQ6l/eZB3pC0iwOjaj9CdAwEuGo67SEVjTbqtpl6uq9GLHPTbLBv5V4F/P
         sibmLaeaYkD2imXcZLIsGoNdHNUYREBLGc3YXFVYmygnekGFqDJ8fhr95WtEWK+xh0gE
         KojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781260605; x=1781865405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t8/MJrALaz6S8qNbsg31/wcn5U1Sj+Gpvh/chh0VHc4=;
        b=githnp6RfRRtV58xwgGPv+pPU+XX1DcjH/La4REjnD+cRXPLpjplsTp1tQvDQYcNH3
         MkQCttBSbjFgt60A1Hbf7sazUkYtG0Mq4hdu2AFv00VGWXFDf46hTc2hK/7Qe9o9eBvK
         HwkswjRfLixlkuCVpGTdU51oyn7q0LxY8oFYRd2tsGS9l1gg8cRh+uvVGnvKq6pKEMVs
         3nW1eFUtYa48hoGl1xognbWXuCXBSKrLvJ0rSgWfzawAcwasyq7rZusypKImdryGY+ys
         DDdrlaaAmpbxup0WmanTMRT6eN8ppPt3yvnk5W5r30gXpq8TztlkjRa6ogp1fDVtK+wH
         /aNw==
X-Gm-Message-State: AOJu0YwvNXZYtzb7+O4D1KrgyaYpBwfYVIi0nT6Qb/C0UjlU+UNsrXuo
	iLvFbuKP9L85nv2eqTU84tx+VKC2Wf8Gv5hsHrBv8kQeRXz2kDllMDjX1ZRx4VhLC+e/cstu0Fl
	uFeEorzxs89mhc1mtjnjxCa16L9EAW+aa96Nzc2DkiA==
X-Gm-Gg: Acq92OGsqATit14TQKLxT+7CPMsHSQ4H9vMhlP6c6DTczGqvezQXBa/rTFHGlBNw72F
	vUzfsnE/4GqkAbWHMmtZB8dkHcwGDPyW8hBdj/BVXs3PeMYWUpvKSuRPYmwaed3idr76PWhfnC6
	vJrkHlBPNu1eoXHz77WfJWaDWgyPf/jPLjfk7v4yv9r63brafO562ePi4NaVQro2L+QWJbLaY3q
	eIZN9VfAA3LfnsSJ9TK9jlWMb9c4v5UI6HqY+HiZJByfxZdel+SsdXEewBKMTpPUAZgQINox1mG
	HYyIcFGagXP7QCKFB7sBHrs3T0aFLLGnaSRzYppqkSNGi0RpZLK9RlZ04XIfIX7wMKHj
X-Received: by 2002:a05:651c:2114:b0:396:a77d:210d with SMTP id
 38308e7fff4ca-3992afcb1b9mr7731741fa.7.1781260605428; Fri, 12 Jun 2026
 03:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505074644.195453-1-haris.iqbal@ionos.com>
 <20260512103424.GR15586@unreal> <CAJpMwyg-6Qxskq2ktuhvf46yD5848J9BYLMPPfBLjg2Uzs=xnw@mail.gmail.com>
 <20260611115902.GO327369@unreal>
In-Reply-To: <20260611115902.GO327369@unreal>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Fri, 12 Jun 2026 12:36:32 +0200
X-Gm-Features: AVVi8CcddBB36C8Ot9lu1AJmuGsTsI5ux-b2nD3IzT3SB1V77NCFVDdDUt0L2xE
Message-ID: <CAJpMwyj2A1ZOAUUd+7KR-RxeMrqgvZd2MqZ2iqjJKXhRXHXY9w@mail.gmail.com>
Subject: Re: [LSF/MM/BPF RFC PATCH 00/13]
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-block@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, axboe@kernel.dk, bvanassche@acm.org, hch@lst.de, 
	jgg@ziepe.ca, jinpu.wang@ionos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 1:59=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Wed, May 27, 2026 at 02:44:08PM +0200, Haris Iqbal wrote:
> > On Tue, May 12, 2026 at 12:34=E2=80=AFPM Leon Romanovsky <leon@kernel.o=
rg> wrote:
> > >
> > > On Tue, May 05, 2026 at 09:46:12AM +0200, Md Haris Iqbal wrote:
> > > > Following a conversation with Bart yesterday, I am sending the RMR+=
BRMR
> > > > code through patch for easier review.
> > > >
> > > > The patches apply over the for-next branch of the block tree over c=
ommit
> > > > 07dfa981ca3
> > > >
> > > > For context,
> > > > RMR (Reliable Multicast over RTRS) is a kernel module that provides
> > > > active-active block-level replication over RDMA. It guarantees deli=
very
> > > > of IO to a group of storage nodes and handles resynchronization of =
data
> > > > directly between storage nodes without involving the compute client=
.
> > > >
> > > > BRMR (Block device over RMR) sits on top of RMR and exposes a stand=
ard
> > > > Linux block device (/dev/brmrX) backed by an RMR pool. Together, RM=
R and
> > > > BRMR provide a single-hop replication and resynchronization solutio=
n for
> > > > RDMA-connected storage clusters.
> > > >
> > > > My session is on Wednesday, at 12 in the storage room (Istanbul).
> > >
> > > To summarize the discussion:
> > >
> > > 1. Move as much logic as possible into the block layer; RDMA should s=
erve
> > >    strictly as a transport.
> > > 2. Identify another in=E2=80=91kernel user of this functionality, and=
 add support for
> > >    it if required. At least accommodate potential users elsewhere in =
the
> > >    kernel.
> >
> > Thanks for the summary Leon.
> >
> > The main logic which handles multicast/replication legs, missed I/O
> > tracking, re-synchronization, etc are the core parts of RMR.
> > If we move those to a separate module, there won't be much left in
> > RMR. RMR already uses RTRS from the RDMA subsystem as transport.
> >
> > Having said that, I am not against moving RMR out of the RDMA layer.
> > It can serve as a reliable replication service/library for any other
> > user in the kernel to use.
> > Which subsystem (block or something else) would be a better fit then,
> > can be discussed.
> >
> > PS: Would this be a good candidate for a session/discussion in the upco=
ming LPC?
>
> Probably yes.
>
> Thanks

Thanks Leon. I'll submit the abstract through the portal.
Do you think the topic is better suited towards Refereed track or Kernel Su=
mmit?

>
> >
> > >
> > > Thanks
