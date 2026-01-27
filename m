Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D8C359714
	for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525782; cv=pass; b=LwDN0V8mzRwIrt7HDgwmLaYMPjWwRSWcIzbeMO77pYAJainqKTVFKuEp0hAb6veZN6HanEX+Cb0N/9JLs5XLsOWs9qetUV18eN3csv0q/6OPUM6yf7qqcSNqYzB4iVqAyTItatyDiO8jaNgeD+zAIxqiFEB7Tz4poSDTabAm1l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525782; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4Oc7DJnre30EreG7odyGVqx85wwBopUqhF+13OQzc5w6bqDszba53NW+Ey0z92Iv15q4QUQ42D7b0hM+5iKfEhVOgylvSusxGLCZKOssQQN6G7Sm7m9aIJH9gCVo3cbBkCZ+v26hUxSx+FfnT5rcrQSXd5U5bJSS7G0jJsROGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJyRaMh2; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJyRaMh2"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65812261842so10910724a12.1
        for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 06:56:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769525779; cv=none;
        d=google.com; s=arc-20240605;
        b=ef4mPFtfcTDjJzG90Wzfoag9+oSr16ErkcpSqEjIUncYsLtVnUfhA03KcnPWqzBhPv
         BEpqGdUXygNBpy/Nnv5/csQSAFMcagaTNlVVz0KPV2Xt+6kEt6EqHngDxHutD50bL1IX
         Y1qjOG4nEOoWam+eIh0ZHukYr2kPeM8WGFb5YYR0YWgF9qj7R2jAtKreHApBTNA8gVkf
         PRuIINFA9tHPnDggFABWDmidlxIMeT9+KsoXuRKNf5FcmpUM8pWFiM1D6Up0XtoWtEqS
         tTrHhEpq+cDQyTngguKPxFJAQBTYEaBqM3QeMJCIC+5SaDbvJLijXJMfHnEmSmfIxKdA
         bhGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=Wsmr4djVuiAs/rxaEEjbmeGZ2v4ghrS08b45fBpqfrY=;
        b=Mjzyb3FUpinGR4Q2IWM7ZXckglTiyRa2VVPAXAT5cW4799W6JCQT91yejT7Ocp1ENv
         MUvidgTsMrcomvAEjVVwbpsLeZwT5Ql16GSM4c6afsezLeGxcKON8pb1aS+QW9avDCeC
         tUELltCl1MeE8YZXs+w25+3P5dKoCUpG7KN3iEN/7v53x2Eeyf1JcCJBO/F+DmQYppf2
         gGqIM6HlFPF5pGElIFr5gbs0QCV0Eysjbk94XKa60zjxZ8Eom4Mrn84TFOpbecWcTlds
         eB4RtKuB2qujbQFW+53mMGYdevK9vA7RVp34A+OzIPKMDU6dKX67eqCS3e47iXZvbC4f
         pHHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769525779; x=1770130579; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=GJyRaMh2hh7lb0M6VyaLLCzza/TMpZb1J86mIXRz6Yo20W+MPiXlQXGJyYHnUXVkp2
         4zkzhhX11FCyyF9Abwz+RCL5VQG+LmQWGIn6OIyV+pBxqlVaREMv/fwfgyPXNUKlvUGn
         VhTG189FB0jZ/deo4BlehOKXXAPjW4NL+qpTQtbQNcqL0smfb6UV6XgOmFRQtphMx2kF
         hQaoFjkg7D4x61jWPPSyRXvnksvG8Dc8WF9cxHB+kIDz0GL8eETd6FS25ZiMGuG7ImFA
         3GxrYvGl2AlZHWlkCxtysaxXYit0C9fPSMKsRQINM2hdqHHRN/ige7H/a32G907gH39Y
         MoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769525779; x=1770130579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=DXAHDdMKYsB4fbcCDrMlIVsHRdOjzIVOGWWE5KayDD8pv70ghAPdR4qYUoa83MXMgI
         Ve1USQvdU8VmZGCYMnHX3ZRH3WXDTVhRvyhyo/WdiLTvpw403QoeI1Ea9U10s+qOkQlv
         0nR9uAFwUvtJMW3+spyV8vwj+KQ9gHB8ygkIDmIgxaZntD9iyzyABr9WueNCegd/lNf4
         L0H5QSsA+Fjh1W+t7EsiWSd578GqA/2fW+vFPqcdvulQ98lPTOXvJkfiYzF3Wl/3sUy+
         nSC3u99UpJWTXVgPtHVs2RLz18HbDf5oAC39fFm1j48Fct3negx3fvcN7VDznVFEDzD0
         lXng==
X-Forwarded-Encrypted: i=1; AJvYcCWIYbyt/O5Dj1qy+dy9Mj6zYHYaiwRXPmu1o0YnQj4c37mKMBjV6zYBlP2vv9MuU5gCltm7bu1FoqLnOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEoFIZKDdrx13cw74CyOtLLtjj94j3Hsqbpnyt/wU4sF7n4T6R
	WP0/iEpUJa7llhtaC3INR3eVtg3nMdw+cm5w5bzEdcFr/N15q+fKN+YNzUZZ0YYjbrzOdzMdbXw
	ArEh81SeLungAzxpFB0ruxXInTgDunQ==
X-Gm-Gg: AZuq6aIJLy09XLKtqZpw/o3hSazNtE40bAErtbTkFdh84wO8u9Fh6kiJlhnrijGEcFU
	RdnmQR7OiaI3esOgzkdmKkEdsgbDNUOE0dqu4r24VCTv5KvccoSa4nTqBHSfFr4BxK+0REo71oj
	jnkn+MWy9T1Te/0Gmf7OHdtHlzuh+K3XiBC397od8MGomOv3MfujPcx8tzOBp1ay2yGqot9yPTg
	X3sGv+F7pmTJLJDlxV4FPCIVtZhE+YeLTD0cLV2EhXKmsBSQ7M0WlIFWjJTYwxYp/Rm5Y3z3tlJ
	ALcEa935g5XgtWKLagPxa9QQQ0thYrA4lNr9Wv95MfC21zmNYu1XMNvnCz2kxWQbBiYe
X-Received: by 2002:a17:907:2d08:b0:b76:d8cc:dfd9 with SMTP id
 a640c23a62f3a-b8daca2128fmr161899866b.18.1769525779240; Tue, 27 Jan 2026
 06:56:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-3-hch@lst.de>
In-Reply-To: <20260121064339.206019-3-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 27 Jan 2026 20:25:39 +0530
X-Gm-Features: AZwV_QiAoKA4QtWy_y0NR6iP_vvxOusoftdbzNUmcHtGTAMptU2eKdF9ySt53aI
Message-ID: <CACzX3AtY6PBV58jXS=jwD-o6Dd=m_3HkB=jRp-3Xt4Ab_U+RSw@mail.gmail.com>
Subject: Re: [PATCH 02/15] block: factor out a bio_integrity_setup_default helper
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
