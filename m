Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58351531E8
	for <linux-block@vger.kernel.org>; Sun, 16 Feb 2025 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739743809; cv=none; b=FBQtDwC/YWvoHT6RT4pxw6UY1GWdYsirCpPfLtJkkKOpwbgoMUZ4ScapLzoj160S/i0JWPzv8/+kr7mOD7sKSMXpAigt2AmtoRUUc5gE6fIeIXUAMZietKOf2l/cDIx5F9mVaQHIWJs02CeWY0YAbTX5AGBreb4seMADK66kq1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739743809; c=relaxed/simple;
	bh=CkdBIOfKGyvQNLz9XBICP6Cd3ZJnuGzuaK1x7Dkc5PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jpp8kuNJnGBiF7vfuFa6S5H96r0fK4mGBvm1Op8jRg5dP4zRZUwwUuF8ZfJ5OFx/luabeM4geq+htZ0SR8mkoZJJFmeTU/bDQgp+7QADS3IUPuShZDy3HmkXKq5cLRZmECxaqNqgkf9hARLqbdg+rXpXQFnHYNYMuRewwBw9IhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HBaAI/b4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HBaAI/b4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22134a64d8cso613455ad.3
        for <linux-block@vger.kernel.org>; Sun, 16 Feb 2025 14:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739743807; x=1740348607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svEMB+fuQjKggY6D7PQDoMNSfyDP3hVbtjvNOR1UMfk=;
        b=HBaAI/b4+yF0c6+QSIhqO/C7Car6yEXdyHCb/Tq54ACJZaj75IKY+LM1qLkF6fGYXW
         IDtV9/kPiIXoFjaqBuVfv+/r/lZJkqQzowP9hZjfL6CmmOOYESz09BdiBNJVBqKiOslh
         n4GkFRXzbSkDPOaTSW84iTj2MGdNINbs4nj2EDHb+8lrkEaR3LUQHzN3i7xjqjlkdIiE
         g8544jHy7/z+VRHkwVbrAVur0kfeb+blV7y5xPZLuhBrWZPyVctwn3Aux+UuPR5tDT5x
         6l/zGPMyGaVWQTtmfmve1Ki6fLL6nrlY3V++K9N22k64D3hgftfWxMpoo4I5LqnwYsHL
         u1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739743807; x=1740348607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svEMB+fuQjKggY6D7PQDoMNSfyDP3hVbtjvNOR1UMfk=;
        b=EOkBrz7WB28Cyg61VHODovHvuRDkb4Udvday0Aa82+bXFc6DmiPxEx8q9itL4JscZ4
         aQdbgvVSIa19jRuZ0Nj0OPrRMTJ9vGDZgOpS4z2KHfNWASgs8SMBFxxudY0ijWP7GTYB
         QnI14fms+CBE5pTocc3ii8MVxfepmze9m+AWav+zeEQfgHgF5JIt6XKBqtK1/z0iX78w
         ReOoAlxJkTHthB4nQbLZYP7/KYwjP1wV2ZB5T0sZgj5ye+WysG2yth9FRtONz1RN+CZZ
         hMCdpAqvsAhZyIB8ObjpBbof6A6ieZdSxAQiStrzeW89aCbaomFcvF7oR+KXhTSZKDAf
         tLPg==
X-Forwarded-Encrypted: i=1; AJvYcCVogfGrfsS4y+63oLZq+rYdlbzya9PtTm+1Mam2KhemeFtlpIaKzxeKwE/QhJKb6bxFRi1/6aFv5dKTaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy20r/TwW6JBy1YCw41NHVh2YjvvAow8mdphjLebuzSGNTkz1Fd
	qR0LtqVZnG/KNAT33OXWOvTKzJkxY5hNsQX4vcbVXVXd8eVCDT3RdX0yW8/IS9EwRHq9R1QDM5M
	BpxEiAio9mhTzhChzNbqT61ZpxTwcq102eM2d5A==
X-Gm-Gg: ASbGncuQlORx0DEEXK2DgyAaQDiRQjQwUnduVxsL3h0uZpygxoAMo1fKP+PYmeVgeSB
	BO/5oifFkVuDu6SDDte4hx+glhQj/60fFbtBVjuvkL7Ht6i7eRmgYGa2uK+mQ+Nk1qb4l63U=
X-Google-Smtp-Source: AGHT+IHCf1cwz26/6LxZ3CgT7yLxo7A7C8mkN6znzDdjrY4sVFLTH8/84ue7tK2yeT71neju4p2OUL2rCwmBq7xpdnM=
X-Received: by 2002:a17:902:c94f:b0:220:fce5:977c with SMTP id
 d9443c01a7336-2210402b42amr43550165ad.8.1739743806990; Sun, 16 Feb 2025
 14:10:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214193637.234702-1-csander@purestorage.com> <20250215115144.6a10dad8@pumpkin>
In-Reply-To: <20250215115144.6a10dad8@pumpkin>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sun, 16 Feb 2025 14:09:55 -0800
X-Gm-Features: AWEUYZkBZVk86ijik-PVUaU2vN0hDwMhamyD4byjIJ94_ZBdHz98lnubONZNZqE
Message-ID: <CADUfDZqjDxLctcSpBzjxu8fN9NjrMq9JvKZeJOB__9ZrjyEOOg@mail.gmail.com>
Subject: Re: [PATCH] block/merge: remove unnecessary min() with UINT_MAX
To: David Laight <david.laight.linux@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 3:51=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri, 14 Feb 2025 12:36:36 -0700
> Caleb Sander Mateos <csander@purestorage.com> wrote:
>
> > In bvec_split_segs(), max_bytes is an unsigned, so it must be less than
> > or equal to UINT_MAX. Remove the unnecessary min().
> >
> > Prior to commit 67927d220150 ("block/merge: count bytes instead of
> > sectors"), the min() was with UINT_MAX >> 9, so it did have an effect.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  block/blk-merge.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > index 15cd231d560c..39b738c0e4c9 100644
> > --- a/block/blk-merge.c
> > +++ b/block/blk-merge.c
> > @@ -268,11 +268,11 @@ static inline unsigned get_max_segment_size(const=
 struct queue_limits *lim,
> >   */
> >  static bool bvec_split_segs(const struct queue_limits *lim,
> >               const struct bio_vec *bv, unsigned *nsegs, unsigned *byte=
s,
> >               unsigned max_segs, unsigned max_bytes)
> >  {
> > -     unsigned max_len =3D min(max_bytes, UINT_MAX) - *bytes;
> > +     unsigned max_len =3D max_bytes - *bytes;
>
> More interestingly, what stops *bytes being larger than max_bytes?

bvec_split_segs() has two callers, bio_split_rw_at() and
blk_recalc_rq_segments(). In both, *bytes =3D 0 originally.
bio_split_rw_at() has another code path which increments *bytes, but
it makes sure not to exceed max_bytes. So when bvec_split_segs() is
called, *bytes <=3D max_bytes. The logic in bvec_split_segs() won't
increment *bytes by more than len, which is at most max_len =3D
max_bytes - *bytes. So inductively, *bytes <=3D max_bytes before every
call to bvec_split_segs().

>
>         David
>
> >       unsigned len =3D min(bv->bv_len, max_len);
> >       unsigned total_len =3D 0;
> >       unsigned seg_size =3D 0;
> >
> >       while (len && *nsegs < max_segs) {
>
