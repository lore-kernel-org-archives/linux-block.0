Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5F5C433B4
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 07:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 690F76136A
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 07:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244142AbhDGHM6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 03:12:58 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:49656 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238199AbhDGHM5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Apr 2021 03:12:57 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210407071246epoutp039fb0dd9b33ac90330b66ab6c37f31ce0~zgfG9xAu91311013110epoutp03H
        for <linux-block@vger.kernel.org>; Wed,  7 Apr 2021 07:12:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210407071246epoutp039fb0dd9b33ac90330b66ab6c37f31ce0~zgfG9xAu91311013110epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617779566;
        bh=x5liReWdTJOamEnTjpiDEmhOwqjyR6VCEOExXQKyxyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kgVu/Q4BbNSO9hS2D3Qd28GdqrbsTQrDdHFJiMcal3dOCLzibng0CE2NbxSx0hOxB
         2SMFJDxpkCing1IrkS5MVlryIUTz0Qb/26q7GeVMQOwEcS0po+7bjTEScPbUvDemys
         se7bkuCWto3uq0/X1FutClNkWZCiMcwMNqKuDmV4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210407071245epcas1p3f4a9d21997f71f084ef62895a70842f1~zgfGAmsy71881518815epcas1p3c;
        Wed,  7 Apr 2021 07:12:45 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.163]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FFbFQ0YV6z4x9Q6; Wed,  7 Apr
        2021 07:12:42 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.0D.22618.96B5D606; Wed,  7 Apr 2021 16:12:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210407071241epcas1p2559ea674299b686c9001326894c933bc~zgfCMQzH22794027940epcas1p2d;
        Wed,  7 Apr 2021 07:12:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210407071241epsmtrp24fd4848cde04928915dff65a12806848~zgfCKwNfA0660806608epsmtrp22;
        Wed,  7 Apr 2021 07:12:41 +0000 (GMT)
