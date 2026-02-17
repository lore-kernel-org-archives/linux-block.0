Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9FF32695D
	for <linux-block@vger.kernel.org>; Tue, 17 Feb 2026 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771324655; cv=pass; b=GpuTxDXQdEYVR7HwYcZg43wlPyBN9QOivKrsBSShCzz9t8AgMLovyk4httFyNrw/DJG6cgw9+UpTklqErJDOZr3wKhHTyuNdFQqRH6ixYy40DmEEOSvBwfFaz/RHoAZiop/Jw8Klz43VG21ndvycVl/6aQIPHUR+xbXNi+iPWUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771324655; c=relaxed/simple;
	bh=dPjtly+ZxqrcgnTcKSIFDHsF1hA5MWE73lwPbiR8+3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0fsjCO/bTjm3LZvTGfvj3RKqYnrmk93+fOmtDoV5chHdOxDkU0OzIlBKc9pwtC+wzDgIEuxSxqXZ/zGT6iKpoorpe+1hm+VLco9LHFNwYSmclbKavNRccoZy1GQo63mW7fyRyb/n/Qq/1QUjbNMIYSeR//Q2nT41Ua1KYfAmGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dmYLmGrQ; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dmYLmGrQ"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-387090ae5b1so32458611fa.0
        for <linux-block@vger.kernel.org>; Tue, 17 Feb 2026 02:37:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771324652; cv=none;
        d=google.com; s=arc-20240605;
        b=BHl29tIF3OY48BS3hcSNw+qtFlYmsAnD+/B4WidNhjWpiCQ/YBVaceCIaeqavQM5e3
         WT0NmS/1FQgsS2oNcATyJA77i/sSyqLFOZHpOsfRx0FnGbijisCwHvuf6nlyQ57VgPD8
         rZZJc+nmSN1o1iNi4HtUs7+WzZeHFcKVZ9UE1I30XquOYNoq3gV2mHWz17NZ5yuHKnBQ
         zYfjp/dFEzskc9X9ib5Of5Ru5m90J5YdmQkdfRKLqSUHewyUBuIjIZYN9ykOjg1BsSuj
         ESbtg3lVvBij+9dtDy3rkO8us/niwN/aKSCe1gW1ueUjkS5osknHBTON7n4NbAmmU8J0
         r3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NZMo/PtOIzSJeD+bvKh62aH9xtqgsP4XaPk4C2v4d9E=;
        fh=nHBtpJkKnlDGP1pWBK+UR35aSb6GcMox0+qSEPK70Q4=;
        b=ZBq/EeOO7eM27BtQcEFYIV/WTNJRZ+d8Vqg3wFH47sNlBS7KNtiN7W6eVEAW52oePx
         WWJcaeQsHCvgFbw8noILj24Bmd+h0x7phhkkepoGG68717xPpT8LbwLAtAMWl/Wwe3r2
         0/AE/X/tRUP3Y78e3+L5fbo4ZpG8dNbSckwa0muaWXGVfCilfop17nFqhkHabiAJmZYX
         f0axBqdeHDgwd2XuDkMFy/d3xO0AkZdU624kvObvg3Gap6uIEDIKrljZdV0rh52AKjJw
         J5tawabOauwQoqrL1l/G2qTQ/Khsg5bUs7MYHdU+dA5RJ09ZiZbHx6ZnmJe+x2Cbi7ot
         MY0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1771324652; x=1771929452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZMo/PtOIzSJeD+bvKh62aH9xtqgsP4XaPk4C2v4d9E=;
        b=dmYLmGrQL6EpWGinGmazJYZO2mJYS/9YAtjKAkQYVsYcu67/5AA8mkj764LmfULiGy
         Bq1tyIlasq5pw9UoS4Sr+XCwvWTBbwX8s+hIVYntsZPYoiwNa3nVU4Db6qMzN0KObR5u
         +szP0cw+XNRlcTzTNf4B5GXh2CK1xmRAFYDmrGhbKeZ1DNZbm24/fY6wlyVWhzNOgLOX
         /tZInKxJH3v+wzSCU2v2Mk1DEhlRMMh0/0h0X+K4aDFEi0cYkMFereA5+SHXhdwt9Ejn
         m9++REQio3HlLCp4R4ZiLcPl3WV10drQ7hxCz+iw3pxBnEx/RC6cNykCWYgpsliYzvIg
         1YKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771324652; x=1771929452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZMo/PtOIzSJeD+bvKh62aH9xtqgsP4XaPk4C2v4d9E=;
        b=BfPA9FAWQ0sJYgJUZGknlE2SujCetAmv6wlIOncIQRtYC+3eKiCMjAyK1pcFG9umsa
         BHGt85C9sbxzc8+qRVv5ocXHmntGz5+rd0gQVT7P+neKN9vQaj52XZJat0QtNKcy+toh
         WWvpfvxdfsWr5MqG/77bD2wZAK04MPBawPAwe+vdCvZ7rmvEP48fxf67ZV3yfpJ1QOaI
         BJ4kHxhEQWyGUu/3XFuGSJQlxHKx4SkmZYoWzgOqC3w9nTMzyp3HMkxVsmjQHSCnr/47
         MgAQSTwpjnKNyW1/bow8wUvUuRhfq3QYtsGcr6QNbj5tRJpI+f+tIYe5SThdCdx81KBU
         LFmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR4DIX9coMCnGpofbJYovqLeQj+jkgVPO0fdV2w9fbgAsT1C3s7IuU0wW5EbS593Ct5dOzXFMRZqWMsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrquBWmruOSkscvqc800S3aRqbKqi7FmfiEpO7lMorGSTFxaX8
	uxXMPSCaGzFDs28M+yfvbHZ6eslqSy6ot0jbdWvf2XVxyd+A59hYG9WepBPaQaibA2gdIUVjVSP
	WZssYiNpopbLqq3gg5E9p9AOLBgScOoYc2Gzyj324ug==
