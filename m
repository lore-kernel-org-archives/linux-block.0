Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573426;
	b=blWbE5BpKI7xSTzp9PK+8z7gLsTmoZMSi9eQ11Kk6XFBIgHQdUdwd0LXbmMAbOsm551V
	 Z7ZxEluRTQjkh4nJ23JYbjFlpb/oBVUxhgkuyo3eu2j7MWPTBBRzHVcvgvk0N28GUmcBQ
	 oOWEZ1yQsQzI5adtD4xjbY59KqWAIfJTuD3s2mKG+6w+BzxY2suwjhthSt2TGcZ8r+Ahn
	 w3LTPrntrGhTYtxE8nWy1mwQOXS3ySuvQVehL9IOoDUH2Mf8HYEIHoy82jIU7U0liTD47
	 mCwpZKKVtRaSc3YcTxDADwVxKmiQettsEPevRttYNUExvyq9f0V+DClHODefVoVEHuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=;
	b=XsoSkWw7mK58TBRKeHi3Pg8o7xLIeAONtseoyUfpC4pCS8etXrUCMQtIu9V2oYcM7Jpp
	 KxUrqN7I692ZnNMGamgltwb7J5yBtsV3pzR1HNSq0mUTpvxaK1VUl2AYEBkD3q/NIjp5C
	 8AT4ntRoPG7u06mNHaYGH0Jbgex+xaT4Xnv0CRzjguMcw1TX5S6dAUQRko3tctY7ELdJU
	 zgsaZs+UkKsJ4mdeKGXxhe7EvE76bXA0s3O/ebHf8C4wlKyXWZqc/5Y4DwRtrKTddQ+oP
	 6LJ3V8TfZxUQXONvVTRSWhx7t6RbGrWH2a7ibBRw0BhW8EaCrJaowDy0dDFtDVvVldQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n2XPHptJ;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11EA606A33B
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 12:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E11EA606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=n2XPHptJ
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4b886ebe069so3303895e9.1
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 04:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794573423; x=1795178223; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=;
        b=n2XPHptJWAiGnWBjuWK6g5NkFljgiKFcabC8Vn0J/U7Rs5oCxIs8ae//bm8icbKFtW
         GhaGag1Xoi7ZyXwdHESo4gzqQGVIFHJ4SWyDVffZrMrzihrR6J8Y41NroO1pUm4S3UEM
         GevRMV87lpSFNCzDE68IInZGbL5X+gYDk7IApotAPKeUo9xOfBbHGBSC5mcggp0KJBcK
         Nc+e1mR1SmgmgC0Frha4Bk72pKDTzd14yUseYASwtvG8qZfbG+gNn4GmoQhA8ODET64L
         X6SskqZIriPJvj35d5mhI8G8hobVKdLKjnxeG6bMHAYcCPTjUD9dRkaaJK3nWVTXV/IA
         bDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794573423; x=1795178223;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87/Ge5NhXdmtGpcXCLUvnqWpWEAxiW5M6eWOW+m4zUs=;
        b=Xhv6qXDqyXjrXGbzm/kt9mznMoo9cfKqbb+o5kJ6KzfV9PgDPsEuDzqgY7ZE6lTwiO
         iPoqc7Aj4sQwrNWGk0BJwt3s8rr9WNrBKLkTGv+ShL9++6HYxCkLphpDnwOKRj/rWMA0
         O7z6w5pcjPsdYoIxI+EFiiTTqH82dPpkwMrUuVHAlzZEU4mI00jSrbnarzU8Hhrz8PGQ
         PP2CdLeGD8v7BR1r0uXSrjfGhsjvh5yuhLDFYx1GFZeNichnj7I9WQeWIeP3ZW174Yq2
         kKAVZjATrLRg45l27NpirSkyvFx+NnS60neYwSSb+QotYw8l/+v2N/pIdgksxoCOqFac
         0Rqg==
