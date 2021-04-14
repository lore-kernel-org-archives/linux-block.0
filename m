Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DB4C433B4
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 01:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65FF613B6
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 01:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhDNB6e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 21:58:34 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:28779 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhDNB6d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 21:58:33 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210414015810epoutp03c0d64037f26395946516aa1f0710982e~1lta9XM9W0796407964epoutp03K
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 01:58:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210414015810epoutp03c0d64037f26395946516aa1f0710982e~1lta9XM9W0796407964epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618365490;
        bh=wSjQTkEEqDoir+5aK2x4I1+yyiru26SGlx6lw/pjVt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O/lkdgBq/r668UyDCRtk7Ip2MdeJpJfad+kF09xqhRZkg4hg2FtwEccCw1zHNudlG
         XNzEq4tOlWV4Z+ITXcBoABgdUI+n/1f0I4q0K8C/HRXTR9I61Y17PdowW2nJ8Lj6p5
         YgTOCfdJoIeScVFmrozdV8RMd+hzpg3HQEvgboKo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210414015807epcas1p3bb29545e723bc93a2be6f5c80432df82~1ltYnhSOk3257532575epcas1p3x;
        Wed, 14 Apr 2021 01:58:07 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.164]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4FKlxB2WYwz4x9QC; Wed, 14 Apr
        2021 01:58:06 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.C2.22618.E2C46706; Wed, 14 Apr 2021 10:58:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210414015804epcas1p21a7581e22dc553530c516459f32d78a9~1ltVPU90t2605026050epcas1p2-;
        Wed, 14 Apr 2021 01:58:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210414015803epsmtrp2d9abbca0d04d45b35bfc54bed8ce8298~1ltVOAqmF0732807328epsmtrp2V;
        Wed, 14 Apr 2021 01:58:03 +0000 (GMT)
X-AuditID: b6c32a38-e63ff7000001585a-40-60764c2e7070
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.87.33967.B2C46706; Wed, 14 Apr 2021 10:58:03 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210414015803epsmtip22f3d3bc9ddf5c0cd709487d2c4b64b54~1ltU-VnUj0104601046epsmtip2e;
        Wed, 14 Apr 2021 01:58:03 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     bvanassche@acm.org
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, gregkh@linuxfoundation.org,
        hch@infradead.org, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        mj0123.lee@samsung.com, nanich.lee@samsung.com, osandov@fb.com,
        patchwork-bot@kernel.org, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, tj@kernel.org, tom.leiming@gmail.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: [PATCH v7 2/3] ufs: set QUEUE_FLAG_LIMIT_BIO_SIZE
