Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904513;
	b=DBL/wlCvmq/T6xFOFoamfYoeoZoDFeXjE+h4ev1LmcYXiDcZqpR6r2ExcOOjCcUuWzfn
	 aiADRab2M9OxEyQXwjbi/E8mLrWKi3kM/DmsHIYiMQxgDDDxIr0+xxmf46Zj5qbW1WJvF
	 xa7atYbJdB/5iy8zl72S/X9Qe2Mw90mR6tV72QHR+UjkYdr0RzFooOQ9WZKR14DH5mLQ6
	 Gc6DHDJTk6XNgPH9dZDwSSlBImMwPBIBZpu8oir+TSxpgF4H8q4qzi1NQmnHOWkIVqNAa
	 zuA1i2C/EoPyVkjFmaydQ4iNnOlK5blDvsCC6Z66qFLkoWTwhUDcI4bVvxkwpw+efbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=;
	b=2VTX/EBw95ClUcILrIrn2poR6GJqcZkn/C6o1uRukUGEpWgGtI5YdzjDVRLcCfcCOeD1
	 QwkPw7ZPIJ7FQ/+ugGC9Ix7VwrA57p26qwMySNaVejNYyX5e/p7vv+xRqyaRV0re48UWF
	 tTxrE/K/S70Ly1syASnMEsHKPMCbOXEQAezHDsciPFuoptk+5U/k0IiFX1T1Vt9aqc6dj
	 hVM5Vxx4ycc1lvwauon3fYZyVdLK7lInseIv+brTaUQuTQJ478jSarNfofOp2NwL4veHP
	 gzjnAL/VC87EsJFLsEqUM32PfLrvWA05utEW8nIYKqAhctNXmCIq6ApxQyB03WNu4ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=asHWLUHh;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92404606A89B
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 08:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92404606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=asHWLUHh
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4919a880834so2252942f8f.0
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 00:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904510; x=1795509310; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=;
        b=asHWLUHh9Osx9c7ISjHVvBK+jrwM+bEKiKQ5ZLUG8jHeL8cbDrdmay7aq+azwtlrvN
         q7YkHw224WJQO7TnM1AyMygFYXrlY29jKpq3C9XROr0oTqsA+UK4p+WS5GMy+xx9DTRb
         nuDA+OEO8+ykjkDq/RDjAwEfWgenycj+snq2KkG6mulygb6NKchr6plM71+t8W0/+aGL
         LigMC+giRqQ92TsunABClmE52NWQSdRqhQeez7lH76lemvGh63Ic8nud3Qte/9KpQmbQ
         YrdviXjfG5hlS64KIE7Iq0kMRVYmtZMNK2hkMRb6Cz1tihRk5N+J71aJKPK+K5E0SOED
         KbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904510; x=1795509310;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=;
        b=Y97i9g1K9F6GiD1ZBHFlx55hhg7CvwYy5Tj4l5W7OlYdMOLhxwap7wIj66RZySlOVN
         34ioWbNZ8Is9r2FjzS/gCHWE4X7Xo1xN9G9FnfYfW0N/Xd54PwaWCrjD+XBBherE6wSv
         lzQfzS6RuxzNT5HynnFK+BSSsuMjOtv2a3Mb7Ryk1oGGiwE/vHmMiqMjMZYuUT/OFbiG
         WSAmwvfygEfS63b4DIPKTjv+icOm7+KZmehpIlsYp3b3Fv3RnjCDMQuzEoIIFxeuw7JS
         osu0/bglSTmI4FIggsoRhlC4qAf8/ev2PCrzm2vKLZlmAOuA9uqIHbN+E2dj07Q69zUC
         91mA==
X-Forwarded-Encrypted: i=1; AL+hErEXPeKnkr9zTGeh7vhhPd/GyTGnjz8sUXHsmRZDeYSOvr68k5pUZUiUUXuIQTsh82V2Rul2vFFX5A5NUA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/e+2WRgb+C86KGm6d/Xj8BTPc1PAIRvRSmAuYc0MyvNC+C7PYG
	wXztPpflSlTk43l2iQFwUYf4K5TCg8/hbvBwTg5z1dIELqH4EHxOjAv1iq6zQRG9/jQ1
X-Gm-Gg: AZFdTZddsyIcmZoi14qcSeIie1OsWIiDHYzHBB6kwbUfern3GOWUT0pYqEXnJK0W/62
	VUsYm0wP92SDIIJMj6P7H/xjwct2hKFUZ69Iy4zqbZ5Ap4sH0zNQnvNmVkL6G0TJvQQAXGi48pl
	frxYhRfLIDWtSSDdg+82Ea9BxGca/DaPs+w+Ouiq9plPIEZu46vWHWWgk4ntirB5PrYp3zBl7yM
	6msDKMqCVJChp8d9NiUJopt+VhmjH/fvGBo95n+gZ2pf8PDvDzX2If2LNDKlq4hxkkaFwhjaJ2A
	5BjxCrFZnvZGoMoadD0IdxGZ6nfRNoJvrVnbThKn75TEkAo9BhAvHjieABS7M5AN0k9mXVowjuu
	F6y7+GcrstU2drtytFplkoic0pCT/lvwIgvDw8rwf61pTr66tGAgGq1qyhy3vKwPvGWDEr3fA2O
	44Ye5CZvN3NR8253LrzKJmT/aZI+OLLFHqi2mmuaR7XZr8ohG9v7c2aLLU+TdvOEcJ6INqhqJG2
	V5/SupBA22UIS8oUaq+kxkVz5sZBgQhciDaydZT6cNuV0igFw7IXWOWsoUeOr9dvZMgkHCi24Go
	qQfMTXnf8oFD5+BO4qSaH66uggin+GNxBbZ/D1msBDsuV9v0nU4nVhV1YY0sG7MxG0rAPXBT2fR
	sk4wyV3sZWK4bdh4ED1enwz40cWfq81L06xI9X9Bttk/BqMs7NIb1ZnlJ
X-Received: by 2002:adf:e193:0:b0:48c:7306:18e9 with SMTP id ffacd0b85a97d-49c728c6e6amr26569239f8f.43.1794904509932;
        Tue, 17 Nov 2026 00:35:09 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4e2esm26338505f8f.36.2026.11.17.00.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:35:09 -0800 (PST)
Message-ID: <b0ec2cd8f9b7a6a2e4a54c6df2fa897bce068cbd.camel@amutable.com>
Subject: Re: [PATCH RFC v3 28/44] ocfs2: use fc_init_pseudo() for dlmfs
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
 linux-kselftest@vger.kernel.org, Chris Down	 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:35:07 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-28-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-28-8cbbea1cf34f@kernel.org>
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
> Initialize dlmfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. dlmfs never holds executables or
> device nodes.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/ocfs2/dlmfs/dlmfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> index d3bfcada3e3bf..1789ec96dc130 100644
> --- a/fs/ocfs2/dlmfs/dlmfs.c
> +++ b/fs/ocfs2/dlmfs/dlmfs.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/types.h>
> =C2=A0#include <linux/slab.h>
> @@ -563,6 +564,7 @@ static const struct fs_context_operations
> dlmfs_context_ops =3D {
> =C2=A0
> =C2=A0static int dlmfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &dlmfs_context_ops;
> =C2=A0
> =C2=A0	return 0;