X-Forwarded-Encrypted: i=1; AL+hErFdEXU9DZ1AFps3I8Q+XVuMI02bsWD268tmdRbU4N+sitidshltn57jC0bM1yqx/rdadRHu2DCm0e3O6Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+tg2WAt9K4K1/xt8XXXOITu4xc6ek4m4d0VPsR5eXbyQ4uutBu
	prYiBYlSpH/o601v4PmgimXja+i4R5TxP6DFnrefctVZuu7mGYAfPWIuocnKR1DRv5JQ
X-Gm-Gg: AYBFou3FPv2/O+C0RChT1An1dJ0MAsAcO9DO5e6SY+0kAMC0AU/5sP4zFRSvbeEpV+q
	WwVFKvUEE548vboKxmu64jzLRjSI1/emMGrXPjGF4FeGb1PddBWQJCv+KGQldJlD1YjWdwDtLi7
	gEonWALkpRzrVbABbhGE4H5uDZXOlFeycwKQSnGYMWFV67g959EQdSLL4HnY1x5j4UCE6dVEZCi
	/+f3FW2jxMxHDF5mjctpyQvdeAkzaCNZBKiJiYZ7ksrpGL8E6Db1y0iLMonLF2oCUXaZ3qKJIyy
	sPFg7AcUVFT3N+8lWTO7PqFDQK1zqJge/ztkoW/cC384bwmC4ScWTxNfRit9KKoBK0C0hURM0iU
	vXVLvr0b/1Fuc+3H4UqCWRh52K/ERESGfgHDYo4OktbNoLxa7npRdvlcuYQMJ1DlFXqgG/26BU6
	eEFrklej7RaNeLTHgpxRTPIPYjhPvVx5L1SICKXKAxP84PZPkJzCwtDuK5Olqt+XYOV0oLV78gi
	CdlTmHpy5IULa78o3+u41eEB+ZIOrCeouuOWpUTmu2tx3G0Y5rOuNc3yXq43/g1vdFwPM53DH0s
	KU59ZGHqDoe2JEXvQJVXysVtOTg+4UX3Za7sF4K6QDFj457TwIeTeWGqF/ruc2idNQy9ui5C9U6
	P326/OvHx
X-Received: by 2002:a05:600c:b86:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4bb55ac4030mr49782945e9.34.1794573423157;
        Fri, 13 Nov 2026 04:37:03 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55af2901sm57437255e9.13.2026.11.13.04.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:37:02 -0800 (PST)
Message-ID: <f12140be54ffc4d1e8e4026f80c41c75cf5727e0.camel@amutable.com>
Subject: Re: [PATCH RFC 39/41] usb: gadget: f_mass_storage: refuse files on
 pseudo filesystems
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
Date: Fri, 13 Nov 2026 13:36:59 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-39-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-39-4c998976c6c7@kernel.org>
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
> fsg_lun_open() takes any regular file as the backing file of a LUN.
> The
> file-storage kthread then reads and writes it with kernel_read() and
> kernel_write() on behalf of the USB host. With a procfs or sysfs file
> behind a LUN the host gets to read and write kernel interfaces with
> kernel credentials. Refuse files on pseudo filesystems just like loop
> does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/usb/gadget/function/storage_common.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/usb/gadget/function/storage_common.c
> b/drivers/usb/gadget/function/storage_common.c
> index 75831f2c7abe..83683ade20c2 100644
> --- a/drivers/usb/gadget/function/storage_common.c
> +++ b/drivers/usb/gadget/function/storage_common.c
> @@ -211,6 +211,11 @@ int fsg_lun_open(struct fsg_lun *curlun, const
> char *filename)
> =C2=A0		goto out;
> =C2=A0	}
> =C2=A0
> +	if (file_is_pseudo(filp)) {
> +		LINFO(curlun, "file on a pseudo filesystem: %s\n",
> filename);
> +		goto out;
> +	}
> +
> =C2=A0	/*
> =C2=A0	 * If we can't read the file, it's no good.
> =C2=A0	 * If we can't write the file, use it read-only.
