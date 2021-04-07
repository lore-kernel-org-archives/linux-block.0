Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E55C433ED
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 05:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25897613C6
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 05:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244534AbhDGFYW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 01:24:22 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:30000 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhDGFYW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Apr 2021 01:24:22 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210407052411epoutp034434306718fe7ddcadccb1a075e6f5ac~zfATBf2q01323213232epoutp03V
        for <linux-block@vger.kernel.org>; Wed,  7 Apr 2021 05:24:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210407052411epoutp034434306718fe7ddcadccb1a075e6f5ac~zfATBf2q01323213232epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617773051;
        bh=2voDvXq2nDuR/hOHoTqOD0pNepaya3MxTm8inBAaciU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZnFpso9aKvlC8k+A1YRhklhv4g0vpnxwnE2tmKbxq5f0BDKTO0mn8OYVhKpVxNu4
         q5xCk3Eie5S9CsauHSrD0fLRcLrIUnckbj/V7cf32YNsAao2jC8Ii/j4mDFmZkDykb
         aYT7LRn+L3pJEHZJJUjnZlxWOGkkviuuC2GRlr14=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210407052409epcas1p3f7b4e02f6f12ddfd5d3e123259a23350~zfARwbG4y2110021100epcas1p3Z;
        Wed,  7 Apr 2021 05:24:09 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4FFXr82FGvz4x9QK; Wed,  7 Apr
        2021 05:24:08 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.60.10347.8F14D606; Wed,  7 Apr 2021 14:24:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210407052407epcas1p1d0b5d23ac04a68760f691954e7ada3dd~zfAP1P_z10428304283epcas1p1J;
        Wed,  7 Apr 2021 05:24:07 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210407052407epsmtrp19b14a0a93cf19fb298bd17092fbc2830~zfAPzDS8L2122521225epsmtrp1c;
        Wed,  7 Apr 2021 05:24:07 +0000 (GMT)
X-AuditID: b6c32a39-15dff7000002286b-d9-606d41f86ed7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.A6.08745.7F14D606; Wed,  7 Apr 2021 14:24:07 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210407052407epsmtip20171785f80fdac1ac296d2ad499b4d92~zfAPhlldE1537815378epsmtip2M;
        Wed,  7 Apr 2021 05:24:07 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     gregkh@linuxfoundation.org
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, hch@infradead.org,
        jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mj0123.lee@samsung.com,
        nanich.lee@samsung.com, osandov@fb.com, patchwork-bot@kernel.org,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        tj@kernel.org, tom.leiming@gmail.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
