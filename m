Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904595;
	b=LwKsg3RywLm6CtSO/Gra6czabm3JOQUf7PxzX1kPMxXPuQPAPRuRFN2vcQz+1GYNAUqp
	 RUKamb+Au4G70R9uxzE1CtxtC0rDF8qVW1qftnKF7cYN+oFC/mrBEDaNCiynsjzYIPz1x
	 1Pf4uW5HfO5uNm/9u67K8iEKYvMo++sjcgmg8fWoYSSR67NNxdE3CAOWDWFm3bXLwqqi0
	 di4z+/bq8Td/or28D8zklhMof+idudm8FsWt/cWj2gPTmwQJMRcEesd97QWYO07Au+1Y/
	 MnRw5nLeRLMUUtX6Pf4jeM8C/1i2tn+VacIxWdPhHGbAS6rJq91Ohj2YJtlhNPpNV5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
	b=pNz/CFdoRSWw/lxfHTqpAH3xs5bkkQkk6F/aj/ebD/Y+7xsBog5fhG9KYi4abVfz8Tyg
	 G+yQSUCh03qfY2v4PjUQiLPl+2RaOFsbiE41sSQp8TvL3pyFTRPlIjK2F3+Hg5wfKfeqp
	 0aYUxQWzzbU7PetGz0cuIT0NV+TtZocy9uEti6nuJfiN3YnJwnyiagCVJe8O41vPP3cWi
	 Ms3k2sYGtjffRB6GvZ93SVO9KcbmeZ4bAr85SGlw0Sw4eKwFtzgph6X+i+BqCFWkKdtjN
	 GaAx1PPfl511YO5K91eXKHfqVwd/GicyPSisV7eFeJGvlYkKGFOxX7XsoDj8AcwnL3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VB84C1sh;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA088606A89B
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 08:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA088606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VB84C1sh
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b467581b98so39088975e9.0
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 00:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904592; x=1795509392; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
        b=VB84C1shjSG034pSk2oK3egXlQwWjuu3VjrdbAKPawk/Twv4Yif6yhPlbROFWtMgPQ
         3tz2NQZOgPBk3fq0QRZC/paJXFCSb8aJt/mhh+A0iXMTZvR4a2C4xo37cxqDT+bS5wyK
         cFfqQ64HX4H+WtOYlqmaNWk53bLD4rVzH3Dam/22N7EldMgTIeT60YiznWNjIzN+eEJD
         Zc6kl9xoD3REW2KAU35dfm9/7zuNgWUL6hteTTxoqyJmYKiacM/NYuvwNSKHsMwzezat
         1L4qftGlpMPZouPAaee8sA2dATEpRVvU+RzrgkUS2mvSj/+KFRi5Npjbd19v9tUdsF88
         Zbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904592; x=1795509392;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
        b=HC6w6f2P50RPPJX/mfrAUAKoaH3e+mvhVyhIBz0sdTOPaOpDHNsjl8fLi9XIVhfqsG
         wUVotN78nBz+OXLOhtIMxNWf//g099hNR88BLVWraHBvyrltnToUXElxT8lP+/8RRc2z
         MUb+Da/fTSi0wCLcghL1MqT0EAjHjb9yF1YBNfXLprzPqnJ9ZVLg09oXSyMc1opogcWf
         k/9advL3GUhm6exTM7K9VQm14ONhLr3dch3csc6//MmDpn0ks7bdL7IXK1SZzInuAYFa
         To8JH47i/YEs/C5MOvEF7HBEKHhoJLiuT5kMcR3E88XjKnt2+shs8kus4S75T21w5j7H
         apwg==
X-Forwarded-Encrypted: i=1; AL+hErG2yD514bNj8+Pm6baxEkwDjGAPcoKfRCN+nCIXOMe1GlV6Uz8pH3L/4qKgToUN5Nvk8HVEOI3DHqfq7Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Z5SCp1/YZIBF9kH0zOPLmiqCp9N/ho+/VO23SH7C5uqqaS50G
	NQPpCj1YoZs8Lj17ZDMbk893mVblpSJipN19vmWhQlnFk+LNlnhzIsYJsPjlV2y1ZI3m
X-Gm-Gg: AYBFou39FH52YO6FqnW7fCAJ0z8ZFHwop7WdKXV7KaiIU/bJQgUmUAiQAjLhBx/I29x
	9ahD56HCIb58hep5e6BPYcax82QNbblX02N28Wce46+uOaRiACHKZjbrbr9v1MU4OADx4PtiI9u
	7nvGL/x4mRzoI55KL/bX4ua/859x+2U3zbpraSo9hGwCOYq+InpBLU3HQAkgrdFlGv5eIhKI0wx
	X8RVUsWrPK1iXg4UjHxSRLcp/aogw+VHsQZEenqLr0gssksmaiEpeyWr/GfGpt62+lwu1bTrdgY
	UtXrpEtZIVyza2mr3dFkpP/qPYmig8jvZkBghVDfWLRylagdoxhnwTAA96ENJ9kxQfgGzoO2GdL
	2ftuXGLaeJPX4YQmzU6MxYnaSUoP5DXR7GZDBkwHZNnJvO3J8+PtWPsRnJH8CkSzFK8qjw/9OeN
	bA20Oh4hePMtxk+TCWrqBhPTP2mIBZNU+5U52Lgn8bVfU5WZ0ZxFcXVSB78sTh/yhiBV2RzmCB4
	XvKdVLN1lky1biytiOit35YQgLm2q1ssgEICH2qltZylUR+PvUmtUB4/xP2xpbxGvAZKAyMfGrM
	ORDnYoGaVW31IHzzQINubWvucoUVSsezglezu42m4p7oDh2D7tLGMr/iZKzttP2Km2EFuosA672
	VTBso/FCO01BvQ6OeVuTFxiYQ7KVYNy1yr2vsY8fp8B+A1NLDvRXzTqUj
X-Received: by 2002:a05:600c:1f90:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4bb55ab281bmr266345525e9.21.1794904592167;
        Tue, 17 Nov 2026 00:36:32 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78430752sm52548565e9.12.2026.11.17.00.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:36:31 -0800 (PST)
Message-ID: <411502f9a4f940c223b2b88d7e19fafdce63172e.camel@amutable.com>
Subject: Re: [PATCH RFC v3 29/44] s390/hypfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:36:30 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-29-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-29-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:05 +0100, Christian Brauner wrote:
> Initialize hypfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. hypfs never holds executables or
> device nodes.
>=20

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0arch/s390/hypfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
> index 559b011e68800..8662169de477a 100644
> --- a/arch/s390/hypfs/inode.c
> +++ b/arch/s390/hypfs/inode.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/errno.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/vfs.h>
> @@ -301,6 +302,7 @@ static int hypfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	sbi->gid =3D current_gid();
> =C2=A0
> =C2=A0	fc->s_fs_info =3D sbi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &hypfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
