Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573510;
	b=uT/HpPLv85KJCMIhOmgjWB1iUY4t5qtxbAKeMWkUHOv1scIqOous/8ClDQv9H6zrMije
	 1U9f6IniadmB8MhKOEnivEZnvVvirreND7IS0/+lceHhGynzEm6J5Gl2Z552921Nclnoi
	 /qMeugA5dBRzPpBTX3EU+aTB3U1vC8SBG49FckqYsblzWb5ji4vjANNDj5vaLSt/u54jJ
	 ChJwQjEQOy/PM3E2OcYGFpYJS0VntICJMRu56X/DqZ8AAUkIZ5eVZvf3xfc1wW0T6qJQb
	 PBCBaXJu7YaLaSD02b0CeYUbmYKMwW4MrMhdmhm0j9G3PzTscmJ2XOOaBVX3GhyuSsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
	b=QETSqhvja7VluSABJDDggUa+JdNMEJOyiPHNlgPTEMoy8qipr+MM+McOgxUGGm5/Nuak
	 Yk0bKm+UQI4HQ1n+UxSG7eMNpxPuG9l6BkvBa/Okz1b7ryu0x1+zppP37jtZXEfLEBATv
	 ZCHmuYdR9YCM5IS7AasduAcj+EWz1LqvExGFwZuR32XhcZQRRkUh95+xOZun9meIFKzCc
	 sWaD10IGuZlT9FeOkOPDVYU5vGpQhyQO0hDtR2I6pN3zpEoeO3d1EK4nAX7OISZCcuxeN
	 vOrEgQY0bRoNNxdsGZXulmJtS4t7/QtySI05cEpzhI2gXEdO5esjq7zB7QzOpgSQscA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bz2+TnPI;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A99606A32D
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 12:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2A99606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bz2+TnPI
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so9108305e9.1
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 04:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794573508; x=1795178308; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
        b=Bz2+TnPIApHKvsf08kyiSuJZ5AWViHONwTwuNXVAuo2u8JGXjKnEoxSd3hG/r/h3b1
         tdsUEBtaZSOWfU3+mD3LjyqvBKt9Vc6RBsvkZZTD05u5eCDGhnWto1Wbu/C0r64DVVdd
         h2TGnt6meedDH7Iwjf2Hw2JxWOY8jwAvEAcAC10FURsf5jjp4p/KJzFYjzuPwuYFNKea
         Iij0h8HoPs5opXKf2XwMBJpd5hsYSV0+BHP/DvKdCCgwNFtbeIFAwqDf2ag0NBOCbqs2
         OXWiZmXbdGCixyOlqQBMgrkFkrhg1VmbSdmvvBdeQ4Vz+QMvhYl+k9AO6FJ5UW1pg6b2
         DVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794573508; x=1795178308;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
        b=um28TWeptRbqDCf5i7tud0sZJ9+2GcycyDSzQSpbehG2WrKR6z/LZNpUXTz2WLO5PP
         gwU3MJj9sa/yPm6rIXVpWdxH8jtyhkUKI4Qb9mZihTTFQBg1DGxluoFLsIebnfFzCa0D
         90xx8GTugHxMjrBGvyihz+ubDXIRg/ogy9uywINh2j6lgW2D4eLqpIgEX5MQFXVfnK4G
         l/kVXeixQUTLOm7roiYfEvRXCVkU6IWcFnramdTwmUnpGvyVA/5cI3PGnol/pNjv/Wkl
         dZqgiIzHun6z0SLJ3m5yfK9e8AQ3GYWcKHF4h7B7RL/Q2Slor0RZZ6H/BPSoBvj4ZHF6
         tN2A==
X-Forwarded-Encrypted: i=1; AL+hErFJZXVaFXWoAfQRe9I6TzWiGxz/bK+ycm1vsqdL1g5uvhwKt6MxMPi2HLg4JQi2M9a/JSyrb4o54yuong==@vger.kernel.org
X-Gm-Message-State: APuU4Z+NS0WEEwjO2PmwORte0bWyjcXPc798pAczBpSNJbU79d8DzY9E
	OQ/1D4YZjFjGzH5k+a8/NTiDxmaOAoxeu7W94q8TjxSltrcLEZ++CVQl4gtMq7vpWAzV
X-Gm-Gg: AYBFou2DolBWEKJlje6T9MCNQ/d/mzPQVk308zZ0LU49lQjamvQCjV74e+lzH3npZuN
	2kaeQAjcWrPPZ5SqaDn9maNN+l8K8oJ5htg5x1GwxYd2VII3dJYgwNx9v97kyK0kn5Pvb/1VUQp
	6JzUcc4Qzpajv55MJ3kpCd1E3+kAGLheF0ynmNLKIpyErBUem6lKPHfbIvixFBlxtBe8infbhUG
	UOUFwB1suXYP3eJnu2sBN/4P5ZIwtMulKXVbn8Pbshc/7yS1LVlmWGM9abqog3rsSTGBC5I7BT0
	lZMvUjDkNWQ1O8KV3f/TTwddjzNjl2QeL0A+18Pm93gV4d0c6mDNZVvZ5vq4tQPNhou/UZVCTW8
	Duj0ZxxLckv/tgnIeiBadj3wgWYlTSKDqjxw8SwcC4aDctSn7aW2uWcX8HTqHr6CeL33fdVaTQY
	2HuH9kS7dT+4eBUTcsRiTewgoGlBG4Aca7k7XA88PtzIB7+RmW11j2ZkjQZFzC9/mjQmJmK8iAs
	XHwzZoQGzO1ZCGnt6nPCVspZ4pmdV4pVjO6n6tQxho4xwcfpjTopdqXwR2eRlKYvi2q9j0kXZR4
	/r2/S8Yzu6wr+RV9JMWqeNPdp2FPCQOG4kxAtl3jMfh18dRpdrtSL9h04/Atd9s=
X-Received: by 2002:a05:600c:a596:b0:4b5:d95c:2380 with SMTP id 5b1f17b1804b1-4bb55a86fb2mr24790785e9.11.1794573508217;
        Fri, 13 Nov 2026 04:38:28 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571cfa2esm48348475e9.2.2026.11.13.04.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:38:27 -0800 (PST)
Message-ID: <28a33fa649dcaae2eadcc934ec49fa591ec1c283.camel@amutable.com>
Subject: Re: [PATCH RFC 20/41] apparmor: use fc_init_pseudo() for apparmorfs
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
Date: Fri, 13 Nov 2026 13:38:25 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-20-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-20-4c998976c6c7@kernel.org>
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
> Initialize apparmorfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. apparmorfs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/apparmor/apparmorfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/apparmor/apparmorfs.c
> b/security/apparmor/apparmorfs.c
> index a99366467217..351ea3a7120e 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/rcupdate.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/poll.h>
> =C2=A0#include <linux/zstd.h>
> =C2=A0#include <linux/string.h>
> @@ -263,6 +264,7 @@ static const struct fs_context_operations
> apparmorfs_context_ops =3D {
> =C2=A0
> =C2=A0static int apparmorfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &apparmorfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
