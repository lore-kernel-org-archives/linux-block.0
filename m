Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9063E364E99
	for <linux-block@vger.kernel.org>; Thu,  5 Mar 2026 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772735861; cv=pass; b=FssvKXqq+SnoyntRc15iYO8CRfSDKC5iQrQ6a/8/tcXNyfXl4rMYU6UA6XEPE50mqE+3r/z+ooRHJShIvUXbjlv4VKOV21t8lT2HzCWWTGz+NHwXxNM9xSs/aDxkWgnrjlTixrYSCUcyBI9sU17km1BvI7netq+gnfz41Z+Evlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772735861; c=relaxed/simple;
	bh=R6dH8XgJiObtxOpcsUX3tskHijiwulWb20uGf7t+NqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kj6ggUZsXhFqdFiaHCc/q+P5XTdA2cLhhmOtyEbHQNGLFimWiuP2PwqRYEbgPwuMLybSCLLvOzvzSy1pyzINbyAZaMWoEmVFdhMYsaXn88Mk0iUFTL60LwT47r20tcVMnO3Fjde0smvOnyPVMGrjmnBCeCpwCqgv9JNBeOHelJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GMSvzMaw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C6+t+gmv; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMSvzMaw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6+t+gmv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772735859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6dH8XgJiObtxOpcsUX3tskHijiwulWb20uGf7t+NqY=;
	b=GMSvzMawyK+f5DnL6FSGjgCNefvwZroZ0qrfMOOLKMI2sg0Ig/xOie+TP4mLL41GABAdCR
	VUNjfZBvncRkNVM+OQ0xk+g26CqSDtQnm/jgIUItcrp/g+4dZHxxy7o8U7KuzljAnWeoNy
	k25ysmExwfRBSAtcnRTksL9kAzVMUTs=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-NaZt3LI1MxqzyN2_xUAsYw-1; Thu, 05 Mar 2026 13:37:38 -0500
X-MC-Unique: NaZt3LI1MxqzyN2_xUAsYw-1
X-Mimecast-MFC-AGG-ID: NaZt3LI1MxqzyN2_xUAsYw_1772735858
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-798541939fdso147918647b3.2
        for <linux-block@vger.kernel.org>; Thu, 05 Mar 2026 10:37:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772735858; cv=none;
        d=google.com; s=arc-20240605;
        b=fjvlSpgLCW+lh1HA1NJ7Q6HIpBV0CItKnGpZ4RlVv00bXzaZ+B0++MJRCyV9spfRcT
         MZOkg+tWd2bktVhovqmJKaRZzkJTyuHNvQ3bB96ptJGYNnFeqTF8hO7bcG8ayuxkifH3
         CR11sv3ziccI+NgyZR64JiY99iPB+m3U8UKcwOxb6MkY0g/eE0vG7/Fg73hZn/rCAnrZ
         WcvpFxYs1hX5mYsi0qZqZIRwDOv1LF2qSh7EdlpnqlgfVkrIev90XRUMvhZ0M9lUcIVn
         PUFS9srB+GoY5Sxk9gd8B1bI0cJmeSjjNMscgef/nY68eIU1a2gM7IhvKgnRR/2JPOCQ
         5uUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R6dH8XgJiObtxOpcsUX3tskHijiwulWb20uGf7t+NqY=;
        fh=1q2DxcHYeNHrVUMyGOFIJB0d0Tc0zFo5cabnsCWI/hw=;
        b=ch15ihUaLuEncHK9H9KlsTMgSPjg3nzEa5MW8I27IBkXtdk/px3YiBsBxgqE6i4WMu
         rz1JVPEsR7fIRotlFWNoYnR9fnMt/iiFPKeZOig9iv1f2/qv7C+9U0669QWEOdQ/dnhz
         YwqAQPEqMKl1JEbJqsvUBC0sgFNVXA29QAnWkIoRVgWjIP0rdVSqgEqQqcDSbE/iDtyr
         fHbyZ9YeAXMoL9ha/eO9nQlMN2deNMRtx+ax0mDG+eCaC4kMNlds5KFuglz9+fWrwvKH
         4A7nTn1gDyk2wxOadh1lNDK4uZ1Dz2e4ZpThZyQypnIDzp0EJHOG9/wsSbZ/On+5o99X
         qQ7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772735858; x=1773340658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6dH8XgJiObtxOpcsUX3tskHijiwulWb20uGf7t+NqY=;
        b=C6+t+gmvFevtjGdH+DEZ5DMp3y2iKxSjmoSFw10y1/Ru2CoyKo+/bCFruvyq9inHqF
         QcicYjEF6+wQWjpTobI9il3OCo8r/5rIP4lRNSlYfR3A4w5aXpDlppanYC0aUokaPjsD
         RSXWZHdNaHCHDBCIiFe3Qn0XAyeTnLPGzwLIyKPedZIERoGjjis83Xt7qxJNc371vBEs
         UNz9aSn0MvpI5R99iXu8293BzrQIj+9wUJ4XdMY4ThNRzsIhfC6Namz8m4Bo0GofBf5C
         tqU3hEp5pKH+c4avG5DYeHi+w1hdThIjD3UkuTy6+RjSq9frCzpXHdf/i6ySmjXnYSMU
         m2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772735858; x=1773340658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R6dH8XgJiObtxOpcsUX3tskHijiwulWb20uGf7t+NqY=;
        b=e+XM0vFT2Z3FYsjFd7rpnE0nUL89I/n6c/No/UveqGlzLoR9gDx92Ob1PyLlxJOSSH
         TBPwxV9O7TFVJpFfdoItDfnDeibKAjo1DkaPb/ShPhqYtQKl844+UjnVCtTWVZcjd+FU
         OJUJn9ncxkF24vJY7E2aIIW6/G+wlNy1AepW4JnQoj0zerXBlJIfUgVT74fXoGrcQZti
         ag8pNCL38GAo/YzIT6WCX/yrnVIGonT337JhZ8Wu76f571NsmVOHdpPI0B97LoJEToek
         BGXKNznlkeoX6pNfgzNuQpbkNtrT0t/J1r+l9yTSOiGT/LkQIraCaSnlTNMZDc8tG5lM
         TL5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVd/KsJiJJSXmJ57/3kWjUPki7n0CkGudKnP4m0TGMOD98JAzKZYXctsWdU9lSjEHw42PK+p9hB25OP0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWIxU3Bg0DXWeGJz8ppVpIZk7OWrWsvJAiLXXHT0tNmC6MMIqI
	pADHgOi7+3uYmqtYUhqgqDPzbD/12BelXFWMWGOgVa0D+siBzS4BiQgahpv+FGBcUPRfnudo6BT
	tTMF0Ro/7VPA23JYsCz6Ldv6q7fDdpjfmcf7DqtcGaeUY/IvnIle0rdour1T36z1ym3U3pN5SEo
	ZvHr2PyiZnfudofdFUj8qujq6IvdAAGA05d3Zmk4s=
