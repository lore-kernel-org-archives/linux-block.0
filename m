Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795703545;
	b=qnJiSV9CawVKn7sZrI9EB1T8rOgnlGqp14xlgYQn3r9nwp2fE6Clmdc4Herv64Tc+k/l
	 sprck7lreYe31S1AY4Q5jt3IltwpERXXa+otBN/dZ4m0/ymE78sKIZvTqne8Yz0IKDh8/
	 1xK9URx1cR5W734fVdcwKQmpQ4wrzGn7yoxj8qh03/oCU2YjpOhWSqVVvku7KDlxrbhh6
	 Q5V0oH9UsO4ZEa57gDy96IAcC/hYxUcxKCHEQakVuowv13z265LH2VfFCMZIVHjY1PZ+c
	 7k4+f+WbYu57nZuI6MgQowjIXVyruJ8f/JoIK5fCVx++dUKV7oC6oio5z6tnHBIIGVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703545;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZBcNEAgJHSy4LVa0EEBy71Jr78O+HkW/q/nH1NNGyoc=;
	b=RmXo8R4J5TukPW3sxvcR5+FZ5M49TCrqCRIGp85B66dQ5vY9K1x+nOsz4R4Cm47LRYkn
	 ww0D18YxyBVR2SdwfBEujkXzK0zLTm65mfmULhNjdfxGzD0qF25lyvfGruz5ix87qFe61
	 7P9RzRm/GGGmPB9pPBZE7imx8hVly+dwAwz58l4MPRUunYmqCxXU0ZDSHB7xY5tApttfG
	 z3Y5R6+Xrh31GfC9r0kwa/DNdlclWNYt3Y5Jpx5HJiXyHOZjjWx0TZNv0GfAKp9L7XGtO
	 PfU61HacoDqZXIcfFNmMKvQjinE0GaFz/bf/IRpjsRp5FS3FEynHy4o+u6vlC8caeCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="dWhkAlm/";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="Fdc8w//Y";
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B1B606A33C
	for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 14:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0B1B606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dWhkAlm/;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Fdc8w//Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795703544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBcNEAgJHSy4LVa0EEBy71Jr78O+HkW/q/nH1NNGyoc=;
	b=dWhkAlm/rgUPJl3OyPpQzb7XCB7dWuPSJ07TXheuGSFN2uVe3I9XU/TzKF4kp+gW8Wzogo
	PTZD2ssp9kGpNZENFnJXmKpiZF6/3WyyuvtQBWSB2Zs1Z9N8pKOsk/IyZEj3XZVQYyZzia
	SFa3Kx2DJbJT7Un3EZazyg7sPxAXlLk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-TYPOxy8YOmazmOKOhpI03g-1; Thu, 26 Nov 2026 14:32:22 +0000
