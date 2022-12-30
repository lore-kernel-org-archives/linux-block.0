Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED33C4167B
	for <linux-block@archiver.kernel.org>; Fri, 30 Dec 2022 10:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiL3KKv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Dec 2022 05:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiL3KKt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Dec 2022 05:10:49 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02426329
        for <linux-block@vger.kernel.org>; Fri, 30 Dec 2022 02:10:44 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221230101041euoutp023a619a6f81b99c875bf9d2373d89f4e5~1im3aycE52837028370euoutp02g;
        Fri, 30 Dec 2022 10:10:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221230101041euoutp023a619a6f81b99c875bf9d2373d89f4e5~1im3aycE52837028370euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672395041;
        bh=uoAko8oRtZfnR0QTUhCdP6YTYiSFukrKmDq2LtXMRvE=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=DBerPL558OrNaRXi3vKNV3CpoJu6Hz6SfUnTDSc0UbTJVDRlvUC+jmct0HHxwoKna
         w3Q2WC6JfliUPLgksnjG+LiDA+18LdVVSrtpol+Q5+Gjxg/7aFV7QIFJK4RRBaQUYZ
         U/wDGKT9wa5tb1473/qSu6Jx7nidj/qfPTLdjqxQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221230101040eucas1p22a0b245d25b2f435f70d4b3085d2489b~1im3MPlfJ0658406584eucas1p2u;
        Fri, 30 Dec 2022 10:10:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 30.B1.56180.029BEA36; Fri, 30
        Dec 2022 10:10:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20221230101039eucas1p13294ecb21ae29b436d91c8f6fccbab3a~1im2StD2-1799317993eucas1p11;
        Fri, 30 Dec 2022 10:10:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221230101039eusmtrp227272c4648ab3dd68fbcf676e152575e~1im2RlHuL3025730257eusmtrp2S;
        Fri, 30 Dec 2022 10:10:39 +0000 (GMT)
X-AuditID: cbfec7f2-acbff7000000db74-1c-63aeb920d3ce
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 08.A2.23420.F19BEA36; Fri, 30
        Dec 2022 10:10:39 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221230101039eusmtip1d8c158cc2cf9e29c85c2917ab5398e26~1im2D4oKi1164111641eusmtip1C;
        Fri, 30 Dec 2022 10:10:39 +0000 (GMT)
Received: from localhost (106.210.248.83) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 30 Dec 2022 10:10:38 +0000
Date:   Fri, 30 Dec 2022 11:10:37 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <osandov@fb.com>, <joshi.k@samsung.com>, <anuj20.g@samsung.com>,
        <ankit.kumar@samsung.com>, <vincent.fu@samsung.com>,
        <ming.lei@redhat.com>, <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/6] common/fio: add helpers using io-uring cmd engine
