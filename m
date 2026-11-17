Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903941;
	b=MxpG9tETDT5vJHa88bwTN1TgNUIO+BVZP09y0GIeSHtAtpryy+b+RKzL1fek+5kj57DB
	 Sxc+D7yUXmuIISYQswDVUaSVj+d4YGcNkj3tbg7DlZruLqTmMpiICrhrcsq8xPmsB4vkY
	 asd7QgqWtoQGitrxC04+VH/S6ocYDBb8baVaFoAmFS+66Pr9GVeJ/XlTFJn/6Dj4agvPQ
	 h8rF/06o16E9OAnEfvF97iXqVPtRlMtWUJgl6QTIGr86R8ig6q48BV8A6jKIYHwlVuYBM
	 WBaq/Onpc1t6W3mqOD9zf/6SjDFgP5pzUenNi7YK44qQGu8Z6FnvyvBdsPKCmuVmfjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
	b=l3W9Hj6hMy2O4OnaasKT6GIJ/w4Q5Ru51VYrwkZLDIbj6v1nzOEB2kXTMuSnAWFVwD40
	 YSl3ILgGqaFeAmQkkDFRdgSO+5onDCfrYvQQWvhW6K8pRaHRVPagc2m35rlbx3ZOjCYgp
	 oZh/E+T2Kp0Qr54aG3zQxqEjolS9y0UcjdVgDAmqA65QtLZ7iARkXLzRvzeOWYSNjYUeM
	 c1VJy4hmPkYaXBu0+kU5zJ3T6VOj4sa0GIHtmacXwPizk0SsJNjMglto71raeiQwAqypK
	 NoC9WZmzDWwyfRZs+g9LFo/hv8coeu/we3qSNQPWPlkDVZ0+3gER3QMO7B0+qbnt9sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="QoCmkI1/";
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C40606A335
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 08:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10C40606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QoCmkI1/
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48dee593f18so4521693f8f.3
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 00:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794903939; x=1795508739; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
        b=QoCmkI1/XbLLMuB5pWQjj6w7lhYbbqiM96jQW+pj9RZ000aRRl9S7H2qSmbtORMNOo
         ePt1TXAWzVIR/TrMeI58Zu3n81XgIdPHavzyhyljr/3uEJYZwsW6Sg14gd450d308jE0
         RrvE2vSlthe4MhW9V05IsJzW8g0CM3u+nfQ1hkfntpYQW6a4z4zmXmxD0w/TiuzDbd7U
         U8xZ2FexNWbZhSQ3d3pA0tlH/f0MOfn4O69UeuIyRM8vQ/YXTKpGPDyGoQczoxEfoynP
         BDcwZppUf46pJGXZ+RH52kug0iZSl25eld2NGIqCa+XVs4XFwFr0CZI1pzljVyhbNHw0
         NmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903939; x=1795508739;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
        b=Gne7F9udO3L1wmfGQfXxA1zonj1u6acZBcXyFVjEy1XDKqtfP3P0yzp7GdUYhFWn9H
         1m7cz8jtcp8yZUkxPndOmh0hgann+eRvr8UxLxZCkzbf3g8nsi5uxvFjExr1HKpvEVn2
         gnubRRUVLuwFyme1++mKWJjrvSo68RCLiehb2uHb+eIUPZGcTIp5SGxWg63bXYwr8k56
         DKim0PkNQvrZO5nVRN0zZYJsgVllSaEfoWIqo7ZqS3oDgIOf/F4lle5xzfHKq254lAgp
         YHOzg1VIZ1Zi6HG9gY5FFyKq32hYh5TtU/nugoygE9S16ZipQkKblef51pk70Cul+dDI
         N/ZQ==
