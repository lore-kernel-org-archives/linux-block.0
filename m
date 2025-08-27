Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97773342C92;
	Wed, 27 Aug 2025 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302626; cv=none; b=cL4YqtB8W5C6WpTguPXUnukcIxm4s/gNvGMwip+6bEmbvZ7GVwXXp6m0X4yv5bufJA5EYT7FKmJG3fn8BSbtaCInFFqVSi2knjYFQkGV1NAOCHG/GRXgl9X/nrvuO1G7RUThaMjCFCMudaR5GwLiuws4jxAd2fuTrDuCnSrxceo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302626; c=relaxed/simple;
	bh=WNl6MYR9rNqQEB6pJqeDUpDq4nhgXnNkqkm0DWk19LY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gAQuJHjighvefToMMC3MpayRviON0fgL2p575Y1yWt/eRtt13c/KByDBJTKRXbLynOL4q5+BzeOP2iegeL41wM85ag4kubU3Jtq7u4Q9B60wEWhjL4EOdTX2W5MnvbqgajV6ikIv4tDiVvP48W/INH5DrcObvarc83+c8LvTBaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=sY5nVMfX; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sY5nVMfX"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cBmBH2tnvz9ty9;
	Wed, 27 Aug 2025 15:50:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756302615; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xq7djjTrndkPysRUhthmE0pGPVdil1mhiHwibAnEooo=;
	b=sY5nVMfXQvsefqhG5hrlz5fRXu5SfI/+U54PX6DUIm+HWva1miogWC0r1gTz3rhtPFNb8k
	IFUVHitI7m8fF2iz3C5FnWxUF6MYmAdfqD5Q+zjXmUedz53qO1KvKi7geYS7yvh9AcO0gX
	amnil/ELi7sWpxPNV6+W3AE18IcQfIsAT42GZgZ3WjUFs2tPQMn6pojpcSXFyzHgu2OCvK
	Y1K/ySJvrjXSfc5vMAKOZL9h9S8apgDgXhe/Uai++6tMPc1V49BYEibikL3W6rkhwHJhuF
	/phOF95bmJucT1aivDAaJ4ZWwUKCRtrGtaXsJTX5v8/+r/KqDGAu80NOJ1AOtw==
Message-ID: <09ef0b44eef45a534fc3230e9dfaeebb36a08e44.camel@mailbox.org>
Subject: Re: [PATCH v3] block: mtip32xx: Remove excess code in mtip_pci_probe
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Zhang Heng <zhangheng@kylinos.cn>, axboe@kernel.dk, phasta@kernel.org, 
 andriy.shevchenko@linux.intel.com, broonie@kernel.org, lizetao1@huawei.com,
  viro@zeniv.linux.org.uk, fourier.thomas@gmail.com, anuj20.g@samsung.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 27 Aug 2025 15:50:10 +0200
In-Reply-To: <20250827131228.2826678-1-zhangheng@kylinos.cn>
References: <20250827131228.2826678-1-zhangheng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: jmaydpqrntpb93yqagc63dkczaknj4ei
X-MBO-RS-ID: 381079d6b0d0c6983af

On Wed, 2025-08-27 at 21:12 +0800, Zhang Heng wrote:
> In the error exit function of the iomap_err in mtip_pci_probe,
> pci_set_drvdata(pdev, NULL) and return can be removed without
> affecting the code execution
>=20
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>

Reviewed-by: Philipp Stanner <phasta@kernel.org>

> ---
> =C2=A0drivers/block/mtip32xx/mtip32xx.c | 2 --
> =C2=A01 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/m=
tip32xx.c
> index 8fc7761397bd..2c33c1dfc39d 100644
> --- a/drivers/block/mtip32xx/mtip32xx.c
> +++ b/drivers/block/mtip32xx/mtip32xx.c
> @@ -3840,8 +3840,6 @@ static int mtip_pci_probe(struct pci_dev *pdev,
> =C2=A0
> =C2=A0iomap_err:
> =C2=A0	kfree(dd);
> -	pci_set_drvdata(pdev, NULL);
> -	return rv;
> =C2=A0done:
> =C2=A0	return rv;
> =C2=A0}

