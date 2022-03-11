Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A589C433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 22:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiCKWtv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiCKWte (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 17:49:34 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DF02A0333
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 14:23:36 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220311222335usoutp016390bb1f1b3969ba168e7bb2d1c6b14a~bc81_kcsP1425314253usoutp017;
        Fri, 11 Mar 2022 22:23:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220311222335usoutp016390bb1f1b3969ba168e7bb2d1c6b14a~bc81_kcsP1425314253usoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647037415;
        bh=e2KfYdPmHjXHf5iApFx0Xcj6H+UqG8ehsqB/kIWQmk8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=jlvrqMvw6Uh+oHfY0zXtAxSMn0q5pJvlJN1qTxGa244mhRyifjXqnr4bpfFnoI3Gf
         hT+NZUjec3rfKqTalXw2sCCcRNHs2MltWG1wFZN9zGscX0mof6IV0glkVCdhj5JBrL
         74ln+u9/oWDlg+TjnSNNj1c7rdhpsYRHmBSvLBQw=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220311222335uscas1p15c36105bca0a02d5c417eef730ff7970~bc812Z9LJ0368003680uscas1p15;
        Fri, 11 Mar 2022 22:23:35 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 1A.BD.09744.6EBCB226; Fri,
        11 Mar 2022 17:23:34 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220311222334uscas1p29231a37e852132dcf387fa70335e0dc1~bc81RSJbb0910309103uscas1p2H;
        Fri, 11 Mar 2022 22:23:34 +0000 (GMT)
X-AuditID: cbfec36d-879ff70000002610-51-622bcbe656ea
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id C8.94.10042.6EBCB226; Fri,
        11 Mar 2022 17:23:34 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Fri, 11 Mar 2022 14:23:33 -0800
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Fri, 11 Mar 2022 14:23:33 -0800
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <matias.bjorling@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Topic: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Index: AQHYMw0mJrsy54HYKEakInde5wh546y457OAgAA1PQCAAB3bgIAB7+AAgAAI7oCAABmtgA==
Date:   Fri, 11 Mar 2022 22:23:33 +0000
Message-ID: <20220311222326.GA110401@bgt-140510-bm01>
In-Reply-To: <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <ACD69D11DC8E32498D505F6F440E2239@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djX87rPTmsnGfT1m1msvtvPZvH77Hlm
        i5WrjzJZ9Bz4wGJx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5MeMposebmUxaLda/fszjw
        ePw7sYbNY+esu+we5+9tZPG4fLbUY9OqTjaPzUvqPXbfbADKtd5n9fi8Sc6j/UA3UwBXFJdN
        SmpOZllqkb5dAlfGrKZpbAX3uSuObLjH3sA4m7OLkZNDQsBE4vK+gyxdjFwcQgIrGSU2/m5l
        g3BamSR2HlzMBlPVOW0LO0RiLaPEpN2bmCGcj4wSG85PgOo/wCix9ulhJpAWNgEDid/HNzKD
        2CICyhJ3589kBSliFpjJKvFs2lQWkISwgJdEx9u17BBF3hIr57UB2RxAdphEzxdGkDCLgKrE
        5AkgvZwcvAKmEocOd4DZnAJOEhtuHwA7j1FATOL7qTVge5kFxCVuPZnPBHG2oMSi2XuYIWwx
        iX+7HkK9oyhx//tLdoh6PYkbU6ewQdh2EgtO/oOaoy2xbOFrZoi9ghInZz5hgeiVlDi44gbY
        wxICszklpk7+BzXURWLSlwZWCFta4u/dZUwQRasYJaZ8a2OHcDYzSsz4dQHqPGuJf53X2Ccw
        qsxCcvksJFfNQnLVLCRXzUJy1QJG1lWM4qXFxbnpqcWGeanlesWJucWleel6yfm5mxiBSfD0
        v8O5Oxh33Pqod4iRiYPxEKMEB7OSCG9TqEaSEG9KYmVValF+fFFpTmrxIUZpDhYlcd5lmRsS
        hQTSE0tSs1NTC1KLYLJMHJxSDUxruM8lNcaYZKtfrnJcWfm2qubR+QfnFr7zagpQE0mPnzn1
        59+uR1/urNri4njb/sGaFNXLfYn+HOu1/tRcCebi/+Hg9qj/aecdowW/k++yBhcnLXuXyGmf
        HffmVJInU72PZv4N0StJRal9r1i7pmwrkbDYlj3vRb580KSmWwd/aD7RLnQ/Y6D0LTAh678y
        05m98l9UZHgV3pcJOi13Znl7LmEF55a+xV/XKTh8tpe/v4NDlWNyuNNU4S5xRtdk5QWz/Hev
        i6nNKXgoalx9MWmdpsUfPlcfU8mnexf+4Bf1MNz7ZFXW86enjP/xbl7aq9L5OGfe71QdsQnF
        Yp4nFkSUMqmel9kyN9D96uNHW5RYijMSDbWYi4oTAZmceDjxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsWS2cA0SffZae0kg/n3RCxW3+1ns/h99jyz
        xcrVR5kseg58YLE4//Ywk8WkQ9cYLfbe0raYv+wpu8WEtq/MFjcmPGW0WHPzKYvFutfvWRx4
        PP6dWMPmsXPWXXaP8/c2snhcPlvqsWlVJ5vH5iX1HrtvNgDlWu+zenzeJOfRfqCbKYArissm
        JTUnsyy1SN8ugStjVtM0toL73BVHNtxjb2CczdnFyMkhIWAi0TltC3sXIxeHkMBqRonHUx+x
        QjgfGSVWnp8FlTnAKNFzr4cVpIVNwEDi9/GNzCC2iICyxN35M8HizAIzWSXW39QHsYUFvCQ6
        3q5lh6jxllg5rw3I5gCywyR6vjCChFkEVCUmT4Bo5RUwlTh0uANq8QsmiTervoPN5xRwkthw
        +wAbiM0oICbx/dQaJohd4hK3nsxngnhBQGLJnvPMELaoxMvH/1ghbEWJ+99fskPU60ncmDqF
        DcK2k1hw8h/UHG2JZQtfM0McIShxcuYTFoheSYmDK26wTGCUmIVk3Swko2YhGTULyahZSEYt
        YGRdxSheWlycm15RbJSXWq5XnJhbXJqXrpecn7uJEZg6Tv87HL2D8fatj3qHGJk4GA8xSnAw
        K4nwNoVqJAnxpiRWVqUW5ccXleakFh9ilOZgURLnfRk1MV5IID2xJDU7NbUgtQgmy8TBKdXA
        VJYS+m59+KuXrvLfjyf9u6dfpRNV8Ch76Trv9e2PBNOMxbp/2EjpG55hfJL5/f1rT7nZV3bd
        uuKrPINH7khOyoega216y43uTr+zeeu1uplnHcxbMm5fc9zdb+3L6HboldXnTREHpQ/+uDo3
        94+gyrzqvjLLD3e3n5Hj/nyTvcx66tumyndhQkv2tX1P50ma5KwjeX7+jWXpjIfCrDgrHAOf
        c19rk3cvuDov96zloaWxpxeUX7y23LNb/eaZiN3bhHvZ5lyS6dui/F9f5YzyT6Fjdxhd5i35
        HLPwOONRtym87JwJqb8uXttS6PuldvaGVyv6zlU6vpX89NejPtHwq8uTidavuR+82Of1Sej/
        zG9KLMUZiYZazEXFiQDIwYOijAMAAA==
X-CMS-MailID: 20220311222334uscas1p29231a37e852132dcf387fa70335e0dc1
CMS-TYPE: 301P
X-CMS-RootMailID: 20220308165414eucas1p106df0bd6a901931215cfab81660a4564
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com>
        <20220308165349.231320-1-p.raghav@samsung.com>
        <20220310094725.GA28499@lst.de>
        <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
        <20220310144449.GA1695@lst.de> <Yiuu2h38owO9ioIW@bombadil.infradead.org>
        <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 11, 2022 at 12:51:35PM -0800, Keith Busch wrote:
> On Fri, Mar 11, 2022 at 12:19:38PM -0800, Luis Chamberlain wrote:
> > NAND has no PO2 requirement. The emulation effort was only done to help
> > add support for !PO2 devices because there is no alternative. If we
> > however are ready instead to go down the avenue of removing those
> > restrictions well let's go there then instead. If that's not even
> > something we are willing to consider I'd really like folks who stand
> > behind the PO2 requirement to stick their necks out and clearly say tha=
t
> > their hw/fw teams are happy to deal with this requirement forever on ZN=
S.
>=20
> Regardless of the merits of the current OS requirement, it's a trivial
> matter for firmware to round up their reported zone size to the next
> power of 2. This does not create a significant burden on their part, as
> far as I know.

I can't comment on FW burdens but adding po2 zone size creates holes for th=
e=20
FW to deal with as well.

>=20
> And po2 does not even seem to be the real problem here. The holes seem
> to be what's causing a concern, which you have even without po2 zones.
> I'm starting to like the previous idea of creating an unholey
> device-mapper for such users...

I see holes as being caused by having to make zone size po2 when capacity i=
s=20
not po2. po2 should be tied to the holes, unless I am missing something. BT=
W if
we go down the dm route can we start calling it dm-unholy.
