Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C249E3612EA
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969880; cv=none; b=DeVWViXbu4s4UWTfJ0WcUMXG4foO45yk2xgc021t4GIrVGc6nw3lY8bJOZMrAbEx968c2xWNBIjACCS/TKa1xeviNdpNWwSFVemWQv2Q7ooS03QeQCKakbRCvuFjQr6kbTkY16XC+9hmlH6v9ZTabZToLWvVWa68avNH8ksQA4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969880; c=relaxed/simple;
	bh=/1+Y4xy4fXPDI+ucFHeswujk5sqRoZi9rm5QWGYirNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF+jhr9rC0CK/s0otAtIo8uzHS3vuzcSBohDHSNp/+pbj2GnFfR2Wan1sJWYuReHJYcBZrRI6WCbueOu0VjsnCqM45n9UF7ZbiYzrV5GpH3Pm+j1QmO0eG7qCzj5mLkXeKJ6q62SRcklmwV0Fnl5Nls4+JPGNp6LLteb1lsLwhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=byYqCuHc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="byYqCuHc"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47774d3536dso28385775e9.0
        for <linux-block@vger.kernel.org>; Fri, 09 Jan 2026 06:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767969877; x=1768574677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/1+Y4xy4fXPDI+ucFHeswujk5sqRoZi9rm5QWGYirNM=;
        b=byYqCuHc2gGCdX631PDgnpi+b/A1HSPGUy6zLWlxomwuu8vi1koDw4ecHqwnrYv2Vk
         PDoSsSjg/Y/1o3itkhfH/fiMspLBm98rPJ5CdpDxfNI5dMkJm83qQhWXrbpS4pyMYMNk
         fhb/REApmd1h7f6YJduY/poyGiICcJSaGZsKRV0JGgElW4Y7Yz9N1qX2uhpSRLsu/szm
         8IUdORu19hdSyL7/dxjxnXOSl7i7Md98FsS2km7RFVY8/tyT3pqJJp/LDbJh3HUL7NlV
         znj4g/oPh9HB+ocZ3Dx+K2QekL5k37OFQK5BJld6vif+HeKZdjwxKCwkGgYbvd4EaXYT
         XGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767969877; x=1768574677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1+Y4xy4fXPDI+ucFHeswujk5sqRoZi9rm5QWGYirNM=;
        b=S3m1QAmrhdRlmyGBW2n4pNen+abTqnv8QDDQQbcYQxxjV7MSQ2Gv3AtxI/210pRorK
         0msX0LoiYpVLuLeR6154xKUMx+Rt97pdwCn5TocNWO9r+sfx2U/oCZgmQLFMIKo5tey+
         xqhXwX671DDCn/mgWy9TAQXhhm6dXmMW+ecoawt8FGMSsOoZUFBBM8d0INSI/cv6caoK
         lYj5veC9B9ybmYAQK2NdONazVuYXjCwiLnRWzIp4S0Ggwd4AGkjakOyRWvvLrXf2LLI9
         pw+d8VkfUtyyvdkDW/bDFJbjIsGSAk9i2aWzJAaHdKd20Obnom5WtzXP3+ynWBf0TGqd
         8BnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD9umZz4FWIt+c+Z6tn0txLfHRc0WlGpXWRsOc3kOi2OWCT/5V6H3bjuO/7VPKhjvcug9EbGaosMA1Sw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwYraW+u6K7Rj5rBLD1UUrzO3rKTERiU8Uw6C+d144ME3SNj1K
	sScqTLRNnzJnXooDkcMjLGNYQO0rCBZjzir73J+Wv8g6axrCEloiikC+wgcldRoPNyyQ/sT1Stc
	KY8iG
X-Gm-Gg: AY/fxX4lZyMWfL0oGYkKEyn7P/gRrOlNIITvCsWlTxTAqFl1I4y/QAnNgEFypMsqCUI
	cICW8iH1MchCMqw5GQImi0ovg3X+5vzujCcwuK5qfbMg8UR+21ms15491wLfT7ZkxMarD+yCMaf
	DGGZBbWUVkW4yJ2E3hWrHGpofxHwogeWO5HQm78sFU2u+1QABJF0AIJPfZ4WkD5EwEr4l3l/h91
	DRmeJUZlimyivmb5zKLn41gJsSX2jXcYQdvwOWcqDFywu+ud2u1cnO+elTF8a1raYnGVfqady28
	Hw4KD8qdOY4vTYE7KEA8ggSsvCIrvrRquSBIMpXQ8ztMPn7MtJi9Lh/ieYCkuk43F+A2SJ6jLXD
	YHE/TP4oJ9G0PtzjOfv/OORh8S11AVwf4wXmYQkK6VbWyWdZrpkZ3Mc0gKB1/MvuBf+WLXfpZcQ
	GVQtgvRFlQFw+5lPfrN9OhSSONmc9hmC0=
X-Google-Smtp-Source: AGHT+IH8FOAwnYy4OZuYKVuTUkzsl5zvNMupDK3PWM4j2did/Ahw9oYwLrTudoKw4NQ1y1JmyWkZcA==
X-Received: by 2002:a05:600c:3541:b0:477:9fa0:7495 with SMTP id 5b1f17b1804b1-47d848787e3mr128657395e9.14.1767969877156;
        Fri, 09 Jan 2026 06:44:37 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm22648070f8f.31.2026.01.09.06.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 06:44:36 -0800 (PST)
Date: Fri, 9 Jan 2026 15:44:35 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, yukuai@fnnas.com, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, houtao1@huawei.com, zhengqixing@huawei.com
Subject: Re: [PATCH 1/3] blk-cgroup: factor policy pd teardown loop into
 helper
Message-ID: <heoizkdewdbvczav4xa4fylnkbswb7sjybt5naw7jlafbzmvin@tctcbn5oxqmb>
References: <20260108014416.3656493-1-zhengqixing@huaweicloud.com>
 <20260108014416.3656493-2-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ywuwths76adpwenh"
Content-Disposition: inline
In-Reply-To: <20260108014416.3656493-2-zhengqixing@huaweicloud.com>


--ywuwths76adpwenh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] blk-cgroup: factor policy pd teardown loop into
 helper
MIME-Version: 1.0

Hi Qixing.

On Thu, Jan 08, 2026 at 09:44:14AM +0800, Zheng Qixing <zhengqixing@huaweic=
loud.com> wrote:
> From: Zheng Qixing <zhengqixing@huawei.com>
>=20
> Move the teardown sequence which offlines and frees per-policy
> blkg_policy_data (pd) into a helper for readability.
>=20
> No functional change intended.

This rework isn't so big, so I'd leave it upon your discretion but
consider please moving this patch towards the end of the series.
(Generally, eases backports of such fixes.)

Thanks,
Michal

--ywuwths76adpwenh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaWEUShsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiA0wEApu7S3lwu4BFXk2atN0ZG
Rj9eEkFVhXMjypkS3w+UiE8A/2euYms6kN4Br0fW1U7H1n/OS2G9qKo1fkYEd7DB
2BQD
=Dv65
-----END PGP SIGNATURE-----

--ywuwths76adpwenh--
