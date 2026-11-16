Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794845622;
	b=EFypxTTewiL74sJMNOo1HBaSL02NFdFPMfmpfs8mWTGDaSmDk+T9mLDY+B1RhpFd13Hp
	 XPHu+CkO132mnftjpTgwwY50aIDPtk1Tqc1bfsNNMOq1V4Fxc5G1OOd2+EVl1/Gruu0U0
	 cZ5nfKk+XVic7qhUN8K3KhxWAvZmgeBP0OYe2YK8Ey3SMjDzU88h9BQXDPcDUFbC42mVB
	 jXuS1mh6ODy+U2d1eTNLJI8bBDUmPqD4QdDmPTZSwbqQZFTeExt9BcFV8d3E+KIqHSDBc
	 3NJ5fxxdXUEfemZ8hFaD3rSnvkf3cXgHMeoGa3A7tejLdR5dbXDxys0ssTfD0W2z98g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845622;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=sB1SE0+x8zWHSF23lZUFMhizy3rFzl0NBN2KJ6cwwgI=;
	b=vrPO8Tri1S6haHioYr5n6/i3XSXpLHSfLjO3vtjOQVDXQWu8NMNr3BMQ9aq3GFyirKqv
	 CfyiiDuthGElSYR+Ztdk4hzejNmQfJelPal5vyXMl4tgARFMNlfigqfRs6//q7VX7z0UW
	 XX3ZcpY5BHMZ0iqPuaHvYNcsnjnjzPXXqZXlgEGjKFMziVZl5E75Ob9SMCm7a2W9etCdI
	 tdy2xfyf6yA2OUrklqNC9+1ymDe3r56DxXQRUVNs3P5NI0/FvaD8l0D5SdURH0IfKB7IN
	 2WYK8AX1/JQiXlDYfhx5jyAxIFjbe7FUXcNPStXybLs7asxd1Vi6HqVutGUqsbLSYvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T0o2rinQ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OeDRhhgv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE33F606A31C
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 16:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE33F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T0o2rinQ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OeDRhhgv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794845620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sB1SE0+x8zWHSF23lZUFMhizy3rFzl0NBN2KJ6cwwgI=;
	b=T0o2rinQmbdm1PhL7zLKU02quGLgcH+m6CuiBeHFrAB9MVX7Bqb3Ixx37ou+kPkmHGBtJv
	/voVNkYXAyTH4V5a/P5/da1vZNeSKv7FgnVsfQG+I0uRsT6xqtBxQhaeX0XPeyGyOKe0Xe
	X4oHLHjpm6h4alnIgJTtGiuU22uFr0I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-yCTzbF0wO7qhEIwX6Zpgxw-1; Mon, 16 Nov 2026 11:13:39 -0500
X-MC-Unique: yCTzbF0wO7qhEIwX6Zpgxw-1
X-Mimecast-MFC-AGG-ID: yCTzbF0wO7qhEIwX6Zpgxw_1794845618
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e0af48c18so2430704f8f.2
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 08:13:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794845618; cv=none;
        d=google.com; s=arc-20260327;
        b=DTHeMqecT1/xMaObT6BPK91JGL1Z9ESiaOjpLaseqZaAaS9P45s+TatS4AliDuZrsA
         mPmzPA5x/SF6D9KTKngIcnvDG59BtMlbYLpXA+EQVZnbrshXtR87L0aNSprnpppUV9/j
         NynwTnb9FrWlcbIY9bbxI3GNd35DdnIzT3fBwZoSpsYXIs0FmKxrN3gZH3SdPNgqvlDB
         Q3NNJ4DKSk7SxAeVYiekPTl01Frf5+H92McLzGOefGOa8C3k29STfDCztOYpkMqkQ+6l
         h1XjRfyb0+opEcTM0wwNFUvh97VVCbqw+QVLKEjyJWawhCyUa7BgEbaFXCDjsFaUBg5r
         pZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sB1SE0+x8zWHSF23lZUFMhizy3rFzl0NBN2KJ6cwwgI=;
        fh=SDVKaiqKm7IeempzdPcYWwVJ+qwl4f83nz2nscsYRiQ=;
        b=gXodX6OeyaEMvJQwVka+E9EWSCi8G0/mXev1wtbiKvtDA1RW988FyVCA50iZJBBQEL
         BBokJDbRZBUV6rE9HQAbIst4dxutE5fapbbD20RPgLxyzgjj3NWNfz4KGFoliul99H3p
         jKzvZKOppEpFky2GdOzC6qrnKBFZEwjvSF1oH+t54lO7cdgXsmzELAgAtJIgb2tOQjPJ
         pe5FcVg18u1nbjjFmpjoZ7v0uhkPLiJHDDkOrnEGaZu9UUBv0dJ+b4BWEmXWyeJAEpMa
         mKbZI5WhjKupGpAxczvJWlsHClqufxl1D/wWuLWwdcAlS7f58OkF4f4TeoyPYsNnB/wo
         S/Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794845618; x=1795450418; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sB1SE0+x8zWHSF23lZUFMhizy3rFzl0NBN2KJ6cwwgI=;
        b=OeDRhhgv/AfCn1Rh9veX+MxsoEljqTbge5ZR2aIWEd2lAwJJaOaRT2PqXC4fIjaSG3
         zaigqmvBWjIQ6IUjwfy7AHmXrBDNVxvJDc5aFC9f/A0cJOeQAiptFjaY9ga5yWPBso/p
         m93KOCQQDnsX81Aik6Q3d3moXqEJbnPI299s3Hm81R4TnwoObVwEKWTOlIgXUbu+fOvJ
         AhhqmaXW8UrUanIeYETu/yP18guJBP9S5m+spJ1Kx7WJ0q8SEeBU5NlyzUAWey3nK3Er
         Fg1kIzNJ3c+EQck2WyWFvzNwJdjMr6PxOtI7GHoN8RgefPreaIBZMGkMi9QEfPn5yPzz
         Q4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794845618; x=1795450418;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sB1SE0+x8zWHSF23lZUFMhizy3rFzl0NBN2KJ6cwwgI=;
        b=b/MungtbiU8lkckSO9ysQRlRbfPppmSB1GfmmQJQRRbYA8Olib/KT+E2f6YAXKngg6
         e1+SAtrQYL01sCm7ZQCnJkYzLmk7pa7Wi/xAJZGHP8DWKJJ02A7LJGgcsyEy/LyJp2J5
         L7XUaefJeRvl1qljKqq0DHCRKhGEbZi48s09MZS+Yf1O+OiSxSlOCqugtXFBlWhBZZpB
         d3qCO9hwdubWYys0gY/8x9TCYeIAzCgiA0hPEh45Vew079m5de5oew5907UxUmLjq0dP
         h42khfdQwAHgt2XNQzxzBVCG7HwKJRh6U4yh5tLrOJnDht21UqbJp/tRxRIHVYpPAg4q
         P4fA==
