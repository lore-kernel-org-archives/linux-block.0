Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904006;
	b=teWM9Gbd8+zy8E8/KhTFOVtz2ejzfsNL4rnHyqd9bxcozI3xk7I/616tNfHHiwphE/gn
	 QXskGyCYck3hGnLqHGloceVGrQ8wCKBhzDy/NLmp02OdqV2MEBksfZe9P10UvIQ7JpjI9
	 4h8bKLbP+3+qo2zPlFmgTMRlpYPUbyqeVwI/Z7IkBiskddupWVoh78hVW8vDOOc+B8PMs
	 qdzoP5uaiYfDvD/dsg0DeuEymLzzvdquOY8iHc7yJkCT1k4Q2InTObvGst9fv2WhXTyRK
	 86000wnBzAZ7j6jAMoQn9JwALPol9VcuJqmvRkzCNl7uaOaGa3AGPW5EZ14+fwLuN/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=;
	b=h5bbps7mZUYg/5h1rS5wzVQD74QhOvGwkYxbTSaw5Mu7RmkxoBar5RqaXvHFup0G3QI1
	 l91oQrAR4I1uZuT03nCwvi7vd0Ad3YbZ8O/Qm81dze+vM+77LnfUF0fcUKXAUzyQzrhfO
	 PveztBrJq9SPwc3g0XWlQXo03hAloc8FojLxEzRIbGbSutMbM0O+oyqQpVs+f2IbRDtDl
	 LH4ACQ0Dg0a+M/MEW0L9JcDajjAI9fQWb9TtT1gtA+ZsfDduuwQKCxJaeLQOgoT8UVRvf
	 lLO9JHbsWnH82ypRjoqJ4SRV2KYDqxRsGDRJRSawRgVBY56tCezkmS+AK0UK09sUFeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bh3COd7Z;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47604606A33A
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 08:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47604606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bh3COd7Z
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4a358881793so374288f8f.0
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 00:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904004; x=1795508804; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=;
        b=Bh3COd7ZzI6TmZdb32Fg462zWvuh7WQNnrUpXucHXcpV5t+t8gMfKKxOWwhkcHBcNt
         zIJKpUT9Ten8K9xmb0ZHj3p/ljeyNVefWtOpjWCo7Igmb/P1wzmYs63YOxLg7f+WXmDC
         wf3ao9cg3f1DrvZE/oBKoQiWFPBKSPnWk+jCT2CGoQgxeoDuJREjXd8oRMM0GizRyDLq
         q7c8W4Fdq61I08pJrjWNPm+S1jXNjmZ2MpEutx4SYZ/JoE6iRzvUZ/uRuGO7TyWDBzw1
         OlncqX8aSwrA8zDhY0Cn+N6eWM3qFfFk2ULf9A0Yk8lhKFDJjJXQbcxKbI+h6RZ2p0E1
         0Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904004; x=1795508804;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=;
        b=lQLx7bumrzPqyfwjczZjSxFW70p+xed+XUADVxOo/naVw3bzGmcQbBQ3ypafpfAe+a
         okE6QuXQqO+GP+9RUsq8APoejHMnH4S3vx0Bw7Yb62R+J9kCvkKhSi9PUpB2XjPbASfa
         QOL0LXl4tDMrA+lYBVvl+2iBRr6pSeAQYm3w4F4pEhSNBy1EBLijLkT1wGicRHCfi+Uv
         oSpfas5wuC+4lQbLWLjIhfuKtDwNAy7hCi4O82VRCf1+Qa961qBeqzumQVTSmw3/dOMr
         rnlw8A33NIodqX6uoCU0CYI+kM/1pLZOUzB8GkrOmfKngfcdmjgRiAwoUW7OGO5vKIwu
         vsgQ==
X-Forwarded-Encrypted: i=1; AL+hErEMi3AWOHKF+uFcstXEK7S3Xop30WltCpa07eFSnYM7+8pMNgYyrBy7RqtfaNLTfc/QpjdpYZYqYMcCUQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/HvuxMYCd4vk2sxccGe383QtL0QOkdaF/1Z7eTOzPTsxAbLj/q
	8cpC4skqLB/VyJqo9uAg1meREUmyl1lCXEEzJhzK7enB5ibpHiV2qJ9uNHgMtcumOmB0
X-Gm-Gg: AZFdTZftJQKYdjaY0LjIHaIloPEq2OGp/U5d0bzVwhyUMQAItq3BdMcvoSYfrs5eKs/
	I+pUCQ+n/juWfb9V5F2sV8INhvOEdXWYVCmSmO164Yz4VGBQWfNfvoAScmKpFZNWhmZ8fT+sELP
	7UlublfKZJTPRBZ5mZowLcJgCFKhLU4YMQ6DN4l6ZdHthDm1lT7E3gUTGEzl2ja5MOg9sgDnUC1
	4WN5CKfLm9Nec0RwM/9XOIy7NXnk+2pkdegs3QnOdn5c8mhiF7B8EG6bKdwI8f946ONQ7+Kppvn
	uoK/lktRjR9/Hr6SRa3T8/JGNhLCfqKDOw2eSKNWL50E/OJ9N4Sii5FIAuNCFU7OJG7G49sSxfe
	I7sApI3XhmxVQZ1LIBeyaou3wZIicbNsytzfYPm90h64H2kvJ59yct4QqArlcmfAwBL2fkOsF8t
	n3kqLbxUZwtrZQJAKqCU+R0yJfaBSoD8dOVYYoPIBmOzm4qSCN7jHbDLeYrtC8dIBAauEkRg+AY
	VYISlrj12yQtC/T5IbaDv2ltoSbOWyOI/C5byNhDTbElGSBhfYU1QJMXeC4TUiqowphBc+6mBfo
	ezlurfLI4D//HHW54wEQIiWFJZezGqY53+dnC/OYl6YHkIcEW3Y3vzU9ciKOWGjU4rZ5GB5qFHI
	lv91OHyMqtkTC9RWCZwp4JE1iGojHTf4sVBAyO9XF7nh4/xMGVaIv2Zp8
X-Received: by 2002:a05:6000:2009:b0:4a5:2e5b:51c2 with SMTP id ffacd0b85a97d-4a52e6a947bmr243585f8f.29.1794904004601;
        Tue, 17 Nov 2026 00:26:44 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a4de4cb1c3sm977858f8f.8.2026.11.17.00.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:26:44 -0800 (PST)
Message-ID: <c43d70badf41f62f8e149ac024bab3df979fa756.camel@amutable.com>
Subject: Re: [PATCH RFC v3 11/44] failfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:26:42 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-11-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-11-8cbbea1cf34f@kernel.org>
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
> Initialize failfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/failfs.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/failfs.c b/fs/failfs.c
> index 437cdc981c2de..f03334f361c0e 100644
> --- a/fs/failfs.c
> +++ b/fs/failfs.c
> @@ -3,6 +3,7 @@
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs/super_types.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_struct.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/mount.h>
> @@ -132,7 +133,7 @@ static int failfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	fc->ops		=3D &failfs_context_ops;
> =C2=A0	fc->global	=3D true;
> =C2=A0	fc->sb_flags	|=3D SB_NOUSER;
> -	fc->s_iflags	|=3D SB_I_NOEXEC | SB_I_NODEV;
> +	fc_init_pseudo(fc);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
