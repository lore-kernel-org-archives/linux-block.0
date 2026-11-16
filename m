Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794859450;
	b=5QKR29BaKbm1SOJuUSJ9+An9lFTTkRoBEhdgDJrRpJHgELPn0z5wY1V1f3im1qr2f8XV
	 vwp4BBnheQaOAgNmULQWimpRCASuexm5xMQpnXD3JviIhuB9dyvGoyTcd6B5H9879iuQD
	 hEacvpYc/bwuiaNGShvrh6T+4PWuT0HWBDc1PkDrIQJEfMSY7OOI9nUSPMSKiMBnsMvQo
	 kDVR6owcokBKUaK9E7UOwlUdT7w4ri0fEvSAPN0yYdQVhz232Bzgi3Rklc9RInKkNsRDw
	 zhJi9meIH4KQAtduJNDFxn3BxcNkwXc7sior/JKClwS0hgTjv3mUHkqmhLnY4/itjpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
	b=0yaJ4Um32VtfMSJ4HFQeo7uEuwcs79iEfcBK3Lp1okd6jcK/aQLq8TEixLyBoasuRWDK
	 iC1z9VZ+lZuLEgLZCt854guXsmsG2JCPFT6Kyt/rykaCWD46AwZAPPFJ+AyvDLGkbGAwV
	 9yQq38Jod6MvX8xjBbeF45bW640wzMac5f7rkqo9578mCdQ8jK4JzJ/hQsDXuOvGa0sdx
	 KfTgjmHfZxv9qkH9rmfsgU9csIOdmKw2cRvkFuXJN/qK3CxgXYaMQfELZUq6dwy1XbKQb
	 TqUFA8xrU8sbWybOFA9seNh86fMx9xtHN4/JWjiIaRMVTjxkUYPbJiUmH29XnHokv4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnqDx80H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3996B606A336
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 20:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3996B606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnqDx80H
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-49a92144733so1559082f8f.0
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 12:04:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794859448; cv=none;
        d=google.com; s=arc-20260327;
        b=bwodVpCyE7+iJ0olTel2h3J/Fp295JRbvzC+w1RU80qgLu5ey96xsm+fli+vyWlCj9
         97CFN2Y0GTn+EVhEpJrY7+VyvD8OOMNlsOrHCRsew4VZXWCnUzuU7Vvwwiq6C2PRx67V
         322V8JWpMAxomzM5q/Mpp4VqDLU3m4RO7ZEvzZKdOkcmMmt9tCFJtYcPC/fkodrkv6P3
         CDo2BdS6hyEsV3wfvZDEZamaRvAP+EwrveT8rhztC5MRdtbGSQ0XZjzI0Xs4BU5M0TXt
         jR0blcm/MseyCWRA/hYRBDs2VgqZgfkY3zuyh05skWeoPguO7b6USo5tkwmBQQnK+eiB
         z8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        fh=KnOJrwwj16ttrYe4RqWgSzrD0561NSWULqS0PsHnN6E=;
        b=s8ZaKPfpL1sIRSQ1PEcCkaGsQqgqpN+nddAsuDYgfgVJB2bORvs8AsfNqBRf4+6fYF
         Xgf7Dd7+HMJ1FhiHvedVs2dwXHxwhJ0Ld/ULwku+dn8H//cl0nEqyZ/0N0kHLMw+69Kd
         MCHu0bZDAgjexl/mD1cMM05NwPI4YZNc8mxeTabhfEmpVAdcgT50uKsYcVsf7xzezOTU
         x6T8I5ZPIbz6c228ooR6lzv2wm0a1txKf1Sh+glUO0Ux7IT2r6479fAa4ctTLpiUZ+K8
         fIfa5jYdFx37g6j3hSzMu7OBY/xTRMBmd5BQ4DrNIO0JwHw02S/XDWSIunsNc1pjh0y5
         q1mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794859448; x=1795464248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        b=hnqDx80H1BHGMZ+jCw863LQE2wm4hG6wTw//ziQNWkZpZIjdyNNCtFJNcbykSvuJWZ
         RrqgQGru9l+9Rlw9NCoAO7RXSeH6CHzRwb+h6TsbT77V+vTLtC7o5AslWzWJ8+7yhciq
         sbJxN7Yoz6y6VYO91QUyEDVlXVHt5e/uzOZriYhKEljZIduQH6pNfhdOY5sHlJFueOxf
         bN/uTLfuNBjnHaTZ+WukZQS/Wa30tWyiKsfqEPmOKtkcPCgN1gGIeLsa9pfco/3ZvP3P
         koo3Bb9/+esUnHdHS2hTd5qtXE/k/xctadMJUuU/zchcL0VDKvTRNofZgdIQ6mLOou9W
         X5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859448; x=1795464248;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        b=Nuk8eafYAFcNZnXrTVi4I5IYJkcy8SH6J81xtArBiBc4348qJXhFGJrhzSN/6aE1Np
         N+PQ7Yygpq8aSwxb1wcloef2lTgyzMWVnheLv9r22aGrnDkgW+8NXjry22V81bKU9mEm
         scatfM1S8wMfHitGVbTG45D5FTRK87++pbZy+9CS/6IYtgC6XXl3QPJ5SKbR+2mpt8hm
         qIom4BAUgHEj/UPsSW8guVCTA6TNeQbz8+ELUryB+cgabpmlfK18HsHmm7RtKLHM8I1o
         lEmiXBUMV1CFAhLpJVlsCzkjOTo91RpCgyunH1zU07X4xITYiJSjLwS+s2y7XAF2WO/U
         RiRA==
