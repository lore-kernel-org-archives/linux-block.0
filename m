Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284401C2454;
	Tue, 19 Nov 2024 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021489; cv=none; b=dfbYbDcJYAjEqWLjB4Ve5vhcejmd9fys0ZbXesD0ZnHXqGQCCaIon0SII9NKS+jmZJvJ6Xf5jOaQCkDDGKvr2eDkPC2YPjoBSusmGvEA7TC/Upvl4xha8xVVt0YiQaPGjUsa/zQ5gQdx0IM4ck0PjVh9r1Bzl2bMnznIzAqKosk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021489; c=relaxed/simple;
	bh=o2bE1lyp51mqTvYSaaSyhBEHTu8nWBf6y+S/CWmBbdA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JSyjhNWTMQjgnbpxJ/M5YqxPkUF3SXSIINfkLeWk38SvfTKAIxAOJtKjYJequuaww6Vn7envyThowFhJe2TbGNYfksY3mUcl2ErYZENk3s9sup+noWijh8gRbEXndxY/5RhDoQ3C9Mn6jP4oFr/mO6M1SmBF5pOEEjrT34B9bC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Dfqo9OJT; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Dfqo9OJT"
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 0736112000C;
	Tue, 19 Nov 2024 16:04:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0736112000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1732021485;
	bh=w9LSuyuV6KN/G1woBs4yWRXVCfyMvWei2nHqNYJ4A0g=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=Dfqo9OJTBx1KmdkAIK6AUmlO4oMRfon9Q+l3bW9Qmv3cZ+I1x7NvMeJItU2OWxItO
	 qxLGPgb4GndyYGluocYb+ujLZ6tkz/SBLhu92EUFAeNzpCMNW2ubkjLjoYtsBiOQRm
	 6FmOCf9uRhm8MdD/g/QZra146FlNarEYIPLKxhHw2W2dC5+ezPJqPrKoXsrAT3H8R8
	 16tpx5ZxZ0zHOah84M6ebjgxE0iGt6CasEBNq8nq0e1JfA+nyjfpf1Yg+GrMtwEajg
	 xQfhGHGJQ1u64co0tGDzaSTk1ay8TTbqT2WEZ9oEUIot6owNBKkhk8a7VjqhO0YZwe
	 5XhUXk8QgbzHg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 19 Nov 2024 16:04:44 +0300 (MSK)
From: Alexey Romanov <avromanov@salutedevices.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "minchan@kernel.org" <minchan@kernel.org>, "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"terrelln@fb.com" <terrelln@fb.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 3/3] zram: introduce crypto-api backend
Thread-Topic: [PATCH v1 3/3] zram: introduce crypto-api backend
Thread-Index: AQHbOn5vpe2xVYBCFUWI+YFrosnIsrK+V5QAgAAIU4A=
Date: Tue, 19 Nov 2024 13:04:44 +0000
Message-ID: <20241119130438.3vkopcmnmmwgmxha@cab-wsm-0029881>
References: <20241119122713.3294173-1-avromanov@salutedevices.com>
 <20241119122713.3294173-4-avromanov@salutedevices.com>
 <ZzyF7PAoII0E5Vf5@infradead.org>
In-Reply-To: <ZzyF7PAoII0E5Vf5@infradead.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FA43A415B2A1D4478ABD0A14A4F0256B@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189267 [Nov 19 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/19 08:41:00 #26886618
X-KSMG-AntiVirus-Status: Clean, skipped

Hi Christoph,

On Tue, Nov 19, 2024 at 04:34:52AM -0800, Christoph Hellwig wrote:
> On Tue, Nov 19, 2024 at 03:27:13PM +0300, Alexey Romanov wrote:
> > Since we use custom backend implementation, we remove the ability
> > for users to use algorithms from crypto backend. This breaks
> > backward compatibility, user doesn't necessarily use one of the
> > algorithms from "custom" backends defined in zram folder.
> > For example, he can use some driver with hardware compression support.
> >=20
> > This patch adds opinion to enable Crypto API: add ZRAM_BACKEND_CRYPTO_A=
PI.
> > Option is enabled by default, because in previously version of ZRAM
> > it was possible to choose any alogirthm using Crypto API. This is
> > also done for backward compatibility purposes.
>=20
> Which crypto API algorithm do you care about?  You should probably
> just add a backend for that instead of a double indirection.
>=20

Should I create backend_*.c file for every compression algo driver?
Okay, there aren't many of them now. But what will do, for example,
when there will be 250 such compression drivers?

And also your approach doesn't allow working with loadable modules.
For example, we may have only binary module (without sources) from
vendor SDK that provieds a driver for data compression.=20

This is an even bigger problem.

--=20
Thank you,
Alexey=