X-MC-Unique: TYPOxy8YOmazmOKOhpI03g-1
X-Mimecast-MFC-AGG-ID: TYPOxy8YOmazmOKOhpI03g_1795703542
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b155f4eb8eso90486657b3.1
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 06:32:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795703542; cv=none;
        d=google.com; s=arc-20260327;
        b=XLc89PJ8jQcpN4PHQ4lulMV1aykYgBpUHXAZvZ9XS420EWsvBGVBnumSKQ474kguTf
         LyP/EgCaCqLqi831Zy1xDMz8TfkSs0w9OOkUmnJVJTVpslStZk42sT0YOfPm/xlgAppq
         V+8LxN2JuYEwH2huBVMyLgEPPk9jZrz3c6fZ+YdAZCz8BiBPbXsISHXr9kwBSZRt3put
         oxVgLgVGWIiHD2H9oXnNCIs4W3qV97UMJiAMp7SFSSPle8d0upRkMxqqJ8JkOaVet6oC
         VaDjKA/Mbd9iRT0jkfRR9lyrrNtb1XFWe/2rU5ZRcoy8Isqzr3mWYFikEjFexym37gOH
         6okQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZBcNEAgJHSy4LVa0EEBy71Jr78O+HkW/q/nH1NNGyoc=;
        fh=VPgnVVbbITRUjd70WkxHUvQX6iXtZV891psKK+OqDls=;
        b=funDLum0LEBvmimTaRwklpU4vB3mXmQ/ER09NCIiraiJW4d75fItvPGC+7iiu1vN2N
         8XgXDnoQ1bhbZi3SL/dAyPOiFbHIc/fIE+ILAMELpFrxUR5hW3d7Bx4r9iCRXZZuNxs5
         JNM7+a7cUAFd/E1S0QGS6TR0kb9+hYvduuIAgEx52MSbeO1Qr2Y+uWdY/335qdVn+Hq5
         uFpZIi0F0BpH3Vv4wmvFNiowBy0SEAJJknGyrzBlHQHcGl+m1mRF93mvKl+dDfsXaCJk
         uL74vy2ABIBGBxWAzQ8IdqhxsHL/b1EXqDR5B+l4/CW5sPF+gQVrc/z1CbvoSX0w0Khr
         s1Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795703542; x=1796308342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZBcNEAgJHSy4LVa0EEBy71Jr78O+HkW/q/nH1NNGyoc=;
        b=Fdc8w//YNylRYTgp3cBPTd7FLmYATXlhmIjx7+kk/wpol7/xAounyKoWGynThmkm83
         tIbvCoFJo73T33f88/UrNsMt98Mwst1bGbKiCMPN7c31Y6FcNdpiekFxHyRg+5ocBaCP
         huWBfwDVuVMwv4ctZrQiA/jssje6PeylhvY1Ze4f5q8DTel5PrBNLO8Xc8mEKFiLWdcp
         Vees3NCihAHQcEZ2ehY0jSnCBA1K69HI61XErCj946a+UvqvDEY/YRJQYSmMWMzxO4la
         2waK/jcvb1feVrw1hnr/YTzYLiMxsgT0DSYoSg+sHX1bRtyF9UeEjdQCv+BwnZKzJ/ap
         dbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795703542; x=1796308342;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZBcNEAgJHSy4LVa0EEBy71Jr78O+HkW/q/nH1NNGyoc=;
        b=Jm91zUsefvDhLP9tIqxwHG7efh4LCdWlGNVLzEbyNiqG7yzzPdQ22NQUJvLTG2GXmX
         zomqXOOH2tWL0/7yr3nZFacNFCbgVVAlQzkyjKWrMnt2eezYczzroiW1qkw7z6YdMqJh
         SDHA3AOr7/KBDB98TIp9nemTGpoxiUdgSksDm45t0+3XgOG/r/QM3G+jHBRoX1vdV4dL
         cuZY52Xy9RVO5MIF5XotcXR6Hc3i28mpobJl7eKDTx2u74G9ifhrYQkgOdjOZJJUtZhK
         JX9YqFVonLJAD1CvEb+GL6FOU0UimQYUh2bvj30HT6FDiHdDn37XNgX60BFxvDbxiNsE
         Jf+g==
X-Forwarded-Encrypted: i=1; AL+hErHPBdHo/vxFW2Kw8gQFQjQDQZ0tQuXHshbk8ov2t2ZpsvgooraESx5yMuXzp116B0YCxIVJG4v0kc64eQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8x+tSyC65J/ocaC/vTjibvHLRHsIom+m0P9F8dzD3kCw7KqCXX
	Cr9u4//cr6ig6xYxkOYx3urIYrKJuBMRFGtWO5NTVQlpl5mt+mNzGL7wCviYi6/AYc2wanOI8LX
	4bFoN0tYI2FwlGPKMcSDF21clgo9NjlNsZOqKSevB+F+Z1OEKNtmeIz1NWtN75QO0zajJK9+jTR
	18eveKh2rFgL/6ZHIVaS5OM/AvXxN1x+FGmZm4iQE=
