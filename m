Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C16C433ED
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 09:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35FD0613A7
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 09:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346368AbhDGJq0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 05:46:26 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:43293 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbhDGJqZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Apr 2021 05:46:25 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210407094614epoutp03b2c99b3bff2100bae62b4ffc33200fbb~zilGgFyIM0525005250epoutp03k
        for <linux-block@vger.kernel.org>; Wed,  7 Apr 2021 09:46:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210407094614epoutp03b2c99b3bff2100bae62b4ffc33200fbb~zilGgFyIM0525005250epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617788774;
        bh=WB0YPGX3l1uZv3fkLzMgay1nU54Ra34LNUzJmmDOi0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eIvJ7xSUbuF6gqp2Y6yP0C+XFbZ43TBPIKSkSaE7niAQj9cS+5a9wFwKzAUMu5ACZ
         BoktrUT1+JCP0DFy5P5winXhkmA+tIunvOLJDJTkX9URAPTtis9yp/76ccpj7PFBxD
         vdSqayyIAoKus4w2on7LPzc1EfNem7gMhECAwoyY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210407094612epcas1p1f383f412d54ca39e83c8e632f7db985b~zilFGiD2d0939609396epcas1p1g;
        Wed,  7 Apr 2021 09:46:12 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.161]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FFffW2tWdz4x9Pv; Wed,  7 Apr
        2021 09:46:11 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.3C.10347.36F7D606; Wed,  7 Apr 2021 18:46:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210407094610epcas1p472207e8d3ca0e5e697974c993a2a34f7~zilDGzkPJ2955429554epcas1p4O;
        Wed,  7 Apr 2021 09:46:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210407094610epsmtrp10db5250b1cf1740dc7564454d09d2b4b~zilDFtKtH2911929119epsmtrp1D;
        Wed,  7 Apr 2021 09:46:10 +0000 (GMT)
