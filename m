Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4872C4332F
	for <linux-block@archiver.kernel.org>; Fri,  4 Nov 2022 18:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiKDSwR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Nov 2022 14:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKDSwQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Nov 2022 14:52:16 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824C44047B
        for <linux-block@vger.kernel.org>; Fri,  4 Nov 2022 11:52:13 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20221104185209usoutp02c1c66a64f69b92d8a9989a862fdf5017~kdmLnEImq2106321063usoutp02o;
        Fri,  4 Nov 2022 18:52:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20221104185209usoutp02c1c66a64f69b92d8a9989a862fdf5017~kdmLnEImq2106321063usoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667587929;
        bh=NOuBQosli2Y48f3Blx3x6jaEx4SXjcNBtv1ClVgFYcg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=rhCqRxgYMuO9DC2ceXwIipbgzpxb+lvCAA+pHivF4wux/gokYelhFnrrmoJX52LDn
         wULmZ2HU+arZFjkDY4NXBNa3dXsyqq7WfJM/VaWidk7Gz9Rzq+EoNcRJEqybRskE+o
         sYcsk4M3SOxw4wgefQcXTLlVnp+yzcO9SiiIeyUs=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221104185208uscas1p234b1e82577d2a0bc011d25b4863ee7ba~kdmLaA36o2181321813uscas1p2D;
        Fri,  4 Nov 2022 18:52:08 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 50.F6.65516.85F55636; Fri, 
        4 Nov 2022 14:52:08 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221104185208uscas1p21733e4e32f43eeb836b7290e6b293fb9~kdmLA5l5d2209322093uscas1p2-;
        Fri,  4 Nov 2022 18:52:08 +0000 (GMT)
X-AuditID: cbfec36d-5b5ff7000000ffec-12-63655f5853a2
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 45.9D.19363.85F55636; Fri, 
        4 Nov 2022 14:52:08 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Fri, 4 Nov 2022 11:52:07 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Fri,
        4 Nov 2022 11:52:07 -0700
From:   Vincent Fu <vincent.fu@samsung.com>
To:     "kch@nvidia.com" <kch@nvidia.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH] null_blk: allow REQ_OP_ZONE_RESET_ALL to configure
Thread-Topic: [PATCH] null_blk: allow REQ_OP_ZONE_RESET_ALL to configure
Thread-Index: AQHY2UFSYtFTFOUz/kSMWiXi9o84464jQiiAgAgrVgCABFI4gA==
Date:   Fri, 4 Nov 2022 18:52:07 +0000
Message-ID: <20221104185124.181754-1-vincent.fu@samsung.com>
In-Reply-To: <6270de4e-9f4a-fcfc-c4f1-d0ede32352bb@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <62AE1423D51C74469A24323CB731234E@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduzred2I+NRkg2OrLSzeH3zMavH06iwm
        i723tB2YPXqb37F5fN4kF8AUxWWTkpqTWZZapG+XwJVxo2Ura0Evd0XD7dVsDYwzOLsYOTkk
        BEwkPj5Zwd7FyMUhJLCSUeLJl+msEE4rk8Tzh7+ZYar2r3jNCJFYyyjxu3sfG4TzkVGiZdpm
        FghnKaPErdPPgDIcHGwCmhJv9xeAdIsIBEvMebuVDcRmFkiT+ND8jBmkRFjAXeL+e12IEg+J
        ix272SBsJ4nuLbvYQWwWARWJo0c2g9m8AjYSf1euZgWxOQXsJKY++coIYjMKiEl8P7WGCWK8
        uMStJ/OZII4WlFg0ew/UA2IS/3Y9ZIOwFSXuf3/JDlGvI7Fg9yeo0+wklk78CzVHW2LZwtfM
        EHsFJU7OfMIC0SspcXDFDbB3JQTmckh09K5jBPlFQsBFouGZPUSNtMTV61OZIWraGSXmbvwC
        1TyBUeL6EykI21riX+c19gmMKrOQ3D0LyU2zkNw0C8lNs5DctICRdRWjeGlxcW56arFhXmq5
        XnFibnFpXrpecn7uJkZgWjn973DuDsYdtz7qHWJk4mA8xCjBwawkwvtpW3KyEG9KYmVValF+
        fFFpTmrxIUZpDhYlcd6oGVrJQgLpiSWp2ampBalFMFkmDk6pBqbVViu47xjobrvbGG4k8n3R
        NZskI//JwSEHbznejv82K5n76ZXgR0/9LA6VPMtgv3jj8PawZzFNO//95RI6XXLoznxRt2iR
        uQH6z7tSuGznmkVdu+nqtWDizqTdKlcOTLyXeMw781f9Ecb2chfDSdtPm/814ItIbfHQeOr8
        QC+6zozLpf7CZOZ5nCdUf+74G857zdn+3EHmj1pWOTZ5uhJ5ESyxr5KznjDp2VmK7M+OsXzM
        fvHdUgOp/PUXWq4ZCUVoR10SMFeqqZyseMXuXu3uxBnnsw+wPDpyY/rmvBtNL6v23KmZe+X9
        lpAJghYTbMrmqzJHv9m+qzA64M2mLrO1P7bulXs0q8WmT++55jslluKMREMt5qLiRABZlAsC
        mgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWS2cA0UTciPjXZ4NcZGYv3Bx+zWjy9OovJ
        Yu8tbQdmj97md2wenzfJBTBFcdmkpOZklqUW6dslcGXcaNnKWtDLXdFwezVbA+MMzi5GTg4J
        AROJ/SteM3YxcnEICaxmlFg4/R0LhPORUWLn1s1QzlJGiU+3fzN3MXJwsAloSrzdXwDSLSIQ
        LDHn7VY2EJtZIE3iQ/MzsBJhAXeJ++91IUo8JC527GaDsJ0kurfsYgexWQRUJI4e2Qxm8wrY
        SPxduZoVYtVbRolXX2czgiQ4Bewkpj75CmYzCohJfD+1hglil7jErSfzmSA+EJBYsuc8M4Qt
        KvHy8T9WCFtR4v73l+wQ9ToSC3Z/grrTTmLpxL9Qc7Qlli18zQxxhKDEyZlPWCB6JSUOrrjB
        MoFRYhaSdbOQjJqFZNQsJKNmIRm1gJF1FaN4aXFxbnpFsWFearlecWJucWleul5yfu4mRmBM
        nv53OHIH49FbH/UOMTJxMB5ilOBgVhLh/bQtOVmINyWxsiq1KD++qDQntfgQozQHi5I4r5Dr
        xHghgfTEktTs1NSC1CKYLBMHp1QD05WzU5n+pn9fyemgVWJtwjvryY21MSHXXv9fn3JSTb4v
        LOK0TuTvouiIpI3e86yNP5UuNF0/K3bd30116QbCFsFTu3wWMW5YEHM6007s5tqHck9ec55w
        E99g8I63WsZcy/htWVlz8MfyBI7Lrzpy1zB8cZVmvROpuWp+q3ivQbBYwRNJPzOXvRyr12u6
        def5zRexXFCwIur+1JnVHIUMEg3GjjErp4cH33i6UnRKZgLfwadJSX4yuizLBToma/6VtfEV
        9DnxpjxewN46qP/eUzuDx2XbHlSsePjl3wVJpr9yr8z9wubd6FmnfPXFWekK5w/T5iVOPLX3
        fnfYaqbpzgvvmIu/1ZrgYzatuXiyEktxRqKhFnNRcSIA5Zs52zgDAAA=
