Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1F4C47097
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 13:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFA1601FA
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 13:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhFCNDx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 09:03:53 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:41074 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhFCNDx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 09:03:53 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210603130207epoutp01c5f1f5d0886b01a9f4285ef6fb1b7d5d~FFBZ7a4ma1697516975epoutp01H
        for <linux-block@vger.kernel.org>; Thu,  3 Jun 2021 13:02:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210603130207epoutp01c5f1f5d0886b01a9f4285ef6fb1b7d5d~FFBZ7a4ma1697516975epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622725327;
        bh=zQhfS0Lj3SAwdFUKVAAVoUgCr3fQIu09ai64tr89oZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O24ZTnnPFQTeGods98329EcQt5untY0Txf2yu+qYYLVnqa+lkJhSp1OorRs/SMlgU
         SDW/26jy2eGwBfQpgkv+kLJrSKWOYJTBE23pPB42VUhrjARn045oX71KTIov/1K/ot
         RQCRvtfEsvo70eJUmTrW3zjpePoddDqBnfpeoeiE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210603130206epcas1p284958fb8987ac5ad847a930d3a39e867~FFBYx1ES82399423994epcas1p2T;
        Thu,  3 Jun 2021 13:02:06 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.162]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4FwmJD6Wb8z4x9Pr; Thu,  3 Jun
        2021 13:02:04 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.B3.09824.CC2D8B06; Thu,  3 Jun 2021 22:02:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210603130204epcas1p1f33c937feb12b181af0c57f464a19f84~FFBWqMb-_1372713727epcas1p1L;
        Thu,  3 Jun 2021 13:02:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210603130203epsmtrp247ee3459d58b8c324701e54c9758ad45~FFBWo6MfP3023530235epsmtrp2V;
        Thu,  3 Jun 2021 13:02:03 +0000 (GMT)
X-AuditID: b6c32a37-04bff70000002660-7b-60b8d2cc105d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.E9.08637.BC2D8B06; Thu,  3 Jun 2021 22:02:03 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210603130203epsmtip1fa7e7324c97cc52bbcad4f5c25673ed0~FFBWYWFCb2075520755epsmtip1t;
        Thu,  3 Jun 2021 13:02:03 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     Johannes.Thumshirn@wdc.com, alex_y_xu@yahoo.ca,
        asml.silence@gmail.com, axboe@kernel.dk, bgoncalv@redhat.com,
        bvanassche@acm.org, damien.lemoal@wdc.com,
        gregkh@linuxfoundation.org, hch@infradead.org, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com, yi.zhang@redhat.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
