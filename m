Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D6D3BD63C
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 07:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785396524; cv=none; b=IWUW6HaOz9BN5vZmAh9s12FPhK9wImgPFrlb9r/WiEMkH7p2MSdWoBFgsXwUjwrxA1JGFEFkpqx7nxmtnwta7jz20YQLiYecBFTsx9o2k66tGyptg9XKtQ4iReCZw6RL04aYmMccPmuf2ZEQr0UprrN91HgT+O/P9KsNAmfPoiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785396524; c=relaxed/simple;
	bh=O3UtXUypQVJbwmShMtqMYx4LulXW4AjquX1zROhxrLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szN2Ohkbh+ZtGSyv0lkFUVpiUE7A2Bsh8gC9/OC2NIajS3962IZgK+vVf/Dqh2VypNvO5usggU+gA+PUFIgmaHvBcYJjhuns5MoBY8TOfIucWs2Xd+7OWev9TmgGfTFzMReUqn33/5670ALPgvUEOPMMCtdi6n/plvmESKoETOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cxfRg2hF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cxfRg2hF"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8486672f03cso1987848b3a.0
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 00:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785396519; x=1786001319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wPfQAXCdtCYx02fTWIFx/tHG074dJ8zh6RUm6IxRcQ8=;
        b=cxfRg2hFQgQozrhoqK8km+PEwF5RQTgD+iA7nEdO5Lv6ZRqkYv5B0m+KrIYvizLDSG
         dsxsE3t/XCFo1gD7rQHca123C4/vBj144XHLjASGunf/Zup1OpCxZHXXbJKIbh/cHJXv
         VOCi8K3yjex3UAtPpe/YVyY6LCPy1AQ4nDN6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785396519; x=1786001319;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wPfQAXCdtCYx02fTWIFx/tHG074dJ8zh6RUm6IxRcQ8=;
        b=G764fQ+e2FPx5RwgYPFSVTbCCCfy7GEA19Dmtaups/TTAP/XrObJQeKCBpp83TFukz
         0T4dD973rXe2fKHsURfe4ldd+a+ZeucUtuiv0DaaCJYDOsPWQGvidcNdpkRZTBGs8/vD
         uu6efVJvoK7Pi4BhMk2Iw23yL900brpcVjMpEzn85c8CZ503nIDlsk11sD+esWfM3ZDC
         FZU2Hoob+gQHQrkX9kKtWSocExBeJXIeUxnvJFxagivE5t0K/1CJ3D/nHEJ7qAeb60JQ
         +svwlM3lATXQUo777YVlmH6JITY2huM9IY7WnayM/lyzbMZcBrPU0X3lB4tDVGKK9n7v
         pKCQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq9DxJ6s07oLXmmxfjsEvQKaWQ3YHMDF6vfvaSB78+ywXQQ1OSs14I0H+08ZpI/TsIFg2cDitf8GVztpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgdYLh6Ohpg0gkcku0bavm+A9062mDqheOIBwMZLPu0WW6tnnI
	p+RCJuX+hgrvI/YjdLJmg252TZSqIznC9Uh0wpqlNemNmIlIvoF+KKzgE5Oy00dLDw==
X-Gm-Gg: AR+sD129pdHPcv8JhcIZYM3/svkhhctXBBqqAqa1TrJideXySkJDN4IOB+Iaz5qX6U2
	DB+UEQRy0OXAGAcByPd5JiuLO+q+Z/Wr+XAX7CbQRm2QtvOCcOHzACvYwv/pNz9MEk0kmKLULZX
	hOsmpDayjrJI5BdBa6LTYGFscQDwcVFpB2UotUkx39GwRNRvDDZqJS39zDMXIVmqvYzFJ4KmacA
	8Q4sLbaVNlHSzs3LZrFGrt2pgF6DYL5pWlpw1ifuXxh6xUGqMUg1RpqO+WnLapyQpVqb7lW0D1e
	rRif9Qwe8OSU/Up16tgdPt1ou6Ncc9AOycYbrOtty8WrwIUByv4xZ37farS9AKcaAHU9Qah9yxG
	vNoZ/1aiyBI8EWmXd7x0BUKufHU/yzo7OdZGcwU1+hGfVGg4mU/5gT9DOTo2wCsT3I8wHo82UBp
	t+MNYqvvqf95p+FLQGYg5Tpwk2XT8ev83I7F0z75CGKWSEr4V0woH3v+myWFG5/V5i8E4gTizuI
	ahcIcsbr8+kTrsnTXp5+g40AmlUxknpKQLxe7w=
X-Received: by 2002:a05:6a00:a904:b0:84a:60a4:2651 with SMTP id d2e1a72fcca58-84ebc1f4d7fmr1573091b3a.6.1785396519632;
        Thu, 30 Jul 2026 00:28:39 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:fd2f:da94:c3be:e16c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe23120sm2639064b3a.11.2026.07.30.00.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:28:39 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:28:34 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Subject: Re: [PATCH v4 4/4] zram: reset per-priority params when changing
 algorithm before init
Message-ID: <amr87whV3biLxmwg@google.com>
References: <20260730025240.17724-1-haoqinhuang7@gmail.com>
 <20260730060133.80233-1-haoqinhuang7@gmail.com>
 <20260730060133.80233-5-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730060133.80233-5-haoqinhuang7@gmail.com>

On (26/07/30 14:01), Haoqin Huang wrote:
[..]
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 0223fd83bbba..814f0af4d77d 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1661,6 +1661,8 @@ static void comp_algorithm_set(struct zram *zram, u32 prio, const char *alg)
>  	zram->comp_algs[prio] = alg;
>  }
>  
> +static void comp_params_reset(struct zram *zram, u32 prio);

Or maybe just move that function up.  I guess that's better than
forward declarations.

>  static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
>  {
>  	const char *alg;
> @@ -1681,6 +1683,7 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
>  	}
>  
>  	comp_algorithm_set(zram, prio, alg);
> +	comp_params_reset(zram, prio);
>  	return 0;
>  }
