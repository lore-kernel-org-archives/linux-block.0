Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B466C32792
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 21:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F144F20842
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 21:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jWhbup8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfI3VzC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:55:02 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:33879 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfI3VzC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 17:55:02 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190930215459epoutp0289726188ab80063338e8f0cdbff3ae09~JVf8pWDxT1386413864epoutp02U
        for <linux-block@vger.kernel.org>; Mon, 30 Sep 2019 21:54:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190930215459epoutp0289726188ab80063338e8f0cdbff3ae09~JVf8pWDxT1386413864epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569880499;
        bh=cEfjYlLf43o9MBy1ICOhBt1tk62BX/W31Wq/TZFyDqk=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=jWhbup8uktGCb8V5qjynsnImduqSVZbk9h27iZqn4wpePtccHDUeO64s5jBBoDMyb
         aBHJ1U+EBAOzbGe2I10MGCWKIHQlAV3SLEJCyroPHw3j7FObgLZL176PhtgqWBHza9
         zbRyaRkNE8gwPa/jzOF1eMXYhRHDkVLfSEYwsnZw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190930215458epcas2p165bd52422fc5de33e087b7b8708713ff~JVf750Y1l2313523135epcas2p1E;
        Mon, 30 Sep 2019 21:54:58 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 46hx5Y1NgNzMqYkW; Mon, 30 Sep
        2019 21:54:57 +0000 (GMT)
X-AuditID: b6c32a48-415ff70000000fe3-94-5d9279b17242
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A1.6B.04067.1B9729D5; Tue,  1 Oct 2019 06:54:57 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH 1/1] blk-mq: fill header with kernel-doc
Reply-To: minwoo.im@samsung.com
From:   Minwoo Im <minwoo.im@samsung.com>
To:     =?UTF-8?B?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@collabora.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "krisman@collabora.com" <krisman@collabora.com>,
        Minwoo Im <minwoo.im@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190930194846.23141-1-andrealmeid@collabora.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190930215456epcms2p64c66823d97c6ffad3861e750a4145f4b@epcms2p6>
Date:   Tue, 01 Oct 2019 06:54:56 +0900
X-CMS-MailID: 20190930215456epcms2p64c66823d97c6ffad3861e750a4145f4b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdljTQndj5aRYgwsnuSw+zNvFYrH6bj+b
        xeZzPawWi45eZ7HYe0vb4vKuOWwWz04fYHZg99hxdwmjx+WzpR59W1YxenzeJBfAEpVjk5Ga
        mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0X0mhLDGnFCgU
        kFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhYoFecmFtcmpeul5yfa2VoYGBkClSZkJNx66dO
        wSrmip/3LjI3MM5l7mLk5JAQMJG43byCqYuRi0NIYAejxJJbV1m7GDk4eAUEJf7uEAapERaw
        kZjTe5oZJCwkIC/x45UBRFhT4t3uM6wgNpuAukTD1FcsILaIgIPE400vmEFGMgusY5JY8uUE
        G8QuXokZ7U9ZIGxpie3LtzKC2JwC9hLP+j+zQ8RFJW6ufgtnvz82nxHCFpFovXcW6mZBiQc/
        d0PFpSR2rD8AdrKEQDOjxB9niHADo8T1+eIQtrnE7/u7we7kFfCVeLhlOdh4FgFViTnbr0KN
        dJFo7d4OVsMsoC2xbOFrsHeZgX5cv0sfYrqyxJFbLBAVfBIdh/+ywzy1Y94TJghbWeLjoUNQ
        EyUlll96DfW4h8TWqT/ZIIHcxijx6/EG5gmMCrMQ4TwLyeJZCIsXMDKvYhRLLSjOTU8tNiow
        QY7ZTYzghKjlsYPxwDmfQ4wCHIxKPLwTXk6MFWJNLCuuzD3EKMHBrCTCK84wIVaINyWxsiq1
        KD++qDQntfgQoynQ/xOZpUST84HJOq8k3tDUyMzMwNLUwtTMyEJJnHcT980YIYH0xJLU7NTU
        gtQimD4mDk6pBkZ1Y0uxe1xW+7QTUjedvF3/+cCWK3kTOOo/cZTEuE8NfNp19xVL6K5zR/dE
        H/jm4nlPWGrLGfkMVpNlv/fnL7zyIGmRdMO6a2z7vuyfmd0TV/gj9+SWzn6vKZ9yf9YkHLTe
        fOapqFpd5JvDm7UfsPJP3RkUElLpf3KGRV+T/iefYNV0+2DXq5eUWIozEg21mIuKEwFKbnTq
        ngMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190930211400epcas2p4253bdc8cc3630f87d7e955cd23fdf1f2
References: <20190930194846.23141-1-andrealmeid@collabora.com>
        <CGME20190930211400epcas2p4253bdc8cc3630f87d7e955cd23fdf1f2@epcms2p6>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Andr=C3=A9,=0D=0A=0D=0A>=20-/*=0D=0A>=20+/**=0D=0A>=20+=20*=20blk_mq_rq_=
from_pdu=20-=20cast=20a=20PDU=20to=20a=20request=0D=0A>=20+=20*=20=40pdu:=
=20the=20PDU=20(protocol=20unit=20request)=20to=20be=20casted=0D=0A=0D=0AIt=
=20makes=20sense,=20but=20it=20looks=20like=20PDU=20stands=20for=20protocol=
=20unit=20request.=0D=0ACould=20we=20have=20it=20=22PDU(Protocol=20Data=20U=
nit)=22=20?=0D=0A=0D=0AThanks,=0D=0A
