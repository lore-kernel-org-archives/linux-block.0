Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B22FA3740
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 20:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbiJ0UIB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 16:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbiJ0UIA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 16:08:00 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D760C87696
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 13:07:58 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20221027200757usoutp018293b72a8be077e79028ed81d9b9d1bd~iBeFZo_I-1689416894usoutp01l;
        Thu, 27 Oct 2022 20:07:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20221027200757usoutp018293b72a8be077e79028ed81d9b9d1bd~iBeFZo_I-1689416894usoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666901277;
        bh=oWXCRoPg8f3KJ3b/x1gPMwhgmO2nM2LzPXyZ/7aTD+Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=bPxogMB2zdk3Br8Rym+CKcMhI2WPPc03/M9KZbphLw2/Z0uex/8Y5DSHrKGfC3AY+
         mSLTgBJdG9tpGTymAC8aV6RqZaAeXjJ0Cz+k5UnNakrxvqBe2b9ozcqF/uLvunqlGW
         6tyX7ncVd6mUeg8wi+wS79Sb6QtjhKOt9SPescFM=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221027200757uscas1p2d7c98d6965403fa7f5186e4d32f8e740~iBeFQSIhU2078920789uscas1p29;
        Thu, 27 Oct 2022 20:07:57 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 91.DE.18126.C15EA536; Thu,
        27 Oct 2022 16:07:56 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221027200756uscas1p206196106ee2224a7653f1f2bc7ba31e9~iBeEqnwJ92117121171uscas1p2C;
        Thu, 27 Oct 2022 20:07:56 +0000 (GMT)
X-AuditID: cbfec36f-fe1ff700000146ce-65-635ae51cf87b
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 0E.53.32876.C15EA536; Thu,
        27 Oct 2022 16:07:56 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 27 Oct 2022 13:07:55 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Thu,
        27 Oct 2022 13:07:55 -0700
