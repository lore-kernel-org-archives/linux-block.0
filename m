Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903967;
	b=Iw16TKLIRPUQnsIXu6Dn0cxX+sg7NVZWEpN14ooYH0iUMThF0m1tFuYUDIVRFbWTXtEE
	 uzw0jY3ilNQCWa9LM3bYVa0PsFqRPNyDJ2Pr7tNsBB6e4S9tL34iAC2jYsXEsTLrqE1W5
	 NRMPicJTAhaOCjWsg5J0EImHVNgwvp+i94v4x4zrtUqOEEVGFR9rUsDaOnL6Vmbsn5nkC
	 Xd8QIejgoIHEwdqOCJYThevqeS79YQwxhfslSFOXqLBYjmnwaoYDnhzRgiqKI8FWrGXDs
	 VprSXYcxciJGgjp1dnzLXb/FxCfbP/GFpyB07vNp1V6ZHiEae5rlObY9/scJC2+L4uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=z/NZRmC5bENRF/WsK1hUt6gARTy1xozW3x04wBCWbAk=;
	b=GKJP6LTFx4ctLQCGkr7F7IS0c2h5g+HPOfWn89jWRTNNzZ6zUUW8qS26uDiBBg1Grq6m
	 SPa7mqocnRKNIMxj/euM0DueQFK5pj4FkmDL8J1470DG7g+rVM9X8E2CBBb+Ibj2rsfvD
	 P873RoAP2sNWwYNXwc3hJiLG7+9A0ymBH6O9quvj5eZbLVdOr2eItBB3qemclDkhasHdi
	 E+J6QQ4TqLi7NTlS+lhRYg5mEeamYQz63o3ol3CVzFPGHQ+idw2UmrybcYsJ9gH5B0I0y
	 N/9DCBW0fasWkw23+lZwQBmod0nolSnlYCzPzJ7yXq7mz81Dz15OGmKoXSQkvmROcQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cds43TFp;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CC4606A330
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 08:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18CC4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cds43TFp
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so7875555e9.1
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 00:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794903965; x=1795508765; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=z/NZRmC5bENRF/WsK1hUt6gARTy1xozW3x04wBCWbAk=;
        b=cds43TFp7I9j7WPcDQvYfHpQ9LovbzzVif9J1GAb84gdrUsjaaD/ks8/CxWEGRZF0/
         68hyeBKuGnu6JbonI+DUrAk+S9ERoS7tOFFA4H5eAQDr7L4jclXV2ELfZ8mKm2Ufg0Vf
         wmDFKHpSFXtb9q6HdOEKHOgWOeHJI7n45fohFUmuSejGQMSPwWlozLhppiRP7NP6/RTN
         Xh3C0JkZ12tnXvLGCknth+xcOYp3m/oSfXqUlVI9cwzFe0Rue3P0S85bM03sQyFUoXwh
         8JJkMFcg0oB6zhSAQwaixAlqp7dYBZf2pow5RK/cSK97CWugz7jqMDtCMqYWg5eRSPcE
         y3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903965; x=1795508765;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z/NZRmC5bENRF/WsK1hUt6gARTy1xozW3x04wBCWbAk=;
        b=OgbHepXdwNthjFQUHhLkXlxG9HiWOGSsSDIDUPcX8OLvPvJpX5qD870USAV7Nt/JH8
         WfzxNWr1mGd5m9+bjqnOMYMo9bGL3DEYgrFJbaaYrFf7YK08TgSJdVhMPoAbt/xV7EUO
         3/ftu2FVkwF2utnbgR7be5ayiJxgTvyBO5XuSHkVlmMs07jjnFDVBhQlFKLm1Q6y49en
         DttSQyEEf/evdx49BkTVzJ4LwuLoDANObO6C5vva+noa9LWzB5VXYC4bEr9x04yBpj8X
         e7y5Z2HL9S7MGHAPgPbRczZlN87MLDP1wzCMb71dfoZKljjILEr7+tmreIC9hBnlNajy
         hnQA==
X-Forwarded-Encrypted: i=1; AL+hErEJQD+vI/8gWvez2sCqC46y1+E8mb9JOdPUOYmc6dN4GZIYQGtVlHtyyp/4Drxmq8n9rrCLnweMp4PM6Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+4fX9jWKyNl2z5sb/lRVTyR/c5J2xUcGFoJTasxVbvDwAENbPD
	PDE6YNrgxt5nTarp+3DGBbEuaifeoN/NhSiokgd6ooFzktfw8woAc/UD7YSQSMmuK+OU
