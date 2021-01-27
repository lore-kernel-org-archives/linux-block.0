Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBE4C433DB
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 07:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5502920724
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 07:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbhA0HDP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 02:03:15 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:55144 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S316676AbhA0A75 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 19:59:57 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210127005903epoutp0159eed3b7d1a41786f8e41e6361e27d85~d8O06An670260502605epoutp01V
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 00:59:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210127005903epoutp0159eed3b7d1a41786f8e41e6361e27d85~d8O06An670260502605epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611709143;
        bh=C1c2cvHMBLReQnOIkyv9l0xmKe43Mvm6VhttaZ2S5Pc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sXSLY7je1OOhWUBug/Q8Dh+Rg00X/Zhfj7JSLR9wCyX06vNYPVD1YM6b3rY40lMhp
         QdpFKkT8ybS9erLRCiBA4g7jYVUsrTUaZtkc+NwYjUwEeQkToJ20+PpxacmMaAKFLj
         cfn6GSB2bT1MchcJX99lKZcAajUbl21Tsbgis1is=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210127005902epcas1p2df0160eb1e8be7e9f30e1ed3e1f14e80~d8O0DmhbE3269432694epcas1p2A;
        Wed, 27 Jan 2021 00:59:02 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.164]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DQQGX6qBfz4x9Q5; Wed, 27 Jan
        2021 00:59:00 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.74.09582.4DAB0106; Wed, 27 Jan 2021 09:59:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210127005900epcas1p2456b0f3321b404995445b8654468c30e~d8OyNJmeA3269432694epcas1p29;
        Wed, 27 Jan 2021 00:59:00 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210127005900epsmtrp132c860266a308635260bd88f2f35426c~d8OyMB08T2674726747epsmtrp1G;
        Wed, 27 Jan 2021 00:59:00 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-7c-6010bad4daf7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.D1.08745.4DAB0106; Wed, 27 Jan 2021 09:59:00 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210127005900epsmtip23f8629b97cb2dea3f623d7a0cd3c25bd~d8Ox_pV5K1071710717epsmtip2D;
        Wed, 27 Jan 2021 00:59:00 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     ming.lei@redhat.com
Cc:     Damien.LeMoal@wdc.com, Johannes.Thumshirn@wdc.com,
        asml.silence@gmail.com, axboe@kernel.dk, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mj0123.lee@samsung.com,
        nanich.lee@samsung.com, osandov@fb.com, patchwork-bot@kernel.org,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        tj@kernel.org, tom.leiming@gmail.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
