Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564363;
	b=XWtaO+zKwvs6yrHJXUtEqgrAPhI0UhBEOlDjZEEVd5CZ/e6qkdqjxAJIm611kpmuxPtr
	 UazIgg6UJq7vjLRT7tNWPF804LLZZSNeypDCI+UVOXRu5hUpSb55NXcpyb1Dl9gYedHkJ
	 xWkkMJKhG1RrkjeXdClVay3DngLaCItee6+Tqprpr2v4fFRPhg5H0uCYd29vudcDbxV66
	 qiXr7RpzyTiWnStLIEQRhNz6Iwl9QzFtmf+qPn8NE1bobZuddvyKx+K0gNwGKiBazmTuC
	 fLPcLOc658D+ZseykAqWUdcLh39LmQNj6saKCg/+fcoZGjB1S/BqVXT8Jmdc+T9KlHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
	b=gr/mpJ3q9a+AJuoywjeU5biVulL5XZiL+6ZACZ5/aVbmmO+O1/TfEuubsnhc6qJquoOd
	 B7wdHIUv67SczG0Vnx0pr32ILkFUo9Y7msa8JvKAl5i76NTop+m4pud0CQG6TFbKgAUjR
	 csBFldLYnF6r4n+W+VcABps3pBDhvmWDuN/kIVsPSw4mHAcDcUFkAstQ1+74O39WodVW3
	 +SWGiuSVnLWopTES9BAWUSCHVIz7y+OKzGYzl2yC8erT9mbOBtPw+yZaPrNS8MRqEnlvK
	 13hB6ZZ9yZxiFsK3Tl3vcZHoKsnmqA3A0eZhWVHH7FcvJYwrbMIvdT9Cfocex6rTp5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cjEYfKb2;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C4660A263E
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 10:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2C4660A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cjEYfKb2
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c50a4a2132cso51085466b.3
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 02:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564361; x=1795169161; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
        b=cjEYfKb2ti/xguKoQF5XePY0eNOezud7K33Duf47S0g3JkHBuObkd06WZKSsE2j4TE
         DEwnxkXlTao4933EWT51qAqcKFQZzBDYUWq7IdS+RrJUrXD2u7QTXDm9Wr29l+nlsY2h
         ba2aoEFnt/fnBZ4TqG8AlHBTx7MlaAOM8MSBIpLqFecTqJgM42mukp171NeFhmx0Zx4N
         EfXY8c4e2NVT5eQpV/Fv1f87MHIzBgzN889RZpIYFKMs83t0n9Q8bpafRw7OfeQ9pMp+
         KOGhNvmnj7I3xZktgYLxquasfZAW0tMnNpo/9hpnK424qA58Vs+J+ftPxNsRzOLYAEav
         G1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564361; x=1795169161;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
        b=y3s22x2yqkcO3h10+zgRkEztEhVrShqDmIact1xP6435t+COsirLXQbJ+Tw4CDk5MS
         LrHGk59OtFDFhu4mhBl/dzoNTNSYJrfBZakjo4s+vpHpPgeDBWrAzY0/5+hlpiZ7Elsp
         HbfHBykAXrkzDktEOZ6BCxbEsW3zIT9Y9Lbfc+n3B1cEIwAIOA9WXYE5Nw4QcFOL28IE
         USOnbhpaqUbVE0CEykMwAXtcELrCpGeiaMDj+r2lh57WMt0pIWlonqaTXHbkEM5CitPu
         WQ68dkurMMFisiReTR+/F7xENbBtZCb6FJaa8o373Ctxv9eVrl23Bj/ewwUpGZ9DX8af
         A+Cg==
X-Forwarded-Encrypted: i=1; AL+hErG2rukq7QubHYMqPewtK/c3hEz8IEnNIkG0xnI1FAQqkBim2MgsflGE7MeQsbk4q2TcygL1cymE1WgLmg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8zY++AtcqJpcdttyJR1JC590iZ5TTiF472clNScIVoC1hZwg30
	JCP1xoZMIubJlbgzgpCcPXstxHZ2knzUPoaBmyHmnL6D7B5RMSX33HxBo358DNa+rGAq
X-Gm-Gg: AYBFou21DOK/QCg6zugLO56sbrsZIZWStAYrqWtvcp62XdEpxYuKefLhmrHxM4mDYAL
	nKsvxDvgUn8Zxugxn6phqYT/RAkYz/to8PqIIFsKXXKhQSK7x+9VDQHwnW9Yjk8P5CaTIfz4Zsh
	yEE6FGWwlN6wnmMN2AghOh/BxN8NxNHkCKfcewaufoKkPtMeEcEKdyq6/H39bybfeLnzvNUcuU1
	xXpY8JLW/7rw9GgrFpbszL1s6F0RGkEbOKhdxhnzo4f/sJcvCxmpeJnxKRHMGs+JfjumXCLljky
	yMc6EgNGQASDYXCTzGcLunr26834uBHJ2MjnHxvhz3KA3XoSR2fnARcQiTKd2kPW+iiTOXwX9F1
	GAKZmvdExc9VT4Np1g7UiI0T6a+dVsENxcHZcYqmOkwc4D7bJzLfuB7mRn6IxQOcVPW8rIHqObm
	Q5JONla1ZNWF9HQajwPIiyEp6p0FwaLxfYKR9r0f2VOEBBr/FjzLbwNdy5wK8qN/bXJPj8TlbyZ
	IgE4imu+bA8mAvz/GC+zYzaUqh48RcI91+hMh+5KBJOx7k66gfP4+rxR6h9EOaw7pw6rN/oMud/
	NwxJB1hL8RjFRnfXfwXWps/wUZY0qzW2gmhxQib0tafK+ck5b4VZ8891ESJxOZY=
X-Received: by 2002:a17:906:ef07:b0:c4d:5820:325a with SMTP id a640c23a62f3a-c50963dc627mr169588066b.39.1794564361325;
        Fri, 13 Nov 2026 02:06:01 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b8651bsm73693366b.78.2026.11.13.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:06:01 -0800 (PST)
Message-ID: <e8b71a2778d7d7797d433e7bac1a37ee64aaa30c.camel@amutable.com>
Subject: Re: [PATCH RFC 15/41] tracefs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:05:59 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-15-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-15-4c998976c6c7@kernel.org>
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
> Initialize tracefs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. tracefs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The only tracefs files
> that can be mapped are the ring buffers and __rb_map_vma() refuses
> VM_EXEC already.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/tracefs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 5020365ca704..e04febd868eb 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/kobject.h>
> =C2=A0#include <linux/namei.h>
> @@ -510,6 +511,7 @@ static int tracefs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	fsi->mode =3D TRACEFS_DEFAULT_MODE;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &tracefs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
