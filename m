Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564141;
	b=zs3bksnx5l6nLGroJCm+EuPqdrDLdRlWj7SutN3anH8Kw9LQya+h5/8tEDGL32TffC+T
	 LwIyAgoX3cAZ3S5YmWwbEKVAaJriH78Yqnmohy+3MKTdK8kXE0mLtQ+t3AhdpxQFXVJDQ
	 m6VXd4ncBevZgt/j/ztp5aQje+VWBvj56/Cru0y6flvQ6Ofj8IkR5DzkefAg/Vd3n3Ded
	 r2oiroMLkG39+Cxpb2y9L4ZjeadtZLNf8oieN4SlHUj5rI6AhoX0OtBYjh2v0hR33/qhx
	 jcczq5CE01fTCdihnTDI33iVeY4oeFcGjyz5s+ZxFMABnd5OnrChLPHRPgeDlzqqtGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Ee4ggwaa7pvqsvjnONVsvhhjx7Blw4b1QTFG8P7u7TE=;
	b=ZUE3CUfPHiJhJdz6A1dfc33pWCJE7TPgZ6L3NkyUUhDwlpe3++KSfEjsWX11kZuMQeO4
	 zL+C2BvbVRzzdHv1ye4nBFDsJlyJi0thgWqhD3yQPo89KV02LfpO8yDlflr8wthpjm1mF
	 1gUNl8zFD613H81yge/cEPhwOLjY1gHtdj6VhT1GTGM9RO655sYbBsLpLUR0f/UAznLxc
	 XOy/MasJUXlMhv7AZGoicAxsY92iRYwGesXxub5rDLhY9KPc2l1QIjB4eOiTaPCQbgYff
	 ZaF5tlXkUk1sBCOiHZt57DhH0VNitsq+6rPANg8mSFlT3Yo9lvMjvtUd2BMH9HRHRgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mxnEK0OE;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01777606A338
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 10:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01777606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mxnEK0OE
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b7bffb5b8fso1233857a12.3
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 02:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564138; x=1795168938; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ee4ggwaa7pvqsvjnONVsvhhjx7Blw4b1QTFG8P7u7TE=;
        b=mxnEK0OEI7AZoc/CfUYBfL7b57vnPAty4yH1m7TS29a3jfzgxF6O21C+4eoAVH56Q9
         piX6TGhock7wjcI74HawyxxvBGzm9YxMDwhPO59HW6wNIzGY38ltasaZh4hFELwGRqEv
         EACaW/+rYd6+QPU5/79gIyHIHlnigPDAQAFlfCT0ngxFbKNdFkIgPJ4AQQVbJxYRU4kd
         sGda4OaUFoBKprw0qaI3K+cYJzK6vhQ24s+osuqJwxviEyFLXhcz7lQ/DUhHhDlN7iYr
         P/EQDWGz9doNbLrGEB0hB+YKjuFHlmGHIGpXLhiZ/HiYA8bpaS50WmEcn/ZjJ0UCEMyu
         vVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564138; x=1795168938;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ee4ggwaa7pvqsvjnONVsvhhjx7Blw4b1QTFG8P7u7TE=;
        b=oGwAank4WXeC7VByTRPQcvlNqXoMTMiWWAuPiJQE5dSGtsZx5ijOvE+k3sNR1WNRbb
         8x2lSiXyryvkeAj+Cz+xQQGzHt9JHoEMumf93v3PRurQbEwLfVU/N8ToCJz/PF6hqOKi
         Jg4rCyoHo3GOpZ/TpXs8hjoU8MBL8CmUJrBW5O8fdVa7bnJ2oYfXoVa6k8B+bhHtAuXS
         vmSMHWaNbDw89WWKB/Z7xUmG82JIEQ1ykMtqBuBPH+pnwutk3FjzLLpF97gdTR/MT4Td
         2fEtZq12o8bkAG7pMrIQYZMgXiTmqP0M5VdHQIOjw9mV363Zzwy/7tq8QHHkCAbgXH8z
         qX8w==
X-Forwarded-Encrypted: i=1; AL+hErEZGqsGTO4BR00/TLj6fITsceeOqkGsx+oT6tUaEou2Ai2FXoho+6z2R9rFIpDNIQ11U6+LUq4WoHT3iw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/3vc5vEYvxNGo+CvG1+2KBA5WQfPmetXWFr+s9sSwGE/r6jLiT
	dDeGaIEsTv3Sp9Pk4qQt62gAqtO26sAV1gZVf6RIl6YkX+g6mTCrAM5CxP2xseE/5GlF
X-Gm-Gg: AYBFou207EuN2RoD791qAcgMhsZrNxAmxu/1Bac9bAS6MawXOczy04c5VyNwmpzSHMi
	9NjHv0qga6wcT6vgFCHGUUsUzkomjxT5KKZSEox9ClRacwa7YjaUMigdgpvopUV08EahpG0Aqcp
	nvRL2r6FVPnI2zOWsbVb8Gdr6BIjDLTc1Cn4aC8bprJsGcdZqgoSVlIs/Q5lpCztXiIUFIBGGmy
	pPaCeMq0Y1/XI1XamLD4XXTpcT2qQ74cG5lhA1t68xa78XWxf8eeZ3Xo3rAoBhq5vMx/Um7OW0t
	EbVS40BzYaA1jP7u+fBPWwQE0I8IcnVcbt5PSAWpKlNh6LA0KkTD+g6rVD5u8h5UDT19QoWbtDT
	F12U0MgC9lPngcmAzc6+esg9ZSKM88FYyCkyLMXrLiTHiE+Fb+0YId/d3KIIGzIuNt5+QkyscvT
	n90bcB0fGL5a0k3CsSEc5WXbA0eMvi0LbiR45ZgX5NWL7xbtAkWl9jPsccKgA86F/8ItxSIdlJB
	oV+lD3l2L7KRBJb5JQat9MkzAUGIr9WcNjRvKcAmFQ/xqJdR1bpIsDYaAH7yfaCTUQHZMFTuilF
	pjAioLRtS9W7/uUqoQik1dYvD/xo7nmzMym6a809tKgp8arcOvyj8SjTKWm0c7k=
