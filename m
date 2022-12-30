Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B115C4167B
	for <linux-block@archiver.kernel.org>; Fri, 30 Dec 2022 10:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbiL3KhU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Dec 2022 05:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbiL3KhT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Dec 2022 05:37:19 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A581A05B
        for <linux-block@vger.kernel.org>; Fri, 30 Dec 2022 02:37:17 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221230103715euoutp01fe24be84fcb161909f3b5f2c88d51a13~1i_Exn4vC3186931869euoutp01H;
        Fri, 30 Dec 2022 10:37:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221230103715euoutp01fe24be84fcb161909f3b5f2c88d51a13~1i_Exn4vC3186931869euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672396635;
        bh=1H+EV5lkQbYxu7KyBZt4GEgMuiuP6Q4aipWj4ZQVioM=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=S3Rzx+N65JRKhEqXmq0YFmWtEL0fRUWkDCQiWsG6zVNGMUdw4YTG4vWVS46q6oDF9
         ALXM+t1qDCW1r0/o0guKBuyrk+AgaQGHMrSHTFN5c45X+ogxr8cBhZeQb/Mk5DSvG2
         k+9SVaORiNt7fDFDnSTSofwwtT3maN2EdbgkVCQA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221230103715eucas1p2a0c1433197182ea848dc3265a721cd02~1i_EnMuYP2967629676eucas1p2m;
        Fri, 30 Dec 2022 10:37:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AB.32.61936.B5FBEA36; Fri, 30
        Dec 2022 10:37:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221230103715eucas1p21212a9024a28e81961ae5c0caf769df2~1i_EO1GGP2746927469eucas1p27;
        Fri, 30 Dec 2022 10:37:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221230103715eusmtrp2a80f004258d9f0292734ff377c999f7a~1i_EOSRks1362313623eusmtrp2g;
        Fri, 30 Dec 2022 10:37:15 +0000 (GMT)
X-AuditID: cbfec7f4-a2dff7000002f1f0-84-63aebf5b4cd5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 93.E7.52424.B5FBEA36; Fri, 30
        Dec 2022 10:37:15 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221230103715eusmtip10e215f0227f5b004a1b9f2a10bfdd224~1i_EDl00L0095400954eusmtip15;
        Fri, 30 Dec 2022 10:37:15 +0000 (GMT)
Received: from localhost (106.210.248.83) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 30 Dec 2022 10:37:14 +0000
Date:   Fri, 30 Dec 2022 11:37:13 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <osandov@fb.com>, <joshi.k@samsung.com>, <anuj20.g@samsung.com>,
        <ankit.kumar@samsung.com>, <vincent.fu@samsung.com>,
        <ming.lei@redhat.com>, <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/6] tests/nvme: add new test for rand-read on the nvme
 character device
