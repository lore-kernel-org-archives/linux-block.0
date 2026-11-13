Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564223;
	b=NY+MiYMvZt89nyXMkBza/+aFMBP/7JFq4GtdztYfntEFMQCglT7VqZjoxaE5Ai8Ur7+G
	 AjUsjTFNBDMrsbh4nd0CS/Qd53HiwC/DeDtI+ez2GIcbx2aZVhsxN+JCXClEkL9mmSuTN
	 tmXTRLjSmeOxe91c/OfyA/uqorJLwRwwHsBMQIEp/qNp5BEEGa6nNzIAIA4drPPnv/yDQ
	 ddfJGl327VsSPBfMCUMqNw4JQWiD1fA+CBE60OSRO+xuR/udcimRivgIRZ6SvqBzzfQWk
	 S6VGIJF62yshmRmved4SMhKXqQrkRBC62hgP74VFwhXI8r1grr//x1iQLuiRCQ1Vjfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
	b=s2M6Oy/cV0SxtBIGtYlj7wP8UKoIScGD2kxScKtLA7uq8V/mW1wLKaZgUEGdcqXRTm5C
	 ytCJ/EMWTazFb85/S9isZmolYm8hvz13yApqVaRcZb0q1W2RwmRxfwtKu0fIc+hO/7pkF
	 fqaS17MEaxQ9zp3QP3WCDVyq8RDYxTCpgmCbvI8Q3sOsrGKLy3+rYPkh2Js3nIT9epoLk
	 z0BN+EuCuAWabWLdZFenoWs/WjiAhe9Z1WVywzt9vAcg7PcB06vCi7U/O3G+VEXZlHCCv
	 19p9njJss59pR+NR5mdrZXoMhIszwZR/3735mZwz9XGbuYiXaZcOLMhh8GTUik8myNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="YppAuU/f";
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B893760A2622
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 10:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B893760A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YppAuU/f
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b7245ab5e2so3385673a12.1
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 02:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564221; x=1795169021; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
        b=YppAuU/f77eWMTZ8F/Y/RTjltBDd6igz4EttMolmckndL9mvAt3euwqVCnUFPcnj1L
         wpVFClVgg0YlcE6bTABHQT1NnQyujG09t70SZ+IGoHQq0qQgGGwB+4JQikI2kaQwvi8W
         H3KupRONVF9kXu90kRN/xwbfNoANJajav9pnhnb3IMIJ4A6DWEq+8017kOKRrUT+YN/m
         jRUDmGHXRq1c+43Y1O2K5XEGEQl+nQ8YkAZ+/5vrEItOhIamTuHGEOkZUAeGsE8baOwB
         Dj4haSBpRwT/bMXANPqkevI0ogqYaGkZDRE/CPrkXlmZ9T16K5sayD5Snik8DtXgYcT5
         haBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564221; x=1795169021;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
        b=r6XRywnC5gzFFNo3uo+5MfRaFML3C6y+dDqsfwSfh3g1KeQ+/Ds4e5tbkM0OJ9S5qF
         H3oJgOu+hxAcU6oSYckpjqfYnEMTMvm7avCqCj3stfaWNGQDVEyTQ29VSQn6IJUgL+oX
         9UjAKrzPCIvpsnFDrJ4QmmmYCQlEKANpk3qhjxbdWjB7i96ijniuK3WCSo8DuPsXkzAV
         NX6DU/Cg/PJySSPscTseHUnkMo0DT4kHcqJQ6TSio6jl4plo3+rBNgEs+UAiueULOWN3
         yUjhBWRtBVyvnAqtxmQXf2lBCUf7eqY9R78fzeH3eK0/6okPSAOmpWvT2OcaZGe2xP9o
         CRpg==
X-Forwarded-Encrypted: i=1; AL+hErE9kNOU94zhs3VJ0n2+ic9oc4hpzusDkrUiuVSnyuml1Mkynl6VDnwc8dmGSbkLP8YiyVWG34ec+3/5qw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9rO8IeuxbMV+YPuQ50LsqCEs/FcWqYmUmPiN1ozgl1PEfBhain
	P+F4AnO22pzbkrXfBLY43w+TugpL+YDLPQTXEVl/YyipDHCxov3uF3O3U2OOlB/zd+CY
X-Gm-Gg: AYBFou10h0jcEHW71/tJnhlKH3VsuEPA/jI4GSwMN15y5pcZZxJxlJPVYhyEo71ve6e
	cwoVklsyLl5LTb+VcqehM7tKIjil3kHxwBnYhMsKzZkCO0V8jXysgE/svgFGEvTucwwf+BtgLoy
	VjK2yB7TD3cKTxTin/3zCsbzFYnjTRQmmeqlsELrVnaDNVc3YisIYfM9MU4vGUsMzeRj5eSLYFR
	YsIhUhuLkLcmn7BNJIm8j7rHMD3oeUHKvAR/pfgtXnHb0p7R87O/zt6jBjLYI8D73eYMdzOAqBw
	0fm6Hdx7Mgu+n7fSL1ZOxk3RIqkGboSSgBq9Hh0xELjMY97A+AQC89+32FrmTjVpZD/PV3AV8+3
	B0hn1mDfJElKskhZgvnp9Zr7/LbtBxrnERrZUsFFt3oL2lYa8yD74jG7T9PLLlV63eovsEsm149
	OdNbTOxmbsvFr1uWGO/i63lj2ocDOOjhfCHLjK+/3NZ1g+Itqsm+2hOY5LJohkqwZn+2I4fFm2u
	eJGT0shZNKHvZFXsEXvxg45+5XPXgoDX2YWqk1Pxi6BxHzqMCGLpt4Q2LadLOcDPrcoPLmZQgtg
	790IVbCtntRU5Ygzbe2elH7TCt5q0feF9t27cfxBHkSH951NMzKWo/Pz67my5YM=
X-Received: by 2002:a17:907:7b8c:b0:c42:bc58:f21 with SMTP id a640c23a62f3a-c50963856f2mr175546966b.15.1794564221164;
        Fri, 13 Nov 2026 02:03:41 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b3asm74752966b.27.2026.11.13.02.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:03:40 -0800 (PST)
Message-ID: <cfcbef5caf7651b63774549fa1999d34981c78a4.camel@amutable.com>
Subject: Re: [PATCH RFC 09/41] bpf: use fc_init_pseudo() for bpffs
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
Date: Fri, 13 Nov 2026 11:03:39 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-9-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-9-4c998976c6c7@kernel.org>
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
> Initialize bpffs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0kernel/bpf/inode.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index c6f328e4752e..57cf3775c076 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/kdev_t.h>
> =C2=A0#include <linux/filter.h>
> @@ -1197,8 +1198,6 @@ static int bpf_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	sb->s_magic =3D BPF_FS_MAGIC;
> =C2=A0	sb->s_op =3D &bpf_super_ops;
> =C2=A0	sb->s_xattr =3D bpf_fs_xattr_handlers;
> -	sb->s_iflags |=3D SB_I_NOEXEC;
> -	sb->s_iflags |=3D SB_I_NODEV;
> =C2=A0	sb->s_time_gran =3D 1;
> =C2=A0
> =C2=A0	inode =3D bpf_get_inode(sb, NULL, S_IFDIR | 0777);
> @@ -1261,6 +1260,7 @@ static int bpf_init_fs_context(struct
> fs_context *fc)
> =C2=A0	opts->delegate_attachs =3D 0;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D opts;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &bpf_context_ops;
> =C2=A0	return 0;
> =C2=A0}
