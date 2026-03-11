Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031013CFF5E
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225810; cv=pass; b=myTbeYEJ2JBgF3r0zY152tCPvbFqY/sgm3ShNjt5kNnU9LCIYfHZ9Kt1He6b0EDvgpmcSrUk/qhHYwwJ18pLYoxy+mWSfrIWhEuqDcU78ev6sXY7OX2bEVb7SL+50KnPC99DCcehT+pBaQHMDvacZxgoZSXlkqHT3eaPBWpRVA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225810; c=relaxed/simple;
	bh=oCeV4ViFevXUzd84m5HpiUHtFFCvWaAKNQJTz+oay64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeOPfs3apjXCqOo71N59AtMHVI60mGdovT2r/h5as/dQTsVQ1Ak7UGboLCCXaCfPdIz7chSfdsgY9USiLTaFSBreqqD5demoQCh1HCqcRWpNZMS5K8EmPPRtaESTVWFeVJLjJgRQlfEaWE0xfmpq5+GVsopCEf83MK61HC+4H2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PklujyXJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pol9DNis; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PklujyXJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pol9DNis"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773225808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Xjw8yXZWjS7rmwloovrXF0TGyPb8EZi/Ah7SDvpbN0=;
	b=PklujyXJYSQ1h7jaMy1HuO1CiVJI1MsgCYXT+8msyYNgBKFX9SeUYjnpGDeMIIUYc64WSn
	hakNNosFYb6OsI5AQub7Yta8PVMKZg9bF61SllZLhceMq/+Oq4Vdnyh3gWiw+4ERcuQo3G
	g5+nH09oevUzj3tEk/XjwGsHUnaEWkc=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-V1JHQq8lNUWZn1ERkTUxGg-1; Wed, 11 Mar 2026 06:43:27 -0400
X-MC-Unique: V1JHQq8lNUWZn1ERkTUxGg-1
X-Mimecast-MFC-AGG-ID: V1JHQq8lNUWZn1ERkTUxGg_1773225806
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-56b0c1af64bso10114951e0c.0
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 03:43:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773225806; cv=none;
        d=google.com; s=arc-20240605;
        b=esJPCv6jyZ1fHe0TbLDAI8rfCIYAvpBT2NE047z3laFenrm3szzp+I0oZrtL4EuYhV
         8p36R/q69wFxTlFsBxr0eoFUZjmFx5cmVHDz8jKyuAmFqlTw0hVz/9SLEqFzoSuOX8Wt
         Lb1WrmXzFkWn9zLILYkVIxuw0fjdFDFrM8EeECl1LGL/cX59ZB+EdSbUhy81gSH9PsxQ
         LUUkMDZd5VOteJEXsdTUgdRZPmeCbD6LsjKVPTDU8qo8XDvjCGhddp3lVOOHSUjcdQUQ
         j6bRfIUyRZSjORCmm04MdhvbUXPRZrtzpDmV6s8Q0aGFnqLR6SjG2rD/xEhTkpWU+k2p
         bPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Xjw8yXZWjS7rmwloovrXF0TGyPb8EZi/Ah7SDvpbN0=;
        fh=J0rne5cm/1lbxpZafObhm64t8FDd4A99SwNNC64oet8=;
        b=F8tHYqE1s43el+ZlVvKwip41O3rexe0Y4L/M7LYmqbRz5XMLjHnTiI2wUxBWUunIa4
         RF/cNTSYl4M/eroDIYUclqxLHCVtxy/vnTNEj/gH3FGBTgX87kxMYRkbnsBdpYzWWOP/
         S3eQw+LDquSMD+n/oe7Yg9j5LaN0XngBzUzyDz3t5UhOAxu0hz5rZPjg5818P6xMUi+Q
         4yrgJg11Bi9+Ai4RrDHjGdFuHJnYiRBbS4c5imdzBDShWQqGLGU2umVYy5PXnZ//Zx/3
         xT8sOrirWu7pHnn5VriRrqO0khg5A9jW9s+IapJZ9fJes/JLJW4n+Wc36mrB/Ah9Yakb
         V5+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773225806; x=1773830606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Xjw8yXZWjS7rmwloovrXF0TGyPb8EZi/Ah7SDvpbN0=;
        b=pol9DNist6xnF1K1ikr3+SXn0WePch9LcsLl5u5Aw9Cjh6D7puvKXmyZQIZQKVX3Wf
         kd05MasBCWy18YcgMRxjoYE7yWec1jbaVNiuHFV3kg0lumHgLROq3B+Dg+4wJSLxUnNM
         MmcgitsMwuNz6Q9cnGXoPesF40q4Z9gFW23gUoTyRERDhhWeZFyKETrIvFjl8cAONlIp
         74JPC7MRo1hmMXtTw0GkJ5qcaK9wyiw87bcSg7Jpo9rBH0FL/m827fwZovl+EIDH4oFn
         vnmP8mXQeOHq2SYOONzfYaN6/BArI0ba1rms4P+W9BCWTCT9KmxPLb/K1yI7DDEzo8IK
         J+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773225806; x=1773830606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Xjw8yXZWjS7rmwloovrXF0TGyPb8EZi/Ah7SDvpbN0=;
        b=TJ7Q8rANcBcF0OlYoWTsq1EdY6FJn2IyU77duo9YDATMKmdZMWbon7HX7VanRc/aWM
         BWLGZFmQgiY+v53RBf0ffZVsZRW491J1w9JvuzPx0ouO0Ju3tgbbmgkLEzdQm7/t52QI
         5M3vcozmweXNFwYwR9MK9X4sD7LGdofLDRROVtSfOx40wEo6yrOj6kK/NgEC6XZfxz7g
         RPF45cuWTVIp7Qt0Y/yaRUFXHutwh5/xhzcV1SrVq51lwW2CURhUnYvM+s1WJyyw3xOw
         mBrnFepT4fMYnF8+ZR+Hqqnd/nKPmq/lTVq5Bx3vuCj2JIkcd9mw/fQEbLiZ00ZU/4sB
         OeKg==
