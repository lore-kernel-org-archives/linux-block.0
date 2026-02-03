Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33068323406
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770116079; cv=none; b=Soaf3zv3BRd7zOkc1bLd+CQzxhLizFQzIniRMxJJDBSmDq52b6pg7EbTM/M5B5nLGNZk+4BH12aW4eF/iPrimG5+oRpXHxEDUeCBiuA9tFbn/PV19HU2BKbS7Z/untvT05a5ORUJGRiTiE+mtLMdI6AuGpqkEI7USiWqIcrgDxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770116079; c=relaxed/simple;
	bh=ZH71Nu88hsHG5/zlGLW9UgyzVfa1zeDXINj5mHKRrmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYcFB5k4D+hL9DxGFLh42vUVWhYh+Qth1tkJEvNaSqh3Vql6pOGD1BWe5xT8p6B+fds+OQvYdrC0atuByQUEdKOhji3aVqOAYywFcfWOFylhjx4kH6XGyqrqmoP7PUHyei6Qdf/URqLLX+M1uhklPkLe12WvU7M3M+qT5w4eMKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T08FQ5CB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T08FQ5CB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801ea9bafdso24195665e9.3
        for <linux-block@vger.kernel.org>; Tue, 03 Feb 2026 02:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770116076; x=1770720876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XebVXPSNdMrxJAnIqGRVfZUx1GAqbd6tkSOPzi0fCbQ=;
        b=T08FQ5CBYfkbD0iHW5HaKVN11vqTjVQhlR1+fZWHfxWmOEWycVcdFxEi+XU2Cq03d+
         OFKEt7Ic2xC1IJ7exHCHvQ3GeI6pxu7jOSWKx210o84u5CNuAfH5dOU+RoVfLwWoTGwb
         ac2Pz8wSHPij5xp8HqsATikAknqY7ro9LN6oP5Qb5aYW5XorlZ+y61y1IsfUbtGJYJz/
         Q8QE4VyfSDaPpemO19IW+9k0Hz6dDVT8e9TNxNJc70Xa0c1D24QWgxi0J2vMn3ohhJwO
         YG8WHB7IIuP8fbRudUmFF6P8PVWK6frbM75riNNr0lVUDriRhlgVEbgQ25llT70aZoHK
         hopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770116076; x=1770720876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XebVXPSNdMrxJAnIqGRVfZUx1GAqbd6tkSOPzi0fCbQ=;
        b=Wovt/v4szOKXSfZhz7/jcyrcw6n6t2n4k7lJXm7XfLFkPR+u98uG+hX9eUJcCV/Ylp
         r6+/ip94Wbk37MYA18/qAMJWdYxFb6HnTZG+zC7GqTQijp653h+K6ZxsAEsDSdgvI58Y
         Gf5lnFFmF4+FahHs5gu/Q8x7Tr0jrY3D6kBUIzmJSJ3VkKYskw2VebTJCOeiGfFT3lf4
         xqfOyVFeKJLT98L9WyWkpH4zmg9Vdx0dHgcSVM6qo2FHFFsJIX5A5KMRvuqCahvYFyjV
         tgD8j5H0fuULAMYpxRcnbL2qsdDMMmyQMT4MVOZfd/Bdgss7DrdXH38l7ixNrVFT82uC
         UUGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8pvq7LihOECns7M1B7v2c/GWmQ433eQMEz5tTEJq5SNSYNAPs5SndzLMvAwW7ALTaB3OCphHONqyWzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKt90HOVsnuywk/p5tdrzKXcOThs4e9JNC0Qlgj634DRC1Jy1g
	uUbS+7bqsXsQCg5nRa62Zf0DjQu5WopwwAUdbnvwIbfWbzN6Oq/ZnAdZ1Uhz+k5uRIA=
