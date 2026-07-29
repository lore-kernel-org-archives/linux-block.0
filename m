Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49009285CAE
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 04:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785299575; cv=pass; b=gBLnqeTXjQL87pS+BRnR3zyCpjqB/rlZInDXEO/fuGd4AkYpgs4MD0R+C6war6WMTYiV+0Z2mmZoJGgVFb2WGcbGyxSwuyUrNiTsaz3UE9wzvx+EyopmJjyS9upAHZpgoAbuYT8L0CACSu64yj/FjVgHnPpnEwu+WjTv5gDpwIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785299575; c=relaxed/simple;
	bh=NCDu57/OAk0Skqrrys9FPJEDDMrY+lWRuumooiW8V24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4kre+sHsSV0cFD9e0W2FrVx3JvTNFQ41IOk0zWLCXot9sswQdK0n0tlxwB5t+yrr/NqXowkNwGKbxp4Cs/WfWVQ2PtPe3mQE3VN+CWPv1L169tU5IgieXtBXtBTL87IH0kVlkUhDH8EceXvz41raZrsKz/jqdVQqb0/OTkfOs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IK1I815W; arc=pass smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK1I815W"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c159467cca6so16021166b.0
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 21:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785299572; cv=none;
        d=google.com; s=arc-20260327;
        b=qz/sQF5umURjz3lYulffFxMSAtdnZgXeAdCoKLeL6msiqG6HmeR6luKKOI7ua1OIP2
         1UYh0BxNIQXBFk5J8H+nt62oMRehvCzp1xcmrmonqn0WIGvdbgP15KQJLBAkmIfV0A6g
         9tsTHONrEe/0/sVKGU8LEG6vkelcEZu9yZLJJiTFvmx+BkHsR2Cx3jpks4Kj2LyBXk5R
         vIKNtAS0vHpElv6M0KdVVj9/EBxKDkpFy7So5wjjVn4foqm3vcRSz8uqDWimJIueVjgn
         ElVd1QtSbj6q/NlKkoE7XmIWnJr7T7b/v+u8nEM8OTwl6V5Xv27x0xNaoItMw3HWUcnz
         sllA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ThKr9LA3UdkIRwXYmipZ/MXcVOpNhwe8tyVr42slfkk=;
        fh=ZyCyIYxGu6fdUQx19J2mYZ4uLtsfbHDScJEtabAgUpY=;
        b=pzoZTw1X2BJwtX1LzqNyjraZVugXU+/bw90dZKwoquhBORdWFTR1nfEIIAvM6gBvN1
         iXpfxA7oinL8Ve53V2FddJ2RHbYeKjAVib8+gGIH8RAeFrX3LsENH6DrEIMNt4z+LJQg
         bQCvYmvGMMWI5Ocl3xYtr5MV34xE9bvPl9YvntCQkrT7ynTgoRwqw+MIMq/NNRFMIh6q
         4Qc2dc5s4JpSwkGouvuTpUXUa2EK35yoO1aukElocpGJa9HWXhRI7a1T2svX0h9yZ+6/
         IawSGxMJT9yQ+0uoDIRcPULN1adVEHXzIAWYclNxin+ts6OYIE0uvUlgIu2Gl2H320xC
         mdpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785299572; x=1785904372; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ThKr9LA3UdkIRwXYmipZ/MXcVOpNhwe8tyVr42slfkk=;
        b=IK1I815WcF0f4UCs5P8Az6nLeeNwuR16p6LkZoqGE4e/BYrARY2TMsokkLM65jSfnA
         MAOCrs5EvRDKIU4tViNB7W1ghp66hR+d22vbDZ1vlpoOkbKipSQUaufr/WeKwVhnDk4o
         4Kc0q4F/fQwo8r57Si9op2sfkVtM3RJUod1BSw+M+BC1i6QEem712hnswL9jbbj48NFM
         cry3IjMDzx/QIh9SfNidxMj1UoSj2ZXX3Uoyb983//g85Z9RCsYCeHLg44uOtlzT0tEy
         WqE2YMn5FpWT3z4ImTKmEs3YDCYHTEv5SAJ6hIufDjelGY6tB1zj67Vs1NIWjOKDrWdu
         5UsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785299572; x=1785904372;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ThKr9LA3UdkIRwXYmipZ/MXcVOpNhwe8tyVr42slfkk=;
        b=fnVPoEWl2+p4bN4bOY7EI8dP3GB+WKAowTY1Hrwgvv+hSCCEEtX7jidLfTlBtrjdzR
         7l1l/GiEraT6AS5MNVHx2iQqmhqQhMcUtYtkximVL6JgB/se2uSuCHJ0lAdMQogxySd2
         EdWR1w9OFl01YyOYmutssippR7j8LVjzUNN6lR6W9zY8yYOSGDZW4lcFHPHOUU4ha45l
         BVI6z8lVaUsaQlTrkM4lYK1ag2hnQNuI7WPJ+DmlJlQK35sc54xjSlT+6BuM1PLp4f2S
         3S848cvHy8S/78m6LNoAFkgm6FBuy4FaUHJChw66U/Lq6fYCgwlJPRqRZNF9e7v4CcrF
         GWeQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr0LTXNPRryRHildenV91AkVUNfOcl8DPtN3GowzsqSNenQQxbADO6MeBrJ5fcy5FCEl/PH0nfNwO1XSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ZxYBY85RFedRJHjYuOSZF8PaYkrHGWtffZAyF0zSUZQ1bgnI
	+5eh+GA0oQHSgNO8whTZNEBBt9PPp2e7RY32QIt9Icjg2zSi5dkUii4hmwC9Y62vsRdf+gb8ba9
	bhlOqQItxtaaMvd88XzZPVVqPNQ58iOY=
