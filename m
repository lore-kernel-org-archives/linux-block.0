Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700615;
	b=U5qqhmuoaI8aBvIgz5bURaPBuXZf0j0E6i21GOxkIj9TBouQ3vsWBgvXPqZneuj7pRui
	 RhecvbsjCI3t7+uBI270gZztAk5KJ041wZ1Uf18KSU8a26kfEPS4KQktMNEwuzCjJJ64U
	 ffghak5G88lfmQYGGWU5ESkQ1Jm0fRkj+SLkjA3pZzDsgG1Y0AVR3xz0iDnV9jm/MZiMK
	 eNXsE7cbGRAT+haLhADWI6CQGG0n6fMA5+0ej39u+pxZAg4fp+EdOoN4SLF+fhB5ESh5W
	 Ryh9GDCGBSiavV5ruv3jAdnDtnynVUoHdmN5LMg0HRHmWHYk4dxohsuXnlNogmlY05g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=bZ+dC6noXl55QlVCt5BZLTKiK5g6wFPqaNKr4aU2duo=;
	b=1uNGfLIuLvJIaxz5dIrTho48Y4i3ILV1b+XV35pLiPJXF9Wje0k+rYKkJFuCdZPe6y0F
	 hxzBl1YRRy35K2i3ZpdSp+pXrRhY3KS8/FpxqRX1P4BZr9frwYNIyTVQwUjAyjKHQ8Rd3
	 uBNCd58su9ltjVHXWTdoNcCtqEntBbJm1JAOSdswrZrvt3L8qM1V45lOVH/BDfIwS/e/M
	 TZTQoWrnYKESSiws+MJ9Pmjbtf3uJIJ/akDzCDF/YkgFkCpjEKlpVjKsytB9pohYn+XJT
	 tR5O0b6Z4PGrUCA5GVcSJD69XhqUW8I+PZkxt9/mphTk3gCKUwl03RpIiDTaHdPNeIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=RZvMrKPb;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87202606A31B
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 20:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87202606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=RZvMrKPb
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso327678eec.1
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 13:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792700608; x=1793305408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bZ+dC6noXl55QlVCt5BZLTKiK5g6wFPqaNKr4aU2duo=;
        b=RZvMrKPbBFnx2yyTosWZ04aFqIkL8Ce/WGIYyuZqTADisEr63CdZ37DebuMQCINTfO
         csg6+7j4vMkjRDPV6N4jaBU4NUssCs7RBPlM+ionoNfAG9CiBcWOKRa032cV+jil6Bvl
         AHBRFarAcS76VSGbf+L6p88zW4JoQA3R5NuOW5eBDln5EyVYa1x8pAF+/8f94GIyYzlh
         HlRIOI5pfHDJs+y8opigZZsI2FcoTByBzNjAIXd/+V1di4APMvgpIMUcKESWvMseCbGB
         P2q+6uRzDgBdJ1QhN1elEt7YyHAnCpEPqx5bt+wmHhUOY0D0/4iiR8Erl/fqWu4bSv4c
         b9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792700608; x=1793305408;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZ+dC6noXl55QlVCt5BZLTKiK5g6wFPqaNKr4aU2duo=;
        b=A4Itny/i7QIGQOG1xQ7dB7uCxmtdreLAq3oQpT+oFnaHvAPh/gqU4WnxM5nY/S+v38
         1zBtu7yowrpXfYbBuR0TDjRfX2zJx1qY3nFIo9qjuwALeNTA8oz9X63+O99E1sioEWAi
         saw571aFt0qAX5pjJ+TaromlFAdwmGwNZCXFgKdzf1rmIp4x9VolbHOk8X8MrNGctg0k
         J/sDirb4uBiOy0fN+9UDiSrqSSxHhnSjOz7NdvULlqASUxeagJjZS0iOgM1vRvcDKFXH
         2a6AtpETzik/rH05tjzKiaLmYiJTUBDUxQqadfb6hAw54rismansT4Ed8LMdIURYJfGv
         HF1Q==
X-Forwarded-Encrypted: i=1; AKwUvBy4CcOjPGJ2SeDeOmN+qr+/7+QzG2HdIZbVAQNQ161E1mHCl+dqjUDmLDU/gwTPpHWVByoxd6/mcdFN9A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJkiAcZJYuvDwbUd9bN2ubIIc2jvnXnrSJGrMFOkK6yl4RmDgIg
	j1GxE5tIesMb2QpXD53TlMmjMvC2dS4rrNCGqpAfBV2K0ta5yVdiAqWLvwT/IHi6lz62CiQ/5I7
	OgCgtcWo=
