Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BA31D041B;
	Thu, 21 Nov 2024 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732191109; cv=none; b=dWRqYxA1F2LuLVLHvl9b/kDX4YdexvhTSQUOaewojL/PiNu5NhwlbTrPKfjEhNfPIQwtx15lgssw9CNoFC/1Ykf6RhLg9P4jAXFbaYeQu38jJUVs9Io2QpNkbJykZRBHS60Dpj4YkUEraSZm1DA2MgrItXQ1LMoq7rtRtJPcxSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732191109; c=relaxed/simple;
	bh=wQ9OpX335ixfUj8FEv2+T/bYoEUXVSavSukXE42175s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lHHqTO6Us1nVhyXHPwapUnv/qrIC4tzGM+4rsfn7cwWZfdVD3mbV3bFenTurRvLw1XztClKPdqW20V8w7wcu0s7TlvqYvsi2EJfV9bdZ6JGQfcopDfo3orHausWsTTNJiWPBpeEAIfWmtkCcO7jl0wCc+cVOqwIx+TnBDjfwuOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=FRSSjgM8; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="FRSSjgM8"
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id DB54412000F;
	Thu, 21 Nov 2024 15:11:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru DB54412000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1732191085;
	bh=J4W2mJXLjt28JulEEpFJn6JFqKuZowV4q6kYlMnsiRQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=FRSSjgM8Rn/theZ99aPKMADnssoVEl6KXXmgIfH6pOfn6cbLrDiKuYscmhlmUSn2Z
	 ahggGbDgq7tf7e1N+viZIj+piwGzyGATmxg08yS6uyOQrPaOuy+NVHzlB0joT8GfdL
	 GbPrz0F7d5mOn0lVJEdbGYjS0eHARj9dlK02ygHrPYl/2Mx4HwPPEoUTD3y0pB864Q
	 4nTllgk2ldQpfI7ndiecR0yENPM73lKnrMhLIpLOpsUoGAcUoM1ggUQYv3/1N21eJ7
	 8+91+pbC5rWVjhLwBYLC5xh3KlknCbTGamb9gJhJcZEq9PgomlC86ej8FYWNUkeCSd
	 axmxwf0UP8PtQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 21 Nov 2024 15:11:25 +0300 (MSK)
From: Alexey Romanov <avromanov@salutedevices.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: "minchan@kernel.org" <minchan@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "terrelln@fb.com" <terrelln@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] zram: introduce crypto-backend api
Thread-Topic: [PATCH v1 0/3] zram: introduce crypto-backend api
Thread-Index: AQHbOn5tER/mherIIkCwEQstBnX117K/TZ+AgAIoDAA=
Date: Thu, 21 Nov 2024 12:11:24 +0000
Message-ID: <20241121121120.ch4qbmbiuje2cjog@cab-wsm-0029881.sigma.sbrf.ru>
References: <20241119122713.3294173-1-avromanov@salutedevices.com>
 <20241120031529.GD2668855@google.com>
In-Reply-To: <20241120031529.GD2668855@google.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <06ACB912F633C14F809BD685F34F5543@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189328 [Nov 21 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 42 0.3.42 bec10d90a7a48fa5da8c590feab6ebd7732fec6b, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;cab-wsm-0029881.sigma.sbrf.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/21 09:49:00 #26878913
X-KSMG-AntiVirus-Status: Clean, skipped

Hi Sergey,

On Wed, Nov 20, 2024 at 12:15:29PM +0900, Sergey Senozhatsky wrote:
> On (24/11/19 15:27), Alexey Romanov wrote:
> > Since we use custom backend implementation, we remove the ability
> > for users to use algorithms from crypto backend. This breaks
> > backward compatibility, user doesn't necessarily use one of the
> > algorithms from "custom" backends defined in zram folder.
>=20
> Sorry, no, we are not adding this for a hypothetical scenario.
>=20
> > For example, he can use some driver with hardware compression support.
>=20
> Such as?  Pretty much all H/W compression modules (I'm aware of)
> that people use with zram are out-of-tree.

At least we have this:

drivers/crypto/nx/nx-common-powernv.c:1043:    .cra_flags        =3D CRYPTO=
_ALG_TYPE_COMPRESS,
drivers/crypto/nx/nx-common-pseries.c:1020:    .cra_flags        =3D CRYPTO=
_ALG_TYPE_COMPRESS,
drivers/crypto/cavium/zip/zip_main.c:377:    .cra_flags        =3D CRYPTO_A=
LG_TYPE_COMPRESS,
drivers/crypto/cavium/zip/zip_main.c:392:    .cra_flags        =3D CRYPTO_A=
LG_TYPE_COMPRESS,

Anyway, if we want to completely abandon Crypto API, these modules
still need to be supported in zram.

--=20
Thank you,
Alexey=
