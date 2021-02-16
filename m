Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21D6C433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 02:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E11864DE8
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 02:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhBPCSn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Feb 2021 21:18:43 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:62455 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhBPCRV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Feb 2021 21:17:21 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210216021638epoutp02028bd9483df5fb40fbfd06d7a8220e8a~kGMSBDffq2840328403epoutp02T
        for <linux-block@vger.kernel.org>; Tue, 16 Feb 2021 02:16:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210216021638epoutp02028bd9483df5fb40fbfd06d7a8220e8a~kGMSBDffq2840328403epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613441798;
        bh=n1KzZnGEZkk8b8SNO/1FHhADCqXsgE9FiTKZipApFhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBPOvNxeNG2Ucct3qvxxCMCUhTTsPE+GHcE423lCly4k+7IajZkwo8Xh4/cPAHxCR
         +04ZFz/19x2I1ynwTHPccAnq8hIMn8xt6C2BtuWMv7ioJQKGxouOvAmOAHkSubzFMy
         XoOw6ThBujYcFSMNtJ7RXc96FJA8fxl9WDczFlcA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210216021638epcas1p24f11c0cdfdcfe6f313602eb68f3f9ccb~kGMRXPGh-0077800778epcas1p25;
        Tue, 16 Feb 2021 02:16:38 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Dfl2r47Bzz4x9Q9; Tue, 16 Feb
        2021 02:16:36 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.B5.10463.40B2B206; Tue, 16 Feb 2021 11:16:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210216021636epcas1p31748fea01f2c9638216f8d8b3b3b3712~kGMPdb02S2589325893epcas1p3N;
        Tue, 16 Feb 2021 02:16:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210216021635epsmtrp24dfa0f30ee37de8d541400e8bcddfa95~kGMPcFs4K0160501605epsmtrp2o;
        Tue, 16 Feb 2021 02:16:35 +0000 (GMT)
X-AuditID: b6c32a38-49247a80000028df-20-602b2b04df95
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.AD.13470.30B2B206; Tue, 16 Feb 2021 11:16:35 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210216021635epsmtip2de714b89fad651bfbf8674dba59fccad~kGMPH8Fmu3084730847epsmtip2Z;
        Tue, 16 Feb 2021 02:16:35 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, gregkh@linuxfoundation.org,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com, osandov@fb.com,
        patchwork-bot@kernel.org, tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
