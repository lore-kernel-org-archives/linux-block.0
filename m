Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E209FC433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 16:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351710AbiBKQtC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 11:49:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241409AbiBKQtC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 11:49:02 -0500
X-Greylist: delayed 543 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 08:49:00 PST
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6048D
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 08:49:00 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220211163950usoutp028917e9694cc95cd8fc939efb79c0d30d~SyMuFBpZq0067500675usoutp02d;
        Fri, 11 Feb 2022 16:39:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220211163950usoutp028917e9694cc95cd8fc939efb79c0d30d~SyMuFBpZq0067500675usoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644597590;
        bh=okhZfsf6x3mc2dzfgtTLYxzi3LXXdQBuaGFDqGvjuYg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=rA2sBxScUL2ge4IfeL8EquM1XeBkuIWZhjHs4BB77JRc++N8E1qVlhjcQcwD4rrfk
         HtT5M6mq28+dglOl10LOvzhpCBkUvcOLY6wh49kBggUGv2DryfTLJHPrzr7A4cgyEn
         kAkpTh35c6Z50Xjz31jTqGfBAcJMHP4yHEe4hYHA=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220211163950uscas1p10a9bf9ba15edde9108bb194d06ecd854~SyMt1KPrY2196021960uscas1p1q;
        Fri, 11 Feb 2022 16:39:50 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id FB.72.09744.65196026; Fri,
        11 Feb 2022 11:39:50 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220211163949uscas1p289777b5a4d42536fa523c94731a26524~SyMtiZRnG0925609256uscas1p2N;
        Fri, 11 Feb 2022 16:39:49 +0000 (GMT)
X-AuditID: cbfec36d-879ff70000002610-f9-620691569f04
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 2E.F8.09671.55196026; Fri,
        11 Feb 2022 11:39:49 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Fri, 11 Feb 2022 08:38:57 -0800
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Fri, 11 Feb 2022 08:38:57 -0800
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v1 1/1] block: Add handling for zone append command in
 blk_complete_request
Thread-Topic: [PATCH v1 1/1] block: Add handling for zone append command in
        blk_complete_request
