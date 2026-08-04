Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1074633D505
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 04:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785818550; cv=none; b=p17+BHOi99Ud8MTRfCFLO/bgO276nhLClvsGVCRbYcSkqPebYWVpHIiI3XIQcj/AZiSzoKTKaZy3tW1QbRICB6e0dB4uFv1QuXHguqIh4hbjKueSM9tMD/fO5pP66URM/IwHqd+oCtRfkBrSJBzDYjFUaA42XQHQZ8I2iMhdL7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785818550; c=relaxed/simple;
	bh=Vf6RpaBz6opxZ18PGekM+UN/u2YHwk7AiGIdTkG4vlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo5W1LULm5HlM4S2on0HxaK3GMtSIM1xw5+Dd2JnLoBuFzvxzpEYXsuVBqQ5nr0cMyyv6nsYAioucKY+6kCSIjV5c4DGg+dRRPiYGgVsD/UfRyx0SkJVb6tLzq6Z0quivTmjg/XRva5ztXFDYPWPKxXq7w2hAVVICCaOSdLPBrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iMu4DLo8; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iMu4DLo8"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso2470446a12.2
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 21:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785818548; x=1786423348; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ofILbuknwRcOfIjMMkJJdpQipeR+q4sG1AqmZyMuEBY=;
        b=iMu4DLo8gBXSv7vDQC3EnhUKi8lDG1Xg2xkw6hiddZJRE5RtCytQZ728ANk9O1+xuc
         gXbL9d2t03fKsbduPGWYlgp+oNsv909ZuetYvnX6rjo/n14r3aVeFFzkyn05n+CLtJDu
         EqxgPr3TxZ+rh9j3jD8qHR2Ew+G3VUi36wX4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785818548; x=1786423348;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ofILbuknwRcOfIjMMkJJdpQipeR+q4sG1AqmZyMuEBY=;
        b=YRg90C7f4lg/e3p1gYqfzX8mruw0SReG2rALJ0QatpcDOUhYMk0TkPkdS9Tgo14yQe
         ylg+QgYc+pjhJt98H5Hqa5jhQhOSw9ncUd6I7H9pPIReH5BHammlSyH15FGBnk3Nczfr
         FzosqwuES/yPkwH8Zv3uHEczn64V2HLPpJQe751hJPL/m3pcts2tJd4cpHi21YiPwJIN
         53GaHt1gbfqHKxTZF34EiITJPw1rZBNiM0MQea4hTyVbARnDG54D5XwCMRBAzyhCbOdg
         JeycluU60MPtavyQFbVGbcqosmH6FJPINfHpiNnBzyNdCM3cXPOmz2XNCVZnjVEZrIVZ
         iBmg==
X-Forwarded-Encrypted: i=1; AHgh+RqUVP1LvT64JfFEpdKXPqyGEZTLIlT1K/IXaL45F6NKUQNc9ddhP2hfxvzMeQ2znDS1+HOclaRJLnXpeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhIhdSfuczqPWjG5Qx0yvZO3+0MFxsVYxoqHkhoE6/pZmbDGq6
	8SfvnxLwbU7YMDsfQYBG9PwmHl+CZNeqJb5rB2gl5+tHG7VMlss6GNsUMUzCM1CxRg==
