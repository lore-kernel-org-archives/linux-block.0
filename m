Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E87C433DB
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 07:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C34A2070E
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 07:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhA0H1c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 02:27:32 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:58120 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S316460AbhA0AiL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 19:38:11 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210127003649epoutp045d723436e52f2a1eefbc35cbe71fe19f~d77bFWS1U1680016800epoutp04e
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 00:36:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210127003649epoutp045d723436e52f2a1eefbc35cbe71fe19f~d77bFWS1U1680016800epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611707809;
        bh=+ih+dTOWurbRje3xLxMp11Lefmk0syXCa3jQHTVuB20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RjzqFQPTJqn8OEy2Bud1Uq4/3crVZFzSlMK3pmJWB7QlsEZYW2WK7P7l04+kQHpG1
         XMM5VJXBSxBte4jbZBQbDzbuWkzgbPr3lXDRIC52hgTzK76Rbb9aRnAn0MrEbBHS6r
         SfXDX4enr1eVjGSUCP1czh8NB4pbxiyQHSqFoefw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210127003646epcas1p15eaac4dcb4a8cefd57fe84654115c20b~d77XtuE140796507965epcas1p1m;
        Wed, 27 Jan 2021 00:36:46 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DQPmr6rnCz4x9Q7; Wed, 27 Jan
        2021 00:36:44 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.18.63458.C95B0106; Wed, 27 Jan 2021 09:36:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210127003642epcas1p4f167d553fc79ef5029a928550adbebea~d77UPMWxB0254202542epcas1p4t;
        Wed, 27 Jan 2021 00:36:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210127003642epsmtrp15c19e63cb752830e9df492e5e46a1497~d77UOO1k61711217112epsmtrp1Y;
        Wed, 27 Jan 2021 00:36:42 +0000 (GMT)
X-AuditID: b6c32a36-6dfff7000000f7e2-bb-6010b59cdc51
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.3C.13470.A95B0106; Wed, 27 Jan 2021 09:36:42 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210127003642epsmtip28f4165671c48059e1304c1c8d4dcfc9c~d77T8DDcz0054300543epsmtip2H;
        Wed, 27 Jan 2021 00:36:42 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     damien.lemoal@wdc.com
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mj0123.lee@samsung.com,
        nanich.lee@samsung.com, osandov@fb.com, patchwork-bot@kernel.org,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        tj@kernel.org, tom.leiming@gmail.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
