Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964E0342173
	for <linux-block@vger.kernel.org>; Sun,  5 Apr 2026 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775388509; cv=pass; b=se6Wzo7sz91KzDtzz28zwcxZVE2W0Ew5VWB7f9guMxpL89DwUk0X1raBcz9DGf8izu6894R0jPsuJVb/qN3hxicY64W4suNMPMlQj+cXvyG7s9OXQuiLGxEkzZpnYr5bjL033JiyeveY+HIFbCAc0mVOPsuaTag8wE2zOEhY68U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775388509; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8mzJ7sOzpKw1MQazVsN1jU2q7/wkNfTvB+lD/D5l9spTVwbernZ+BSju5iO+5ckamWR0dn+39qtFmqYeCxqTrcSDwAfdDBS60o/Kw48NeN1VWARKWQZkGTNLZNdZSVXO5yxz0VBXYeWsV76404XGNa0UHgZT8AONZLiZLklLik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiWX6n8/; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiWX6n8/"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66bb6eb28acso5719593a12.0
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2026 04:28:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775388507; cv=none;
        d=google.com; s=arc-20240605;
        b=hEt/rAUn2yRuT4I1K/GI5UrDE5uclJR/rWqpw1u9wSUuDN01u+VM74UMghtytDfpS6
         5//vElhQPzBAStYQf/fGFGv8Mf+kCP5jmkUs2iVFK05UbqTgjLf58xFqj83sxc0Up5Hk
         Az7xlUjZGyAnVeysKNA7zLAZNdC/NfxfRn1KcEwYuzjScEsCHjZy9tq5nVlUkK/9TNRy
         cG4wzueoB+u5q2D8vZiYg5Be1euj3Hah/R2Vxr/22ls7i0UosRRX9Z8QBR7WE6maBa9w
         Du7D0+okWpk/8bR09X+zn+m1GXbpMDV7RqrUJacDm18TuPcTI3tnCEdRSEcX9q3U8cyl
         3H5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=YTNA0O9SrxdJURfqBdPDP/A0/tneJMhRtH5KBjtJ1/A=;
        b=lNGMHacPVfHC887yTjMdSF99D6bkHBWUk7Mvmx6aCqEZpBUKkLdVZ/0cLT2eOMFSj9
         K21f78prR54rKakesqhWUjHLvik3s34VY3n6IcAucKycF2uZiYj7aIM/voOlY2wTs7ju
         G45OgTmpUvuGAjzVOGbd3jz0JXmg8eYH5ItvkID/cCM9dTfOORPLrUwzGZUIwQrgpjjz
         UrFK4BxV7yoU1J8CiTgMFM/M0tsqF3leYF5rIq+YX2/Oo7EuYqhEDDj4shXsROQ5RnNg
         x4lv7stGoaiM9b/KPg389nZN1DYDaiMPrQgNvMuTQQ80tNPoU6kVin9j5PGNtGhm4JDK
         j+Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775388507; x=1775993307; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=eiWX6n8/dvQP2epzag+YOiOJKImwBf0ETOFRZpxjC1rfx2fIJn7MwIyhhxwEbXmV0P
         9OhNwTVtZ3EAiOuT0enMlxKRW1mnF++pITBf6ykD4l7mDgmVZ48drY31swGtS02HskNh
         Elt1Zlqr2ohEkg4Ekrdt0gu+YaYNTZC8lf5ZnAydk1huj7gEQ4xfT6rbejcP4gd2gVTC
         JpW6WxBgEd+F2j5017dD+4LTHGLR6qU+PTdO30NGJQ/+70vONaJea+d40KxMPhuObiOl
         Pd6rL10zgz6GHhHRlnMXmJlOCf6mghUDiTX50gl3H43rFuqbRdxiZl8TNQj2cb1ZTW1b
         S77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775388507; x=1775993307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=RfSInrLJ20A15U1R9PbGtCnGZwKjqGAerL43vMSBbDVf/9G5d96+LueGFphD1h8b78
         ZLAhsesaPxSapN9fGv1my4YvkNpKblbuBMzbhcOEZkL+R/e7IZYq03pV+DZNhyiWxEUP
         mKuPp+YwvZ03we3wWJKEb2L/rwsXBGX38evAiYDGF2A11Lr7k1d6+iHfx2TxWjHuQ1A5
         lCQ53SKytPzc7k/Tkbt4GqSmk7r9EyCbUwLr8pte73mTEtLiLCbrOyJdRwzhUdc8je2P
         9D6unVciDy748ggC8dcAdbqpyCMeJnYJ0iYpDtgtsEGv8syin2HyKtpfmvtT1lyPZ8xd
         8ItA==
X-Forwarded-Encrypted: i=1; AJvYcCWxTl4cYQh0BWmsh+nsuLw7RZ4Ou6qpfDOUEg7qmcCTL7aqEiiMdcRLx8NCxTYrYeF6T9JbdDHyjlPHEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDEgvwePLTI+p7BIfdU8blLnflN1zAcY8TgBvdX+Ek1zNrzYwG
	kJkf4r2FclazbixlJmzohleNM0NiCflO6vrxU4ghiB4GPS1ouOrZ4yCgEtMMg8fz2IxzPOX6lSe
	0rnzgDUL8zl3OSD+Od5VDGIdqqbvB5A==
X-Gm-Gg: AeBDietm5I0fTbU29Tk6usVOPUWG2PecfCcm+xBsRyifMr75F/XNhMl7FFcQ3pgaxK4
	d/XtU3FSoDg5NvCl1UsH0Rz5CSmMhUxGAg077BCnZJ5RkFp5QnavOzXr+743ddm/cUBjd62gInn
	jBXAhEuay3xREblpRNhQq2X01Bj2HiQ6aaAYA7JccUIuq5HJXr/WiRRuZBYUw4quFH4/dawuTYf
	MLr+ur7295YMFivOu/muR96ZW4StWV/oK23xtvsYrhc5QKNjU3B3WxJTz54JAGGatAWhA5ZhXMm
	0ICEEdjfaopVWslXcgfdnuc1TT+lX7bYVCj+MBM2NlKkBQ49k3+HQrsjxayhzQ3SsFmJgA==
X-Received: by 2002:a05:6402:510d:b0:66d:eb3c:e33a with SMTP id
 4fb4d7f45d1cf-66e3f3cd75amr4391626a12.1.1775388506893; Sun, 05 Apr 2026
 04:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403194109.2255933-1-csander@purestorage.com> <20260403194109.2255933-3-csander@purestorage.com>
In-Reply-To: <20260403194109.2255933-3-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Sun, 5 Apr 2026 16:57:47 +0530
X-Gm-Features: AQROBzB7BsO7HtCIFo-YLrsx_ROEx0YM6hJF0_8-6yyuGMvlIZYevxnPKzknkJw
Message-ID: <CACzX3AsJbxpYdVPiSeY8bjZVVWDfMuzGSH_dsTqzBvGGbkvx8g@mail.gmail.com>
Subject: Re: [PATCH 2/6] block: use integrity interval instead of sector as seed
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
