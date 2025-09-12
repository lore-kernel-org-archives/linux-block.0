Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8DD31A04D
	for <linux-block@vger.kernel.org>; Fri, 12 Sep 2025 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757694496; cv=none; b=Zfbamkg29FkyzPL7U++aaPdiQznuirsnUTC8urPVTt8nhwsEFuxdOVSjmWZbd7WuuGQ+a3hUcLf4iaAv4mJGHK00/juSHKn5QIXnQ/a84Edgzf0WSawbZv/0IZOC8Ln1QO8ksrYFBDuhbxiw+Lf9fevxWUdj+w42dqev32CH8X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757694496; c=relaxed/simple;
	bh=4ZQds+rLQqXKtrUuxNGp9y/Vi70dhfBppH9lnk7gdCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1cOCLXjtt11IJCy6GWXSvelGtaJ3e28pJDgVw7l5g69LuhoZ0aBW9XYAEO5Fs7RIHG9aSGX+IDc2Gh6iBit3omtjYoyqSkAYL0CvkjI8mWpn595Pbk1nlAMAtlAFiyNnyrjX4yFn/5NJc/KHbfbgun8W9D7wqaWr9JdpGQJTMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDuJXpnn; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDuJXpnn"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b5e35453acso26406031cf.2
        for <linux-block@vger.kernel.org>; Fri, 12 Sep 2025 09:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757694494; x=1758299294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZQds+rLQqXKtrUuxNGp9y/Vi70dhfBppH9lnk7gdCA=;
        b=fDuJXpnnzZBgy62qA/zbs9nS//r+43P1NYWcv/V/VdowLoQ0o+SChONYShoeUoHeFG
         ygtVQvDW3+mH6sVgUEN8Im4BNY6c7xRwDyz5wC77cSNb3is9JD99KRJAAkhxJTLNF5Fr
         e7gdM4MIJh2Xt/1LSL2v8fOyDPSDq2GwTCpQ19ehQlD/Um2NGuPcd7i5JjsimIhAnJd8
         5eqNOK4/HMp1CoRFSw7gzvJM5tz/vHuwA2gwF59L+TcS4P7q/2o57vgpUaTndAuv3aIP
         /CA/+3Sfyf8Tr6xR2O4tuqrPzrA6gRJkJZyjTL5B1G72SweM9EOiV5N2UYr+PGo9xveV
         bSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757694494; x=1758299294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZQds+rLQqXKtrUuxNGp9y/Vi70dhfBppH9lnk7gdCA=;
        b=pXG/zy6O2/MAM9vJ6qWxePamU/MVUOqnBJ+W6tFLJXsel78CXQ472JwihbHc5eMqFX
         SNBtT5WkIWvyRjydLikM0xcNQvfsTuS1SzqPMCClp9IIKw3coI8arX4x1Bo4s/brc9AJ
         9RYt4arJ6MmoTmja/yP8uJR1+7wn0QDQW/9/9QoWaUJgYEL60VbS2jQwc0wZZQ8X/qLv
         3MDjnHvzyNGw2fmQ/HoFavcOiC1/F5JdeziUdy1Ur449OfakA/Lqh8N22tsPCBsBmZKH
         fpLzRREjAJRGO2xzqjdCfDwW0YJ5g3aVNf37eY16/rqEz4VhqqPVf/J+I5aJJIoX5zCR
         nW7w==
X-Forwarded-Encrypted: i=1; AJvYcCU3+Pf5QCy6WWuk8iqjxbYCPlnc85irdiBjyCKKLovO3SdY4uf0tADVwGt92kHZUkPhCNGo4qsV3Yv5NA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx971TPJHuzA4+nAkIQxh5955e8kiDNLqco7mwfqWzHXvvHH80i
	9V/0AN83NcNN4KwPTlNgQXCMthlXmoBdjtBjPNHcyx3ZZjlf7heI5Vf2irBofPVZwZ4HMPDSBII
	oo2tpQ66vTClhs7nrDEXdSLRmmOJKt4k=
X-Gm-Gg: ASbGncuAOZmjZxZGis1Mj3UGiJ2uTpoQrJcwyN2Rbzwo1F6wUH0e+gE/oLK4ToCeElR
	01JfgitD92BRvGhRalwNczQ7Ks3SutTTdbnBkRZG4IfjRkzRyR1VKpY/iX/wkAU7xRoQmqeZ5p1
	aFxV6ZYZL4ZU/P4nZAYC3kC3V7ng+6FbN931SWMgS9uxppayouri5fzdZSiWZUeIx933TmJB8Sx
	KgR+A88KWtRq1R65+V9QkIV6Mj+h4/bpU+svFBh2EmsyvNWqQhgOociIqhZT1A=
X-Google-Smtp-Source: AGHT+IH3sgRSs+dcbMoU7VA9j2cW53LQyv/IZLN7O9xGcrcKIirLDxNle7DY6XecZsiCSB6AFLxXPVP6mp6QV78ZXRU=
X-Received: by 2002:a05:622a:1c09:b0:4b5:b28e:f0ee with SMTP id
 d75a77b69052e-4b77d035872mr40986501cf.51.1757694493815; Fri, 12 Sep 2025
 09:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-6-joannelkoong@gmail.com> <aMKuxZq_MK4KWgRc@infradead.org>
In-Reply-To: <aMKuxZq_MK4KWgRc@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 12 Sep 2025 12:28:02 -0400
X-Gm-Features: Ac12FXxFDjN5YQNfv2vrM4ZDEgMv6WgrZBCDj2pFB-Fs02NqF_4tIokmTzA_qak
Message-ID: <CAJnrk1b8+ojpK3Zr18jGkUxEo9SiFw8NgDCO9crg8jDavBS3ag@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] iomap: propagate iomap_read_folio() error to caller
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 7:13=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Sep 08, 2025 at 11:51:11AM -0700, Joanne Koong wrote:
> > Propagate any error encountered in iomap_read_folio() back up to its
> > caller (otherwise a default -EIO will be passed up by
> > filemap_read_folio() to callers). This is standard behavior for how
> > other filesystems handle their ->read_folio() errors as well.
> >
> > Remove the out of date comment about setting the folio error flag.
> > Folio error flags were removed in commit 1f56eedf7ff7 ("iomap:
> > Remove calls to set and clear folio error flag").
>
> As mentioned last time I actually think this is a bad idea, and the most
> common helpers (mpage_read_folio and block_read_full_folio) will not
> return and error here.
>
>

I'll drop this. I interpreted Matthew's comment to mean the error
return isn't useful for ->readahead but is for ->read_folio.

If iomap_read_folio() doesn't do error returns and always just returns
0, then maybe we should just make it `void iomap_read_folio(...)`
instead of `int iomap_read_folio(...)` then.

Thanks,
Joanne
