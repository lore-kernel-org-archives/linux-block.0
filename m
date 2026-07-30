Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79840099C
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403549; cv=pass; b=ZEj9UfH3ecrYthhNuISw5QTM8/LfAKhl3ng9b8MrqXBR0O3VVW8PVk7TbZOg3TIa4wOmjtRXlsHzcfMqkzraWIhyYoplNfrwMgCkE3rf/N2cl7WOQayPxFfKKntukmUPUV+btvelHnWb3RDNPFVfAqosePukUcIiC0WCr9QurGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403549; c=relaxed/simple;
	bh=LSzHtFgbtMvKJSPGWtBb295ZwWuUO05f/LYUa++jE+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okByAl+DK6gzAwobWwmDt2FWpW2pv/01yEgZA2fJT/m9HL+WWi+omvhUl23LLIxhR2Smbo6hytoWUY7rXts/TQuid49kQNaMyNd/J7ahEDu9YuBYPm1ljEAiAIZ0NwnB7xBgV1ix4VsTss0zuqftqd9rsImIpsa5RacDEOoEkD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnhZ2K2w; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnhZ2K2w"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso2018101a34.3
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 02:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785403547; cv=none;
        d=google.com; s=arc-20260327;
        b=JPxz7bPtH0m+iAJfP2fxDu7Rj2NV/GdRLWYZo04IqC4jb+Av7QsKh9ARjzo+khhET5
         5EUcZYPKC/UE/2ql858chbs3ewUF8qsMLK+NH0RYzpTzX3mIjSB6j8VRwO2MVGyU4cYb
         MoLorue9o2GHyNMUSzP6nK33UIjXObyvufV6FbmPqDtFvSf87m7te3Lz/NToUBfzj0ru
         61JVBfL8WUztcdH1U5fJ6rtjL0eXFCFF+DwrdJazo7nOZjhLbr/AMqjIptWJuaCeWCGc
         fLNU2HPHOWHSvCF5Rb437MhqDyyBoxnG04ghRy4iVEDxw08+MZvNdcTaRek3Ls8Fhz/b
         5uIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F3tmc6Hix679VZeoNLiFv83lH5jhtiL+H1oB5qeNyiE=;
        fh=TSMy35S1f+/1KCipsnk9YxwFRaCixi1dq/jfONsdHl8=;
        b=lhWMeDgHlGQzZyw3Cbqb8l1eR2dpmG9QNdJoLZEv5oJYSa9l5azEFQOo8CJWRZIG/b
         c6+NXOsvZ/Om6Xt7zF/kZY2wH6UFqw8/6UiLlKzmMO7UPf45uYodY+GWK8W7RqXReF2m
         /ZKGEvxNvRBHTjzoViUscBFSSfOOgZk52WDCNUvHctKYXx3KCQb9/nlYHeq+yBHUbP2W
         RIlgAy9nZ96C5kw2gkx4klPYgmP7dbtcHtTmWU9TMM7daDA2IjA+k2Q0gbxLZmXxHCV4
         nvEJbvtwDtk3tdzT4KaASzqz2H3dXoj5vjcvU3lWTZww60pZ5NtQmEM1VDImEEj6wKb2
         PDBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785403547; x=1786008347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F3tmc6Hix679VZeoNLiFv83lH5jhtiL+H1oB5qeNyiE=;
        b=GnhZ2K2wJnh9JswJQO/ZSdEAHTyrKEcvOELH2VcBoMcZY4AMORhRA+ltiIctZnpVNA
         ctxzel4/Et01U2Bhc+BIsqS1htKaeeyqKXq67hS+5CV3l49FDexOehOEivnIVWWXXKJ+
         XN2UKKz09o7blhxzPa0JvGmcuFjBz8VI1DlwQFJcyLXIQRID7A/F9u6JGMkHHKvmIK4x
         XLsrqShGbVbm9/p2ZoffQYY+0NvU/4SmVAYpXj09dSw2jLmsIcOo2+EFCyEo+bzFDZ4o
         Ozs6sUJwq/MSEASqw+SelJ5o0Xr99kf6IGiLrHxFp8TWCwCuPDHf7SLztHl4HDHmVxjR
         wSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785403547; x=1786008347;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F3tmc6Hix679VZeoNLiFv83lH5jhtiL+H1oB5qeNyiE=;
        b=FiaTQZ/UUPXTcI8VwVkeHFSM7NQRhmb7qmwgwt5MjTt6S7Z4aQdbyiE1Ll+msWqpd3
         jcP+qtwX9uMmBE//leFSnLzWTIBAbR0WYtporZf7Mu2dhKfY/Vfo7wsVAEXRl2XAwNcd
         v+G7Fvu+4rk2z15qzmjwQwMrxbBWNHMRDAeh5Wu3hX8qgsrTZ6CW+PDzxWMsAULp8Xxr
         zy4I9l9BE4bWrdMMD9iPs1cZaV03Z1k9oipwoMOfc35mkg7S3psQQFKiF62MY/GC3VVk
         nwv2e2W0jvUi90fWQXT9dorbSdmRpju6Yazlr/ZTWw6LxG46TpBmTtBX8Lw1jZsjEgqV
         PUAg==
