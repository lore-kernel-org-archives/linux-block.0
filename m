Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564173;
	b=YNEsChJH9xaMyc7Maql7wSesnEvnX7za+dKGo+7HuIce/Z57vOw1gwaUkuojfLcPpzPv
	 PvoAswmQ7NofFE89TetspYNm2qit8vzpQsVV9cEjxpx8Vm8mlooZkGOW6+tqBunfUXKjz
	 XEABfO9/nmxXipLTBpYx0YirwC5DAYniq1MUzD8OvfLnV2oEVnPVrzXLlrA0v4QjspwId
	 +MO2bZzvg0lQWbjT+0kUW4hyAatH4FPpnQ22UM1Npb15j+m/yBlRJglKQuihgzoqHLwE+
	 9beg+xYHxzXYg96JKrX1IHNITb0kPT8CP1sDTojyPaMXciZg1C0I+ZFUXeNCv+MY1OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=QOKRfXbntKilXKCbQIPuMXmISRmnU6cXIBUGi5zYMoA=;
	b=qxwJOqQ5GvLH54FdIdQ6rJSh0bQCv1Fs3voQR6q0vrPSWq7zNzVLUvQWDqw7luV+JhJ0
	 B4DnRYzoqUI6ySAbuYdfqan+8OeXTxH/anVs3+3c4VC/1+2LIJrqIOAciZTb7Kv1444g4
	 NKjC5Jy6EhQs13V8nrmNSS2Ps+6yRaBWcufwgZWTj558h1Atfa8BtZzLHMkXuwyt6NR/j
	 iXqKZV+YTWZJbQUCNwrFHTUA4DcPfXSnkMNsNSa9mMNg8conMRn1bbU2FGlXLNI55oNlx
	 95PaRLq1/E2f0YsInH3eE6dmTsJV3N/hYA6qP4RHPTZHVOu24A0KGkPoeor+uFTt3sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BrRghWve;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7F1606A8B1
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 10:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC7F1606A8B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BrRghWve
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b587591414so1163228a12.0
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 02:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564171; x=1795168971; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QOKRfXbntKilXKCbQIPuMXmISRmnU6cXIBUGi5zYMoA=;
        b=BrRghWveZPMQ2lrGbo6B+XUgpff5EufUxldGFiTipoIaiFawRH8FVJvDBChKSCm+0U
         qE7NrwVrHQo2b1oiTPINBjADcjfu8j5+2hiB9wPnUB0Sj/3WgVbhatfBxMm3U8N4KnOM
         ecLP+89NGaRsX9nOgSryY2U8lUIJARrslqQpZFBfoMRf7b7aCNcM2ESlmVVEcyz67Zq1
         nmg/xl76oWVlPrwozco+e18C71yw30j2TPM9TFHhbc2tHwAu5TUUkKbNr7mrc8DWNqok
         L5mLyN847Ry543yO7VRmUF69tZ0RGoya4bqZfEDQ44XXZ70j+SgMCotFLrfSWds1gzqN
         VQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564171; x=1795168971;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QOKRfXbntKilXKCbQIPuMXmISRmnU6cXIBUGi5zYMoA=;
        b=gmgu/3k4NFVO0PSD0z7FmbpBmh7ZxROT5QMflKiemuZ8mdV3I/3Y7xOKFof78z+1xf
         huiYZCzaQMY4PREpvd/iQqhPYislwL1ijpxLn5aOBKfxBU8iBhwlMqr8Q9FQvmus01hY
         75okg1DFzqbjslROVlA0vbMmDDW2vnh/rfAEq8G8/woMLgWmizVikKWakSNx0UCxh3ke
         GFSx3Zxrmxdh0uVHvzBaoLQm5NiW9q+tG9ogXCXLpSZl1stlijNqWlwPjIWF65m5Y7RD
         MUHbiUBdMChwIduPE9k6uNRRIPHlIzTcpELIKCx5xeKesb2PFxB6bAB9YBPZlwHGY1f8
         pQBg==
