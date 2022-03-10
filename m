Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCF2C433F5
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 17:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiCJRjn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 12:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiCJRjm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 12:39:42 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AB84C7A6
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 09:38:39 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220310173837usoutp01a6cd00f796c8664f04d0f5954dfbc225~bFawKJAAs2979729797usoutp01R;
        Thu, 10 Mar 2022 17:38:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220310173837usoutp01a6cd00f796c8664f04d0f5954dfbc225~bFawKJAAs2979729797usoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646933917;
        bh=E9P33HUeB0Z6addZR+NzNflnkmN2VBfsYulVgqSMn4U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Vt/GNEvayt6VjM5QUcD0DqS0bR0Vq32Ooo4RK0PktM67ZsxESwH++vG0aIgtZhmeM
         Y85K+Y9/5v1nXL6jAKS83xDrhFyBq4uHhv1rCDRHruOT4u/bSNIpjyUTg+c+bWj6/M
         LfBbAFmZvmPEvNCKc5AashfTs1toDSb1RzGbF36k=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220310173837uscas1p273ed1901c85c02c4405528e7c96fbff4~bFav8-krq1090910909uscas1p2W;
        Thu, 10 Mar 2022 17:38:37 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 57.4D.09744.D973A226; Thu,
        10 Mar 2022 12:38:37 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220310173836uscas1p2f96d9fff23f9abcddaffbbef28d725b8~bFavgiQYO1092210922uscas1p2Z;
        Thu, 10 Mar 2022 17:38:36 +0000 (GMT)
X-AuditID: cbfec36d-879ff70000002610-24-622a379dc5f7
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id BE.04.10042.C973A226; Thu,
        10 Mar 2022 12:38:36 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Thu, 10 Mar 2022 09:38:35 -0800
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Thu, 10 Mar 2022 09:38:35 -0800
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <matias.bjorling@wdc.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Topic: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Index: AQHYMw0mJrsy54HYKEakInde5wh546y457OAgACDpIA=
Date:   Thu, 10 Mar 2022 17:38:35 +0000
Message-ID: <20220310173835.GB89599@bgt-140510-bm01>
In-Reply-To: <20220310094725.GA28499@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B613F393D6DDEE4DB351D125FF75903C@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djXc7pzzbWSDJavY7VYfbefzeL32fPM
        FitXH2Wy6DnwgcXi/NvDTBaTDl1jtNh7S9ti/rKn7BYT2r4yW9yY8JTRYs3NpywW616/Z3Hg
        8fh3Yg2bx85Zd9k9zt/byOJx+Wypx6ZVnWwem5fUe+y+2QCUa73P6vF5k5xH+4FupgCuKC6b
        lNSczLLUIn27BK6MC4+WsxZM4a1oenKItYFxO1cXIyeHhICJxKTtl1m6GLk4hARWMkq8PTYZ
        ymllkrj9qZsJpupd0wN2iMRaRol3k+cyQzgfGSVmnf0D5RxglGg/Mp8FpIVNwEDi9/GNzCC2
        iICSxNNXZxlBipgFZrBK/Jlwjx0kISzgJdHxdi07RJG3xMp5bVC2lcTJK9vBBrEIqEp8/vQF
        7A5eoDs+9l9iBLE5BXQk5vXvAKthFBCT+H5qDVgNs4C4xK0n86HuFpRYNHsPM4QtJvFv10M2
        CFtR4v73l+wQ9XoSN6ZOYYOw7SSmn9nHCmFrSyxb+JoZYq+gxMmZT1ggeiUlDq64AQ4kCYHZ
        nBLt35ZALXCR2L1nEzuELS3x9+4yJoiiVYwSU761sUM4mxklZvy6AHWetcS/zmvsExhVZiG5
        fBaSq2YhuWoWkqtmIblqASPrKkbx0uLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMA0ePrf4dwd
        jDtufdQ7xMjEwXiIUYKDWUmEtylUI0mINyWxsiq1KD++qDQntfgQozQHi5I477LMDYlCAumJ
        JanZqakFqUUwWSYOTqkGJkPPgDUyjJOUbu1hS47JD1mQvqpBuLqx7nmZV9m6oizuuJJpq2Kn
        BJZPvn3L2L0jabOf4IJs+c2Om7lPXJcM172/JTfmeSbr6hSpF9NXuZSGqrTXpk3vOXh8O7P8
        kc0iaxyS9igVFj/mnS35/YXr2tQ5encePosQ1LZvYJ/R8YJVuuQp29fA2nvp7JJHrie6e0ix
        qVw6qMPruGINw49jN/VzvI9+05iWnPklMffI9PnqH22ELkvWpM8+oiQj/Woat3XjI9Xys1NW
        yH3xn+J/KP0l/wY91SdH5h58GGQQtyAkrqPy2hv9rCVBT23SW5taLzE8kmHexm6876KAC7u3
        yz6WVQ9O3tv5+eq93OQSJZbijERDLeai4kQAzABrdfIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWS2cA0SXeOuVaSwc5FFhar7/azWfw+e57Z
        YuXqo0wWPQc+sFicf3uYyWLSoWuMFntvaVvMX/aU3WJC21dmixsTnjJarLn5lMVi3ev3LA48
        Hv9OrGHz2DnrLrvH+XsbWTwuny312LSqk81j85J6j903G4ByrfdZPT5vkvNoP9DNFMAVxWWT
        kpqTWZZapG+XwJVx4dFy1oIpvBVNTw6xNjBu5+pi5OSQEDCReNf0gL2LkYtDSGA1o0TfnZes
        EM5HRomj93vZIJwDjBKPty5lA2lhEzCQ+H18IzOILSKgJPH01VlGkCJmgRmsEn8m3GMHSQgL
        eEl0vF3LDlHkLbFyXhuUbSVx8sp2FhCbRUBV4vOnL0wgNi/QHR/7LzFCbNvAKDH30zqwbZwC
        OhLz+neANTAKiEl8P7UGrIFZQFzi1pP5TBBPCEgs2XOeGcIWlXj5+B8rhK0ocf/7S3aIej2J
        G1OnsEHYdhLTz+xjhbC1JZYtfM0McYSgxMmZT1ggeiUlDq64wTKBUWIWknWzkIyahWTULCSj
        ZiEZtYCRdRWjeGlxcW56RbFRXmq5XnFibnFpXrpecn7uJkZg+jj973D0Dsbbtz7qHWJk4mA8
        xCjBwawkwtsUqpEkxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdl1MR4IYH0xJLU7NTUgtQimCwT
        B6dUA5O17LOtdwV2SRdX3bD9+Wrv41sCebn3FILDJlQY6lm0LPA+ssv+TcmHD/ZietLBJfdf
        fddp3xdqEThlZ/GFlNTKXJbOCyu+iq77JPNx5XO/zPudu4y/1n1aVa06Ze4epc2mewo5nu2b
        ZCrJOi/ze1LgjaaoCD3j2reLObtF7KLLfuYLJhucnWJsFi3I8Ci//LR+5AIDrQJWC92VAiXs
        6er6lesbn7tHbAq++UiGO+/d0jTteb/OyGj862xZ+aI75i7jsbftK59Pk6l0ENZ3uLZ9uZRH
        LceBaUbcwlnJ/gztRl90S460rPl9cYfDt+CdBd/yf8hcfFZx0my2ueqJk9G3d8kc4Z16e6bH
        kk6BS0osxRmJhlrMRcWJAEJ/93aOAwAA