X-Gm-Gg: AZFdTZevU6qVrTU0RAZBqPRC6UWSj4uzPHonKTHpjGA3ERK6gM2orWh+zWNmjVxUAFd
	G8YcsTRRQyR+XKEwSi+Azz1Z5LVSvkpIufbdEtnIWARWsrzovh+45n9GbDVSY2RgjCxXS7BAFC/
	uZF7l67qO6sw6JhDQHEi62zmoyk5+zyS/wmC/PQMhlFKawtX78tCVbAo2QpKEnY4QgZz864BLBe
	GE8H1JNf+/bKBmoomWpnPHH1O269ZqssM6DRuHSnWBvSw==
X-Received: by 2002:a05:690c:7349:b0:8b4:fc2d:2fbd with SMTP id 00721157ae682-8b52042becemr71775697b3.22.1795703541321;
        Thu, 26 Nov 2026 06:32:21 -0800 (PST)
X-Received: by 2002:a05:690c:7349:b0:8b4:fc2d:2fbd with SMTP id
 00721157ae682-8b52042becemr71775297b3.22.1795703540562; Thu, 26 Nov 2026
 06:32:20 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125091157.1822521-1-huangsj@hygon.cn> <CAHc6FU4h-FRvLkO_0ouTey9MbX=n61t3abt4hPNFOthsRGG9mQ@mail.gmail.com>
 <awgi6a0Hayug7RJH@hsj-2U-Workstation>
In-Reply-To: <awgi6a0Hayug7RJH@hsj-2U-Workstation>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 26 Nov 2026 15:32:08 +0100
X-Gm-Features: Aa3M54qEByO_EHNX8OHGBPouiZLwpLPKlFRFRV9aYOI6i2TAngEySFHZ6dr1dD8
Message-ID: <CAHc6FU4KLxzoQ6NJQUnFfcbKufqwqdhfcGhva9V44K=J7HCXRg@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] vfs: add inode iteration methods
To: Huang Shijie <huangsj@hygon.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	hch@infradead.org, mic@digikod.net, axboe@kernel.dk, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, legion@kernel.org, 
	aleksa@amutable.com, libaokun@linux.alibaba.com, ebiggers@kernel.org, 
	djwong@kernel.org, sandeen@redhat.com, zhongyuan@hygon.cn, 
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, wujianyong@hygon.cn, 
	shijie8@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Nov 2026 at 13:20, Huang Shijie <huangsj@hygon.cn> wrote:
> =E5=9C=A8 Wed, Nov 25, 2026 at 11:25:12PM +0100=EF=BC=8CAndreas Gruenbach=
er =E5=86=99=E9=81=93=EF=BC=9A
> > Huang,
> >
> > I have some thoughts ...
> >
> > On Wed, 25 Nov 2026 at 10:18, Huang Shijie <huangsj@hygon.cn> wrote:
> > > This series adds a superblock inode iterator and converts the open-co=
ded
> > > sb->s_inodes walks in the VFS to it.  The design follows the cursor-b=
ased
> > > construct proposed by Christian Brauner:
> > >
> > >   https://lore.kernel.org/all/20261120-mitverantwortlich-drehbaren-ka=
ntholz-241300d20168@brauner/
> > >
> > > and is the same direction as Dave Chinner's patch set:
> > >
> > >   "vfs: improving inode cache iteration scalability"
> > >   https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbi=
t.com/
> > >
> > > The caller owns the iterator state and drives the walk itself:
> > >
> > >   CLASS(sb_inode_iter, iter)(sb, eligible, priv, flags);
> > >   while ((inode =3D sb_inode_iter_next(&iter)))
> > >           /* do stuff */;
> >
> > The pattern should be:
> >
> >   for (CLASS(...); ...; ...) {
> >       /* ... */
> >       if (/* end iteration early */)
> >           break;
> >       /* ... */
> >   }
> >
> > so that the iterator goes out of scope immediately when the loop ends.
> > Hide the details of the loop header in a macro and that this becomes:
> >
> >   for_each_inode(inode, sb) {
>
> The fs/jffs2/build.c has used this for_each_inode.
> Maybe change to for_each_sb_inode?

That's the least of all problems; just rename the jfs macro.

> >       /* inode is referenced and unlocked here */
> >   }
> >
> > Use that to convert the simple cases.
> >
> > And then we've got preconditions that are checked while the inode is
> > locked. Those can probably go in an expression:
> >
> >   for_each_inode(inode, sb, expression) {
> We still need add flags here.
>
> In evict_inodes() and hook_sb_delete(), only the expression is not enough=
.

I know, these are the two cases that check i_count before the inode is
even locked. Leave them as they are for now; we can get back to that
later.

> How about add a raw code like this:
>
>     for_each_inode_raw(inode, sb, expression, flags) {
>     }
>
> And add a macro for_each_inode:
>   #define for_each_inode(inode, sb, expression)  for_each_inode_raw(inode=
, sb, expression, 0)
>
> Most of the cases, we can use the for_each_inode.
>
> But in the evict_inodes() and hook_sb_delete() we can use the for_each_in=
ode_raw.