X-Forwarded-Encrypted: i=1; AL+hErFi4QYtvJU5FpOvhHR3oXl0HX0ox5EHbU1t43QrKOrM4G4auROYNwXyESMid/UwVm9mQPG+7lvzjwDkYA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/NKaEneWQcX7H5lg3pZ9jLTqFntrR7nA1horGS4iGkC08MkPCd
	Mkufc4K/Sq+w472CsRZXwE+TbLQig5dx0C+rCfmeSUwdj1gZAOmJvl7zpSAF/NlI/zR9
X-Gm-Gg: AZFdTZcn4mDmQ7K9Vn4q3HCtP0DFw8it69moHxWNXbrtnDc9Rs9B0FNamjjDMQLPkEm
	lnQD7XC1jsNdrmLlB3UUm5Q4l192bLqzai3wwaAWd6Bk44v/zAhFj32wVkY8yJ/lH0YigJ0NjFm
	3ofkvGER+Rbql5m2efg7sf2T9MPiemv7svWb/jIyhL3o8A29hGnFrexPzUNDNV+C2gyDkO/EFVg
	hS6493VcWPYM6BwZeqxIIJgUZm4CMefcFZW8PFn6gtM4FXvCn8mHjKZtkGmBIwBj7uD12UjpOyR
	yXlX05v9TytO/152lRyunoE6raqjI2FeVreUJVWVMG/0a1XdpkTNkjOzR1MJbFq+VougkhcTTZ2
	sb9bBSDE/JqK4DIhQCKarEjz1f2YHOf9ugX6tU+VwyrVrZwf9i0bE5VyF7Rh6dLG3QXSnrFDjfl
	tdLYPDhHMR/UxJPo89y5vRsJSJXumxly/jxclR5XgTmgPyLDZ8y7oXwix8q4skKwQ8lOTaTOsyZ
	+CLnBNRp/6I8rJJWHxwL01brOdvk7Zh5B50Y2AAFWIkQR13oIT2mYLSSvqSAQ4wNF7XhmQ1i1+8
	0NuHxzZiKBVOPe2hErv5K4b9EH/8FGF2NhlyCw4M687PEXvBjYFNv+L5Xmi9WemDYmLPcqkczof
	vCsDPWrzdDsNIbcpJNOo1RKpx6SCtLoJgzKMPdma1rZUAwd6702EA7wbbLmtHEtMfxkEDAOrZv9
	X1xQ==
X-Received: by 2002:a05:6000:2084:b0:492:46e:d4ce with SMTP id ffacd0b85a97d-49c6fd932c8mr25238543f8f.13.1794903938925;
        Tue, 17 Nov 2026 00:25:38 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5ff2be55sm26907832f8f.28.2026.11.17.00.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:25:38 -0800 (PST)
Message-ID: <a9124bf1c858cef3e8ac06b1b2396dcb0e19e2a5.camel@amutable.com>
Subject: Re: [PATCH RFC v3 02/44] nvmet: check that the file backend
 supports ->{read,write}_iter
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
Date: Tue, 17 Nov 2026 09:25:36 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-2-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-2-8cbbea1cf34f@kernel.org>
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
> The file backend calls ->read_iter() and ->write_iter() of the
> backing
> file directly but never checks that they exist. Everything that isn't
> a
> block device ends up in the file backend. So a namespace pointing to
> a
> file without them calls a NULL pointer on its first I/O. Only
> buffered_io=3D1 gets that far as the O_DIRECT open fails for such
> files.
>=20
> Refuse them when the namespace is enabled the same way zloop does
> since
> commit 0c10f8a1a7ae ("zloop: check that the zone backing file support
> ->{read,write}_iter").
>=20
> Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0drivers/nvme/target/io-cmd-file.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/nvme/target/io-cmd-file.c
> b/drivers/nvme/target/io-cmd-file.c
> index 695963dd932ee..dfa8aa46188c8 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -47,6 +47,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> +	if (!ns->file->f_op->read_iter || !ns->file->f_op-
> >write_iter) {
> +		ret =3D -EINVAL;
> +		goto err;
> +	}
> +
> =C2=A0	nvmet_file_ns_revalidate(ns);
> =C2=A0
> =C2=A0	/*
