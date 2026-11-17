Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904092;
	b=0tz+hAAqH1CNBIs0qKLLpgdDC7Z0sxqlrrZZJIxj0d9R5En+Eq+xawE/BEm7gcf5XK/C
	 M5381V9i1bQotGtKpgpWRjxXeKXsHct4uncHT+Xw7Tr5ujAV2hMv2WuZQ0KafwId2ZNaC
	 e/aB8z9z0nUppU18ZeHMVP7bFTpE88scj0t63CFQP/bPF5Z2VW4NxKWpId5ysAxnP2BAW
	 RMLLPXcWCbfDU+6n3O2r1EGpOhR1zfT0ZsUPqXW+Z9eeZyULoSOZCdNUUhliSj1YQDaHp
	 DOiW/l27BAHjEMzhoIsB5wV8bGQ3HPknoQAajhZsndUCT0Q8nCIlD2vafr3qwWAucbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=AET1JHslkSzLNTOs00e5qdhXA33kuZnL+yhN5Q6hFHY=;
	b=aCrK+4X0MOFPp3R2nWuolDay6Ik3Gp2zAAgiBkk0KPZ6u0i4sTbuVFjX7ZAkMl4HsNgs
	 PPLFaK2WPP51PhapWhpdP9VYJz83ovhC0m3c7auVC2uQ6homeN8F9BNQnSpGllL6j3YUI
	 i0vLYBFxVssatHvkKlqud9hH+rG73Rn0zrl6v2M3sd3Uem90p9C8xLKjcKyfmM2aXA5+Z
	 0EXqD5+otEJ9LufFUyD6FaA7kjKeCT/EHPqP6HoKvr1nP7acfCZ2A7SZZEvcqU/jG7p0R
	 BcU49nXqAKB8jkJPMfob+XriHCvIKbQAjIgxoStS91gU6PIiQGQIBDe4pxLsi0ep6Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=G5kPAzk6;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105F5606A899
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 08:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 105F5606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=G5kPAzk6
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso26232725e9.0
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 00:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904086; x=1795508886; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AET1JHslkSzLNTOs00e5qdhXA33kuZnL+yhN5Q6hFHY=;
        b=G5kPAzk6YKyHaocuCdT5IFslrUJH5/ldhNVhV6xYWUthrOIppv7Y8kBtZdevqAkpzI
         BDRFsu2jrF+YCozPia7EV1j3KLeZC6Lnc8BgBdPYFaePytvbOESC0m4eRkryqhoEbPxE
         WM5n2Fa2IGRg+WkSIkgfyoTemIrDdEbfzZV+2Eacmamzzj+t+HuCPRqV+GPswkKxuMa/
         2fm9UdrHUV6v7jtlgmqycAcrxGUcSbURHcUFMMj9LS/XjgTFJtp8hDDDARovdS596Fjm
         xwkar34XXNuYsLWY+RNo1AZ45FE/L69efZRvwjPbSAF3CGRgr3AaMHZz6Kf/cz8pCVs/
         RhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904086; x=1795508886;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AET1JHslkSzLNTOs00e5qdhXA33kuZnL+yhN5Q6hFHY=;
        b=SNzmNs3PBrHUyFVu5Ut+bPbVa94CjFBY/mIRgviuq2pcbHqs6ftm6vbIFQgkNRYBWc
         jQAJtTCjKHN9F0b5RwG81WJhSkXg4LmUKt9YNBA4kflUnHPxW1yW7VBQpEMoDo3AuSkS
         +j/MX9olKZBXJMMHL3e5voHZ9cpvqsWyO+sS0/EGX988sBE1jfGSGODdXjo8y/e3VK3p
         TrgSC1uHcNr+9UWWP2tknuwt60PVdVjB0SgaQ54b8zxhW7/HpouiNJoZfHRRPA/9mZ+r
         +6RyZSgp3ORhg6UbbaV4Ra22IwQm2F9HrFyFIgGcm18W2XXHf4/3iFlImYfrsnFwNy1T
         RqnA==