Subject: Re: [RESEND PATCH v5 1/2] bio: limit bio max size
Date:   Wed,  7 Apr 2021 14:06:33 +0900
Message-Id: <20210407050633.949-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <YG09t9VRYfxRnhPt@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGJsWRmVeSWpSXmKPExsWy7bCmge4Px9wEg++9nBZzVm1jtFh9t5/N
        orX9G5NF8+L1bBanJyxisuh50sRq8bfrHpPF14fFFntvaVtc3jWHzeLQ5GYmi+mb5zBbXLt/
        ht3i8L2rLBYPl0xktjh38hOrxbzHDha/lh9ltHj/4zq7xakdk5kt1u/9yeYg6jGx+R27x85Z
        d9k9Nq/Q8rh8ttRj06pONo/9c9ewe7zfd5XNo2/LKkaPz5vkPNoPdDMFcEXl2GSkJqakFimk
        5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAPaikUJaYUwoUCkgsLlbS
        t7Mpyi8tSVXIyC8usVVKLUjJKTA0KNArTswtLs1L10vOz7UyNDAwMgWqTMjJuNvmX3DFvOLh
        xOfMDYxnVLsYOTkkBEwkjvX8YwKxhQR2MEqsmMjWxcgFZH9ilJi1Yg87hPOZUeLSzQ5mmI7T
        szdBVe1ilFjbuYcFrurjhEdsIFVsAjoSfW9vgdkiAnIST27/YQYpYhZ4wSwxreMO2ChhASuJ
        rztegy1nEVCVWHzsP5jNK2Apsb+nhRFinbzEn/s9YPWcApoS157uh6oRlDg58wkLiM0MVNO8
        dTZQDQdQ/QcOiekSEK0uEnP3rIIaIyzx6vgWdghbSuJlfxvYaxIC3YwSzW3zGSGcCYwSS54v
        Y4KoMpb49PkzI8hQZqDF63fpQ4QVJXb+nssIsZdP4t3XHlaIvbwSHW1CECUqEmda7jPD7Hq+
        difURA+JJd9OsEHCukbi+PKnrBMYFWYh+WYWkm9mISxewMi8ilEstaA4Nz212LDAFDmCNzGC
        E7yW5Q7G6W8/6B1iZOJgPMQowcGsJMK7ozc7QYg3JbGyKrUoP76oNCe1+BCjKTCsJzJLiSbn
        A3NMXkm8oamRsbGxhYmZuZmpsZI4b5LBg3ghgfTEktTs1NSC1CKYPiYOTqkGpklTK28l7H1y
        s3xfOp8Tl3iwyLbOH+38dqkuP9tfljTb3FJd//pyqG968KL2iNamfK1K5UubpJ+1ZJmk3tDj
        Uuef/Pr0qo2e5VlGTWlHd/k1KuT/UPZSvHfSUubYW4Nl4v38Ufqyh4+nbdJkPi78OniXoebt
        7oPMIUXKryb+kws6JCt6u3NHB5fSbtEHR7lVb7O/Xbj0157mw1VlVZc1lwiU6fhW7Vlxt8qS
        47lejVDq3qUrp7V6WP+4ezRx5qrvhnGhEUtYvU5f6a86G6q74e7a7a8figmsvKct/9V7Zmv0
        +r9hJlKzXj04bjfvs8zhVjslM9kGVofLU66vyNvfUpxst+Grk/T39a9/F7a5KrEUZyQaajEX
        FScCAKR4Wix5BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSvO53x9wEg3tHpC3mrNrGaLH6bj+b
        RWv7NyaL5sXr2SxOT1jEZNHzpInV4m/XPSaLrw+LLfbe0ra4vGsOm8Whyc1MFtM3z2G2uHb/
        DLvF4XtXWSweLpnIbHHu5CdWi3mPHSx+LT/KaPH+x3V2i1M7JjNbrN/7k81B1GNi8zt2j52z
        7rJ7bF6h5XH5bKnHplWdbB77565h93i/7yqbR9+WVYwenzfJebQf6GYK4IrisklJzcksSy3S
        t0vgyrjb5l9wxbzi4cTnzA2MZ1S7GDk5JARMJE7P3sTWxcjFISSwg1Fi06N57BAJKYnjJ96y
        djFyANnCEocPF0PUfGSUOHb2BStIDZuAjkTf21tsILaIgJzEk9t/mEGKmAWaWCSun1/NCJIQ
        FrCS+LrjNROIzSKgKrH42H8wm1fAUmJ/TwsjxDJ5iT/3e5hBbE4BTYlrT/eD1QgJaEjs+3We
        DaJeUOLkzCcsIDYzUH3z1tnMExgFZiFJzUKSWsDItIpRMrWgODc9t9iwwCgvtVyvODG3uDQv
        XS85P3cTIzgStbR2MO5Z9UHvECMTB+MhRgkOZiUR3h292QlCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1ME1xDdCXcmO3rC27UMph+PGpCNe8E69vnnZS
        Nb7zbsfpmVUpHh79Yf3vGVXtnZ4GrMsxz7J+UJv9m+P884lLN71I+JRx+7hTC3v81dpu5YKy
        Rz7uLkyPp3+589W+dYVqxU6WyPsHlTYsko7btnJlX873+YJbE/atzHLSPdOyc+ZW47df7vYc
        cHCpWyD1RMAk8Wn1R1eBVh6jS1tCRNfPfn7H9XnE3VWff/xKXXQy2/JAt27wTuOWc3W3PTak
        THtr1vuj4XDD+ZdB0mXuvxtOHLyfaTLDhGf5Te68zwLcsfvuxSnNbpdtcbl4aJ9XCt9rzV5l
        E8bOr4rNpeJJ+7PfPZzfcDH2S0zvY/t5Lk0eakosxRmJhlrMRcWJADbxPkYzAwAA
X-CMS-MailID: 20210407052407epcas1p1d0b5d23ac04a68760f691954e7ada3dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210407052407epcas1p1d0b5d23ac04a68760f691954e7ada3dd
References: <YG09t9VRYfxRnhPt@kroah.com>
        <CGME20210407052407epcas1p1d0b5d23ac04a68760f691954e7ada3dd@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Wed, Apr 07, 2021 at 09:16:12AM +0900, Changheun Lee wrote:
