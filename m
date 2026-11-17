Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904032;
	b=ZapSAMpUzCEULaTfR48wX3VhNb/4dpq8OpVwaDDAUF5t5STLN0DtISz9dKmj45LwYtXI
	 dH8mA5C4hms/99mgDWnzq1XN2VeU7sce1r100Mi2BVMa58IPi6uxaVmJna2zOUevGBy34
	 9WgeYu2x/oXUYSmaLlIY4YL1esnYy5nyVSv2MPr8ppvh7VyII41x7/HWglXEoSPhdU/6U
	 FBepIfZ1CLCARdaadyb+2XTDUQJTPijBQBKEfFyAHjVLy1F9gV2fU+2gLOWfh51pvpAC6
	 kiTRvSkMKNOJWx5l1irqwzzbCyAENI9dm5v7uPcbNt/Z5ylrknhhf1724yrWzc3NS7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=o7Ds5Sp5DChQJ6GHa3pEkVZuOErJkij7LbLCUPT9+Pc=;
	b=OQwAHRQ6AAMHqvKPDYIAz2rLD8YY4i0+7AoM4xCiFjHiVA3Hg56b7OuQc8xeZoFiXJqk
	 lDJSWluIKScAr1YU3j4CVWxHMEiy8DXUH+c6Ucre5R+74veRXuZoOPVw0hOTwqDrxm5Qo
	 7Pi5hOpqCSQZ3e9m9Vkhp1Y2XqXwR007096FvORe9v1SP1m+MktBwkeMb1H+UQW6uRLt8
	 pn03+eVieJAAnpU4jYgVsYc9FTo/Oa7KbEHwGEDjv0e662o6/cNZQZOwu39IzwyODHmW3
	 sh2zmB+d51Nd3s67nmldNiir5PH59Jr3j7bibSzW2j6nO1rHXPVQOVXL2gvA8zY0qTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=m3Y+iV2p;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7EE606A338
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 08:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F7EE606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=m3Y+iV2p
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4b467581b98so38964055e9.0
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 00:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904030; x=1795508830; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=o7Ds5Sp5DChQJ6GHa3pEkVZuOErJkij7LbLCUPT9+Pc=;
        b=m3Y+iV2pelmutPYORVxza4CHQMpjq7iS5lmecWgDjvax6Coso4uWa+KMaCm+CB3bWY
         yM9xDjlaUDqClL2wfFs+3EgMKFX4Q8fuLgup7VSVEO3iDYFOyh4nyeN0Shri07+KD82b
         UFGbuWvBELdRnXkiKa1GIWjPRb4Wz8WRQUErt4eMboeCaxWHABbQwTZk6BuPw2NopAXW
         5935wwOL0Ggt8LD7VeJmtmL6iC6DgtiD4S4DRbEtkaj1swNFS1XEbe90cWaNyokAE8Lz
         Ulc1c4G0eNVUIpLzTdbViN3HgCOMoyHpu6hnCIZ+utcpbQY02w1kBKtCyN8iaUfGq6tI
         6sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904030; x=1795508830;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o7Ds5Sp5DChQJ6GHa3pEkVZuOErJkij7LbLCUPT9+Pc=;
        b=WH9YwMInx/cnUk7+s+pNYUk3UKEc/C6DSNl3x1UDwfuyEJ8sGGiWMstG12jJccY9kE
         7+iCLsfxc4uTeuK9I/7+O/tmLPpt9NXOlR6//pYNqFE3jWUfQVT+bd6R8RVgAPGVI3eP
         0gbOOGorXPFSYOHZqaaM9N6krCaPx6PSx7QZoC0jpvjcW6IUMB+elsR1kJ01rl7YPI6C
         dvcFcyusk6zLgcfe5d6tZa5FWD3TjAaGxHe03jG9zxi17sv9DT2Q1p+vvvoOoevSBfom
         yd1lVYkUIMrgCTQXcXGL7EjMaA0SOI8TEBR4zqWdcIh+e2G18UH8JcRu1g3eSWz+OBA7
         XM7Q==