X-CMS-MailID: 20221104185208uscas1p21733e4e32f43eeb836b7290e6b293fb9
CMS-TYPE: 301P
X-CMS-RootMailID: 20221027200756uscas1p206196106ee2224a7653f1f2bc7ba31e9
References: <20221006050514.5564-1-kch@nvidia.com>
        <CGME20221027200756uscas1p206196106ee2224a7653f1f2bc7ba31e9@uscas1p2.samsung.com>
        <20221027200654.147600-1-vincent.fu@samsung.com>
        <6270de4e-9f4a-fcfc-c4f1-d0ede32352bb@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 02, 2022 at 12:52:06AM +0000, Chaitanya Kulkarni wrote:
>On 10/27/22 13:07, Vincent Fu wrote:
>> On Wed, Oct 05, 2022 at 10:05:13PM -0700, Chaitanya Kulkarni wrote:
>>> For a Zoned Block Device zone reset all is emulated if underlaying
>>> device doesn't support REQ_OP_ZONE_RESET_ALL operation. In null_blk
>>> Zoned mode there is no way to test zone reset all emulation present in
>>> the block layer since we enable it by default :-
>>>
>>> blkdev_zone_mgmt()
>>> blkdev_zone_reset_all_emulation() <---
>>> blkdev_zone_reset_all()
>>>
>>> Add a module parameter zone_reset_all to enable or disable
>>> REQ_OP_ZONE_RESET_ALL, enable it by default to retain the existing
>>> behaviour.
>>>
>>> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>>
>> For the sake of completeness would it be reasonable to also provide a
>> means to set this option via configfs?
>>
>> Vincent
>
>I deliberately avoided that as I don't see any need for it as of now.
>but if it is a hard requirement I Can certainly send V2 with configfs
>param.
>
>-ck

I think the default should be to have features available as both module
options and via configfs unless there are good reasons to make an
exception.

https://lore.kernel.org/linux-block/f0dadb60-c02d-d569-3004-81eafeebb95f@ke=
rnel.dk/
https://lore.kernel.org/linux-block/ca206223-112f-2d60-34a3-bb7e6295de7a@ke=
rnel.dk/

Vincent=
