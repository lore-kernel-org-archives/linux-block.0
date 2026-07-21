Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C9233CEBB
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 04:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784607077; cv=none; b=rKwtpZ3PvtvuPKEpHuMpLmA8hy6MkqjaQSB0GGIGGrEu8CJBPQiE9ngGdApaOs6z7T63X2YkojahTisIb7QE/4+Cybonj7K800atxMkGTltIO7hjQMu1NSwT7qGzw4N6ndNUnn7vun4moEPy03ehNOJdPoGBWlELl1rJ6b6tEf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784607077; c=relaxed/simple;
	bh=zWZXVXl1z0v5d8UkgEH3ruZjNAkPcciGbkApx1nQp48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ow9BQWJ7zYqLcjAgnvqZVSSvsKwdVjTxYQaDLBiAs7jMjJ49F+nnQnSUEhfmbHek3dMR0l+Flot5QE/JhSfmhdTXRv6+aAADva6jyKf5ZXeenjAGJ9JmIkjTqJfA7HnkCA3XPBtcTa19AOFmrl4twOHxJhyzYGn/f553iCP8xdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=n9cAkn4l; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="n9cAkn4l"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7eb64371a2aso4603816a34.0
        for <linux-block@vger.kernel.org>; Mon, 20 Jul 2026 21:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1784607070; x=1785211870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZxT7oKGdnI4nQikoHVyTSqR6Yt0hNv9b3DDVk4HugJw=;
        b=n9cAkn4lonTZEAGEvjqMnPy+iIWvlyGP/cpTL7zn+DqCvpbGB1b8ytAGLjAZsWWBdB
         E/K62Kg03DNVeV/1pwPzzb9WUI2IBA+AnMYDkDYHewwivHnACAWZs3fwNk/MMwFuh/62
         ukq40UWeF0mc6Fb4XlIH8mVsKs8PqSa4zEP4/UZL6FUsaDiBzo/Aq78+sKEUA3MXWUBN
         uR02vSbPzNg8cfW11ZLWXjBioE5+qXtk1kFOaDdT6ITB3ASwjmscM+YILQ3lu7NZA4dg
         9tdCnpbc/MUjZPp+IlyK1PYTUcX0HXWGGDg/1FfAvRuHjvcTY1QOJihxDOUqZrDSPADv
         eCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784607070; x=1785211870;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZxT7oKGdnI4nQikoHVyTSqR6Yt0hNv9b3DDVk4HugJw=;
        b=PR72Et3rRRH1Ujp+mmVJluO6xZqEKLwdIKLiLXWViVkDkcJZM+SnCsIwyveEPCcISY
         DBeFOxJwkWsbYcdr8q+rUwPHsPLRPknj9Oq7dEeaD+9oUwEhyTFuEKsI3nLDVcrRRRsQ
         gmtN7Yj+k3co72AlDKL9Q2dBoJhdXblwUJ+JRzTZthLWEUwYOLx1gGkFjujPGNZLI0xC
         9nA9XSO59LxaT8RKRwrui33OQQ399uGbB8AkFvo1XJ6j16UJm4wrZxJQnFS380SJMO3p
         Er068a9S8zr2FcYkWaXizlfjFmusCKYhLgdgdtXhSwyeV4fk7dTr3IWNnJFWeFNRCiXx
         jWyg==
X-Gm-Message-State: AOJu0YwdbZErTT2jHbvecRoXgyJ3CsvdevF6Apy3VSK0C/9YSepte991
	Zs1cY+OLAGMOrzMohtPAymllFhZcxhBWoLHIkmyP1MxFpWZrywA4jcPBWKvhAw5Lhjolqi8btPc
	CIMQiJXM=
X-Gm-Gg: AfdE7cmae2HDI1D82pzcYE4jV6/AehCqFdU4IcxolcU/PtuUEyMFoskkpDKt/Vwpp62
	ya7dF3C2aPaj6sb4z/J094HTyw86p9DniyRcaodSkXb+rtFDz3YwpQob1MSbAlZXxNqPZjCjwLM
	KwLVg8I0gHYQJJhdmnX3d8CCWIFRW1+U/Yx9nLw3hkzg6mSDh1jug525Fml40y8zA0HqvDwVrBN
	xNKzYxrfgBxFPnPMxRk+Fcs0Hjh/RKKGsEQ2v+Q9pLC+jwDb4JDox0HZhqWvO1A4XPfaafZHmkR
	4JLSGmD6QRJYansNUJYVPuY3Q7owooICA0fWFQcaCvYzlJtH7QxuKL94+YzY67YLKakYL0kp5GQ
	gi7S9XGj4PBox6LA3O95avha2xMmAGutCWsfqkREpJ4CvRD92RPCrorvhT1gHGt5pSwIxhEzNYp
	ZnUggsP4lO6P43+k77+K7Bpx/IAyRFuopzGs7WA7MJ2Iq6vQlFBpl0N1w=
X-Received: by 2002:a05:6830:270a:b0:7e9:b4d1:78af with SMTP id 46e09a7af769-7eda14397d4mr10319186a34.29.1784607070501;
        Mon, 20 Jul 2026 21:11:10 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edad98ab3dsm9584232a34.12.2026.07.20.21.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 21:11:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: linux-block@vger.kernel.org, raoxu@uniontech.com
In-Reply-To: <20260720194421.1497-2-phil@philpotter.co.uk>
References: <20260720194421.1497-2-phil@philpotter.co.uk>
Subject: Re: [PATCH 1/1] cdrom: fix stack out-of-bounds read in
 CDROMVOLCTRL
Message-Id: <178460706849.220282.13341697772506394152.b4-ty@b4>
Date: Mon, 20 Jul 2026 22:11:08 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 20 Jul 2026 20:44:21 +0100, Phillip Potter wrote:
> mmc_ioctl_cdrom_volume() first reads the audio control mode page into a
> 32-byte stack buffer with cgc->buflen set to 24.  If the device reports a
> block descriptor, the function increases cgc->buflen to include that
> descriptor and reads the page again.
> 
> For CDROMVOLCTRL, the function then builds a MODE SELECT parameter list
> by moving cgc->buffer forward by offset - 8 bytes.  This drops the block
> descriptor from the outgoing payload and leaves a new 8-byte mode
> parameter header in front of the audio control page.  However, cgc->buflen
> is left unchanged.
> 
> [...]

Applied, thanks!

[1/1] cdrom: fix stack out-of-bounds read in CDROMVOLCTRL
      commit: b27e195d4db8dea263050bdbeb11881b2999c9c6

Best regards,
-- 
Jens Axboe



