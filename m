Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1D1C47096
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 08:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D30613DE
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 08:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFCIw5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 04:52:57 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:17240 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhFCIw4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 04:52:56 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210603085110epoutp0301b75cb30d80fe48373f95dfedde3a21~FBmTUXACN3263932639epoutp03V
        for <linux-block@vger.kernel.org>; Thu,  3 Jun 2021 08:51:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210603085110epoutp0301b75cb30d80fe48373f95dfedde3a21~FBmTUXACN3263932639epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622710270;
        bh=ROInMEp5LWFDYW5/MsWYnCMtBjhdQPxdGfaQbz4PS8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rbl7EE0FpzZ47HOPD6AJuyABbVdL+QmZ4CXXqpd2/Yf8eaUf+JMxedIPk4Gg6tw9n
         4CMx3U8K1gsHWail3bNCsbxoZ+o1s4s7AvpfUeH4XDqDN4Guy/Qr2oIOy2qAR2MXI9
         t4QpFQbEm/hVqBi7N4xl90YJJdVQNpv9r7G+c2+Y=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210603085109epcas1p389366153a5f299bd0bb7f7daa7a030e2~FBmSYR-5Z1342013420epcas1p3q;
        Thu,  3 Jun 2021 08:51:09 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.166]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Fwfkh2LjVz4x9Q8; Thu,  3 Jun
        2021 08:51:08 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.60.10258.CF798B06; Thu,  3 Jun 2021 17:51:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210603085107epcas1p223fb68f0d992fd9b64df84d8bcfea1f0~FBmQCIt472678326783epcas1p2x;
        Thu,  3 Jun 2021 08:51:07 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210603085107epsmtrp24f8374617cf0c1880d26d6278affe983~FBmQAsUAC1016010160epsmtrp2B;
        Thu,  3 Jun 2021 08:51:07 +0000 (GMT)
X-AuditID: b6c32a38-42fff70000002812-77-60b897fcd6f0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.63.08163.BF798B06; Thu,  3 Jun 2021 17:51:07 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210603085106epsmtip12c2d2e90f0b66e09e00dc77ad723ac92~FBmPtwKJ10300903009epsmtip11;
        Thu,  3 Jun 2021 08:51:06 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     damien.lemoal@wdc.com
Cc:     Johannes.Thumshirn@wdc.com, alex_y_xu@yahoo.ca,
        asml.silence@gmail.com, axboe@kernel.dk, bgoncalv@redhat.com,
        bvanassche@acm.org, gregkh@linuxfoundation.org, hch@infradead.org,
        jaegeuk@kernel.org, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        mj0123.lee@samsung.com, nanich.lee@samsung.com, osandov@fb.com,
        patchwork-bot@kernel.org, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, tj@kernel.org, tom.leiming@gmail.com,
        woosung2.lee@samsung.com, yi.zhang@redhat.com,
        yt0928.kim@samsung.com
