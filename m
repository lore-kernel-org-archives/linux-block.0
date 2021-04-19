Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E310C433B4
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 06:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DBAF6113C
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 06:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbhDSGIT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 02:08:19 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:46668 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhDSGIT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 02:08:19 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210419060748epoutp02998adf19783ad3605f5a10530986ee76~3LV0BhCZJ1486114861epoutp02d
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 06:07:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210419060748epoutp02998adf19783ad3605f5a10530986ee76~3LV0BhCZJ1486114861epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618812468;
        bh=nF6znZkX0nZv9Cb0T7Aw8DoiaR5+h9LS434ZYxvMBxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7XAaifvuXVX0XBEEIwzCYETu7HJzhrxFTigaPXW7jwg7G7x6t0prg0axcyyyHnP1
         kmWrtv+cWDgNXwUJnvBhBxnIS+B/tMeHloZmQhtxbdc3uMBrswWdmyEYdlRdGuI8fg
         0y4OdYTJ5gPTOPiJ2n5bsg8BvxhJ0OuNW/rkwD0c=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210419060747epcas1p3a2e335ff4eb20f7d9f318dcd9446073e~3LVzX9Tk31025310253epcas1p3g;
        Mon, 19 Apr 2021 06:07:47 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FNxDy240vz4x9Q1; Mon, 19 Apr
        2021 06:07:46 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.7F.10258.23E1D706; Mon, 19 Apr 2021 15:07:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210419060745epcas1p220138a5de8e08201a6bcd9193c37fc51~3LVxJnycj1909119091epcas1p2P;
        Mon, 19 Apr 2021 06:07:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210419060745epsmtrp19e2e9ad3119a1c13a396d32bae2fe433~3LVxIgAh01819718197epsmtrp1R;
        Mon, 19 Apr 2021 06:07:45 +0000 (GMT)
