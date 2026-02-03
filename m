Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01C43A7844
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128209; cv=none; b=Jzb1u+RvmJigx4VTZ+yovIZKQGw1b6U3KYOEcA1pSDAtrPNnOhp119TEX+Mq7EHw4HiFtaaeeDm8l7F3vslr4ojUZ/QlNAO/kBPnmQssG/P3KygDcGnzrplgzm8JOKcSW/vXfKUbUxHwvIkKp1mrhmisD34K8YebubyC9Z9LDos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128209; c=relaxed/simple;
	bh=/8AxLODon1dXJN5bmJReCIQSMiZZtx0ZY8XTK2Nzshs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ol8eUhBtG6jj0dssCSK7GDLY8FmG9g7StcnZ9GL+vsMTImYap1oaxnQBLvfUB+A47fz2GCy3yoUe4An2b/p23++MkX47A3q7/1RSB3d/cyhumZg7QpunzcpOfuSmJ6pWjlEJRyV3q6kFpKUu80fKa1B6uXQ1Fo3/cnQ5683gYyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PcG1pqvc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PcG1pqvc"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-480706554beso61632405e9.1
        for <linux-block@vger.kernel.org>; Tue, 03 Feb 2026 06:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770128206; x=1770733006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ID8QrMDweWZ/fIr/Kd9rCSwycKGCPJRwbxZfV8aqlY=;
        b=PcG1pqvcq3EihGWOtnuBK5lyITufEXcOd/wlSWMJIOs8esMNQL1MoEmxqVezthODp5
         HUQN6bV2smaiGL3oiY49zg/wyZTf3XiFhd+iBNIPEK3Ul7fivmL9E5KR9x42kPh46a/n
         Qu4msneb7WhOm8oyJO3wF00B9bP7IBB2UyjkpEtPiFjUN4cJoHwwxs0INv8P3a9OAnct
         hiAW41kvWk9lJv9o4KtLgOJ53O/mf7EkPZoec9ZXm0GpXEYisHDY1L/juCjS6uNps5p0
         rAslJWK1twzA1QPz6bTRKR3MsQpBIqk32P9C828UUuCTEmdyJfwH32bJECTLaYcWkbje
         Km4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770128206; x=1770733006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ID8QrMDweWZ/fIr/Kd9rCSwycKGCPJRwbxZfV8aqlY=;
        b=uYUPSOdBMRmlN54esYfQZvbrqFydyTpl1SgeT3PNVIc86rBFbBm2+SGz7a2bdKJ24h
         1i3RqgOdGWMTGK707dVJ1cXBhIHpd3mpj14ClVgu/wRDG4nDlGmS56VBhCmelUXFzZd/
         jopKni7rO4cQ1hXXltpiL20BMMH8Kpu2Omjn9vpfZN+KZfscpkMmr0NjuG4bhOu0QqdS
         ijvh0dIkbvcHgpIrv8x9AfnlnKt2cWUXgo/JOQKNsEb9luQPB0hKYrG71QfGPN2EOkKM
         08bbsqIq8kGlEJLIrw3FtejSXlir3+joM2aXdWXTGfaY+93U1mMqarE5/jhZZd9WNIyb
         +Y7w==
X-Forwarded-Encrypted: i=1; AJvYcCVOo/FDJvWhRQM6bIkm6N6Yq+c0hd8LwHaHqddK5YaCrwLMaPHAhsOnyYv89EcuEqr7OID/VfzcACpvNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbHSCoKqjJiXj3A20MORdqUJ/bfFOSUmA6Vv3k/OpIkMZ5RR+s
	WOE73n2ufaF0K/FMtDe9ggW3aCtMho98cUOo3mIcALRVArll0o0RZHynv9pb8kr0tUo=
