Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564825;
	b=VDR12QaN2e5RrmhUVee+xqyP9o5DRWyxZ/c7as5vYTi7XzvtXpR25C/gN3fqGGlqTZjy
	 r3qztq/TgjTgr4ZhTXSC/oFfqfzcRnAyqzEETHT5Uj6sGVVtAMewDV/HBB+Ce3kjCb2m2
	 K4G5uvyMZJqbch1Xrt7RA1LywwWvcFC9gK9GjU80hBVjlpIIhGP2sJFrEHwK+fTpt7nh1
	 Q/yILJLjLRr+xlC17KMm5cgwtchGdKrck5szr+HfjTymvzi0kXHdYRnQFmBz8yjEqU0QX
	 zHHnerdguONKii9Dt0YAkWikoCGYx2BsY9HNDTlkU6ZJklcT54YrSniZoRawpWXOyaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
	b=aauSuVxumZPVBQ8GFkLzyhHvaG/IcHmr/0cxAU/tHL5vYTEnrbEywqPFPUK2NUU/9o+J
	 GTA3DwBcXmSnBXrqVW0MIjV9pNJ9IL0FVFmRk3KCZWMclvUBqcZA9iertlSRK7XJ+mgS4
	 /h6dfnRGS2dZ8sgU/AxS/hHVw013ACeHue/OE2MYSweeJi1BRGY4qZg7jxOHCaJ7P8/O+
	 OEqTUIL9X/PE86Sd+ehdhyInBJtRDCF9wi4L8LRJ7GEIXdz7f+d4wNe7P9TeVmf3bS1aI
	 lOHVoruYe46M07S2WQ7WEXgu5/bL+mSPtaS7DDqgabiIEf0cHvEZLqrVCygrNgNISSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tBSDp3uS;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF7760A2607
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 10:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFF7760A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tBSDp3uS
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b581b6b0e9so1096347a12.2
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 02:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564822; x=1795169622; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
        b=tBSDp3uSBFgypsbtBQgsadIQZQK7UWodMC4WHZVi1N1ipHHYu6WywVfCa4AZ6QIaRM
         wIcOajhLTVFUJp4yf9/N65gePrg5n4K0AYKI0yA+7KNwnMoUY/irx0jTqY91Kx7jR9xZ
         Pm03fPe9TdsIWGPKhcU7A4Ssshd7c8Dhe1zzS2a/pwsZLiwc6FmAy6ptf2LWGhArJX18
         uzRhPjO9k+hyhG0ceM77HGUPCflD5+7VnbyODCgVUFUm1PdMwYT1gZdGgKWe2z5NHlJg
         Ao5qYJPp+rBAoBURzi6iHuHACVVyoOXqBDLcaaEy2+qVTTu+93IkZN11FbEDMtWMDX2T
         mB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564822; x=1795169622;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
        b=DAkwx0MrUF6g7UhItHtveV5YsfgTTQjEYA7kPogEwjclTSfkPXgjr+OqFcr8rEzwZH
         ABF/82u3aDUbFjKVrk7+1sPCE86mi55V8qdIl152Q7F4eaTeMeKZBlxKpmmoOUwWKmo+
         6hDRP2cjMZ0OqiqUhGFoWueub6lsztqi+6lCI3YFe839C/fOYbwjJIOg+ZBaWSJBnbcd
         3tFeTcRLMw+Nj6IyIy5vFm5DaxgFTxCSRBUQN6WhNd0fNDwBYedEgn1DFl3Z1thFVh6p
         bueOWFtA/RyQLoCNlieT0Pl+f4K7AmlZIR3or9nymSFjXSyeRATmCChKvt6VNPNgs9xt
         wPHA==
X-Forwarded-Encrypted: i=1; AL+hErFvNd2c5ZY7YVdxhMfO4s5+X8rfgOpc+fZQ4kIMx2wJNT+UAjmxdNPp+sLDP/rYLf3sOJh2617UZfhH7w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8CM0aHcnK1ECaebSEYgg5MF1ZDC/rl1/JynO4e1z9ELvY9Z7pi
	iVTwVLUzKbBMKY+0Sw4m0rHGeVSxyIlX/vVC6msZKmHyrZZdfnYVzW/DNFKhBNq6DZVw
X-Gm-Gg: AYBFou0n3vAWR/n8aiguVC+DT6e71RgnqW/5Ma5K65LD19fGDijwkjL4CgSkXok3j1k
	LM90FAPEYOkysFglcV1pJ8LzS6muv8f4G5ifnlKkX2TXXRG+V3GgdLjPAXjDFIQUs+wMNVCMMN/
	GTsi0rBiIX+K/mq0nhMA6/lgjWrAy5LGM0hyHTFoHXH+Taif35Jp9LqpFFxctuT/DNdx2Mbgqs7
	f0YhRad9sa2XjML34wGLswg6kjIVQIqpS6WfHerdS+cTqwK2rhwplkKDJMygwr/uafnv9W3TaWg
	Y9B9UBBA4Jqyfk8rHudmRtBEx6F3YPOkrrjYxLZTXcz2OEmTfYdkec8gym6O1k0a/CguTro7xw9
	w7lr364f+ElJ8I/z+J/lzxsNO2+1GMY3fAD7/TCKePToS2PQ9eT3Wvp3pnOKvoXOrfv2xx2McsI
	4PmpN5zwl3x4Js3khctvOA4lqMch0viRQkRnmOQZfKGyv41mqlL3W41+q6coyn3QrQmEx7yTTKs
	rTSoj58TR8b3BnJLIr6F2nKii2PU6Lg+Gv+nPCryUH+KXUZ2+7fptn7kBKlX4bsEizNQB0+K+C/
	VNluynfs5JLAphDh6UEb4DGmJ3sPqmRjVO+m3UbdDVDddTTqc/yRXoaBNLU72cQcIS5HrnWMb66
	6BXXZ3X/d
X-Received: by 2002:a05:6402:208c:20b0:6b5:69f4:e7ce with SMTP id 4fb4d7f45d1cf-6b7c0c62bacmr1415990a12.39.1794564822367;
        Fri, 13 Nov 2026 02:13:42 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4d29sm4332158f8f.35.2026.11.13.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:42 -0800 (PST)
Message-ID: <3546dd28b1d63c1478d391a2015fff4c1b976639.camel@amutable.com>
Subject: Re: [PATCH RFC 24/41] efivarfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:13:40 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-24-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-24-4c998976c6c7@kernel.org>
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
> Initialize efivarfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. efivarfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/efivarfs/super.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 12746ced6dc6..e598d42c5f42 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -8,6 +8,7 @@
> =C2=A0#include <linux/efi.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/pagemap.h>
> @@ -554,6 +555,7 @@ static int efivarfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	}
> =C2=A0
> =C2=A0	fc->s_fs_info =3D sfi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &efivarfs_context_ops;
> =C2=A0
> =C2=A0	return 0;