X-Gm-Message-State: APuU4Z9LDhchKbo/xd64DvyHvWER0z1BZYTNwZfjSy/6ziv7VU0URFIi
	GsHyUXzZdBAHsPtwhAvbUWWeqKJrISCPbrfchGLapK/N1Rq+DXRY3WrqzR0MyOCc2JNyMRrI4gq
	+UaBQTGD04IIUXZwT1Wki682Pb8IaSEZk3PuZfDPmiSFjBEkFo8OPcAAcW6ogMJAgBZ3PeKdqZr
	1KmAAMWvfqcF+vEzwPh87Z3OooMo0H5pJMzQOvkaY=
X-Gm-Gg: AZFdTZeQbIRZpBbn2NhAw3c6D/2s5VRGq3m1dUJgeE9Qrfay0XK+5cchlXrU5r6BS2n
	1Cb/hENXno7YMThGLKnc9NasRtj/E5Rq/8C+uBcXeMZOnGtIeXMX4L1BnsPOrpxPGnXL2xFGpfA
	WiqNBIh8vB4DrMBjik5qVOBvfjnWtzOJTFIHK2B9n8qjjYJGoICbdkVwbvGeIBz7FsuSunTxmMK
	RWodOQ397SIHtSzGw==
X-Received: by 2002:a05:6000:5c7:b0:48d:f996:1814 with SMTP id ffacd0b85a97d-49c7325b40amr21495652f8f.57.1794845618171;
        Mon, 16 Nov 2026 08:13:38 -0800 (PST)
X-Received: by 2002:a05:6000:5c7:b0:48d:f996:1814 with SMTP id
 ffacd0b85a97d-49c7325b40amr21495612f8f.57.1794845617844; Mon, 16 Nov 2026
 08:13:37 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104173842.2937092-1-jtaubepe@redhat.com> <avWUy2nQQChS7dsu@shinmob>
In-Reply-To: <avWUy2nQQChS7dsu@shinmob>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Mon, 16 Nov 2026 11:13:26 -0500
X-Gm-Features: Aa3M54oatI2uOPy95QX9eiVR4ZGnjUeWcUc7CEQ_hJu_GQvfIawjS5e-k7-pXg8
Message-ID: <CADRr4bdwGdeQsH5Rwhzd0HjRYDuPopK5_6SLi7BKnpg=XOLpbA@mail.gmail.com>
Subject: Re: [blktests] nvme/077: Add ANA log page information leak test
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	John Meneghini <jmeneghi@redhat.com>, Daniel Wagner <dwagner@suse.de>, kbusch@kernel.org, kch@nvidia.com, 
	hch@lst.de, sagi@grimberg.me, "Ewan D . Milne" <emilne@redhat.com>, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 5:36=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Nov 04, 2026 / 12:38, Jesse Taube wrote:
> > Regression test for reading memory contents beyond valid data when
> > reading ANA log page. The NVMe target must zero-fill the ANA log page
> > response buffer beyond the valid data so that stale kernel memory is
> > not leaked to the host.
> >
> > The helper program (nvme-ana-log), requests the ANA log page,
> > parses the response header to find where valid data ends, and checks
> > that every trailing byte is zero. The check is repeated 64 times becaus=
e
> > leaked data may incidentally be zeroed.
> >
> > Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
> > Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
> > ---
> > This test is meant to test:
> > Lore Link: https://lore.kernel.org/linux-nvme/20261104172833.161567-1-e=
milne@redhat.com/
>
> Thank you for the patch. I ran the new test case on the v7.4-rc2 kernel a=
nd
> confirmed it passes. When I reverted the kernel commit 29b8758b470 (" nvm=
et:
> don't return memory contents beyond valid data when reading ANA log page"=
),
> the test case failed. Looks working well.
>
> Overall, this blktests patch looks good. I have three minor comments belo=
w:
>
>  1) src/.gitignore should have "/nvme-ana-log".
>  2) it's the better to note about the kernel commit in the commit log and
>     the test case comment
>  3) I think "--port 0" option of _nvme_connect_subsys call in test() is n=
ot
>     required
>
> Jesee, if you are fine, I will make ammendments based on the comments abo=
ve
> and apply this patch. Or you can respin the patch. Please let me know you=
r
> preference.

Sorry I seem to have missed this. Yes it would be great if you could
make those fixes.
It will be faster than resubmitting and waiting for a review again.

Thanks,
Jesse Taube

