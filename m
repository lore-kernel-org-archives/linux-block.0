Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565648;
	b=rf5Oz00vd6/V7pR1Al6wKLJQE+hh6g1wj/gKOP05/Lg1qTwCxvIjss04LHKQ8m8oXjiO
	 X+sa55caqbVHZzSaXdxhqbFbAwf3tQJsND5cxB9qoMIRoeZoTl/A0OLsQbwgETPjYzxJs
	 Vj14oh0MnFSKxq7Q3FDz30PHp6X9E4wXn/qwzkx2gsYGtHnV3ri0JIpQ5+tO6Zb5taO8F
	 cy+BMQHcZsmR7/dzeJJvaLi8r7jAHHAiUTvhZKr0t3c498PrlLVSh7HsSh9LT1rXYKYtu
	 X7jUxvZDF0QlFSRPKHDFTzmlkX/9wobCh2CE5q2JiqT2AN3JeqzrluFu+3M51J6Ntew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=TXY31nY7nMCHyiOZTp7Dn0JSWYPda+tFg8CPAdTq7II=;
	b=KkgsTd3x6Ctj9Cn/h4sBBznZdwDdxyCcct72YGZHkFW7atu9FQjh4eq6jooSIul6RErJ
	 rG7Ra+0x9Ow0tztWMsFGkLBiUx0km8pfR/8cGwz5etTBn3pVigd0218B1ulmZdVChMdEZ
	 xBHocD9AQWQpt8mBMVC23vY0+IOPRcpfD3iE+MR9EAZiwv82gIgwytUXiz+TcCzajvT7m
	 9ExSObSTfc10VuFE3yGtKixxCYOa1zEn7iY+YwUSp75Sh4uI/6m//haBFY250LEvmdSQm
	 5RrZMjRZikHobHu4xTShUZcdaeOGCXS81WBNa7ftoyjzSN3srLYX2Fwb008hT/vO2PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=N7Ff61ik;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D5C606A339
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 10:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79D5C606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=N7Ff61ik
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-491846221ffso783332f8f.3
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 02:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565647; x=1795170447; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TXY31nY7nMCHyiOZTp7Dn0JSWYPda+tFg8CPAdTq7II=;
        b=N7Ff61ikIQ27nXVrR+i5fFuiFp+kpNCkSJ8kzzwXsWXF8oHPQYaaEtIn2sVJ/R61Yt
         eN/EgbWtaqyPzsaKr2MVnoSj+msmKBheiZS6yCjGNfIw7Nev7hKixHBvdeyifMwCAuyY
         p4HuC2pLhsdw/6s4IDRTQYVk2XreSuuUeA2/lEtpnIKw65+UPm9cBNCU3JmsoFXsrPGj
         WUoovGImF4s4dFS6xRIsBa0e81egoKAVqgb5m7AbWjvbiu6rsFasaFfPaH+ik5AAKzYn
         61DshIaK40jfv3WiwMjZKKDrEIOQNGX/IDgIqQj4sI1tIu9ZETTA/xF/QESgBcPouNO3
         9yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565647; x=1795170447;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TXY31nY7nMCHyiOZTp7Dn0JSWYPda+tFg8CPAdTq7II=;
        b=Qrxyb5o+WbSrcqJrkBjRu/NLUyoqTk4HaqjiQKowJDF6n3D1bskSijwVhWN9CYWLfY
         9BFhHKUrJyht71D8gIt+DprloiXOD8TcZNNFDhKEyXYbGxAPdlIkUqN5sa+u+1NDUHXG
         UBtz+FI3jCuEkiANlSnZcj8PejOr+kXUBqT1BzT+pBGCcg5OBP6tecAmPA5jGkKMBD64
         cwSiabq/AZRt1ulbDaNPAHaI8HC7SZzWv3wJ+zQv/GhPvSuPguNHqvaRJBy7fOGtupQT
         +sopEaPtHu1lAEpCUjEYu6O9npgpfKoKmsBx7aXCwfIf2ytkyED5SDgcF2+Dl7PmQMIy
         qCIQ==
