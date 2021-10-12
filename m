Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9137C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 08:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB596101D
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 08:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhJLI5p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 04:57:45 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:39896 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbhJLI5p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 04:57:45 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20211012085542epoutp037415fc346ba6ffeda66b3ba7bc2f2b15~tPKpizbn52695326953epoutp03j
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 08:55:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20211012085542epoutp037415fc346ba6ffeda66b3ba7bc2f2b15~tPKpizbn52695326953epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1634028942;
        bh=LO/n6aFzXs/XjEuuQtzhfJiNPn4XO6dA+JKwkXogSIo=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=dY9ZI+3PpyR09hxNSJqt4WSypxF0ieZheUr7i2PqPZwC9meWTuxKkgDG0g1US/N/l
         6KbB6O6NlXuyR2U7X+SMi2nHzsEperkR35dK1dm7dyADr1ZpLtVMsggHz3XdKFCJUD
         L/DDlmgel5Sf7kWPQ1waN2ZrmW5Iz9UvbUfjkEoY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20211012085542epcas2p48c19529f352229b9cd0f8ae4ece659ea~tPKpVQ4Ad2191121911epcas2p4H;
        Tue, 12 Oct 2021 08:55:42 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.98]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4HT8dP2FGVz4x9Ps; Tue, 12 Oct
        2021 08:55:37 +0000 (GMT)
X-AuditID: b6c32a48-d5fff70000002500-56-61654d85ccc6
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.95.09472.58D45616; Tue, 12 Oct 2021 17:55:33 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] block-map: added error handling for bio_copy_kern()
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <YWUqI/SkoJxYAeco@infradead.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20211012085533epcms2p687230b2ad95ec73653ddce6c29157ae4@epcms2p6>
Date:   Tue, 12 Oct 2021 17:55:33 +0900
X-CMS-MailID: 20211012085533epcms2p687230b2ad95ec73653ddce6c29157ae4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmhW6rb2qiwYu7ohar7/azWbw8pGlx
        esIiJou9t7QtLu+aw+bA6rF5hZbH5bOlHn1bVjF6fN4kF8ASlW2TkZqYklqkkJqXnJ+SmZdu
        q+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA7RTSaEsMacUKBSQWFyspG9nU5RfWpKq
        kJFfXGKrlFqQklNgXqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd8WLJacaC2cwVT761MzUwtjJ3
        MXJySAiYSKycfImxi5GLQ0hgB6PEpY29rF2MHBy8AoISf3cIg9QIC3hI7Nv0jAXEFhJQkji3
        ZhYjSImwgIHErV5zkDCbgJ7EzyUz2EBsEQFNiVvL25lBRjILLGeUaNvZzwqxi1diRvtTFghb
        WmL78q2MIDangK7EsRd3mCDiGhI/lvVC3SYqcXP1W3YY+/2x+YwQtohE672zUDWCEg9+7oaK
        S0o0TpgGNb9c4uryOSwgR0gIdDBKXF5yEyqhL3GtYyOYzSvgK3FxchszyDMsAqoSC9+nQZS4
        SBzZvxrsHmYBbYllC1+DlTADPbZ+lz6IKSGgLHHkFgvMVw0bf7Ojs5kF+CQ6Dv+Fi++Y94QJ
        olVNYlGT0QRG5VmIYJ6FZNUshFULGJlXMYqlFhTnpqcWGxWYwGM2OT93EyM47Wl57GCc/faD
        3iFGJg7GQ4wSHMxKIrx/bFIThXhTEiurUovy44tKc1KLDzGaAv04kVlKNDkfmHjzSuINTSwN
        TMzMDM2NTA3MlcR55/5zShQSSE8sSc1OTS1ILYLpY+LglGpg6vZTT9Rcu05t69eySAObvduT
        2PjrpJhPK2euUvTq2Kke5xN7yPn/PfaTyvZ8/8Rn/ezOc5N5zPSSz8sp4XdS9y5R/gPslltd
        fMvMV15fq53tNnv/dOYlt88Y5T7bt3Ff2tovRqf1Nlcr/vzYbJZ7crpjwpuTdjE3f7x4teve
        w0jRLVFMWsoJBpn9q3tEtFTDXl7+G2S0lF3naZxcVc6Z5L/3OoR6figfTLF4I6v26bzIb37J
        GVJlmu86zns1cknaM7uKWsS+Lj120v3R5N91TCbnjM65Ba0XeTM/7p3kX40TjQdr2s4YVLFz
        BGzoEk2/diXIMWmfQ95uq0V9U3yDdZ8fmtMpqbuH91gB41klluKMREMt5qLiRADauadvBAQA
        AA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210928063420epcms2p8f0cad25e1b820169755962ff4555d3ac
References: <YWUqI/SkoJxYAeco@infradead.org>
        <20210928063919epcms2p12ef0dfc94e6756f7bf85945522720e8f@epcms2p1>
        <CGME20210928063420epcms2p8f0cad25e1b820169755962ff4555d3ac@epcms2p6>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Christoph.

Thanks for your review.=20

>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int=C2=A0do_copy=C2=A0=
=3D=C2=A00;=0D=0A>=0D=0A>Please=C2=A0make=C2=A0this=C2=A0a=C2=A0bool.=C2=A0=
=C2=A0Otherwise=C2=A0the=C2=A0patch=C2=A0looks=C2=A0good.=0D=0A=0D=0AYes,=
=20bool=20is=20better.=20Will=20update=20in=20the=20next=20version.=20Thank=
s.=20=0D=0A=0D=0ABest=20Regards,=0D=0AJinyoung=20Choi