X-Forwarded-Encrypted: i=1; AL+hErGKQ4vClE2jxZbUUKq9jATf06hSh3tlkk/ruvQv4MaSGwe0sQtKoUF81Gckv8CQSjElGhMlKRy95Y0PgQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8+pRckl/QNZsu0f34tJzE+5LmBVeGc/h+w2fuE/GHyDiJJ21Mv
	tcn8GjyiOEglgmUvrh/W+IOKWX2/8zlHy0TfCARS6ihJXbmz6DiEiKTr7gxrbaqvtLw/
X-Gm-Gg: AYBFou29vBxtNVn8Ieb4nXsl2/CC6tMGLcy0b4I1uWJJD4IawniJ9/+BazSi8JCl6/n
	vbJY3UX0kK4W4b2vrZ/hIb5wRm9bRkkbk9ZnbPfJw+xcWrs7Oip+cmMDuOwHyJPNaraVnW4Eg16
	Zb8laRZx/rVm73wPC0G2pu5qJ2uEoMWDp03Gb5BbZIdB70vXDtNcBL66SKdXl1mfUmZeTAbFhnE
	ax43IEBBQSe3FZOIaxO1uPx/L1cPYGM8l+Q01d0SOjOycy4sjaap8hXC9lZ8eJY0VqqtCSAeP7E
	F0TuTjZVqpqmqL7lArwPclccrqiuMrXwz2YMm2MC2dt/wmW0+Ae7Amtb4bzF5isOcpEA5FhY9Ht
	sFiT1MtxvrtNldcCPDxr8ksq7NC40EUP7ADTAjjmgWjbzDLMGv5IhrvIizO4sqwmGfoPIUCtTSo
	IeIsheMXTCci7iDT1IiO735GMS6/e3aAemelLVaRwjr2XmVZWReCjWvPv0pSNBjpFXm1yPdZ4wN
	lZZtfsHIDIMAg1eXKP/ukJ7MvQEMld8S4EgLq1d7qXAGyX87GuEahDOIZ6x9df3VWvpQqIlf6fQ
	H42NmK4tuYzzlR/wyAySuGgrQnTLA+0aiooOuCGnDFk5UU3bFli194a9hh0hOQk=
X-Received: by 2002:aa7:c842:0:b0:6b7:82cf:f69f with SMTP id 4fb4d7f45d1cf-6b7c0ceaefemr1298014a12.41.1794564171137;
        Fri, 13 Nov 2026 02:02:51 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c262338csm739270a12.33.2026.11.13.02.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:02:50 -0800 (PST)
Message-ID: <06b194053de4f4b65895248d1f2ba29d42a21b17.camel@amutable.com>
Subject: Re: [PATCH RFC 06/41] proc: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:02:49 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-6-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-6-4c998976c6c7@kernel.org>
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
> Initialize procfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> =C2=A0fs/proc/root.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index 7fbbe92bf73a..ca0e75081934 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -17,6 +17,7 @@
> =C2=A0#include <linux/bitops.h>
> =C2=A0#include <linux/user_namespace.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/pid_namespace.h>
> =C2=A0#include <linux/fs_parser.h>
> @@ -265,8 +266,6 @@ static int proc_fill_super(struct super_block *s,
> struct fs_context *fc)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	/* User space would break if executables or devices appear
> on proc */
> -	s->s_iflags |=3D SB_I_NOEXEC | SB_I_NODEV;
> =C2=A0	s->s_flags |=3D SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
> =C2=A0	s->s_blocksize =3D 1024;
> =C2=A0	s->s_blocksize_bits =3D 10;
> @@ -350,6 +349,7 @@ static int proc_init_fs_context(struct fs_context
> *fc)
> =C2=A0	put_user_ns(fc->user_ns);
> =C2=A0	fc->user_ns =3D get_user_ns(ctx->pid_ns->user_ns);
> =C2=A0	fc->fs_private =3D ctx;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &proc_fs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
