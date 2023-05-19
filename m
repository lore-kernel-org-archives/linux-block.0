Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1E6C77B7F
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 06:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjESGNs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 02:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjESGNr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 02:13:47 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2981A6
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:13:46 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230519061344epoutp01ac03042a116149b9351fddb6e02c383d~gdr83JxFZ2866928669epoutp01q
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 06:13:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230519061344epoutp01ac03042a116149b9351fddb6e02c383d~gdr83JxFZ2866928669epoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684476824;
        bh=oOF8MuPYOH2An8FWy5GwcVNNVNFi8i99I8IMaZDpLXQ=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=ZOzXzAUBSW1jLHiLeiEwrWxpVGooNqEBekSxAEynaagV9cbqWfLge8BlsEOMhveQ4
         qmseAQvqDgPFx7Ejn5bcG/e1WjIABHv09t1q5YmVUN09qBQv6h6GvNVGXkBJKxVPVP
         M8DqenzehP2S5jlPeSbAesgrpCs6s+YvuHvFkQGk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230519061343epcas2p17eb121b7622247000315c38e29028a6c~gdr8Tmc8-3058130581epcas2p1g;
        Fri, 19 May 2023 06:13:43 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.68]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QMxP32dSvz4x9Px; Fri, 19 May
        2023 06:13:43 +0000 (GMT)
X-AuditID: b6c32a45-445fd70000022cba-fb-64671396bc05
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.B1.11450.69317646; Fri, 19 May 2023 15:13:42 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 4/8] block: move the bi_vcnt check out of
 __bio_try_merge_page
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230512133901.1053543-5-hch@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230519061342epcms2p23501685a9020864ef6e6301d02c0b935@epcms2p2>
Date:   Fri, 19 May 2023 15:13:42 +0900
X-CMS-MailID: 20230519061342epcms2p23501685a9020864ef6e6301d02c0b935
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7bCmhe404fQUg5tXjSxW3+1ns3h5SNNi
        5eqjTBZ7b2k7sHhcPlvqsftmA5tH35ZVjB6fN8kFsERl22SkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA7VNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX
        2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGdcfnWZscCnYkbTROYGRocuRk4OCQET
        iVVzdjB3MXJxCAnsYJS4/rIdyOHg4BUQlPi7QxikRlggROLkicVMILaQgJLEuTWzGEFKhAUM
        JG71moOE2QT0JH4umcEGYosIOEjM3rAUzGYWsJfYe7uVEWIVr8SM9qcsELa0xPblW8HinAJG
        Ej9X/YKq0ZD4sayXGcIWlbi5+i07jP3+2HyoGhGJ1ntnoWoEJR783A0Vl5Q4dOgrG8hpEgL5
        EhsOBEKEayTeLj8AVaIvca1jI9gJvAK+Ere/9oKNZxFQlZh64xbUKheJFStfMkOcLy+x/e0c
        cIAwC2hKrN+lDzFdWeLILRaICj6JjsN/2WEebNj4Gyt7x7wnTBCtahKLmowmMCrPQgTyLCSr
        ZiGsWsDIvIpRLLWgODc9tdiowBAeq8n5uZsYwWlOy3UH4+S3H/QOMTJxMB5ilOBgVhLhDexL
        ThHiTUmsrEotyo8vKs1JLT7EaAr05ERmKdHkfGCizSuJNzSxNDAxMzM0NzI1MFcS55W2PZks
        JJCeWJKanZpakFoE08fEwSnVwOSn9yPNpiLKyeT6x7RCr4DegsACvQO7rSMW5W16nLiMT67y
        bmLSfqU6kz3v9WSXH1K+WDBXYL3+kXx2xh7uLdq88p7cVq3rJlltWRifEn/c+NNMS31119+H
        L7XGvSzO21xywHndkorVcuErgpK/r7y48thHD+fG1Mbv1qnv9f9f8ftnONtgpkv8rvd/z1c8
        575e1Tm70HPlgrPTLp+reKxhplG13mTBhWWc080msa9n+Rl3497sraX3zKNFP96PmHB+15fq
        n+6bV37/IK222VFn188d5ZELFi1VLt3243b164UMj27ZF8jbyzgnu99eZHXnt9R550+TLEL0
        npeVntdcoFnlIRJ9c9mdHtmijvdKLMUZiYZazEXFiQDnTDnS/AMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230512133934epcas2p1427ddc5bad0943b9da07c060b985b840
References: <20230512133901.1053543-5-hch@lst.de>
        <20230512133901.1053543-1-hch@lst.de>
        <CGME20230512133934epcas2p1427ddc5bad0943b9da07c060b985b840@epcms2p2>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me,

Reviewed-by: Jinyoung Choi <j-young.choi@samsung.com>
