Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [46.4.70.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD4425A33F
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.70.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747722882; cv=none; b=i8iq4dAk6F/u1yD0P1VREbDUW5JV5EbgbVUi2AGf/4nCxa//mPYz0alSPTrrvzhr1ocWfHtjjCr4ko/jfMIZ7RHFpwn3rlYTjrxJN7ve9SwDSn6/b3E0ZD7UrU3gZh8tn3VBISSEWHFHimTvWQypC+6R8UqowCi2/gBCNuhZOkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747722882; c=relaxed/simple;
	bh=2RUinEL1Eq5U6TvPMd7m9XAO3DZWMF0UfUS5bEdGUL0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdaUZi086XH559J71TNDGd9fGm7SYMv1mX13t2/yAU8/UbJ55Sy3wvosPWpqup4udckfTCWyyPl3ZXf9UI6rqkJ8JapKLJM2m1hDdqYzuifoeYeiqsjuiYA6fD2B1KWXx9mzNgPVWN7rxQuEinnrGAsrn1GnCVE1zzhqp3dJ3eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eworm.de; spf=pass smtp.mailfrom=eworm.de; arc=none smtp.client-ip=46.4.70.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eworm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eworm.de
Received: from leda.eworm.net (unknown [194.36.25.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id CFC1C25AAFF;
	Tue, 20 May 2025 08:34:38 +0200 (CEST)
Authentication-Results: mx.mylinuxtime.de;
	auth=pass smtp.auth=mail@eworm.de smtp.mailfrom=list@eworm.de
Date: Tue, 20 May 2025 08:34:38 +0200
From: Christian Hesse <list@eworm.de>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Roland Clobus <rclobus@rclobus.nl>, Lizhi Xu <lizhi.xu@windriver.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 1106070@bugs.debian.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: [6.12.y regression] loosetup: failed to set up loop device:
 Invalid argument after 184b147b9f7f ("loop: Add sanity check for
 read/write_iter")
Message-ID: <20250520083438.295e415a@leda.eworm.net>
In-Reply-To: <aCwZy6leWNvr7EMd@eldamar.lan>
References: <3a333f27-6810-4313-8910-485df652e897@rclobus.nl>
	<aCwZy6leWNvr7EMd@eldamar.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pHHCVVO63xn3l9rY3DXDkq1";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spamd-Bar: /
X-Spamd-Result: default: False [0.00 / 15.00]
X-Rspamd-Server: mx
X-Rspamd-Queue-Id: CFC1C25AAFF
X-Stat-Signature: tto66ciskyy4jxzcwht5ucfkrgp8hxhr
X-Rspamd-Action: no action

--Sig_/pHHCVVO63xn3l9rY3DXDkq1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Salvatore Bonaccorso <carnil@debian.org> on Tue, 2025/05/20 07:57:
> In Debian Roland Clobus reported a regression with setting up loop
> devices from a backing squashfs file lying on read-only mounted target
> directory from a iso.
>=20
> The original report is at:
> https://bugs.debian.org/1106070

We are suffering the same for Arch Linux. Already reported here:

https://lore.kernel.org/all/20250519175640.2fcac001@leda.eworm.net/
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/pHHCVVO63xn3l9rY3DXDkq1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAmgsIn4ACgkQiUUh18yA
9HYgZAgA4bNSTczRx+NihDV8Xfx3/KM7eGuNVbcIFhiXgm6AnWmqrobyQQU3vygo
79dKyAXYTmB7dxGDOkmMv5JiqJ3yzOUNx4gX6OlAoX9ZlLA7PUrqBcPvLyAhrhvd
0VR5wSwLOsBo4ujSlR0wQNTc03UwtIRm+t6gdTrqAGBhe7yJNMYCutvwuqEe67wH
pMszcc7rOHNM8h/2//xz6uyIK1whIO1DU4hsvbZiGMcayKZnNeClGB4JdCZDwaH6
M6Dpv5aZ05JySqPg1eQvXA/QR6VWPNjoj/J9Ph2yAcx5gQ8bwS3quyhjETOajgad
5ACdS83Ua+gZs3Iy8M1Pb0a+JxmsvA==
=Hr/4
-----END PGP SIGNATURE-----

--Sig_/pHHCVVO63xn3l9rY3DXDkq1--