Message-ID: <20221230103713.sf7y77ds77473rl3@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="yuxdgeszv5r5csq3"
Content-Disposition: inline
In-Reply-To: <20221221103441.3216600-3-mcgrof@kernel.org>
X-Originating-IP: [106.210.248.83]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djP87rR+9clGyz9qWWx95a2xY0JTxkt
        Dk1uZrI4fO8qiwOLx8Tmd+wem1Z1snm833eVzePzJrkAligum5TUnMyy1CJ9uwSujMdr21kK
        DkpUnLr6j72BcYNIFyMnh4SAicTtWzsYuxi5OIQEVjBKNFzuZIdwvjBKnJ3TwwrhfGaUuPXp
        ADNMy7/ln9kgEssZJSau/8YIVzX74E9mCGcLo8Sa77fAWlgEVCW2T/7PBmKzCehInH9zBywu
        IqAhsW9CLxNIA7PAJkaJFQevgyWEBeIkTu9pZQSxeQXMJT5c+ccOYQtKnJz5hAXEZhaokGi+
        9gloKAeQLS2x/B8HSJhTwFKiZ+9UFohTlSQ23rjFBmHXSqw9dgbsOQmB/xwSPQ8eskMkXCT6
        nk2CKhKWeHV8C1RcRuL/zvlMEHa2xM4pu6D+L5CYdXIq2F4JAWuJvjM5EGFHidP/p0OF+SRu
        vBWEuJJPYtK26cwQYV6JjjYhiGo1iR1NWxknMCrPQvLXLCR/zUL4CyKsI7FgNxZhbYllC18z
        Q9i2EuvWvWdZwMi+ilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzBBnf53/MsOxuWvPuod
        YmTiYDzEqALU/GjD6guMUix5+XmpSiK8GmdXJwvxpiRWVqUW5ccXleakFh9ilOZgURLnnbF1
        frKQQHpiSWp2ampBahFMlomDU6qBiWvqLcfwOb8FXmi8F5c1vfDyQ+utR12xtqulriQsK9k9
        ewq3ndWktccnVAl2L08KuJTzNEhNS7b3xvf/Dntqfx4KceCT0Uib7Xpd8fD5xSv+c7y1eZQb
        O3Uye/VDX1EDTutzc4ofV2aIPjP1vpi5rNQ+6P1dPubpl5k+bbVTy7r90PvssUO8GZYNX2tu
        5i4PKAu+Jbw8OnZxpsOjbS8sI2dn712d+i31XJHZi4O8XXM/WS37M+PdCQ4lW91pG+beb4rV
        38PBek9mV8OGC+5Jj4wmX7/96cT/6BVCYfX67wz3MMgnF/5l/vPFcb3ww/1ppm7rHE8v8WgO
        2NyxpGB91eeClVHpiZ8f/TeZKpVrkKPEUpyRaKjFXFScCAAmbu39ywMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xu7rR+9clG0w6J2ix95a2xY0JTxkt
        Dk1uZrI4fO8qiwOLx8Tmd+wem1Z1snm833eVzePzJrkAlig9m6L80pJUhYz84hJbpWhDCyM9
        Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jB9fX7EU7Jeo2P91FVsD4zqRLkZODgkB
        E4l/yz+zgdhCAksZJW4skIKIy0h8uvKRHcIWlvhzrQuohguo5iOjxOPTs5khnC2MEtvvXWcF
        qWIRUJXYPvk/2CQ2AR2J82/uMIPYIgIaEvsm9DKBNDALbGKUWHHwOlhCWCBO4vSeVkYQm1fA
        XOLDlX/sEFN3M0qs27uXGSIhKHFy5hMWEJtZoEzizcHPQEUcQLa0xPJ/HCBhTgFLiZ69U1kg
        TlWS2HjjFhuEXSvx6v5uxgmMwrOQTJqFZNIshEkQYS2JG/9eMmEIa0ssW/iaGcK2lVi37j3L
        Akb2VYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIGRuu3Yzy07GFe++qh3iJGJg/EQowpQ56MN
        qy8wSrHk5eelKonwapxdnSzEm5JYWZValB9fVJqTWnyI0RQYjBOZpUST84EpJK8k3tDMwNTQ
        xMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgSnndMDqRSz7rUVbFjx7a+Uu0n9S
        snnng2P77k/PkvB6MPnMwVuv684ZTDtcmC2qovHlrOihkN1q4ilxSzt1Y+0k6pYZCN96qtuQ
        7NAr5lK278nd1Xe2Tj1y8qlt0wcXu48NnYv3Xzq6dbbI0y3rr8/Km3PlpoJVTFiP8n/WaJOd
        OWpXzkxtOvNi1kQZA4Wy95WXmY8FHnNU/C0h8zVkoaXmsv6bt8XYF3xM3Kfb+7X8H8Odtle5
        Dt9dzmU+COXnEGW+f/LwqagF0/T3rJZeYbStsHKzHmNF7K8fFSvVtuZqvVtosMPAaTGP5a7e
        O9LGYjHCBToBD42UMlefP+G/fb5Njqz8CXPbOUY9r/jd+COUWIozEg21mIuKEwGXrXltaQMA
        AA==
