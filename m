Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793068422;
	b=pgm6P/UO5/NJBzIawZElnyxNMfiRyXgv2cvqyaBw4aunomffzGyVHnR+0Xc8Dhi3cE2c
	 SGvuaxhbomck/pX1y0ADrb4PCTgwOnb4izEcmAqLdu5uy7OAk0nr7dAxLeAiqZ3lEhSPH
	 w+XbaJYHLMoxaj6Y/YCPZMYuvtgh1iz9pL1H4JjiKbZaTLmb2XT70biIodDerwUF9yREY
	 Zukszj0R0gPccv6/Dbn180g9dWkWc2/IARWbM17I1eZzyNpFvnyYf5iHD569Di4E0hGxa
	 0vcAcSnSq+WfT8vJKFENRmhHAs5Wif2v77rv1zfghHJuoBQvIk5yEGrmn1hRnlSNkkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793068422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=puCn0Ks69HMbweTqrcsUBv/ereDfbXa2GkbsTiQ4tug=;
	b=2Y445SSySUqHLh/tATGrTkOxGqMzresKq4KhiXCXV/WRPzi1xIBCuPcLJswVe9zeZVuh
	 Dx7dKUqupVsvSOF42Rbcu03c6KPw8GjKnMRVlswPj0uwVQQ1YdWo/N63kcDMlZcLSGPM+
	 wDNID6Is+lP3bUwVR5xF6Y/G+lqUR0sgP4//r+1jgcDWbeoSpesb6A5q1xW/hAWWrS0Ag
	 MeFQbEZgqHILjDiBG1qC4Iey2Yh0STU1JBCOeCqJTitfyuGRXizqVu/Iv2wqOgQV+Cp6Z
	 ETYsCeMnDFp+/AU1/1gLMVGO9RQm9xSrSU/XHRnXNgZ4RqZVoke6Ud1dZZqZIy+/M2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=tStonwDr;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466B7606A31A
	for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 02:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 466B7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=tStonwDr
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-185fd3a4ca3so3121244c88.0
        for <linux-block@vger.kernel.org>; Mon, 26 Oct 2026 19:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1793068420; x=1793673220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=puCn0Ks69HMbweTqrcsUBv/ereDfbXa2GkbsTiQ4tug=;
        b=tStonwDrNoxNucFAywLg9XAMC47eCUhohE+AnYCAxsniVQe1EYRF1rep1BcrpKA7xQ
         PMXPXGJRRBZPZdt8KHTlMdJm4/2cyUbnu23naSIjr5kMmbclaNnQpNmt6cPfOYOSjaIC
         bTTS0bwMbtlyLQofRMagFPl3lQDIlDw+qZrd0/r38tDlmQMh1u417t3CviOYkwti21VO
         TMa+foE+OedPT8vL2bInZhVl1M1IBeW1UK3O/R2Fo2q6jBdSlppz4LXsiIQwfq6cjPXi
         mlOKbd+V0pMkyD/pJP8mmciBUrSGWNfBS8guRBk1cx6a600noa1OjtWcxr0TGFWFlp7Z
         FKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793068420; x=1793673220;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=puCn0Ks69HMbweTqrcsUBv/ereDfbXa2GkbsTiQ4tug=;
        b=RzSUG28juCZxnCRz8KGjD1Gks+uw68gXBSiiHS5eVAFVWLSqoYWFCwBb9SZyVkCboe
         WEoFwT+2L6Y+bPDZJ/vkoB6swQH4KAKz8DJg04Ko2zAb40bkohGe2MOKcPlsY41ULdf9
         a9fT225yLJr/oV+Mm1vOyQSVQ6IYj1ftKOwM/gqCEWqrk/9dT943qOtDZTbB3sLtBbFP
         RB6lk9c6QxMBecrule3PfAfwwCNjUw0kZ+VvzO/j1FjT5SGysQBbkNhP59lcxh51iqOO
         ZyKRk/F03uanH2tIg+EIRTyZtiqjrpUJ7J2hzfaC/9XmB56yZ0jPT/ErqVvY2etncBV0
         8VlA==
X-Gm-Message-State: AFq9FYLvsJHMday6HoQto6xFk3SfUcvKe1EhJmAFrZrEpuJyf+Mpkl2R
	pswB/sGvlyQfh9za9sLrHc9J67vH5KUTpEFau+/EojkvIPKLvEk9TyGwA9FCqxSzdDvXXij/Yb5
	T74KHfYY=
X-Gm-Gg: AYBFou1JKMNYIKBDHko3iRnFiEKDcyO9kwIrgF1BFSFobolW74NABhJDfW59jdHOo+p
	cmFAPSX9TwcURikXp81zJX0x7UpQ5piEAESLIj63YrBAsjuPJu705yFvAdY4ffRHdx/AcdBiYKB
	/ML7LHoSaYpRiSheQoTc8aE3bM3Wgj1rDQXhzcd829VIngaprbxg0x+KtO1BsNadU/ABFEqOA/6
	odkkN6BJkSCXTO4+xo6J5SqEs1XhPLanOO+3Rav0u1n5lmUMhWqdM/HEbrvnfg5V8sitzwqCFB6
	/ORRe81ZRV0VWw8C2x6/o13l9KLDsnnlTIg0TvF3wF/mhpzgAKDeT/oMQcb1A22AxETYqhzb+XE
	hoICC2efsqzZ4cTjZC6IolKoVbhP/cwgu7oO6T3a7lrlT1yRcHTR36WxKgPu2WIyYsAh3SmK+4i
	z+nqka8/mJHbTzxwLm46tiPyTufnxbtIGn82/utpj9a7UgWsKPJieWbjEox+LPa7EhYSWkjjAwy
	zjDUFN15TnkOyowcpISBegc+4SghdmBPBOVvFmAHibJucfIKOlOQzZuXmVSjMhRNzdJe3U8C0uQ
	lE+LI9qbeLNVhHuLI7vcxUhAZShL2nQS6U6NsmI=
X-Received: by 2002:a05:7022:ea45:b0:19b:7b7a:a61e with SMTP id a92af1059eb24-19b7b7aa68emr10771199c88.26.1793068420246;
        Mon, 26 Oct 2026 19:33:40 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm26186181c88.21.2026.10.26.19.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 19:33:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: linux-block@vger.kernel.org, rdunlap@infradead.org
In-Reply-To: <20261026220823.1162-2-phil@philpotter.co.uk>
References: <20261026220823.1162-2-phil@philpotter.co.uk>
Subject: Re: [PATCH 1/1] cdrom: drop linux/fs.h from cdrom.h
Message-Id: <179306841930.867242.15678945354004186026.b4-ty@b4>
Date: Mon, 26 Oct 2026 20:33:39 -0600
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


On Mon, 26 Oct 2026 22:08:23 +0000, Phillip Potter wrote:
> The comment "not really needed" has been there since the inception
> of git history. I have done build testing of all files that use
> <linux/cdrom.h> with no problems found.
> 
> <linux/libata.h> includes <linux/cdrom.h>. I have also build tested
> 99% of the files that use <linux/libata.h> with no build issues found.
> 
> [...]

Applied, thanks!

[1/1] cdrom: drop linux/fs.h from cdrom.h
      commit: 3d97e7c377f1a8fac1c5bf8fd6008c9a67c87847

Best regards,
-- 
Jens Axboe