Subject: Re: [PATCH v3 1/2] bio: limit bio max size
Date:   Wed, 27 Jan 2021 09:21:13 +0900
Message-Id: <20210127002113.8280-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <BL0PR04MB65147D829369D0E6B45507E0E7BC9@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxj29La3F0aXa8Fx5Ad0VzejDugHrQcjC8mcu5ka2ZZsiRkrd/SG
        ov2yly5icIBFVJDvfVm74RyC68IgBU2Rj5jCZiB+JDoQyRAZaCdGYNQK0+HW9kLGv+d9n+c9
        T573nENg0iE8jsg15bFWE2Og8Ejhxd6NiYnOC2SWvKNDiZyuiwD9NFqFo6PHngrQyckjIrRY
        dleAAuMc6h7ZjG5dcuLIW2cXoK/bnBgaGrsqRr13B4VovKEGQ9f750Tou4l09KzpF4BmFm6L
        0YCnDkMt3X/j6dF0jX1aTHc4RsX0rWs22u06gdMzPYM4XdnuArTfHU8fu1wuyCD2GrbpWUbH
        WmWsKdusyzXlpFE7P9C+pVVr5IpERSraQslMjJFNo7bvykjckWsIpqFknzEGW7CVwXAclfzm
        NqvZlsfK9GYuL41iLTqDRSG3JHGMkbOZcpKyzcatCrlcqQ4qswx6368uzOJSHmwuuoYXgSdU
        GYggIJkCWzv9ojIQSUhJD4Atj9xivpgDcLbHscQ8DTJdD/Dlkabn3y8R3QD+HijCQoSU9APo
        bCsIYZx8A1Y+HgkPxJBr4cDDJ3hoACN7MDjX/kAUIqJJFbxRbheGsJB8DTa2DYexhNwKvdcX
        Ae+WAO9XNIUNIshMeLx4AOc1q2H/qcmwHgtq7BdOY7x+mIDtf2zg8XZ4+YsKEY+j4dSVdjGP
        4+DDqtJwTkiWA2gvrQd8UQ1gg69RwKtUcM7vDxJE0GEjbLmUzLdfhR3PvwW88ctwOnBSFJJA
        UgKPl0p5yXp4tWQMW/byNXcsnUjDkn9mAb+5VgB7/yzHqoHMsSKPY0Uex//OZwDmAq+wFs6Y
        w3IKi3LlHbtB+IFv0nhA7ePZJC8QEMALIIFRMZKZdWSWVKJj8g+xVrPWajOwnBeog9uuweLW
        ZJuDP8SUp1WolSqVCqVotmjUKipWwsjvaaVkDpPH7mdZC2tdnhMQEXFFghTLwbfPfUPUdzb4
        6X359ma1J0FxwN+t7TK2nc0e3l2YWrP4sfMdJZcpPxsV0928yqWc/3fzb4GyE9WpGxIiHlX1
        n2trfjEdubrkoyFb1F92Kr02HmeaYj9Jmj9K0ffkp9cnl1RpEpoyouLTKm723oFr4j/9sS5r
        cFTdeb+vcaJVkCnpWUifXjv/UqWsb+GHPaSnZwpwt1slk0nv/jye+dV76xoIx9yN4eK0L/FV
        R2yuw/nDvlhdcSBhZ1//gkN0vj5jYq9GPzNSIHhRG9i3p7DVqzvwodBK3vSOFUzs95VLxe4z
        7vMzbue8J7Kwq+LzBr3zyqnX7xgPvb8D8x2ufDZFCTk9o9iEWTnmP27cfhhpBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXnfWVoEEg6Z/khZzVm1jtFh9t5/N
        orX9G5NFz5MmVou/XfeYLL4+LLbYe0vb4vKuOWwWhyY3M1lM3zyH2eLa/TPsFofvXWWxeLhk
        IrPFuZOfWC3mPXaw+LX8KKPF+x/X2S1O7ZjMbLF+7082B2GPic3v2D12zrrL7nH5bKnHplWd
        bB7v911l8+jbsorR4/MmOY/2A91MARxRXDYpqTmZZalF+nYJXBnPj61iLlhlVLG24SxbA+MX
        pS5GTg4JAROJ5b8XsnYxcnEICexmlLg37TQLREJK4viJt0AJDiBbWOLw4WKQsJDAR0aJab2u
        IDabgI5E39tbbCC2iICkxKmXX9hA5jALXGGW2PxxJiNIQljAWOJ8dzPYTBYBVYllm2+A2bwC
        VhKHzv1lhNglL/G0dzkziM0pECvR0XiKDWSvkECMxOPjtRDlghInZz4Ba2UGKm/eOpt5AqPA
        LCSpWUhSCxiZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEeYluYOxu2rPugdYmTi
        YDzEKMHBrCTC+15ZIEGINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUw
        WSYOTqkGJlZX5kULT3ZyJ/qtXia4ievdxl0vX7gsCY58VHLKaT9fb+/Bm7XTzt1WnLqV9+YG
        ocILcdtdS/1fF2aIxRzKePdh2RWLR6KLGrh3Bu/a+PvSyl3HnxfMU+/Y43ygq/j0zIkbbt/a
        9vfLGxHjVV9kJyo4fgy49S9hmuktvmuvEtcKHUubonjwQ6m64kc9Mw5djgf5opW7p00IZg92
        vzxDf8+52Mi+BW7Tbbsv2dommwvvv77Sa+IldiFXx+qTHxtF9PIUsvwnHjB8GK+q8Opxk03v
        /OQZsQIr5BjmHXoxczvTQqalMvqvnSJ22H7rjzP4ed0i4uHrqATJhibVxGXHty1wY8zumcGY
        xsxS3MpseFOJpTgj0VCLuag4EQD+STM4HwMAAA==
