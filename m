Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FC12E973E;
	Mon, 25 Aug 2025 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121609; cv=none; b=Z58l+ti3JHCLVjq5DwDFgcZa2ACX5ReZUd2XU0skjFxlZvY5LBhYfGVmdOVzXRMLkaMDbfOwMnUMgudUO+eNg5yZiFylyM52H1AoQ4/PX+c/oXkhz43sH9W5FLAj9lprCUiacOYFwhcSg0QUTgb8MhBMX2gwuP9ItCjI4UfuKs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121609; c=relaxed/simple;
	bh=eEtIaibKqKdPr4YrsIFVAnudVNi9K3ryFlvOQIzI4AU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qeNk7j8NdhSuNFfc7vlAkOGiYaPaPPZ0CbDJhmg7yhLbzjNFSJXFvi5Q3pC8wzmdI7M0PymiLdB78jcsB+MQZbafpRe2ISUjCZrHl59MmIYF0dM3dtdunqeQZRBkYtqQ2zfHNKo1tvMJE9e6fZr3kZ/64u0lY+AF8luKITP0O/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xx5f5TIc; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xx5f5TIc"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c9TFH1pXdz9tQL;
	Mon, 25 Aug 2025 13:33:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756121603; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNSSCPeGqN6zjA3VkCq993OovPyznVI5qQSB6QgIYew=;
	b=xx5f5TIcNOek4XsyREHU8dpczmFGQcYDQ9vVhKY0A4XV4Zzf0NtX/q5nSrWVbQsKBLECyE
	mkGB6kXz6WTHD8wN171TjBFgSlScZ3GJ2NQvvXSN6EE5iB1OZq7aQ3q+AXXrRR+aVP9wgr
	Cpo134VBWG4/mcMvREeIVexlQ1HqoNutWWwScRfuc+2Nh6yx4yKicTb0yvUIa9Jbn9z4+e
	xKXNsUob0JULzs/V5vFyRrfaxmeeZzCNi24LIKWBp3P0W6p/z41R49MFQooPgvtiHtf1iM
	W/BjPt+4mbtfJwaZ4Kuued0TK8HJtMOxIaTFxaECwtkfja+HqW7GsvdBNXzc+g==
Message-ID: <ab3196a1e0ccb8f94eafb83de589c0ae8f82d598.camel@mailbox.org>
Subject: Re: [PATCH v2] block: mtip32xx: Prioritize state cleanup over
 memory freeing in the mtip_pci_probe error path.
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Zhang Heng <zhangheng@kylinos.cn>, axboe@kernel.dk, phasta@kernel.org, 
 andriy.shevchenko@linux.intel.com, broonie@kernel.org, lizetao1@huawei.com,
  viro@zeniv.linux.org.uk, fourier.thomas@gmail.com, anuj20.g@samsung.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 25 Aug 2025 13:33:17 +0200
In-Reply-To: <20250823083222.3137817-1-zhangheng@kylinos.cn>
References: <20250823083222.3137817-1-zhangheng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: f202200c8dda11aa72e
X-MBO-RS-META: pray9abyjp7i4pz3qhweyh49jf4yeb7y

On Sat, 2025-08-23 at 16:32 +0800, Zhang Heng wrote:
> The original sequence kfree(dd); pci_set_drvdata(pdev, NULL); creates a
> theoretical race condition window. Between these two calls, the pci_dev
> structure retains a dangling pointer to the already-freed device private
> data (dd). Any concurrent access to the drvdata (e.g., from an interrupt
> handler or an unexpected call to remove) would lead to a use-after-free
> kernel oops.

I tend to disagree I think . This is the driver's probe() function. It
is always invoked serially by the driver core.

remove() cannot be called while probe() is still running.

Thus, the only potential explosion that could happen would be if an
interrupt handler were to be set up in this probe() and then accesses
dd.

However, if that were the case, everything would be exploding already
because there is no place in the code that tears down that interrupt
handler or other potential parallel accessors before kfree(dd) is
called.

In this case, the relevant call is pci_enable_msi(). Sooner errors,
like iomap_err: are jumped to before that's the case. Which is the only
sane design for probe() anyways. Otherwise, pci_disable_msi() switches
that off again; IOW: there are no racers.

So I think that the pci_set_drvdata(=E2=80=A6 NULL) can be removed
alltogether.=C2=A0

When working on the probe() / remove() paths last and this year, I came
to believe that calls like that were often used because of a
misunderstanding of how the driver core APIs work.


P.


>=20
> Changes made:
> 1. `pci_set_drvdata(pdev, NULL);` - First, atomically sever the link
> from the pci_dev.
> 2. `kfree(dd);` - Then, safely free the private memory.
>=20
> This ensures the kernel state is always consistent before resources
> are released, adhering to defensive programming principles.
>=20
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
> ---
> =C2=A0drivers/block/mtip32xx/mtip32xx.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/m=
tip32xx.c
> index 8fc7761397bd..f228363e6b1c 100644
> --- a/drivers/block/mtip32xx/mtip32xx.c
> +++ b/drivers/block/mtip32xx/mtip32xx.c
> @@ -3839,9 +3839,8 @@ static int mtip_pci_probe(struct pci_dev *pdev,
> =C2=A0	}
> =C2=A0
> =C2=A0iomap_err:
> -	kfree(dd);
> =C2=A0	pci_set_drvdata(pdev, NULL);
> -	return rv;
> +	kfree(dd);
> =C2=A0done:
> =C2=A0	return rv;
> =C2=A0}