Message-ID: <20221230101037.4g6tckvbtijteb26@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="vdd4uxtjfng5dx77"
Content-Disposition: inline
In-Reply-To: <20221221103441.3216600-2-mcgrof@kernel.org>
X-Originating-IP: [106.210.248.83]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djPc7oKO9clGxzcpGmx95a2xY0JTxkt
        Dk1uZrI4fO8qiwOLx8Tmd+wem1Z1snm833eVzePzJrkAligum5TUnMyy1CJ9uwSujEW7LrMX
        /Jeu+HwntoHxhngXIyeHhICJxPOrX5m7GLk4hARWMErc+faECcL5wihxZO1MdpAqIYHPjBIL
        F/B3MXKAdXS80oGoWc4osW36eXYIB6hm9fIGVoiGLYwSa6ZFgtgsAqoSG2cfZwax2QR0JM6/
        uQNmiwhoSOyb0Au2jVlgE6PEioPXwRLCAl4SCxZuZwKxeQXMJbqbHrFD2IISJ2c+YQGxmQUq
        JD7cfc0KchGzgLTE8n8cICangKXEssfxEJ8pSWy8cYsNwq6VWHvsDNidEgJfOCQmNs9mhEi4
        SDw52McOYQtLvDq+BcqWkfi/cz4ThJ0tsXPKLmYIu0Bi1smpbJCAsJboO5MDEXaUmLptNjtE
        mE/ixltBiCP5JCZtm84MEeaV6GgTgqhWk9jRtJVxAqPyLCRvzULy1iyEtyDCOhILdn9iwxDW
        lli28DUzhG0rsW7de5YFjOyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAtPS6X/HP+1g
        nPvqo94hRiYOxkOMKkDNjzasvsAoxZKXn5eqJMKrcXZ1shBvSmJlVWpRfnxRaU5q8SFGaQ4W
        JXHeGVvnJwsJpCeWpGanphakFsFkmTg4pRqYrCakXV69qtJF9OMfx3LVOKllq92L79ns9Cuy
        cGWRCU423vytwNx67S/NWxMM/uvrX204dGLa7fOxr1O+/pTZs+Oro0QYp+izdevq2i4askcz
        S3x1E9/L2z5L58o6FY5JFyZt+8X31+kU044NtkLmkrE+BinbuDQYP5meSihb1JSh0xeY8P+P
        dlDns1sNfUf1bGOq357o1Pn6Onvyzm1J/WVOM5gLNiRxi+2/dW+163u7F1ek7zpYeB0/8C5i
        0yI257pJNzZrRCx/r9B7o7CzuO6UrdNirp3OTy6Z1uRuW9H3uftOyMm8WXeUbgeE567f/0pY
        vfDuQ12WHC/BF46v8zqlt1S71Lw6ckGw/tEGJZbijERDLeai4kQAlYXlYsYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xu7ryO9clG1zt0bbYe0vb4saEp4wW
        hyY3M1kcvneVxYHFY2LzO3aPTas62Tze77vK5vF5k1wAS5SeTVF+aUmqQkZ+cYmtUrShhZGe
        oaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexoPp75gK/kpXtPZoNjBeE+9i5OCQEDCR
        6Hil08XIxSEksJRR4sveh+xdjJxAcRmJT1c+QtnCEn+udbFBFH1klLhw5wELhLOFUeLdnBaw
        KhYBVYmNs48zg9hsAjoS59/cAbNFBDQk9k3oZQJpYBbYxCix4uB1sISwgJfEgoXbmUBsXgFz
        ie6mR+wQU3czSszddoYdIiEocXLmExaQW5kFyiRaHntAmNISy/9xgJicApYSyx7HQxyqJLHx
        xi02CLtW4tX93YwTGIVnIZkzC2HOLIQ5IBXMAloSN/69ZMIQ1pZYtvA1M4RtK7Fu3XuWBYzs
        qxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQIjdNuxn5t3MM579VHvECMTB+MhRhWgzkcbVl9g
        lGLJy89LVRLh1Ti7OlmINyWxsiq1KD++qDQntfgQoykwDCcyS4km5wNTR15JvKGZgamhiZml
        gamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA9Mpi4qbSyTbU77w/+q5bSvmWPdRWvj9
        37PVdyNbH7MquXG++PJsdRR30DP9mSbrFT3CpsTn/itfn7/0QKqRS6l+0tJ0oxI1B7dOY7et
        KbsvnvcL/LIrdFKNZ4iIlVPdnTOaV+0Y3z06bv5JZk7ChMyjsS35NyQ5NlQty71yYcHSKodf
        q1w+en/a+vPzr4UVCwSj+RWmXPSf2nBU+YBjkP+09eFb/LrVZrN6TrbcGfaRwefX+RU/0/7O
        3ebSquz1cJrUae6b0+YbtUplMeX+ZJGYkxJStcNUNLfd4lywffDxmRN07/utfDqpyWZfZ+o3
        xiMspx8cELcIyFJRzzqvxvuG1W6NOZuzzsmcwy5+6kosxRmJhlrMRcWJAK1/IS1lAwAA
