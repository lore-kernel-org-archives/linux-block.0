Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [46.4.70.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A072580CB
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.70.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747722698; cv=none; b=BT+yj0S+5sc8PjrbnPKLmBVdz7Mi66Ru9IR2r8qpfask5IJdExW1f97Cygt/QP2EkQIgJkk8UyfnOFjUCfUy2o9M5gyiXWQCbvgXOLiFm/91pitrWmmPGVGq3gT/APWzEa3DMoudzT6zs0bOCnxZkDPPwa+1B0RnCvnDGeaY6hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747722698; c=relaxed/simple;
	bh=d0nAGsYw2R6FLg5r2h36rVVt8q36cToCdrm+N3mMMFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7Dfk5zUqGtsCVVYBCMKho7OLzDxW3pgLEwFTZtioSwpFMh3VGFvTLlY8TJirJX91IJPpi3T7Xirsce9HCqGtTKStR833tKrcIf/tsn17OjIhS7uePVU+XRccYWW+xNgVxlcO+AjYwI4kp58zSCXgJ9c/UEVc4lOp2Z8ourFsBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eworm.de; spf=pass smtp.mailfrom=eworm.de; arc=none smtp.client-ip=46.4.70.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eworm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eworm.de
Received: from leda.eworm.net (unknown [194.36.25.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id 77E6225AA38;
	Tue, 20 May 2025 08:31:34 +0200 (CEST)
Authentication-Results: mx.mylinuxtime.de;
	auth=pass smtp.auth=mail@eworm.de smtp.mailfrom=mail@eworm.de
Date: Tue, 20 May 2025 08:31:33 +0200
From: Christian Hesse <mail@eworm.de>
To: "Xu, Lizhi" <Lizhi.Xu@windriver.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "christian@heusel.eu"
 <christian@heusel.eu>, "hch@infradead.org" <hch@infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com"
 <syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>,
 "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: =?UTF-8?B?5Zue5aSNOg==?= [PATCH V5] loop: Add sanity check for
 read/write_iter
Message-ID: <20250520083133.0683bdda@leda.eworm.net>
In-Reply-To: <BL1PR11MB5979C666DA3BC228C2C30E92869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
References: <20250519175640.2fcac001@leda.eworm.net>
	<20250520030051.177205-1-lizhi.xu@windriver.com>
	<20250520073901.6fdfbee4@leda.eworm.net>
	<BL1PR11MB5979C666DA3BC228C2C30E92869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yM+n6Brr1lK6Aa0/ksIAfQn";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spamd-Bar: /
X-Spamd-Result: default: False [0.00 / 15.00];
	TAGGED_RCPT(0.00)[6af973a3b8dfd2faefdc]
X-Rspamd-Server: mx
X-Rspamd-Queue-Id: 77E6225AA38
X-Stat-Signature: k3m653n37d5ritghdgb1iub49hbdnpy3
X-Rspamd-Action: no action

--Sig_/yM+n6Brr1lK6Aa0/ksIAfQn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

"Xu, Lizhi" <Lizhi.Xu@windriver.com> on Tue, 2025/05/20 06:29:
> I figured out your steps to reproduce, and yes, this problem will occur if
> you do losetup with a file in a filesystem that does not support read_ite=
r,
> which is what this patch does.

So is this expected behavior now?

It worked before... How to recover for our use case?
--=20
Best regards,
Chris

--Sig_/yM+n6Brr1lK6Aa0/ksIAfQn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSmOl3fryo2Nzt8CpJOj8ol/axIVQUCaCwhxQAKCRBOj8ol/axI
VTLGAQD5EXUGIGmsUkbCqYtfvroxPldCPKOGk9O0D8iX2o630QD/WlgL5yfMuDEx
eAjCgtwuMo9XCkPCe/0Qx4mCExmgbQE=
=oF/4
-----END PGP SIGNATURE-----

--Sig_/yM+n6Brr1lK6Aa0/ksIAfQn--
