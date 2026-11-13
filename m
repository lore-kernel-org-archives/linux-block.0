Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564657;
	b=FQx1V9zK715WVJsSgRwB89b8lSZgzmoaL52VD0ogbf+qSke2kTXFk0NJyP8bZ6Fq//e1
	 mesVIYUkG+Sml++vGGNLEhhQJHYggE5K5Hl9sNh7zdwEpw549MojKkposFTyaWHQhYsn2
	 KYwmE4ULzY1p1zw/Gp6LyBC9CYUd+YqBDnHyHtupJJwisHWCuxueJbo2Ruo2ZUzIqtHFM
	 goT7jurhjpYQ90UdOWPI80+IjJBwaNHGfUZKbFT1YhbhujWvBjuWdU+EB/LMtm1Bt2EkJ
	 hsGuKMRuJ9bn8PvPtPHyAbekkGqWvp8WPMwGjeUxFcxPvjuISjRZ1a6OheyOnH1SJFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=;
	b=5CoFutI4oRbwGR7T15drNLof41XWU7ddrMmhvyXDfgfqqv1IRQBk4F0UeRXYuTHZVvpO
	 MoloM37itWi6vDX+KjAgCkh1/JQwbotxX/UUl3P16K0rAOXRsAEi3lpjdj7bcDotpy46d
	 Biy/ZMJtZSgqeQNcSEddIZkTh39n1/FVCuzz8H0M+9pWFA18cye9clXnbn+ur7qGCY4an
	 MJ88CHDYmIknmWmIM5TwZHfgJXxUzL/wHgHN70CRHkoMUAoJydfwHkEK+uhPF4jQP4UNS
	 njfQO2BRFlhYZsb0F7v4vVmApW419NvmuNmSvz5LUEM+upNR0TlHJyivcBYkXic00UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=afSYRRYW;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C382606A33F
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 10:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C382606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=afSYRRYW
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-490f38e9688so497685f8f.0
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 02:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564655; x=1795169455; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=;
        b=afSYRRYW0Lzg1RjNF5a8Z8fp4FTD8+wBAkqEEgX+uXVLN6iB/1Oe+S3s3pjBsHkfPy
         t+OYs+BeBV0n1jEyBb10NVx3dBSZolIBqoZV0sAqk1NmAyPkc8BtADcPrCcEDzdTW4+p
         zgkm0FzjpTOQt7I53MJB0zmRNwJ5JPK+9oiFhFL/qPiFq6x22bgZ8fSq9Se2ho9ikF+q
         rg0gx4TedCmdQu2h6zCkoXcFHWmQ+ZQsRVeKTv2sVCXhncyHGZ2k8DCVvoh7926dtvhd
         5w+l12l3Dd1UCqA4z70s6tomNhqNtGqcJuf3lRDB60cxVt/wNhZpOgzeegjchzcaCyfn
         tojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564655; x=1795169455;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=;
        b=jQbgBPbV4BXlwBO+q3zTLCF9ez5iycv7rsNAZ6g9RW2Ko1QgeyqC70sciL9aUHj7Og
         AhnsENbJE8e8cUYD5ngZM0SW/XamN+5ZaCBV6wLwWeaIyemg09D1ASck5VJvZ9nCu6jx
         mBhqwurCxycFrPzZSc6wOkLFTLecn6EYFQ1UoXhkPC2CybWlD0RXZkk1zF1uBdZh7tam
         VAoP4og46enb1QykU2VUUfTtYCj9l+ZIrxTg9Uy/3mVWq/RZhZhTX7IfKKvtt2O7c27+
         PFUGN2R64otXAASQWpfDd0up7pIRMqbh14vLSw1NyN1o9p+75Jn1ktIJ7OvnNi3QoNio
         krvQ==
X-Forwarded-Encrypted: i=1; AL+hErGOw5SQrbH7AH4LYDUjz68FQMJF4ow0bqusWyg4ZxpdkZgPK83kJMEC1pt06gQdocME14enja9uJlAy5g==@vger.kernel.org
X-Gm-Message-State: APuU4Z8fcqKie+2LMTgTPXW/pTLYbIJpkUAAwrat5bznTnEfFbdxSz1T
	bM0fOM9xbDzL2NnJQC8dnQOhTCGelsLI78QRn+4wkG9wgq/M1fOqWJbqoP12Oc226o7q
X-Gm-Gg: AYBFou1RDPHMrNEpKFI8gbrxYoS8o++sLCQaiLzdxwEjcHEZF5SXoUg+7pJCYeyMdLY
	uwGR/jzcsf+MsRKG0w2vhQOXFRwQSxSQDvtXXtBMk+tA0DOiZy46ZQLkOsBQ/AC7ITIQ9wiITnQ
	IdtI8+Jk6OzD0noFLi5dZdEFdNpsW4Pq/NY//QsYYpdkRHsYChuiKN1d1Xs3Odt1Y3ddTNB0Goq
	VHziuj8F+2f16FtIe7/IPN5pLsw/42SaF4UDeh0s6Hwh3k0nI1yxv8HExDVvVFH4DX3yxANFMh6
	ANUHlf1S8T7PIvQZZTwjd0TxE5GjAgHfQ9b2x+rgO1hk7bRk7SgF96M12HdrmWwT0JpnaAv1+dN
	HYtRKlcgVbxEG9UQeevAMzqWd6Gb/J2hAcYdj0e5J0AHGIy6qg2RaSH16HElYnBs2Y/ltH9kOk6
	v3cUWswheVsRE0x5rMF/3PtVoSbDbjsbLPWlYVS0AfT+JAHxr8/im+NrJkIPvxiHHG9EgGapQmg
	xj8i1ilf6f83icrrwPEr7e5Wrk0GNSLQrgoloYuZuHoLXcFsy1elsMvZMJDTXkEk80EHbgmwJqG
	t9wmiKexhrwN2uvMNuEa2F4xxf0AyG/jyJ5B0j9KvgT7SnSI2iMFiBZ5cBijJTo=
X-Received: by 2002:a05:6000:470e:b0:499:ffd4:f519 with SMTP id ffacd0b85a97d-49b02d4c2cfmr11662822f8f.23.1794564655454;
        Fri, 13 Nov 2026 02:10:55 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5a32d336sm4988050f8f.0.2026.11.13.02.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:10:55 -0800 (PST)
Message-ID: <0894c601b3f3c5b92008c6c399faaa539b658307.camel@amutable.com>
Subject: Re: [PATCH RFC 17/41] securityfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:10:52 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-17-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-17-4c998976c6c7@kernel.org>
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
> Initialize securityfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. securityfs never holds executables
> or
> device nodes.
>=20
> AppArmor puts a .null device node into securityfs but only ever opens
> it via dentry_open() which doesn't care about SB_I_NODEV.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/inode.c b/security/inode.c
> index 080402367674..93997a9f16fc 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -14,6 +14,7 @@
> =C2=A0#include <linux/kobject.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/init.h>
> @@ -64,6 +65,7 @@ static const struct fs_context_operations
> securityfs_context_ops =3D {
> =C2=A0
> =C2=A0static int securityfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &securityfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
