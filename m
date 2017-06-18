Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44742 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750869AbdFREdS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 00:33:18 -0400
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@fb.com>
Date: Sun, 18 Jun 2017 14:33:09 +1000
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Two fixes for loop devices
In-Reply-To: <c70dfc69-516c-f1e8-4e39-74eff1bca176@fb.com>
References: <149758925866.10006.12779875832895865043.stgit@noble> <c70dfc69-516c-f1e8-4e39-74eff1bca176@fb.com>
Message-ID: <87bmpl6hkq.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Fri, Jun 16 2017, Jens Axboe wrote:

> On 06/15/2017 11:02 PM, NeilBrown wrote:
>> Hi Jens,
>>  one of these is a resend of a patch I sent a while back.
>>  The other is new - loop closes files differently from close()
>>  and in a way that can confuse NFS.
>
> Are you wanting to get these into 4.12, or defer to 4.13?

I'm happy either way.  I just want them to land eventually, so I can
tick them off my list.

The conversation with Al might result in a different fix for the
flip_close() problem, but I think that it is still more correct to call
filp_close(), because what loop is doing is a lot like closing a file
that it has been writing to.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAllGAoYACgkQOeye3VZi
gbkv1BAAuFvLEA/SbZQLQhFvBoyZ0IJ0mVDtZHg0CKJpmmdN2EkFm+BlJbpdsFEY
UaMxlBU7z7p1L7MDZNa+srU7MORXeGz/V9BM9zhz7u0u/Hm6qvq1IgFU1jA07gv2
9MSn8RNXWU5G5+oZVT6XttheCUP/uDQ6WRQ1muLNubjQuMJVmG4uyxzyouaaqqof
zoBdD5a+RlHqEwJVwNi9CGwjDvmfm/O8Vs29X+eydjVNOAUS1WYIXco2IbaMcsI7
4geoIZD3rnIFP1NDd7jJdobyoTeQd/dyFePVBO+lwLTdo6ontD/jfHuhig+Rycjz
wIrwFmu2oiTpxqiqY/LhtLBZ8xFpPBpfIHKtMOXf32sCwm9zxngUCZYxsSMsbyeb
fG3mCdiuJBckVGJcUxj2eIzw78zCQTibYdvVz1bXU07gC6Qc910dv0T0dB1L5Jr5
mSyzg2vfFUYhFMPc+bra7uV8z+TKHxBIsBVq4zrXX9J6/H51Zqx9MmE9wkVJycUL
KOTmZXvuMjpXv93W5PDMh1jQJPjkNMalrfi/0WWTpJknhYd9LRuhgsAn9LODWLGO
m0do7BWtkAvNXKeInZTvgnbng0+yhcVyntho8Kq+4pQ2CbDKjoc6dOZTsoZzkcIq
6FfyAPDcxW4BworAFS7vunO/+ZGrAKQsfMdHd+xKsn6sRIMX1Ak=
=Cf8o
-----END PGP SIGNATURE-----
--=-=-=--