X-Gm-Gg: AYBFou0JwteiYIc9ie9HD39YP219vLPIjNDnE1bj/P+kh5McFwj3MN5g6j4MUSA/gxF
	5j6WuV7vXBhciAFuwNLXqIzFpmryvYn1GsikE2x3EqMokFgk1X/szLenk86efr7r1lUq6vmF8J0
	blSmD/tPF1BYiv8Dv/lJEyuzJyBE3jG4yxkzEgAVOrF5qjQ5FxDVimrVZgufEbWLpdv50A7d2C/
	etHMLBPix3hTjY/YrwnEscLHBpL8SqGbpmZffZwWH5RtNQkZ6gpQgngJ9aW89TcgIzaDmedn2gT
	VFqqZH7hYSOx7BK8boTi9HyEN/Z7OuodAHVQTv2wNAcQty/rUjs7KqxKYrFWfogSgjKeP3gP9um
	iuWBHN01El7dq7hP4pYNCGSKd6uq6lXEGO8It6D8CFc3NvBeDg6fBJI58gMS5u7HN9R2iWRJRNK
	DdKGMlcwDnh7RkI/8PhGe/X2mkqz+08UiI7xDQTRbFf2cZ929G1z/dd6djI8vJHmb1YAa37xY0y
	I/lBhr6sGqOIlJEWE9de6/SgNzVIcoHmYtQAB4JKptCdSekGzNq5e7ekiCsXki6guevuVEZToKg
	H4osZroJFsBc8eeK6OJ06EnBEMp7Gq2mSHZQGBEgUtkvSYhJmXfbFP1/SFNi5TUX6C/WsgY0rfq
	W8MyxvNIxeQlp4F6co3zVxm74xHs23Qo0EUVYJhyowgw9kaORXwyZGu+Z
X-Received: by 2002:a05:600c:5493:b0:4a1:c27d:e1a8 with SMTP id 5b1f17b1804b1-4bb783813a7mr42606245e9.10.1794903965400;
        Tue, 17 Nov 2026 00:26:05 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7ad9430asm12629125e9.15.2026.11.17.00.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:26:05 -0800 (PST)
Message-ID: <88041240268f70b218de7dfd58c41977d03a60d3.camel@amutable.com>
Subject: Re: [PATCH RFC v3 03/44] target: fileio: check that the backing
 file supports ->{read,write}_iter
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
Date: Tue, 17 Nov 2026 09:26:03 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-3-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-3-8cbbea1cf34f@kernel.org>
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
> With fd_async_io=3D1 the fileio backend calls ->read_iter() and
> ->write_iter() of the backing file directly. The synchronous path
> goes
> through vfs_iter_read() and vfs_iter_write() which check for them but
> the aio path doesn't. So a backing file without them calls a NULL
> pointer on its first I/O.
>=20
> Refuse such files when configuring the device. On the synchronous
> path
> every read or write that needed the missing method failed with EINVAL
> anyway.
>=20
> Fixes: 769031c92c8b ("scsi: target: target/file: Add support of
> direct and async I/O")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0drivers/target/target_core_file.c | 8 ++++++++
> =C2=A01 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/target/target_core_file.c
> b/drivers/target/target_core_file.c
> index ab9824a4852f1..a5391e57e9aa5 100644
> --- a/drivers/target/target_core_file.c
> +++ b/drivers/target/target_core_file.c
> @@ -144,6 +144,14 @@ static int fd_configure_device(struct se_device
> *dev)
> =C2=A0		goto fail;
> =C2=A0	}
> =C2=A0	fd_dev->fd_file =3D file;
> +
> +	if (!file->f_op->read_iter || !file->f_op->write_iter) {
> +		pr_err("FILEIO: %s lacks ->read_iter or -
> >write_iter\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd_dev->fd_dev_name);
> +		ret =3D -EINVAL;
> +		goto fail;
> +	}
> +
> =C2=A0	/*
> =C2=A0	 * If using a block backend with this struct file, we
> extract
> =C2=A0	 * fd_dev->fd_[block,dev]_size from struct block_device.
