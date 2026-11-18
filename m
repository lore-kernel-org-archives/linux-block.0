Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018059;
	b=WoNZVLdGBDRIxLTD6jGzkyJppSP6/8qcwpJHM0z7cqScrncE+ULy9hQ3JeZRARYSkbGB
	 RQHPDPDc9yeBcHwPNZSvJQl86sbd3xxnLIqbWAJU4OrqHAYq3ghsPPMzmgxOLSqu7VpUT
	 AJqFDFw29fRarfoSSu8OvH4Vup5phMYHux2vlDG2IJkK+UAmpsqOH19E+lBa395vSCYuW
	 2l92wMEJMOomziM1VavZf6n6a6UxZVYK/jV2Alvhka7daiSnd9H3kHDEQy2FCJyuYHqXz
	 c81j0hVPgYl85m2fhEvILo07FqHCnRvIWCFOUcICMDHQbBGyKxjWutIr9XNSLG+PpGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=CV7oamrSYXfpp3NnleoEpP5E6f5lbD9kU3nbbqKEnc8=;
	b=gyglfaABSuLjhRuWOwxfGXavepmsYDfwftzMLBHAetWnCI8RSdQ5uh0NlqWnDGjYqxXr
	 g5OCH793MLNPEoY/apTLBZ/YOImE991550G3tmf43hvleiHg3ERSq+zL2OZNx6UeIsjci
	 PZgdwB80YiXYYgs0eureKhVsqPuicPJ6OA2/91FMXN4JrHm3i4vePPcnsQxgMGPiPCgst
	 fcUcuOSAhac+wML11XTOZPHqF+v9CmeRPqNvkWQg/xTmZEUoQn9WHrtPn0spKuCK6qcnd
	 mI9UDR0j07QRjpGQo9wU5AjbRLO9JCFy0/e/azaIoGOeq5tbrovmGN2J6qydcLCMiPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=a5rhgeb3;
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE914606A333
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 16:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE914606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=a5rhgeb3
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4a85c656c58so793889fac.3
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 08:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795018057; x=1795622857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CV7oamrSYXfpp3NnleoEpP5E6f5lbD9kU3nbbqKEnc8=;
        b=a5rhgeb35b8T5xllNNAeAnECO5OGWZ6FRR7g3JBTBjO3p29UNlMA5n5uAkVzlQrWDb
         9X9tktBgkFW+N1AWN82LjGdQogSQ4C20Uq3ZqEfNc6b6QQnInosH7yAuraUEAckqLXRN
         H8QXC6YWgM0rKmm4+aQArZeRlYHi5A9ujcVq17/4jz1Po88aC8PZnbgZwqfdfkRwCDwC
         qIHH+l6buu7Fbly+5y4La0q2XL0yaSHrAlzPVTYXoW28SKbupT9CWG8AVuN6tBNNGPlM
         8hw0B9CbHIRCEOd4dlJM8dAk2Ph1GA2THTGe5CsJF+6hPmUpcm7u9I0yji42m2YfX3bz
         V/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018057; x=1795622857;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CV7oamrSYXfpp3NnleoEpP5E6f5lbD9kU3nbbqKEnc8=;
        b=TlnUzLG/9PJ4glsZQFXxrOPKbAXuzoShLFePkuMpH44BihpHTPHlJsvoppuXc9xYEA
         uBQNzlGYgPPI8y/5efCalbNC6ujoLfgRqjcl2fVoa1T1ycuPYQiRKH5K40VTyAvLBTiY
         jug4f/p/2z32uHA4SbYYPUgT7j8PkUfJqQV9ZC6skziI4sZmOehLSziEZP1+poAq3gT2
         32MFOgltXKrYCJyDLCUjST/BX9+WHzCdIkyh1qksfOD4khJZjwYQirhOPUu5D/RLtFIx
         vRjiziH4vVdR1le9Cu0COxfEQcVG8dfbh3V0JA4vQ13gWpjbUYYp5eN7F6NkRpO2DBcU
         Ob8w==