Subject: Re: [PATCH v11 3/3] scsi: set max_bio_bytes with queue max sectors
Date:   Thu,  3 Jun 2021 21:43:32 +0900
Message-Id: <20210603124332.17435-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210603083236.18161-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbVBUZRSe91727kKsXBbQV8Zyu5iNxMcuy8IbQYOhdouaUKaZckrY2Osu
        sexueyFRm4YBkc8QYqLk0xBX3CAKEBbiQxc2R1BmkHDNRDIoDAN0d3TCwFq4MPHvnOc8z/uc
        c945AlyUz/cVJGvTGINWoaEIN5f2/h3BgVeumRMlNXYJ+vZWIx9VmdoB+mb8BIG6RmoBKr+/
        gKOc3EcYyj7dTKChkjoMTTVX4KhoKouHlgpuY+jhHRb13HwBjXZVEchSlo2hL1urcNR/e8wF
        3akvxdHwZTsP1UxGo8dnrQDN/23jo0FzGY5sw+UEau5ZIKI306M/xdKl2XN8urNinE+3NvjT
        o1fT6RZTPkH3VTfy6fneMYIubjMB2tHyDJ17oRCjLRYjHue+XxOpZhRKxiBmtEk6ZbJWFUXF
        xifEJMjDJNJA6YsonBJrFalMFLXrjbjAPcka5/SU+GOFJt0JxSlYlgp+OdKgS09jxGodmxZF
        MXqlRi+V6INYRSqbrlUFJelSI6QSSYjcyUzUqG1Ls5i+ySNjrtFMZIJK9wLgKoBkKDR2/wUK
        gJtARJoBHH3wGcYldgBvnFqrPALQ9kWmy5pkbsC6WugB0HK6hOASB4BV/dPYMosgA2Dx7M2V
        gjdZi8Oms9fx5QQnOwG811GJL7O8yFhYXWQBy7EL+Ry8YJpfwYXkS9Ax30Jwflvh4kTRCu5K
        RkLLj3cJjuMJL5+cWukJd3Kyz1euGECy0hXeuDfI48S7YLWxa7VxLzhzqY3Pxb7QMddDcIJC
        ALOP1wIuKQGwftqIcSwZtDsczoLAabEDNncFc/CzsPOfasA5b4BzD4t4yxRICmHecRFH2Qav
        HJvA17ymmzpXX6Rhw/gin9vXCQDzC+14CRBXrBuoYt1AFf87nwK4CWxk9GyqimGletn6b24B
        KzfhH24G5bP3gywAEwALgAKc8hZ2bzcnioRKxeEjjEGXYEjXMKwFyJ3rLsV9fZJ0zqPSpiVI
        5SEymQyFhoWHyWXUJqEq5miiiFQp0pgUhtEzhjUdJnD1zcQ+enPSZro2I1d6tErtvXFn9vkE
        1H2X2OzXeWx78cXfYzd+GBkzFeUx/9vdDVvSOqa0XgmvPdk9kq9+9RybS7WRkqot+b1bv36d
        ykvuGxCf++GDt3zOVAe1to/E5mz+M+s6pD7ns/G/PjmcFclLXpK2tvwRfGhPRFTE829bQ8QP
        hE/dKhvyzNmkEhkrBur7DnTlYe8s+NURYR1q4y/hQxPueYf8FtXSnTz/3TMpn+wtuJrRrWwb
        WHCUWyXWVzxPnt9mPXjkwNMjuXHenn6XQif3e7Px73p9HxLwad/jf8eaRnd+dTTj/Zqfh1Lw
        hkG3fe8tBjhCZmwXw4v25hTafA/OEMPRHTGOIMqFVSuk/riBVfwHJWcSCpwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7bCSnO7pSzsSDKb2mFmsu7OG3WLOqm2M
        Fqvv9rNZ7Lo4n9Fi2oefzBat7d+YLJoXr2ezOD1hEZPFk/WzmC16njSxWvztusdk8fVhscXe
        W9oWl3fNYbM4NLmZyWL65jnMFofvXWWxeLhkIrPFuZOfWC3mPXaw+LX8KKPF+x/X2S1O7ZjM
        bHH93DQ2i/V7f7I5SHpcvuLtMbH5HbvHzll32T02r9DyuHy21GPTqk42j/1z17B7vN93lc2j
        b8sqRo/Pm+Q82g90M3kcOrSMOYAnissmJTUnsyy1SN8ugSvj+t+3TAVr+SverdnB1sA4m6eL
        kZNDQsBE4t2Ro4xdjFwcQgK7GSU+zV7JApGQkjh+4i1rFyMHkC0scfhwMUTNR0aJLY8WMIPU
        sAnoSPS9vcUGYosIbGWW+Ls8DKSIWeAgo8Tx2WcYQRLCAt4Sc3sOgdksAqoSB1a9B2vmFbCW
        +Px+ExvEMnmJP/d7wOKcAjYSh469AIsLAdVM+P+SCaJeUOLkzCdgxzED1Tdvnc08gVFgFpLU
        LCSpBYxMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgqNYS3MH4/ZVH/QOMTJxMB5i
        lOBgVhLh3aO2I0GINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYO
        TqkGpklGZjnhf3qYUt0i7mUxz+oSfJ63aLtOsBCLpov/xYid8lOuTpTnYX315aJL2NuwA36C
        hSePr0zMYtl45Elq4eejZ7m2v6yS3i1hcsVEr3brVrti5hKzT9Or0tZ+mWhze2Lh2T2nl5Qp
        7Ba0t9jUn3J3pl2novQXZj91hpx4ZbVFJqKPrUIT7niwnVeofvbmx5IsMelZ13j5LL6YxZvX
        JfR+kTw4/+8WiWzr5E9r4oKyg5apNXFzHTz5cPaZ0EbhzD0a2rJsDzItu1q51kS/0k98f7v2
        qv7aCHVOQb3UADvvRLnCVLG06NVKtWtf+zOU7tohuUzz4Pe1KbpGmcee6H96tvpy/cEmIaUr
        TKFKLMUZiYZazEXFiQBBxnUkUQMAAA==
X-CMS-MailID: 20210603130204epcas1p1f33c937feb12b181af0c57f464a19f84
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210603130204epcas1p1f33c937feb12b181af0c57f464a19f84
References: <20210603083236.18161-1-nanich.lee@samsung.com>
        <CGME20210603130204epcas1p1f33c937feb12b181af0c57f464a19f84@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > On 2021/06/02 21:29, Changheun Lee wrote:
> > > Set max_bio_bytes same with queue max sectors. It will lead to fast bio
> > > submit when bio size is over than queue max sectors. And it might be helpful
> > > to align submit bio size in some case.
> > > 
> > > Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> > > ---
> > >  drivers/scsi/scsi_lib.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> > > index 532304d42f00..f6269268b0e0 100644
> > > --- a/drivers/scsi/scsi_lib.c
> > > +++ b/drivers/scsi/scsi_lib.c
> > > @@ -1837,6 +1837,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
> > >  	blk_queue_virt_boundary(q, shost->virt_boundary_mask);
> > >  	dma_set_max_seg_size(dev, queue_max_segment_size(q));
> > >  
> > > +	blk_queue_max_bio_bytes(q, queue_max_sectors(q));
> > 
> > Doing this unconditionally for all scsi block devices is probably not a good
> > idea. Cannot this be moved to the LLD handling the devices that actually need it ?
> 
> OK, I'll try to check more nice location in LLD.
> 
> > 
> > > +
> > >  	/*
> > >  	 * Set a reasonable default alignment:  The larger of 32-byte (dword),
> > >  	 * which is a common minimum for HBAs, and the minimum DMA alignment,
> > > 
> > 
> > 
> > -- 
> > Damien Le Moal
> > Western Digital Research
> 
> Thank you,
> Changheun Lee

I think below location might be good. feedback to me please.

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 3eb54937f1d8..0f97b7d275ee 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4831,6 +4831,9 @@ static int ufshcd_slave_alloc(struct scsi_device *sdev)
 
 	ufshcd_get_lu_power_on_wp_status(hba, sdev);
 
+	blk_queue_max_bio_bytes(sdev->request_queue,
+				queue_max_sectors(sdev->request_queue));
+
 	return 0;
 }

Thank you,
Changheun Lee
