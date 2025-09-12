Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B793F26E17D;
	Fri, 12 Sep 2025 20:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757708514; cv=none; b=T+btKuWCde/bcwl6vGGXFGHAZNQb55Z8nbj/lqM3Po6XPxvRx/Q68LLj1ueeTf6xUfIZhFZiObKQmd3V/vM1GqtiXfyg59b6NW6QwFqIgXC8t5foJTTDwfSrRKGg8f12Lhmiw7SfZN0IHyGofCtJyywg2CkT+UP9kkFYIP2uXTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757708514; c=relaxed/simple;
	bh=1XR56SR+z2CBR5E5TriztVfhwFNUArCinFwYBUwkU40=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yg7XIo+/LELilXq//jQznZEMQYAGshzrB9w3NFgdmuaUQgyuoGvDKNcqHZeqZqRPh6DhM7vOd6aJ9LbIgTXlYh0YLH+5yFM9lJj/aJAkaww1m/rlOazMRnl1v8ktIn//7A0ogrCg4Xhenwelws/lXbrqZt+3oyb60HM1TKTTVq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=FSYzCyYN; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="FSYzCyYN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=CrZcAOEzjLjX1gZCVLM20v02GJXBX5Y+1e/kkg2NnnM=; t=1757708511;
	x=1758313311; b=FSYzCyYNFgOIpB5mYUcGKRNo96Ezc+f11YiWr76QeGdYDRw9VP1KWLy7FVrEB
	vvxuLOHDIB0l+sMyB5FUGqgAEd0EUFGZFBIvACmVrQwN3mwKSbEy7aQRrVDvHGSK5X24fkk9bRz40
	hPCbG6Uga3m6+Aceo234EIE7AkesyJR1DxNUfOy2vQs079tznXHBHeyg/KVUPGSD6G6TrKZKKhjDU
	8whBzMQWdNruP22rxJJj5FqiaysgSCwNPkG0DVVc4BvF+MtwyX41GHKTR3jBs1+7RIU+QfIT1tCi+
	NK+7ETYu2AHOcin0tFy0MzHpQ9Je0SjvzOcd3w7LvGelDAsWPQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uxAH8-00000002lZ0-3oso; Fri, 12 Sep 2025 22:21:42 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uxAH8-000000045T8-2tlU; Fri, 12 Sep 2025 22:21:42 +0200
Message-ID: <471f32d77e201bc54e23842b69ce87e36929d8a2.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sunvdc: Do not spin in an infinite loop when
 vio_ldc_send() returns EAGAIN
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Jens Axboe <axboe@kernel.dk>, Yang Xiao <YangX92@hotmail.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Anthony
 Yznaga <anthony.yznaga@oracle.com>, Sam James <sam@gentoo.org>, sparclinux
	 <sparclinux@vger.kernel.org>
Date: Fri, 12 Sep 2025 22:21:41 +0200
In-Reply-To: <4c693ebe-dfc4-b5fb-f8d5-28f93b05b77a@kernel.dk>
References: 
	<HK0PR01MB21634739CFCEA8CB1AC08E45ADD10@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
	 <4c693ebe-dfc4-b5fb-f8d5-28f93b05b77a@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello Jens and Yang,

On Wed, 2018-11-28 at 06:23 -0700, Jens Axboe wrote:
> On 11/28/18 5:36 AM, Yang Xiao wrote:
> > From: Young Xiao <YangX92@hotmail.com>
> >=20
> > __vdc_tx_trigger should only loop on EAGAIN a finite
> > number of times.
> >=20
> > See commit adddc32d6fde ("sunvnet: Do not spin in an
> > infinite loop when vio_ldc_send() returns EAGAIN") for detail.
>=20
> Looks good to me, applied.

I am seeing a lot of I/O errors as a result of this change of Linux running
inside a SPARC T5-2 LDOM running on Solaris 11.4.81 and I'm wondering wheth=
er
this change was justified by the commit in adddc32d6fde ("sunvnet: Do not s=
pin
in an infinite loop when vio_ldc_send() returns EAGAIN") only or whether th=
ere
were actual bug reports.

See the output below:

[19095.192532] sunvdc: vdc_tx_trigger() failure, err=3D-11
[19095.192605] I/O error, dev vdiskc, sector 368208928 op 0x1:(WRITE) flags=
 0x1000 phys_seg 2 prio class 2
[19095.205681] XFS (vdiskc1): metadata I/O error in "xfs_buf_ioend+0x28c/0x=
600 [xfs]" at daddr 0x15f26420 len 32 error 5
[19432.043471] sunvdc: vdc_tx_trigger() failure, err=3D-11
[19432.043529] I/O error, dev vdiskc, sector 3732568 op 0x1:(WRITE) flags 0=
x1000 phys_seg 1 prio class 2
[19432.058821] sunvdc: vdc_tx_trigger() failure, err=3D-11
[19432.058843] I/O error, dev vdiskc, sector 3736256 op 0x1:(WRITE) flags 0=
x1000 phys_seg 4 prio class 2
[19432.074109] sunvdc: vdc_tx_trigger() failure, err=3D-11
[19432.074128] I/O error, dev vdiskc, sector 3736512 op 0x1:(WRITE) flags 0=
x1000 phys_seg 4 prio class 2
[19432.089425] sunvdc: vdc_tx_trigger() failure, err=3D-11
[19432.089443] I/O error, dev vdiskc, sector 3737024 op 0x1:(WRITE) flags 0=
x1000 phys_seg 1 prio class 2
[19432.100964] XFS (vdiskc1): metadata I/O error in "xfs_buf_ioend+0x28c/0x=
600 [xfs]" at daddr 0x38ec58 len 8 error 5

At least Oracle's UEK kernel for SPARC [1] does not contain this change whi=
ch
is why I'm a bit reluctant to believe that the change is correct.

Adrian

> [1] https://github.com/oracle/linux-uek/tree/uek4/qu7/

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