X-Gm-Gg: AYBFou2jgROPhQ5olHVE1+7ZPzCy2+6xfxcq0ATWMSqatrchHLunE9wc90Is8WnN/U7
	8md8asjJ1ik1KetRncrNqezaxu/tAQuK7nfEfHewtp2M6ODTzIJi+DvfaxJz2OeNOoEw1+n20sd
	69Z0A80e5d8cWNp7b++ssArudmO1bk4Qi5KDteDNtCdVd9otf1HUwFHeU8CZgy9RXxwn+OP29Bf
	ygijzLaaVhRFsWHvcsw+Pmd/EjbGEgqKBQ2BA+kI3QHHjSj7K0My3CKHAReO8uNrx4sYYCkWQvd
	icvq4bVA7f7/d7xVhxQIr/6tgMrfLeU3CS+2iTLjRXspwU0CyyUnTQQaHJtCNTdk2TBcSnh8zrT
	ExI/C1QpWD3O9EsUmSshb7unFc/XRLww0Oz2RF+vj8aHBqrRuyAEZ9X8by9nSXEqi0utXiunUWD
	NrLwCvYSE+P4tl8ML4WGX5fj3u/TV1QHBrImx8xKSGzilPQShHNr0+uvz9ALN14oxPvs+de8hHd
	scRUt0iPN36k0wndQgN7ZKX9obdVQq6JVErAQuU7Nt4PlCUgco8omwzGv70WbyzZX1kk0s8Zf17
X-Received: by 2002:a05:7300:2a9c:b0:365:b147:b458 with SMTP id 5a478bee46e88-369d90c7547mr323249eec.3.1792700608112;
        Thu, 22 Oct 2026 13:23:28 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-369d9d8978csm426450eec.13.2026.10.22.13.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 13:23:27 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:23:26 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Md Haris Iqbal <haris.iqbal@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [v3 for-next 0/3] block: delay support for error injection
Message-ID: <20261022202326.GB2931-mkhalfella@purestorage.com>
References: <20260928221634.43239-1-haris.iqbal@linux.dev>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928221634.43239-1-haris.iqbal@linux.dev>

Hello,

I wanted to use the delay injection for a test case that I am currently
working on [1]. Are you still working on these changes?

1- https://lore.kernel.org/all/20261022185920.GA2931-mkhalfella@purestorage.com/


On Tue 2026-09-29 00:16:31 +0200, Md Haris Iqbal wrote:
> Error injection can only fail a bio today.  This adds a delay_us option so
> that a rule can hold a bio back first, to model a slow device.  The delay
> happens above the driver, so it tests the code waiting above the block
> layer, not the blk-mq timeout handler.
> 
> A delayed bio is marked with a new BIO_ERROR_INJECTED flag so the rules
> are not applied to it again, even after a split.  Christoph asked on v2
> to avoid the flag by allowing a delay only together with an error.  I kept
> delay-only rules, as a slow device that succeeds is the more useful case,
> so the flag question is still open.
> 
> Holding a bio back reorders it against bios submitted later, which breaks
> sequential write ordering on zoned devices.
> 
> Patch 1 is a prep cleanup.  It moves the rejection of an unknown status
> tag into the parser, because patch 2 makes a rule without a status valid.
> 
> Tested in a VM.
> 
> v1: https://lore.kernel.org/linux-block/20260827000115.128093-1-haris.iqbal@linux.dev/
> v2: https://lore.kernel.org/linux-block/20260830012002.80275-1-haris.iqbal@linux.dev/
> 
> Changes since v2:
> 
>  - Patch 1: return bool, rewrite the commit message.
> 
>  - Patch 2: drop __submit_bio_noacct_nocheck(); the flag alone stops the
>    rules being applied again.  Log the error when a delayed bio is failed.
> 
>  - Patch 3: trim the documentation.
> 
> Changes since v1:
> 
>  - Add the BIO_ERROR_INJECTED bio flag.  v1 only resubmitted a delayed bio
>    below the injection hook, which left the remainder of a split going
>    through the hook and matching the same rule again, so a bio was held
>    once per split instead of once.
> 
>  - Patch 1: tag_to_blk_status() returns an error and passes the status back
>    through a pointer, instead of returning BLK_STS_OK for both the "OK" tag
>    and an unknown one.  A delay-only rule has no status, so the two have to
>    be told apart.
> 
>  - Documentation: a delayed bio is held once rather than once per split.
> 
> Md Haris Iqbal (3):
>   block: Reject unknown status tags in error injection rules
>   block: allow error injection rules to delay bios
>   Documentation: block: document error injection delay feature
> 
>  Documentation/block/error-injection.rst |  39 +++++-
>  block/blk-core.c                        |  14 +-
>  block/blk.h                             |   2 +-
>  block/error-injection.c                 | 167 +++++++++++++++++++++---
>  block/error-injection.h                 |   1 +
>  include/linux/blk_types.h               |   1 +
>  6 files changed, 192 insertions(+), 32 deletions(-)
> 
> -- 
> 2.53.0
> 
