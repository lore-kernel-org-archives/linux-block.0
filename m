Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [46.4.70.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A270286896
	for <linux-block@vger.kernel.org>; Mon, 19 May 2025 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.70.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670626; cv=none; b=iuSeLMov5ErAKmxqaB3W3V1fRg0E7ROImSMrFtwEAC/WX3CeRNL4Ls6x0eQT0RWadKNS8UNKJgpUF5BkumGsZpXKO4xNTJ1bPmMKyhpp4fjPuR7H3+MyYcjukVjBfq02Y2vGomHYIJkbcFQsu4dSrpVL6mLg4OB1CQVdKgRMJlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670626; c=relaxed/simple;
	bh=CU6youjXboITy+rJv4aeTedr301G8Zm6O3Ab5USqpZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpY3Zs8CvZiiyti7Ev7SlUfAsZATKUMcx8QJQvWepI19X3oQnPJf6xGvQwAr8vFE1jGSgMsTA7JnnSZqZTn2rgX46vD+IdlPF34vKCgj7tBKPDgm+DpVXtvujDVgXnsdbjE4saNLTsREBgb+lf/LoPK6OFAK+8VX6/tsDsrjsyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eworm.de; spf=pass smtp.mailfrom=eworm.de; arc=none smtp.client-ip=46.4.70.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eworm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eworm.de
Received: from leda.eworm.net (unknown [194.36.25.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id 99265216F54;
	Mon, 19 May 2025 17:56:41 +0200 (CEST)
Authentication-Results: mx.mylinuxtime.de;
	auth=pass smtp.auth=mail@eworm.de smtp.mailfrom=mail@eworm.de
Date: Mon, 19 May 2025 17:56:40 +0200
From: Christian Hesse <mail@eworm.de>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: <hch@infradead.org>, <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <ming.lei@redhat.com>,
 <syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>,
 <syzkaller-bugs@googlegroups.com>, Christian Heusel <christian@heusel.eu>,
 Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH V5] loop: Add sanity check for read/write_iter
Message-ID: <20250519175640.2fcac001@leda.eworm.net>
In-Reply-To: <20250428143626.3318717-1-lizhi.xu@windriver.com>
References: <aA-QB7Iu6u9PdgHg@infradead.org>
	<20250428143626.3318717-1-lizhi.xu@windriver.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S90K33h=.7s9=MsdGtUcLlt";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spamd-Bar: /
X-Spamd-Result: default: False [0.00 / 15.00];
	TAGGED_RCPT(0.00)[6af973a3b8dfd2faefdc]
X-Rspamd-Server: mx
X-Rspamd-Queue-Id: 99265216F54
X-Stat-Signature: 36niebrzyqsewbgg3maz3zorfejfxxgk
X-Rspamd-Action: no action

--Sig_/S90K33h=.7s9=MsdGtUcLlt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Lizhi Xu <lizhi.xu@windriver.com> on Mon, 2025/04/28 22:36:
> Some file systems do not support read_iter/write_iter, such as selinuxfs
> in this issue.
> So before calling them, first confirm that the interface is supported and
> then call it.
>=20
> It is releavant in that vfs_iter_read/write have the check, and removal
> of their used caused szybot to be able to hit this issue.
>=20
> Fixes: f2fed441c69b ("loop: stop using vfs_iter__{read,write} for buffered
> I/O") Reported-by: syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D6af973a3b8dfd2faefdc
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> V1 -> V2: move check to loop_configure and loop_change_fd
> V2 -> V3: using helper for this check
> V3 -> V4: remove input parameters change and mode
> V4 -> V5: remove braces around !file->f_op->write_iter

This introduced a regression for Arch Linux, breaking boot media generated
with archiso [0]. More specifically it's this call of losetup [1].

There's a squashfs inside iso9660. Mounting the iso9660 filesystem works
fine, but losetup complains when setting up:

$ losetup --find --show --read-only -- /run/archiso/bootmnt/arch/x86_64/air=
ootfs.sfs
losetup: /run/archiso/bootmnt/arch/x86_64/airootfs.sfs: failed to set up lo=
op device: Invalid argument

This has been bisected to commit d278164832618bf2775c6a89e6434e2633de1eed in
mainline (and 9bd3feb324fce2e93e09d0a5b00887e81d337a8c for linux-6.14.y,
184b147b9f7f07577567a80fcc9314f2bd0b0b00 for linux-6.12.y). Thanks to
Christian Heusel for his work on this.

As the call tries to setup in read-only mode the check for
(file->f_op->read_iter) fails here, returning the -EINVAL we see.

Reported-by: Christian Hesse <mail@eworm.de>
Bisected-by: Christian Heusel <christian@heusel.eu>

[0] https://gitlab.archlinux.org/archlinux/mkinitcpio/mkinitcpio-archiso
[1] https://gitlab.archlinux.org/archlinux/mkinitcpio/mkinitcpio-archiso/-/=
blob/master/hooks/archiso?ref_type=3Dheads#L88
--=20
Mit freundlichen Gruessen
Christian Hesse

--Sig_/S90K33h=.7s9=MsdGtUcLlt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSmOl3fryo2Nzt8CpJOj8ol/axIVQUCaCtUuQAKCRBOj8ol/axI
VdcMAQD8COWGYPfVA+CfsDsvTILwTxEy6J9MDcznNJJI2OIyowEAjxoAj2hgBfwJ
Fe6zgRknC3M/uJlHcO4mGZBhSVq/hAA=
=ylBs
-----END PGP SIGNATURE-----

--Sig_/S90K33h=.7s9=MsdGtUcLlt--
