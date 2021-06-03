Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4187BC47096
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 09:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EADB613F0
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 09:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhFCJsu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 05:48:50 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:37983 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhFCJst (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 05:48:49 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210603094703epoutp030b40d340004bbdcc327979541ec02a1f~FCXF7XSkG1890618906epoutp03R
        for <linux-block@vger.kernel.org>; Thu,  3 Jun 2021 09:47:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210603094703epoutp030b40d340004bbdcc327979541ec02a1f~FCXF7XSkG1890618906epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622713623;
        bh=a5Wku6KPwfauJgdkL6loMj/OZS4Ji+rfubuNDIVzE78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tPgpSsiHL/t2wDu5LBRXEKP3t2eCqXX+uPu0SMQT/G+6Ey4LnrmiI/3ek4MfvGxSX
         UDnBP4/6fggxnKPCupzAxSQ8nxMGOtWak2zwVnnZA4Hbihm8/CXX/oGwOV6pUm0mSP
         8TKfTPCfXYrTg9+7hyuJSpqwQ33iUBMBIIXicMfE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210603094702epcas1p448c8940afb3a3b7e90957d5b54c39bb3~FCXEzEUdJ1308213082epcas1p4C;
        Thu,  3 Jun 2021 09:47:02 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Fwgz91MTZz4x9Pp; Thu,  3 Jun
        2021 09:47:01 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.AB.09736.515A8B06; Thu,  3 Jun 2021 18:47:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210603094700epcas1p3921df0cd92caca7b098205d35d861eb9~FCXCpmCDj1375413754epcas1p33;
        Thu,  3 Jun 2021 09:47:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210603094700epsmtrp2a38268049e6174cd5e8550b1ca45400b~FCXCoTleD0392503925epsmtrp2P;
        Thu,  3 Jun 2021 09:47:00 +0000 (GMT)
X-AuditID: b6c32a39-8efff70000002608-c7-60b8a515c8fe
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.DD.08637.315A8B06; Thu,  3 Jun 2021 18:46:59 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210603094659epsmtip11e0af06f75930f869fabb312b5deec3c~FCXCSQNmX2799727997epsmtip1q;
        Thu,  3 Jun 2021 09:46:59 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     bvanassche@acm.org
Cc:     Johannes.Thumshirn@wdc.com, alex_y_xu@yahoo.ca,
        asml.silence@gmail.com, axboe@kernel.dk, bgoncalv@redhat.com,
        damien.lemoal@wdc.com, gregkh@linuxfoundation.org,
        hch@infradead.org, jaegeuk@kernel.org, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        mj0123.lee@samsung.com, nanich.lee@samsung.com, osandov@fb.com,
        patchwork-bot@kernel.org, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, tj@kernel.org, tom.leiming@gmail.com,
        woosung2.lee@samsung.com, yi.zhang@redhat.com,
        yt0928.kim@samsung.com
Subject: Re: [PATCH v11 3/3] scsi: set max_bio_bytes with queue max sectors
Date:   Thu,  3 Jun 2021 18:28:30 +0900
Message-Id: <20210603092830.27062-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <10c02317-7528-bbad-3cfb-75db54d2ab91@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjOd045LbK6Q1X2jSyOVTGTa0stfApsEHU7ESSwxWWTLaWDk8JW
        2tqC2XBBIgIDOqRzglQuKgiMi3WIrDRjmupE5LIJIg65jEGUGQvKTZm2ruVAxr/nfZ/n+Z68
        75eXg/Py2e6cJEUKrVZI5XxiDavl6laB74ZzxjhB7RMWOj/UwEaldS0A1Q8fI5DpVgVARY8X
        cZSVs4ChzEoDgToLz2JowqDHkXbiiBOy5o1gaH5Mg9oGvVGfqZRA5uOZGCq+WIqjO6NdbHR1
        pJ+Fxqp0OOrpmHFC5eNh6N+a3wCafjbARjeNx3E00FNEIEPbIhHmTvXdjqB0mVNsqlU/zKYu
        1npRfd2pVFNdLkFdLmtgU9O/9hNUQXMdoGabNlI5V/IxymyuxqNf2S8PSaSlCbTag1bEKxOS
        FLJQfsSHkp0ScaBA6CvcjoL4HgppMh3K3xUZ7ftekty+Ar7HQak81d6Klmo0fP93QtTK1BTa
        I1GpSQnl06oEuUooUPlppMmaVIXML16ZvEMoEASI7co4eeIj0xlcZeB9ZTLo8Azw59o84MyB
        5DZ49/ktpzywhsMjjQDOXO/GmWIGQP1PL5eLBQDrszpZKxZLcT/BEG0Ajk/eXyJ45CyAva0p
        DkyQPrDAMkg48HrSDfbNLQCHAScHWfDs33ecHMQ6MgKWac3AgVmkJ/xRa1sycMlg+FdjOZtJ
        exO+GNXiDuxs71d1NOGMxhV2lEwsBeN2TealUzijr3CGs0McBu+CNbYWgsHr4MP25uU33eHs
        VNvSBJDMBzAzuwIwRSGAVQ+qMUYlgjOzs3aCY0/YCg0mf6b9Fmx9XgaY4LVwal7r5JBAkgu/
        zeYxks2w6+govpL1oLF1+UUKvrzXzGI2VwBg2UwzUQg89Kvm0a+aR/9/8mmA1wE3WqVJltEa
        oUq8+o+bwNJVeG03gmLLYz8zwDjADCAH56/n/rLFGMfjJki/TqPVSok6VU5rzEBs37YOd98Q
        r7SflSJFIhQHiEQitC0wKFAs4r/Gle08FMcjZdIU+kuaVtHqFR/GcXbPwC6cyt7dL3vXZ/J+
        +IGRqHyb6UL10XYszCwRWBO8bQFdxYVvlyQ9Lagt+l1s+bQ+vXLP4pRPrzXG9fDJdNfzb9y4
        Rlo3l48/NTflsHSbeq9zY5ICJVkuornY5B8+8R9Y8K59dq7c2l7j7xmwJzc0pNETawha3GiL
        wMhY+dxdrxOs7G8mXj8ISwuH3T64URy7N/i77kdSneALSSWIKtrxRNvzvrbm+yub5v+Yx6b/
        cR8Kfnh5Ib/+sOae5dDHn40duR0znH7SpeHm4H7D5D7PAydszv69LhZZq6Ly0u6cjGvGyBZd
        iGXL50Aennvm1foXJR9x0tKKjoWrTu/7md0ZJbbujaSMfJYmUSr0wtUa6X9lq3HLngQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02RfVAMcRiA/Xa33e2I7ZysM4obGV1Ek+FHTRgfrSHThGH44+5iFbrktsvn
        0NTQ2I7TNGWk8hGuDp25ipw+2GO6SOQquhFOh2Fc8lGUj9FdY8Z/z7zP8877x0uiYismJbel
        pLGaFFWyDBdh162ywJmSizXK2XcforDi+RUCFhmvA3i5S49DS+sZAAt6B1B4OLsfgVmlJhw+
        OHEegS5TIQp1rkwf+Jt/gcA+JwfrHKHQbinCoZCXhcCTlUUo7HjZTEDri3YMOi/korCl6YsP
        LOleBAcN9wD89OMpAe/X5KHwaUsBDk11A/giKWNvW8nkZvUQzM3CLoKpLJMz9odaxmw8ijMN
        xVcI5lN9O84crzIC5qs5kMm+nYMwgnAJjRu1URS1hU3els5qZkUrRUkfLefQVJN4j8WUi2aA
        ztE88CVpag7tPtmO80BEiqlbgDYPPEOHhZRutLl9eEAO8VjaauWGm8+A1rsFwtPg1Az6uNuB
        e1hCBdD2b/3AE6HUIEa/f/0K8Yix1Eq6WCcAD2NUMF2u++Nd8KMi6VdXS4jhY0H0r5c672Hf
        ofmFJrOXxdQCuvpILTbc+9NNp1xeRof6rOrT6AlAFf6nCv9TZwFiBBPYVE6dqObCU8NT2N1h
        nErNaVMSwzbvVJuB98/ykBpww9gbJgCEBAKgSVQm8audVqMU+21R7d3HanYqNNpklhPARBKT
        jfd7zDcpxFSiKo3dwbKprOafRUhfaQYSaOnOtmOqvpmdvDhv8WTbevebKQc6Ap6kHbNZuw8P
        bIIJATbEcSwoMnP+mxGkogHv+dm7TAvaHMy6isp0PqixsrnqQXiUdm1ErE5yMH/q4PSQ02vr
        JzkMYGu/Lb86XWivKo2JzsM6DZZxUc0bJo9892WfPWm3Ppi5FHEtuK/zK5Ex7/ss5X1FzgyJ
        z7wIvbrreyw3wn1Ef+OOk393a8neqnjXI+XPfueY4NBdLWpyTUXZIWlm38bykOUGvmh1XKTt
        c0LrB7lCuT39R8GKpa09C40rYuRv958tWxUajTcq1C7/lo4zs3PIulVtc+MWqhrjDfNjpiSr
        /aOXr3E674hkGJekCpejGk71F1twXMBWAwAA
X-CMS-MailID: 20210603094700epcas1p3921df0cd92caca7b098205d35d861eb9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210603094700epcas1p3921df0cd92caca7b098205d35d861eb9
References: <10c02317-7528-bbad-3cfb-75db54d2ab91@acm.org>
        <CGME20210603094700epcas1p3921df0cd92caca7b098205d35d861eb9@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On 6/2/21 5:10 AM, Changheun Lee wrote:
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
> > +
> >  	/*
> >  	 * Set a reasonable default alignment:  The larger of 32-byte (dword),
> >  	 * which is a common minimum for HBAs, and the minimum DMA alignment,
> 
> Has this patch been tested with dm-crypt on top of a SCSI device? I'm
> concerned that this patch will trigger data corruption with dm-crypt on
> top because the above change will make the following dm-crypt code fail
> for a sufficiently large bio:
> 
> bio_add_page(clone, page, len, 0);
> 
> When testing dm-crypt on top of this patch series, please change the
> above dm-crypt code into the following before running any tests:
> 
> WARN_ON(bio_add_page(clone, page, len, 0) < len);
> 
> Thanks,
> 
> Bart.

I think it will be OK if nr_iovecs is not over BIO_MAX_VECS in
crypt_alloc_buffer(). Because page is added to bio in PAGE_SIZE as maximum,
and the minimum of max_bio_bytes is "BIO_MAX_VECS * PAGE_SIZE".

for (i = 0; i < nr_iovecs; i++) {
	page = mempool_alloc(&cc->page_pool, gfp_mask);
	if (!page) {
		crypt_free_buffer_pages(cc, clone);
		bio_put(clone);
		gfp_mask |= __GFP_DIRECT_RECLAIM;
		goto retry;
	}

	len = (remaining_size > PAGE_SIZE) ? PAGE_SIZE : remaining_size;

	bio_add_page(clone, page, len, 0);

	remaining_size -= len;
}

Anyway as your advise, I'm checking it in my test environment. There are no
problem by now yet. I'm testing with 1MB max_bio_bytes of SCSI, and UINT_MAX
max_bio_bytes of dm-crypt.

Thank you,
Changheun Lee.