> > > On Tue, Apr 06, 2021 at 10:31:28AM +0900, Changheun Lee wrote:
> > > > > bio size can grow up to 4GB when muli-page bvec is enabled.
> > > > > but sometimes it would lead to inefficient behaviors.
> > > > > in case of large chunk direct I/O, - 32MB chunk read in user space -
> > > > > all pages for 32MB would be merged to a bio structure if the pages
> > > > > physical addresses are contiguous. it makes some delay to submit
> > > > > until merge complete. bio max size should be limited to a proper size.
> > > > > 
> > > > > When 32MB chunk read with direct I/O option is coming from userspace,
> > > > > kernel behavior is below now in do_direct_IO() loop. it's timeline.
> > > > > 
> > > > >  | bio merge for 32MB. total 8,192 pages are merged.
> > > > >  | total elapsed time is over 2ms.
> > > > >  |------------------ ... ----------------------->|
> > > > >                                                  | 8,192 pages merged a bio.
> > > > >                                                  | at this time, first bio submit is done.
> > > > >                                                  | 1 bio is split to 32 read request and issue.
> > > > >                                                  |--------------->
> > > > >                                                   |--------------->
> > > > >                                                    |--------------->
> > > > >                                                               ......
> > > > >                                                                    |--------------->
> > > > >                                                                     |--------------->|
> > > > >                           total 19ms elapsed to complete 32MB read done from device. |
> > > > > 
> > > > > If bio max size is limited with 1MB, behavior is changed below.
> > > > > 
> > > > >  | bio merge for 1MB. 256 pages are merged for each bio.
> > > > >  | total 32 bio will be made.
> > > > >  | total elapsed time is over 2ms. it's same.
> > > > >  | but, first bio submit timing is fast. about 100us.
> > > > >  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
> > > > >       | 256 pages merged a bio.
> > > > >       | at this time, first bio submit is done.
> > > > >       | and 1 read request is issued for 1 bio.
> > > > >       |--------------->
> > > > >            |--------------->
> > > > >                 |--------------->
> > > > >                                       ......
> > > > >                                                  |--------------->
> > > > >                                                   |--------------->|
> > > > >         total 17ms elapsed to complete 32MB read done from device. |
> > > > > 
> > > > > As a result, read request issue timing is faster if bio max size is limited.
> > > > > Current kernel behavior with multipage bvec, super large bio can be created.
> > > > > And it lead to delay first I/O request issue.
> > > > > 
> > > > > Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> > > > > ---
> > > > >  block/bio.c            | 13 ++++++++++++-
> > > > >  include/linux/bio.h    |  2 +-
> > > > >  include/linux/blkdev.h |  3 +++
> > > > >  3 files changed, 16 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/block/bio.c b/block/bio.c
> > > > > index 1f2cc1fbe283..c528e1f944c7 100644
> > > > > --- a/block/bio.c
> > > > > +++ b/block/bio.c
> > > > > @@ -287,6 +287,17 @@ void bio_init(struct bio *bio, struct bio_vec *table,
> > > > >  }
> > > > >  EXPORT_SYMBOL(bio_init);
> > > > >  
> > > > > +unsigned int bio_max_size(struct bio *bio)
> > > > > +{
> > > > > +	struct request_queue *q = bio->bi_disk->queue;
> > > > > +
> > > > > +	if (blk_queue_limit_bio_size(q))
> > > > > +		return blk_queue_get_max_sectors(q, bio_op(bio))
> > > > > +			<< SECTOR_SHIFT;
> > > > > +
> > > > > +	return UINT_MAX;
> > > > > +}
> > > > > +
> > > > >  /**
> > > > >   * bio_reset - reinitialize a bio
> > > > >   * @bio:	bio to reset
> > > > > @@ -877,7 +888,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
> > > > >  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> > > > >  
> > > > >  		if (page_is_mergeable(bv, page, len, off, same_page)) {
> > > > > -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> > > > > +			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {
> > > > >  				*same_page = false;
> > > > >  				return false;
> > > > >  			}
> > > > > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > > > > index 1edda614f7ce..13b6f6562a5b 100644
> > > > > --- a/include/linux/bio.h
> > > > > +++ b/include/linux/bio.h
> > > > > @@ -113,7 +113,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
> > > > >  	if (bio->bi_vcnt >= bio->bi_max_vecs)
> > > > >  		return true;
> > > > >  
> > > > > -	if (bio->bi_iter.bi_size > UINT_MAX - len)
> > > > > +	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
> > > > >  		return true;
> > > > >  
> > > > >  	return false;
> > > > > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > > > > index f94ee3089e01..3aeab9e7e97b 100644
> > > > > --- a/include/linux/blkdev.h
> > > > > +++ b/include/linux/blkdev.h
> > > > > @@ -621,6 +621,7 @@ struct request_queue {
> > > > >  #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
> > > > >  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
> > > > >  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
> > > > > +#define QUEUE_FLAG_LIMIT_BIO_SIZE 30	/* limit bio size */
> > > > >  
> > > > >  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
> > > > >  				 (1 << QUEUE_FLAG_SAME_COMP) |		\
> > > > > @@ -667,6 +668,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
> > > > >  #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
> > > > >  #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
> > > > >  #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
> > > > > +#define blk_queue_limit_bio_size(q)	\
> > > > > +	test_bit(QUEUE_FLAG_LIMIT_BIO_SIZE, &(q)->queue_flags)
> > > > >  
> > > > >  extern void blk_set_pm_only(struct request_queue *q);
> > > > >  extern void blk_clear_pm_only(struct request_queue *q);
> > > > > -- 
> > > > > 2.28.0
> > > > > 
> > > > 
> > > > Please feedback to me if more modification is needed to apply. :)
> > > 
> > > You are adding code that tests for a value to be set, yet you never set
> > > it in this code so why is it needed at all?
> > 
> > This patch is a solution for some inefficient case of multipage bvec like
> > as current DIO scenario. So it's not set as a default.
> > It will be set when bio size limitation is needed in runtime.
> 
> Set where?

In my environment, set it on init.rc file like as below.
"echo 1 > /sys/block/sda/queue/limit_bio_size"


Thanks,

Changheun Lee