X-Forwarded-Encrypted: i=1; AL+hErFAQWxU8i06UeNZi6GTD0h0K90tGfd5uI7xI4b5v/R2flqIxuPq6cpOZi5TyBlWUrSmnQmbcbYIBvFmkg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8S8glqujh6PPs9Juj5ftcg4W4aY9jGC31e8TQTzJnT6JcLCMvO
	8Ex1MCyxQWm0FjxdR0BBmssBzbt571euHCpfIlBCXA0Da9DNcwSYxIOmoPyoTQ9TBvhZswhm7nb
	2V8/hoyQuc1U3+Q89kdStp3Qji220ZMU=
X-Gm-Gg: AZFdTZd1z4cd32xgaruEBTyQJqEsNniaeW50YN9gbRmH8hlZlvxO+uPMYRcfOfCHZFs
	fd2PL8mX3XiThhQ2ewzsj7zS1wqv7yqnZTT9ZcFa+WbYC9DZhBRvm1FheeLhCalMGsRacKn4qGL
	2fgPUBy3ryjrStoJNZiWYXLZ4ThieRvXUvFgRVRUgT+KquXcOa6hGlvWexsAj6JqDwGGf9VGxi2
	sq2g0Ybj9arwr+YO5jsYYrvOfm0v4TWnz+lIb165PuaW0zLInt0PcZY3xF+qQOwigOenpC1LIKS
	txMA4BxpIOASXo6+bJcM3+BpfcKymHqcnw42YIDsKFWQgIY5+4b8TS1H1/cUT7IxsVhkKliCkLD
	IhfP4sARE77C6CG4xPOFaa6MurZNb1gbnsho0tKSY5Aj6s/3hVFq3XKnstzeCmmIxQO+vdkPBta
	7X553uLlae2IkPruBZ224=
X-Received: by 2002:a05:6000:4692:b0:491:3fdd:af34 with SMTP id
 ffacd0b85a97d-49d61c80db3mr13343868f8f.36.1794859448335; Mon, 16 Nov 2026
 12:04:08 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-9-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-9-8cbbea1cf34f@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Nov 2026 12:03:57 -0800
X-Gm-Features: Aa3M54q6P4M0RFDCKQ8HHGNCWJafItTSPdWR1qNwVGtToDAv2VOv8vDfWHzYR6A
Message-ID: <CAEf4BzbLFVawibuX0wk=8uzy0WZSYHbkgK55d7rqLab2qAM1Fg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 09/44] bpf: use fc_init_pseudo() for bpffs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
	Alexander Mikhalitsyn <alex@amutable.com>, Chris Down <chris@chrisdown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 3:21=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Initialize bpffs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  kernel/bpf/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index c6f328e4752e1..57cf3775c0766 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -15,6 +15,7 @@
>  #include <linux/namei.h>
>  #include <linux/fs.h>
>  #include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
>  #include <linux/fs_parser.h>
>  #include <linux/kdev_t.h>
>  #include <linux/filter.h>
> @@ -1197,8 +1198,6 @@ static int bpf_fill_super(struct super_block *sb, s=
truct fs_context *fc)
>         sb->s_magic =3D BPF_FS_MAGIC;
>         sb->s_op =3D &bpf_super_ops;
>         sb->s_xattr =3D bpf_fs_xattr_handlers;
> -       sb->s_iflags |=3D SB_I_NOEXEC;
> -       sb->s_iflags |=3D SB_I_NODEV;
>         sb->s_time_gran =3D 1;
>
>         inode =3D bpf_get_inode(sb, NULL, S_IFDIR | 0777);
> @@ -1261,6 +1260,7 @@ static int bpf_init_fs_context(struct fs_context *f=
c)
>         opts->delegate_attachs =3D 0;
>
>         fc->s_fs_info =3D opts;
> +       fc_init_pseudo(fc);
>         fc->ops =3D &bpf_context_ops;
>         return 0;
>  }
>
> --
> 2.53.0
>
>