X-Forwarded-Encrypted: i=1; AL+hErEFOLthKJ4gpYph2CDzyl0ngsa+MpmZTCIsn6GTRnZWjTO4OAyeD8XI+DrEJeDT03o7BtzHT7xBwt9RGQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8zpsuL5ctLmEb81xLkJlWzibWUEdRSlzMt4q8NdDr1p+WIg/A+
	JsiQUh9OIR9cKyeElm3ZZ1FntVPV2+Jrgx+xvJQ0GFQZNZ/q2yZjDhifHXy3wcaQgaje
X-Gm-Gg: AYBFou2dFSFhodyjb4b/m0ekEILCx8flkWHk38LwLyan+d/1Ar23dUfbq7716ug+uy9
	QFCWJ3DWjvhwI18GFOtD5AyRicoMBC//yGQxP6kWAJ4puOd47UvjrVIF8u+trybdl2QpJ920863
	QtmNg+osihhM3AYkGcuFuWcSpY9Hy/SWmO+DPDrZw3c9jceMcQzB3NLyUzS17vn4sJ3xhsjUHCO
	55qbPvmMlLoKHHwnWDjmdI1Bg8EKMOOhg3rMARltQ+Dsvf46PFG7e2/2VmzjXZIdtKlelqRPln1
	QEHwZ/ATu2sX2iIIZmtkuxpjD23QToCFZliFFWygFw3U/RgRzSCTvUFZ34Apq5AfNOx2fu9zujL
	A2kwfcopes2n1UUWOVLR4uY89DrMtPOREMS+SnJM2K1SRkW5NHlZKfKLs8yoSa+uTx3ZbmjPBIa
	9PbULJArIDxmuj7hynHD57NJFSlHDaJeOJlKDGlHJcKBBD4EfUaKSWRlyuxdr+GWZHFPb1qEkq2
	0rypN2auEWu0bRT1ryMWPogHjaz33rm4nx3J2JxP568Xe1nz6dz15EH0tEWC8yAZWqZLCda/WtK
	6kpclcbqyiX54c+OR0zawG1cpv1uRhBb7KIjSHIcM8+pC1spYf4eMJGZMj2KI4HrTqATd3Bw8lM
	I9Rny4+lGP+k5pgn+xgyC94SOQWgSrLmpiEqZ1j1m8rJcW4bka4dgTAj9
X-Received: by 2002:a05:600c:3494:b0:4bb:6c71:b268 with SMTP id 5b1f17b1804b1-4bb6c71c232mr134135095e9.6.1794904030378;
        Tue, 17 Nov 2026 00:27:10 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7838c912sm45730155e9.4.2026.11.17.00.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:27:10 -0800 (PST)
Message-ID: <0ec7b8c90cc456b24e5b19c1db673d497ae43735.camel@amutable.com>
Subject: Re: [PATCH RFC v3 12/44] rust_binderfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:27:08 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:04 +0100, Christian Brauner wrote:
> Initialize binderfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC
> by hand. This adds SB_I_PSEUDO. binderfs_fill_super() keeps clearing
> SB_I_NODEV for the binder device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/android/binder/rust_binderfs.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/android/binder/rust_binderfs.c
> b/drivers/android/binder/rust_binderfs.c
> index 5f020226720db..04468c5b5c116 100644
> --- a/drivers/android/binder/rust_binderfs.c
> +++ b/drivers/android/binder/rust_binderfs.c
> @@ -3,6 +3,7 @@
> =C2=A0#include <linux/compiler_types.h>
> =C2=A0#include <linux/errno.h>
> =C2=A0#include <linux/fs.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fsnotify.h>
> =C2=A0#include <linux/gfp.h>
> =C2=A0#include <linux/idr.h>
> @@ -667,7 +668,6 @@ static int binderfs_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	 * necessary and safe.
> =C2=A0	 */
> =C2=A0	sb->s_iflags &=3D ~SB_I_NODEV;
> -	sb->s_iflags |=3D SB_I_NOEXEC;
> =C2=A0	sb->s_magic =3D RUST_BINDERFS_SUPER_MAGIC;
> =C2=A0	sb->s_op =3D &binderfs_super_ops;
> =C2=A0	sb->s_time_gran =3D 1;
> @@ -759,6 +759,7 @@ static int binderfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	ctx->stats_mode =3D binderfs_stats_mode_unset;
> =C2=A0
> =C2=A0	fc->fs_private =3D ctx;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &binderfs_fs_context_ops;
> =C2=A0
> =C2=A0	return 0;
