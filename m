Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C555619D063;
	Mon, 23 Sep 2024 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109812; cv=none; b=YLc8DLLa7IbAC2dPE7FQgbMqAWpxgmDpcTxOUXXwoFgQN7oDo6iHGMFWAVQpjVEKGx54iT8AtS63cExMZpz1Tizc5TM14vGw/ZUwdtVP08X9NmV5bb8djR/1FEnAtdJBowZJByOgSABePjRofTVBOq2xihm4M5Z+Ophalicfmys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109812; c=relaxed/simple;
	bh=sHntfB4J5u/ONLYcZ6g6ICEEkuqVjcWEcFETDb2sI/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lp19w6ahvOoZp/gYrmx745EQ/9yOg33HYNsNX5BXOg6sWaORzszqDFIcxiRudLz0shE+mZwwlkhAEL8+svG0O7h2N59WkrkbaMlvTORkVwQ9jINQR3SVdW7R4MEMonxnHMAXRdE63szXgxicef8nv640IBYvypKouODryCyiNNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUCTi7Ko; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUCTi7Ko"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cba8340beso34607315e9.1;
        Mon, 23 Sep 2024 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727109809; x=1727714609; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WksqpH56ysAFUK+4nlYe9WLKwcoZ+7PWTDw7x0T2SJw=;
        b=hUCTi7KoTSNmqNSEMV4n6d+4JLJ2sQIa6iyxRPSWhtB433V7tweyyIlpHBaLcIXlH7
         Y91Wo1piwqk7aIH+S6LGROv70NfT5wKjPzwZykIOEZRy8O6udU8nefGIxDOM767JmWB2
         mmal7GQIRAXQYGpyx/M1Jxm1dceety7C0RhXNOJ6ZmxklvUYXou7UnWodzLuDxisPIUw
         QoCUB2ihysqmAzfMQ7AF2ePNSq27hee2TVSErPdK9eRQUHxcZhbWlg6+xhB4iAaefNVT
         +2KuAOKZL6KDUq+fYVn4/iAXKRukmT5omDzuycmwt7QtoOMHq5k8FpIVQHedHmz8Lck0
         9kZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727109809; x=1727714609;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WksqpH56ysAFUK+4nlYe9WLKwcoZ+7PWTDw7x0T2SJw=;
        b=aQ1AepOxzbTpuoOe+3nteqzIeWiTLo4sB9quTwMPYFwzVBnu3ldCrug93/DN5WHrCf
         TGzBlO2QEJpRWBF2jdE3EpDBdIxHzROUGakxjuZHj1mKISFjBi0u9oak7Uvxmv6Eo1LT
         Ex4jNgUSOOsG3xf8gT38ddjR7xK9X84yJf+P6QDQBO+KKaMSju6i53s1XSzMBq06GBIo
         /F2GbyQulFVfvxhodgtEL/5WISg4IzWf2QOtVbKCEaGZrm1lhc3CLM05PMnKLIQVrZLV
         Ivdc/4FOTeGqj0UxoFI9NDs4fogFa+wUQdPKZGkZhjJEBvk/uxd89PbBIcmHeVLZFaHm
         mhGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGpYjln8nclkhYZDoNIj3xRq4uOm0Zdv3PCSynQYRlHTjqLDv6RxSSPyoUf40R/nfqojvh7ShP@vger.kernel.org, AJvYcCUXqB1Np8qZ3l2lEMXzEAiHwdmXZ6livN/6UdeBv3F/LAJfmKzWi2Cty0nvd6/V7mUtBq/iVSlDNJP76gW5@vger.kernel.org, AJvYcCVObKLqSZk3VUvu6p12cvL/kR/EQyMcDFfRzNT24s80efiGkhh3IvXmcd7MJ/SdqGFf+L/hP50MmaqhJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx6eSxqQQVpagIJtbc83oGVDq9h/kK7CYTYbppUS/E/pVuFO5J
	6M472az1suwAZcwC6DCyvDJTXfpbR+zcQcfyETJjizhjM0pOzOQw
X-Google-Smtp-Source: AGHT+IGrFj2daDfJe4fGcVAQTrX70cIQeFmOWBbr1EucJQSk6RMFuw7JknYnGWzFoDUKxmgGFsIr+A==
X-Received: by 2002:a05:600c:3b10:b0:424:895c:b84b with SMTP id 5b1f17b1804b1-42e8f349e49mr1614395e9.4.1727109808866;
        Mon, 23 Sep 2024 09:43:28 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7ae5fc68sm106041945e9.6.2024.09.23.09.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 09:43:28 -0700 (PDT)
Date: Mon, 23 Sep 2024 19:43:27 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] zram: don't free statically defined names
Message-ID: <ZvGar7f5IcMiFzKk@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org
References: <20240923080211.820185-1-andrej.skvortzov@gmail.com>
 <20240923153449.GC38742@google.com>
 <20240923154738.GE38742@google.com>
 <ZvGPWaXm26iq-8TI@skv.local>
 <20240923160708.GF38742@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240923160708.GF38742@google.com>

On 24-09-24 01:07, Sergey Senozhatsky wrote:
> On (24/09/23 18:55), Andrey Skvortsov wrote:
> [..]
> > > Ugh, I know what's happening.  You don't have CONFIG_ZRAM_MULTI_COMP
> > > so that ZRAM_PRIMARY_COMP and ZRAM_SECONDARY_COMP are the same thing.
> > > Yeah, that all makes sense now, I haven't thought about it.
> >=20
> > yes, I don't have CONFIG_ZRAM_MULTI_COMP set. I'll include your
> > comment into commit description for v2.
>=20
> Thanks.
>=20
> Can you do it something like the diff below?  Let's iterate
> ->comp_algs from ZRAM_PRIMARY_COMP.  I don't really mind the
> "Do not free statically defined" comment, up to you.
>=20
> And the commit message probably can stay that: on !CONFIG_ZRAM_MULTI_COMP
> systems ZRAM_SECONDARY_COMP can hold default_compressor, because it's
> the same offset as ZRAM_PRIMARY_COMP, so we need to make sure that we
> don't attempt to kfree() the statically defined comp name.
>=20
> ---
>=20
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index c3d245617083..ad9c9bc3ccfc 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -2115,8 +2115,10 @@ static void zram_destroy_comps(struct zram *zram)
>                 zram->num_active_comps--;
>         }
> =20
> -       for (prio =3D ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++)=
 {
> -               kfree(zram->comp_algs[prio]);
> +       for (prio =3D ZRAM_PRIMARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> +               /* Do not free statically defined compression algorithms =
*/
> +               if (zram->comp_algs[prio] !=3D default_compressor)
> +                       kfree(zram->comp_algs[prio]);
>                 zram->comp_algs[prio] =3D NULL;
>         }
Sorry, I've seen you comment after I've sent v2. I'll do this in v3.=20

--=20
Best regards,
Andrey Skvortsov
