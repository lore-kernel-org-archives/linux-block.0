Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437189;
	b=4Pv96qM5wyiR2bpqV60QkjFNEq0rCylvrtC+woyf7oZPhbMO98U1hAb6z3pZxPKOj7ZP
	 UNvmb7RVsugXI1yeLnbhm14xafEqs1Y+/XKcTYDyVL/KJABWhd+R9hQ/tyfczacfrV8bN
	 JZTjuj3g+kFjJb5Q8KqWAhP5A9tblOwBjA/ofqG0YHHfVlB7QEpxwkVw6b8BI+A0Q+Nr2
	 khph4pu2wu4g8WXYgVcq042Atytp5eWXEnurmPGxEi6ENlnF5nI/UlItpQ1x7gGiXFwYP
	 y85kWEM1k9kNfIoQeODhu/nNTGggRNh8ov8SLmP4LPOzOFMGmnDlPrC5xmC/n35oHJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=M+CPaFiCA9XbMHS7gojwVpze5zb2SRHOUz8jg0VHNBg=;
	b=gmybUFTCOZJ4MI9Dnp3puRFItf3cvMW8yvVDK/PaKJjaxxCx4ktGcj19t0W2chhQL63V
	 jeaGOlMgXP0sZTLKXPlQFIxCy6SeXQsG18IGk+koz2XjwSjI5tborrdOw4m8dzt22wRGu
	 6yy+RtWZqnOdRi7tdy5m5Sw9asktkjPsgt3eQbYxOMVdTYz4rC+L1HvPirB5s8W6PketL
	 05Tsqn+PtTY+qBQAlpX6zUXTA3isIJ3Of73i0yDbRhb4/kSg4VN8qT42ztR1pT6EVcHrx
	 8eyO8YkiUrJWrC5rilI1s72sWwbgnsa5MHqMw1S0EzVYyfyE4wVB8THo3jAYu7b09HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=mODp2Ilb;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563CA606A31F
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 19:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 563CA606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=mODp2Ilb
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-845788309b4so879797a34.1
        for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 12:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792437188; x=1793041988; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M+CPaFiCA9XbMHS7gojwVpze5zb2SRHOUz8jg0VHNBg=;
        b=mODp2IlbYgwb6hVJcox4yT0PDl/ONHwiijF2qBSPLyOaFu+643DUI26jJbamJ1we0i
         wtQuNS8ecFou/dI+8xgA32T7E3QE4W3A7KasxOeWeWNzG/2DNIN5D7MlLgPeJytMIHCj
         WT+F/Hmh6CpQqXMGGWdE1lqDEbZw8BpU/upKZpoC83eLRXzpdmYvVJWzEuts1/uyRYLp
         MrOXstn9A4+69YCDyyeFZ4DDoTOvnoAm+1dCAu+dTVkgE5wPeqfiQTOa0qEK3PdSIc+2
         0SQNIH30XGFbvomFNGgazb2zetyMyIpPMKCTmcjh03JAYCpf1qy0GygV8xAZHsEN5Gtv
         OafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792437188; x=1793041988;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M+CPaFiCA9XbMHS7gojwVpze5zb2SRHOUz8jg0VHNBg=;
        b=nAPFf2rsmAMgWFZkMceAJZINCh8tJRj4MMkqzPJoPsMcBExka1lr8+F8Jl+pZJgufE
         tisGWY/zJ5oqWkxau9dsYKcqy9rKP70bL9zc6apCgEBhCJmEsDrg1arYoDpNG2SH9uHz
         W+tPw+iv4h9K3x2/gqjSuqqkZ8Epmgx1V1vDhv25AEBIloZPFoUA4fbnqohnbmKi/u11
         zpv+ygmLFwz6TIj90hek20cLYtDzEPBFXHB0cfeGiZOGA6D8lPEcVSl+ZlV2LmorE/ly
         orF+164tlKi0RKQg/Ue1mHHwoq/WBlKSLBibi0FhU6J9eQD6f6zPXT6D0mTeJqgSxv9T
         pppQ==
X-Gm-Message-State: AFq9FYK8yUjh87oRhk98KIPbMfv7MA/QGbZsXtd66cGxzisBsr3UpahD
	qRR4T94CLhGZHSS9iJtF00Zdqq8oF7pZ7wuh86u0OcupddeMClavCWtlZhXQ4sQXbaw=
X-Gm-Gg: AYBFou06kxod0oTDZM5cZNJnqVSzH0H7wQqh6I3FrqnCBz5Ib/seQKAit+K6KsGoMbZ
	HukAGP1NCT2jGvMIk52wln0U38mneLxSSHCiuTv2xAe4m2UqKaxPfkMGmyuhsx677dFsBTiNOwb
	vBkPVA37uKo2fszDFsmImmzEYuXUkhrFYWrtYfhrdGSDvlVlvOa52KkWSwZGgYNKSgyrPMRsUpn
	hebJtAq73tUzn5zOFI4FAxA4eXEGJk6Bo5xvG9QGMNJJeVF8yy59/gzXEdZ3M6WnnWdkGDCSRmV
	gYbohqyrtNFio4a6sCXTLvCTWhrz+SRhrByrlwPrCMHDEd9JxrgT/pFLGQx6MpPKOdfDNvDDSdR
	U/7h/nESSUFwb0IKPHH0eLMD1YRU792gt2Yl/z89637/epWAnElbt4Ma3jrqF/mktsYWRVxyU5y
	Df0Q0C5nfetHgyqd2GhxiVU2CQVKHQv1UzWNE+CwW21us2vqj1pBtATFtt3D7+kN1dH1HEmUD5i
	1695RnEM/P5VDnPZ798/3Qw5G8PC/ZPveVsEYDIRcCEgpHOIWVPPQc=
X-Received: by 2002:a05:6830:67d5:b0:82a:bf47:a080 with SMTP id 46e09a7af769-84503e0a4cemr8262641a34.27.1792437187856;
        Mon, 19 Oct 2026 12:13:07 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8462659e3f0sm6669149a34.17.2026.10.19.12.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:13:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20261019150936.1819956-1-johannes.thumshirn@wdc.com>
References: <20261019150936.1819956-1-johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2] zloop: print device that had errors
Message-Id: <179243718516.3127071.15588195031740884579.b4-ty@b4>
Date: Mon, 19 Oct 2026 13:13:05 -0600
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


On Mon, 19 Oct 2026 17:09:36 +0200, Johannes Thumshirn wrote:
> When testing zoned filesystems that span multiple zloop drives it can be
> difficult to figure out which devices access caused an error.
> 
> Prefix the error messages where we have the disk available with the disk
> name.
> 
> 
> [...]

Applied, thanks!

[1/1] zloop: print device that had errors
      commit: bdfc6433b2d9433edefa17c5c779fe658356bd3b

Best regards,
-- 
Jens Axboe