X-AuditID: b6c32a39-15dff7000002286b-4d-606d7f639e84
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.47.08745.26F7D606; Wed,  7 Apr 2021 18:46:10 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210407094610epsmtip16b0bb46e051d954b7d7251ea3e5d2c0f~zilCxYV1D3001130011epsmtip1y;
        Wed,  7 Apr 2021 09:46:10 +0000 (GMT)
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
Subject: Re: [RESEND,v5,1/2] bio: limit bio max size
Date:   Wed,  7 Apr 2021 18:28:36 +0900
Message-Id: <20210407092836.13016-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <YG1iC944hUkBniDM@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTZxzd11vuLSjzWkQ/iXNddclkAq2l8DHAgI95zVwg2WImjpU7uKOM
        vtZbnDqNxCKUijyCgwEFN2CohQ0FRwoRdBAEBjIzQ3U6QCMGNl6O0g032NZyIeO/c34553dy
        vocAEz7F/QQpGgOj19AqMe7Fb+rYFhSQeEqdIPncvAZZrE0A1Q7m4ehM1h88ZKyqx1FvfiUP
        5Yyc9kAL5iEecj5mUeuD19HdFguO2guNPFTcaMGQfbiPQB1DA3z0uLoAQ/09Mx6o4kkU+uti
        J0DTc/cI9IOtEEP1rc/xKF+qwDhFUM2lgwTVeMmfuns7jWqwZuPUjfI6gppuG8Cp3GtWQDka
        NlNZN8/yYr3iVBFKhk5i9CJGk6hNStEkR4rfekexWyEPkUgDpGEoVCzS0GomUrznQGzAmykq
        V0Gx6AitSnONYmmWFQftjNBr0wyMSKllDZFiRpek0kklukCWVrNpmuTARK36DalEskPuUiao
        lF0lIp3zwNHBW1eIdGCXmYGnAJLBsOJJDmYGXgIhaQPw/nTdEpkB8MK5LsARB4BXrfW8ZUtt
        jQNzYyHZAuBsdRCHXaLb5vfcGCe3w9zJB7gbryM3w5GH84tbMXIMg0WmX1xEIPBxLer5l+/W
        8MlX4fmLecCNvclweLnSjHNZL8P54ZxFuSe5DeZdDecka2FPyciiFXNJjN+VLa6H5IQAnp9d
        IDjvHmjJnedz2Af+1nVtae4Hf83LJDjDWQCNmRcAR/IBrB6tWWopgzMOB3AnY67k+pYgbvwK
        bP67HHDJL8IpZ46HWwJJb2jKFHKSrbAvYxhbzhr9pnlpIwU7TEMEd1YnYLYxm8gHotIVfUpX
        9Cn9P/hLgFnBekbHqpMZVqqTr7zfBrD43v3DbKB48llgO+AJQDuAAky8ztt2LjVB6J1EHzvO
        6LUKfZqKYduB3HXYBZifb6LW9WE0BoVUvkMmk6HgkNAQuUy8wftDySOFkEymDUwqw+gY/bKP
        J/D0S+eFVtwviVv/cUPnQpLUHm57+HvVu10nbX8axmsN090Ztw7G/9R/+cqW00dnnX3gaWSs
        8vqPn2TUftFw8NCJb/EFxqEzxdPdvm1rgo8oDk/t3q+sq8kufCkzus0YPfTZ+6uCbR94RQ0K
        /WPSW+SyGJVPqL14l8Nv9tQZ3keRxtVz+yZSO8Mm3y4Me35Ibt3/tfS1/rnjqc+KSKe6Z2zt
        KEtoLN1N8cXm1XfGt27a12rybRTBbPMNWdFXrdstnT8LomMs1x91/zM2sStgZ7S/fcsL5ZVo
        Yfrep3tRL0+/oWhVVfrJsY47sRvHsyJ6D5fFUz2bnONz32+8ZIrDBm4eqyao1DL7vJjPKmmp
        P6Zn6f8Aw0p6zHgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSnG5SfW6CQe9COYs5q7YxWqy+289m
        0dr+jcmiefF6NovTExYxWfQ8aWK1+Nt1j8ni68Nii723tC0u75rDZnFocjOTxfTNc5gtrt0/
        w25x+N5VFouHSyYyW5w7+YnVYt5jB4tfy48yWrz/cZ3d4tSOycwW6/f+ZHMQ9ZjY/I7dY+es
        u+wem1doeVw+W+qxaVUnm8f+uWvYPd7vu8rm0bdlFaPH501yHu0HupkCuKK4bFJSczLLUov0
        7RK4Mo7PVCj46lNx99gG9gbGa8ZdjJwcEgImEquXfWbuYuTiEBLYwSixqnMjM0RCSuL4ibes
        XYwcQLawxOHDxRA1Hxkl/vdeA6thE9CR6Ht7iw3EFhGQk3hy+w/YIGaBJhaJ6+dXM4I0CwNt
        OPmfBaSGRUBVYsryfkYQm1fAWmLloi42iF3yEn/u9zCDlHMKaEr0b7QGCQsJaEi8n/qUGaJc
        UOLkzCdgY5iBypu3zmaewCgwC0lqFpLUAkamVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5
        uZsYwVGopbWDcc+qD3qHGJk4GA8xSnAwK4nw7ujNThDiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        e6HrZLyQQHpiSWp2ampBahFMlomDU6qB6XTaudet3X+U5T0FtS6yn5777G7sr9WGk5LLivJO
        FjQHLj+jmsX368yj+vD3lW8vxsz8sMrxhu/DDU5zPb4unqQU9D/euO8X96uGlopyYbutM7/V
        Hcx2Lb2/Mybyu++GwN7Ll1jXFMYXhkdwcm76wOZY8OzDkeSVnCHrgu9l/zi+tvBD42yV+Scf
        lTe9/C10YX7qJA2uFMaZ0e+XL00NEDa+z6zwqGLhZ4nba2adLdKoyDG2lLz7N3r3/COfd879
        fuK41L9AqVevl60K5NrLzlkiHu0/T3XX9GoHkSbV262r6/eXntSaVl5y9c2G2beAEfd0aZuz
        yHfjtrOnA0MnVDgccDd9aaU48XQvT5vRaiWW4oxEQy3mouJEAKp0r+oxAwAA
X-CMS-MailID: 20210407094610epcas1p472207e8d3ca0e5e697974c993a2a34f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210407094610epcas1p472207e8d3ca0e5e697974c993a2a34f7
References: <YG1iC944hUkBniDM@kroah.com>
        <CGME20210407094610epcas1p472207e8d3ca0e5e697974c993a2a34f7@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Wed, Apr 07, 2021 at 03:55:07PM +0900, Changheun Lee wrote:
