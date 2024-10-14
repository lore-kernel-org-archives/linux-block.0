Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8F329CA
	for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728924333; cv=none; b=A6ZavpnbLhnjR9o2ncysBNp63+xmebcGyc2MItizjsg8ynJm10ngy65A4/uGhUsCN31/DQbki6S6NlzMhGUaRdeQ3O9BC2GWKuDQKyCKeb4Mxei27sjqpSk8fk7KjtZ1lSAzoROiqMw5DCfFM4r2P+bbBI3/nXlaXnDEyTuxE3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728924333; c=relaxed/simple;
	bh=grYIK9osXBs31UEgg648AG6dUiZ52FwAEW7cDwHQwzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7O80zagGqnMT3Yh+A4MaFsxaxcQntUc3WwjNWPJ/JEUMjlCm7QdFpeYtcytHVq3eyW5gWwR0hOlotzdPmym0R38FAD6MjafRFGzT8/xy5wqTEB+cADUQ8KnaGu9s97fBNAujz3Vbj+e9aty+BtAjJLI2Wiz1liPvPebMOQwudA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RIiMmsoa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RIiMmsoa"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43120f65540so22253245e9.0
        for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 09:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728924330; x=1729529130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=grYIK9osXBs31UEgg648AG6dUiZ52FwAEW7cDwHQwzw=;
        b=RIiMmsoaGd4GeTwcwej3z4C8tfNkZ/xd9ywOTT0+xU6wyATZhB/ymXky30bnetAAXe
         gEjW/wkZoRiCAGlGsSeRX3yLSc17tiF/Bg5M0WnRqZE1Oy4LA94iIYxFTCteESB+RHfN
         kobQpdFg+vgCYLguTUXXjA2StRpMHhj/lSmcYRzggQm6E3dUc2h+kJr9e5gy05ohiISQ
         io+P5eRkggtQWgp6A6Rd4fXt4wi3HHPk7+ieoyiAK9Pk48TbQc+7TCGjKoRctcln0NfS
         vp1Q1uoMxy9dgvUBLTwTuO/iTvQuYlixsGRscPHnj3pLvdQh0GJjE+u+XYMornqnVoZT
         V8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728924330; x=1729529130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grYIK9osXBs31UEgg648AG6dUiZ52FwAEW7cDwHQwzw=;
        b=T8eDyKEP1vuPco+EX+6iE6W6Po3dcIZJNwUjAbIUS+JX9OKaEvKXq1QWu2vRK85auu
         AZIu0Wt5qYS9ip2DztcvRQQ5fUOkXBjBkRUDz788QCwuDwCQf8PUPKlXF5BdMN6pfnsh
         oLXvxVZcrffO5NBxE5AGd5NZ93mvN8IKjnHF+bXvT7NbkokYnBXxNlmFVr23RDwVUP8w
         TSkhGgAywY+ew6ZJu2vcH/e2Tamcrn02ROBdb4NsNvYGUhYM8PVuIA9TTjM9poVKxQAH
         DM5WA8+e0PCxBKc1Mfk5Byg7a9VeK65uAtKRRZtk7vJFUEsUHF5TPHRKrDxsSVGvpG5s
         me/g==
X-Forwarded-Encrypted: i=1; AJvYcCV6+kyDh/Y6IC0hAFZp84czxVhi31KrJ709k3LYFc86KixeQecKGfA5uyRN8yiNNjq+BMkOByDmjieRhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmVezdEq1EyhubPz87UkLOJyYFXorfmQyA5tBFuj8GENqGLYo/
	HTvTb5IpGIldqZ44HZ0PJlnu+kKEa0CTNGacW2avhYRfsBAp3StBTDceKGcwkNY=
X-Google-Smtp-Source: AGHT+IEPD/piRW2UpqC6E11an6S8QYVfY/9TiIDZseUGBgsVRSIPbykwzHPL0EGPEZdRGbjvGwPi+Q==
X-Received: by 2002:a05:600c:3543:b0:425:80d5:b8b2 with SMTP id 5b1f17b1804b1-431255e4113mr83913985e9.16.1728924329666;
        Mon, 14 Oct 2024 09:45:29 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b444csm159006015e9.33.2024.10.14.09.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 09:45:29 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:45:27 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Xiuhong Wang <xiuhong.wang@unisoc.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	niuzhiguo84@gmail.com, ke.wang@unisoc.com, xiuhong.wang.cn@gmail.com
Subject: Re: [PATCH] Revert "blk-throttle: Fix IO hang for a corner case"
Message-ID: <dgfa2ehxmdixfi2fu32b5kjoyfpbd3ew5e6rmzxpcy7crwctaf@st4s4df6nvuo>
References: <20241011014724.2199182-1-xiuhong.wang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uztwfvhsighpltti"
Content-Disposition: inline
In-Reply-To: <20241011014724.2199182-1-xiuhong.wang@unisoc.com>


--uztwfvhsighpltti
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Fri, Oct 11, 2024 at 09:47:24AM GMT, Xiuhong Wang <xiuhong.wang@unisoc.c=
om> wrote:
> This reverts commit 5b7048b89745c3c5fb4b3080fb7bced61dba2a2b.
>=20
> The throtl_adjusted_limit function was removed after
> commit bf20ab538c81 ("blk-throttle: remove
> CONFIG_BLK_DEV_THROTTLING_LOW"), so the problem of not being
> able to scale after setting bps or iops to 1 will not occur.
> So revert this commit that bps/iops can be set to 1.

What is the use case where the difference between 1 or 2 matters?
(Unless this is meant as a cleanup, then it makes sense to me.)

Thanks
Michal

--uztwfvhsighpltti
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZw1KpQAKCRAt3Wney77B
SXyMAQCuAyDBL/Tk0ei5q1tJj97Fl9PrFECqf4yehX8sZ8fJDgEA53yyuPX0IL9y
WsU9rCvia5eXmIaIry0DtV9gUfy2twU=
=JUxf
-----END PGP SIGNATURE-----

--uztwfvhsighpltti--