X-AuditID: b6c32a38-419ff70000002812-74-607d1e3299dc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.8B.08163.13E1D706; Mon, 19 Apr 2021 15:07:45 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210419060745epsmtip20b2d689f2a40b160ff5086a2a3475394~3LVw5h5zJ0704807048epsmtip2C;
        Mon, 19 Apr 2021 06:07:45 +0000 (GMT)
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
Subject: Re: [PATCH v7 1/3] bio: limit bio max size
Date:   Mon, 19 Apr 2021 14:49:51 +0900
Message-Id: <20210419054951.6244-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <9ad8ef3f-905c-543e-d2af-7bf2f43ea04c@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHd3pLb5FVL+XhgWyuNLAEJqWlPM4QnBsGr3Mq24wEMwYd3FFC
        abvedq9qNPIcIg95yVsEFCsbCyKPTlAhBHGoI7wCDJgBIRhBR5WUTbO1XNj47/v7nc/5fX+/
        8+BifBPHlZug1FIapUwh5Gxht3R7env77jgRI14ttUPlhhaArk7mcFDRs1UMpaavsFByTSMH
        /Zp7kYWyZk/boFeZUyz04iGNOsbfQYPGcg7qyk9moeJr5Rgame7HUffUMBs9rM3D0P2+ZRtU
        ObMH/XW5B6Cn5lEc3W3Lx1BjxypnjzM5OHSAzEtewsn20kmcvFbvRQ7e05FNhh845M2KBpx8
        2jnMIbObDYA0Ne0g02+dYYXbHVMEyylZHKURUMpYVVyCMj5EeODT6NBo/wCxxFvyLgoUCpSy
        JCpEuPejcO+wBIVlUqHga5lCZ0mFy2ha6LM7WKPSaSmBXEVrQ4SUOk6hlojVIlqWROuU8aJY
        VVKQRCz29beQMQp5wew0UN92/bbln3pwChidMoEtFxJ+0DR1Fc8EW7h8og3A1HMZ68EygFnn
        amyYwATg47J0sLHl/EQDxiwYAeytm8T/ox5cXGJZKQ6xE2YvjnOs2pFwhoPPV4AVwog0NhxP
        GVlbcCCksPVVNW7VbMID1t/4ZS3PI4Jg3dAVDmP3Fnw5nYVZtS2xC448mmEzjD3sK5ld05iF
        Sb5ettYSJMxc2H49w9I41xLshR3mRKaOA3zc24wz2hUu5KThDH8GwOS0KsAEuQDWzl9iMZQU
        LptMwFoIIzxho9GHSbvB9r8rAGO8FS69yFr34sGMND6DuMP+lGlsw2v+x/b1iiQ8vbzCZk4r
        G0BzRjWeCwSlm+Yp3TRP6f/OFwBmAM6Umk6Kp2iJ2m/zJTeBtdfvhdpAxeIzURdgcUEXgFxM
        6MibPnE8hs+Lk333PaVRRWt0CoruAv6W087DXJ1iVZbvo9RGS/x9pVIp8gsIDPCXCrfz4kP1
        MXwiXqalEilKTWk29rG4tq6nWPt6/jx6rKTcFKGtiqrkBTnU9ES6Vz55I1v/2xGd90nWvjdd
        Rh98nOpCvJ0zfOXwlwVwdkBf2Ns5x7/fu+yznw50cYv9oOpRgebOyf6xcY+Gs1E238zdmZFv
        G5z9Sv4Z3zHB2CyTHr57yC3gVvU9r/qB2q0G01lz8fPREsnPodjET04r7VRV4esxAufjTk9C
        x24aUvIjdp/vjBgVF3kumo/WdXXrvzgomnt/si9M79svYouG7OfohcjinTPNA69hPkGt2zWt
        5ii7I5/AP/iRksLPO+0mPHyay8ZgvrHnhmrh4Pwu6nZi2O/Sjv3uYR8uRQULLjvVp14Sz+sV
        RbnvvbQXFxcI2bRcJvHCNLTsXzf5LuOGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCSvK6hXG2CweaLIhZzVm1jtFh9t5/N
        YtqHn8wWre3fmCyaF69nszg9YRGTRc+TJlaLv133mCy+Piy22HtL2+LyrjlsFocmNzNZTN88
        h9ni2v0z7BaH711lsXi4ZCKzxbmTn1gt5j12sPi1/Cijxfsf19ktTu2YzGyxfu9PNgcxj8tX
        vD0mNr9j99g56y67x+YVWh6Xz5Z6bFrVyeaxf+4ado/3+66yefRtWcXo8XmTnEf7gW6mAO4o
        LpuU1JzMstQifbsErowpT+4zFhyUqtj2fwVjA+Mu0S5GTg4JAROJGbfXMHcxcnEICexglJgx
        8TUzREJK4viJt6xdjBxAtrDE4cPFEDUfGSXapv4Hq2ET0JHoe3uLDcQWERCTuPzlGyNIEbPA
        AhaJgztPsIMkhAWMJbb/XQhmswioSqzYsxusgVfASmLplZVsEMvkJf7c7wEbyilgLXHt6WMW
        EFsIqObB41ksEPWCEidnPgGzmYHqm7fOZp7AKDALSWoWktQCRqZVjJKpBcW56bnFhgVGeanl
        esWJucWleel6yfm5mxjB0amltYNxz6oPeocYmTgYDzFKcDArifDer61JEOJNSaysSi3Kjy8q
        zUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoEpyGmzwqlDRS9uFcsnu5xNV5Xx
        WbTkeKW+lkJnt8k1zl/fnn7i890h/UGv/LWnHa9ekFvxQh+1pCxnHbfNUnVdfRm/M37mPNTg
        yWeINfzQF/T0RlqmyClF1gADE57JXyb93i3d+dNmSVZjWt6GiOCDT7liPv9fo7DrWMfXCctn
        tzScUY9vDZjBr770Rwbv5ZaCnM9vvC+LJT5vFVjlvzau1ET1vO/eloOnPr3dZVv5QFi+231q
        d31UyF9z5ZaU/20eOa9kvBNTZ6pHsq1a83JK4jqREM+p8X+m5O922D0/0mhh4WO9Rkuvn1uu
        CvZt/JHhLMK7WSJ5c4bztfKoqVvX2T09IZ3Asljq+sWuvUosxRmJhlrMRcWJAOpNBv49AwAA