X-Forwarded-Encrypted: i=1; AL+hErF6oCIhRtoAX3ysbUmd6J8N940Tu8yWCUyBtX9SEQfRXU83J9MCHzopKUJ0jn1PKF588KNmpHq/TKRrJQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/pN+VR7oqd3RomA15/1bSvjydFxT7wiuIJctQ323q7SSvyJcyW
	W5BwDsPAng/ttdjdJLooDkzp3VbRY8shF/cGbvyQtcMh3R+CSG1EcYnHA+NZQjgPWL2f
X-Gm-Gg: AYBFou0ZkUPEY+4tRAX8yKKvT+FVCYtEAzx3bHy5JdcHqqLERELOfBtRxthq67Hlv3g
	mKzOV/IMYpmWO1Y7MPDSFqqlLY6JJQgd8XvDLNzRYOQvSVKJSnZFFWJSwOngsUsFxflHZCgjr5z
	o3EysGC3uGC6+T2b3HY1q0TwQDXBbTcKDTBvRhn+2KhAZPhv8PDOGkXVB1JIdRVKGpH766XkXI1
	U6miY8bpQg/R4GrcIi135LaDVcaewn/ZCkC3k4Jfqt4Bh8SCrlP1iT7mWQg+/ZQ7p/vuSPxHBUa
	iFLix52lsqJ3glf0MFEkzQehXqdsF7Jo+5u4C9qK2U1Gaktt4thoSaDlYarUYO1iPMS99aFYaaU
	B9y8ghT+cZDsaS/6xja2rcrjSePgaMTxr3wbbJcnHqGOfp84yp23hTJVKa1k+EajvkWx1537NCT
	9esiEJ+b37mVPlOdUxxlpGBV1uQH6yzO7e2HaGqrBrcdhXafHv/l7eI9ZtWB+3z8I6gv1tFkSKk
	dB9RZ3uPoU2Q0UHBepCthBdSleiXAZZ3EboXT0irdiy+MUaB/49qi5xjWSUDcjHs28XscYzanIl
	7N8guTM7TCKAW7FaOX01gmlCu9D98lIHpxGg6gBQdivHXIJ9LhM1VBJ6EuvQ3CTHBFwp/uLe/w9
	JsSiCBSRiMX0yaPV80x5/XirYr/XnujjQyG6eQCSPyqs1JO5QJgDUMga0
X-Received: by 2002:a05:600c:512:b0:4a2:a9:ed87 with SMTP id 5b1f17b1804b1-4bb55a5aa47mr209766355e9.19.1794904086313;
        Tue, 17 Nov 2026 00:28:06 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78418853sm74782845e9.8.2026.11.17.00.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:28:05 -0800 (PST)
Message-ID: <fa0ce0f7ecdbe91cc6773bcbe86be137d2129944.camel@amutable.com>
Subject: Re: [PATCH RFC v3 21/44] nfsd: use fc_init_pseudo()
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
 linux-kselftest@vger.kernel.org, Chuck Lever	 <cel@kernel.org>, Chris Down
 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:28:04 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-21-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-21-8cbbea1cf34f@kernel.org>
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
> Initialize the nfsd filesystem as a pseudo filesystem. This raises
> SB_I_PSEUDO and also SB_I_NOEXEC and SB_I_NODEV. It never holds
> executables or device nodes.
>=20
> Acked-by: Chuck Lever <cel@kernel.org>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/nfsd/nfsctl.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index f32311f2d7cf9..ce2666deddbd9 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -9,6 +9,7 @@
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/ctype.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0
> =C2=A0#include <linux/sunrpc/cache.h>
> =C2=A0#include <linux/sunrpc/svcsock.h>
> @@ -1375,6 +1376,7 @@ static int nfsd_init_fs_context(struct
> fs_context *fc)
> =C2=A0{
> =C2=A0	put_user_ns(fc->user_ns);
> =C2=A0	fc->user_ns =3D get_user_ns(fc->net_ns->user_ns);
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &nfsd_fs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