X-Gm-Gg: AZuq6aIyF8IWqqCTLQVkKuCneBCuC2mSDJYT1/38Gj3WctVqGTGuEm8bxm5V6lBspxx
	Q6BSC7Y5BDFa9qLPUtOkyfKo5TBIEH0sEzou701zf/JZAUCHEHgvI+FFj+tTkowKd4nh2mfRMBV
	jUliq2nOAqJi9ropCcYv9u7Q5FMCuh3LR6Cz8Fz85ClL7tzAueNetMccfnsxRgLV21xqxc1J9wX
	yEnvIp0Sf9nrd0rOzP3lU3d51WhFmwHIcK2MfiaZs7/Et4vVNmFJu5Z/aYHHURkTqhkvyxezbOs
	ZnJshnIeLR1T3ROJ2pFcnlCD554AxtQqsePTU8zTxkeQR8XBS2IsEG2pan37sGRiUA5+
X-Received: by 2002:a05:651c:1ca:b0:386:ec21:c87f with SMTP id
 38308e7fff4ca-3881b99cc9cmr30135731fa.42.1771324651832; Tue, 17 Feb 2026
 02:37:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner> <20260119-bagger-desaster-e11c27458c49@brauner>
 <20260129-beidseitig-unwohl-9ae543e9f9f5@brauner> <20260216-ruhelosigkeit-umlegen-548e2a107686@brauner>
In-Reply-To: <20260216-ruhelosigkeit-umlegen-548e2a107686@brauner>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Tue, 17 Feb 2026 11:37:19 +0100
X-Gm-Features: AaiRm52ye33PKO28CcExseV6coNOG-rZ2nBeMP78z80h8Dwp-N455yQLK7UlhmY
Message-ID: <CAJpMwyg-3-Z=ZDC60Vn0s-8Z78VOPKYmvX9s=Nnvcoao4T5zbg@mail.gmail.com>
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
	bpf@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 3:28=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Jan 29, 2026 at 05:13:52PM +0100, Christian Brauner wrote:
> > On Mon, Jan 19, 2026 at 03:26:39PM +0100, Christian Brauner wrote:
> > > > (1) Fill out the following Google form to request attendance and
> > > >     suggest any topics for discussion:
> > > >
> > > >           https://forms.gle/hUgiEksr8CA1migCA
> > > >
> > > >     If advance notice is required for visa applications, please poi=
nt
> > > >     that out in your proposal or request to attend, and submit the =
topic
> > > >     as soon as possible.
>
> This is (likely) the final reminder to put in your invitation request!
> The invitation request form closes this Friday, 20th February.

Hello,

What is the announcement date for accepted topics and invitations?

>
> Fever has struck me down so all you get is a bad limerick:
>
> There's a conference called LSFMM,
> Where maintainers debate and condemn,
> They argue till dawn
> What's merged or withdrawn,
> Then next year do it over again!
>
> Don't forget to pester^wask^wremind your respective organizations to
> sponsor LSF/MM/BPF 2026! If it helps, you can tell them that we're
> considering renaming it LSF/MM/BPF/AI.
>
> Thanks!
> Christian
>