X-CMS-MailID: 20210419060745epcas1p220138a5de8e08201a6bcd9193c37fc51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210419060745epcas1p220138a5de8e08201a6bcd9193c37fc51
References: <9ad8ef3f-905c-543e-d2af-7bf2f43ea04c@acm.org>
        <CGME20210419060745epcas1p220138a5de8e08201a6bcd9193c37fc51@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > @@ -167,6 +168,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
> >  	max_sectors = round_down(max_sectors,
> >  				 limits->logical_block_size >> SECTOR_SHIFT);
> >  	limits->max_sectors = max_sectors;
> > +	limits->bio_max_bytes = max_sectors << SECTOR_SHIFT;
> >  
> >  	q->backing_dev_info->io_pages = max_sectors >> (PAGE_SHIFT - 9);
> >  }
> 
> Can the new shift operation overflow? If so, how about using
> check_shl_overflow()?

Actually, overflow might be not heppen in case of physical device.
But I modified as below. feedback about this.

@@ -168,6 +169,9 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 				 limits->logical_block_size >> SECTOR_SHIFT);
 	limits->max_sectors = max_sectors;
 
+	limits->bio_max_bytes = check_shl_overflow(max_sectors, SECTOR_SHIFT,
+		&limits->bio_max_bytes) ? UINT_MAX : max_sectors << SECTOR_SHIFT;
+
 	q->backing_dev_info->io_pages = max_sectors >> (PAGE_SHIFT - 9);
 }
 EXPORT_SYMBOL(blk_queue_max_hw_sectors);

> 
> >>> @@ -538,6 +540,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
> >>>  {
> >>>  	unsigned int top, bottom, alignment, ret = 0;
> >>>  
> >>> +	t->bio_max_bytes = min_not_zero(t->bio_max_bytes, b->bio_max_bytes);
> >>> +
> >>>  	t->max_sectors = min_not_zero(t->max_sectors, b->max_sectors);
> >>>  	t->max_hw_sectors = min_not_zero(t->max_hw_sectors, b->max_hw_sectors);
> >>>  	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);
> >>
> >> The above will limit bio_max_bytes for all stacked block devices, which
> >> is something we do not want. I propose to set t->bio_max_bytes to
> >> UINT_MAX in blk_stack_limits() and to let the stacked driver (e.g.
> >> dm-crypt) decide whether or not to lower that value.
> > 
> > Actually, bio size should be limited in dm-crypt too. Because almost I/O
> > from user space will be gone to dm-crypt first. I/O issue timing will be
> > delayed if bio size is not limited in dm-crypt.
> > Do you have any idea to decide whether takes lower bio max size, or not
> > in the stacked driver?
> > Add a flag to decide this in driver layer like before?
> > Or insert code manually in each stacked driver if it is needed?
> 
> There will be fewer stacked drivers for which the bio size has to be
> limited than for which the bio size has not to be limited. Hence the
> proposal to set t->bio_max_bytes to UINT_MAX in blk_stack_limits() and
> to let the stacked driver (e.g. dm-crypt) decide whether or not to lower
> that value.

I see what you said. I'll set t->bio_max_bytes to UINT_MAX in
blk_stack_limits() as you mentioned.

> 
> > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > index d0246c92a6e8..e5add63da3af 100644
> > --- a/include/linux/bio.h
> > +++ b/include/linux/bio.h
> > @@ -106,6 +106,8 @@ static inline void *bio_data(struct bio *bio)
> >  	return NULL;
> >  }
> >  
> > +extern unsigned int bio_max_size(struct bio *bio);
> 
> You may want to define bio_max_size() as an inline function in bio.h
> such that no additional function calls are introduced in the hot path.

I tried, but it is not easy. because request_queue structure of blkdev.h
should be referred in bio.h. I think it's not good to apply as a inline function.


Thanks,

Changheun Lee.
