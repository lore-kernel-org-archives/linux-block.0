Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C89CCA480
	for <linux-block@archiver.kernel.org>; Thu,  7 Jul 2022 20:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiGGUyQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jul 2022 16:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbiGGUyO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2022 16:54:14 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5AC2ED6D
        for <linux-block@vger.kernel.org>; Thu,  7 Jul 2022 13:54:12 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220707205408usoutp014a35be4ef1f304cc8f90130eccc7be78~-p2blxZK51458514585usoutp01g;
        Thu,  7 Jul 2022 20:54:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220707205408usoutp014a35be4ef1f304cc8f90130eccc7be78~-p2blxZK51458514585usoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657227248;
        bh=OTaFPl7pNfjbVQIasNX4U8UhTKJbeXyDaRbKTsVUEiw=;
        h=From:To:CC:Subject:Date:References:From;
        b=q/ED6PiQtTe8XzxhiDYIzxUV3eqiuufRPic2jcdjZ20AQoT8tk9rW9imEJTTKG4VO
         WjVVd7de7kxPoFIZuR6Lqp1dou/O4bBplIVWHyj6HeNIURhDOH9SuhV1Mj9fyUXjED
         pNYswkOhxHMji8pObQeJfGdeOD9CHZ90rOWSP77c=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220707205408uscas1p24b90336c0e1c7971f745b442df9c15ad~-p2bZ9gHS0168401684uscas1p2K;
        Thu,  7 Jul 2022 20:54:08 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 46.C8.09642.FE747C26; Thu, 
        7 Jul 2022 16:54:08 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220707205407uscas1p10e5bf9f9758dc5acfa3712c3f3c848c6~-p2bCx8jw0573005730uscas1p1U;
        Thu,  7 Jul 2022 20:54:07 +0000 (GMT)
X-AuditID: cbfec36f-c15ff700000025aa-fd-62c747ef492c
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 9F.BC.52349.FE747C26; Thu, 
        7 Jul 2022 16:54:07 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 7 Jul 2022 13:54:06 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Thu,
        7 Jul 2022 13:54:06 -0700
From:   Vincent Fu <vincent.fu@samsung.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>
Subject: [PATCH 0/2] null_blk: harmonize some module parameter and configfs
 options
Thread-Topic: [PATCH 0/2] null_blk: harmonize some module parameter and
        configfs options