No. Convert the simple cases first, with iterator constructs that are
as simple as possible. Later, worry about the more complicated cases.

> >       /* expression was true */
> >       /* inode is referenced and unlocked here */
> >   }
> >
> > This unfortunately cannot be implemented on top of the
> > sb_inode_iter_next() pattern, at least not in a reasonable way, so we
> > actually shouldn't use that pattern.
> >
> > The locked iterator would look like this:
> >
> >   for_each_inode_locked(inode, sb) {
>
> I tried this way today.
>
> The macro for_each_inode_locked is complicated.
> When I tried to add more hooks to super_operations to implement the
> procfs issue, the for_each_inode_locked becomes more complicated.
>
> BTW: the procfs issue see the link:
>   https://lore.kernel.org/all/20260920072811.2064247-1-huangsj@hygon.cn/

Introducing reasonable inode iteration constructs is a completely
separate problem from introducing per-super block inode iterators.
Please keep those issues apart.

> >       /* inode is locked here */
> >   }
> >
> > This doesn't cover all existing cases, but that's okay. Don't force
> > things into this pattern that are not a match.
> >
> > We can always extend things further if it makes sense.
> >
> > > The lock does not span iterations.  sb_inode_iter_next() takes
> > > sb->s_inode_list_lock, takes a reference on the next inode, drops the=
 lock
> > > again and hands the inode out; the reference is what keeps the cursor=
 on
> > > sb->s_inodes so that the next call can resume from it.  As the iterat=
or
> > > is a cleanup class, a caller that breaks out early does not have to c=
all
> > > sb_inode_iter_end() explicitly.
> > >
> > > Two optional channels let a caller keep its own state instead of fill=
ing in
> > > a shared context:
> > >
> > >   - iter->eligible is called with inode->i_lock held, so that a calle=
r can
> > >     reject an inode before a reference is paid for.
> > >
> > >   - iter->status carries an error out of the walk.  Setting it to a
> > >     negative value makes sb_inode_iter_next() return NULL.
> >
> > Nobody needs that. Just break out of the loop.
> >
> > > Most callers just want a referenced inode and use no flags at all.  T=
hree
> > > flags cover the walks that need something else:
> > >
> > >   - %INO_ITER_F_REFERENCED restricts the walk to inodes that still ha=
ve a
> > >     reference, preserving the "only handle referenced inodes" rule of
> > >     landlock's sb-delete walk.
> > >
> > >   - %INO_ITER_F_NOREF hands out only inodes whose reference count has
> > >     already reached zero, and %INO_ITER_F_NOIGET suppresses the refer=
ence.
> > >     Neither keeps the inode alive, so the caller has to make the inod=
e
> > >     unclaimable itself.
> >
> > No flags.
> If we do not add flags, we cannot convert the evict_inodes() and hook_sb_=
delete().

No flags.

> We'd better convert evict_inodes/hook_sb_delete this time, and then
> we can add more hooks to super_operations{}, such as sb_add_inode/sb_del_=
inode/sb_iter_inode.
> With these hooks in super_operations, we can add more optimization code f=
or different FSs.
> For example:
>
>   "vfs: improving inode cache iteration scalability"
>   https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbit.co=
m/
>
>   and
>   https://lore.kernel.org/all/20260920072811.2064247-1-huangsj@hygon.cn/

Right. One step at a time, please.

Thanks,
Andreas

