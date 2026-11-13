Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564378;
	b=4czPS5PTLPylUJIXtoTDn8vr4cxe+dobe/XWnxJKzxulXIxV4MsJYwjMFBbXpWBbUYb/
	 mRo8FHG1l1LprrSfq8Uc+70qI0WrZ+VoxWqKUbrfTgyvD1V0/ki/mZRqe9sohmsJ00/rn
	 ub2s2RJYNqCrhdTr2t9OY7GJRGGVO4cWrD6+nsHHzkyB/im+BiOXE5h2W5YU7D4BNyLRX
	 7mlai5OBGxH97p1DCdhHRk0pRSWQtzSSb7nyYLwEKMuBW6kQTsswZTIX8ZcHKbeuuYGYP
	 c5XKA67rmqvR6M1cxb7ETYAIcIWqa3uq8CMrZgDxGXPDfDet1AWrbBh4hD0EWBInMOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=oBVCWZMOabVq55k67Q8GIm9NBAOJHOxllLRlvncSbis=;
	b=Uuc1f6hBaRfxvlsecGr3y931+ew0/WQ7+9xkIf6bqtDVtlJbtBXyGNMk8SlN97ox+Avv
	 ClGTW77/SUd5ORAI9kcYl1zfshv8HWR4jOx/DE3FW+q1TcFdtdB8xa9iiST42GWhElWKJ
	 xCwb5T6CYi5+I8esL4ni67hezDyOm2Fv6B5lxSSSNjVPFDEo0EgKSD2YMfdTKxYMFBM4M
	 HSqMS5B7ZNkzs7u6V/4IonQrXReuDTeupBoymo/dxBwYQYbnYxAdi6YQUhaaZu0II13OZ
	 sn36c94geQNWH0qhwLyym6agpj2lfDbfIcFKE77rsXNh5UAbLP3MYm1H32ASuymAW3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WDdVkHgl;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC03D606A33B
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 10:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC03D606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WDdVkHgl
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b785ca42ebso1499719a12.2
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 02:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564376; x=1795169176; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oBVCWZMOabVq55k67Q8GIm9NBAOJHOxllLRlvncSbis=;
        b=WDdVkHgloKbBDmiudlEZ3ZWe+zg0BVZ0Jxwgdy+X6nc8ZJ9FIVi7F/SYJVqBRxNf3G
         3Gnq29xgDZdSKYiYaDVmU8W0xCuGm4Eu82rb/A8U6D5iLEOgHTmlDog4vSfdCU82B9rm
         qMGycG7Kl4j8h61zt+kqUkohzwqy0DPARMdjq2hKw51hdb6jylA1cwqwSD8nreSBsEB9
         DkDXk5ueYK99P4pH+jY8EwMoZnNW6BehoecLG+1JSq6wWJXsZMYgAdKGybKKFJkxuO0p
         O8Ri4u2My3QdIqEe8fwKAquZP0382+IuLTCd4KpBNa7znuGAHwPb5rxafjOggGTtG7Td
         r9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564376; x=1795169176;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oBVCWZMOabVq55k67Q8GIm9NBAOJHOxllLRlvncSbis=;
        b=1B498UPfTYY6waSpB+/eGeOu172ukAzl6BGImfVMTiZ2bZA4fm8oC6Q5Ce8KAd3j+9
         1bS0JT3rck45vjgcddzQ73L+Q3ImPdwv46NwDXTXqFd1GfWgELXd97Q41VDYT+lOL2LS
         kGyGckPzCAubkVKyBWMtof5v86CtsPh4PK9TfS9gsQYi6AfyljgMNWs9aNLhE0af7QIZ
         LrcL8YCCayxBbxQNfJznwpVtMtecAvxuKWgR1pP8xm7OTlzUbWKRDjd45xRaEhYJvQjP
         WXsnnyCoUZDUhgtF5xbZuRtL+X7Ao+5jdLJ/qlJzMmUGGZuMDsKdoFx6SJtSBvrmIG/k
         4qoQ==
X-Forwarded-Encrypted: i=1; AL+hErERGrJyXvMTC0TxKiUEG5vrabubkkRAv2utLGjQO6wjxbrN5LQdUTk4XmqXG4XTR2fTjHVCubl18dGMTw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/p8vo0NiGP4AqxNEKTnp+uaXqc9J0rwpWjxQM1u9nqj5Ib+sbq
	3+kVuvTbmvjNEdIfkY5dB17jJixFUFffoqB6eWlIvxVNu94FNpIAb97sJ9utS3jzW15j
X-Gm-Gg: AYBFou3G5+PzoaAwyo2hcyp4PaJTQ39kH3Qc3HLArgZvHug+MjZmL4se0+eqj5ofXLT
	3ltR88ug9jloUPpopUMH/EUj8HBf64jSjYFiNJLrPhvmYW5kZpVmLoxnl6rdKkUhfmfqyLs3Tv1
	eXmEPErrWs7TQMPuLFNygVMUapGg0saiIuQBJ6zOB0R2E5pVmj5ZGdvnVg3Cpx42RgVIqASTM0x
	znDvT0LWKnXj95Z9WCaI/16rAOSQo6505YRB0E5ChcsZ3xe/N4wB+mpHSCmLKWjriA2YtqfshMa
	4Hdyyn5ED/LNGX9YrCXti/xk7T8O2L23pH5v4J33MqocpDZfWIDG5lCxGID471sza/lVkgNfWCo
	x66fx6F4uerHDS/OcncKsIQjrHzt1+aSn6MHam3wE6Dde0F+G1eHYh2+0BUjgl0Cq0P3GqGPV0H
	Br9SHR21A+r9A1OE1EvMAODWblu6KVtOiobqVVmv8kPQj3LgG/Q9BjNxNYnkIfbpJ8XtvCq9SYh
	0A4k6HH6nv8VDWdyJCmHd4lfQE93VMi8zAumIK1W+hV1PVfBQVpcBBXRhmkorbcrQGkeY1U/woX
	QBj7NyOe+w8HMrS8tRzK6x678XpMg9PZ1pCNfBEL3JXHgSC5wXXxBJXC3ifrdl4=
X-Received: by 2002:a05:6402:280d:b0:6b6:4dcd:967e with SMTP id 4fb4d7f45d1cf-6b7c0bbc394mr1685420a12.20.1794564376161;
        Fri, 13 Nov 2026 02:06:16 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c21b1b5asm706711a12.4.2026.11.13.02.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:06:15 -0800 (PST)
Message-ID: <4dfa19dd41ec1a202182284d9617926a259288a7.camel@amutable.com>
Subject: Re: [PATCH RFC 16/41] configfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:06:14 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-16-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-16-4c998976c6c7@kernel.org>
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
> Initialize configfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. configfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/configfs/mount.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
> index d8cac1cbf3bd..60ba24e7ae2b 100644
> --- a/fs/configfs/mount.c
> +++ b/fs/configfs/mount.c
> @@ -13,6 +13,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/slab.h>
> @@ -106,6 +107,7 @@ static const struct fs_context_operations
> configfs_context_ops =3D {
> =C2=A0
> =C2=A0static int configfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &configfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
