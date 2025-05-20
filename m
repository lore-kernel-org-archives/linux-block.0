Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [46.4.70.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B1B2550A6
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 05:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.70.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747719547; cv=none; b=o3Z25tnT0EBCI0vnDyzQO/ahmzA3EGAjQavq1HumVCMdQofnobgz4aweF4ziwlJgTS6YVSZYXdy/OkdLZDID/eI783IjeCvgTGlhiV8R5a/EmRdEyz/gin2OIyyHIB4Zgx0CuzbJGf5/fZYtTYA1zvpE/a+IW+Lt/txvQWJQf3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747719547; c=relaxed/simple;
	bh=TZ1bau13uMjZ3xmEGXPxBrb/T6qFcnWWPccxnkdxN8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bu9rRcWGOXeCVSkxIa6G8ArpPS630YujzS4nhtJM44vzxGAsUCLrsVgHe/7Fm+QQoaoLB+pcLYWufti0x8dxazflZg7/cn8/Je6SLiyn/JZNl1/8TmKBKjinv1mxJs2UJFaDZAqzqB7XwFnXmRxQ6+HsYoeKAzlSJ8MaSCfp7k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eworm.de; spf=pass smtp.mailfrom=eworm.de; arc=none smtp.client-ip=46.4.70.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eworm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eworm.de
Received: from leda.eworm.net (unknown [194.36.25.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id 59BC425A2AB;
	Tue, 20 May 2025 07:39:02 +0200 (CEST)
Authentication-Results: mx.mylinuxtime.de;
	auth=pass smtp.auth=mail@eworm.de smtp.mailfrom=mail@eworm.de
Date: Tue, 20 May 2025 07:39:01 +0200
From: Christian Hesse <mail@eworm.de>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: <axboe@kernel.dk>, <christian@heusel.eu>, <hch@infradead.org>,
 <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <ming.lei@redhat.com>,
 <syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>,
 <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH V5] loop: Add sanity check for read/write_iter
Message-ID: <20250520073901.6fdfbee4@leda.eworm.net>
In-Reply-To: <20250520030051.177205-1-lizhi.xu@windriver.com>
References: <20250519175640.2fcac001@leda.eworm.net>
	<20250520030051.177205-1-lizhi.xu@windriver.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fNst24p=Np=ldSTs/mAULnQ";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spamd-Bar: /
X-Spamd-Result: default: False [0.00 / 15.00];
	TAGGED_RCPT(0.00)[6af973a3b8dfd2faefdc]
X-Rspamd-Server: mx
X-Rspamd-Queue-Id: 59BC425A2AB
X-Stat-Signature: khw1e6gszj3qiaabzf4ok9wsrhekzrg3
X-Rspamd-Action: no action

--Sig_/fNst24p=Np=ldSTs/mAULnQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Lizhi Xu <lizhi.xu@windriver.com> on Tue, 2025/05/20 11:00:
> On Mon, 19 May 2025 17:56:40 +0200, Christian Hesse wrote:
> > $ losetup --find --show --read-only --
> > /run/archiso/bootmnt/arch/x86_64/airootfs.sfs losetup:
> > /run/archiso/bootmnt/arch/x86_64/airootfs.sfs: failed to set up loop
> > device: Invalid argument
>
> I tried to reproduce the problem you mentioned using the kernel containing
> "commit:f5c84eff", but failed to reproduce it.
> The complete reproduction steps are as follows:
>=20
> sudo apt install squashfs-tools debootstrap
> sudo debootstrap --arch=3Damd64 focal rootfs http://archive.ubuntu.com/ub=
untu/
> sudo mksquashfs rootfs rootfs.sfs -comp xz -e boot
> [...]

That's the wrong end of the stack. After all squashfs is not directly
involved here (that was just an etxra info on why we have a loopback file
inside iso9660).

The issue is setting up the loopback file inside a mounted iso9660 filesyst=
em.
Take these steps for easy reproduction:

root@leda ~ # mkdir iso.d=20
root@leda ~ # truncate -s 10m iso.d/loopback.img
root@leda ~ # mkisofs -o iso.iso iso.d/
Setting input-charset to 'UTF-8' from locale.
 94,75% done, estimate finish Tue May 20 07:34:52 2025
Total translation table size: 0
Total rockridge attributes bytes: 0
Total directory bytes: 0
Path table size(bytes): 10
Max brk space used 0
5294 extents written (10 MB)
root@leda ~ # mount -o loop iso.iso /mnt/tmp=20
mount: /mnt/tmp: WARNING: source write-protected, mounted read-only.
root@leda ~ # losetup --find --show --read-only -- /mnt/tmp/loopback.img=20
losetup: /mnt/tmp/loopback.img: failed to set up loop device: Invalid argum=
ent

Hope that helps, let me know if you need more assistance.
--=20
Best regards,
Chris

--Sig_/fNst24p=Np=ldSTs/mAULnQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iHQEARYKAB0WIQSmOl3fryo2Nzt8CpJOj8ol/axIVQUCaCwVdQAKCRBOj8ol/axI
VYovAPjB5lx5KHvbGNCKPXj0KVsTHSS0n7UJ8OGO7WP5FGhkAQD34BN4l3pHwARk
Z0ZeskSgLWuMZigIxE3Cqty8uJg8BA==
=ehv3
-----END PGP SIGNATURE-----

--Sig_/fNst24p=Np=ldSTs/mAULnQ--
