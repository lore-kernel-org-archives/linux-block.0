Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B207266B6A
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480708; cv=none; b=CyN4S4xOgUpWuKGL6RaTzqMU3qwf+Mu85zY1D86EWvERcERJqcfOENUZoQ+wg4MIOaxZRRjyg0qTsxCNkWPTbUSVVMPH2Umi3vZ8E7XTQpXC7VUPy0tD8M639ED7uY9MUJtzYrKXoHnnjG2CrJHCuwgduFEMC4T3QCh5TDZ8xZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480708; c=relaxed/simple;
	bh=U2Fxrw+ZWnZroV2gtVWjbt2Q37s+7jT2hIUi1TH42vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8Wy9YV3rEVMczBX0aSVn5oW3N6sRhmoyfUWYg77uwyIYo/bBIzT+wECuJAUK3289VSGQpjBpdV54edG/ilfTSEO5A1W+PVcd6VN211Gv2pz8sccttKawNqNvUK2EaUVcn1SZnlTL3Tuzf1WyH++/AgStJQ/2twwZ5ui+ovoa+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fB6zkoia; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fB6zkoia"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abbdf897503so1119451666b.0
        for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 02:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740480704; x=1741085504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mv1GjtLH9p6AAgaKLJdaYv1valnjqWPg00vkxZOmddk=;
        b=fB6zkoiaIdMgbfeIGodOK3Bc5hooKM6K1xm0XsoLN2PzPWLcJ0JpZ1FGbt9tU+fZj1
         cbH+/LkcoTXyyH7sdIjr+yizafF491qtIPOiJBtHMj6O7v5KdfCiPEpkgq4VYaUEdFbR
         RCzrlNVkOSokkiFb5dyCsTLf4Wo10/c4HE0cI+EvhHLduwLr1oATaVQlrIRvp8QZAnxx
         ZYVlsRJQlJkn8IL5m2vQ8ikz8w7Oy7eKBfSaYewdZL7UUZ0c7QntQTruTzMxqFlCnQg3
         ZOUBl6Rho1SsPEjNqrZKLsDD7Y19DsUiV3DC17C2pjx9XmasY/krW9B41OJFhoW6wpH4
         IyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740480704; x=1741085504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mv1GjtLH9p6AAgaKLJdaYv1valnjqWPg00vkxZOmddk=;
        b=TKj31bzNkjI8YGZVPdb6kuSTTKKTjtKTY6HCAArhzcSfVACTT7FfD387AqcH3K6ztX
         lVtUvxONaqL6GaAx0W6loxRhP25mYRn5QrrvbwGzVVv4X1S/ZZ0fNU+6mA/R03SLUcId
         tDXGw4gtM9NR44Cqq1YQF16HIJgwwi9Ev8mBiUgdat8SvimpIavkA6U8a2FW0HYJCLtO
         pioZB3ZjoU+61MOQfrJ2XHkOQXrMG/XdLR86yLmpDGiqZ//5CCkH5D9b8h2dXBQM19A7
         9CqksPV9/JMLuAuDJRmDJGpUKUULU6aJq85PTuLYSstAl5uy0f3dS1n7jbsOFWBhZiWs
         taHg==
X-Forwarded-Encrypted: i=1; AJvYcCXSHwybeOxr6avbRThTFZI8mahY4lm+aOoJzLO9y03GPsZNc1W5jK9cacpDN401lyO7R2tvoaFxmFhGTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfJIAX/Kc4f4HADOQi+amogi58SDMSLnf4Jbf6PZd4STIlcdHJ
	dpt373Wrz+c96S+WhKcUB86Bj4Eq/1eEfkJ1ppqm0jKqq8WgXtYqO+8w2zXNHdg=
X-Gm-Gg: ASbGnctT6JYl8q4asy9tVtvTvyCw7nwN2pZyC8s4AB8xP0e7++8ATWpzsEfmoYkwwFH
	Ve1nvGdq+JfaV5bDOhcR5sjLj6DXkOb3WfYcG9kh80ildWobBOlQ3zy5d7kkm7ai68A+KSAx6Gb
	tIDNL2s0y3AOzVe1n4VrzPIvqI+6IYbp/26kZf1pbauHPn8WNUpbhuh4VaAJeM3gqIe4OJYE+B9
	3q/44Z+TY+gpDZDgrkbVUXlXeL/dAaUq4ZtIuBIHz1K6C7HQEWK7Tnd2sTCfe2P71Z8ZG2sHOTf
	NYFum1AXS4EkFLYY0mIDLKk2HOJ+
X-Google-Smtp-Source: AGHT+IHUS8m9al3aYpp9dTro/BoJsAzrTMGGeZSSdFhetcpWcy+SNbbUKcmiFFvP72TdtmWFR4s3Zg==
X-Received: by 2002:a17:907:3e0b:b0:aba:620a:acf7 with SMTP id a640c23a62f3a-abc0ae5728bmr1777898866b.10.1740480704381;
        Tue, 25 Feb 2025 02:51:44 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1da1c2dsm121396366b.77.2025.02.25.02.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:51:43 -0800 (PST)
Date: Tue, 25 Feb 2025 11:51:41 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: ming.lei@redhat.com, tj@kernel.org, josef@toxicpanda.com, 
	axboe@kernel.dk, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 0/2] blk-throttle: fix off-by-one jiffies wait_time
Message-ID: <igzfzkwbbdywdvkbjzi624fgrc2jopnb6c4dpcrac644lazgbp@k63ht5r5ue4x>
References: <20250222092823.210318-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="teg6osmgnl3qwlc4"
Content-Disposition: inline
In-Reply-To: <20250222092823.210318-1-yukuai1@huaweicloud.com>


--teg6osmgnl3qwlc4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 0/2] blk-throttle: fix off-by-one jiffies wait_time
MIME-Version: 1.0

On Sat, Feb 22, 2025 at 05:28:21PM +0800, Yu Kuai <yukuai1@huaweicloud.com> wrote:
> Yu Kuai (2):
>   blk-throttle: cleanup throtl_extend_slice()
>   blk-throttle: fix off-by-one jiffies wait_time

(I haven't read through all of the 2/2 discussion but) if the 1/2 patch
is only a cleanup, it's more backport friendly to put it after the fix.

Thanks,
Michal

--teg6osmgnl3qwlc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ72guwAKCRAt3Wney77B
SXOwAP9fngBMH4Xn+ahF0Zv0RzYoYnjox8PuSgoFd8VeVVyVIgD9EMg0p69jzpqn
RGSQPrygGqTm1vbVYBMl+rzVsdR5Sgo=
=bd7s
-----END PGP SIGNATURE-----

--teg6osmgnl3qwlc4--