X-CMS-MailID: 20221230101039eucas1p13294ecb21ae29b436d91c8f6fccbab3a
X-Msg-Generator: CA
X-RootMTR: 20221221103454eucas1p13f45c08f5f1757b329b72fd0999a4acc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221221103454eucas1p13f45c08f5f1757b329b72fd0999a4acc
References: <20221221103441.3216600-1-mcgrof@kernel.org>
        <CGME20221221103454eucas1p13f45c08f5f1757b329b72fd0999a4acc@eucas1p1.samsung.com>
        <20221221103441.3216600-2-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--vdd4uxtjfng5dx77
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 21, 2022 at 02:34:36AM -0800, Luis Chamberlain wrote:
> This will allow us to add tests which use the io-uring cmd engine,
> part of fio. They are inspired by the work by Anuj Gupta and
> Ankit Kumar which added sample fio files onto fio for this exact
> purpose.
>=20
> We can build on those to expand test coverage with elaborate tests.
>=20
> We don't specify the cmd to allow other types of io-uring cmd
> users to use this other than nvme.
>=20
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  common/fio | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>=20
> diff --git a/common/fio b/common/fio
> index bed76d555b2a..4da90804ed21 100644
> --- a/common/fio
> +++ b/common/fio
> @@ -184,6 +184,53 @@ _run_fio_verify_io() {
>  	rm -f local*verify*state
>  }
> =20
> +_run_fio_rand_iouring_cmd() {
> +	_run_fio --bs=3D4k --rw=3Drandread --numjobs=3D"$(nproc)" \
> +		--ioengine=3Dio_uring_cmd --iodepth=3D32 \
> +		--thread=3D1 --stonewall=3D1 \
> +		--name=3Dreads "$@"
> +}
> +
> +_run_fio_verify_iouring_cmd_randwrite() {
> +	_run_fio --bs=3D4k --rw=3Drandwrite --numjobs=3D"$(nproc)" \
> +		--ioengine=3Dio_uring_cmd --iodepth=3D32 \
> +		--thread=3D1 --stonewall=3D1 \
> +		--sqthread_poll=3D1 --sqthread_poll_cpu=3D0 \
> +		--nonvectored=3D1 --registerfiles=3D1 \
> +		--verify=3Dcrc32c \
> +		--name=3Dverify "$@"
> +	rm -f local*verify*state
> +}
> +
> +_run_fio_verify_iouring_cmd_write_opts() {
> +	_run_fio --bs=3D4k --rw=3Dwrite --numjobs=3D"$(nproc)" \
> +		--ioengine=3Dio_uring_cmd --iodepth=3D32 \
> +		--thread=3D1 --stonewall=3D1 \
> +		--sqthread_poll=3D1 --sqthread_poll_cpu=3D0 \
> +		--nonvectored=3D1 --registerfiles=3D1 \
> +		--verify=3Dcrc32c \
> +		--name=3Dverify "$@"
> +	rm -f local*verify*state
> +}
> +
> +_run_fio_iouring_cmd_zone() {
> +	_run_fio --rw=3Drandread --numjobs=3D"$(nproc)" \
> +		--ioengine=3Dio_uring_cmd --iodepth=3D1 \
> +		--stonewall=3D1 \
> +		--zonemode=3Dzbd \
> +		--name=3Dreads "$@"
> +}
> +
> +_run_fio_verify_iouring_cmd_write_opts_zone() {
> +	_run_fio --rw=3Drandread --numjobs=3D"$(nproc)" \
> +		--ioengine=3Dio_uring_cmd --iodepth=3D1 \
> +		--stonewall=3D1 \
> +		--zonemode=3Dzbd \
> +		--sqthread_poll=3D1 --registerfiles=3D1 --sqthread_poll_cpu=3D0 \
> +		--verify=3Dcrc32c \
> +		--name=3Dverify "$@"
Are you missing a "rm -f local*verify*state" here?

Joel
> +}
> +
>  _fio_perf_report() {
>  	# If there is more than one group, we don't know what to report.
>  	if [[ $(wc -l < "$TMPDIR/fio_perf") -gt 1 ]]; then
> --=20
> 2.35.1
>=20

--vdd4uxtjfng5dx77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmOuuRMACgkQupfNUreW
QU/EhAwAia6J9KeeS7DN0JlzMKfZBRRnaPemYT6Xqn0YlsFZoFTWKRUwUk5J+kKf
zDocTR9HMJeWcpcsG55cyXjt2La5sS3xmp6YNZocz80DCfynAd+cqw6yvOOy0Gq6
zJRVnt6d6uJ4h2Bf/ojIM2vYDT5SnHl0KEw5XAvQ6ELaV+I4QOT2D0ojOKbBBbTk
J7on1YA9bas7THA2e4fJs9wf0+x7iW81/j90EKeNkj/Jt0y69f3S/t/naoA589Ka
bzq3kmL0dPSQlxiGGMgs2+4CWUvVZLxEIqm+cIiTSYwZrA5+SXhN8+aIj4Euz63i
q2OC4v+6niY6K99mCb9DjW5W3g+Wq0srZBMsfXYinEwif4CQiK8F/SHmJtywZBKX
Gh5snoXEA1EywmQxPDVUDjuw5WUBTDbzGS/i/Y5t/2s7E5GcQYHyRxg030pLQUd6
K6yUqoatB0b88WR1Qu97epl2RE6Z4puF+rENkDrlY87fmtSd/gkdi62pm4CRx/qs
d+6ytS0j
=Ru3T
-----END PGP SIGNATURE-----

--vdd4uxtjfng5dx77--