Thread-Index: AQHYkkOy2ZlLii6YFkuT20APqeTVuw==
Date:   Thu, 7 Jul 2022 20:54:06 +0000
Message-ID: <20220707205401.81664-1-vincent.fu@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7djX87of3I8nGcx7wGSx+m4/m8XeW9oO
        TB6Xz5Z6fN4kF8AUxWWTkpqTWZZapG+XwJXRN+UsS0ErS8XNRetZGhiXMHcxcnJICJhIHNh4
        lQnEFhJYySixYHJAFyMXkN3KJLF9zRYWmKI9v/ewQhStZZSYetMSougjo8TX93dYIJyljBKX
        Dy9n7GLk4GAT0JR4u78ApEFEIE3ixJUV7CA2s0CERPOCeWCbhQVCJdoP/2EHKRcRiJLY9qEE
        wtSTOHk+C6SCRUBFonNqC9gJvALWEh9u3WIEsRkFxCS+n1rDBDFRXOLWk/lMEGcKSiyavQfq
        LzGJf7seskHYihL3v7+EukBP4sbUKWwQtrbEsoWvmSHmC0qcnPkE6l1JiYMrboB9JSHwlV2i
        89lPqEEuEn0rdrFD2NISV69PZYYoameUmLvxC1T3BEaJ60+kIGxriX+d16A280n8/fUIHDwS
        ArwSHW1CExiVZiH5YRaS+2YhuW8WkvsWMLKsYhQvLS7OTU8tNspLLdcrTswtLs1L10vOz93E
        CEwWp/8dzt/BeP3WR71DjEwcjIcYJTiYlUR445WPJwnxpiRWVqUW5ccXleakFh9ilOZgURLn
        XZa5IVFIID2xJDU7NbUgtQgmy8TBKdXAFPZ3rY5lu/GmuTpF3O9r8nwavuqdjtrUoB5fuFTq
        Z9dL/8xX16+6Xef4aeywfPOM547VO6bf6st/++qSixKPSs3C6K69TT3x631uZK+LtuAqmlpi
        /D5jM1fq7yOey3z0zzlxthU+WjEpk/12lJ9F6b64Cw/5JlRFx/js3Si9bv87ZsHiQyqqWhf3
        lcu923h9l+AV6dx7y5eqzV740Lt95qENOnPlFl9VSjm50q/0x2zLz/tkmzcsnhrkUdcx3+/K
        57Q5xvUpvv3d92IXvmu4e0DA953Kq1kb7k96+Vl65a2C5qd1U+8u3rZwm1b3+q+rHa7yfp1/
        1dDLVmj523cP1vq+nPZie16qzUn2ju5ThWFKLMUZiYZazEXFiQDjam9ehQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWS2cA0Sfe9+/Ekg+X7lCxW3+1ns9h7S9uB
        yePy2VKPz5vkApiiuGxSUnMyy1KL9O0SuDL6ppxlKWhlqbi5aD1LA+MS5i5GTg4JAROJPb/3
        sHYxcnEICaxmlOh/0sEM4XxklOi5MZkRpEpIYCmjxN4fVV2MHBxsApoSb/cXgIRFBNIkTlxZ
        wQ5iMwtESDQvmAc2VFggVKL98B92iJooiYP9UxhBWkUE9CROns8CCbMIqEh0Tm1hAbF5Bawl
        Pty6BbaJUUBM4vupNUwQI8Ulbj2ZzwRxp4DEkj3noW4WlXj5+B8rhK0ocf/7S6gT9CRuTJ3C
        BmFrSyxb+JoZYr6gxMmZT1gg6iUlDq64wTKBUXQWkhWzkLTPQtI+C0n7AkaWVYzipcXFuekV
        xYZ5qeV6xYm5xaV56XrJ+bmbGIExcvrf4cgdjEdvfdQ7xMjEwXiIUYKDWUmEN175eJIQb0pi
        ZVVqUX58UWlOavEhRmkOFiVxXiHXifFCAumJJanZqakFqUUwWSYOTqkGpjyHS17uaw7W+un/
        6TsVl6wT7KP7VaNk6vZTzE03LNZ+btmx7KiytVDlDk3++9uurvQ0/eua8yY5ymDdnNuBssxe
        9sK72Sdz164oitcOXWIgue7P44i/LTezWI4KKS3793HvG+6ff1eqe23rfV24p8C0mXGR5q3u
        5o/ltX+4vDevWWsWH357gX2VcR8D49tXqs9XPz6/YcFfiRgZ25Xqs7S2b91yJE7o0LT8p43M
        eyKztJmE5M/OSDP+cCls0TWWlDSPzGWOk7x4LXj28X82ecF7ZILa5aO2N25XLz+79/Cct1UP
        7WbO/G8naJrTdecQ7+zk1W9EWpLP3HfZwLZ/trVMUta6gs63BZbmnk2HjymxFGckGmoxFxUn
        AgCOfPZwAAMAAA==
X-CMS-MailID: 20220707205407uscas1p10e5bf9f9758dc5acfa3712c3f3c848c6
CMS-TYPE: 301P
X-CMS-RootMailID: 20220707205407uscas1p10e5bf9f9758dc5acfa3712c3f3c848c6
References: <CGME20220707205407uscas1p10e5bf9f9758dc5acfa3712c3f3c848c6@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These patches add plumbing to allow some options that could formerly only b=
e
set via module parameters to now be set via configfs and vice versa.

Vincent Fu (2):
  null_blk: add module parameters for 4 options
  null_blk: add configfs variables for 2 options

 Documentation/block/null_blk.rst  | 22 ++++++++++++++++++
 drivers/block/null_blk/main.c     | 38 ++++++++++++++++++++++++++++---
 drivers/block/null_blk/null_blk.h |  2 ++
 3 files changed, 59 insertions(+), 3 deletions(-)

--=20
2.25.1