X-Forwarded-Encrypted: i=1; AJvYcCXs5D88qXhRg+EjXQcwnI/rOMyFowfAlVHwJkWQ9cDGs5bSyTaxDATURwEn734MOvEyTrT8phdyykAQ7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEJIBK6UXGMMNLlLc1Z8bD1eCQkcGnK1S6xBZsc9dw/NnzGDi4
	G1A4lFxLUGtIgrT/Wb93gDkLiT4R7yHDGqJ+Cfdl43cOtFBXL4KHePi4unnYeTtGolKfXmyyPmT
	EJBa1IDnh2acHbmjwkeedotTxX/LVmexcmLQYrDa9NJ5R+3quYz8DJBv6yovpwHfmEJSp5QgOqa
	1vDP0NM3JWWRdTKrgNcPjCWXLQZfBJdaDwyx1wKaw=
X-Gm-Gg: ATEYQzzuJJRNYavn7uiyh0MdoLIvmUNRflF+qvtMG3GLB0xGaY9hSazvO3D+8w5SPBj
	+ZjIY3KRq36xk+Dj6/TZFWU9u2GYATcH+uDc63RC9QiZVQ8ixTQYbRd7WqyyAPtmlfh62N9ne/U
	vw8PgtlNku8j4H53Zggl8F99f5Xfj0SwzFLpAlLUsoyGAay4jJdBCJBKRxOJ0SOH8vrTVeIIB3N
	AD1S8RxvgqOYNYKoVs7TP3fr4i+afAh5Jv1BeE=
X-Received: by 2002:a05:6102:6ca:b0:5ff:bbc1:50a7 with SMTP id ada2fe7eead31-601df72aa68mr781428137.15.1773225805998;
        Wed, 11 Mar 2026 03:43:25 -0700 (PDT)
