Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1B03DB96F;
	Thu, 25 Jun 2026 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389946; cv=none; b=Ij5CypdyNf0TcMvn8uP1Hvu4PmBdGoVAkapz63Dm7RNRa+JCigVPOcAWGDG0KRa/JhxYpLtkxjLF2G4ftwTPRjSxUsJ1OB+ZXUYrRMNXDj6zFihpwYuHLVda6e2OMzkdbq9k3CVN2XHaCJBZQCxdFoMdIZp8+WRTcqOaO6DSpQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389946; c=relaxed/simple;
	bh=YGfnZSF2L9tt7N+xexgIcZv37UPrUpbAlOK6gTrzk+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Deomd4yEoJFHU9Se4SHEv5lQgoE0Sns5/pr6X5v4J5eNpMZM9aGNMOeJrd7e+Wvo/JQcEkVrcFMkqin9jq+qKL0qLj/2Eff/l5mH3rtbQ6JYDFSuIeeujDjFWnyb+jw4/V9aIIKBDc3SNfQdW5GV5V13s3Vm2aP3S41UxyqvmLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dDkeDbrB; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dDkeDbrB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782389933; x=1782994733; i=markus.elfring@web.de;
	bh=fKvFXoIIcDzbDBY1hudCeg/fybvIRrMl4gUMghbCJmo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dDkeDbrB95f4rgZm0pbNKFmvgpRcHMHI4nxPgmHtSMk7f6MgIdthGcSDrlWFP7MZ
	 BKkkXtlVMu0STnp2SQlKd0TnhzI/VZN8mnzwUGKgxInIbMB+rUuu9JGFRYCTUNfk0
	 J157OzeDrIMXaAtyt0oeOKVnIIoLgaJh+hqn1JXz8RxFMt3JP4ghHfHJWHezA17cr
	 sWNer0mVIdw1WkIOIPO+dTtHZY238tczgFp2yXdmHTAu12TRWO81WbWEH9V2/dhsb
	 JEzqQxVJR2hCnTYaQKVD7sHD4t+CwFJihdUuG/VopHh6WQV1p3HPCLXDyNPuckuam
	 5BUzqlnvvcS0sHpfBQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlbHC-1x3qa92ZTW-00abOX; Thu, 25
 Jun 2026 14:18:51 +0200
Message-ID: <7de415a7-457d-4dd2-aebb-8e179fa0bbcd@web.de>
Date: Thu, 25 Jun 2026 14:18:49 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: partitions: Use seq_buf_putc() in
 cmdline_partition()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Josh Law <objecting@objecting.org>,
 Kees Cook <kees@kernel.org>,
 Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <59dfd2ef-2fda-4dd0-a288-52c35613e778@web.de>
 <ajzkRM_RFKBpp0i5@ashevche-desk.local>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ajzkRM_RFKBpp0i5@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hCOxyJHYmLBy8V/y3wFubKi2VpkC5Cycv260abTMrb8lUuxzXzh
 6rsgFRdZPYMPf3ii98DAHLxwAi97jIPCvvF3DQUEBYa8hQqPYqAa6lPb/A91TqhjHk+Y/it
 YswBA8W9sjqEgYeMU64PAPvyFBiciXbDc5WPPKTrTpKS+htaOpcvbQMrE7REwdPrupXrif4
 wgIg3ar36fxknJkGRNhSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dLv7t00YHSQ=;OWf1yoEjI2PHOIv/YPLmAygnCSe
 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
 lDS4030OzVVPerGZPww4tISttVo=

>=20
>>  	cmdline_parts_set(parts, disk_size, state);
>>  	cmdline_parts_verifier(1, state);
>=20
>> -
>> -	seq_buf_puts(&state->pp_buf, "\n");
>> -
>> +	seq_buf_putc(&state->pp_buf, '\n');
>=20
> Why did you remove blank lines?
>=20
>>  	return 1;
I imagine that this source code place can become a bit more succinct.

See also:
efi_partition()
https://elixir.bootlin.com/linux/v7.1.1/source/block/partitions/efi.c#L694=
-L756

Do you insist to preserve two blank lines here?

Regards,
Markus
