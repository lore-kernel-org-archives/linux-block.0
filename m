Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83140C47082
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 08:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C6A613DA
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 08:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhFCIst (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 04:48:49 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:51793 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhFCIst (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 04:48:49 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210603084702epoutp027f39f24dd5da4b8758697031e93b2a07~FBisXnya_0384003840epoutp02D
        for <linux-block@vger.kernel.org>; Thu,  3 Jun 2021 08:47:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210603084702epoutp027f39f24dd5da4b8758697031e93b2a07~FBisXnya_0384003840epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622710022;
        bh=09QmnMglhhRnkvKZwSVbk1nin4oV4zY1v9T5OJOFL0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2eRrqbygrz7AHqS1mhErwxWuYoTr3pHhUvJfpHMyuuCLJAayCsa+Rs0nMKDmnT2X
         +kw52rWRaJ2a2P/IjygSOFt1tBL6UuCg3Nxi5tyPTxu/n9JvZeFrfXH9HZyQUPyC8p
         ojj//Tt2X8euGZ2h15Je4uv9D6aqB58nXZhvDYLE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210603084701epcas1p23a557b305c8a06fe78a87369fb181dce~FBireFznI0053300533epcas1p2x;
        Thu,  3 Jun 2021 08:47:01 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.160]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Fwfdw2vDKz4x9Px; Thu,  3 Jun
        2021 08:47:00 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.72.09578.40798B06; Thu,  3 Jun 2021 17:47:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210603084659epcas1p1bc7b425e65bdc6517f69cf5a0e0628dc~FBipd_SWE2902929029epcas1p1b;
        Thu,  3 Jun 2021 08:46:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210603084659epsmtrp1925b1bed0faa1489b308c91ac59b226d~FBipcyG1B1283912839epsmtrp1f;
        Thu,  3 Jun 2021 08:46:59 +0000 (GMT)
X-AuditID: b6c32a35-fcfff7000000256a-74-60b8970466b2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.E2.08163.30798B06; Thu,  3 Jun 2021 17:46:59 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210603084659epsmtip24dbba2a6bbb97374993a4f5a6ae45ac9~FBipLrrga1193711937epsmtip2J;
        Thu,  3 Jun 2021 08:46:59 +0000 (GMT)
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
Subject: Re: [PATCH v11 1/3] bio: control bio max size
Date:   Thu,  3 Jun 2021 17:28:21 +0900
Message-Id: <20210603082821.17278-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <DM6PR04MB70819D1D9C6301E399FC1A67E73D9@DM6PR04MB7081.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te1BUZRTn27t7d5fcuoDmF2OCKxgiC7vC4iePRCC8jZaUTc40o+xtubMw
        LcvO3qUpqElZ3gsLiEiuoPjiFUHyCjCTVip55BSgzFjAKIxEBNLySCSclr1Q/Pc75/x+5/ed
        880RYM55fFdBvEZP6zSUWow7cltu7ZRIuCWtCmlvrROq+62Wj0prWgD6YigfR+2/XADozMwi
        htIzFzjIcLkeRz0FlzhorN6ModyxVB5azhnmoPkHDLpxfxfqby/FkaXIwEEljaUYujfSy0e3
        hu9y0YMrhRi602XlofOjYehp5fcAPX4yyEfdrUUYGrxzBkf1NxbxMFeyf+AgWWiY5pNt5iE+
        2VjlTfb/lEQ21GTj5M2yWj75+Nu7OGlqqgHkbMNWMrPDyCEtlgosesN76pA4moqlde60RpkY
        G69RhYoPHomJiJEHSmUS2V60R+yuoRLoUHHkoWhJVLzatgKx+4eUOsmWiqYYRuz3aoguMUlP
        u8clMvpQMa2NVWtlUq0vQyUwSRqVrzIxIUgmle6W25gKdVyjpRLX3o7+qHrid/4JYA3KAUIB
        JAJg5TUTLwc4CpyJVgC76zpxNrAC2Fh+EmODWQCtlUWcNYnxah2HLbQD+OvpPP5/rLGmz/kr
        LJzwgaap+/gK3ki8BLsn5ux9MWKQC9Mbu+wFFyIQdl0f5q5gLuEJH35XbbcQEcEwfTJ31c4N
        /jOSi61gIXEM/pw9AFiOE+w6O2bXYjaOofmc/a2QuCyEHZMlXFYcCXtNxTiLXeAfPzbxWewK
        J/Iz+KzACKAh4wJggwIAr4xXrFr7Q+vsrK0gsFnshPXtfmx6G2xbKgOs8/Nwej6Xt0KBhAhm
        ZTizFA/YmzaCrXmNf9m22pGEpeYcLruur2zrLnuKFwB387qBzOsGMv/vXA6wGvAirWUSVDQj
        08rW/3IDsN+Ft7wVFE7N+FoARwAsAAow8UbRNztaFc6iWOrjZFqXGKNLUtOMBcht6y7EXDcp
        E22HpdHHyOS7/f39UUDgnkC5v3izSBWRonAmVJSe/oCmtbRuTccRCF1PcNzEbZ+qn0s+9FnP
        lnMR8xvGudPVf1c1UyfjP9k+OqTJ+msy6q17qR4mp+Bih1dm9FRnBrL0MVvjdj3Lqljavu+4
        OrKz65Rb8028Z8Bl9qGiykiE/JD5hvW1cFV8wPn9fe1v+hm0+cb9wkbJ19l7y/vqSmlw9PAT
        c69P8Gm1Bl/ycNY5OHgZfdIXnbYcjXxkSulLT/UUBvB4CdUlooubHPOVRwJly9mPru1IK5Ar
        RiRzamu49PWzLUoyxeXiyOGF5NF4kkp7oSW4J1O54HcV9kW5HrtueOdZmgy8zAx5jtFBx5cO
        LOcNhYn+3LdN6PV+wKUDQdKMiI7wKa+3s+aK3918W8xl4iiZN6ZjqH8BPsz3I6AEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra1BMYRyHvedsZ09L5lip14rGmdGYlchQb25TMzHHbSbGZdymlo6ittae
        ctkvYpG2FYkaKzEWW1tTlM2Kpc5qsqFZU20jtS4tySWVSC6D3caMb8/M88z/9+FP4mKrQELu
        TEljlSmyZJoQCaqtdOBMvMAcN7u6MwiVd5QJUaGxGqDSzhMEqnlyAaD8vmEcHcn8iiG1voJA
        D09ewpCrQocjreuQF/qlcWLoy0sOWdpnoOaaQgLxeWoMFVQV4sjx/JEQWZ2tAvTyci6OmmwD
        XqioKxJ9N9QD9OlbmxA1mvNw1NaUT6AKyzARKWGaW1YwuepeIXNL1ylkqoqlTPPjdKbSmEUw
        986XCZlPd1sJJueGETCfK6cwmbXZGMPzV/GYMZtEC+PZ5J17WOWsxXGixCreQCgexOwr6Xkr
        zAAD8zXAm4TUXJh9pRzTABEppswA9hwz4SNCAhsefPTSAPIvj4dWKzfS9AOoHT5BuBuCCoY5
        H9s97EtNhI09g4Q7wqkhAbyX+cYjxlNh0HbbKXCzgJoGX9WVYG72oRbAI++12MhYIPz5XOsZ
        9qa2QntWC3CzmNoCjz59Kxzpx0HbWZfnDv63V5vO4ScBpftP6f5TFwFmBBNZBSdPkHOhijkp
        7N4QTibn0lMSQranyiuB589SqRncMfaF8AAjAQ8gidO+PneCzHFin3jZfhWrTI1VpiezHA8m
        kQLa38euscWKqQRZGpvEsgpW+c9ipLckA4vJUNuIzeHLI+5fPDDQn+cXsKzedivCgW8+WEWN
        MqYmmTbJJ/gSX4pIJ1oJksOu041p73SsIz2XjZrh51jNL+JXPbNnO/Nvq8L9o/UBZUnSK+un
        G3aXhnXHLk4c1GcX1y5oDe+M6rg2uVXVLlIWN5TuCoq3n9asr7y/5uwgUXrIZMGvu3LqJ3do
        t1y2152fRx00RFydVB3oUOjqQn+c6tX3dgTfDCg4LA9e1xRRYj4evn0jlxVp+UAnWvzW/o41
        vA46ox1drlo67R2R4ZLM/B7V9iTza922Imn5VBQ9tqllK012R/cqa+kdL2r8D/y4phqapzdt
        ILsalhz/nHd3iBZwibJQKa7kZH8Az+M14lYDAAA=
X-CMS-MailID: 20210603084659epcas1p1bc7b425e65bdc6517f69cf5a0e0628dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210603084659epcas1p1bc7b425e65bdc6517f69cf5a0e0628dc
References: <DM6PR04MB70819D1D9C6301E399FC1A67E73D9@DM6PR04MB7081.namprd04.prod.outlook.com>
        <CGME20210603084659epcas1p1bc7b425e65bdc6517f69cf5a0e0628dc@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On 2021/06/02 21:29, Changheun Lee wrote:
> > bio size can grow up to 4GB after muli-page bvec has been enabled.
> > But sometimes large size of bio would lead to inefficient behaviors.
> > Control of bio max size will be helpful to improve inefficiency.
> > 
> > Below is a example for inefficient behaviours.
> > In case of large chunk direct I/O, - 32MB chunk read in user space -
> > all pages for 32MB would be merged to a bio structure if the pages
> > physical addresses are contiguous. It makes some delay to submit
> > until merge complete. bio max size should be limited to a proper size.
> > 
> > When 32MB chunk read with direct I/O option is coming from userspace,
> > kernel behavior is below now in do_direct_IO() loop. It's timeline.
> > 
> >  | bio merge for 32MB. total 8,192 pages are merged.
> >  | total elapsed time is over 2ms.
> >  |------------------ ... ----------------------->|
> >                                                  | 8,192 pages merged a bio.
> >                                                  | at this time, first bio submit is done.
> >                                                  | 1 bio is split to 32 read request and issue.
> >                                                  |--------------->
> >                                                   |--------------->
> >                                                    |--------------->
> >                                                               ......
> >                                                                    |--------------->
> >                                                                     |--------------->|
> >                           total 19ms elapsed to complete 32MB read done from device. |
> > 
> > If bio max size is limited with 1MB, behavior is changed below.
> > 
> >  | bio merge for 1MB. 256 pages are merged for each bio.
> >  | total 32 bio will be made.
> >  | total elapsed time is over 2ms. it's same.
> >  | but, first bio submit timing is fast. about 100us.
> >  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
> >       | 256 pages merged a bio.
> >       | at this time, first bio submit is done.
> >       | and 1 read request is issued for 1 bio.
> >       |--------------->
> >            |--------------->
> >                 |--------------->
> >                                       ......
> >                                                  |--------------->
> >                                                   |--------------->|
> >         total 17ms elapsed to complete 32MB read done from device. |
> > 
> > As a result, read request issue timing is faster if bio max size is limited.
> > Current kernel behavior with multipage bvec, super large bio can be created.
> > And it lead to delay first I/O request issue.
> > 
> > Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> > ---
> >  block/bio.c            | 17 ++++++++++++++---
> >  block/blk-settings.c   | 19 +++++++++++++++++++
> >  include/linux/bio.h    |  4 +++-
> >  include/linux/blkdev.h |  3 +++
> >  4 files changed, 39 insertions(+), 4 deletions(-)
> > 
> > diff --git a/block/bio.c b/block/bio.c
> > index 44205dfb6b60..c52639bb80cd 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -255,6 +255,13 @@ void bio_init(struct bio *bio, struct bio_vec *table,
> >  }
> >  EXPORT_SYMBOL(bio_init);
> >  
> > +unsigned int bio_max_size(struct bio *bio)
> 
> It would be nice to call this function the same as the limit name: bio_max_bytes().

I'll do in next version.

> 
> > +{
> > +	struct block_device *bdev = bio->bi_bdev;
> > +
> > +	return bdev ? bdev->bd_disk->queue->limits.max_bio_bytes : UINT_MAX;
> 
> My personal preference goes to a plain if() instead of this.
> 
> > +}
> > +
> >  /**
> >   * bio_reset - reinitialize a bio
> >   * @bio:	bio to reset
> > @@ -866,7 +873,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
> >  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> >  
> >  		if (page_is_mergeable(bv, page, len, off, same_page)) {
> > -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> > +			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {
> >  				*same_page = false;
> >  				return false;
> >  			}
> > @@ -995,6 +1002,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> >  {
> >  	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
> >  	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
> > +	unsigned int bytes_left = bio_max_size(bio) - bio->bi_iter.bi_size;
> >  	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
> >  	struct page **pages = (struct page **)bv;
> >  	bool same_page = false;
> > @@ -1010,7 +1018,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> >  	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
> >  	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
> >  
> > -	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> > +	size = iov_iter_get_pages(iter, pages, bytes_left, nr_pages,
> > +				  &offset);
> >  	if (unlikely(size <= 0))
> >  		return size ? size : -EFAULT;
> >  
> > @@ -1038,6 +1047,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
> >  {
> >  	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
> >  	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
> > +	unsigned int bytes_left = bio_max_size(bio) - bio->bi_iter.bi_size;
> >  	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> >  	unsigned int max_append_sectors = queue_max_zone_append_sectors(q);
> >  	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
> > @@ -1058,7 +1068,8 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
> >  	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
> >  	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
> >  
> > -	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> > +	size = iov_iter_get_pages(iter, pages, bytes_left, nr_pages,
> > +				  &offset);
> >  	if (unlikely(size <= 0))
> >  		return size ? size : -EFAULT;
> >  
> > diff --git a/block/blk-settings.c b/block/blk-settings.c
> > index 902c40d67120..e270e31519a1 100644
> > --- a/block/blk-settings.c
> > +++ b/block/blk-settings.c
> > @@ -32,6 +32,7 @@ EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);
> >   */
> >  void blk_set_default_limits(struct queue_limits *lim)
> >  {
> > +	lim->max_bio_bytes = UINT_MAX;
> >  	lim->max_segments = BLK_MAX_SEGMENTS;
> >  	lim->max_discard_segments = 1;
> >  	lim->max_integrity_segments = 0;
> 
> What about the limit setup for stacked devices ? Leaving it to UINT_MAX is OK ?
> If for your use case you add dm-linear on top of the device and rerun your test,
> don't you get again slow performance ?

After applying of multipage bvec, max bio size is UINT_MAX. So set to UINT_MAX
as a default. As you comment, performance is not improved if limitation of bio
size is not in stacked device. Limit of bio size is needed in both of physical
device and statcked device to improve performance.
Currently I want to focus on physical devices only. After this, I'll prepare
patch for stacked devices.

> 
> > @@ -100,6 +101,24 @@ void blk_queue_bounce_limit(struct request_queue *q, enum blk_bounce bounce)
> >  }
> >  EXPORT_SYMBOL(blk_queue_bounce_limit);
> >  
> > +/**
> > + * blk_queue_max_bio_bytes - set bio max size for queue
> > + * @q: the request queue for the device
> > + * @bytes : bio max bytes to be set
> > + *
> > + * Description:
> > + *    Set proper bio max size to optimize queue operating.
> > + **/
> > +void blk_queue_max_bio_bytes(struct request_queue *q, unsigned int bytes)
> > +{
> > +	struct queue_limits *limits = &q->limits;
> > +	unsigned int max_bio_bytes = round_up(bytes, PAGE_SIZE);
> > +
> > +	limits->max_bio_bytes = max_t(unsigned int, max_bio_bytes,
> > +				      BIO_MAX_VECS * PAGE_SIZE);
> > +}
> > +EXPORT_SYMBOL(blk_queue_max_bio_bytes);
> 
> Why does this need to be exported ?

I think it might be good for usability in the other module, like as
the other exported functions in blk-settings.c

> 
> > +
> >  /**
> >   * blk_queue_max_hw_sectors - set max sectors for a request for this queue
> >   * @q:  the request queue for the device
> > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > index a0b4cfdf62a4..f1a99f0a240c 100644
> > --- a/include/linux/bio.h
> > +++ b/include/linux/bio.h
> > @@ -106,6 +106,8 @@ static inline void *bio_data(struct bio *bio)
> >  	return NULL;
> >  }
> >  
> > +extern unsigned int bio_max_size(struct bio *bio);
> 
> No need for extern.

If not, compile error - implicit declaration of function -  is occured
in some environment(-Werror=implicit-function-declaration).

> 
> > +
> >  /**
> >   * bio_full - check if the bio is full
> >   * @bio:	bio to check
> > @@ -119,7 +121,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
> >  	if (bio->bi_vcnt >= bio->bi_max_vecs)
> >  		return true;
> >  
> > -	if (bio->bi_iter.bi_size > UINT_MAX - len)
> > +	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
> >  		return true;
> >  
> >  	return false;
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 1255823b2bc0..861888501fc0 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -326,6 +326,8 @@ enum blk_bounce {
> >  };
> >  
> >  struct queue_limits {
> > +	unsigned int		max_bio_bytes;
> > +
> >  	enum blk_bounce		bounce;
> >  	unsigned long		seg_boundary_mask;
> >  	unsigned long		virt_boundary_mask;
> > @@ -1132,6 +1134,7 @@ extern void blk_abort_request(struct request *);
> >   * Access functions for manipulating queue properties
> >   */
> >  extern void blk_cleanup_queue(struct request_queue *);
> > +extern void blk_queue_max_bio_bytes(struct request_queue *, unsigned int);
> 
> No need for extern.
> 
> >  void blk_queue_bounce_limit(struct request_queue *q, enum blk_bounce limit);
> >  extern void blk_queue_max_hw_sectors(struct request_queue *, unsigned int);
> >  extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
> > 
