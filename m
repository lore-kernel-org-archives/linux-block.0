Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5141E3B14C9
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832234; cv=none; b=lQEJ6CdQzCSPUhqVlQGJKngNM8xLpfklB/jTdzh5CHEWP6trvwOEfdYuMMgbxsqjKPkgGYycqxmfklitdG88Y50h0chpAUKO+iY/sG9+33Z2Qcx8ZNn79o38hE24BjeD6iGJkaT6czQ1wrq0Gf9pQCPsYWHh+KfVQWH9ScZec28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832234; c=relaxed/simple;
	bh=QaZZmRLla0C/P56SeA7TUgrwDV03WkitZBqmRPBKt9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rx1IZXPa2tQaZu2g6EavU0S3Y2nVmYmgnAm9+cdli2I894Jqgb3ObPTXXdHCpSmUBn0iwMsyfNjOiiJ88veVOdcs1HCob+F0N9DA0R8ltg1bazEUkCNiU2n2JHnMmxXIztUbHj/Nw/hLnKYW01PT8oExREiCD+AZkJ9MmqiQpg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BvuFxShv; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BvuFxShv"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso5229437a91.2
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 01:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785832233; x=1786437033; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D4cvrtfKomIvINzqlR4fl6glsDd57Brk0rDNRooAdeQ=;
        b=BvuFxShvkiCFwixLjDBttEceRvPNuH0RQderblF11ntJ/SvxHzqEvBb8JU2EGLumTm
         WbtCZd5AmDJtJbRDcaeOcynbG4o4r7UOIchYQXO0HUOrZIZCYPzm7ADwXvmLPHfzdF8n
         qpYH52EvxZORNbX7HBpf+dq+R0JrmQUT4NWDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832233; x=1786437033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D4cvrtfKomIvINzqlR4fl6glsDd57Brk0rDNRooAdeQ=;
        b=APJAii07w7t63w7fp4J1NycY1xcxlr/up43FyMO7NOGAAb2cBMKDZ7PJRBg1At+Egu
         aRhI5ukHkahlRrKYvbxkuGKVLC79tX6tJad3yocAjL0VxNZTsdOVT8nskmBmnszwfcxp
         KR56hm1kZwqJhEGpQyzcOMddPi47RRYifniG555IrxRqmh+YusBQhKbw9IbdP3iHqEge
         eZyOvAThrMZa6zycoy7N7cQtDQUa52MmvjAlbOdQf0sM+XVJHm0/0aUmZoKto0FEKtGS
         GKB5CgqVzd9bc22OAoBlIUyvhSS5u3Z5OJVau4Mk+vIqqopcaU1z+NMikO43eFZT+iyi
         6tFw==
X-Forwarded-Encrypted: i=1; AHgh+RpUyqva8Ec5xz2jNo9itTjIu/mr1YGdsC4wUK6SySZaUe+YdrZRiYE0tYELPGPy56yX6/ow0Sj8J85Mzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzICPb2/yHSwnI3ZrzFIr1CBqkADb9tvZYHoyX+qJPBp5atqiNm
	orlEcCS8Ky18fKXaQekPXgWFRGS00fgIBjrccIup4b1q/51rCAfces6242xmjBilvw==
X-Gm-Gg: AR+sD126fpktRlyUVIPXn5f6OavAfazpD46giWNKpH7Z0vPO1NSGIfgOUUEmpEBcpRI
	pv8PxAXTkbiNchRZnSRcYrTfQmJsE2Qd8ngM8RxKnzQ5RtiVFMprIKbH8Pd/is6Qi/rhp6K86Ig
	7XwdyC+v6e0vQfO00FkRsrcWjyX9hgteCAjURRwkGTU0fl0X16/+kmEv/I4w5E1Iwy4cgT6KICR
	BlW5xC1qWgyNkW5IQPfB6T3YGPkhGtMO0ExmMqXyYkj2Agh3cOVK1DGLi6r36Wet4UbJ+7Au5PO
	FY+PYsd/oQM8zphlfVFDgoC8BCSVu8rbqkvcH4Rk+iJCRDAXl++i7qGZRjvfI1UbzgrXhJMSMv0
	Zn43Olc844ulNtSQm3B9/V+NI6/cOdQ489SEiBWSLtVA01IoJq9b7HpG27q/c08o2yaHjbM3NzJ
	XZu50/veTCA0En9V5GuLhbcvcLIoWUYdFN1On2YukEKa8UXWLjm9EdygH4NBy3EjDtnExvASRgR
	4epexWZ20eKJnTOQewolwZebQtM
X-Received: by 2002:a17:90b:5690:b0:38d:a8be:a597 with SMTP id 98e67ed59e1d1-38fbc56732bmr12033205a91.37.1785832232667;
        Tue, 04 Aug 2026 01:30:32 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:32eb:b46b:e9eb:65c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38feda512fesm959039a91.9.2026.08.04.01.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:30:32 -0700 (PDT)
Date: Tue, 4 Aug 2026 17:30:27 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: haoqin huang <haoqinhuang7@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v5 3/4] zram: validate parameters in each backend's
 setup_params
Message-ID: <anGiqbjPIXg7sUIk@google.com>
References: <20260730060133.80233-1-haoqinhuang7@gmail.com>
 <20260803141256.60599-1-haoqinhuang7@gmail.com>
 <20260803141256.60599-4-haoqinhuang7@gmail.com>
 <anF5ZikFOgS1hp6I@google.com>
 <CAEjiKSnECdUd9oZNbhJLiD5NTpOY+fx=mKNnccCXtBLyEC7KCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjiKSnECdUd9oZNbhJLiD5NTpOY+fx=mKNnccCXtBLyEC7KCQ@mail.gmail.com>

On (26/08/04 15:02), haoqin huang wrote:
> On Tue, Aug 4, 2026 at 1:37 PM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (26/08/03 22:12), Haoqin Huang wrote:
> > >  static int deflate_setup_params(struct zcomp_params *params)
> > >  {
> > > +     if (params->dict_sz) {
> > > +             pr_err("deflate: dictionary is not supported\n");
> > > +             return -EOPNOTSUPP;
> > > +     }
> > > +
> > >       if (params->level == ZCOMP_PARAM_NOT_SET)
> > >               params->level = Z_DEFAULT_COMPRESSION;
> >
> > If we want to be pedantic, then {} should also be added to the "if"
> > in this case.  And in other similar cases.
> >
> 
> Okay, thanks for the reminder. I will add {} to the if-branch for consistency.

Thanks.

> > > +     else if (params->level < Z_DEFAULT_COMPRESSION ||
> > > +              params->level > Z_BEST_COMPRESSION) {
> > > +             pr_err("deflate: invalid compression level %d\n", params->level);
> > > +             return -EINVAL;
> > > +     }
> > > +
> >
> > [..]
> > > +     else if (params->level < 1 || params->level > LZ4HC_MAX_CLEVEL) {
> > > +             pr_err("lz4hc: invalid compression level %d\n", params->level);
> > > +             return -EINVAL;
> > > +     }
> >
> > Let's add a small comment justifying/explaining that "1" constant?
> 
> For the lz4hc comment, how about:
>         /*
>          * LZ4HC_compress_generic() clamps levels below 1 to
>          * LZ4HC_DEFAULT_CLEVEL, so < 1 is the real lower bound.
>          */
> Does that look reasonable?

I suppose we want to document the fact that LZ4HC_MIN_CLEVEL (which
would be naturally expected here) is set to 3 and cuts off levels 1
and 2 which are perfectly valid.  Maybe just say something like that,
for simplicity.