X-AuditID: b6c32a38-e63ff7000001585a-92-606d5b69fa15
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.A6.33967.96B5D606; Wed,  7 Apr 2021 16:12:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210407071240epsmtip192114c429d7451f11074f86c7bbd8b54~zgfB4KeVn1711617116epsmtip1h;
        Wed,  7 Apr 2021 07:12:40 +0000 (GMT)
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
Date:   Wed,  7 Apr 2021 15:55:07 +0900
Message-Id: <20210407065507.6240-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <YG1E2krVn5S+E1Da@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJsWRmVeSWpSXmKPExsWy7bCmrm5mdG6CwfSr1hZzVm1jtFh9t5/N
        orX9G5NF8+L1bBanJyxisuh50sRq8bfrHpPF14fFFntvaVtc3jWHzeLQ5GYmi+mb5zBbXLt/
        ht3i8L2rLBYPl0xktjh38hOrxbzHDha/lh9ltHj/4zq7xakdk5kt1u/9yeYg6jGx+R27x85Z
        d9k9Nq/Q8rh8ttRj06pONo/9c9ewe7zfd5XNo2/LKkaPz5vkPNoPdDMFcEXl2GSkJqakFimk
        5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAPaikUJaYUwoUCkgsLlbS
        t7Mpyi8tSVXIyC8usVVKLUjJKTA0KNArTswtLs1L10vOz7UyNDAwMgWqTMjJ+NH4mbnghGvF
        /rn3mBoY1+t3MXJySAiYSLz+d5+ti5GLQ0hgB6PE/PVPGCGcT4wS37bsZQOpEhL4xihxcYID
        TMetr+9YIIr2MkosWtAJ5XxmlPgyoYsZpIpNQEei7+0tsG4RATmJJ7f/MIMUMQu8YJaY1nEH
        rEhYwEri647XTCA2i4CqxN4H91hBbF6g+NynHawQ6+Ql/tzvAavnFNCUeLHnDgtEjaDEyZlP
        wGxmoJrmrbOZIerfcEicWy0JYbtI3Jr8hgnCFpZ4dXwLO4QtJfH53V6wpyUEuhklmtvmM0I4
        ExglljxfBtVhLPHp82egBAfQBk2J9bugIaYosfP3XEaIxXwS7772sIKUSAjwSnS0CUGUqEic
        abnPDLPr+dqdUBM9JCYs2M0ECdIaiYX3HzFNYFSYheSdWUjemYWweAEj8ypGsdSC4tz01GLD
        AhPkKN7ECE7yWhY7GOe+/aB3iJGJg/EQowQHs5II747e7AQh3pTEyqrUovz4otKc1OJDjKbA
        wJ7ILCWanA/MM3kl8YamRsbGxhYmZuZmpsZK4rxJBg/ihQTSE0tSs1NTC1KLYPqYODilGpgs
        1i+OeDhj9uzMm+furHp53s1P6v/kjHdlc8WqvDN409edXRml1Cy/Vq1YersE85Rbku35D3eX
        1CVdeC4RfXnqI0O1njTnLfv/8lmXn+8Rebj4YCGTmujK+2z9QX07zFK51ffweQnX+qfULZB8
        6VVgo/Vv9oWcXya1YcEVOyPnWdT5bvpZreJ+9sl/XrX3oUV5zw/yXo+trfN5H/rxeuTTe9F1
        u177HVI4bphw5GCN6bNvpgpnjltyB2e9+cW/xUgm7ODefSu+Rcg8SGCQfBO77afg1mnPDm7e
        sli1ujz7xYxd0VcMG5kubBRPMYwq7Du8dO26c861Bk79cnx88WueCZjn7T68uWGa4ZVjM9Yo
        sRRnJBpqMRcVJwIAzZ7GJnsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSnG5mdG6CwdFlHBZzVm1jtFh9t5/N
        orX9G5NF8+L1bBanJyxisuh50sRq8bfrHpPF14fFFntvaVtc3jWHzeLQ5GYmi+mb5zBbXLt/
        ht3i8L2rLBYPl0xktjh38hOrxbzHDha/lh9ltHj/4zq7xakdk5kt1u/9yeYg6jGx+R27x85Z
        d9k9Nq/Q8rh8ttRj06pONo/9c9ewe7zfd5XNo2/LKkaPz5vkPNoPdDMFcEVx2aSk5mSWpRbp
        2yVwZfxo/MxccMK1Yv/ce0wNjOv1uxg5OSQETCRufX3H0sXIxSEksJtRomnLdlaIhJTE8RNv
        gWwOIFtY4vDhYoiaj4wS2z++YgOpYRPQkeh7ewvMFhGQk3hy+w8zSBGzQBOLxPXzqxlBEsIC
        VhJfd7xmArFZBFQl9j64B7aAFyg+92kH1DJ5iT/3e5hBbE4BTYkXe+6wgNhCAhoSu758ZISo
        F5Q4OfMJWJwZqL5562zmCYwCs5CkZiFJLWBkWsUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpec
        n7uJERyLWpo7GLev+qB3iJGJg/EQowQHs5II747e7AQh3pTEyqrUovz4otKc1OJDjNIcLEri
        vBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamCT1Dxk66+eo9NRxS0zuLpkbmeIj7s+4+2tEVEdb
        FseuCX8dGphTFNIue93XKfv5y+Vk7t3njTwLRdLeer+bKzJn5tywHNObfi/MAjduK+Qs9Y6d
        3nrpjfSZYxHlyS+avuRduslQ3H1PasnKu4etrhypXHyQ5f8kPi+1f9se+Ezfm/3t/bMCv2y7
        Ty6B9178EJKNNjWJVr/JP2tlTPP78oMTKyLYL54O+1U3V3aHgOS8E/Fm65fMunN3S4ISm5Ph
        eTvO9M8uhU2tb9tfnNxnPHVj3O9jj/w/vreQ4CqJ8GHiT384d9GRI4LmWfWL+NYt9RBINXvW
        7/M7kWEe+/+7Nb6/TCfU1CtmMf442cbyQ4mlOCPRUIu5qDgRAICizxc0AwAA