X-Forwarded-Encrypted: i=1; AL+hErENk10qZcUQyG9BMV7qeE96Qz7rtgrWhXm+P0UOLG2hqglkPhUMbEmx42k1VJ2Nn7JKZo5fbeCWVEn2Ww==@vger.kernel.org
X-Gm-Message-State: APuU4Z/7UvldhM1eZJIJ169pKNU/05y2Q3tFu/un2JPj/n9/5TqzHMhj
	k7upBvEIYvM+w/zZVfj7MnpWtZFfVmL34tWFSmItLrQScy31KtQXziODsPiw2CGf2ixnDQuZBAQ
	20CsiJY4=
X-Gm-Gg: AYBFou0Vxw3KiFVyHbAgRmGsT6Q7zLe78/VpXtcPrHc65XRI86EbR0MCxLDffrkoQxX
	nQoo5kTYkjh8QwBOkJF27PU/FLTNQcfMLuuf6ezEqsh3uVsTHennTvIEuUiwSFrv0J0RbU4bIuR
	nB6O76/T8YmWtaJL/yV59Hj0m8QSyIp9NDxBxOLqU88gl3p3IcvZnO349MWRlwjZBk8fiz6OLp6
	//G3SR5cFDoO04kugWwXdtsl6xIAwUS4TXhkhKqOwwPZKwCvCYAsi5ccfYcX4qNAGKbKRZhLTB/
	ex6sT4pjcgi7NfKN7eXHY4jwpPbYkjUM22bZRnhUYP1z/AmSviEtdnK4CWM01Y8eVaP8RUTwSHv
	ncYmUZE0MTmX7mNMLpAE3NEJmk/p7u4mKgYiht6ZqEnm1Vb+JiJcZVKg/qAFVFUESSBVixkdFgX
	OnjJ1MLUwONhVMimqY2IezJ7rliEu1t9SlH/SUFmndBVekOsKlOogBDrawNjViWIKatoIPEn6J4
	n1R0lcbvOMMO3SMe0c1Cm4358u67odrBaaIpgeXwXPXGNrtj1MD2d5PGqcEKvDH62icN7FQun8H
	iJ3CKArv/BV+AMVPnthEj/CsgPmhlSd6rU9b2hIDIpZ9xKnf9g/TdGKzm3GJtJNHfnbfbThESQd
	15EFOf6rieZHvcdY2oSlzJvDkrGsquwvixh/TZIhPopskNgai7O4=
X-Received: by 2002:a05:6870:d285:b0:4ad:5a7a:f7e9 with SMTP id 586e51a60fabf-4b7613c52femr2613744fac.34.1795018057354;
        Wed, 18 Nov 2026 08:07:37 -0800 (PST)
Received: from [192.168.11.112] ([96.43.243.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b743721fe9sm2624231fac.6.2026.11.18.08.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:07:36 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Nathan Chancellor <nathan@kernel.org>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
In-Reply-To: <20261115-blk-throttle-wunsequenced-v2-1-1d297c891b82@kernel.org>
References: <20261115-blk-throttle-wunsequenced-v2-1-1d297c891b82@kernel.org>
Subject: Re: [PATCH v2] blk-throttle: Avoid unsequenced accesses to jiffies
 in throtl_schedule_pending_timer()
Message-Id: <179501805630.17649.245726738544852847.b4-ty@b4>
Date: Wed, 18 Nov 2026 09:07:36 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 15 Nov 2026 20:37:57 -0700, Nathan Chancellor wrote:
> After a recent improvement in clang to warn on unsequenced accesses to
> volatile variables [1], two instances appear in
> throtl_schedule_pending_timer(), which can break the build with
> CONFIG_WERROR=y / W=e:
> 
>   block/blk-throttle.c:469:25: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
>     469 |                    expires - jiffies, jiffies);
>         |                              ~~~~~~~  ^
>   block/blk-throttle.c:469:25: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
>     469 |                    expires - jiffies, jiffies);
>         |                              ~~~~~~~  ^
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: Avoid unsequenced accesses to jiffies in throtl_schedule_pending_timer()
      commit: ae1171f38098098e88c13c38e462d27babb50038

Best regards,
-- 
Jens Axboe