Date:   Wed, 14 Apr 2021 10:40:18 +0900
Message-Id: <20210414014018.20318-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <b923af39-8a33-4c2e-38ee-3ef53ced08e1@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxjfubcvHLALBTw22azFZcqztRSPmwgZau4CS9iGbu4FHdwVXGmb
        3paxRTO3WkAglQ4U5TEddGDLJghCAIe4EqYMJCPlkTCB4VhEDI9QYVbntpYLGf99v+/7/b7f
        +b5zDg/3d3IEvEyVjtKq5EoRZxOrtXunODwiMTtV3HvxOVRpawWofvw0B51ddOHImLeCIUNN
        Awf1FVdjqGj6KzZ6WjCBoeUpGnWOhSJHRyUH2UsMGCprrsTRyGQ/F3VPDLPQlMWMo4HeJTb6
        5o849LiuB6CFR6Nc9EtbCY4aOl2cuCDSMZRAmg3zXLK9fJxLNl8KIR239WST7RSH7Kr6nksu
        XB/mkKarNkA6m14g824UYknPvqvcm0HJ0ymtkFKlqdMzVYoYUcJbKfEpsmixJFyyB+0WCVXy
        LCpGtD8xKfxgptI9qUiYLVfq3akkOU2LIvft1ar1OkqYoaZ1MSJKk67USMSaCFqeRetViog0
        ddbLErF4l8zNTFVm2AdvYpoBmNNcOck9Aab5BcCLB4koONT+LbsAbOL5E20AnrNWYwxYAvCB
        1cViwAqA1ZZWsC6xjLYAptAJ4P3uUS4DnADOz1oxD4tDhEHT3BjHEwcQQdDxcGVVgRO5LDh2
        csRd4PH4xD7oGD/i4bCIF2Hjb65VrQ/xCqztXnfbCv+eLMI9sZc73zFwDTAcP9h7fprliXE3
        x9BSgXv6Q+JfHqydquIy4v2waKaUzcR8OHvz6lpeAJ3znRxGUAigIfcCYEAxgJZ7tRjDksIl
        pxN4TooTO2FDRyST3gbbn1QBxtkXzi8XsT0USPjA/Fx/hrId9p+cxNe97v3QvtaRhAuDJWsL
        NgE462xgFQNh+YaByjcMVP6/80WA20AQpaGzFBQt0URtvOQmsPr6Q1AbqJpbjLADjAfsAPJw
        UYDPwVJdqr9PuvyzzymtOkWrV1K0Hcjc6zbjgsA0tfv7qHQpEtkuqVSKoqJ3R8ukos0+H4l/
        T/EnFHId9QlFaSjtug7jeQlOYFsKypK7fHPEtrebl6K2j45Zv7zeGPA09IMrOsi/9nPhZSNq
        jevpOnSrTO297UpPbeP9OeN3Je8J4qHlxh37hJ/c1Dx1NPjTf1ixbEPt11/0OQ9U9A4+Q2QP
        K+sswV0C/hu3jId+mnvd5Wuh7/BP7cDfeax9NKQ3BV7IEVn7o7C8iPMfItNfyQnJd9u2HDH7
        OYTx51JfVbx0OW7ltj2UfdT48ZP6w4vG4+Ydb4YJ4WuBYmVdQ8xhRcWCYE/s4jKfRVnRjFnt
        HP816c+tNTX14bG8RIdNOpMoDfsx31X6fORZ71jZ6Zbjx5bOnOmQ6vO9j73fd/eSMW7gofnB
        yGYsEgQPiFh0hlwSgmtp+X9AgLV1hgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvK62T1mCQU+jucWcVdsYLVbf7Wez
        mPbhJ7NFa/s3JovmxevZLE5PWMRk0fOkidXib9c9JouvD4st9t7Stri8aw6bxaHJzUwW0zfP
        Yba4dv8Mu8Xhe1dZLB4umchsce7kJ1aLeY8dLH4tP8po8f7HdXaLUzsmM1us3/uTzUHM4/IV
        b4+Jze/YPXbOusvusXmFlsfls6Uem1Z1snnsn7uG3eP9vqtsHn1bVjF6fN4k59F+oJspgDuK
        yyYlNSezLLVI3y6BK+PQxeNMBeckKjbPuc/ewPhEuIuRk0NCwERiyfWtjF2MXBxCArsZJSbs
        OcMIkZCSOH7iLWsXIweQLSxx+HAxRM1HRoll836wg9SwCehI9L29xQZiiwiISVz+8g1sELPA
        AhaJgztPsIM0CwvYSVy+GwlSwyKgKrHh9k8mEJtXwFpi2eFtULvkJf7c72EGsTmB4rvO7QaL
        CwlYSRzYcIcVol5Q4uTMJywgNjNQffPW2cwTGAVmIUnNQpJawMi0ilEytaA4Nz232LDAMC+1
        XK84Mbe4NC9dLzk/dxMjODa1NHcwbl/1Qe8QIxMH4yFGCQ5mJRFetyklCUK8KYmVValF+fFF
        pTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUw+dkqCxhWf3parKH93liufWOU
        p9yigh4jL9Zjq9KSmz9Ws72TkmrunnS3oWrPrYy9nP69AY75XLPYfDtrn+e9+M68fPUKu74p
        VkfePMs/+fL2kfajS5jYtroEWStuyPjsNOXEpW/nnkvs+B3Usm/WJE5dzSLpFg0eG5fM5unL
        /jgd62eYcTbw6LYFy300Bdcpy4iuP5TvuU6r37d+4apPa1weFUsse978U2+XHw/HW5bWE07H
        72r92srk61NmO1GH+fncq2qvL/A132lomspaNGe51ZJu2w35xvPNFvOabL9ufs1jsyjjpjCZ
        GQu2vnnkub/4u5ba2d8Np8O/z5mtt7DzSvuhj6Yn/859e+7KVyWW4oxEQy3mouJEALVNabs8
        AwAA