Subject: Re: [PATCH v11 3/3] scsi: set max_bio_bytes with queue max sectors
Date:   Thu,  3 Jun 2021 17:32:36 +0900
Message-Id: <20210603083236.18161-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <DM6PR04MB7081BDEC7ECFB63D3E6345D0E73D9@DM6PR04MB7081.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0zbVRTHvf21v7YMsJTNXRm42uAUHI9SHhcGg2yoP8diMCTOsRGo8EvB
        lbZpwceGrth1QNdNCArSgZ2sIgG2LoDYVl4pmg4YRGXQsAhIJFs2KCyUxyaw2FJQ/vuecz7n
        fnPOzWFgbA3dj5EnLiBlYoGIi3tQO/qCwkLWq41Z4dVKb3TzzxY6qm3qAKh54kscmX/XAVT1
        +CmGVCUrFKS8bsDRYHk9Bc0YtBjSzHxBQxvqSQpanpajrnuvoxFzLY4slUoKqm6rxdDY1B06
        6pscpaJpfQWGhvsXaejbv5PQPz/8CtDCExsdDRgrMWQbrsKRoespnuRHjNxNISqU83TCpJ2g
        E22NwcTIUCHR2lSGEz11LXRioXsUJ660NwHC0foSUdJ7iUJYLA1Yqme6KD6XFOSQMg4pzpbk
        5ImFCdyUtMyjmVHR4bwQXiyK4XLEgnwygZt8PDXkzTyRcwVczkcCUaEzlSqQy7lhh+NlksIC
        kpMrkRckcElpjkjKC5eGygX58kKxMDRbkh/HCw+PiHKSWaJcteoJXTru8YmuW6IAXQw1YDIg
        KxIu2cuBGngw2CwjgCrbGtUdLAK4MGTYqjgAbP7+OthuaVIP0NwFM4CD1h7af5RmrJXmonDW
        QXjFfg936d2sF+HAwyXcBWEsGxWq2vo3C76sFFinsWw+S2W9AlU9vZt5L9Yh+Ehv3bLbD9en
        NJhLM1kZ8Jl5leZmfGB/zQzVpTEno/zxKuYygCwdEzavLGPu5mS40nyT6ta+8JG1ne7WftAx
        34W7Gy4BqLyoA+6gHED9gwaKm+LDRYfDWWA4LYKgwRzmTr8MTWt1wO3sDeeXNTQXAllesPQi
        240EwjsXprBtrwc3TFsvEtDaf3VrqbcArFnuoZUDjnbHQNodA2n/d74GsCbwAimV5wtJOU8a
        ufOTW8HmWQQjI6izPw61AAoDWABkYNzdXp0HjFlsrxzBp2dJmSRTVigi5RYQ5Vx3Bea3J1vi
        vCtxQSYvKoLP56PI6JjoKD53r5fw6LksNksoKCDPkKSUlG33URhMPwVF1lIpM6x9HEQ7gscP
        dOjuYp6nFTGztzHtXKPv9Nn50ezX8nd9ILXri+Yja1oCDh+S3ufuvTXU1Tj3Of+vMeupMt3B
        9jHK24ETAScWBxUm2+34lPXBV0/6v3W++4y+z3ZE+dDzWllaQEYzc/wrxzuiJCO/88PLs94x
        nf5tpTfsJCe4OPeE+bh9svLZymeneT6qXxLTG3yOJcaWFEu5Sjb7t6G56KKKjVPMaoGSE3i/
        /ph/Yqkie+b8RsSSYmF2TVy/kR76nbD4jYiUql1fp72rj20p2FMxLIhLTbYOy0zfTFD2wecy
        9p8cv/BT3PjzaHV1vdf0/r7L2IGfi+LN6j/OOXjvcanyXAEvGJPJBf8CSn6e6p8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRyHe8/ZzjmuFsdp+TbTaLY+qJmV1AtZrSI6dCFNKIxCl55Uck52
        mqUZaWajZWUkzk1NMdGaojBrzXlZnFGpaSiWkZRmmt3LLmZmRW4S9O3h/zzw+/CncAkvkFJJ
        KUdYTYoyWUaIBFanzH/ZlMEWG1rbNAfVPa0lUYnZClDNs4sEsveUAVQ4NomjXN13DOVcrSfQ
        /fwKDI3Um3CUN3JKiH7rBzA0PsShlv4g1GsvIRB/OQdDhoYSHPUNdpLIOfBIgIYqL+HoQfsX
        IboyrEA/q+8A9OnHYxJ12C7j6PGDQgLVt0wSCinT+3A7cynnI8k0mp6RTMO1QKa3S8tYzGcJ
        xlFaSzKfWh8RzIUbZsB8tfgzutvnMIbnq/CIOftE4fFsclIaq1m+PlaUqM/9QaY+ER0ra1Vn
        gRZKDzwoSIdBs75DqAciSkLbAKxsaMRnhBTea/swLahp9oJOJzfTfAawqfsL4WoIOhhe+NDv
        Zm96Aex4841wRTg9IYAO3ahbeNHbYWkeD1wsoOUw13HbfRfTa+HbyntgZmwR/DWY5x72oA/A
        P/YJoYsl9H5omnqBzfSesN04InAxPt3n3CzG8wFt+k+Z/lPlADODBWwqp0pQcStSV6awR0M4
        pYrTpiSExKlVFuB+c2CgDTSbx0J4gFGAB5DCZd7i5qW2WIk4XpmewWrUMRptMsvxwJcSyHzE
        3fr2GAmdoDzCHmbZVFbzz2KUhzQLqyOzD53pWi+O3gK7MhcJ1beax3TG7Maf6SUHfclNua87
        x+cbdLLIoP1NRWhhUUdw9ebFx05GduN/SKIYyD9qtO/6rQq/K/Kl108g53uz33PrVMFdvc+y
        VeNhhg2WtX47NmCjkRNdC4u/y1XGG5a0+MIKW83sgtNDNcffANHX5mvhmeV9rfOlW+1bDdEv
        qz2H+yaWlG5rdSgy20I7jXvljsqkoILE13vIAFHTgHZuXNyoaNSyr+ehNCh8950E666oOKN9
        Xn/AOs9faRvzJ1+F5mX3qIfZ0lgv5nzfu8ONPe/Jef54RN3uLO823yh+dXrDTluGYlZ2VXSt
        T0bioag1MgGXqFwRiGs45V/aGOU+VQMAAA==
X-CMS-MailID: 20210603085107epcas1p223fb68f0d992fd9b64df84d8bcfea1f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210603085107epcas1p223fb68f0d992fd9b64df84d8bcfea1f0
References: <DM6PR04MB7081BDEC7ECFB63D3E6345D0E73D9@DM6PR04MB7081.namprd04.prod.outlook.com>
        <CGME20210603085107epcas1p223fb68f0d992fd9b64df84d8bcfea1f0@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On 2021/06/02 21:29, Changheun Lee wrote:
> > Set max_bio_bytes same with queue max sectors. It will lead to fast bio
> > submit when bio size is over than queue max sectors. And it might be helpful
> > to align submit bio size in some case.
> > 
> > Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> > ---
> >  drivers/scsi/scsi_lib.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> > index 532304d42f00..f6269268b0e0 100644
> > --- a/drivers/scsi/scsi_lib.c
> > +++ b/drivers/scsi/scsi_lib.c
> > @@ -1837,6 +1837,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
> >  	blk_queue_virt_boundary(q, shost->virt_boundary_mask);
> >  	dma_set_max_seg_size(dev, queue_max_segment_size(q));
> >  
> > +	blk_queue_max_bio_bytes(q, queue_max_sectors(q));
> 
> Doing this unconditionally for all scsi block devices is probably not a good
> idea. Cannot this be moved to the LLD handling the devices that actually need it ?

OK, I'll try to check more nice location in LLD.

> 
> > +
> >  	/*
> >  	 * Set a reasonable default alignment:  The larger of 32-byte (dword),
> >  	 * which is a common minimum for HBAs, and the minimum DMA alignment,
> > 
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research

Thank you,
Changheun Lee