X-CMS-MailID: 20210407071241epcas1p2559ea674299b686c9001326894c933bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210407071241epcas1p2559ea674299b686c9001326894c933bc
References: <YG1E2krVn5S+E1Da@kroah.com>
        <CGME20210407071241epcas1p2559ea674299b686c9001326894c933bc@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Wed, Apr 07, 2021 at 02:06:33PM +0900, Changheun Lee wrote:
> > > On Wed, Apr 07, 2021 at 09:16:12AM +0900, Changheun Lee wrote:
> > > > > On Tue, Apr 06, 2021 at 10:31:28AM +0900, Changheun Lee wrote:
> > > > > > > bio size can grow up to 4GB when muli-page bvec is enabled.
> > > > > > > but sometimes it would lead to inefficient behaviors.
> > > > > > > in case of large chunk direct I/O, - 32MB chunk read in user space -
> > > > > > > all pages for 32MB would be merged to a bio structure if the pages
> > > > > > > physical addresses are contiguous. it makes some delay to submit
> > > > > > > until merge complete. bio max size should be limited to a proper size.
> > > > > > > 
> > > > > > > When 32MB chunk read with direct I/O option is coming from userspace,
> > > > > > > kernel behavior is below now in do_direct_IO() loop. it's timeline.
> > > > > > > 
> > > > > > >  | bio merge for 32MB. total 8,192 pages are merged.
> > > > > > >  | total elapsed time is over 2ms.
> > > > > > >  |------------------ ... ----------------------->|
> > > > > > >                                                  | 8,192 pages merged a bio.
> > > > > > >                                                  | at this time, first bio submit is done.
> > > > > > >                                                  | 1 bio is split to 32 read request and issue.
> > > > > > >                                                  |--------------->
> > > > > > >                                                   |--------------->
> > > > > > >                                                    |--------------->
> > > > > > >                                                               ......
> > > > > > >                                                                    |--------------->
> > > > > > >                                                                     |--------------->|
> > > > > > >                           total 19ms elapsed to complete 32MB read done from device. |
> > > > > > > 
> > > > > > > If bio max size is limited with 1MB, behavior is changed below.
> > > > > > > 
> > > > > > >  | bio merge for 1MB. 256 pages are merged for each bio.
> > > > > > >  | total 32 bio will be made.
> > > > > > >  | total elapsed time is over 2ms. it's same.
> > > > > > >  | but, first bio submit timing is fast. about 100us.
> > > > > > >  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
> > > > > > >       | 256 pages merged a bio.
> > > > > > >       | at this time, first bio submit is done.
> > > > > > >       | and 1 read request is issued for 1 bio.
> > > > > > >       |--------------->
> > > > > > >            |--------------->
> > > > > > >                 |--------------->
> > > > > > >                                       ......
> > > > > > >                                                  |--------------->
> > > > > > >                                                   |--------------->|
> > > > > > >         total 17ms elapsed to complete 32MB read done from device. |
> > > > > > > 
> > > > > > > As a result, read request issue timing is faster if bio max size is limited.
> > > > > > > Current kernel behavior with multipage bvec, super large bio can be created.
> > > > > > > And it lead to delay first I/O request issue.
> > > > > > > 
> > > > > > > Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> > > > > > > ---
> > > > > > >  block/bio.c            | 13 ++++++++++++-
> > > > > > >  include/linux/bio.h    |  2 +-
> > > > > > >  include/linux/blkdev.h |  3 +++
> > > > > > >  3 files changed, 16 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/block/bio.c b/block/bio.c
> > > > > > > index 1f2cc1fbe283..c528e1f944c7 100644
> > > > > > > --- a/block/bio.c
> > > > > > > +++ b/block/bio.c
> > > > > > > @@ -287,6 +287,17 @@ void bio_init(struct bio *bio, struct bio_vec *table,
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL(bio_init);
> > > > > > >  
> > > > > > > +unsigned int bio_max_size(struct bio *bio)
> > > > > > > +{
> > > > > > > +	struct request_queue *q = bio->bi_disk->queue;
> > > > > > > +
> > > > > > > +	if (blk_queue_limit_bio_size(q))
> > > > > > > +		return blk_queue_get_max_sectors(q, bio_op(bio))
> > > > > > > +			<< SECTOR_SHIFT;
> > > > > > > +
> > > > > > > +	return UINT_MAX;
> > > > > > > +}
> > > > > > > +
> > > > > > >  /**
> > > > > > >   * bio_reset - reinitialize a bio
> > > > > > >   * @bio:	bio to reset
> > > > > > > @@ -877,7 +888,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
> > > > > > >  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> > > > > > >  
> > > > > > >  		if (page_is_mergeable(bv, page, len, off, same_page)) {
> > > > > > > -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> > > > > > > +			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {
> > > > > > >  				*same_page = false;
> > > > > > >  				return false;
> > > > > > >  			}
> > > > > > > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > > > > > > index 1edda614f7ce..13b6f6562a5b 100644
> > > > > > > --- a/include/linux/bio.h
> > > > > > > +++ b/include/linux/bio.h
> > > > > > > @@ -113,7 +113,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
> > > > > > >  	if (bio->bi_vcnt >= bio->bi_max_vecs)
> > > > > > >  		return true;
> > > > > > >  
> > > > > > > -	if (bio->bi_iter.bi_size > UINT_MAX - len)
> > > > > > > +	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
> > > > > > >  		return true;
> > > > > > >  
> > > > > > >  	return false;
> > > > > > > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > > > > > > index f94ee3089e01..3aeab9e7e97b 100644
> > > > > > > --- a/include/linux/blkdev.h
> > > > > > > +++ b/include/linux/blkdev.h
> > > > > > > @@ -621,6 +621,7 @@ struct request_queue {
> > > > > > >  #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
> > > > > > >  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
> > > > > > >  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
> > > > > > > +#define QUEUE_FLAG_LIMIT_BIO_SIZE 30	/* limit bio size */
> > > > > > >  
> > > > > > >  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
> > > > > > >  				 (1 << QUEUE_FLAG_SAME_COMP) |		\
> > > > > > > @@ -667,6 +668,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
> > > > > > >  #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
> > > > > > >  #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
> > > > > > >  #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
> > > > > > > +#define blk_queue_limit_bio_size(q)	\
> > > > > > > +	test_bit(QUEUE_FLAG_LIMIT_BIO_SIZE, &(q)->queue_flags)
> > > > > > >  
> > > > > > >  extern void blk_set_pm_only(struct request_queue *q);
> > > > > > >  extern void blk_clear_pm_only(struct request_queue *q);
> > > > > > > -- 
> > > > > > > 2.28.0
> > > > > > > 
> > > > > > 
> > > > > > Please feedback to me if more modification is needed to apply. :)
> > > > > 
> > > > > You are adding code that tests for a value to be set, yet you never set
> > > > > it in this code so why is it needed at all?
> > > > 
> > > > This patch is a solution for some inefficient case of multipage bvec like
> > > > as current DIO scenario. So it's not set as a default.
> > > > It will be set when bio size limitation is needed in runtime.
> > > 
> > > Set where?
> > 
> > In my environment, set it on init.rc file like as below.
> > "echo 1 > /sys/block/sda/queue/limit_bio_size"
> 
> I do not see any sysfs file in this patch, and why would you ever want
> to be forced to manually do this?  The hardware should know the limits
> itself, and should automatically tune things like this, do not force a
> user to do it as that's just not going to go well at all.

Patch for sysfs is sent "[RESEND,v5,2/2] bio: add limit_bio_size sysfs".
Actually I just suggested constant - 1MB - value to limit bio size at first.
But I got a feedback that patch will be better if it's optional, and
getting meaningful value from device queue on patchwork.
There are some differences for each system environment I think.

But there are inefficient logic obviously by applying of multipage bvec.
So it will be shown in several system environment.
Currently providing this patch as a option would be better to select
according to each system environment, and policy I think.

Please, revisit applying this patch.

> 
> So if this patch series is forcing a new option to be configured by
> sysfs only, that's not acceptable, sorry.

If it is not acceptable ever with current, may I progress review again
with default enabled?

> 
> greg k-h

Thanks,

Changheun Lee
