Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904346;
	b=QdDcGiHkSKd86lF51nuy7clcuORjyw43fsc5MveXIA7zbzt460ryxUMBv1+gew/1ELh1
	 Kwugw7W4o3TxjoMNpurT/xloTYmTeuuFmfoBqNZ7gY2fNRh8IvFqoSo3hFdrVguBOQDnV
	 6CDYPKinDPh16Qn47UEt7JMQAxUpzztHU44JfzNPV8PcQjUVoPLWTpl3snlztWsodbEaB
	 6ehqH0t8hiDqJL2Og//t78QqhgOYkTtVZ/bW5+Wsxi7Umxif+uQksOP03DQHpLw+j69Z0
	 vI4r4BX56/zHngY+5yks0bppYG1fHdRPZdDQP3WbU/vQh1m3Rh9+3RSRRjTmrgruxSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
	b=LS+i4Qh/rCwsIKddWxx7/oTZ3rARSEd3tftECPuUFDLB0peXnnuq7Bux62LAt0Hey7Ib
	 SfQa77TtAjSzMqioib3JTjAyvoHq1le7dxjoceTyQx8EVhmRjdaMnXaRJ9Aqh/5M+2jwW
	 y/U+LzGyX/mrxG1INvWOtjSLMrUiArXQR6lukVJMl7K/toz2laeYMttSZdtkiTXp9lM06
	 wRUaSbV3BPGEcshCRY2HYH1vNxBjYuaHwt496SpOC6EOPgNPGEZneYGM2iwB0rMEd6zHp
	 qcgzw1pgC+rDG05yDqjZ3VDAeMX5LV6hT1lgPCLOfnkbZjkm02ySfrZ05DU2k0dU73Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EFPX8Vuf;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0921606A896
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 08:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0921606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EFPX8Vuf
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-49412eb1474so2235570f8f.3
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 00:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904343; x=1795509143; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
        b=EFPX8Vuf7iz+NzEUQG+pPgjK/MbrESqv3n9ATmra3Zopp4tpstszPHFfE2sR6EI1XH
         /MuIqTxoWkMXSLrvcYnqUGQvNVGY6YndEf7Smwels/t/G0PiJAqa5YTB3/XSR2c5vF/4
         5S685rADCuM7kD+KTHsn5xD0Bbvj+kfNJN7h3Eeu6Tgpz77cxc6E5ixV5T0A3r/KAOuP
         +pclbSVYUTOzYQ2RRiRVVs4C5Z7y/NhXCRc6Of4Q0fL8jD/Em4FfidsaQN0h6TdkChBo
         DufH5bn8tmF4fp27j4WWCE7M7sjar8yCORXmuz1wFPQxfWworU2xHCWyEC/YN83R4E+t
         3i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904343; x=1795509143;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
        b=Rq0j+ysOPyDXZCx9EVXxCA/IWZS7UROpKz6TARfog+mguxxl/+JfEBXVddaUbr/W2a
         icnOovtC9T4OTPrtGTVf5Y9gN6LANMNIGBGesDWo9/5DSHg9vXWBVdXnts6XCX/GG9Xx
         REFnbbAe781+OZgYbYpozCoU1pyw93uF3iBJHwk4qV+dpxsCSrYN0cvevQ5orP2pjuGn
         2rAwlbIIgHvs2Ka2aOizRgU+mnFYpAgU/64pBsxvzhS53MFzck/4iO9aJZqsMB4Jrzb6
         MUQ55ZHE7BpdeAu0xtW/vOz1eXQNqV/mXyUS0dOalRNsYU1uEeGgbciSL1iGPEZAdjYH
         c7fw==
X-Forwarded-Encrypted: i=1; AL+hErFwrnqcgNs7DsU73snLHSQfmlRWSmnXRSYPDaBGwvXc9ds+UEjzxJ1YPhgRsdM59Kje3loZYYO5dobGLg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8uo/Rs+a7knhSIHoX1a/xrS2B1uo7F0VCDC9vGHUz0BepcgblG
	bFwZ7OYn7XCddUmyVssK1NoXXewjRwxX9KYv4FG4fm4mXIol/Yy+5OEvwM8DgD4PvQeP
X-Gm-Gg: AZFdTZfS+N1xswtp0YMw3u904qkDziIw+oPc9r8MYK/icizGPUfzUzceFehAZvuj8gl
	Y3Jr27l62CdK7uyGHR1sK4zu5PsBjKgRAUE0h2IW19jYvL5MbAudwLwGLpUwS550nQixdxXQRcs
	AfCqj2o1JMaY3+tnZn3T9e6waTxGGjpFQK1iiGKvmX78zoY8OOb8SCFQ2x+XYRmRRminieoWKK5
	0GRc8ynccYmXZMDH1ukI3/pOz/GTozwGzUgVopggVWmiTmOGpjzb5GcEpYP2dl0sVlw17FHrqxx
	T4exbsOk9F5yrWUzJMGkVXsbaHf/46e09vp34VK+1grFlsBhyF3v7E/nR8kHDut2zjxPqmnyox7
	XM4gAEPwI7pfg3D6PIh+tm7lQukqtXkUx+AIW1OTBdrWQrYSUdkzzH9UdfuhF4i1i63pUMdgXrC
	zNkDaQPWx2z5833bPcsEdbJjqRKUi4vc4XrfaXXbiTASpjuXqbdY7Bum+bPzDPeoTfAMMHrNcfg
	25G6XIxXlfteVPTh3ByDAaQa0JLHDew6ztdRmaEENi9hysRnLqL29WIGj2pAAebSVmAdDocC+Th
	VsTlQCVeg/uGZK2TJPNVNtsCOLYjGRB4Bc4C0y7jneKwtKxdCk2+hxBumTf1MuBXwywZGwtbEj1
	dfj4daI/oP++TNxDD0IuMT+xgFBI80Z9dJNuRc3nouYDHhj7q9MPvq1EB
X-Received: by 2002:a05:6000:3108:b0:48d:f9dd:e3de with SMTP id ffacd0b85a97d-49c7353c415mr27089117f8f.45.1794904343236;
        Tue, 17 Nov 2026 00:32:23 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608d10b2sm43646659f8f.44.2026.11.17.00.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:32:22 -0800 (PST)
Message-ID: <fd39200976086130cc82d59699a988fc3e0689cf.camel@amutable.com>
Subject: Re: [PATCH RFC v3 27/44] openpromfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:32:20 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-27-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-27-8cbbea1cf34f@kernel.org>
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
> Initialize openpromfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. openpromfs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/openpromfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
> index fb8d84bdedfb2..6cd02d456bac9 100644
> --- a/fs/openpromfs/inode.c
> +++ b/fs/openpromfs/inode.c
> @@ -10,6 +10,7 @@
> =C2=A0#include <linux/string.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/seq_file.h>
> @@ -419,6 +420,7 @@ static const struct fs_context_operations
> openpromfs_context_ops =3D {
> =C2=A0
> =C2=A0static int openpromfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &openpromfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