X-Gm-Gg: AR+sD12Pqltodkc5hNUzoohp1SBTthHLV8K5bWS0ZDb+GtW6tqIWKl2/jOsf0fSdZn+
	6svog0T9fjsUjFzmcN+v1UUlq5iEPQjVJ8zNvuS66pCZi/U2OP04HnDVwnVWkFyFcFCq5JRZpF0
	ek/vGCTfFQxao3oHFPLR6YoeGJkeaAtoPvZttycXJGMdRDN8aNdDIrOXcCv5Vg3W6wBI1iakJO0
	fjFP8huV/ijv7DDQNYsxcX0hAJUHA2hwCO++AcF/gsuIcqghHyh5utLFNfw8S3tHrizkuvnZGkY
	SDudpOt+HTrJtSpmKme2F6cCZPGQOspkqNsxT+cYa60QEx1v6a+Uj4RN
X-Received: by 2002:a17:907:a684:b0:c16:5cdb:9f89 with SMTP id
 a640c23a62f3a-c1f724ea507mr262299966b.64.1785299572277; Tue, 28 Jul 2026
 21:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com> <20260728092935.31139-3-haoqinhuang7@gmail.com>
 <amltU9PgLGZYCD-1@google.com> <CAEjiKSkotZQAwUGgAggpS0Ar8Ewo5suB1kDssDK7jw=1w7xDoQ@mail.gmail.com>
 <aml_aEB6BDBqgIRH@google.com>
In-Reply-To: <aml_aEB6BDBqgIRH@google.com>
From: haoqin huang <haoqinhuang7@gmail.com>
Date: Wed, 29 Jul 2026 12:32:40 +0800
X-Gm-Features: AUfX_mynGnuc6sv-ceJYto-arq136TMav-sQ_OW5MDtgNlL-Yzy7Gup1WuFAZJg
Message-ID: <CAEjiKSmLSrfbtBukdC+fRqDY0tOVnyPtnxBEUyhrvrrwLbaxMA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] zstd: move ZSTD_MAX_CLEVEL to zstd_lib.h
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 12:23=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (26/07/29 12:16), haoqin huang wrote:
> > > On (26/07/28 17:29), Haoqin Huang wrote:
> > > [..]
> > > >  #define ZSTD_MINMATCH_MAX         7   /* only for ZSTD_fast, other=
 strategies are limited to 6 */
> > > >  #define ZSTD_MINMATCH_MIN         3   /* only for ZSTD_btopt+, fas=
ter strategies are limited to 4 */
> > > > +#define ZSTD_MAX_CLEVEL              22
> > > >  #define ZSTD_TARGETLENGTH_MAX    ZSTD_BLOCKSIZE_MAX
> > > >  #define ZSTD_TARGETLENGTH_MIN     0   /* note : comparing this con=
stant to an unsigned results in a tautological test */
> > > >  #define ZSTD_STRATEGY_MIN        ZSTD_fast
> > > > diff --git a/lib/zstd/compress/clevels.h b/lib/zstd/compress/clevel=
s.h
> > > > index 6ab8be6532ef..06565e064456 100644
> > > > --- a/lib/zstd/compress/clevels.h
> > > > +++ b/lib/zstd/compress/clevels.h
> > > > @@ -17,8 +17,6 @@
> > > >
> > > >  /*-=3D=3D=3D=3D=3D  Pre-defined compression levels  =3D=3D=3D=3D=
=3D-*/
> > > >
> > > > -#define ZSTD_MAX_CLEVEL     22
> > > > -
> > > >  __attribute__((__unused__))
> > >
> > > Sashiko made a good point.  Can we use zstd_max_clevel() instead?
> >
> > Good point, I'll drop this patch and use zstd_max_clevel() instead
> > in v3.
> >
> > Since it's a runtime function and can't be used for static struct
> > initialization, I plan to set backend_zstd's level_max to -1 as a
> > sentinel value, and query the actual maximum in
> > zcomp_validate_params():
> >
> >     s32 max =3D backend->level_max;
> >     if (max < 0)
> >         max =3D zstd_max_clevel();
> >
> > Do you think this approach is feasible?
>
> Hmm, no, that doesn't look good. zcomp should not include
> zstd.h or any other libs directly.  Should params validation
> be a per-backend callback then?

Good point, zcomp.c shouldn't include library headers.  A per-backend
callback would be cleaner.

I'll add an optional validate_params to zcomp_ops: the zstd backend
implements it using zstd_max_clevel() internally, while lzo/deflate
and others just rely on the static caps check (no callback needed).
zcomp.c stays free of any library headers.

I'll send this in v3.
