Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5EF3BB9F3
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649709; cv=none; b=dAlYFV7RBB69MVntmcPNt0XbMJ1Sb6KlrCYbOXIwNXRKALGg3XWzehEioH9fGZohYc5U/F7FiKgPLP1o/0p8+BRZ4A/A3KF6W4hUsmvEfxhziwEk/y0bUfOREOegvcz13Aeh/wK2vx9K2mbJwn0970bMFceLvzDOY3bg19UPYOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649709; c=relaxed/simple;
	bh=UEdb6b6Z5iQlGQJZPDCcB5rUaLckwRSveh0FGowiTB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kl/hdD6qE2vMzZyZaAf9pl9nJFRC4Bnk8nwt+s6wBr70uzxWa3mq+2NpkwSFG+a2rQU75ju76V1aKIdXOih5Z1c4ouFkKRwPrizl7KhgV+sIoXy7yDs9N4AAHj0BVqq8NeMomTuMSJXihcroD/gkd5bMb+QNqOSgWI0ZNWExYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=mliC2jwX; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="mliC2jwX"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cf5fbacc9so408593f8f.1
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 05:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1775649707; x=1776254507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKYv/92g4USBYnuvjQ2o6KcGgYeWGPu2ptasrtf+UBI=;
        b=mliC2jwXaNGrsu/QC/M5rKsg2cnQu95WnGY381hlLcLLO7rcDiYWRysk1TrzBllamY
         vFv3SneOsCU38DBmtJYyrIiAyn0FfHGsasgDGiqj54AGZj8FtPS9Jej5ULgc07u7F/as
         EC+RxgI453J2kf7ql7QeZKsIE+D7Wvd+EN81Snvnw3mt9VZuRq8QwVwcb1R9U9Uv+Ye2
         ZK1i2efYgowdGJxhN5gd7pLK5fGlD2QwczufcN3GHi1LP+Uc6N9fSWcZZUghYf15y7qW
         EUu3j+B3oOp2C5HVzeNBANw1atqr/H03oBsQPsOK6xFfGGXyTsATqLySTlTkYJKDfpmq
         e7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775649707; x=1776254507;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKYv/92g4USBYnuvjQ2o6KcGgYeWGPu2ptasrtf+UBI=;
        b=W1q1W43dIgSw4jfBtDHbMK6o8iazxmRbd566MQXE3ptBTBxBn15wWtZnw0BKN6sk96
         W8myx37h/GsRIUobmwCxHFoq9Z9mhPf9Vuj2Mtk14DJKO53V1SQ2Nl8Z5E1h+aFbkaqr
         E4ntF2WQ2IPVtjTnFQtT3VIAi6oPxZ0/rVjV376/if4FGOLGkxzV2zzWCP1mvla2xCyQ
         C6c6v3I5jU+H+nYnaGJsf8KhcShzr2TQk9Poq2nr+rBv+TszGP9kp4qfIHcBKadiT9Ro
         656//0/qL7TO0R1IpWhhPUA/LTwfSMhfIkLy4VHzf0LC33msAXz7BD1NorRTqcsnC0qh
         1Dbw==
X-Forwarded-Encrypted: i=1; AJvYcCXVyh/L/FIPTPWzq0Re5fcGYwHC2p+VTzmZtVE1cu70zaQSRR35+5UjB3Yw1XB/JYHKfeEsP4siNDPRLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWvDyQktsIaW3ByNRKUMF0gRXe5GxB3d+oTs+WzNr4Wye7qgRG
	CHeVejDxoJODuIwehRcoJUV6eks7Sw1lt3eQR7wINzYTWSYa1+G7lbLJtJ/FF5A8LZKz9zPWMPy
	/YU7Sjzw=
X-Gm-Gg: AeBDievEoGtu/kQVbMHXuEs8KPSpTU4xSU+hY0RGMfJj9rORTmxa/HyAr3wnJ1SZ1F3
	tzvxLseP4dvDKt7GcLOI59rweWgYKO5gLdXaunACJANiJaoJXJ2qYNttAUmusW6SPiuyqAL2ttB
	Rcg0RONApotQ+evWcT9J4VP+5POrkyau+kLvPBH+fZx1PT/ur5/nGGJEZl/ZCuKvp+uj8shHqpN
	MkzZydrmhJ2x6scuGZ6C6szgIWTBagR/adECBVuNS7TWRKGfWlSAHqu760Lh4S7VnFZ71O2/T4I
	RHWNBa46l7yqjtI4vEMnLBXxxJS6XnYOJoOzysFcxU2DqLFf/PTEOAYspV67SLVNTSBd8JeaSxV
	zYKbJRyySMVdE0hOZP8gb5mH5RbXU8OyxBXPyx2vXKi/knOuuTWE+y2aMwUEyXv5FXDpZZlMCBH
	9fhgFED1BrkL6PjdXoAJG4qJ7lC5WeUQ/pmXWU5JqrqMKpUudFwkCzrvB8BICpKYYdO2DAGNqUh
	2k5lw==
X-Received: by 2002:a5d:5d0a:0:b0:43c:fac5:d382 with SMTP id ffacd0b85a97d-43d2118dc50mr36398359f8f.12.1775649706776;
        Wed, 08 Apr 2026 05:01:46 -0700 (PDT)
Received: from localhost (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f5294sm54605833f8f.35.2026.04.08.05.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 05:01:45 -0700 (PDT)
Date: Wed, 8 Apr 2026 14:01:43 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, 
	linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
	Joel Colledge <joel.colledge@linbit.com>, linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH 06/20] drbd: add RDMA transport implementation
Message-ID: <adZCPanS7iZlcPE9@localhost.localdomain>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Philipp Reisner <philipp.reisner@linbit.com>, 
	linux-block@vger.kernel.org, Joel Colledge <joel.colledge@linbit.com>, 
	linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
 <20260327223820.2244227-7-christoph.boehmwalder@linbit.com>
 <adXq36pbGLXMZc2r@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <adXq36pbGLXMZc2r@infradead.org>

On Tue, Apr 07, 2026 at 10:42:55PM -0700, Christoph Hellwig wrote:
>You really need to add the RDMA mailing list before adding new RDMA
>code.  I'll try to review the bits I still remember, but you also
>need a maintainer ACK.

Thanks for the hint and your detailed feedback. I'll address all that
in v2 (plus some other similar fixes).

Thanks,
Christoph