X-Received: by 2002:a05:6102:6ca:b0:5ff:bbc1:50a7 with SMTP id
 ada2fe7eead31-601df72aa68mr781415137.15.1773225805639; Wed, 11 Mar 2026
 03:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZ0SbIqaIkwoW2mB@fedora> <5cf75a95-4bb9-48e5-af94-ef8ec02dcd4d@suse.cz>
 <724310c2-46a2-4410-8a5d-c69dcc8de35d@kernel.org> <aZ7BbosIr2FvZFAe@fedora>
 <c6a01f7e-c6eb-454b-9b9e-734526dd659d@kernel.org> <aapeVb_L5zohWRRe@hyeyoo>
 <d5cd4eb4-1703-41af-9c71-842ae33edbdf@kernel.org> <aaqq7YmUcOht3GWH@fedora>
 <abDA9UrJBT1wXh22@hyeyoo> <abFA17ZmsW6RgcYI@fedora>
In-Reply-To: <abFA17ZmsW6RgcYI@fedora>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 11 Mar 2026 18:43:14 +0800
X-Gm-Features: AaiRm506C_nISMUep0Od2dqpUzuzhQzDUy4U2M3p2Tx9SR_kxDokMrc0Dva4Nao
Message-ID: <CAFj5m9KutWuGfPN4cfAd-CjFNTCC+fLw0DtMsFFQrRBEeK-8LQ@mail.gmail.com>
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
To: Harry Yoo <harry.yoo@oracle.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Hao Li <hao.li@linux.dev>, Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 6:16=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Wed, Mar 11, 2026 at 10:10:13AM +0900, Harry Yoo wrote:
> > On Fri, Mar 06, 2026 at 06:22:37PM +0800, Ming Lei wrote:
> > > On Fri, Mar 06, 2026 at 09:47:27AM +0100, Vlastimil Babka (SUSE) wrot=
e:
> > > > On 3/6/26 05:55, Harry Yoo wrote:
> > > > > On Thu, Feb 26, 2026 at 07:02:11PM +0100, Vlastimil Babka (SUSE) =
wrote:
> > > > >> On 2/25/26 10:31, Ming Lei wrote:
> > > > >> > Hi Vlastimil,
> > > > >> >
> > > > >> > On Wed, Feb 25, 2026 at 09:45:03AM +0100, Vlastimil Babka (SUS=
E) wrote:
> > > > >> >> On 2/24/26 21:27, Vlastimil Babka wrote:
> > > > >> >> >
> > > > >> >> > It made sense to me not to refill sheaves when we can't rec=
laim, but I
> > > > >> >> > didn't anticipate this interaction with mempools. We could =
change them
> > > > >> >> > but there might be others using a similar pattern. Maybe it=
 would be for
> > > > >> >> > the best to just drop that heuristic from __pcs_replace_emp=
ty_main()
> > > > >> >> > (but carefully as some deadlock avoidance depends on it, we=
 might need
> > > > >> >> > to e.g. replace it with gfpflags_allow_spinning()). I'll se=
nd a patch
> > > > >> >> > tomorrow to test this theory, unless someone beats me to it=
 (feel free to).
