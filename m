Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564335;
	b=L1p+381HcjiitAvYJLmTiK3NC+Q/25HO47LgKW7pZIpUyqjP/+DyX1y5433IZovgG5yl
	 54BcHxyEcp3Hbr4jMAyead+yU45yCq6qToAErNfKyOaeD/drfCCbP2cxdXHCTufhzTMJG
	 ycrK0Yyg+kSz1AfbM38KkVnX9x3E6fjI9aJ/NIEI4fw4u3ED1fj2AOPSi3wJ+b86XOSL5
	 wCJRqb+4lXVMXRGPWWaKkASOzC42Wo8GbWe+vEr6kXpZOSsWGCl1vUnboN0Xpa/HGpbkM
	 Y0YogZST7DcPiGAYd+EP9HUnOvUXWx4IMoMzRiyeVgg6dclPNVouYkllxPpm0sITXHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
	b=SRBVbK3SV5OnGPpQW5pCS+KVBWDD0+ipm8gqYWds8xPiBNpztKkHtqiyOSx/ANflJDwD
	 RMaCMoQAIO9AMMe7UWwrfZYsiDllbeEKPpcuK615FUctlIfhyp/9DDS1SPolETBxKZQeK
	 K7uyeV0fBNlZ/Pq89tHqUc4pM5Cujibv2BWGrgqZc6+nu4hf6Qd8CYk8aE9gRoanV0l3s
	 MwQwVuXaoJk6z96MC57HfnLEyRkVS5uaVr3KlvLo6apiFkDI+gpPg9sQHwJD4hfYCsHIe
	 xyzOCxaUcR2X6W1JS2P8hrVYF6qK3gh7dUbVBHL1AgmVlfK6kkgzEMjE7bLkhRVKPZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nN3frtS1;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB1D606A890
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 10:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CB1D606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nN3frtS1
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b65d69f5c2so1381230a12.3
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 02:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564334; x=1795169134; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
        b=nN3frtS1dXU5gnwmqfzT8+bhaiQQmGH+o8SykyblXrC3qld0kuEs+6HEGC2rkpdv/S
         sQV16XdsqqZb3GM8OFjrvrple+atxGtcqxLFVKkGZ0Zd80qUKx/EPhy8mDGrZkmovYLQ
         gPE45P700sVxzONMsyf76aaH6Xk5KYIuezCkWASzF5DvGkP1gh+ZRYmtrnwRu9+hQOqa
         BqpjziGjGsV2LfHal3A39L3aaFb8qdjtC8kgwx4O/4F9AvhElCVGweiPQgw5f+yTyeo/
         j+w9LUu3B6WOr6fOKhMnpx/PfseHq+Dks7TfznRnFDL7kPCQ+qTR2Sh8LdlE9KHj9gsV
         IzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564334; x=1795169134;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
        b=O69TEFrFxuZYeTK0C2O+7XWW0lvfDa5NLosKasgB9z2G08iD5xWJDXl62l36Ycw0ho
         WGceRCxrquEQBKj7umqOwcQWwkQuEk/82HQT0/vC8z9jxKyvJY9PMLvUX/6Cq94J5Ckp
         lEE10UZ3SPy8EbrJedzaIqGDs2ILhnibJmUD2ONDdDyI0mB1aCn5dKgKHqqGN/hPRV4F
         nI/bZ67fmH86c6XIo9ZhnbS5qaArGDnMc4RjtttIIp6bw1TkMACnALLWnLoDmP0YbOIh
         2tPWGaRqTYadMsHYYHh+L+ByFiw169s5MLZwhgBCQ5r03mDUUt6crHi/CY7UW6rbBAcq
         SegQ==
X-Forwarded-Encrypted: i=1; AL+hErF23kTII7+EsEVKSYn7HoxUcCZIXLfifQ6chJLoXPfdegXEAaoRM7PbBXwU9z/eH80hUArLKQCpErX3nA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+dXR3emsnOAy1c7m+PgRDKeVv7+NQ5RRjsbcKs4SbAWsP2yNNU
	JePey9uuUDHxp3LgRamT4y5WH8PFayEy0uLVnbvSY23Fr/ldZ2Ks8iASLftjS04nK5eBkss1S/W
	yGAiArNXu+lQ=
X-Gm-Gg: AYBFou0R2F6PX/kefaauJSsA62rbclJOfa/wT5yLMCEBeqTxdgIqWmUuYVy/IqCEdxp
	z0mw0ytzVxmWPKf4TdPeNwzcnd6pFd/bCNmYiDAUVyX4l42H3jpUxwqXOL7cbYmFws+Qmj/Pzk/
	Y/oZylvLu8z/DBT26l53RUd7Ufpbx3OkUsnbZHPvguW2KSsCVM8whdC5zJqmZiZawW8T1aoB7Aj
	syQZW+g1IhrRkZdtdjYDeXU13IhYft8mR8p001bnH3ysOz6EHHUFvNYSgnECApWScfHI8zTS/Xf
	T3Q1DqZc1JB2lGFZ6k3qvwbmKYF5kbAaOCNY7uIt+g8bDG1eo6atYumZ9nH/iVM2im1lzdHtADg
	RW9sVvPSRSvA1ssauCCWa0llOZlRQFN/4ksGAyEs/2Wm7wBwJMPJD0i/MK2bLj7nZt5GbelWuoX
	daiv6/10nYaLKEGrbUXS/71qX2DV7tMqMnkP1VhrlHqrBCvWxZiJcKyL7PVO/PRpKql/EiTz4LX
	mhs0IAg0CKqR9VjV6LbhpM9+HCjGWGbOP9JTIVcAjyHjsBxpw6arpQGTm4d71YH0gwltXQMDKvU
	3rgr+bA7dzr6PEy35GJdHmGs7np1FDgd2Qe0m5LEKkQgt+DVjGkow6JvZhGAV91rRQwGBdUBwNB
	X8ZqR3ryF
X-Received: by 2002:a17:907:608f:b0:c43:eae5:ee80 with SMTP id a640c23a62f3a-c5096398b03mr148720566b.17.1794564321873;
        Fri, 13 Nov 2026 02:05:21 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b7b2c9sm75811766b.73.2026.11.13.02.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:05:21 -0800 (PST)
Message-ID: <08fa1be263cf4a3db6b3e5ec2847107fba7acfba.camel@amutable.com>
Subject: Re: [PATCH RFC 13/41] devpts: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:05:19 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-13-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-13-4c998976c6c7@kernel.org>
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
> Initialize devpts as a pseudo filesystem. This raises SB_I_PSEUDO and
> SB_I_NOEXEC. devpts never holds executables. devpts_fill_super()
> keeps
> clearing SB_I_NODEV for the pty device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/devpts/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index bd1e8eb26edb..47ef12241d92 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -13,6 +13,7 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0#include <linux/namei.h>
> @@ -438,6 +439,7 @@ static int devpts_init_fs_context(struct
> fs_context *fc)
> =C2=A0		fsi->mount_opts.reserve =3D true;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &devpts_context_ops;
> =C2=A0	return 0;
> =C2=A0}
