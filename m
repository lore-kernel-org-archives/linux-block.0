Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D3C1E376C
	for <linux-block@vger.kernel.org>; Fri, 15 Nov 2024 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685529; cv=none; b=uDNnCCCAsLD4vRAXCnD02EF+X5opjnOr0bVlA+TsHft1UFSFv7h0TBKyEUfK6+EZwLrsk06r1ZZWTdsluc8f8N7bv7FWaDjEjyGydAbtlru+OczTsrZ+i3+hc8vysgULPbkfb1Y4/QKAV4RdZEq5yDoOtOyIzQtRI+h6GeMiq4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685529; c=relaxed/simple;
	bh=9FFH6fI16GRqVNiLffzMOW91eX3sSjbt+L1GoUi8Rnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQ+3SVypH3bni8bM/L3G03IrrlplxYWczb1RjTFscx91bUfNoWJjxNiXkg0ap0BQRFhg8uMK57MwO+a/CES+asG0NKSDabr0nUEaSkwnZg+Gvwa93CYjA1RryRLej5+lWwLFYETMcrwtpxGtcdaEjvTeXXZYaH2DNc/5g4klvFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CUehZe47; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CUehZe47"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43169902057so16105745e9.0
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2024 07:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731685526; x=1732290326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9FFH6fI16GRqVNiLffzMOW91eX3sSjbt+L1GoUi8Rnk=;
        b=CUehZe47+1TmPe9L6O/qxwhEDYj2TPtGXu6a68tBrHZXYs5+YULQmyOFvc9PuGL1Kd
         270IzO8ASD5Pn4mj/UZLg89FC1sgphhdXX4Q6/gRcFXLsXq7ADfrjdMrnnCmv1U2iWkg
         EmDmtVkiXup6Iu0DGR8BPNrre7r970qJeW4UEZAVLwrYTIJR35i0f/hRgsx2Vy6y97LS
         c8iD5IjV2DyU1xwSGqCbOl11qWdVXpf8ec+mYDXgN6bXqy6nchiIhYWd9bXxH20WjgAK
         LCyY7DumUBTV0r3uCnYa22V/N256AfXRl1o/eemV3gB6lW4jc5MY8o/yNczmeY8TuUpQ
         /yNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731685526; x=1732290326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FFH6fI16GRqVNiLffzMOW91eX3sSjbt+L1GoUi8Rnk=;
        b=Nbreh+gX13rIEL489xenx1+IDAK1bIDWGkwZ2y+Xu5WTfsDjcwbKXnNbRQaiv7jYlT
         UQwajIG54xlm6MBs/1v655nUwpMFBLhZjPDa6Rlm1B0EB8anvbIvoe5pUAvK39bP+x3D
         BAt2l6WYBsVqyvLgG2bK1/5fEXov//qSL61txInOefQTr7bkviKmL3F+HhD7/BJR6XvN
         W/mSJMBlyNUwRinJsFJ2h3Ke3dqSceAWjpuq0HguyUOmk0OXV9Kda528wn+7RS5Xf6BK
         xn3RVFB6fTIaCPhGsvjsC6uQJTBkv4rBwNkU5BXm3RgK/T/H0hm2ri+JznVvX6su+eHy
         2ODQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp6TdkyNOu/iBuVdMgnxiw4q0ZDQesfsQK1dAwnt2YPJL2mMtX1CtNm+Q8vrfvEbwRo87/Fb7ELi1deA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yya/VBq2u9v8B6apFLf8AwaPH3mbco80i3Lp1j0ir108+0RJFe9
	gWC1wZtpi0rxj/2+cy8t7zKPmvkHq1L5D2S9RZ7TKT91d5Y9MzAxyAWBAlzsdak=
X-Google-Smtp-Source: AGHT+IFMzkpB5ten8aStGI5U0itCRb9SQJnUjz1+wqgAB5ntNpoiOJeeloohYfL8pax+nnjaE0HMrg==
X-Received: by 2002:a05:600c:1c09:b0:431:5f1c:8352 with SMTP id 5b1f17b1804b1-432df71d609mr27024635e9.5.1731685525955;
        Fri, 15 Nov 2024 07:45:25 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac0aef0sm58557685e9.28.2024.11.15.07.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:45:25 -0800 (PST)
Date: Fri, 15 Nov 2024 16:45:24 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: ming.lei@redhat.com, Jens Axboe <axboe@kernel.dk>, 
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Daniel Wagner <dwagner@suse.de>
Subject: Re: [RFC PATCH v1] blk-mq: isolate CPUs from hctx
Message-ID: <qlq56cpm5enxoevqstziz7hxp5lqgs74zl2ohv4shynasxuho6@xb5hk5cunhfn>
References: <20241108054831.2094883-3-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l3kcsrkvzzccsahc"
Content-Disposition: inline
In-Reply-To: <20241108054831.2094883-3-costa.shul@redhat.com>


--l3kcsrkvzzccsahc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Fri, Nov 08, 2024 at 07:48:30AM GMT, Costa Shulyupin <costa.shul@redhat.=
com> wrote:
> Cgroups allow configuring isolated_cpus at runtime.
> However, blk-mq may still use managed interrupts on the
> newly isolated CPUs.
>=20
> Rebuild hctx->cpumask considering isolated CPUs to avoid
> managed interrupts on those CPUs and reclaim non-isolated ones.
>=20
> The patch is based on
> isolation: Exclude dynamically isolated CPUs from housekeeping masks:
> https://lore.kernel.org/lkml/20240821142312.236970-1-longman@redhat.com/

Even based on that this seems incomplete to me the CPUs that are part of
isolcpus mask on boot time won't be excluded from this?
IOW, isolating CPUs from blk_mq_hw_ctx would only be possible via cpuset
but not "statically" throught the cmdline option, or would it?

Thanks,
Michal

(-Cc: lizefan.x@bytedance.com)

--l3kcsrkvzzccsahc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZzdskQAKCRAt3Wney77B
SVLLAQD/w8EP314EpkVv+CS8Q78tZha++i6qmCnttn45QJL5UQEA610FW1x1YqKu
ee7dMxr0W1ccS6lUwnBt6BpNAH//NAk=
=/uKX
-----END PGP SIGNATURE-----

--l3kcsrkvzzccsahc--