X-CMS-MailID: 20210127003642epcas1p4f167d553fc79ef5029a928550adbebea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210127003642epcas1p4f167d553fc79ef5029a928550adbebea
References: <BL0PR04MB65147D829369D0E6B45507E0E7BC9@BL0PR04MB6514.namprd04.prod.outlook.com>
        <CGME20210127003642epcas1p4f167d553fc79ef5029a928550adbebea@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On 2021/01/26 18:37, Changheun Lee wrote:
> > bio size can grow up to 4GB when muli-page bvec is enabled.
> > but sometimes it would lead to inefficient behaviors.
> > in case of large chunk direct I/O, - 32MB chunk read in user space -
> > all pages for 32MB would be merged to a bio structure if the pages
> > physical addresses are contiguous. it makes some delay to submit
> > until merge complete. bio max size should be limited to a proper size.
> > 
> > When 32MB chunk read with direct I/O option is coming from userspace,
> > kernel behavior is below now. it's timeline.
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
> >  block/bio.c            | 17 ++++++++++++++++-
> >  include/linux/bio.h    |  4 +++-
> >  include/linux/blkdev.h |  3 +++
> >  3 files changed, 22 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/bio.c b/block/bio.c
> > index 1f2cc1fbe283..ec0281889045 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -287,6 +287,21 @@ void bio_init(struct bio *bio, struct bio_vec *table,
> >  }
> >  EXPORT_SYMBOL(bio_init);
> >  
> > +unsigned int bio_max_size(struct bio *bio)
> > +{
> > +	struct request_queue *q;
> > +
> > +	if (!bio->bi_disk)
> > +		return UINT_MAX;
> > +
> > +	q = bio->bi_disk->queue;
> > +	if (!blk_queue_limit_bio_size(q))
> > +		return UINT_MAX;
> > +
> > +	return blk_queue_get_max_sectors(q, bio_op(bio)) << SECTOR_SHIFT;
> > +}
> > +EXPORT_SYMBOL(bio_max_size);
> 
> Why export this ? This is only used in this file and in bio.h in bio_full().

OK. I'll remove it.

> 
> > +
> >  /**
> >   * bio_reset - reinitialize a bio
> >   * @bio:	bio to reset
> > @@ -877,7 +892,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
> >  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> >  
> >  		if (page_is_mergeable(bv, page, len, off, same_page)) {
> > -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> > +			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {
> >  				*same_page = false;
> >  				return false;
> >  			}
> > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > index 1edda614f7ce..cdb134ca7bf5 100644
> > --- a/include/linux/bio.h
> > +++ b/include/linux/bio.h
> > @@ -100,6 +100,8 @@ static inline void *bio_data(struct bio *bio)
> >  	return NULL;
> >  }
> >  
> > +extern unsigned int bio_max_size(struct bio *);
> 
> No need for extern.

It's just for compile warning in my test environment.
I'll remove it too. But I think compile warning could be in the other
.c file which includes bio.h. Is it OK?

> 
> > +
> >  /**
> >   * bio_full - check if the bio is full
> >   * @bio:	bio to check
> > @@ -113,7 +115,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
> >  	if (bio->bi_vcnt >= bio->bi_max_vecs)
> >  		return true;
> >  
> > -	if (bio->bi_iter.bi_size > UINT_MAX - len)
> > +	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
> >  		return true;
> >  
> >  	return false;
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index f94ee3089e01..3aeab9e7e97b 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -621,6 +621,7 @@ struct request_queue {
> >  #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
> >  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
> >  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
> > +#define QUEUE_FLAG_LIMIT_BIO_SIZE 30	/* limit bio size */
> >  
> >  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
> >  				 (1 << QUEUE_FLAG_SAME_COMP) |		\
> > @@ -667,6 +668,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
> >  #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
> >  #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
> >  #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
> > +#define blk_queue_limit_bio_size(q)	\
> > +	test_bit(QUEUE_FLAG_LIMIT_BIO_SIZE, &(q)->queue_flags)
> >  
> >  extern void blk_set_pm_only(struct request_queue *q);
> >  extern void blk_clear_pm_only(struct request_queue *q);
> > 
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research

-- 
Changheun Lee
Samsung Electronics
