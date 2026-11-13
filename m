Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563700;
	b=1GT8XJo2K6MVj6CRqquNT1ELG7BCErvGw/VD6DvtrhLy3Fu7MBmBxwo3PlsJN2lTkIPo
	 ysE/OyXbHphmJoudGlCtA6A2QPTsN/k/FaaI0AdnMku84UDkx03Y3mUvURKk6kQeihLT7
	 z+4P9wgHnsAUkbyM427Rf2vhasSZGjXH2HBHszgkZWlIvewuN/sJQ1svGfT1sFwcxpSNm
	 3YGJgxO7eZAoDG2MTWWAyAab/KXjb6oJOSW9Fa6QQ8TNcPIarujyxeD7aMrljlRquKDRo
	 pcJI18wUKTRgksQwIEVFn08PCPriLgV5L86nin1UlBCJfIkLzoH94Ftb2cHXzvuOPCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
	b=o0kBaTHdooI9nfwixXjOc/9oVO6oM6UGO28NwkNUG3PB2gdUk6xNat79QbqxhJC2bbYy
	 r09OXLbo/lqFWJp0Vg1IuhyBxewg2QMsakx6GU/Q3AZcx1RLMOJcg1pSavQJwhucfmWjn
	 5DjLeLZw0g2MhqMXv8lDz6IfsXKvCbEMptc4owSpNcC/2J5cmDcjlFDfm97X+Lp1VGTfA
	 PzdXu44s5pp8+L/VX0DNnQDCqphjkeLNv93k3Qlx9YEIlmgfZr1BvXvdpcMl//wIgljMF
	 6JB7puVj3glE3gCKGq6NY7zhJIh4GD07zglL+w7Ul2o1RwfFDLySMP0XyfW2ZWvghSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sk58W6sW;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476F360A260A
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 09:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 476F360A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sk58W6sW
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4395d31228so145414666b.1
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 01:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794563698; x=1795168498; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
        b=sk58W6sWmN4ERo+6S+koVh/BM/TVuc998Smvb7+dAHAHasLoIxA1PyH7SpTb2sphTs
         qaL8BceJIK/C5zTluK59TXAg0t7i18MIhSXKzAc74GDtFkVBtJ5XexxofTn2ErTCpEyw
         wBL0ZIwSoD+QdFLNUYuAtp3uhttIIU+8CcgeY50Q9BuPcdVkRSxffNnvhBi5q+TOT3Z0
         N0fPVcnw8avDa7R0wdKzwUNoVC/3vPRCD1SmgKjZfrkNv7BBIugYP8aqCryl3mRTzhIm
         nyzLSOhSkS/Bye+QA00IM2MsjhnUA408QIyungJaHYxvuyXbuTeC6K0dJcKnUnQNsCLo
         BJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563698; x=1795168498;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
        b=JmmuAZxq3raRgZfMW7nkftH3wLAUimyIiKZTpUxJCVtoVS8xpUizKg04gS2VYZka1Z
         btz9aUIDTXChSdADMWWIdBcXV6phYeitJbxk0XGZcCmn1BWisRzwlw2/HndtHBGpk+U0
         kC3STrPuRlgy53R5Ns+z5sw7h6WIGDxEwfKktnZzq2fFW2W4SMfMI8a0ANSNYzK+lN1K
         2G2VA+xlD3jU4yMlYdl+zysSzql3cw+QscjfsZudBnr4vQ8M431TKMUzG2ldnKfJro5w
         a4bQ1oxdD3fvcZQcTUZwP1uHV/BMoJ5E4jpsC1i9qKZZiNu7hvqWWbjqGkwgPBoz8fVc
         kcaw==
X-Forwarded-Encrypted: i=1; AL+hErGuNbOaUF1/fbG53vG45XmqNvauIlVKElKVQ6mJx8rjUSXdZjb29yzEgBquLPdkXNvq+4UnKlwONgE5BA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/eHyIAj8/adL5NAAJJ7ZVWEDMMauWT7qmEr6JEYvGiTbOx6z7X
	rDsh6cj87jKqGZJmsz6KUpPCu0SZCw/cJNtGx59mqQa150T+nImHgJGE7KERPon5VE/x
