Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565074;
	b=N7p2LDRdMUN4Q7AcPIaycbkGnjJ2SusxLR3BEwiIT3osanN/g2voH89zowoLYlIQvqyU
	 hLbPr2aJakGOV2yWe+QR9PhOR/claKpyQq5xnCO/MDkKYT4FeeDMscljDSyekjaV2Mxbk
	 HNHy+7uvUZSWFr7bFFgC1ycP5vH2Aam54UOH4p20l3OHT6yvc2e7masQqQvHf8RSflzIE
	 SOs3fINyjgM1eHcHNRLKdwo98zAyWXtl31JZbssrxM/pJpvlga6IMrQgRullc6H1VHUqq
	 84iR8ZDZxkBCFjCORlbEkcxsWMlhncUWWMnOxMs2sSNGPZ9JxcjAEx7AGpoIysHT30Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=;
	b=P6UopXj+wx6obBlthB1rNAh7JizrNSqFXoVqZPCe86ln0nwQUb/SDxSYP7BqZVKhmEAd
	 fz6Z1zPKCyA5SsW+o9sNKdAGiIJZWZeg7aFjpKJ7w1FgzHLLXk8WKslwHXeCRVX6RBrnp
	 Y+i5vAlQ0RZ77PC9nUEPoEZCt8IC8y/ElJEVMPrXNggEdYXKWHx+Oc5bQI5kFo3g1uWFm
	 J3i9/TF76iv8dIConNAx5jB4R9fAC8JZZLs9b6pfOB3A9sX679Lr2+IHV0xNHSFCFRR01
	 vXRx3uBDqBVOh6v5+ZbYvwnbg7vEHRZ0O+Uqde0k8mxw5Jzh66uDDXzPoTkaz2eztjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hEEG7fG6;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668CB606A882
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 10:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 668CB606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hEEG7fG6
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso10283275e9.3
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 02:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565072; x=1795169872; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=;
        b=hEEG7fG6RzQkOoGSL66zkn+hWpy0b8TxpW+CxGFBwGxbhLfdgmFqwESmbjaY7MScGa
         1TTEC4ZDzMo/nTmQbATUq4OC5CVK8FiegRjrCOceUr+V68t+3IyOPEhrmauT/typpuMH
         7BtZ7bLX9twnpc3pST7EzNdPnkg3BFhqHXhYG5RTwPNXEKUOMAEYxir+CLBCGEbp4xnq
         ot2tG8XA7sYEn5cZCga4RcL6w3I4tCQX2A1rGgTmCQohN7lvb4NCOhavzOt0i7fRXz7K
         0fiOYrUI/s1Mo3f+qCL5v2ciULr5WU1WUhy3OFmgCMCM2mU4bZM+JgAT1J65gELN03wt
         2Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565072; x=1795169872;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=;
        b=223m4nd8HHkACxzDHMa75g4C4Q1qm0yqFKhKK4OUUQeI5JQD7c+3Zf963BlTzcTHUm
         xGhIUPPTHkcS4m7Ujofgp5XnefJN2wuLSoEfDDjzZFKiuRPJxAMmPYs1wyMo4Z1jbgFx
         LpVj67MteqjMPxB/LALVWwO3sqvb/AP0W8TWRrcT6IWCtlPzHkJINvrcittX5+5VzVjV
         EqAYitcfvD5ksO55pt/6CQeIx4WU+MFguduWohgDMJmdSyemx7b/N+V3pQUJ3jex2XPR
         HRyxQY6bErUycrqTNzMEF2OO6BeukIRgtwabN0SjORTsyb9i0yoxVLyACJwt13paXDr6
         Xcfw==
X-Forwarded-Encrypted: i=1; AL+hErEtWWs6/5Jh7H9iwggQywiiu0FOAvizOE72+TWkTQXYkA3rcW+0F/3072afmmm3ia3FCqnElVQJTbrTWw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8yGHGGgFdjayXKYC17mBwn/lyy4Q4GWmMry1em3b0pms1hLotE
	WPMJSH7m8/Dt937IVvw6jjh27C5beZUAHu8waxUY1ji5nAelMZ1a5JevEXmOrxLQMyHH
X-Gm-Gg: AYBFou3NRDGwjtLlR+eD4B67+5QRVykn8Yd7EHrfxvXomgXKwFCIrMvkfbGeV5lTdWI
	ecIF0gDBz5Ndeh9C+aZqs5nFBA0H5uGEaPmNaFVT8wIgi+j4fspHF00QuWPEYJs2GPgu92NOr5c
	eVenI1TEUeO37FeY55XnhVcIVjlQDH6zkP8jZ3WDZHhpuBBLneZfAsPpZPAzhl/Vf19DjEHhDaL
	M/NQlNLv7nCLayqhbGxQ+y1hfINQxD5R2mEWA4kzsOuArDX+CpvMWM7bG5cuJSBto6cP35tOQfg
	cK2L1QHddReudckEHobUHA0qADwZuJh+EqxKOJehMmC2S9sIFC0Q9Y2KQA16XJZLwED06PpUHj4
	Fxo8baqYmZETz1FxFxpWZ3meymGHYcfaCXM6tj7Q6wAB9NOjN0/icD6HUwhEyq46DiW79ZQe+Lc
	uI7FE5uh7JVECN98v/sl7bBTYgwPGryW8e3Da1QXfh4lkO1uh6arS1Yd8DnpV55gvE++Tv79Pqo
	IN5wtSmnTUCcP3tTy3ToosqEeTb8jre46w2+xBG213/BvU5x5E1Z05GUbb6UxF31GUHzPxmESkx
	PBB2CtYRLZntPTKJv6SQFx3JLefv0ThdLWMc4B1t3EbOO597tRYvqu03OzlUSiY=
X-Received: by 2002:a05:600c:45d4:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4bb559f6f31mr43851425e9.2.1794565071804;
        Fri, 13 Nov 2026 02:17:51 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c7da37b19sm3937770f8f.5.2026.11.13.02.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:17:51 -0800 (PST)
Message-ID: <7cde6f3091f9d90593e4a6441723b6b889cc4024.camel@amutable.com>
Subject: Re: [PATCH RFC 35/41] zloop: refuse zone files on pseudo filesystems
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
Date: Fri, 13 Nov 2026 11:17:48 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-35-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-35-4c998976c6c7@kernel.org>
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
> zloop opens its zone files by name below the base directory but a
> bind
> mount can put any file there, including a procfs or sysfs file.
> Refuse
> files on pseudo filesystems as zone files just like loop does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/block/zloop.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
> index 65634a39b0bf..dcc06dd47b04 100644
> --- a/drivers/block/zloop.c
> +++ b/drivers/block/zloop.c
> @@ -1137,6 +1137,11 @@ static int zloop_init_zone(struct zloop_device
> *zlo, struct zloop_options *opts,
> =C2=A0		goto out_fput;
> =C2=A0	}
> =C2=A0
> +	if (file_is_pseudo(zone->file)) {
> +		ret =3D -EINVAL;
> +		goto out_fput;
> +	}
> +
> =C2=A0	if (zlo->block_size) {
> =C2=A0		ret =3D zloop_get_block_size(zlo, zone);
> =C2=A0		if (ret)