Subject: [PATCH v5 1/2] bio: limit bio max size
Date:   Tue, 16 Feb 2021 11:00:32 +0900
Message-Id: <20210216020032.19792-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210204010156.5105-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbVBUVRjHO/cudxccnBuQnKEG1ls08r4XWDgqEE1ql5EmJphBdGpZ2TsL
        tm/cu+uU0wdoBeVdZJRxgTRFqY3c5C3W2Ah2zEDRBtSUEYWigSCBYcNKjdrlwsS35/88v+f8
        z3NeJLjfJBEkKdAZWU6n1FCEj6jLGRYTJYqIyJVdsgejRmsXQF+M1RCo5MhjDJnP2Qh07dhZ
        DFVOfuyF/il/gKGlCR45RiPQyOVGAvXXmTFU396II+eD2yI00VyLoxsDi17ok19S0ZOWKwDN
        //WTGA121+HI5vibSA1gas1zYsZuGRMz7Z+FMyNDJqbNWkYwvU2tYmb+29sEU91hBYyrLZg5
        8l0FluGzV5OUzypVLCdldXl6VYFOnUztzlS8oZAnyOgoeitKpKQ6pZZNpnakZ0TtKtC4Z6Ok
        B5UakzuVoeR5KiYlidObjKw0X88bkynWoNIYaJkhmldqeZNOHZ2n126jZbJYuZvM1eSPzE96
        GXI+uPbNV6IisLMceEsgGQ/HKpxEOfCR+JHdAI5fLV0ViwAunDstFsRjAG01LmKt5VZVORAK
        DnfBMi0ShAvAgZlOLw9FkJGw+tHoyloBZCcGD99x4h6Bk3YAZ79uwD2UPxkDndYyzBOLyFA4
        1nVixcOX3A7vVziB4BcCf61qWeG93fmjzbdWmefhwKlJkSfG3Yy5s2HFAJLTEti6PLu62R3w
        c2eXSIj94czVDrEQB0HXnIMQGioANJeeBoI4BmDz1AVMoOLgosvlLkjcFmHQdjlGSG+G9qdN
        QHDeCOeWKr08CCR94dFSPwF5BV4//BBf85r60o4JCANHuzYKx1UNoLNhUnwMSC3r5rGsm8fy
        v/EZgFvBJtbAa9UsTxvi199xG1h57uGoGzQ9WojuB5gE9AMowakAX7ErPNfPV6X88BDL6RWc
        ScPy/UDuPu1aPOiFPL37v+iMCloeGxcXh+ITEhPkcVSg737ZuMKPVCuN7Pssa2C5tT5M4h1U
        hOGOnJ099xPT8MifQ3oGFtSSvpPv7p4ZoF8qPtX+rJ9rKdl3vjghdNiWtoe5YcpuCvm053hU
        StnFipSzBT+Yng3mtFvOG2nXRNmV10eHssT7vw9PTtvzoz+ipYy8F9zbNRz7ZlvDheL6oppp
        +wL+3IbIsN9kJZmWifzAVutTlTZo2TlMbU8/9Np1Ov345sK3HE6bXNV94OaTJCs3laOou8dJ
        E7PIwrDuJHwJvLdlU2925r5Lgduql/0r7/67Qaor/ChL50oza7OyUw/47y20/a4Npt4+eCZx
        6MWXqwyzoOPPweJgsfrkzT8u9nnXF99ZvFs6bsP6Hoa2c+9wr27J2hpVQon4fCUdjnO88j9I
        nwXldwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSvC6ztnaCwZsfxhZzVm1jtFh9t5/N
        orX9G5NF8+L1bBanJyxisuh50sRq8bfrHpPF14fFFntvaVtc3jWHzeLQ5GYmi+mb5zBbHL53
        lcXi4ZKJzBbnTn5itZj32MHi1/KjjBbvf1xntzi1YzKzxfq9P9kcRDwmNr9j99g56y67x+YV
        Wh6Xz5Z6bFrVyeaxf+4ado/3+66yefRtWcXo8XmTnEf7gW6mAK4oLpuU1JzMstQifbsErozL
        75+wFkRWnN69gaWB0bWLkZNDQsBE4kpvF2MXIxeHkMBuRok9m44wQiSkJI6feMvaxcgBZAtL
        HD5cDBIWEvjIKPHlfxCIzSagI9H39hYbSK+IwFEmiQ1XjzGDOMwCBxkljs8+AzZIWEBf4vCq
        TiYQm0VAVeLutqlsIDavgLXEne7DUMvkJZ72LmcGsTmB4h1LrrBBbLOSOP5hPSNEvaDEyZlP
        WEBsZqD65q2zmScwCsxCkpqFJLWAkWkVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZw
        9Glp7mDcvuqD3iFGJg7GQ4wSHMxKIrzsn7UShHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZ
        LySQnliSmp2aWpBaBJNl4uCUamC6+OfRLPvpB4uFZZbmNCz5xB2oMjHtnVhs7meXG6FnVe9u
        d9x6emFAVElO22+TT93r7KqftOrlL/1s2t+2f6Zy0lvNAyyT7tU7Jahn9zqkR6x8elmA1ab4
        f5i87IvP+3uXPN/QpzK9ZeHtBgXn/1/TWXvU5vVPNMpuuyQQGDh1y89152us7Jz/ZX77p7Pw
        0Nq9Nx4aiJ0/M332qvMpJSp22tc2vjh4+X2rWdleqZb4p85ln7s4Gk/OdSt9f27mgfk9HwzO
        LSuIl7z85+D5Sc6/7rG37bj0WpIxNjBQtmCp49qJlRocBRJP89sWmWnNn3+Qd1pofjfbHYm5
        Jtvup20xDfTiYc0vnnkm9fPZaq7LSizFGYmGWsxFxYkAx55+yS0DAAA=
X-CMS-MailID: 20210216021636epcas1p31748fea01f2c9638216f8d8b3b3b3712
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210216021636epcas1p31748fea01f2c9638216f8d8b3b3b3712
References: <20210204010156.5105-1-nanich.lee@samsung.com>
        <CGME20210216021636epcas1p31748fea01f2c9638216f8d8b3b3b3712@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Please feedback to me if more modification is needed to apply. :)

---
Changheun Lee