X-CMS-MailID: 20210414015804epcas1p21a7581e22dc553530c516459f32d78a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210414015804epcas1p21a7581e22dc553530c516459f32d78a9
References: <b923af39-8a33-4c2e-38ee-3ef53ced08e1@acm.org>
        <CGME20210414015804epcas1p21a7581e22dc553530c516459f32d78a9@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On 4/12/21 7:55 PM, Changheun Lee wrote:
> > Set QUEUE_FLAG_LIMIT_BIO_SIZE queue flag to limit bio max size to
> > queue max sectors size for UFS device.
> > 
> > Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> > ---
> >  drivers/scsi/scsi_lib.c   | 2 ++
> >  drivers/scsi/ufs/ufshcd.c | 1 +
> >  include/scsi/scsi_host.h  | 2 ++
> >  3 files changed, 5 insertions(+)
> > 
> > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> > index 7d52a11e1b61..73ce6ba7903a 100644
> > --- a/drivers/scsi/scsi_lib.c
> > +++ b/drivers/scsi/scsi_lib.c
> > @@ -1838,6 +1838,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
> >  	 * Devices that require a bigger alignment can increase it later.
> >  	 */
> >  	blk_queue_dma_alignment(q, max(4, dma_get_cache_alignment()) - 1);
> > +
> > +	blk_queue_set_limit_bio_size(q, shost->limit_bio_size);
> >  }
> >  EXPORT_SYMBOL_GPL(__scsi_init_queue);
> >  
> > diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> > index d3d05e997c13..000eb5ab022e 100644
> > --- a/drivers/scsi/ufs/ufshcd.c
> > +++ b/drivers/scsi/ufs/ufshcd.c
> > @@ -9313,6 +9313,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
> >  	host->max_channel = UFSHCD_MAX_CHANNEL;
> >  	host->unique_id = host->host_no;
> >  	host->max_cmd_len = UFS_CDB_SIZE;
> > +	host->limit_bio_size = true;
> >  
> >  	hba->max_pwr_info.is_valid = false;
> >  
> > diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> > index e30fd963b97d..486f61588717 100644
> > --- a/include/scsi/scsi_host.h
> > +++ b/include/scsi/scsi_host.h
> > @@ -607,6 +607,8 @@ struct Scsi_Host {
> >  	unsigned int max_segment_size;
> >  	unsigned long dma_boundary;
> >  	unsigned long virt_boundary_mask;
> > +	unsigned int limit_bio_size;
> > +
> >  	/*
> >  	 * In scsi-mq mode, the number of hardware queues supported by the LLD.
> >  	 *
> 
> This patch should have been split into one patch for the SCSI core and
> another patch for the UFS driver.
> 
> I see an issue with this patch: a new attribute has been introduced in
> struct Scsi_Host but it is not used by the SCSI core. That seems weird
> to me.
> 
> Another comment I have about this patch is why to restrict the BIO size
> (blk_queue_set_limit_bio_size(q, shost->limit_bio_size)) only for UFS
> devices? Aren't all block devices, including NVMe devices, expected to
> benefit from limiting the BIO size if no stacking is involved? How about
> the following approach?
> * In blk_queue_max_hw_sectors(), set the maximum BIO size to
> max_hw_sectors. As you may know blk_queue_max_hw_sectors() may be
> called by any block driver (stacking and non-stacking).
> * In blk_stack_limits(), set the maximum BIO size to UINT_MAX. Stacking
> block drivers must call blk_stack_limits().

I think it will be good for all block device too, but it might be not in
some environment. I got a feedback about it. So I specified to UFS only.
I see what you said. I'll try as your approach.

> 
> Thanks,
> 
> Bart.


Thanks,

Changheun Lee.