Subject: Re: [PATCH v3 1/2] bio: limit bio max size
Date:   Wed, 27 Jan 2021 09:43:31 +0900
Message-Id: <20210127004331.8386-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210126115439.GA1116639@T590>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGJsWRmVeSWpSXmKPExsWy7bCmvu6VXQIJBqvnm1jMWbWN0WL13X42
        i9b2b0wWPU+aWC3+dt1jsvj6sNhi7y1ti8u75rBZHJrczGQxffMcZotr98+wWxy+d5XF4uGS
        icwW505+YrWY99jB4tfyo4wW739cZ7c4tWMys8X6vT/ZHIQ9Jja/Y/fYOesuu8fls6Uem1Z1
        snm833eVzaNvyypGj8+b5DzaD3QzBXBE5dhkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoa
        WlqYKynkJeam2iq5+AToumXmAH2jpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkw
        NCjQK07MLS7NS9dLzs+1MjQwMDIFqkzIyejZfYGt4HRERUPPPqYGxm8OXYycHBICJhLPH9xj
        6WLk4hAS2MEo8XXtcTaQhJDAJ0aJtz8TIRKfGSUWbvnACNPxsW0FI0RiF6PE4elr2eCqVjdu
        ZgWpYhPQkeh7ewtslIiAuETrklVMIEXMAgeYJV4c+gFWJCxgLHG+u5kFxGYRUJU4e3MrmM0r
        YCXx89QmJoh18hJPe5czg9icQEOvfHzCBlEjKHFy5hOwemagmuats5lBFkgIXOGQaJn8nR2i
        2UVi5ZNzUHcLS7w6vgUqLiXxsr+NHaKhm1GiuW0+I4QzgVFiyfNlUKuNJT59/gyU4ABaoSmx
        fpc+RFhRYufvuYwQm/kk3n3tYQUpkRDglehoE4IoUZE403KfGWbX87U7oSZ6SHy/8ZYdEsD1
        EleOvGOawKgwC8k/s5D8Mwth8QJG5lWMYqkFxbnpqcWGBcbIcbyJEZzAtcx3ME57+0HvECMT
        B+MhRgkOZiUR3vfKAglCvCmJlVWpRfnxRaU5qcWHGE2BoT2RWUo0OR+YQ/JK4g1NjYyNjS1M
        zMzNTI2VxHmTDB7ECwmkJ5akZqemFqQWwfQxcXBKNTBxmx+3rhJ0rP3CqbR9W+6CGIdFvk9W
        mC/V+lKjdM/98PWb7ipd9yz+nwh8L2+fcPVcptJ0f+3DYvF5SroSGUGuryXnSs2eermptWsl
        z8f+tOB52usn2Yk/qC7pUJgef1Fm7Xz3n38ZCtdLzYpZf+myc3LlxoDrKqodTtVHD/j027Aa
        TBUwu8b2YU0Wa3qsnNMCR8YLE5l/69ywD166SLZaXX9DQGD4IZGImldJuye8iPc/7cJz3u71
        3iO2PJ/2n1lrmDAz8VD88drT7xL2pu7Ylas56fdD3RlpHMz/ey36ruqX7zla/otZZOuHOxMq
        1ggeFShX/fFCTP9YeQzjzbKlt8+U9OrMvfavIs/q13klluKMREMt5qLiRAAxb4w6aQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJXvfKLoEEg5vHRC3mrNrGaLH6bj+b
        RWv7NyaLnidNrBZ/u+4xWXx9WGyx95a2xeVdc9gsDk1uZrKYvnkOs8W1+2fYLQ7fu8pi8XDJ
        RGaLcyc/sVrMe+xg8Wv5UUaL9z+us1uc2jGZ2WL93p9sDsIeE5vfsXvsnHWX3ePy2VKPTas6
        2Tze77vK5tG3ZRWjx+dNch7tB7qZAjiiuGxSUnMyy1KL9O0SuDJ6dl9gKzgdUdHQs4+pgfGb
        QxcjJ4eEgInEx7YVjF2MXBxCAjsYJS4t2sMEkZCSOH7iLWsXIweQLSxx+HAxRM1HRomemReY
        QWrYBHQk+t7eYgOxRQTEJVqXrGICKWIWuMYs8XvFVBaQhLCAscT57mYwm0VAVeLsza1gNq+A
        lcTPU5uglslLPO1dDjaUE2jolY9PwIYKCWhLbO+YxAhRLyhxcuYTsF5moPrmrbOZJzAKzEKS
        moUktYCRaRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnCUaWntYNyz6oPeIUYmDsZD
        jBIczEoivO+VBRKEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi
        4JRqYBI8vDAh+F/greqYzRMY7x++vr86q/7JnfqI+gMxH3eu2di3eFvNxluKkfLrJNIqG3o+
        Troxd+Gdg3nlhYFW6q68L/OPyN+pZOz3MFz3I5zjD8uNJWXFFVp62swL9+8KOb9n4vraDPfj
        /YyfczPXv7T7NSFqcqbJL23lt+xqizviUtri035tNIqd81j26rTcU2Gv5vIvLH+qsFCD45Cq
        6v8z1h0bmwrOrnitfIXtZTZjpJFwfvOJpEKpF+2q1+uZ6mRVImeEn1YpUF25eamwh9s2Q94n
        J3v7Mkr5L9V2e9Uu3f96ffO/0pmRq/PPi/RvmJ9SJtT44nT8dMbSN0siuR68+1/6b8L7dcxr
        twpdEVViKc5INNRiLipOBACj72kEIQMAAA==
