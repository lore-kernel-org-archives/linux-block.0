Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789595;
	b=sq13KMm1m528O6NBZDljZJjvHe4L0DxGaHsX+37EulSbfTFBLp2wa/n5fh4W6EhB4moH
	 XWFSv2fSHuUvCJFC5JQXJ5U4UP2wL5Tj7CWwrf7a8/ki8HBcAOBoHF+y9o7FA44jW4xAT
	 CiK+5k41eel0Axz/IWjrpmqeOMm7jwJcNn5l0xuGmcyBIRNlDbnLQQz2C/9kM8GRbod/V
	 /avvMdOoovvtYc9Y9KyonEAK3XsUhIvVwGSCtwafI7mZump/jcojEy60Q87ELr9oib5m9
	 T7VRpiRWq33Yv1fTMjvzk15gxBMUsCC89EEnDkYX7ryryHvVlze5z6T5cSJtWxTFJ0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=xkGF7zBGeMOog6znoxpyertUF5RaNgUHosDUgHdgsp8=;
	b=rd5/0nYN+wj8ypf2ZRmXsayr1AnHUk+WyzAot8l7V6hfWk83tzoxv7dP1vTm8OPfV8ZD
	 jVmeM3qwhGLUdAafu+vgxGHA06xyYsYHlKqAtPKXCf0PqF1izz3pKF9M796LJT5sIeyC3
	 CqNnQmODMOZ1fKsPUDKHc4Hy7UsGWnMXu8OA6J/qhluFBTsz3+1KdiWCzxbkh7GYha2HB
	 UlrYNfUYVPy4JSZbmiuzPkVJSHO9VuFBhX4VvlNymirR+DjQbcz1+Q+7frW4BVX1HsvjC
	 tHgkr+teLepGkXH9SdwyL/sRk/THJF2TEsbXmAvh+vyhAb0s31K3pP/I7VCoAqUWOzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=philpotter.co.uk;
	spf=pass smtp.mailfrom=philpotter.co.uk;
	dkim=pass header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=X3GjboI9;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEA9606A31A
	for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 21:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEEA9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=X3GjboI9
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a214af2076so7809245e9.0
        for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 14:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20251104.gappssmtp.com; s=20251104; t=1792789593; x=1793394393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xkGF7zBGeMOog6znoxpyertUF5RaNgUHosDUgHdgsp8=;
        b=X3GjboI9vbRyOrLLIkl1qwVzIxdb4pNxH9sQYbNgxQJQBAvbJ7BISwfybKSnFBCCeg
         oPEXYv6SeBJTE1AvyOR4IKC1Qv4FtnVgCbiTMTJxTc+bSLAxNyJIWEqfmdbWiYwHsGrC
         MBdmDnSW6qnxr6h57cxtYvizoblM6kDgDF9t9Tr4HmUBJz06XMGz3fh+PgLpScidZZ3f
         3TBaUByLy12zVrLGvDNgrfJCpzElnvKVqUAtJMkMEOhzX+7AqUtTCKu7FnegY0XCPNcE
         2jPWHkz2gLHnU/eZRZzQn1U0WXijs89Y2OQlcVibVB2Q9bL6dmvp8g54XPiV5Kdjr7Bb
         IWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792789593; x=1793394393;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xkGF7zBGeMOog6znoxpyertUF5RaNgUHosDUgHdgsp8=;
        b=CheAUXrwpGZd1P8PWcP+TgBTFkVyAV8M9VoNkSip0unlGT3ToUU4Tmp++18AyqlbqD
         I+S31aKHhlzqVJLx95LvFhPyiVOxZlrnD0c32NBBSTfHb3lGBReNlPoYmB/LBQiUPI+P
         g+6v9AKjQmmwTaSrtaVfr3aYk025/depdvZP8lB4NOK7954Hc4Ig+mKmMg35hTibR+vH
         x8+hcr/J+hJbp5vxVeqnpPq9ggYvrgEUd0kj8/8Hc3ToO6IfDmMTM62/XWVT/4kvkxw+
         i3Ah20MIKZN8k4rFe+bUa1qhhcvc2iBMXgIO/HG3KoxOLAAITr5Tka7s4mGlHAhigYos
         f2UA==