X-Forwarded-Encrypted: i=1; AL+hErG59YzcHGzR6QwZcUwmrCg2jdI/mF7PxAq5BhYdIw9yRTDvNyzU8RE0ZxPnoAEFyfHa+QxFqk6vnzc0iQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8h+QyA5kGuLP7p6iCECvupzcq6TVdsqVPEHu6JJznQCEPro81v
	5Mw4ItiQQDROUZawghc1Wnr2Ya8a8eJo73qYFcuXDKWJYQQ6kuAs/eaVPE8z5MB/hvqC
X-Gm-Gg: AYBFou0yNGzfqNkYPAwQI4PPZ9xxQqZxjBb4fKTqfrgraSF4ECqwB/kXSHXtVGz7Te4
	/6yfIsHk3rc0k6HiRV6kxEkmqAJtCNrW63XLyEL+ttkwuURAb+Gc8pmwCNmZyDGt94gzhfwGK33
	QsOxo+9Flyqepf8HCGnxLFuTTZYdqNi4Xq5Q4INzmK1RwZEgcVLycGW0A086wRSKwJUkskVOViG
	7muxjTHHP4Zy5lDU29+nKCqgG9Z4GJ2zOfsJrhNmtbL7nbVNbma6uXSnNvdrAXxmBqTnHpyc4EG
	5i2SgnPa1zV8mzGLdySyQu0eErJDweWr0MJM5cNUoF+MgjrpTQJyFS2R3QxPQ7TU2DW2Y+H789W
	3TiPFZdVuM6ic0iKmT1095V/hsoyUYF+bD3YUMCod7ZCRR0QQvXvfobrnOp3ay+qdE3qBU4AvIB
	SH/LdtPAzVrGeTaKWjzLQgtqowR6qI65x0K0Pw1TfUIoLyaWEE6/bYhGKd29EGLRjV6DZPhRTIY
	kzrxV4Qr7/tmYkLKT/e7pBoueZI1nbxK8fjj3qeAxVB0kP+d9TZWGHdVNvzegfBFfRVQO3Eo3X0
	Deo7DgfkYmknMJ98sJ0r46N48dQgEKn0ahPaIQNinoHoR7dX34CryVkoZqw/Wug=
X-Received: by 2002:a05:6000:4707:b0:498:c419:3728 with SMTP id ffacd0b85a97d-49c713ae367mr4463557f8f.22.1794565646661;
        Fri, 13 Nov 2026 02:27:26 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5a32d336sm5077482f8f.0.2026.11.13.02.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:27:26 -0800 (PST)
Message-ID: <0c109a58804a2d782e549af6ad13e89532d9f9d2.camel@amutable.com>
Subject: Re: [PATCH RFC 40/41] erofs: refuse files on pseudo filesystems as
 backing files
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
Date: Fri, 13 Nov 2026 11:27:24 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-40-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-40-4c998976c6c7@kernel.org>
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
> File-backed mounts take any regular file as the image and the same
> goes
> for the extra devices of such a mount. erofs reads them with the
> credentials of the mounter so this doesn't hand out anything the
> mounter
> couldn't read anyway. But files on pseudo filesystems aren't images.
> Refuse them just like loop does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/erofs/super.c | 6 +++++-
> =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index ce05557bd998..980d5fc2b576 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -158,7 +158,8 @@ static int erofs_init_device(struct erofs_buf
> *buf, struct super_block *sb,
> =C2=A0		if (!erofs_is_fileio_mode(sbi)) {
> =C2=A0			dif->dax_dev =3D
> fs_dax_get_by_bdev(file_bdev(file),
> =C2=A0					&dif->dax_part_off, NULL,
> NULL);
> -		} else if (!S_ISREG(file_inode(file)->i_mode)) {
> +		} else if (!S_ISREG(file_inode(file)->i_mode) ||
> +			=C2=A0=C2=A0 file_is_pseudo(file)) {
> =C2=A0			fput(file);
> =C2=A0			return -EINVAL;
> =C2=A0		}
> @@ -835,6 +836,9 @@ static int erofs_file_get_tree(struct fs_context
> *fc)
> =C2=A0{
> =C2=A0	struct erofs_sb_info *sbi =3D fc->s_fs_info;
> =C2=A0
> +	if (file_is_pseudo(sbi->dif0.file))
> +		return invalfc(fc, "source is on a pseudo
> filesystem");
> +
> =C2=A0	if (!test_opt(&sbi->opt, SUPERBLOCK_SHARE))
> =C2=A0		return get_tree_nodev(fc, erofs_fc_fill_super);
> =C2=A0