> > > > >> >> Could you try this then, please? Thanks!
> > > > >> >
> > > > >> > Thanks for working on this issue!
> > > > >> >
> > > > >> > Unfortunately the patch doesn't make a difference on IOPS in t=
he perf test,
> > > > >> > follows the collected perf profile on linus tree(basically 7.0=
-rc1 with your patch):
> > > > >>
> > > > >> what about this patch in addition to the previous one? Thanks.
> > > > >>
> > > > >> ----8<----
> > > > >> From d3e8118c078996d1372a9f89285179d93971fdb2 Mon Sep 17 00:00:0=
0 2001
> > > > >> From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
> > > > >> Date: Thu, 26 Feb 2026 18:59:56 +0100
> > > > >> Subject: [PATCH] mm/slab: put barn on every online node
> > > > >>
> > > > >> Including memoryless nodes.
> > > > >>
> > > > >> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > > > >> ---
> > > > >
> > > > > Just taking a quick grasp...
> > > > >
> > > > >> @@ -6121,7 +6122,8 @@ void slab_free(struct kmem_cache *s, struc=
t slab *slab, void *object,
> > > > >>        if (unlikely(!slab_free_hook(s, object, slab_want_init_on=
_free(s), false)))
> > > > >>                return;
> > > > >>
> > > > >> -      if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) =3D=
=3D numa_mem_id())
> > > > >> +      if (likely(!IS_ENABLED(CONFIG_NUMA) || (slab_nid(slab) =
=3D=3D numa_mem_id())
> > > > >> +                      || !node_isset(slab_nid(slab), slab_nodes=
))
> > > > >
> > > > > I think you intended !node_isset(numa_mem_id(), slab_nodes)?
> > > > >
> > > > > "Skip freeing to pcs if it's remote free, but memoryless nodes is
> > > > >  an exception".
> > > >
> > > > Indeed, thanks! Ming, could you retry with that fixed up please?
> > >
> > > After applying the following change, IOPS is ~25M:
> > >
> > > - delta change on the two patches
> > >
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index 085fe49eec68..56fe8bd956c0 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -6142,7 +6142,7 @@ void slab_free(struct kmem_cache *s, struct sla=
b *slab, void *object,
> > >                 return;
> > >
> > >         if (likely(!IS_ENABLED(CONFIG_NUMA) || (slab_nid(slab) =3D=3D=
 numa_mem_id())
> > > -                       || !node_isset(slab_nid(slab), slab_nodes))
> > > +                       || !node_isset(numa_mem_id(), slab_nodes))
> > >             && likely(!slab_test_pfmemalloc(slab))) {
> > >                 if (likely(free_to_pcs(s, object, true)))
> > >                         return;
> > >
> >
> > Hi Ming, thanks a lot for helping testing!
> >
> > The stats look quite fine to me, but we're still seeing suboptimal IOPS=
.
> >
> > > - slab stat on patched `815c8e35511d Merge branch 'slab/for-7.0/sheav=
es' into slab/for-next`
> >
> > Does that doesn't include Vlastimil's (fb1091febd66 mm/slab: allow shea=
f
> > refill if blocking is not allowed)?
>
> No, because fb1091febd66 isn't included into `815c8e35511d Merge branch
> 'slab/for-7.0/sheaves'.
>
> >
> > Next time when testing it, could you please test on top of 7.0-rc3 w/
> > the memoryless node patch (w/ the delta above) applied?
>
> IOPS is same between `815c8e35511d Merge branch 'slab/for-7.0/sheaves' in=
to slab/for-next`
> and 7.0-rc3 with the two patches.
>
> IMO, it should be more easier to compare & investigate by focusing on
> 815c8e35511d, given there is only 41 patches between v6.19-rc5 and
> commit 815c8e35511d.
>
> >
> > Also, let us check a few things...
> >
> > 1) Does bumping up sheaf capacity change the slab stats & IOPS?
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 0c906fefc31b..5207279417e2 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -7611,13 +7611,13 @@ static unsigned int calculate_sheaf_capacity(st=
ruct kmem_cache *s,
> >        * should result in similar lock contention (barn or list_lock)
> >        */
> >       if (s->size >=3D PAGE_SIZE)
> > -             capacity =3D 4;
> > +             capacity =3D 6;
> >       else if (s->size >=3D 1024)
> > -             capacity =3D 12;
> > +             capacity =3D 24;
> >       else if (s->size >=3D 256)
> > -             capacity =3D 26;
> > +             capacity =3D 52;
> >       else
> > -             capacity =3D 60;
> > +             capacity =3D 120;
> >
> >       /* Increment capacity to make sheaf exactly a kmalloc size bucket=
 */
> >       size =3D struct_size_t(struct slab_sheaf, objects, capacity);
>
> IOPS can be increased from 24M to 29M with this patch, against 7.0-rc3 wi=
th
> Vlastimil's today patchset.

BTW, the improvement looks unstable; sometimes it reaches 28=E2=80=9329M, b=
ut sometimes
it doesn't, just 25=E2=80=9326M.

Thanks,

