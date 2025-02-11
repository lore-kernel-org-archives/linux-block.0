Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B38E23099C
	for <linux-block@vger.kernel.org>; Tue, 11 Feb 2025 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739282235; cv=none; b=I4jv9ZSlgkuwYkEiEGpRlR8cBEacKyIaR5E97PpjNUQo1hyfRa2NWmNDZdUayPlGPCZ9Vg31D1whLQ6EEYEN4dvJeQppoNx/YFQSDEH3UbCcrdDp4zdztQB6rtPxWzq+Z4yFR/p53ut3XWroQda+BD/himwkOATyKNg92EPTPS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739282235; c=relaxed/simple;
	bh=42SkK/uGcPe3+X1XXQFJq5L9WLaDP9DsrXhpMr8UjQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXghYM5dFskCa/tYgXUBrnbsLJ6KEO6sW5APDDSzoL4ZRS1WR0DiQjv/NjLdwNzRJIlhh+QMuIbvUloI9d0l874RPKaxf8xtwfSpDRTnyPVoB0oGLUKgz+hws1ktlfJM6xZbosLfcKjC2eeb3KNjHXKp5s8ys2oMU1+JLjXPEM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WzvSrZNn; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WzvSrZNn"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de3c29ebaeso6749483a12.3
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2025 05:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739282231; x=1739887031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nc2Fbe5I0sSQTKOy2ZPiGOXHCFIjUyJawnB44aSJiHk=;
        b=WzvSrZNn1GiR5/VEcF2TfggW/UApynWXIGK+sMv+D7KY79IhJqcH9XFgDJC41CHk4B
         R/eoF3Oz0MStjrRPbi0yBVrlMuSfLJ09C5N3gY0TxtMaetUB7rOZ3/wRIYrvDQ7GxrXA
         /icrdFLtEVDqpBqKlRxhl+7vrmYLh40eU7tXUn6N9yjwkEmtJxm8tlcepbaIWzeSAzdn
         WU7uPn0eSuM8HB7GJTUL5IHPY5uHds1a/Qs6EiHup3dR9En2XsI8V+S807MpEuWmCV+Q
         zwqYAsPY77GWnWRl/+uFdEJguzuGR+9nZ/emqDJz5ChP2qwgJWhi0vWXM624WjE25T6m
         2RWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739282231; x=1739887031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nc2Fbe5I0sSQTKOy2ZPiGOXHCFIjUyJawnB44aSJiHk=;
        b=c2NcnL/7vqpIY3TnrR8NoJIsbRoc2gSTp5veB6PtmENhSPqQnLwQAj8WGvszSvvzFM
         /XAPsSU9ncNvgvNCznq0XvbBNRdwcwl0ysZdguucWd6OnMok6vckWdZGjIMi9dHFLF61
         pyXHDzpLl10ilIgLRMKhPbC91HTkpLQouBfsQlmSF/t0awfBIbkYR8cFbUZw6bHKAkn4
         rU0umqXV37q6mu8CHRi2ORFWsg5eTRrtfmHfw6kt+gvR847RK4QW1u34wWLSTtCeVARr
         FMBPE+i9tjKpIg+EGPnYPEaFxADFpW6c4s7Ly4g5p6yL6A/8H/qFzrnl5bAgI2tAsC+x
         xASw==
X-Forwarded-Encrypted: i=1; AJvYcCWVkwjl77GOrFwLnbLEXsUTloBR0Alx6lDHyGBfSbUWB+1VVhkqKE/hiW/qBmQXwYR8nXsOIeUnXvUNIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxynQV1PuN1QyM4NyaNzdRchtJ0mtSw6fTV3l6zZszntZ5NN6Ij
	WB3+wADXAjHl44tPILqqe1UgrcFED/909ZjjF2R0jfcNwDJgvNwYjUFNRuw9DRU=
X-Gm-Gg: ASbGncufJ2KIC5fqGY6GxY6hNJGVI37mxt/d/iH4xOuOuBbWlMclK8BEr5hHI7RvyhF
	Ee+KGE1710ojJmVq42ULSTcOGBWxH4UqC9bSm0MkTL1cbf3hjm6xHZXmGTlSzdHz5+m4/vT72JV
	jPDoAP9Ov1wQFYVpNGX6iu0/nlPs84CpzaD4tqqQOB1xNDCjpRIpsXOfXnV7z8iHplbxG8r2Bw/
	V5vxFnn59CSoJwYzo+geU0rzM46d568YpyWvmxElSwJQ2lTmAlnZ+6WDKC8tHYoaEoqtma9jMac
	RdS2sktTXLBDAlYJGg==
X-Google-Smtp-Source: AGHT+IHOOumXj+rsEvDgGNfsD2H40sBsAx3FPNbbQOsVuk+Cv32qwjEvbWYK7p7fjHfp7cQhzJxRyw==
X-Received: by 2002:a05:6402:321d:b0:5dc:1ec6:12bc with SMTP id 4fb4d7f45d1cf-5de45087800mr21024023a12.28.1739282231515;
        Tue, 11 Feb 2025 05:57:11 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de5941e014sm7157341a12.50.2025.02.11.05.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 05:57:11 -0800 (PST)
Date: Tue, 11 Feb 2025 14:57:09 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Jens Axboe <axboe@kernel.dk>, Wen Tao <wentao@uniontech.com>, cgroups@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-cgroup: validate alloc/free function pairs at the
 start of blkcg_policy_register()
Message-ID: <i6owvzwb4pjg27tex5utdzcoyeeawqejegvc2byz6tnfn2flmh@2ggun5qyokvs>
References: <EE1CE61DFCF2C98F+20250210031827.25557-1-chenlinxuan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dllvaf3vwm2keh2z"
Content-Disposition: inline
In-Reply-To: <EE1CE61DFCF2C98F+20250210031827.25557-1-chenlinxuan@uniontech.com>


--dllvaf3vwm2keh2z
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] blk-cgroup: validate alloc/free function pairs at the
 start of blkcg_policy_register()
MIME-Version: 1.0

Hello Linxuan.

On Mon, Feb 10, 2025 at 11:18:27AM +0800, Chen Linxuan <chenlinxuan@unionte=
ch.com> wrote:
> Move the validation check for cpd/pd_alloc_fn and cpd/pd_free_fn function
> pairs to the start of blkcg_policy_register(). This ensures we immediately
> return -EINVAL if the function pairs are not correctly provided, rather
> than returning -ENOSPC after locking and unlocking mutexes unnecessarily.
>=20
> Co-authored-by: Wen Tao <wentao@uniontech.com>
> Signed-off-by: Wen Tao <wentao@uniontech.com>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>

If you consider those locks contention a problem (policy registrations
are "only" boot time, possibly module load time), then it's good to refer

Fixes: e84010732225c ("blkcg: add sanity check for blkcg policy operations")

> ---
>  block/blk-cgroup.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

But it's correct,
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--dllvaf3vwm2keh2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ6tXMwAKCRAt3Wney77B
Sc0OAPsFfyTtfA9SZMEqJj2m4PnsUJUwkX/Vql/KV067dSlbYAEA/XZ7eLxelz4n
RI4kpp42WYSfhwBMT9/50Ya9coA9eQQ=
=IM8w
-----END PGP SIGNATURE-----

--dllvaf3vwm2keh2z--
