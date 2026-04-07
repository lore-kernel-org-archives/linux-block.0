Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8064A318BA8
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775559800; cv=none; b=mTgoxp/SJLmJFkYCFtK9nzQTmMTGd83Gq+uNDT5oq9wMteZbC6jqy+sFHphQ094+rzVsPkUglMQWG2tWOrwMsQ/r7GoA9VKo+Wj4ELDoLAMHzSUojPEqF2o8BWFPxcEggo627RNB8ZBWoG18eisCW05DT8s+Ncf/ZKtNJPrCMZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775559800; c=relaxed/simple;
	bh=IkZzuazTH/iSTyd2T6R8GjK69h4T1pNcKXpp4s4Gg1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqUGUEn7kyJebA9xK1Ymt1FHJ6L0lW2Cma6hwexz0ihpsV2yK4uL24xFlfhSdYJA0TQ5SdKiPDLHDhbB9l9xJa5n923/9Tw1XFCaAKxijoRHxDySkygo56ej7+QJ2WPoxFhCznUevbl02YZpXH/Inb8vFYTbeaaG6VoCF3utNr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=u2HZJB/v; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="u2HZJB/v"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso22784155e9.0
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2026 04:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1775559796; x=1776164596; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m6TtVGHE2sfWKmKHTfD7B+wW30vSxCVJuqgVacPiiPs=;
        b=u2HZJB/vUiR5lymoBAvTeeFxwc6WnMaUdlQRSNBU7S+VkcRSix4hsO34fNtHPF7x/k
         QtnYt1N3mr3yCMoh7m4CF7s+5hEXvixu8A8QmgLsCJTuI9xCl/3npfNNKxmo5Ib/vmAb
         o/ok6VsTmvWjWfwFDKl4lPYYmbnMbPgAs5/frJmybB4HxiJllgAIITuz48q65Zy11Nlw
         59AOaINBF2/HJHUtt6Fs+pVo2xp4DDyTdhCUxnqJQ+JczSwA6C7GujjkOMmHo8fzLf2D
         1eWws4ZeAWH4M3qk2axQzUJ3diueEF87onhfh6lgQl37NhUZjNtw8QoT1Byv5BBs53yu
         +J7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775559796; x=1776164596;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6TtVGHE2sfWKmKHTfD7B+wW30vSxCVJuqgVacPiiPs=;
        b=p0o/b6mYNb/hEc1mpVsRwOnlLSByF6bZVEnpD1w5/bvsr5uN1kq4wq1vQmOhtSrzNu
         rDjUVYuVNRZ+yurhBYgHI9hjyOJyaD7WVtf6k39Y2+TODZdEimEtCyKKR5gprS9mZp0I
         5BOhS7YPgO9ZZB1ZF+CTBGF2cWzaONg77bm3fY1MruG3MWDRuk8GPsc8Gmwt7S1kvISh
         T0PtpHcm1PbVpoBVVejqDbg7GlZ2PdVwGe7tSKp/oD+PZPOdCSZ/MhZI67vziEYpcO+K
         TI8gK8DiHAjK20v967Ax+FERElpNzHlLEGjjiYhcEippWAWFo6stQ+zjT2X+B20ZHeAt
         g91Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWLS8uhogpcEhgJ18/wsqpbXvS5T70yIS3FE9yfEsnGLRBNZq6zoR8i/krssZJdxsxbwzvtbCv0JyjJA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz9XxxKtPxoieKMIM9g7jrog7wyVpMFmjxc+0eCFsqeefQiW/A
	Wbf7CBP5qGs7+eBYowcTdXE2FTG+BeF7J9wNtTRdQ4uzXWkNADE+GfTVt4trG7PlFbs=
X-Gm-Gg: AeBDievTh04naQhDHGqpGCoixZoWW5ItAoGAQUhFOhe4CtGW3gDVR1zJSD8D48waufX
	s8Eo2jeHBlA2N8jKnVdl1ykxbrKZ7vqFSgX3r/1wYgy2QNeZkvvztw4pgoj/ppqrMionfbSwutw
	+AqENGEL3khUnX7AIF+zswNSRRHaBBL7C/I/Ea0mRVpnx/6DVNBYWjdnZOUIsSTEg7fxdtSUUJu
	DdjqtiLtlQ9QOZzYtQ10b3SiqdNhO6FJYEwTwzClYkdydV5xZhoEOYvU3HmsNZnLo+qbFAnsWSC
	yWp2UwOXwFaCmxwmf2SfIfecTxsKQW9iJn+5sJe4V/60MHzJxWA+3pR4lH3SGHJhhH0DXuUAC3j
	cJb37xQ0d2Co2bbTdrUUd7vMGHHaZB7yUweL/rIoT8aXqFiSDknba+PJ1n8+qSSS7xBRSXxG4ns
	5wXFO3yylHhNNTS+MFmT02Fxjhk5DusBQIGadT97hAQmlU8efY19Ohs5eCtgczvuMBlAh4SZJBO
	pGpKg==
X-Received: by 2002:a05:600c:c090:b0:488:b683:a421 with SMTP id 5b1f17b1804b1-488b692e9ebmr50994655e9.19.1775559795818;
        Tue, 07 Apr 2026 04:03:15 -0700 (PDT)
Received: from localhost (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e1fe0b0sm50289928f8f.0.2026.04.07.04.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:03:15 -0700 (PDT)
Date: Tue, 7 Apr 2026 13:03:14 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: David Carlier <devnexen@gmail.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drbd: use get_random_u64() where appropriate
Message-ID: <adTj5DBxjUjVkx82@localhost.localdomain>
Mail-Followup-To: David Carlier <devnexen@gmail.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20260405154704.4610-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260405154704.4610-1-devnexen@gmail.com>

On Sun, Apr 05, 2026 at 04:47:04PM +0100, David Carlier wrote:
>Use the typed random integer helpers instead of
>get_random_bytes() when filling a single integer variable.
>The helpers return the value directly, require no pointer
>or size argument, and better express intent.
>
>Signed-off-by: David Carlier <devnexen@gmail.com>
>---
> drivers/block/drbd/drbd_main.c | 4 ++--
> drivers/block/drbd/drbd_nl.c   | 2 +-
> 2 files changed, 3 insertions(+), 3 deletions(-)

Maybe I just missed it, but v1 and v2 of this don't seem to exist?
Anyway, the patch itself looks good, thanks.

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
