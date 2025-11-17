Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840A93246E6
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763373407; cv=none; b=eebZvJbneC/8NBgoVNow23KjJbQopWVs3pnGo2tBxzvWxfcCcG5WuFmL61xNDyGUgKCS+DH2fsGb06ERd1F68pAhCRgPJ3UYc6aDW/SnGCnxjcx+AAsXK09ezxkLJ3bMOPr9y34DErYlnwNFNSBZmzZ1oMNlaLoAUrzQPL0vcOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763373407; c=relaxed/simple;
	bh=u7U/U9/cUI3hshOC5lSKy+eUpS0XJRL/yT8+ajeFbfw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mIB9aBkunFbLb8uAN1XUZrUt118jmyLNAqohX37FFpU5lRiW7+IpyHmGcqkqLz6v/BRwyJRF+N5BSruhCbT2MCyTUbR1BF697zQG3p2u3BjdqOafr09sYaG8ud1e+YqSrBfhM66mxSRPjPWpAlOnYWya69atANAVS6DI+pmeZt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=wiO0/Ebk; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="wiO0/Ebk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To
	:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=k2f3j71BNrxJPRPjOJNmgb3Ao7lLQB6cOVK5xMoEYsU=; b=wiO0/Ebk4YFhyF7YJ6Fo5mMFCk
	dNCU75YCuCED70S+Dbjb/EIYcBBYLCxiWp2bawVpScC8xo7NyOzIn1jUX8HsN+dEQgbbz+OSMlrsi
	Eth5v/CnHEHoqN4vHC5XuefAfqPrbSnk4SoZwes5eYYOLcOFJLaijhy34HBGgYJ5M9VVrp9zOy5nj
	+mboaTSr1mq8XgC4uRl3SvRmy5pFgh2JeLr+l+rpUK9TDilT7dFoR8Ge6Xj/OgQjifXFQXh8UpOHI
	eZj41Jg35GJyifW1WbWH0jY6w/me9i1mw8akAw/RC1cVaSV+OK8++u2WS9DscOy9liH/8VodERhni
	fVH3xecA==;
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] fix floppy for PAGE_SIZE != 4KB
From: =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
In-Reply-To: <20251114.192119.1776060250519701367.rene@exactco.de>
Date: Mon, 17 Nov 2025 10:56:39 +0100
Cc: linux-block@vger.kernel.org,
 efremov@linux.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <708B7962-86CD-489B-AC33-4B929F2902B6@exactco.de>
References: <b1e17016-3d4d-4fac-b5b0-97db357d0749@kernel.dk>
 <20251114.172543.20704181754788128.rene@exactco.de>
 <fec67c88-53f5-4482-aeef-86e1213d187e@kernel.dk>
 <20251114.192119.1776060250519701367.rene@exactco.de>
To: axboe@kernel.dk
X-Mailer: Apple Mail (2.3826.400.131.1.6)

Hi,

>> 64k is 4% of a floppy disk! But I hear you, works for you.
>=20
> Again, still only 8k or 16k for most of such remaining workstation
> floppy users.
>=20
>>> But if someone wants to refactor this code some more, ... I'm happy =
to
>>> test it, too ;-)
>>=20
>> I don't think refactoring would be required here, it's probably just
>> capping that probe read to something constant irrespective of =
hardware
>> page sizes.
>=20
> Well, the floppy.c __floppy_read_block_0 does:
>        bio_init(&bio, bdev, &bio_vec, 1, REQ_OP_READ);
>        __bio_add_page(&bio, page, block_size(bdev), 0);
>=20
> Is there an easy way to limit that to less than a page without
> refactoring it too much? Otherwise we could just apply this hotfix for
> now.


Any chance we can get my initial one liner constant PAGE_SIZE fix
for this over a decade old bug in? I currently don=E2=80=99t have a =
budget
to refactor the floppy driver probing for efficiency on bigger PAGE_SIZE
configs I=E2=80=99m not even having a floppy controller on.

Thanks!

	Ren=C3=A9

--=20
 Ren=C3=A9 Rebe, ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 https://exactco.de | https://t2linux.com | https://rene.rebe.de=