Thread-Index: AQHYHyq76WJJcrCG/ku2y/IcDnSZj6yPE7qA
Date:   Fri, 11 Feb 2022 16:38:57 +0000
Message-ID: <20220211163942.GA227871@bgt-140510-bm01>
In-Reply-To: <20220211093425.43262-2-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
x-exchange-save: DSA
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <8042C884A0F8944890567CF34887AAE6@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djX87phE9mSDP72SFusvtvPZnF6wiIm
        i723tC1uTHjKaLHm5lMWB1aPnbPusntsXqHlcflsqcemVZ1sHp83yQWwRnHZpKTmZJalFunb
        JXBl/HijW3CHo2J770nmBsYG9i5GTg4JAROJA0eWsHYxcnEICaxklFj54BALhNPKJHF76WMm
        mKop6xvYQGwhgbWMEhuOsUEUfWSUePnkIlTHAUaJVdv3MoJUsQkYSPw+vpEZxBYR0JB4dmUz
        E0gRs8AuJoknl9aAjRIWSJS4s2keUDcHUFGSxMm98hD1RhK/z+9gAgmzCKhKPP2UDxLmFTCV
        2PLgKiuIzSlgJdG6eAvYKkYBMYnvp9aAHcosIC5x68l8qKMFJRbN3sMMYYtJ/Nv1kA3CVpS4
        //0l1PsiEuu+v2WD6NWTuDF1CpRtJ3H7WD8rhK0tsWzha2aIGwQlTs58wgLRKylxcMUNsN8l
        BC5wSLycfxlqgYtE3809UAukJa5en8oMUbSKUWLKtzZ2CGczo8SMXxeYJjCqzkJy+Swkl8xC
        csksJJfMQnLJAkbWVYzipcXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIFp6PS/w7k7GHfc+qh3
        iJGJg/EQowQHs5II74obrElCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZdlbkgUEkhPLEnNTk0t
        SC2CyTJxcEo1MM18qBuw6eDr1UePLZgwefK+0sffPq3trfleqePl6qIVES5/qaJ/zbO6U1P0
        Fsx5Zx3DUDatQU1ePPKfA6/2wqcCdue7VPN/TOxcMPVtTOGjP19f33qbdrurw6ddIHzClXLV
        P1r6PhceiAXW6Msesqv++SCY5cbN3trGmTLyW+9pVcd5zp6U6OKyYXE/s87S+SXdbVXndcom
        bfm+q3PpmVvzfgZ6+7nZTI7ryeRr7WYs/Pbx7CPxhpvtTa5WL/anVKVNcNU4tjBZiyvSqUTv
        zY7kE/Y//ujVau3O/ut8cq+4R7mOxlZWDi7Dc198Wk4f7tOcoS7HWcG/d/2LviPvpwVIP7jM
        +m57/M71tRuPWCixFGckGmoxFxUnAgA/UZAosgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsWS2cA0UTd0IluSwc5Nphar7/azWZyesIjJ
        Yu8tbYsbE54yWqy5+ZTFgdVj56y77B6bV2h5XD5b6rFpVSebx+dNcgGsUVw2Kak5mWWpRfp2
        CVwZP97oFtzhqNjee5K5gbGBvYuRk0NCwERiyvoGti5GLg4hgdWMEt/aF0E5Hxkl1sy9zAzh
        HGCU+NX5jAmkhU3AQOL38Y3MILaIgIbEsyubmUCKmAV2MUk8ubSGDSQhLJAocWfTPBaIoiSJ
        x0t3QNlGEr/P7wBq4OBgEVCVePopHyTMK2AqseXBVVaIZXsZJSYv/8gIkuAUsJJoXbwFzGYU
        EJP4fmoN2BHMAuISt57MZ4L4QUBiyZ7zzBC2qMTLx/9YIWxFifvfX0L9KSKx7vtbNohePYkb
        U6dA2XYSt4/1s0LY2hLLFr5mhjhIUOLkzCcsEL2SEgdX3GCZwCg5C8nqWUhGzUIyahaSUbOQ
        jFrAyLqKUby0uDg3vaLYMC+1XK84Mbe4NC9dLzk/dxMjMLZP/zscuYPx6K2PeocYmTgYDzFK
        cDArifCuuMGaJMSbklhZlVqUH19UmpNafIhRmoNFSZxXyHVivJBAemJJanZqakFqEUyWiYNT
        qoFJZ/XqhuzL2V+3v1AyFL0bNFsg8MA0A7tLeQaftQ6miExLm73xup5z0Kw9cxjuc8/U+tk1
        V//RzRW/OzZKMzzOdWJhDex2rbMMOvrh9+bqnDD5c7cmH9T/wjNbhefOQZfQ12WciaIlk6Td
        +vJSVB/0XHToeqstZRUp2rJ9l2/07xetH9tcazvfcfLf37+Uj3PDQx6LnxIJhlMEl4SJCV6R
        zNtn6sr314xlkk3E6omd9s+0184N1FKo+j/hSskL6ejdQQciaypuxPukKEsVr9nec+eWxqZH
        uTyxZfcOKopsXvlXoWd1161crdVbhOdFeU8J87QTcbXQfzX59p2oGF717wwaiQxPQn4dK3J5
        aqnEUpyRaKjFXFScCABJ+1m4XAMAAA==
X-CMS-MailID: 20220211163949uscas1p289777b5a4d42536fa523c94731a26524
CMS-TYPE: 301P
X-CMS-RootMailID: 20220211093602eucas1p1fe39e931232162a686b2feb06ea1f314
References: <20220211093425.43262-1-p.raghav@samsung.com>
        <CGME20220211093602eucas1p1fe39e931232162a686b2feb06ea1f314@eucas1p1.samsung.com>
        <20220211093425.43262-2-p.raghav@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 11, 2022 at 10:34:25AM +0100, Pankaj Raghav wrote:
> Zone append command needs special handling to update the bi_sector
> field in the bio struct with the actual position of the data in the
> device. It is stored in __sector field of the request struct.
>=20
> Fixes: 5581a5ddfe8d ("block: add completion handler for fast path")
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  block/blk-mq.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4b868e792ba4..6c2231e52991 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -736,6 +736,10 @@ static void blk_complete_request(struct request *req=
)
> =20
>  		/* Completion has already been traced */
>  		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
> +
> +		if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
> +			bio->bi_iter.bi_sector =3D req->__sector;
> +
>  		if (!is_flush)
>  			bio_endio(bio);
>  		bio =3D next;

Nice catch and thanks for including steps to reproduce.

Tested-by: Adam Manzanares <a.manzanares@samsung.com>

> --=20
> 2.25.1
> =