> > > On Wed, Apr 07, 2021 at 02:06:33PM +0900, Changheun Lee wrote:
> > > > > On Wed, Apr 07, 2021 at 09:16:12AM +0900, Changheun Lee wrote:
> > > > > > > On Tue, Apr 06, 2021 at 10:31:28AM +0900, Changheun Lee wrote:
> > > > > > > > > bio size can grow up to 4GB when muli-page bvec is enabled.
> > > > > > > > > but sometimes it would lead to inefficient behaviors.
> > > > > > > > > in case of large chunk direct I/O, - 32MB chunk read in user space -
> > > > > > > > > all pages for 32MB would be merged to a bio structure if the pages
> > > > > > > > > physical addresses are contiguous. it makes some delay to submit
> > > > > > > > > until merge complete. bio max size should be limited to a proper size.
> > > > > > > > > 
> > > > > > > > > When 32MB chunk read with direct I/O option is coming from userspace,
> > > > > > > > > kernel behavior is below now in do_direct_IO() loop. it's timeline.
> > > > > > > > > 
> > > > > > > > >  | bio merge for 32MB. total 8,192 pages are merged.
> > > > > > > > >  | total elapsed time is over 2ms.
> > > > > > > > >  |------------------ ... ----------------------->|
> > > > > > > > >                                                  | 8,192 pages merged a bio.
> > > > > > > > >                                                  | at this time, first bio submit is done.
> > > > > > > > >                                                  | 1 bio is split to 32 read request and issue.
> > > > > > > > >                                                  |--------------->
> > > > > > > > >                                                   |--------------->
> > > > > > > > >                                                    |--------------->
> > > > > > > > >                                                               ......
> > > > > > > > >                                                                    |--------------->
> > > > > > > > >                                                                     |--------------->|
> > > > > > > > >                           total 19ms elapsed to complete 32MB read done from device. |
> > > > > > > > > 
> > > > > > > > > If bio max size is limited with 1MB, behavior is changed below.
> > > > > > > > > 
> > > > > > > > >  | bio merge for 1MB. 256 pages are merged for each bio.
> > > > > > > > >  | total 32 bio will be made.
> > > > > > > > >  | total elapsed time is over 2ms. it's same.
> > > > > > > > >  | but, first bio submit timing is fast. about 100us.
> > > > > > > > >  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
> > > > > > > > >       | 256 pages merged a bio.
> > > > > > > > >       | at this time, first bio submit is done.
> > > > > > > > >       | and 1 read request is issued for 1 bio.
> > > > > > > > >       |--------------->
> > > > > > > > >            |--------------->
> > > > > > > > >                 |--------------->
> > > > > > > > >                                       ......
> > > > > > > > >                                                  |--------------->
> > > > > > > > >                                                   |--------------->|
> > > > > > > > >         total 17ms elapsed to complete 32MB read done from device. |
> > > > > > > > > 
> > > > > > > > > As a result, read request issue timing is faster if bio max size is limited.
> > > > > > > > > Current kernel behavior with multipage bvec, super large bio can be created.
> > > > > > > > > And it lead to delay first I/O request issue.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> > > > > > > > > ---
> > > > > > > > >  block/bio.c            | 13 ++++++++++++-
> > > > > > > > >  include/linux/bio.h    |  2 +-
> > > > > > > > >  include/linux/blkdev.h |  3 +++
> > > > > > > > >  3 files changed, 16 insertions(+), 2 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/block/bio.c b/block/bio.c
> > > > > > > > > index 1f2cc1fbe283..c528e1f944c7 100644
> > > > > > > > > --- a/block/bio.c
> > > > > > > > > +++ b/block/bio.c
> > > > > > > > > @@ -287,6 +287,17 @@ void bio_init(struct bio *bio, struct bio_vec *table,
> > > > > > > > >  }
> > > > > > > > >  EXPORT_SYMBOL(bio_init);
> > > > > > > > >  
> > > > > > > > > +unsigned int bio_max_size(struct bio *bio)
> > > > > > > > > +{
> > > > > > > > > +	struct request_queue *q = bio->bi_disk->queue;
> > > > > > > > > +
> > > > > > > > > +	if (blk_queue_limit_bio_size(q))
> > > > > > > > > +		return blk_queue_get_max_sectors(q, bio_op(bio))
> > > > > > > > > +			<< SECTOR_SHIFT;
> > > > > > > > > +
> > > > > > > > > +	return UINT_MAX;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  /**
> > > > > > > > >   * bio_reset - reinitialize a bio
> > > > > > > > >   * @bio:	bio to reset
> > > > > > > > > @@ -877,7 +888,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
> > > > > > > > >  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> > > > > > > > >  
> > > > > > > > >  		if (page_is_mergeable(bv, page, len, off, same_page)) {
> > > > > > > > > -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> > > > > > > > > +			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {
> > > > > > > > >  				*same_page = false;
> > > > > > > > >  				return false;
> > > > > > > > >  			}
> > > > > > > > > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > > > > > > > > index 1edda614f7ce..13b6f6562a5b 100644
> > > > > > > > > --- a/include/linux/bio.h
> > > > > > > > > +++ b/include/linux/bio.h
> > > > > > > > > @@ -113,7 +113,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
> > > > > > > > >  	if (bio->bi_vcnt >= bio->bi_max_vecs)
> > > > > > > > >  		return true;
> > > > > > > > >  
> > > > > > > > > -	if (bio->bi_iter.bi_size > UINT_MAX - len)
> > > > > > > > > +	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
> > > > > > > > >  		return true;
> > > > > > > > >  
> > > > > > > > >  	return false;
> > > > > > > > > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > > > > > > > > index f94ee3089e01..3aeab9e7e97b 100644
> > > > > > > > > --- a/include/linux/blkdev.h
> > > > > > > > > +++ b/include/linux/blkdev.h
> > > > > > > > > @@ -621,6 +621,7 @@ struct request_queue {
> > > > > > > > >  #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
> > > > > > > > >  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
> > > > > > > > >  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
> > > > > > > > > +#define QUEUE_FLAG_LIMIT_BIO_SIZE 30	/* limit bio size */
> > > > > > > > >  
> > > > > > > > >  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
> > > > > > > > >  				 (1 << QUEUE_FLAG_SAME_COMP) |		\
> > > > > > > > > @@ -667,6 +668,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
> > > > > > > > >  #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
> > > > > > > > >  #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
> > > > > > > > >  #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
> > > > > > > > > +#define blk_queue_limit_bio_size(q)	\
> > > > > > > > > +	test_bit(QUEUE_FLAG_LIMIT_BIO_SIZE, &(q)->queue_flags)
> > > > > > > > >  
> > > > > > > > >  extern void blk_set_pm_only(struct request_queue *q);
> > > > > > > > >  extern void blk_clear_pm_only(struct request_queue *q);
> > > > > > > > > -- 
> > > > > > > > > 2.28.0
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > Please feedback to me if more modification is needed to apply. :)
> > > > > > > 
> > > > > > > You are adding code that tests for a value to be set, yet you never set
> > > > > > > it in this code so why is it needed at all?
> > > > > > 
> > > > > > This patch is a solution for some inefficient case of multipage bvec like
> > > > > > as current DIO scenario. So it's not set as a default.
> > > > > > It will be set when bio size limitation is needed in runtime.
> > > > > 
> > > > > Set where?
> > > > 
> > > > In my environment, set it on init.rc file like as below.
> > > > "echo 1 > /sys/block/sda/queue/limit_bio_size"
> > > 
> > > I do not see any sysfs file in this patch, and why would you ever want
> > > to be forced to manually do this?  The hardware should know the limits
> > > itself, and should automatically tune things like this, do not force a
> > > user to do it as that's just not going to go well at all.
> > 
> > Patch for sysfs is sent "[RESEND,v5,2/2] bio: add limit_bio_size sysfs".
> > Actually I just suggested constant - 1MB - value to limit bio size at first.
> > But I got a feedback that patch will be better if it's optional, and
> > getting meaningful value from device queue on patchwork.
> > There are some differences for each system environment I think.
> > 
> > But there are inefficient logic obviously by applying of multipage bvec.
> > So it will be shown in several system environment.
> > Currently providing this patch as a option would be better to select
> > according to each system environment, and policy I think.
> > 
> > Please, revisit applying this patch.
> > 
> > > 
> > > So if this patch series is forcing a new option to be configured by
> > > sysfs only, that's not acceptable, sorry.
> > 
> > If it is not acceptable ever with current, may I progress review again
> > with default enabled?
> 
> I am sorry, I can not parse this, can you rephrase this?
> 
> thanks,
> 
> greg k-h
> 

I'll prepare new patch as you recommand. It will be added setting of
limit_bio_size automatically when queue max sectors is determined.


Thanks,

Changheun Lee