X-Received: by 2002:a05:6402:c4e1:10b0:6b6:eefc:ae7a with SMTP id 4fb4d7f45d1cf-6b7c088f8ecmr1236733a12.4.1794564138223;
        Fri, 13 Nov 2026 02:02:18 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23c672asm734155a12.15.2026.11.13.02.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:02:17 -0800 (PST)
Message-ID: <f4ce8239f22046e90cf4807853282a570c73707a.camel@amutable.com>
Subject: Re: [PATCH RFC 04/41] fs: add SB_I_PSEUDO
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
Date: Fri, 13 Nov 2026 11:02:15 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-4-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-4-4c998976c6c7@kernel.org>
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
> Currently, there's no way to tell whether the files of a filesystem
> store data or whether they are kernel interfaces. Files on pseudo
> filesystems such as procfs or sysfs generate their contents when
> they're
> read and writes to them are commands to the kernel.
>=20
> But a few places in the kernel take an arbitrary file and use it as
> storage: loop, zloop, the nvme target's file backend, the scsi
> target's
> fileio backend, fuse passthrough, the usb mass storage gadget and
> erofs
> file-backed mounts. At most they check the file type and whether the
> file implements ->read_iter() and ->write_iter(). That's not enough.
> kernfs provides both for every sysfs attribute for example.
>=20
> Add SB_I_PSEUDO so a filesystem can state that its regular files are
> kernel interfaces and must not be used as storage.
>=20
> Pseudo filesystems also never hold executables or device nodes. But
> currently each of them decides on its own whether to raise
> SB_I_NOEXEC
> and SB_I_NODEV. Some do, most don't. Add fc_init_pseudo() as the
> common
> initialization point for all pseudo filesystems that raises all three
> flags and switch init_pseudo() over to it. The following patches
> convert the mountable pseudo filesystems.
>=20
> Nothing checks SB_I_PSEUDO yet so no functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/libfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +=
-
> =C2=A0include/linux/fs/super_types.h |=C2=A0 1 +
> =C2=A0include/linux/pseudo_fs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 ++++++=
+++++
> =C2=A03 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 96a6e9b1535f..8c8789489fdf 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -735,7 +735,7 @@ struct pseudo_fs_context *init_pseudo(struct
> fs_context *fc,
> =C2=A0		fc->fs_private =3D ctx;
> =C2=A0		fc->ops =3D &pseudo_fs_context_ops;
> =C2=A0		fc->sb_flags |=3D SB_NOUSER;
> -		fc->s_iflags |=3D SB_I_NOEXEC | SB_I_NODEV;
> +		fc_init_pseudo(fc);
> =C2=A0		fc->global =3D true;
> =C2=A0	}
> =C2=A0	return ctx;
> diff --git a/include/linux/fs/super_types.h
> b/include/linux/fs/super_types.h
> index 72f4288e16c5..472200bdf081 100644
> --- a/include/linux/fs/super_types.h
> +++ b/include/linux/fs/super_types.h
> @@ -359,5 +359,6 @@ struct super_block {
> =C2=A0#define SB_I_NOIDMAP	0x00002000	/* No idmapped mounts on
> this superblock */
> =C2=A0#define SB_I_ALLOW_HSM	0x00004000	/* Allow HSM events on this
> superblock */
> =C2=A0#define SB_I_NO_DATA_INTEGRITY	0x00008000 /* fs cannot guarantee
> data persistence on sync */
> +#define SB_I_PSEUDO	0x00010000	/* regular files are kernel
> interfaces, not storage */
> =C2=A0
> =C2=A0#endif /* _LINUX_FS_SUPER_TYPES_H */
> diff --git a/include/linux/pseudo_fs.h b/include/linux/pseudo_fs.h
> index a651e60d9410..0ca408aa60af 100644
> --- a/include/linux/pseudo_fs.h
> +++ b/include/linux/pseudo_fs.h
> @@ -2,6 +2,7 @@
> =C2=A0#define __LINUX_PSEUDO_FS__
> =C2=A0
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/fs/super_types.h>
> =C2=A0
> =C2=A0struct pseudo_fs_context {
> =C2=A0	const struct super_operations *ops;
> @@ -15,4 +16,14 @@ struct pseudo_fs_context {
> =C2=A0struct pseudo_fs_context *init_pseudo(struct fs_context *fc,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long magic);
> =C2=A0
> +/*
> + * Common initialization for all pseudo filesystems, mountable or
> not. Their
> + * regular files are kernel interfaces. They don't store data and
> pseudo
> + * filesystems never hold executables or device nodes.
> + */
> +static inline void fc_init_pseudo(struct fs_context *fc)
> +{
> +	fc->s_iflags |=3D SB_I_PSEUDO | SB_I_NOEXEC | SB_I_NODEV;
> +}
> +
> =C2=A0#endif
