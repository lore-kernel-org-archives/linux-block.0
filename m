Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B898C77B7F
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 06:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjESGOp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 02:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjESGOo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 02:14:44 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C501A6
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:14:43 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230519061441epoutp03c1c1ec8a19a94a4b9c3fca2ce185bbea~gdsyXQoqO1239912399epoutp03U
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 06:14:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230519061441epoutp03c1c1ec8a19a94a4b9c3fca2ce185bbea~gdsyXQoqO1239912399epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684476881;
        bh=oOF8MuPYOH2An8FWy5GwcVNNVNFi8i99I8IMaZDpLXQ=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=FG7EHCPQRsYA7GR9NUZbUz2icbtxs3nOm1hjPSzYVs1phmcjRYs+BE+jG8o/16Izb
         Cj5l9OZx3FD26Qe5gVx3Ty6iD29bkelNllZ4TOqBoS5SVy5+JtsHpi0d7QhNk2deRA
         stv1DAjuZ6r9fWXUNzAOU0NLxjfuAXsMQIypDl/Q=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230519061441epcas2p30b97c0d0de1fb61108741db487d95c80~gdsyHGuJG0779007790epcas2p3k;
        Fri, 19 May 2023 06:14:41 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QMxQ90vt8z4x9Px; Fri, 19 May
        2023 06:14:41 +0000 (GMT)
X-AuditID: b6c32a47-6fe4ca8000001ce0-74-646713d07659
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.64.07392.0D317646; Fri, 19 May 2023 15:14:40 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 5/8] block: move the bi_size overflow check in
 __bio_try_merge_page
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230512133901.1053543-6-hch@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230519061440epcms2p553b2fe7d225ea059f28a9af5358ca573@epcms2p5>
Date:   Fri, 19 May 2023 15:14:40 +0900
X-CMS-MailID: 20230519061440epcms2p553b2fe7d225ea059f28a9af5358ca573
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmhe4F4fQUg1cPrCxW3+1ns3h5SNNi
        5eqjTBZ7b2k7sHhcPlvqsftmA5tH35ZVjB6fN8kFsERl22SkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA7VNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX
        2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGdcfnWZscCnYkbTROYGRocuRk4OCQET
        ialz17J3MXJxCAnsYJQ4cf0NYxcjBwevgKDE3x3CIDXCApES61afZASxhQSUJM6tmQVWIixg
        IHGr1xwkzCagJ/FzyQw2EFtEwEFi9oalYDazgL3E3tutjBCreCVmtD9lgbClJbYv3wo2hlPA
        SOL4GR2IsIbEj2W9zBC2qMTN1W/ZYez3x+ZDjRGRaL13FqpGUOLBz91QcUmJQ4e+soGMlBDI
        l9hwIBAiXCPxdvkBqBJ9iWsdG8Eu4BXwlXh5eQLYGBYBVYk5q5cwQ7S6SLz+LAZxvLzE9rdz
        wMLMApoS63fpQ1QoSxy5xQJRwSfRcfgvO8x7DRt/Y2XvmPeECaJVTWJRk9EERuVZiCCehWTV
        LIRVCxiZVzGKpRYU56anFhsVGMPjNDk/dxMjOMVpue9gnPH2g94hRiYOxkOMEhzMSiK8gX3J
        KUK8KYmVValF+fFFpTmpxYcYTYF+nMgsJZqcD0yyeSXxhiaWBiZmZobmRqYG5krivNK2J5OF
        BNITS1KzU1MLUotg+pg4OKUamCT6T9dEMHXIX0jTNmBP74+8cOKX/NIbn10VZCQnvj1x95J9
        xsmZLzVL3Z+LMee4lv7xkq6y09m231Raz/RPWHm1zPp+8+l+il9Sl4beZJQ+c2/+lNdLHKMN
        Ji34Hpof6pJuWXHciqcyN3/11JBvZhM7ipnVfyXu1tngMHcrw/sj+X0su8wmrdy9kdHsNod/
        Bc/OU83e8Yt6DnTH7C8yuec1zdb93d+cnIztmq+cvohM32JdVaPlan77bqaXxSZ2/rmh4QeX
        tglvZixQsn+1j633NP/aNeEpv+4/yL4jtoyTaVO9tYJQ6dVqzusZfg8+7Jpq/spFtiowkHPb
        g0YVkwBVBY/CdSfzNv8t7tyjxFKckWioxVxUnAgARfbaHPoDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230512133933epcas2p45296bb126cfbbf413a2acd09c222fd29
References: <20230512133901.1053543-6-hch@lst.de>
        <20230512133901.1053543-1-hch@lst.de>
        <CGME20230512133933epcas2p45296bb126cfbbf413a2acd09c222fd29@epcms2p5>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me,

Reviewed-by: Jinyoung Choi <j-young.choi@samsung.com>
