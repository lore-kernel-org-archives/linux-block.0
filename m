Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564808;
	b=iAtySC8fOYbo8BjYWXL8jbq4twKCtF2EwSz59SE4kBrBBF7HI9vZSzdHdU5vlrf/eI+p
	 a0RV6OYKDkkspV1oOkYmFHs2sRvBtvr6HQt8hLS/j2Zp2Pa6/b7VaRMNjjp/OxubNVcDm
	 Sf+10J5gdqU+EYC91IcCFpfgeJxAAEUGXITj3iQuhPm7oJexSwiWb638bZKQaMvwFApWU
	 DGJHTPRKehcZC344Uxl19DkHs6W6c91s/lGgJFH3+57zBwJamxk87vSxWR900J2XVJn1l
	 X2x+69seiSzNfVUhA9BcSpQGBtIYgloNLo/wXX6GEfmyKQlm43rt0lSctWyRp8ztcQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=UX3uQO58FXw3i2m3kzI3o8uINYIcsljrdUAfEKBly4o=;
	b=0B3oQBhT5Ng3QuPHKxZ8ObeaUUisHrBAyFUEix89IVbAoG7RjO7yVz1mZmGYLRe78yvL
	 NF/ELUna2yBRHb43/exG3jvEgYf1psMdKcQFnq2D5zpXhhDaNnO8D0GT2KZ7a5H3BRztd
	 8yIk3JVwL1aiqqjRvE9OpxDbuDvZ0RdYNYc9ZGR4R520NMBsXud4XLUeYo97E+RHd47GT
	 QFY/xDyN28KQuGvTz8ssIpRgxdS7fXwOCY48Y+bB3+FG9tfoTkWturkqPegoR0ZHJrxde
	 6ifZ8Mp8cJ1DKLEDu/ZpPK4KqrLHu5MxjFKMiOC1u3bm0cRQ3ULZIaWcdt+8RjUp+cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rqBNEWhe;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A67606A33F
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 10:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1A67606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rqBNEWhe
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso10630905e9.1
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 02:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564806; x=1795169606; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UX3uQO58FXw3i2m3kzI3o8uINYIcsljrdUAfEKBly4o=;
        b=rqBNEWhefqtER2dpEJNVPTElbe19fVdkNyIzbVbNULqUnWk9JP4TtodfrAxZg35Ufq
         +ciPTMXXDC3Fn73QdDq1nxL10hoZ0LEMTSuk+HTluWLCH3mNQBpp5ecm/W/Lr1PQghIv
         NQThaRjLVubmwKFzY9W4H2pkvpw752j1vTd8XwcKuq70wsUgwzLrChjclsxLFe4j6CXh
         P2+zI4RYwkyiSmtYnxi7mmM5Yw0kfqLENKBervoD5JNkytp6QIULxp+qmuf3k5WOFN+d
         HC6ACfaHkSpUVoBZwd9XYoAangfmrtxV8FymQjjH9iY0qoozDauX1oxEdXhYxV5zTWYW
         c/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564806; x=1795169606;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UX3uQO58FXw3i2m3kzI3o8uINYIcsljrdUAfEKBly4o=;
        b=KMShehni/YHfYoEGBQpSL/X/8ZC2vOGE/MexqsVZmcIKRY+ztQTyT/VtugAxRAMmhF
         ALTm7JggI2O0vVxRGLra1nXdq/JIsSRiYSIsz+gJsJinZDheuB/R8bUf8kcExs8MvTZz
         N4hBl01ErECQDUuFT/FfMD/3Rt1beKzcnQB4AurXh80Bo1wCd2oFKhITs5zAIaw6QY33
         yfUvalsdcp0JE8RjFsexh292m9sw6AdSjs018zYhr7j8EdVEwUq+5xi7ocpHJsHrFu+L
         upaL7Jnz3LyLSX3/EhxNN3lCVY9Bqa6s8DJ9BwW25PpGj3PPOz3SiUClan7pdMT6pBG3
         7TlQ==
X-Forwarded-Encrypted: i=1; AL+hErE9cMRSEDkQ5Ugp+Gn8J0UNzulqBufk6ntYoRFM3TvLh4p7vBlYfGTraK/zRyVIvSd9J3ghhYGqrcgBbw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8zp/dToYHrikaT3ITw0UaRDpDOFkwNN6D+YAMDUyoIKTn3dO9m
	ujyxlvhuUeMb4AfJxCtSJdisLr5hziSRfASd4l4yHjpmLf5PEGmkSWLhX0tD8C8OUtvz
X-Gm-Gg: AYBFou2T4+t2tWHv2RZMKIXbfwMkw9IO4Zz7v/Yg9LjrF1NJBzmN6bPcqE7bj2ZK+x0
	l1KqZFLrG6CapVXChmnFNoE7ZoyIhq2zAqCUSVqFf5CoPWe2vkzmwVgOgPKArC7aES8SmDbXLc3
	kEmVgskOfNCUcsZBe7LGEpw8R+it451zbSqxtjNibLTOjeufjGZaJ34IL7dzSWVNqhE7zkEwKVT
	WvCqF5A+207o09UouMmagQTvV/HCF1kjMf6ANFCHa+fvFrNsl8HlJdyHbND7PmyyZBzmZd7p5Oi
	t6/ILfhjapnwUONgjKKptcn5TmybjJGeFAI7coXjwBxNqSUezdQ0ptX0DyjOMrz2+yawGAgyAGX
	fhu4M0yd4xmQW+BBrvjrsamnHcIYulTzywkTY/dYF9IYAZ050IVQbbkKfkgfN23noV/epcR7alR
	fsaB6Mf4PrGeUIy7XxgN5CkOXKOxmmvyUW/aCs9w1qrN9abemej6Zt5nFf+igT07oYv8L1i31t2
	C9pOelC1LnbIcBXIEwXjGzpvivJkwdpWRCus4TmD6PeI7nxq5UOqIvbsefoXWUpE+44z7HMj8vH
	AVSQPst2HMIhD7tbyrnVzkNOR/wYDcBqgaamRNIVaOKm87p3sfImM45Jumug65E=
X-Received: by 2002:a05:600c:45d4:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4bb559f6f31mr43583035e9.2.1794564806374;
        Fri, 13 Nov 2026 02:13:26 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c8a77sm4362275f8f.49.2026.11.13.02.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:26 -0800 (PST)
Message-ID: <23edc29c421f5d4c1103004f79e104e9f94d42c2.camel@amutable.com>
Subject: Re: [PATCH RFC 23/41] fuse: use fc_init_pseudo() for fusectl
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
Date: Fri, 13 Nov 2026 11:13:24 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-23-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-23-4c998976c6c7@kernel.org>
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
> Initialize fusectl as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. fusectl never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/fuse/control.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 21ffde596d61..4497362e7df0 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -10,6 +10,7 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0
> =C2=A0#define FUSE_CTL_SUPER_MAGIC 0x65735543
> @@ -334,6 +335,7 @@ static const struct fs_context_operations
> fuse_ctl_context_ops =3D {
> =C2=A0
> =C2=A0static int fuse_ctl_init_fs_context(struct fs_context *fsc)
> =C2=A0{
> +	fc_init_pseudo(fsc);
> =C2=A0	fsc->ops =3D &fuse_ctl_context_ops;
> =C2=A0	return 0;
> =C2=A0}