X-Gm-Message-State: AFq9FYJeMeVkqkHo6kHKZF56QXKGXTcicoqibgWLCm2+WHbDJkOMdWUT
	xfuf160pp8ba95PYOKXGy/KCL8AUZVeUPI1XF5hhjOYMEj00/S0tU5CyXoRPmgWm3Cg=
X-Gm-Gg: AYBFou08EW3bq5mbr1sxJpeCocydXZB91O9DEYwJRmgugEqqRxA87mdxXS+sSfSxUu0
	eP/nVChZTdKDyzrFZcqfMbF5k6If5aIqfgHycbF4czWANXFSVYr5d/bULPDwEQ8CTWeZns45OS0
	nDmlHxM9Th9G2/tH4My2udFu7UZdV1uRGsc13ugJJavNmgaNQNNg81lPyE2JeI8GKIQ1kxGtRnW
	hsL2uQXvvww/G0Tu545aNmeldvB9HZAIFHvSwzL4uGf7tozqj2UP0WKvZ+5KZWdOnCN9YZ6Tw40
	JcUZD/pyZt6sl7yaa0lx8Ks0OeC5wPs5emgemqP/lMXabz0T9e9vKLMFReYmema1bZ2awF/4Rwq
	2aUA/EWpBCgN8SjXP6O+N693tSUwMxSDRa5D2Ca/AV06Bf9T2QsnAyKWQmTA56eEJHlagi0kpQh
	DtMamW+kBr8aDAYa27BMR9Irq26hI4K+4YDtK1lqmaZD+ghmrpkTmAp4eALPDI4eqj7q3XvpV6Z
	HtM2pnScTzWGsY3H+eg0pqHVT3Fvfw2Ah0QTxxS6VUjR70=
X-Received: by 2002:a05:600c:5307:b0:4a1:fc98:1cb1 with SMTP id 5b1f17b1804b1-4a35ac3b1c1mr1839465e9.2.1792789593267;
        Fri, 23 Oct 2026 14:06:33 -0700 (PDT)
Received: from equinox ([2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a55e9aasm7324895e9.5.2026.10.23.14.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 14:06:32 -0700 (PDT)
Date: Fri, 23 Oct 2026 22:06:31 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-block@vger.kernel.org, Phillip Potter <phil@philpotter.co.uk>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] cdrom: drop linux/fs.h from cdrom.h
Message-ID: <atvMV1rHU1nfcRwu@equinox>
References: <20261020170322.3687068-1-rdunlap@infradead.org>
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
In-Reply-To: <20261020170322.3687068-1-rdunlap@infradead.org>

On Tue, Oct 20, 2026 at 10:03:22AM -0700, Randy Dunlap wrote:
> The comment "not really needed" has been there since the inception
> of git history. I have done build testing of all files that use
> <linux/cdrom.h> with no problems found.
> 
> <linux/libata.h> includes <linux/cdrom.h>. I have also build tested
> 99% of the files that use <linux/libata.h> with no build issues found.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Cc: Jens Axboe <axboe@kernel.dk>
> 
>  include/linux/cdrom.h |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- linux-next-20261019.orig/include/linux/cdrom.h
> +++ linux-next-20261019/include/linux/cdrom.h
> @@ -11,7 +11,6 @@
>  #ifndef	_LINUX_CDROM_H
>  #define	_LINUX_CDROM_H
>  
> -#include <linux/fs.h>		/* not really needed, later.. */
>  #include <linux/list.h>
>  #include <linux/blkdev.h>
>  #include <scsi/scsi_common.h>

Hi Randy,

Looks good to me, I've built and runtime tested this too.

Will pass on for inclusion, thanks.

Regards,
Phil