From:   Vincent Fu <vincent.fu@samsung.com>
To:     "kch@nvidia.com" <kch@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH] null_blk: allow REQ_OP_ZONE_RESET_ALL to configure
Thread-Topic: [PATCH] null_blk: allow REQ_OP_ZONE_RESET_ALL to configure
Thread-Index: AQHY2UFSYtFTFOUz/kSMWiXi9o84464jQiiA
Date:   Thu, 27 Oct 2022 20:07:55 +0000
Message-ID: <20221027200654.147600-1-vincent.fu@samsung.com>
In-Reply-To: <20221006050514.5564-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3CE7E7E502099B4AB08CEAA5166922D7@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZduzreV2Zp1HJBneu2lg8vTqLyWLvLW0H
        Jo/e5ndsHp83yQUwRXHZpKTmZJalFunbJXBlNHeuZi94z1rxYsY0xgbGdyxdjJwcEgImEs9u
        nWPvYuTiEBJYySgx/d0FRginlUli44SNbDBVB1rOQ1WtZZR4vf0pVNUnRokfb78zQTjLGCVm
        z1kOlOHgYBPQlHi7vwDEFBFQlZi9qQBkELNAmsSH5mfMIGFhAXeJ++91QcIiAh4SFzt2s0HY
        RhLd5x+xg9gsQJ1PTv9gBbF5BWwk9vT+ALuaU8BY4sWer2D1jAJiEt9PrWGCGC8ucevJfCaI
        mwUlFs3ewwxhi0n82/UQ6hdFifvfX7JD1OtILNj9iQ3CtpPY2H6NFcLWlli28DUzxF5BiZMz
        n0BDS1Li4IobLCDfSgjM5JBYv/kGI0TCReL1keesELa0xPQ1l6GK2hkl5m78AtU9gVHi+hMp
        CNta4l/nNfYJjCqzkBw+C8lRs5AcNQvJUbOQHLWAkXUVo3hpcXFuemqxUV5quV5xYm5xaV66
        XnJ+7iZGYDI5/e9w/g7G67c+6h1iZOJgPMQowcGsJMJ79kZ4shBvSmJlVWpRfnxRaU5q8SFG
        aQ4WJXHeqBlayUIC6YklqdmpqQWpRTBZJg5OqQYmnVRD4cNL/zemln6tarQ6xfGrKzIkqrTH
        7caLp/yC1+o+c57LkFCrkDCXuTQxecLJNY3JDuK5iR9eSMS6rxK/vkw45OOL15eP77UOVn2Z
        6XRic8R7Wc77OROFufc8Sr0qy2QvJdHg4Rsf+1pypZZX3ekDou4/q2YJmpi02am/yNK+t2j5
        hmXf53AsfPBk7sanDB+CdmnULDydd+qsTfqZEj9NHqej5VM+XFnTEr096fSq7ocs099O26G/
        KMdz79+K7tXKZ24uuff3qdrvPYY9X12Xpa5MjTm63o5NksP7kfu1M+FuKhOC9zvwVq7uzBCJ
        LKoXepCVylU7b1pqxvrffYlX49Zdvt7Hee3rp8VZSizFGYmGWsxFxYkA+RNaiJUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWS2cA0SVfmaVSywcdvihZPr85isth7S9uB
        yaO3+R2bx+dNcgFMUVw2Kak5mWWpRfp2CVwZzZ2r2Qves1a8mDGNsYHxHUsXIyeHhICJxIGW
        8+xdjFwcQgKrGSVW/X8JlhAS+MQo0XgmASKxjFHi4J5prF2MHBxsApoSb/cXgJgiAqoSszcV
        gJQzC6RJfGh+xgwSFhZwl7j/XhckLCLgIXGxYzcbhG0k0X3+ETuIzQLU+eT0D1YQm1fARmJP
        7w+orUYSmy+dZQaxOQWMJV7s+QrWyyggJvH91BomiFXiEreezGeCOF9AYsme88wQtqjEy8f/
        WCFsRYn731+yQ9TrSCzY/YkNwraT2Nh+jRXC1pZYtvA1M8QNghInZz6BBomkxMEVN1gmMErM
        QrJuFpJRs5CMmoVk1CwkoxYwsq5iFC8tLs5Nryg2zkst1ytOzC0uzUvXS87P3cQIjMHT/w7H
        7GC8d+uj3iFGJg7GQ4wSHMxKIrxnb4QnC/GmJFZWpRblxxeV5qQWH2KU5mBREuf1iJ0YLySQ
        nliSmp2aWpBaBJNl4uCUamDS4c1vNVu5Ubm6N4mJTa2g6eJsqdSW6ubCZ563/Pa+j2J2PKrB
        sORv0ZqF52/oLUwTVV33facolwjft4PdF6ZaetanNHfeuScr13Hhr9hFmzfc68+HfGr/tEXT
        6Pe6tXni/4zn6LG5vtNrMs2efGVn3xHWIt37cxaL/g9w/Xv1TDZzQTBX0beJhYHHPkSo8fHm
        HfrIcuuN35szrYXnr17bN8/Bt+fv6jfhC1c8zJvt+0LgtpFMcerhHV093GWWs1dKsixPKy4o
        WHRnti6Px29H5z3csRG13122LW5VFlZ9rmu1VOtAUJrUin9Tlbo7VTlCvPMnHZBQ/hJ+MWna
        0fze6kgv1at28lfcnu8sZlJiKc5INNRiLipOBABnDSXnMAMAAA==
X-CMS-MailID: 20221027200756uscas1p206196106ee2224a7653f1f2bc7ba31e9
CMS-TYPE: 301P
X-CMS-RootMailID: 20221027200756uscas1p206196106ee2224a7653f1f2bc7ba31e9
References: <20221006050514.5564-1-kch@nvidia.com>
        <CGME20221027200756uscas1p206196106ee2224a7653f1f2bc7ba31e9@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 05, 2022 at 10:05:13PM -0700, Chaitanya Kulkarni wrote:
>For a Zoned Block Device zone reset all is emulated if underlaying
>device doesn't support REQ_OP_ZONE_RESET_ALL operation. In null_blk
>Zoned mode there is no way to test zone reset all emulation present in
>the block layer since we enable it by default :-
>
>blkdev_zone_mgmt()
> blkdev_zone_reset_all_emulation() <---
> blkdev_zone_reset_all()
>
>Add a module parameter zone_reset_all to enable or disable
>REQ_OP_ZONE_RESET_ALL, enable it by default to retain the existing
>behaviour.
>
>Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

For the sake of completeness would it be reasonable to also provide a
means to set this option via configfs?

Vincent