X-Gm-Gg: AYBFou39S2dMjWgHiSsdO1EdThkz+aVbYBCXNrpQ5aWGeoKJx7tmTKP1O34kICcJxOj
	AueeceSC2rsFA0ocvJyz09dTNg/GjBaHL1cAhf8qwyuDSjTtW7yBkug/Me2gugQOgzT10hN4fNu
	GtEecle2C3LoM+4Br6+neCTV9zB67IvYRoWSexwp1+PwUowbfy26AuXJBZ3772XbnnRI/fd3HGx
	DJVxUnQzO1n9xSSNwHPCaqU+2iolXtyHRW2eIEBa23SjhBGQTC6Y33USyoKkxJPXhosS163HeU6
	yyOxKF1ASyZFipXeOo74YJ1uf+nXfJggMBInzOcTh02gSeUSFQEo7t9j2L3MmnUrotWI0oBLgcH
	5+Qhmt5t7YgNIhmVfxPYhhNqRUHp+AvIeZYAGrkn1+JCHDUgwGPfleJiPjFPEkdgVF5QMxc+9OK
	lRlXHcI8MMDzSzPv9kg6g96iKVzuRwtpnxZZ2fcKdzi6c5mVaiv+bOmv9DbvNX0THkrJ+JFf0j+
	wBnunw6VifBFXcNy2hYZqAMYXbQcsz+p0nq31TP6liMcKXzEpgKTJd5GNluRO8TXl1ut216q19R
	23Y3FmkBtNtQBe8RriTj2Lve5pfSsuhpUWDl1Rjklzify8JsjyUfc/r9ar+V4Hk=
X-Received: by 2002:a17:907:ea93:b0:c41:4c20:5a80 with SMTP id a640c23a62f3a-c50963bdb9bmr198299566b.44.1794563698514;
        Fri, 13 Nov 2026 01:54:58 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50957c6c1fsm75151566b.0.2026.11.13.01.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:54:58 -0800 (PST)
Message-ID: <b42c9f4d29a9cbea66929c95cc8f736f12703c72.camel@amutable.com>
Subject: Re: [PATCH RFC 01/41] loop: refuse backing files that aren't open
 for reading
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
 linux-kselftest@vger.kernel.org, 	stable@vger.kernel.org
Date: Fri, 13 Nov 2026 10:54:56 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-1-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-1-4c998976c6c7@kernel.org>
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
> loop_configure() takes any file as long as it implements -
> >read_iter().
> Loop itself never checked whether the file was actually opened for
> reading. Buffered I/O went through vfs_iter_read() which refuses
> files
> without FMODE_READ. Direct I/O has called ->read_iter() of the
> backing
> file directly ever since loop grew support for it.
>=20
> Since commit f2fed441c69b ("loop: stop using vfs_iter_{read,write}
> for
> buffered I/O") buffered I/O calls ->read_iter() directly as well.
> That
> commit was about O_DIRECT handling and the FMODE_READ check went away
> as a side effect.
>=20
> So whoever can set up a loop device can read a file it was only
> allowed
> to open for writing. Open the file O_WRONLY, configure a loop device
> with it and read the contents through the loop device.
>=20
> Refuse backing files that aren't open for reading. Loop always reads
> from its backing file so a write-only backing file never made sense
> in
> the first place.
>=20
> Fixes: bc07c10a3603 ("block: loop: support DIO & AIO")
> Fixes: f2fed441c69b ("loop: stop using vfs_iter_{read,write} for
> buffered I/O")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/block/loop.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index a3325ceab484..c96e35c3ef42 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -528,6 +528,9 @@ static void loop_assign_backing_file(struct
> loop_device *lo, struct file *file)
> =C2=A0
> =C2=A0static int loop_check_backing_file(struct file *file)
> =C2=A0{
> +	if (!(file->f_mode & FMODE_READ))
> +		return -EBADF;
> +
> =C2=A0	if (!file->f_op->read_iter)
> =C2=A0		return -EINVAL;
> =C2=A0
