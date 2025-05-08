Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2A4262FF1
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746693603; cv=none; b=PPYG7zyhS4g9bbdRsaTgTduc1mK5TWAhy9Y5GdoXouY9cotPENaqNSZ7HlQub7Yq9YLvKMOEd1lEU64+tuPUOLHurXK7Cl6Jiw1paK++DG9wUnmso8S7APKq56C4MLeKXprN8baAlfpUvdANZbN7KXBA29Vn02R0Ks1emPaMQhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746693603; c=relaxed/simple;
	bh=AluxxiQOUGxhTw15wWCjpaQPmP8CI9T/W3mX2V0Iq4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVvQRlMZpP3pQNJ2nWxUX8q83wUZJh8tvl42cviobd2rH2+L5jNduNhbyZm9cb+VcZdjC8Oy278NgIFeMD0QT+D4QZt2XQhPlQ98CkngQo0q6ZNP1DGifynlOStI6YknZpvSaNLleJFWVEFvsDWVI9mIucHgV7/XLzQN6IZWfKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=D4OGt+SD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="D4OGt+SD"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac3b12e8518so141069766b.0
        for <linux-block@vger.kernel.org>; Thu, 08 May 2025 01:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1746693599; x=1747298399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tAMMoFnFLjgC9AxWVKUIqDWBuYeiF74xsSdBNFfpxcI=;
        b=D4OGt+SDnDMyklMDVifOQA3o9GfBp6d9wMNIH8hef2ZOyjpOPHTZk9M71NeltyhGkF
         mtgkfC3EzEmXgWMVRi16hErQ+Bxor4MKfjcd+1URNgJ+skBii/dPrQ+YN/6OkDNR5mVy
         ZPsk8L3OMkCSeVngIA6AWUY401/W6FOthd4nF2ULd6qz2Fo/+9SIOhu4Lqvgb/2Z4wrD
         kS+1XhDQr/adHXaOoHMUHK9H79jKsu0BWVZvnwVY5/YpSQkQxAs/JOxCnpDk7mf1FOpZ
         /ECtLMAsn7cCprbm9zjG86sFmjvSoa/GVRUJNfBVB6eSjiAQD4FIuK14fkdUX5lZoLxy
         oE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746693599; x=1747298399;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAMMoFnFLjgC9AxWVKUIqDWBuYeiF74xsSdBNFfpxcI=;
        b=cqwJZsG0K2SyAPARVb7cmYzLMfmTfi/3pVIl/Y11nyZAZ6WPWuQstQDEnN9HTXCUlL
         UNkuXeM96D0aVLPy8bVsL8DsgMz5wmVGwSgxQhwE/YXXYS8jEAPv9vqd2gA9rcD0o8m+
         cz6ZtbMBazftWae3OkhPsOiSKYQwUb23IqJ7pfVI9EjBpZMT0reIoUDzh88cqrbSj5+u
         aYcKKhJH1OkLZHOmNard5ehZkDogfiNdQx0PY0MP0r2J0v0J8WY4RuDFeA5nMm8Lubv2
         aBEP2DGGVRybBnWGRhN1Z95y/z1VlSyg13koZLtYQDNxuJs4lfEUus9AfKoYAZpv0cLR
         Po0A==
X-Forwarded-Encrypted: i=1; AJvYcCVNhVHLxmnDN8h0CMOjBWde6icWyqaEWYLrdbzViBGs+GqAV54Z/JlQfdtRgjVX7v1INr3yfqUWTpLm4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9gXV6FjX/ciLkmTLGkuQlnEds7KbsD8CEgs7VTQlEa1R3sluJ
	hxmqKqt/2Uac+/+0Fw2UX0845fRNAy5ZAscI9ambFvrbUkgtUQ0YY8qbfLdxE/o=
X-Gm-Gg: ASbGncvKKehgaRTRbKN7JvXeppx/C3V1ZOE8eBcm9C0qoT5L7M0SZzAnSbjhIhBVVWY
	ZQeLOnpx8mLU0x06shDAogLr/IvImcsMNU7gOME5ShvTjzg+YCq3Z1Qf9kTj7mbfxTVCzgkJMly
	iM03oYxi2LJdRm+H+aF3aVZeSwmmAyqFc67xXRdCZnOHbtY6Vr6sv7Le4kGP2P6wGE3XO/AYer9
	Gj1PONSloQyOG253PJon5xkKIopyx6L0cLXSmRIK8EMF18V90f/M+tfLxoQSljT4jbk5bfbq5j5
	N4f7+mwDaweXtEN4EvMX9PZ8oRs0I+OM3Gz7KoKFad+UUa1K8ZeQlq6fDkT51rbBG23R2dS18Ct
	v890mCEHEQtIO
X-Google-Smtp-Source: AGHT+IFS5ug7hwtAoPOrOpPdMHvCmuTo+K9+sWESa0b8bvZDBXVxf650X6+wfe/41qLd+PNEDUKe3w==
X-Received: by 2002:a17:907:a08f:b0:acb:34b2:851 with SMTP id a640c23a62f3a-ad1e8cd6495mr655012666b.44.1746693599036;
        Thu, 08 May 2025 01:39:59 -0700 (PDT)
Received: from grappa.linbit (62-99-137-214.static.upcbusiness.at. [62.99.137.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1e1292696sm402542566b.111.2025.05.08.01.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 01:39:58 -0700 (PDT)
Date: Thu, 8 May 2025 10:39:56 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Subject: Re: transferring bvecs over the network in drbd
Message-ID: <aBxt3NsJcofxhV5P@grappa.linbit>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
References: <aBxTHl8UIwr9Ehuv@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBxTHl8UIwr9Ehuv@infradead.org>

On Wed, May 07, 2025 at 11:45:50PM -0700, Christoph Hellwig wrote:
> Hi all,
> 
> I recently went over code that directly access the bio_vec bv_page/
> bv_offset members and the code in _drbd_send_bio/_drbd_send_zc_bio
> came to my attention.
> 
> It iterates the bio to kmap all segments, and then either does a
> sock_sendmsg on a newly created kvec iter, or one one a new bvec iter
> for each segment.  The former can't work on highmem systems and both
> versions are rather inefficient.
> 
> What is preventing drbd from doing a single sock_sendmsg with the
> bvec payload?  nvme-tcp (nvme_tcp_init_iter0 is a good example for
> doing that, or the sunrpc svcsock code using it's local bvec list
> (svc_tcp_sendmsg).

For async replication, we want to actually copy data into send buffer,
we cannot have the network stack hold a reference to a page for which
we signalled io completion already.

For sync replication we want to avoid additional data copy if possible,
so try to use "zero copy sendpage".

That's why we have two variants of what looks to be the same thing.

Why we do it that way: probably when we wrote that part,
a better infrastructure was not available, or we were not aware of it.
Thanks for the pointers, we'll look into it.
Using more efficient ways to do stuff sounds good.

    Lars