X-CMS-MailID: 20221230103715eucas1p21212a9024a28e81961ae5c0caf769df2
X-Msg-Generator: CA
X-RootMTR: 20221221103454eucas1p2facaa4072e0c8f395162f37fd74fcd18
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221221103454eucas1p2facaa4072e0c8f395162f37fd74fcd18
References: <20221221103441.3216600-1-mcgrof@kernel.org>
        <CGME20221221103454eucas1p2facaa4072e0c8f395162f37fd74fcd18@eucas1p2.samsung.com>
        <20221221103441.3216600-3-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--yuxdgeszv5r5csq3
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 21, 2022 at 02:34:37AM -0800, Luis Chamberlain wrote:
> This does basic rand-read testing of the character device of a
> conventional NVMe drive.
>=20
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  tests/nvme/046     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/046.out |  2 ++
>  2 files changed, 44 insertions(+)
>  create mode 100755 tests/nvme/046
>  create mode 100644 tests/nvme/046.out
>=20
> diff --git a/tests/nvme/046 b/tests/nvme/046
> new file mode 100755
> index 000000000000..3526ab9eedab
> --- /dev/null
> +++ b/tests/nvme/046
> @@ -0,0 +1,42 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2022 Luis Chamberlain <mcgrof@kernel.org>
> +#
> +# This does basic sanity test for the nvme character device. This is a b=
asic
> +# test and if it fails it is probably very likely other nvme character d=
evice
> +# tests would fail.
> +#
> +. tests/nvme/rc
> +
> +DESCRIPTION=3D"basic rand-read io_uring_cmd engine for nvme-ns character=
 device"
> +QUICK=3D1
> +
> +requires() {
> +	_nvme_requires
> +	_have_fio
> +}
> +
> +device_requires() {
> +	_require_test_dev_is_nvme
> +}
> +
> +test_device() {
> +	echo "Running ${TEST_NAME}"
> +	local ngdev=3D${TEST_DEV/nvme/ng}
> +	local fio_args=3D(
> +		--size=3D1M
> +		--cmd_type=3Dnvme
> +		--filename=3D"$ngdev"
> +		--time_based
> +		--runtime=3D10
> +	) &&
> +	_run_fio_rand_iouring_cmd "${fio_args[@]}" >>"${FULL}" 2>&1 ||
> +	fail=3Dtrue
> +
> +	if [ -z "$fail" ]; then
> +		echo "Test complete"
> +	else
> +		echo "Test failed"
> +		return 1
> +	fi
I see that several test have this structure, but would it not be better
to do:

"""
if [ -n "$fail" ]; then
  echo "Test failed"
  return 1
fi

return "Test complete"
"""

I point this out because I noticed that most nvme tests just set the
"test complete" string at the end of the test function.

> +}
> diff --git a/tests/nvme/046.out b/tests/nvme/046.out
> new file mode 100644
> index 000000000000..2b5fa6af63b1
> --- /dev/null
> +++ b/tests/nvme/046.out
> @@ -0,0 +1,2 @@
> +Running nvme/046
> +Test complete
> --=20
> 2.35.1
>=20

--yuxdgeszv5r5csq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmOuv1IACgkQupfNUreW
QU92hAv/VPpAjccbHRuBUaQPnZRSBAfFkJRiEO86tMJs2o9C1/P25uV98eDOawRe
8w88ROwVrxkYmwg/xXnF/nDf3dlj6S0NV9rNxa+jtd4Sg1BZFiFFFchNvZTqn0tj
nvZK4o/RhnJKIdkw1vmksauQpilrkx2e83hoCyDH16BudaQjW7sEAi4Whn2XAYaK
kKQEzk/GxWJECFoe3M3my/d5HOVEyrzvu6aAfV4cBxOYeO3C+ImCW8Vboa+oMHA4
CtuTIipACIhMRSU2bXEBSnuckeVcf0xC2XDSGyGefDM5cysngvNa69pZFeDz6mSN
6pM/NgHsCwME2RgIiE2ku/yeL6MXaGgM4D8lhZZXc2Ini5YstNzu9oXc0OZHvWzG
HAsoVOtsoR2AssgcwA2v+x390DlDAr1dRGfBbOCDyuvD62qMRb4TrA3jIujL8jIi
WF5W30rLDsyN938oCTVnifRwQRBlEetllhHyaebiP/hBGDiFMW6kUmaXLdn21Uel
cvR3h1PM
=0mX3
-----END PGP SIGNATURE-----

--yuxdgeszv5r5csq3--
