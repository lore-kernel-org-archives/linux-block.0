Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF9A145B3E
	for <linux-block@vger.kernel.org>; Mon, 13 Oct 2025 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340879; cv=none; b=Zj9LmXLsbfr4XhYspQap96V1/HxdxlL7QeEl/MLcM3yCi4nxzpchx2YPDhPsXYOvEaG7v5UUgNXAOsUaxzhGYSiBFp3zHDKwTqnzJxWlHlJ2BP4DZIVNDf1agZIbfltwGTH33gci+QTyZ61JEDsPal9XCE+DZF/5KxjCgGIilVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340879; c=relaxed/simple;
	bh=RSUCA9ticKaDxkrE3LGHMl7UuGRaFEIACX8OO/22ReY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NP+dZBYLZfnG2uGNM/tvBm1eLOHKYEb1q52zgBsK+YjBkq1TqQrGeGJCjei2aGxrWZ+Em5r7PvYoYlo9JsPSmSLgGSw6y8/6xK+jmxWxTDvIpx9V0H1a28b1HsCIDs4+0E79wsgJYaW6BgaTIyXCtSQTA5QIqK5SJUR+lqp4/Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=yPE+TdSy; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yPE+TdSy"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4clTcz28Jlz9srX;
	Mon, 13 Oct 2025 09:34:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1760340867; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GBSxBBTrxtBEoYSu30sJYjS5XWOABkVahkRi1z6ILwo=;
	b=yPE+TdSy+dSz14mcP+FiM4DJ+j+pwmep5fey8OHSts0JIqlRLXtRbjd0VGDj0xJZBghdjt
	Nx0VWsgAGWdynPlGVKFL+gSh4uPHxb5YHEyk2VnX5PjXQpeWeZQl5GcpoYZyGn01//lp7f
	ZkcZQogjNrh93AD7Znb2zn8kQMUuR7AoDJrR2wQ4ZEHMk4Nb4ZV1zefpy5+QBHU8PL14z3
	I7YdTbRO5ddGk0cEB3TxfJoqbge+xTEfKB21iOizDpe6EKJ9uMtPXmPQkhYdXbUQPZp5/h
	FKcGiQL2i3RBZBb2nxQgEUqkec5HlPftWsMheJfwVBSjUUKIPdBANsTY+Hdhmw==
Message-ID: <8d3bf7c232248d4d8fd5e1f032c8e3d56c9e50ac.camel@mailbox.org>
Subject: Re: [PATCH] block: mtip32xx: Fix typos in comments and log messages
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Alok Tiwari <alok.a.tiwari@oracle.com>, axboe@kernel.dk, 
 andriy.shevchenko@linux.intel.com, phasta@kernel.org,
 fourier.thomas@gmail.com,  viro@zeniv.linux.org.uk,
 martin.petersen@oracle.com
Cc: linux-block@vger.kernel.org
Date: Mon, 13 Oct 2025 09:34:24 +0200
In-Reply-To: <20251012184010.198891-1-alok.a.tiwari@oracle.com>
References: <20251012184010.198891-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 8f606a0fc1f80938d5f
X-MBO-RS-META: hwu47sj9xi17mt9yooe8uxe6garh4r1k

On Sun, 2025-10-12 at 11:40 -0700, Alok Tiwari wrote:
> This patch corrects several minor typos and spelling errors in mtip32xx.c
> - Fixing "ge" -> "get" in a warning message.
> - Correcting "kernrel" -> "kernel", "progess" -> "progress"
> =C2=A0 "strucutre" -> "structure" in comments.

btw. I think listing such examples in the commit message for a mere
typo fix patch is a bit overkill; but of course not harmful.

>=20
> no functional impact.
>=20
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Philipp Stanner <phasta@kernel.org>

> ---
> =C2=A0drivers/block/mtip32xx/mtip32xx.c | 8 ++++----
> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/m=
tip32xx.c
> index 567192e371a8..df184a9f006f 100644
> --- a/drivers/block/mtip32xx/mtip32xx.c
> +++ b/drivers/block/mtip32xx/mtip32xx.c
> @@ -1337,7 +1337,7 @@ static int mtip_get_smart_attr(struct mtip_port *po=
rt, unsigned int id,
> =C2=A0	memset(port->smart_buf, 0, ATA_SECT_SIZE);
> =C2=A0	rv =3D mtip_get_smart_data(port, port->smart_buf, port->smart_buf_=
dma);
> =C2=A0	if (rv) {
> -		dev_warn(&port->dd->pdev->dev, "Failed to ge SMART data\n");
> +		dev_warn(&port->dd->pdev->dev, "Failed to get SMART data\n");

One could think of adding a full stop '.'

Although the kernel is quite inconsistent with these anyways.

> =C2=A0		return rv;
> =C2=A0	}
> =C2=A0
> @@ -2127,7 +2127,7 @@ static int mtip_hw_submit_io(struct driver_data *dd=
, struct request *rq,
> =C2=A0/*
> =C2=A0 * Sysfs status dump.
> =C2=A0 *
> - * @dev=C2=A0 Pointer to the device structure, passed by the kernrel.
> + * @dev=C2=A0 Pointer to the device structure, passed by the kernel.
> =C2=A0 * @attr Pointer to the device_attribute structure passed by the ke=
rnel.
> =C2=A0 * @buf=C2=A0 Pointer to the char buffer that will receive the stat=
s info.
> =C2=A0 *
> @@ -2679,7 +2679,7 @@ static int mtip_hw_get_identify(struct driver_data =
*dd)
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> -	/* get write protect progess */
> +	/* get write protect progress */
> =C2=A0	memset(&attr242, 0, sizeof(struct smart_attr));
> =C2=A0	if (mtip_get_smart_attr(dd->port, 242, &attr242))
> =C2=A0		dev_warn(&dd->pdev->dev,
> @@ -3148,7 +3148,7 @@ static int mtip_block_compat_ioctl(struct block_dev=
ice *dev,
> =C2=A0 * that each partition is also 4KB aligned. Non-aligned partitions =
adversely
> =C2=A0 * affects performance.
> =C2=A0 *
> - * @disk Pointer to the gendisk strucutre.
> + * @disk Pointer to the gendisk structure.
> =C2=A0 * @geo Pointer to a hd_geometry structure.
> =C2=A0 *
> =C2=A0 * return value