X-Gm-Gg: AZuq6aIf7ELd4PDI3ihng5NPr+ySVKRnBAgCnC9mnwFdHXXSfB8kKoZXBYQqFSV3NYr
	do6ElSfV/HXfJvGbTeKkZ8xBV9PmwIk3yTIOOI1z3nA7BTqnOdR6EnSDJX4iuPgEZh1npsPqXyu
	yhAmwdbXfmG53QK+90go+AbW3qA5Kzsf8GPXF8TOVDyuKMKWoS+hly4JzXxyWBkfmzKbpa5fqJi
	0hfdy9NrZ/z0zGsnVvGbuVuK6GQTc5xzd9IcEyu4qU3kmTeKeI64JGP5IsLZvwOEuYiK0frP2UT
	Q8LBhuLlNHmgelbEY206mFuwkoAzaECTBtVO6rdpyzBAk2VPGwohBrssutuX/K1z5zteGh9W+9b
	8pQAqatWR5u1PdjqZAfgqZ8Or+yRg436ch/ZJRlayWjP53cLiIwCnP4knTuBJDsttHnRaxQi5fD
	B8VopEMuEEIM+UfZp1hn2W3X15J4DEHj9z99L4DK+DSQ==
X-Received: by 2002:a05:600c:8b2f:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-482db48c8a2mr188218615e9.19.1770116076560;
        Tue, 03 Feb 2026 02:54:36 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322f40sm49312022f8f.34.2026.02.03.02.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:54:36 -0800 (PST)
Date: Tue, 3 Feb 2026 11:54:34 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: =?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>, 
	syzkaller@googlegroups.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yukuai@fnnas.com
Subject: Re: [Kernel Bug] KASAN: slab-use-after-free Read in
 __blkcg_rstat_flush
Message-ID: <ffzrfu62npwacsl3225qqyjbhd6oue3x3rt46l2wcyp5oq4eli@26gvvst6hrmu>
References: <CAHPqNmwT9oRpem3J3erS_W0uSQND47LGGSBsNxP8E6uSUish1w@mail.gmail.com>
 <aYFlZf9p4cY0rIbc@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="om5bwzeo4m3sw47s"
Content-Disposition: inline
In-Reply-To: <aYFlZf9p4cY0rIbc@fedora>


--om5bwzeo4m3sw47s
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Kernel Bug] KASAN: slab-use-after-free Read in
 __blkcg_rstat_flush
MIME-Version: 1.0

Hello.

On Tue, Feb 03, 2026 at 11:03:01AM +0800, Ming Lei <ming.lei@redhat.com> wr=
ote:
> Can you try the following patch?

I think it'd work thanks to the rcu_read_lock() in
__blkcg_rstat_flush(). However, the chaining of RCU callbacks makes
predictability of the release path less deterministic and may be
unnecessary.

What about this:

index 3cffb68ba5d87..e2f51e3bf04ef 100644
--- a/tmp/b.c
+++ b/tmp/a.c
@@ -1081,6 +1081,7 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, =
int cpu)
 		smp_mb();
=20
 		WRITE_ONCE(bisc->lqueued, false);
+		blkg_put(blkg);
 		if (bisc =3D=3D &blkg->iostat)
 			goto propagate_up; /* propagate up to parent only */
=20
@@ -2220,8 +2221,10 @@ void blk_cgroup_bio_start(struct bio *bio)
 	if (!READ_ONCE(bis->lqueued)) {
 		struct llist_head *lhead =3D this_cpu_ptr(blkcg->lhead);
=20
+		blkg_get(bio->bi_blkg);
 		llist_add(&bis->lnode, lhead);
 		WRITE_ONCE(bis->lqueued, true);
+
 	}
=20
 	u64_stats_update_end_irqrestore(&bis->sync, flags);



(If only I remembered whether a reference taken from blkcg->lhead causes
reference cycle...)

Michal


--om5bwzeo4m3sw47s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaYHT5hsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjBlAEA+pA79J0qs+XvKea3uo4M
AQ50Yt4XmSII2ywcpyrrZyoA/11CWP4Nn4BpuWlnQDGzcmWM4UOrIG8XHCGOsJze
+v0K
=YQs9
-----END PGP SIGNATURE-----

--om5bwzeo4m3sw47s--