X-CMS-MailID: 20220310173836uscas1p2f96d9fff23f9abcddaffbbef28d725b8
CMS-TYPE: 301P
X-CMS-RootMailID: 20220308165414eucas1p106df0bd6a901931215cfab81660a4564
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com>
        <20220308165349.231320-1-p.raghav@samsung.com>
        <20220310094725.GA28499@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 10, 2022 at 10:47:25AM +0100, Christoph Hellwig wrote:
> This is complete bonkers.  IFF we have a good reason to support non
> power of two zones size (and I'd like to see evidence for that) we'll
> need to go through all the layers to support it.  But doing this emulatio=
n
> is just idiotic and will at tons of code just to completely confuse users=
.
>=20
> On Tue, Mar 08, 2022 at 05:53:43PM +0100, Pankaj Raghav wrote:
> >=20
> > #Motivation:
> > There are currently ZNS drives that are produced and deployed that do
> > not have power_of_2(PO2) zone size. The NVMe spec for ZNS does not
> > specify the PO2 requirement but the linux block layer currently checks
> > for zoned devices to have power_of_2 zone sizes.
>=20
> Well, apparently whoever produces these drives never cared about supporti=
ng
> Linux as the power of two requirement goes back to SMR HDDs, which also
> don't have that requirement in the spec (and even allow non-uniform zone
> size), but Linux decided that we want this for sanity.

Non uniform zone size definitely seems like a mess. Fixed zone sizes that
are non po2 doesn't seem insane to me given that chunk sectors is no longer=
=20
assumed to be po2. We have looked at removing po2 and the only hot path=20
optimization for po2 is for appends.

>=20
> Do these drives even support Zone Append?

Should it matter if the drives support append? SMR drives do not support ap=
pend
and they are considered zone block devices. Append seems to be an optimizat=
ion
for users that want higher concurrency per zone. One can also build concurr=
ency
by leveraging multiple zones simultaneously as well.


