Received: from mail-oi2-f42.google.com (mail-oi2-f42.google.com [74.125.231.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DDC332EC1
	for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 05:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790400273; cv=pass; b=gdDmP4rsNci2xg1Gz14l/Sr8jyGKqxbXbnGKrYyaEyQX412h1wJ2o5e/Xdq2QlnhfI8bZ4Ay6L/4TwbVlfhqFzRhW/EgtXLGzQc6Daf6pDNDGUfEeUfLmRzZAZpeZxnWMWTKRHQjN61lPY/y+oh9THwN7EeOE2gLwnjtyI335yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790400273; c=relaxed/simple;
	bh=Ze+iI4MPN/oMczfNs2a3p2CNrjiokST60jo3zEacJNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPEJBacpAx/TTO0amxt4qur3PgQ5anRQQhJ9mf8Ac1Ba+Jl1vPKfaY2gP8f30EKEN2FH6kCS12Xhwes8BBSScPpfvcVwuQtKZoWgTVFmWIquzy6XYNA6srvETJ4PWtFu56fLhP1Ey6d4+Vr3Zak3pqlScryo8dnrgDWXTqUZ7U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhC413f0; arc=pass smtp.client-ip=74.125.231.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhC413f0"
Received: by mail-oi2-f42.google.com with SMTP id 5614622812f47-4db3c747ad8so962219b6e.2
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 22:24:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790400271; cv=none;
        d=google.com; s=arc-20260327;
        b=bmOSAoDj6Kc+SHcshsGNUwsTLzG8ix0+YU4pYIuQ0jkrBdugDPvuFhVz/5AL4TpglV
         nuvTvoHJ/hme5PVvKxIMXAubwaN/4BzcAz4w1CqCvnPXBj+iLn+U1kQ7aldbGcYBCuMk
         7OtSTia7EwxSeewvO2MkSVvbSMHajfVPeg55X0NcQimRkS54O+igRNrgDX4SOufp8ejr
         fJPxkINqVxWhn3hPVVJWcAMhLbvrp4RfgEh9WkYbMuS0ESIXl98yQPIBhVL1A/m5apBw
         VqE0wS90V31BS52ZG9gGAHKTqfwYCLdW9tj+qR4VlzDwDEUrnP1jIN0OP/p0o6asCazI
         XACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pVIiyRqhME2rfVYUFjEtU86And7QcpxR5cM22u9g16Y=;
        fh=4QmCaoLNu0/neogvBYL0LbXbChITkiszS5F24wtM5vM=;
        b=bsFfcZW9Wy8rdAs48LHEqdgDYE2/uUBYt9i5+QI1eJHnKwFLeAf7e87AOTst7Sv0PP
         N+/kmV4stq6XefwcfdXWqA1KY9S+wMnmjf78HglsrT16PgHHtbOeS69c/2gskVRADzM7
         e/MVJNT+h655n/yECbYILXZXraCpiKXtMsuEAWWWWe1wskHpthdVF/V7sLlKr9OsWr2I
         6avRnc1g0ULfx2FTAfFhyFutvkI/zlYisachXXPC1iyIx/WDi0UhGgvF0uaGGUmNDOw3
         nP59UAuUlPyGi+fSKyoOnyuqikkux62NLn/Ex4RbkMaCSA/uY/o4aOXg4Cv2b7uNAp9J
         YxHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790400271; x=1791005071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pVIiyRqhME2rfVYUFjEtU86And7QcpxR5cM22u9g16Y=;
        b=lhC413f0KgQOdC+OVF69nUzsAbBPV2R89p7MwBEF/7uqDsT1WzPKVJvV/YGxJ3C1dv
         Ww475qQIypBc7OJKcWv7NtfbP6gZwG1NeE1X7UO6OQZKhL0AxjqQaJBJrpmHq2vzbqc7
         JfOcLAyXy8x2K9tyXEf/uywRrPoB8+HxiFmNo1Cefb4kkMsdj8iEdjW/y8ewFKygyw55
         1pGkzijpJQ+yyGP2LBZkvO5SnEu4TAnQ2hwvXY2Vrj2p0J0z1zv+B4Gxw9PrVzNz03q0
         6mMzXBMR3z4t3kQ6EczX1ZM5ZJaIuJqyEuhK70ICrpYUq+slBNo0EfOh0r56JHDtssgP
         bNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790400271; x=1791005071;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pVIiyRqhME2rfVYUFjEtU86And7QcpxR5cM22u9g16Y=;
        b=DlnxjnBaZrtY9tgBua+y6z7s3uTheJmCHlq1XCVbJUy7r2ruWWP8AgKk38NZehFKZ6
         tLe8nqD6pl+OlmBwRC8hJmC4aySIKaaZm4uPbKp+ZvRfNz7uKtMQcIfNqFH7zeoYMIDA
         iMy9lNsmwnZuODsmaTIxYYmHYANbK7yGltVfihf1PAeNINp2sKqXbsdSNQYmwz0DnUDz
         KtrLJnEeimI9r1vZ5uCjo2iMP7YuMMkNWjKRxeWN5wZkHCj7ch+mrKPf63lsi19Pa5Oq
         D8dG9Kc6Wo1kZ7ZvMmm+18Wv5FeIps8CuzpyLEz2fGLgMnt3pGXac3Z4qPioDtfvOjbe
         MnEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTBj5yj53qw4QZZ2sV5QUPf96VcpFSOlmcljlNWkO6IUyurI1p8bOBW6vQTEzcXwftPE4l7Ekt5mtDzw==@vger.kernel.org
X-Gm-Message-State: AFuF++liI07mhRZKPIIyF/bA3dl+GruIkop2+zg7xBfQrSeSs3tP8UVE
	P9cY7vCdZHaq1NzxgW6CwPgHWvW8mhpIV9nv3cqjdGHwvIt+izPpqFcgEauFloFghbvsMkmw67x
	v3JDfEgzC0Pxg6dRcTx+zpgcAU8r2mAM=
X-Gm-Gg: AYBFou396lqk4+MV3zHyKbyUCXZ7tKUpO6dsrdi6lOgRG5Lx1cl96AmqM4yJRw3Yk9R
	VNhYwgOF+oUtfT2JvcSJsbNaKDsqGBUtGegR3bGR/u/5tVrf3wCp5TU/w8w9yOxAOwQd5w/HDlv
	ujCmMXYg1a/6dp0zLHSYzqhCpSfPb0HGJVM2f7qbKQW9OuqQ57atuOjfCGXxOtSwpwnNBsiujQe
	HUbUlOeQeHPIl5yVlv1EWzChV2yowqiWVEgiidAM4xWY/zWX8fsIarYBbRZpRaX4yCILQOwBvvT
	/1TeW9YEwA3VlpS7aehuBclVRx8hiyL7OHnszSuBYbocs57qWeDw30Bao0Y+xm0ZrLmA1A0mEi1
	3qZBzwkVdMt7zbSe1iaRlMnk=
X-Received: by 2002:a05:6808:1782:b0:4d6:92d4:c806 with SMTP id
 5614622812f47-4d72be3a1f7mr8385532b6e.62.1790400270638; Fri, 25 Sep 2026
 22:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923152653.40953-1-yupeng0921@gmail.com> <arP0TmdK3FnNfbwH@localhost.localdomain>
 <CAG3TDc0bQJATmJR5dF5j9RoDp1ti-tbAiUkLRGq4zX2CYD3unQ@mail.gmail.com> <arZFtIkV0vg_aQR7@localhost.localdomain>
In-Reply-To: <arZFtIkV0vg_aQR7@localhost.localdomain>
From: peng yu <yupeng0921@gmail.com>
Date: Fri, 25 Sep 2026 22:24:19 -0700
X-Gm-Features: AclHuK_i4TetM7wyRpEb-4NCnm73C_jTw7zDqMN5n0xOhknlW_0BTd0EVzLx3Ao
Message-ID: <CAG3TDc0zdhUaTYy1tk39VcSE6PipiTLDMXU0cUZ04yOijOgWOw@mail.gmail.com>
Subject: Re: [PATCH v3] nvmet: add cgroup_path to charge namespace I/O to a cgroup
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Josef Bacik <josef@toxicpanda.com>, 
	Jens Axboe <axboe@kernel.dk>, Maurizio Lombardi <mlombard@arkamax.eu>, cgroups@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 2:59=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Wed, Sep 23, 2026 at 09:34:48PM -0700, peng yu <yupeng0921@gmail.com> =
wrote:
> > The LVMs are close to my real use case, so I mentioned them to explain =
why
> > I need this feature.
> > When I write the testing code, I try to demonstrate the usage in a
> > simpler way, so
> > I use RAM devices.
> > Sorry for the inconsistency.
>
> Understood.
>
> > > > * The subsystems are exported to different users.
> > > > * We should provide each user a specific iops/bps quota, thus a noi=
sy
> > > >   neighbor won't impact the performance of other logical volumes.
> > >
> > > Why cannot you place users into respective cgroups and configure
> > > appropriate per-device limits?
> >
> > I export the devices to nvme target. Per my understanding, the IOs are
> > controlled by kernel threads. The users are remote users, so I can't fi=
nd
> > a way to put them in a local cgroup.
>
> I see, so the core of the issue is that local storage is exported
> remotely as NVME (over TCP) and you want to regulate IO on the local
> storage.
>
> 1) resembles loopback devices where original task's blkcg is transferred
>    to the kthread issuing actual IO. Is there any userspace component
>    fronting the clients? (whose cgroup the IO could be associated with.)

I'm using tcp-nvmeof. Per my understanding, there is no local userspace
component. The tcp-nvmeof listens on a tcp port in kernel space and
sends the IOs to the kernel block layer. So I can't find a userspace proces=
s
and assign a cgroup to it.


> 2) it also resembles FC app ids (blkcg_set_fc_appid()/blkcg_get_fc_appid(=
))
>    Could you look at that whether a common concept could be used? (I
>    haven't looked into detail how the client side is handled [*].)

The FC app ids export the host side cgroup. But I want to not rely on the
host side information, limit the iops/bps on the target side. I'm not sure
what I can use about it. If I miss-understand anything, please let me know.

> Thanks,
> Michal
>
> [*] And now when I'm thinking about it, I'm not sure one can trust any
>     app ID that is sent over...
