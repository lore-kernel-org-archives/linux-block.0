Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr720049.outbound.protection.outlook.com ([40.107.72.49]:26822
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388913AbeHPSxB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Aug 2018 14:53:01 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/1] lightnvm: move bad block and chunk state logic
 to core
Date: Thu, 16 Aug 2018 15:53:34 +0000
Message-ID: <00698BD3-4382-4033-908F-BEB63E7FAD57@cnexlabs.com>
References: <20180816113417.3641-1-mb@lightnvm.io>
In-Reply-To: <20180816113417.3641-1-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_9EAC1DCF-70BC-4BA1-A748-4D710507DC92";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_9EAC1DCF-70BC-4BA1-A748-4D710507DC92
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 16 Aug 2018, at 13.34, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> This patch moves the 1.2 and 2.0 block/chunk metadata retrieval to
> core.
>=20
> Hi Javier, I did not end up using your patch. I had misunderstood what
> was implemented. Instead I implemented the detection of the each chunk =
by
> first sensing the first page, then the last page, and if the chunk
> is sensed as open, a per page scan will be executed to update the =
write
> pointer appropriately.
>=20

I see why you want to do it this way for maintaining the chunk
abstraction, but this is potentially very inefficient as blocks not used
by any target will be recovered unnecessarily. Note that in 1.2, it is
expected that targets will need to recover the write pointer themselves.
What is more, in the normal path, this will be part of the metadata
being stored so no wp recovery is needed. Still, this approach forces
recovery on each 1.2 instance creation (also on factory reset). In this
context, you are right, the patch I proposed only addresses the double
erase issue, which was the original motivator, and left the actual
pointer recovery to the normal pblk recovery process.

Besides this, in order to consider this as a real possibility, we need
to measure the impact on startup time. For this, could you implement
nvm_bb_scan_chunk() and nvm_bb_chunk_sense() more efficiently by
recovering (i) asynchronously and (ii) concurrently across luns so that
we can establish the recovery cost more fairly? We can look at a
specific penalty ranges afterwards.

Also, the recovery scheme in pblk will change significantly by doing
this, so I assume you will send a followup patchset reimplementing
recovery for the 1.2 path? I am rebasing wp recovery for 2.0 now and
expect to post in the next couple of days. This logic can be reused, but
it requires some work and testing. A preliminary version of this patch
can be found here [1].

> Note that one needs a real drive to test the implementation. The 1.2
> qemu implementation is lacking. I did update it a bit, such that
> it defaults to all blocks being free. It can be picked up in the ocssd
> qemu repository.

I added patches to fix store/recover chunk metadata in qemu. This
should help you generating an arbitrary chunk state and test sanity for
these patches.

Can you share the tests that you have run to verify this patch? I can
run them on a 1.2 device next week (preferably on a V3 that includes the
comments above).

[1] https://github.com/OpenChannelSSD/linux/commits/for-4.20/pblk: =
3c9c548a83ce

Javier

--Apple-Mail=_9EAC1DCF-70BC-4BA1-A748-4D710507DC92
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlt1nfsACgkQIX4xUKFR
nnTCxA/9H2fQ6aK1r5o1UNRzSigoJBrztOGauenTcpTgs9S/i/JcCgcxbGCPyX6M
SrhySUK7DJ1YGR4EfDwFpb15R+LJkzBBvYEPf13fQrZcCBruU8+A6bHt3Fi9yUD9
EwAVlOwa79X3xbHLCnRoD9+vIVO/Rd9VId50kOPsxYGylc55oiwpyZsDWNjsSp21
6327ImqiJhnIwFX1WWK8uEFXXAQPhLKRFNncIPU4sCLSTtHM60nSTgbJo7NjNavD
ltfM8en+MIsu2TPVAU/1KKKTuIfXwJC4eZwrliBVWWoLhHc6aqS/ZeBHdJaHWDue
qQQIf4JepAf+a1gKxcEm50rjH1RtI0hcZk2JEyA+4hTfrSg2E4w3rlHApLGiHKdg
/NL8oxHWYZXI3y01gMOje4AadkELV6rMM7mEv75kT39bwCA3VzFWW+bIqC9uqgcj
pMsxuhRsIZ4UMizEnvs77v2zJryPiBn6eZcIFPShk9uIwf+w/5ZV6iJatkW4J1cj
+MC0t4q1KbbUh86zxYrQgWXnoK17dkc0QiuLZ1CBXewbDBMcnv+I2SnABFNaxBvM
y7RhBFgQ9WyEt/+zCkorkXb+1/yYve1hn4wIiWePliH4SIl/wAWu0Ky7PTw0hwMM
9+HrZpgbnGJa/lzj6UWUpWOJEO4Kr1dkgjGvh4BbInDsoFJ6oFE=
=bPTN
-----END PGP SIGNATURE-----

--Apple-Mail=_9EAC1DCF-70BC-4BA1-A748-4D710507DC92--