X-Gm-Gg: ATEYQzwDQ1mhCWxGjfuEv2BbSxdde9PfgU656x0bMdtepERgj19pnghzKO+LwqPgCrh
	o1YOKVWLvEbuuPYF7Vk431MO1Gt/iY5AKEpZZyJrabH9nbwRzJ8ClhM86GmIFKCMQZUgTUps+yO
	e6COtYLxS9Yt5l+cViCT/M5JC1XF1T8MKBpGaleW6ay24H7W7lLrQ6SOwABdXFhk/qOVSjRgIVr
	V64MZArHQjmiXjmHLlt1HkSprStoN7CItjxw1LbOxCdVdwh53gInGXk1/TVRXmUBQ==
X-Received: by 2002:a05:690c:c513:b0:798:647f:239 with SMTP id 00721157ae682-798c6c01a87mr55056807b3.21.1772735858034;
        Thu, 05 Mar 2026 10:37:38 -0800 (PST)
X-Received: by 2002:a05:690c:c513:b0:798:647f:239 with SMTP id
 00721157ae682-798c6c01a87mr55056657b3.21.1772735857680; Thu, 05 Mar 2026
 10:37:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304190424.291743-1-agruenba@redhat.com> <20260304190424.291743-5-agruenba@redhat.com>
 <aamP2qNKEmiyXQQH@infradead.org>
In-Reply-To: <aamP2qNKEmiyXQQH@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 5 Mar 2026 19:37:26 +0100
X-Gm-Features: AaiRm500QkwsYOPyC8DDeTtG7W1JPyGlNX5bDWdmiHocLDeSRR23AHcZAF5cQWI
Message-ID: <CAHc6FU5sEivMqj38xrAXuTxZ0d19LJjxbvoWtsPqm6NYigAEhA@mail.gmail.com>
Subject: Re: [PATCH 4/4] bio: use bio_io_error more often
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, 
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 3:14=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
> On Wed, Mar 04, 2026 at 08:04:09PM +0100, Andreas Gruenbacher wrote:
> > Instead of setting bio->bi_status to BLK_STS_IOERR and calling
> > bio_endio(bio), use the shorthand bio_io_error(bio).
>
> I'm a little torn how good these helpers actually are, as
> hard coding one specific type of error seems to create weird
> code and lead to bugs like the xfs one you fixed yesterday.
>
> Maybe we just need a bio_endio_status() that allows passing the
> status?

I'm not particularly attached to bio_io_error(bio); it's been around
forever but it can be confusing. Any thoughts on replacing it with a
new bio_endio_status(bio, BLK_STS_IOERR) helper instead of keeping two
mechanisms for doing the same thing?

> Also you really need to send one patch per subsystem.

I'm really trying to avoid that for simple, obviously correct,
mechanical changes that can be recreated from scratch any time.

Thanks,
Andreas