X-CMS-MailID: 20210127005900epcas1p2456b0f3321b404995445b8654468c30e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210127005900epcas1p2456b0f3321b404995445b8654468c30e
References: <20210126115439.GA1116639@T590>
        <CGME20210127005900epcas1p2456b0f3321b404995445b8654468c30e@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Tue, Jan 26, 2021 at 06:26:02AM +0000, Damien Le Moal wrote:
> > On 2021/01/26 15:07, Ming Lei wrote:
> > > On Tue, Jan 26, 2021 at 04:06:06AM +0000, Damien Le Moal wrote:
> > >> On 2021/01/26 12:58, Ming Lei wrote:
> > >>> On Tue, Jan 26, 2021 at 10:32:34AM +0900, Changheun Lee wrote:
> > >>>> bio size can grow up to 4GB when muli-page bvec is enabled.
> > >>>> but sometimes it would lead to inefficient behaviors.
> > >>>> in case of large chunk direct I/O, - 32MB chunk read in user space -
> > >>>> all pages for 32MB would be merged to a bio structure if the pages
> > >>>> physical addresses are contiguous. it makes some delay to submit
> > >>>> until merge complete. bio max size should be limited to a proper size.
> > >>>>
> > >>>> When 32MB chunk read with direct I/O option is coming from userspace,
> > >>>> kernel behavior is below now. it's timeline.
> > >>>>
> > >>>>  | bio merge for 32MB. total 8,192 pages are merged.
> > >>>>  | total elapsed time is over 2ms.
> > >>>>  |------------------ ... ----------------------->|
> > >>>>                                                  | 8,192 pages merged a bio.
> > >>>>                                                  | at this time, first bio submit is done.
> > >>>>                                                  | 1 bio is split to 32 read request and issue.
> > >>>>                                                  |--------------->
> > >>>>                                                   |--------------->
> > >>>>                                                    |--------------->
> > >>>>                                                               ......
> > >>>>                                                                    |--------------->
> > >>>>                                                                     |--------------->|
> > >>>>                           total 19ms elapsed to complete 32MB read done from device. |
> > >>>>
> > >>>> If bio max size is limited with 1MB, behavior is changed below.
> > >>>>
> > >>>>  | bio merge for 1MB. 256 pages are merged for each bio.
> > >>>>  | total 32 bio will be made.
> > >>>>  | total elapsed time is over 2ms. it's same.
> > >>>>  | but, first bio submit timing is fast. about 100us.
> > >>>>  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
> > >>>>       | 256 pages merged a bio.
> > >>>>       | at this time, first bio submit is done.
> > >>>>       | and 1 read request is issued for 1 bio.
> > >>>>       |--------------->
> > >>>>            |--------------->
> > >>>>                 |--------------->
> > >>>>                                       ......
> > >>>>                                                  |--------------->
> > >>>>                                                   |--------------->|
> > >>>>         total 17ms elapsed to complete 32MB read done from device. |
> > >>>>
> > >>>> As a result, read request issue timing is faster if bio max size is limited.
> > >>>> Current kernel behavior with multipage bvec, super large bio can be created.
> > >>>> And it lead to delay first I/O request issue.
> > >>>>
> > >>>> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> > >>>> ---
> > >>>>  block/bio.c            | 17 ++++++++++++++++-
> > >>>>  include/linux/bio.h    |  4 +++-
> > >>>>  include/linux/blkdev.h |  3 +++
> > >>>>  3 files changed, 22 insertions(+), 2 deletions(-)
> > >>>>
> > >>>> diff --git a/block/bio.c b/block/bio.c
> > >>>> index 1f2cc1fbe283..ec0281889045 100644
> > >>>> --- a/block/bio.c
> > >>>> +++ b/block/bio.c
> > >>>> @@ -287,6 +287,21 @@ void bio_init(struct bio *bio, struct bio_vec *table,
> > >>>>  }
> > >>>>  EXPORT_SYMBOL(bio_init);
> > >>>>  
> > >>>> +unsigned int bio_max_size(struct bio *bio)
> > >>>> +{
> > >>>> +	struct request_queue *q;
> > >>>> +
> > >>>> +	if (!bio->bi_disk)
> > >>>> +		return UINT_MAX;
> > >>>> +
> > >>>> +	q = bio->bi_disk->queue;
> > >>>> +	if (!blk_queue_limit_bio_size(q))
> > >>>> +		return UINT_MAX;
> > >>>> +
> > >>>> +	return blk_queue_get_max_sectors(q, bio_op(bio)) << SECTOR_SHIFT;
> > >>>> +}
> > >>>> +EXPORT_SYMBOL(bio_max_size);
> > >>>> +
> > >>>>  /**
> > >>>>   * bio_reset - reinitialize a bio
> > >>>>   * @bio:	bio to reset
> > >>>> @@ -877,7 +892,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
> > >>>>  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> > >>>>  
> > >>>>  		if (page_is_mergeable(bv, page, len, off, same_page)) {
> > >>>> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> > >>>> +			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {
> > >>>>  				*same_page = false;
> > >>>>  				return false;
> > >>>>  			}
> > >>>
> > >>> So far we don't need bio->bi_disk or bio->bi_bdev(will be changed in
> > >>> Christoph's patch) during adding page to bio, so there is null ptr
> > >>> refereance risk.
> > >>>
> > >>>> diff --git a/include/linux/bio.h b/include/linux/bio.h
> > >>>> index 1edda614f7ce..cdb134ca7bf5 100644
> > >>>> --- a/include/linux/bio.h
> > >>>> +++ b/include/linux/bio.h
> > >>>> @@ -100,6 +100,8 @@ static inline void *bio_data(struct bio *bio)
> > >>>>  	return NULL;
> > >>>>  }
> > >>>>  
> > >>>> +extern unsigned int bio_max_size(struct bio *);
> > >>>> +
> > >>>>  /**
> > >>>>   * bio_full - check if the bio is full
> > >>>>   * @bio:	bio to check
> > >>>> @@ -113,7 +115,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
> > >>>>  	if (bio->bi_vcnt >= bio->bi_max_vecs)
> > >>>>  		return true;
> > >>>>  
> > >>>> -	if (bio->bi_iter.bi_size > UINT_MAX - len)
> > >>>> +	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
> > >>>>  		return true;
> > >>>>  
> > >>>>  	return false;
> > >>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > >>>> index f94ee3089e01..3aeab9e7e97b 100644
> > >>>> --- a/include/linux/blkdev.h
> > >>>> +++ b/include/linux/blkdev.h
> > >>>> @@ -621,6 +621,7 @@ struct request_queue {
> > >>>>  #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
> > >>>>  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
> > >>>>  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
> > >>>> +#define QUEUE_FLAG_LIMIT_BIO_SIZE 30	/* limit bio size */
> > >>>>  
> > >>>>  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
> > >>>>  				 (1 << QUEUE_FLAG_SAME_COMP) |		\
> > >>>> @@ -667,6 +668,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
> > >>>>  #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
> > >>>>  #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
> > >>>>  #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
> > >>>> +#define blk_queue_limit_bio_size(q)	\
> > >>>> +	test_bit(QUEUE_FLAG_LIMIT_BIO_SIZE, &(q)->queue_flags)
> > >>>
> > >>> I don't think it is a good idea by adding queue flag for this purpose,
> > >>> since this case just needs to limit bio size for not delay bio submission
> > >>> too much, which is kind of logical thing, nothing to do with request queue.
> > >>>
> > >>> Just wondering why you don't take the following way:
> > >>>
> > >>>
> > >>> diff --git a/block/bio.c b/block/bio.c
> > >>> index 99040a7e6656..35852f7f47d4 100644
> > >>> --- a/block/bio.c
> > >>> +++ b/block/bio.c
> > >>> @@ -1081,7 +1081,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
> > >>>   * It's intended for direct IO, so doesn't do PSI tracking, the caller is
> > >>>   * responsible for setting BIO_WORKINGSET if necessary.
> > >>>   */
> > >>> -int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> > >>> +int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter, bool sync)
> > >>>  {
> > >>>  	int ret = 0;
> > >>>  
> > >>> @@ -1092,12 +1092,20 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> > >>>  		bio_set_flag(bio, BIO_NO_PAGE_REF);
> > >>>  		return 0;
> > >>>  	} else {
> > >>> +		/*
> > >>> +		 * Don't add too many pages in case of sync dio for
> > >>> +		 * avoiding delay bio submission too much especially
> > >>> +		 * pinning user pages in memory isn't cheap.
> > >>> +		 */
> > >>> +		const unsigned int max_size = sync ? (1U << 12) : UINT_MAX;
> > >>
> > >> 4KB max bio size ? That is a little small :)
> > > 
> > > It should have been (1U << 20), :-(
> > 
> > Sounds better !
> > 
> > > 
> > >> In any case, I am not a fan of using an arbitrary value not related to the
> > >> actual device characteristics. Wouldn't it be better to us the device
> > >> max_sectors limit ? And that limit would need to be zone_append_max_sectors for
> > >> zone append writes. So some helper like Changheun bio_max_size() may be useful.
> > > 
> > > Firstly, bio->bi_disk may not be initialized when adding page to bio; secondly this
> > > limit isn't really related with device, is it? Also if it is one queue limit, it has
> > > to be stacked.
> > 
> > 1MB can be used as a fallback default if the gendisk is not yet set. If it is,
> 
> IMO, only sync dio on slow machine needs such limit because pinning userspace
> pages to memory may take a bit long, so far not see other workloads needs this limit.
> 
> Even today I get queries from client about why 4MB user space IO won't be converted to
> 4MB bio, some workload needs big size IO.
> 

IMO, your solution is good. But I think it's a scenario specific solution.
Current approach could be better to remove bio submission delay basically.
And this is a option to enable in runtime by queue flag, default is no
limit of bio size. I think this solution affacts little on your work.

> > using a queue limit that does not cause bio splitting after submit makes most
> > sense as that avoid useless overhead. I agree, it is not critical, but it would
> > be nice to have some number that causes less splitting than the arbitrary 1MB.
> 
> That is another story. Each fs bio needs two allocation(one fixed length
> bio allocation, and variable length of bvec table), however bio splitting just
> needs single fixed length bio allocation. So if the source bio(fs bio) for holding
> data becomes smaller, splitting may become less, but more fs bio and bvec table
> allocation may be involved, not sure this way always gets better performance.
> 
> Also in theory, bio splitting may not need to allocate one whole bio
> allocation, what matters is just the actual position/size info of the
> to-be-splitted bio.
> 
> > E,g, most HDDs will likely have that 1MB BIO split... And max_sectors is a
> > stacked queue limit, no ? We could use max_hw_sectors too I think.
> 
> bio_add_page() is really fast path, and checking queue limit here may
> hurt performance because queue_limits reference is added to the fast path.
> 

Your concern point is good I don't like it too. But it'll be better than
adding new variable in bio structure I think.
Actually adding new check condition is not good itself, But queue flag
checking load is smaller than many condition checks in page_is_mergeable(). :)

> 
> 
> Thanks,
> Ming

---
Changheun Lee
Samsung Electronics
