Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713263;
	b=iefVM/aNl8Rzwz5ODnX/fiB+lY+qK1otS5G/FvsyQgtNGnvnuBO6mUmTLa/yXLioIAAQ
	 xbOLpHEkRCvqwrIabqth01IArMxlInx8DEt7qXsYPNmaUb/Fg3akVgJgrwBPkmjvpZz3C
	 xuwlA6v1+9lkTrkmemC/XDrYYv3QkP61y/3W7ll79WFyrNZX0DWoAmCcD6QNvuo2iSGz0
	 pVwB5HDqQo9RyB6eDJKm+wGyK+z0b6ufL5FhPICW+If9oXCuBKsLypRQLzGv0TgIEebzk
	 ihmEawBirDvVXz+nhbVUhAKjE5iEy10uZJlzWSJKjr1of3z1puNqRaSYOzVv3X3W0oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713263;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-MBO-RS-ID:X-MBO-RS-META;
	bh=DJlGLqyr7qaLFG04KI8kVedddj4Vea+yaqBKGFZW6fY=;
	b=khZGtgTKa0R7jK3EsKemI8bk5QmCAWC1p3rb/PZ/PmRu5/IDeIYZLWguJ7Vm5T0vXCD/
	 duOwtXZbD/XVg8YYulky+fKJlZ+wJlG3MIMo7UmhG916vOhbyB6yuf6ers4P16Fih/Gue
	 qDFCM9HQeD+JdNojVe+mOK6BlNR0TTcyaEqweJFGvKiaHgLHYvug3PdboWrp1oz6tFYU2
	 LliIxKu/SET38L5qlid5tBLv/3K7StuCYsyluitXf/JwVVm9OEDDB2QdtSleynGbS8W9t
	 Mv4arLM4y4FOnre4OhxBCK1HT/ft5X7v2dZ34+bJQBVAan974GZt8ZE/a3a7EAuxXFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=TJ21vDI+;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A00606A326
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 13:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00A00606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=TJ21vDI+
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jJqTk2KTlz8v2F;
	Tue, 03 Nov 2026 14:40:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793713258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJlGLqyr7qaLFG04KI8kVedddj4Vea+yaqBKGFZW6fY=;
	b=TJ21vDI+pdiZ5y6bPAKJ/4XhwsMbo3Nvr4GqdCGuijuOfX9334roia4iNFD2y7pejfkH3w
	kTDr3OikDnYfQ8ZoopI41IubaEOsxvBzLlGZJ4gLSmrOcmPd1DH11cfTPAKk1VuC3wJ8Ji
	lZEhUYmcop/kYiD0iEY/3CZU7V/5O71ymNB1q9TTZjXsk7aEyKLprHnHwgfv+RAarPLpvH
	IbV8jxlwAJwYcjoWtK8d4mLTvRkuUtJQQ9wZ0ZXPIN1+zxd1BK8FCDtYEbEkIlPHQa+TTi
	MAiWG/KrDU4ECtGcb3yJyS8V0q8zqB1XZdTAMqxRC23z00GxhVjMJXxi8kNkUA==
Message-ID: <d57ee45e25cd429372298b1481a58c232d052569.camel@mailbox.org>
Subject: Re: [PATCH 1/1] cdrom: fix brackets
From: Manuel Ebner <manuelebner@mailbox.org>
To: Phillip Potter <phil@philpotter.co.uk>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Date: Tue, 03 Nov 2026 14:40:56 +0100
In-Reply-To: <20260902183723.1584-2-phil@philpotter.co.uk>
References: <20260902183723.1584-1-phil@philpotter.co.uk>
	 <20260902183723.1584-2-phil@philpotter.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MBO-RS-ID: f7b59ce7afe9ae0eb40
X-MBO-RS-META: qjdbmp4qaj3prpj7ej5w971n8g8qbhhb

On Wed, 2026-09-02 at 19:37 +0100, Phillip Potter wrote:
> From: Manuel Ebner <manuelebner@mailbox.org>
>=20
> Fix missing ')' and add '()' to function.
>=20
> Fixes: e327cfcb2542 ("docs: cdrom-standard.tex: convert from LaTeX to ReS=
T")
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Can I do something to get this applied?

Thanks
 Manuel

> ---
> =C2=A0Documentation/cdrom/cdrom-standard.rst | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/cdrom/cdrom-standard.rst b/Documentation/cdrom=
/cdrom-standard.rst
> index b97a4e9b9bd3..b6dde1d1eaaa 100644
> --- a/Documentation/cdrom/cdrom-standard.rst
> +++ b/Documentation/cdrom/cdrom-standard.rst
> @@ -1014,7 +1014,7 @@ How to update your driver
> =C2=A0=C2=A0 just calls to the routines you adapted in the previous step.
> =C2=A0- You may remove all remaining memory checking code in the
> =C2=A0=C2=A0 *audio_ioctl()* function that deals with audio commands (the=
se are
> -=C2=A0 listed in the second part of cdrom_ioctl_. There is no
> +=C2=A0 listed in the second part of cdrom_ioctl()). There is no
> =C2=A0=C2=A0 need for memory allocation either, so most *case*s in the *s=
witch*
> =C2=A0=C2=A0 statement look similar to::
> =C2=A0
