Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564237;
	b=UdLqzrnYXbThBH+h3gHoE4TLXvfRYFB009BibyyRIMm9fRgsCmmzvjREQmqn4neXM4uM
	 YKYRBGdXZhLWNd2Cje15NdMVO5QlFwOeWwi2YAB2tWj3fGjxX8E10DfvjSdR58hUniMlv
	 I1kcuu4o4RO+0ANFCZritQ0DWCkcHj8TRezxxe7Jo4i8UEmvnIoNbVjIHa+SElnNqflWr
	 b/mHk4PcUXecFeF4k2pC1OxDmyn+IAvM1FIHTvbZphoMBPmoXIJ2jMiVcd8vFMh0+xmaG
	 Bz8Ve4Go1X7Sn0g0hs+Wlb04c+gp8mUr0fomcpQtGd4kgPNCCf6B4soUBN3n/7+A6mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=isfwHOSFEU1THdAtyjNR/BymwB+TGu4CpGjFt5oul8o=;
	b=eDKgpUl7lhhwcB2ngSOxKdJ/B2w4MEjw/aYl3Rk2dlMhD2632VbZ6kaPjxA8AeGYtEP2
	 e1x+vZoAomGgQ5VjnTWUc2fKfZf+BEKeUNqO79RRBJEXX/Xzm9/ofCWu0xrv5wD9xQ9AM
	 5fQbeA82pLZb/JWUhx4KclOrhmI29HvtMzlE82ZYB8DECtkwHCz1kFOfQsOdYFHLwOAeu
	 7kFOsEmm50xMBWN4hPafcZirnXBD00oJgKynBqehT7i3EJlNQtVytjqFOOhskN629KCAS
	 uJCU0YTLQkiBS7TtBg9HrwG/0MJFSU/5CJ/WUeVsSNLEz63Cbd7etfYgACnaewDDwdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HmOhZp1a;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA13606A8BD
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 10:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFA13606A8BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HmOhZp1a
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b6f42095bcso1441620a12.3
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 02:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564235; x=1795169035; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=isfwHOSFEU1THdAtyjNR/BymwB+TGu4CpGjFt5oul8o=;
        b=HmOhZp1aysVRSGcApaAZDLI81xyeSldeu7ePLUPKkH54FsFfnK+QDVFY4+VQQZDD5I
         H2HloBZm5LZmO+0yz1W9rfEhaL+YICMUwpLNmuFaGXNfAv5LYB2fsAN36refSeHGX9fO
         cryYVQ+kM2KCw8u+OcP3112ltvgpCHGvfl9d9GfdLtqmNcwNDmKz3KTPAT46qO03zj8M
         uuWZNkUaGTWe7Ooua9eiEAKQiiHx3qf0rn/l3lNWMOa2sfege5hzg+R5XNTSj8AN0bpY
         dCBAZCrR4vjcQdomnF2hzC3FA98LaruL1WYTiCQ1DC9kzlEXZqoLyeQdM7U6VrMRD1VV
         Lr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564235; x=1795169035;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=isfwHOSFEU1THdAtyjNR/BymwB+TGu4CpGjFt5oul8o=;
        b=gOKm5P68Z+iCcHoW5nBryXTPaFDXhwXw5/xDRbezONUJGwEJXM0TtjAuRCG9TbZaA0
         TROTZj2pyvymkUHeLll1wIeCeatnjUQImAXqkH9zWv4wXYwfLOXR2aowzE8GRonZj0gl
         msBkXfmH/4rEssbne4vqL82424C5likcwU8cDEiMkVbVz/qKGji5qoVq4H0jEUSFuVMF
         VLn+P3ldg2kY5j6iifTRzvqHSjsp0xx9zVOUHQ8KWuDdkAV6nLmPsGfkXoetF3XtzsEr
         PhkJ0EJ+JpKmRyQC/Vi1WXoHCTJILbD+HxxzyYO2RRSk7a5mwsfv7dFIwYqJmghxzeam
         QSQQ==
X-Forwarded-Encrypted: i=1; AL+hErEHRM/0nIT6d01Jfr3kz4VIRSmQwiP1UbJZ+H4x5LV8xWnCHWqVJxPzV0nGzWim23MmRbMgswB6XYs27w==@vger.kernel.org
X-Gm-Message-State: APuU4Z+6+ckuH63GyvmrBV2W3TKOr+bPGQIy2nXHaT9K0T6Q4/DsjiLz
	Wq/PLqX37lwRzej5Q7yNy9++5kzuUN9NGUZaIL8wsH0f95X7zmIcAWqRKUra8J7iQBrZ
X-Gm-Gg: AYBFou248zri6btUAPRwKl1pGCJym0KLLWkL1NKfWIe3t0hLjz6OjglTHu39aLdZNRP
	tAIKHc5oq+FTA/b527qoSsDC67X6LqA7rjffo9zq+F3AotI1dJYURsFx2ywCoxRzljIruP0hTnV
	Eg3cN5Ss2K5dX11mp08CF2lTE0Ct3eonzxqRxQfsnTLdiYAttjAlz639wFF24c6aHehKRqq1JCM
	cIvVFGFNtJa8MbeikwWUtg8Od1tre2MZmwxFKx7w1DJx/pqXRcvJw6Lk0ggJYsolTvV+OuInf94
	jXEauSmQXnpcuOoX+M56VskDTt1jINxqi2WcVWU9Aa8gkJ0N0hm2XNhD3z+STe9H4ykpghFrnGw
	tMwplOBjqEaOFDG4VWtGxZlLCUJPOwlXjWs/bWmVNLoqDK03XGDc9ADHGGZWJMxXsztYyLxdHI0
	j2uhPgwK3MRdynwcNDbJgYysyScbdZ14creKRB3+k4gErQJV93c+H1txaqygcdUUdh6l8b7SKYw
	0A+MZv0oxN3KKFhrLvjiGO1903RBzvTlm++8d02ityfOsIaSjz7bQnE57NXEe+OnJmL9SLsdmiN
	By+m8YTW+oM3CVn/d3cHdZRg2EH3LlJqo5vJ0602khPOzf4eg7vMsiaprelK9m8=
X-Received: by 2002:aa7:d556:0:b0:6b5:96e9:ae97 with SMTP id 4fb4d7f45d1cf-6b7c0ccaafdmr1234919a12.34.1794564235160;
        Fri, 13 Nov 2026 02:03:55 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23611casm766458a12.9.2026.11.13.02.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:03:54 -0800 (PST)
Message-ID: <16dbddeb5cbb9613dc806b43fc681eb26aa3b0dd.camel@amutable.com>
Subject: Re: [PATCH RFC 10/41] nullfs: use fc_init_pseudo()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:03:52 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-10-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-10-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize nullfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/nullfs.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nullfs.c b/fs/nullfs.c
> index 319c2f5c5a67..2fe24cb97160 100644
> --- a/fs/nullfs.c
> +++ b/fs/nullfs.c
> @@ -2,6 +2,7 @@
> =C2=A0/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
> =C2=A0#include <linux/fs/super_types.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/splice.h>
> =C2=A0#include <linux/uio.h>
> @@ -174,7 +175,7 @@ static int nullfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0{
> =C2=A0	fc->ops		=3D &nullfs_fs_context_ops;
> =C2=A0	fc->sb_flags	|=3D SB_NOUSER;
> -	fc->s_iflags	|=3D SB_I_NOEXEC | SB_I_NODEV;
> +	fc_init_pseudo(fc);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