X-Gm-Gg: AR+sD11kDEXLN/FNZRI7Yvrqytq4GJrHz0v0NhmtiUeUi04kUoogmPtLq58lKIaMc6w
	lKnbFdrwEaqpkwozSleyhuFOg32zp64LsotaYETZDrKc6iIweKHvsTaGWyUuipGbBID6VOTjvmG
	54Gt/wRYnuf9THBgZY1m4dFksmlCGbdvEsDxwUyUnimdnZ6tIavKtjOXD+1L5UWbWbeqhY9cxNJ
	BcT32prk/oJKxzxipLzuP3sv+4c7q1a9t2N14Sejvwiur+37aUipmcZ07/oRUbZ00+uXaMkTbxr
	DMQpwr4cQTy+hemwRIJ/iNqBmjlqgWalNIXXKKKNU0mYvoysuNiyEjkqutqm5IqcjLBWzYC/G7P
	mC9iCyaJdiXi28a4exp4Hbn3UZpCBIlkAsCiuVe9ntHtGuKC9c8FdLI+KRo+yb9PCZ3J/nARaPv
	BN4fF9MX7ebUSc20PTK2yYuar6c4XG8Ocd7EbXsZdQHg5VY9qvhhSFp17KFKHqOxI057KjHoy0E
	B4C7z9Ma1jWzUSljQ+6+NaDY5qU+w5pFK6YBmU=
X-Received: by 2002:a05:6a00:c94:b0:847:770f:da4c with SMTP id d2e1a72fcca58-84ee4813951mr12064733b3a.16.1785818548446;
        Mon, 03 Aug 2026 21:42:28 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fcb5:533d:198b:8d48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe564b3sm4629556b3a.14.2026.08.03.21.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 21:42:27 -0700 (PDT)
Date: Tue, 4 Aug 2026 13:42:21 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: haoqin huang <haoqinhuang7@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 3/4] zram: validate parameters in each backend's
 setup_params
Message-ID: <anFspPi023HFlwwE@google.com>
References: <20260730025240.17724-1-haoqinhuang7@gmail.com>
 <20260730060133.80233-1-haoqinhuang7@gmail.com>
 <20260730060133.80233-4-haoqinhuang7@gmail.com>
 <amr3P_4zxX2w7ZNR@google.com>
 <CAEjiKSkExTnRc77Va-cOSpoNJ4S0i_-r2-iGFyxoSw2mqh1Diw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjiKSkExTnRc77Va-cOSpoNJ4S0i_-r2-iGFyxoSw2mqh1Diw@mail.gmail.com>

On (26/08/03 20:20), haoqin huang wrote:
> On Thu, Jul 30, 2026 at 3:24 PM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> > > diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
> > > index f6a336acfe20..5d551d165213 100644
> > > --- a/drivers/block/zram/backend_lz4hc.c
> > > +++ b/drivers/block/zram/backend_lz4hc.c
> > > @@ -20,6 +20,11 @@ static int lz4hc_setup_params(struct zcomp_params *params)
> > >  {
> > >       if (params->level == ZCOMP_PARAM_NOT_SET)
> > >               params->level = LZ4HC_DEFAULT_CLEVEL;
> > > +     else if (params->level < LZ4HC_MIN_CLEVEL ||
> > > +              params->level > LZ4HC_MAX_CLEVEL) {
> > > +             pr_err("lz4hc: invalid compression level %d\n", params->level);
> > > +             return -EINVAL;
> > > +     }
> >
> > So...  lib/lz4/lz4hc_compress.c supports levels 1 and 2.  However,
> > LZ4HC_MIN_CLEVEL is set to 3, but clearly the compression library
> > supports levels lower than LZ4HC_MIN_CLEVEL.  In fact, LZ4HC_MIN_CLEVEL
> > is never used in the lz4 code.  Maybe here we need to just hardcode
> > "< 1" and put a comment:
> >
> 
> My bad, completely missed that LZ4HC_MIN_CLEVEL is advisory and the
> library actually accepts 1-2.  Will hardcode < 1 in v5.

No worries, that LZ4HC_MIN_CLEVEL thing is difficult to spot.

> Btw, would it make sense to fix LZ4HC_MIN_CLEVEL to 1 in the lz4
> header as a separate cleanup?  It seems misleading as-is.

I'm afraid we cannot do that.  f2fs uses LZ4HC_MIN_CLEVEL, I assume
compression level is stored per-inode?  So if we change LZ4HC_MIN_CLEVEL
then newer f2fs will start accepting compression levels that older kernels
don't support.  Cc-ed Jaegeuk and Chao just for visibility.