X-Forwarded-Encrypted: i=1; AHgh+RogdEYfLhjN4Bq+AF9fK3UIpQFjF2hWzI/0gFYXfBkb5nYwwasuO00HW10uAmv3AoDWiSWcAI0Td65u7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiI26pxIxOBaxtf1+HPe0hRAk2ODqJl1Mjx0JZ6zyNGQ2v0d9C
	cfh9j+CviMwrnoaJp6dVuK7yld38T7xS9xOOZMS3eaeWuS1KWxkR8eTpYl+QIpLPKOG/NGP0dT5
	f/h4LWe8DHL9Tmzut2pCAFXYNnEEmLqQ=
X-Gm-Gg: AR+sD12upwkmclHEPwi8lox3zBXikSAT4FRmyH61eyVBsGLH4FBTyOpibeF/m3PHAxb
	Wb3FOQdaGLObQwlL3Rr/mkoYU0NuVdTvQjhLrFOHVPbVVjz8msXB4ZzdzVnJnMONNjC8zEpBjGm
	AMJcYGM6V7WCFIjk2akMLlZeXfvZDhR+d4XHylEwxRKCWqOiyK5f59p10/r7eh2gBSE/pY7t1LN
	IbmBinkhcx5cECbRi6HCJ9SvtC3cuKq5jvxPPVHCnrPHjLHPTQKHH1yPw4JqVrF/OCnF+m0WSK/
	iAd2i1ztLiKnWsvyJFo5qvhvG4Rl7uef4/xQM/YypbjAOr85bfroZpsPkIz0RtJlEvTju/D3IlP
	hDgtWMm4dExB9FHJl7ZeUriLakE1cu9xQKp5hPkkrMK/OXaSXqm/mxyg=
X-Received: by 2002:a05:6820:2914:b0:6a3:97c6:f80f with SMTP id
 006d021491bc7-6acbc0962b2mr1103342eaf.44.1785403547526; Thu, 30 Jul 2026
 02:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730084000.3305702-1-hanguidong02@gmail.com> <66fc571d-4e6e-4d2e-973c-2de4789df432@suse.com>
In-Reply-To: <66fc571d-4e6e-4d2e-973c-2de4789df432@suse.com>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Thu, 30 Jul 2026 17:25:36 +0800
X-Gm-Features: AUfX_mxfbh1F7INaUWJefxenTBaf3A5IcBk4T84hBt6KJT_lrx3p8U-Fv5F1jbE
Message-ID: <CALbr=Lb2KSqYLg+19opHZJdhTGcuZCAtskxFFyibNBjuyRGUnw@mail.gmail.com>
Subject: Re: [PATCH] xen/blkback: Prevent missed completion when draining I/O
To: Jan Beulich <jbeulich@suse.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, konrad.wilk@oracle.com, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, roger@xenproject.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 4:43=E2=80=AFPM Jan Beulich <jbeulich@suse.com> wro=
te:
>
> On 30.07.2026 10:40, Gui-Dong Han wrote:
> > --- a/drivers/block/xen-blkback/blkback.c
> > +++ b/drivers/block/xen-blkback/blkback.c
> > @@ -1021,6 +1021,13 @@ static void xen_blk_drain_io(struct xen_blkif_ri=
ng *ring)
> >       struct xen_blkif *blkif =3D ring->blkif;
> >
> >       atomic_set(&blkif->drain, 1);
> > +     /*
> > +      * Publish drain before checking inflight. Otherwise,
> > +      * xen_blkbk_unmap_and_respond_callback() can decrement inflight =
with
> > +      * atomic_dec_and_test() and still see drain =3D=3D 0 after this =
path saw
> > +      * inflight > 0, missing the completion.
> > +      */
> > +     smp_mb();
> >       do {
> >               if (atomic_read(&ring->inflight) =3D=3D 0)
> >                       break;
>
> Yet then don't we also need a barrier in xen_blkbk_unmap_and_respond_call=
back()'s
> check? Barriers almost always come in pairs, after all.

The matching barrier is already provided by atomic_dec_and_test(), which
is fully ordered.  It orders the inflight decrement before the following
drain read.

Thus, an additional barrier in
xen_blkbk_unmap_and_respond_callback() would be redundant.

Thanks.