X-Gm-Gg: AZuq6aK2yHnagRKFCJ7C8TYPS9zu4CVpD0vXXneQZ/uDcm2J0SWsP5nh0dIqJNR+bGZ
	w6E3oJQOUB6ZntbFASl36BLrHCOuX4htDu7OedA+0qyfjzb0R6ulcKXDnEdBMvVrt6TO90o/ywK
	0zr/LQjEqaofhst7gn6Cevz68cTut+CXraYmKza8rYWhTzzjMIEgCYa48rR1ML9MVHy0yjdRdue
	kkuzZPd4ghCjy/gWopYgVQK/DQplDXq2XYYop/TFMBeyXvtNRU/RaKUZBd2UEfGj4MWjk6Uz860
	BUZ8q0g8RvEq8UImUH3ULhhe7xVnzgPhBC0zNd4bL9McDYjfqt6B0MvXGuL/i2Yv8G56aDsJ02P
	37IqFoaqBqTvZJAtpXZY7KbPY2PcnGbWDF2U+zyo5Vp81tMgECQISTFdYQ/MitB4FVsV8leWzVz
	Jx+E8klgIUq31YY1vxYsXhBzgSk71mNmdkO0vdu+Stcg==
X-Received: by 2002:a05:600c:4fd5:b0:477:a219:cdb7 with SMTP id 5b1f17b1804b1-482db213bc7mr207307515e9.0.1770128205951;
        Tue, 03 Feb 2026 06:16:45 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830511cc93sm77479295e9.2.2026.02.03.06.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 06:16:45 -0800 (PST)
Date: Tue, 3 Feb 2026 15:16:43 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: =?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>, 
	syzkaller@googlegroups.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yukuai@fnnas.com
Subject: Re: [Kernel Bug] KASAN: slab-use-after-free Read in
 __blkcg_rstat_flush
Message-ID: <74zggmy53vzdb2q7sidvasnnlih5d5b4rp6jb6ibpka5zg7z7x@enl7iqw4prji>
References: <CAHPqNmwT9oRpem3J3erS_W0uSQND47LGGSBsNxP8E6uSUish1w@mail.gmail.com>
 <aYFlZf9p4cY0rIbc@fedora>
 <ffzrfu62npwacsl3225qqyjbhd6oue3x3rt46l2wcyp5oq4eli@26gvvst6hrmu>
 <aYHXzyRJbzFSohNm@fedora>
 <l55sz3sgogoyniecolvzscjamxqrxlzgk7w7scds3tt42z6atj@nrfvjqg2agib>
 <aYIBR6eeudRUQ9q8@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="czdjhrhidmglbtjn"
Content-Disposition: inline
In-Reply-To: <aYIBR6eeudRUQ9q8@fedora>


--czdjhrhidmglbtjn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [Kernel Bug] KASAN: slab-use-after-free Read in
 __blkcg_rstat_flush
MIME-Version: 1.0

On Tue, Feb 03, 2026 at 10:08:07PM +0800, Ming Lei <ming.lei@redhat.com> wrote:
> I can't parse your question, here blkg_release() simply needs to flush
> all stats. Why do you talk about preventing new flush? why is it related
> with this UAF?

What prevents this fix:

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -169,14 +169,6 @@ static void __blkg_release(struct rcu_head *rcu)
 #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
        WARN_ON(!bio_list_empty(&blkg->async_bios));
 #endif
-       /*
-        * Flush all the non-empty percpu lockless lists before releasing
-        * us, given these stat belongs to us.
-        *
-        * blkg_stat_lock is for serializing blkg stat update
-        */
-       for_each_possible_cpu(cpu)
-               __blkcg_rstat_flush(blkcg, cpu);

        /* release the blkcg and parent blkg refs this blkg has been holding */
        css_put(&blkg->blkcg->css);
@@ -195,6 +187,15 @@ static void blkg_release(struct percpu_ref *ref)
 {
        struct blkcg_gq *blkg = container_of(ref, struct blkcg_gq, refcnt);

+       /*
+        * Flush all the non-empty percpu lockless lists before releasing
+        * us, given these stat belongs to us.
+        *
+        * blkg_stat_lock is for serializing blkg stat update
+        */
+       for_each_possible_cpu(cpu)
+               __blkcg_rstat_flush(blkcg, cpu);
+
        call_rcu(&blkg->rcu_head, __blkg_release);
 }

--czdjhrhidmglbtjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaYIDRxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Aj+dgEA0cidUUMyuxGYzXMVhB4c
GuMLXVmDCaXI2MkrAu9fnrgA/ix6Pj9MOlUwhhBGeilNbf3LyFe5dTTzN3ds/83C
JIAJ
=HP1U
-----END PGP SIGNATURE-----

--czdjhrhidmglbtjn--
