Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:50300 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbdJFMIz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Oct 2017 08:08:55 -0400
Received: by mail-wm0-f49.google.com with SMTP id u138so7171395wmu.5
        for <linux-block@vger.kernel.org>; Fri, 06 Oct 2017 05:08:54 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <EFDF36A0-7C36-44F5-B6F8-C8E6E0048B9B@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1E4D2E50-B705-4845-A604-EE1BD810D2BE";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Why removing REQ_FAILFAST_DRIVER in LightNVM?
Date: Fri, 6 Oct 2017 14:08:52 +0200
In-Reply-To: <20171006120609.GA27720@infradead.org>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>,
        linux-block@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
References: <216FF7C0-4B2A-438A-BC63-88A9BBDC77CC@lightnvm.io>
 <20171006115927.GA12530@infradead.org>
 <6D7E3697-713C-4FBD-86EA-20AB1DC72742@lightnvm.io>
 <20171006120609.GA27720@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_1E4D2E50-B705-4845-A604-EE1BD810D2BE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 6 Oct 2017, at 14.06, Christoph Hellwig <hch@infradead.org> wrote:
>=20
> On Fri, Oct 06, 2017 at 02:01:46PM +0200, Javier Gonz=C3=A1lez wrote:
>> I think it is good to fail fast as any other nvme I/O command and =
then
>> recover in pblk if necessary.
>=20
> Note that we only do it for other nvme _passthrough_ commands - the
> actual I/O commands dot not get the failfast flag.

Yes. I was thinking of the LightNVM-specific _passthrough_ used by
liblightnvm since I'm refactoring the sync. path at the moment; the
"normal" async. path will be untouched for now.

Thanks,
Javier

--Apple-Mail=_1E4D2E50-B705-4845-A604-EE1BD810D2BE
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnXclQACgkQYx8FO3WZ
GMrADxAAi8JcqBEeVyKSHG7AefdzQYoMxXk8mIU13P6MjiPcgTsn2X7j0g3YuMjz
AsBFe27g99LOLtfsIkdUnfR+iuL0I/egS8EsoPU2dZzJ8pk4DxmaIDNp/u7/u/S6
OUFzjWYvyQe2tB9JRDEHfKXjTerh3ldoFhrCIHg6zqmmRplLeZsvn0jxR5BZ/HfQ
f1753wAgOA71jD90jjpHDlpT8x2h5DkBUsJsFiIA7nZgVRCAeRqks5oPPMEdLeaw
RWAkyjAiw8F28221K/uMAw0/2UYvXSYNmk4NKKhyIAcJX2ekhdyVVgEpwXyjtAO0
hsgYrXQUxbs4wEs2dxntO5327qFYDAJsfTIA/ALDTTXuKO6Qss5qFCil+yP3G4G7
+B+5HoLIaiHrqVdZiRtRCd6moC6ypzIxSrL02j9kKZyedt2regWbvRueUL25w74b
eid7cbbQ+RKyHtFGZcxGf40Z4wdcugnrdaV/EHymsnLABLTx+qafdorel9Fzsqp/
KHqrv581+F1P7FgUnJ7O4+DxD8MekHcRcRBFnrHliy6bPospG4pWnjTYHe+z36nw
g3HnImCCkQAGYrvm80ooMoi2mWD/fqjn1Qm9OU5QFH1+mhQtKEnUG4PtRWp4CPfW
4oM53pWdFAE8z6mO01s1+DU3WzU3cOBI6VZ6GSfghj/phbpkTp8=
=m/Y/
-----END PGP SIGNATURE-----

--Apple-Mail=_1E4D2E50-B705-4845-A604-EE1BD810D2BE--
