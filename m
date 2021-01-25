Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D80C433DB
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 02:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94FBD22252
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 02:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbhAYCWQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Jan 2021 21:22:16 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:45480 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbhAYB5h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Jan 2021 20:57:37 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210125015639epoutp01c159b08b805bee6e9e57087379dba387~dVui5sPNa0106801068epoutp01n
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 01:56:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210125015639epoutp01c159b08b805bee6e9e57087379dba387~dVui5sPNa0106801068epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611539799;
        bh=rn2uVheFCBif+lhBXMLYPUD6I7WgD/KcJtIJV7c8e1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XfotF10AsIQ2zVmK/62CREGo5YE7P9ioKXaWXszVHPykxYTgteI3C7wleen2OID9h
         hjqPDWsVKMZAbS4DpHUcVeoZ3Lj8qWbpsPwX0n9vAotXboezR+Z9+b5r2e0G7PxcaV
         8t71Vz8FAU+EX2oTI4JNL6bzC0WP6FoJe51W0GuQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210125015638epcas1p283cc32bdb44680bd1a5ee7f52229ff7b~dVuiJrOor3043230432epcas1p2G;
        Mon, 25 Jan 2021 01:56:38 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DPCdw6nY6z4x9Pw; Mon, 25 Jan
        2021 01:56:36 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.A4.09577.4552E006; Mon, 25 Jan 2021 10:56:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210125015636epcas1p344b530317fe3379914449197ad591eff~dVugLaLaW1445114451epcas1p38;
        Mon, 25 Jan 2021 01:56:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210125015636epsmtrp17237fed9547283f2764725e83c31313d~dVugHn0Io0612306123epsmtrp1y;
        Mon, 25 Jan 2021 01:56:36 +0000 (GMT)
X-AuditID: b6c32a39-bfdff70000002569-b0-600e25541ce0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.16.13470.4552E006; Mon, 25 Jan 2021 10:56:36 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210125015635epsmtip188138917777460951e2c52a2bfe829f9~dVuf3G9lJ2076020760epsmtip1P;
        Mon, 25 Jan 2021 01:56:35 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     ming.lei@redhat.com
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mj0123.lee@samsung.com,
        nanich.lee@samsung.com, osandov@fb.com, patchwork-bot@kernel.org,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        tj@kernel.org, tom.leiming@gmail.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
Subject: Re: [PATCH v2] bio: limit bio max size
Date:   Mon, 25 Jan 2021 10:41:10 +0900
Message-Id: <20210125014110.16525-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210122034547.GC509982@T590>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGJsWRmVeSWpSXmKPExsWy7bCmvm6IKl+CwfnrRhZzVm1jtFh9t5/N
        orX9G5NFz5MmVou/XfeYLL4+LLbYe0vb4vKuOWwWhyY3M1lM3zyH2eLa/TPsFofvXWWxeLhk
        IrPFuZOfWC3mPXaw+LX8KKPF+x/X2S1O7ZjMbLF+7082B2GPic3v2D12zrrL7nH5bKnHplWd
        bB7v911l8+jbsorR4/MmOY/2A91MARxROTYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqG
        lhbmSgp5ibmptkouPgG6bpk5QN8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgoM
        DQr0ihNzi0vz0vWS83OtDA0MjEyBKhNyMvpfnWMsaDSvmPzkDHMD40q1LkZODgkBE4mXN9Yx
        dzFycQgJ7GCUOP7hB5TziVFi2ZMudgjnG6PEulUH2GFaVn1ZCFW1l1Hiz8OlbBDOZ0aJFQ+X
        MYJUsQnoSPS9vcUGYosIiEu0LlnFBFLELHCAWWLx/U5mkISwgL7EohVvwIpYBFQlPl7fBBTn
        4OAVsJaYdS8YYpu8xNPe5WDlnALaEvO+zmUBsXkFBCVOznwCZjMD1TRvnQ12kYTADQ6J/Y8b
        GSGaXSRe7L4AdbawxKvjW6BsKYmX/W3sEA3djBLNbfMZIZwJjBJLni9jgqgylvj0+TMjyEXM
        ApoS63fpQ4QVJXb+nssIsZlP4t3XHlaQEgkBXomONiGIEhWJMy33mWF2PV+7E2qih8TtWQ/A
        WoUE6iS+3elgmcCoMAvJP7OQ/DMLYfECRuZVjGKpBcW56anFhgWmyHG8iRGcwLUsdzBOf/tB
        7xAjEwfjIUYJDmYlEd7dejwJQrwpiZVVqUX58UWlOanFhxhNgYE9kVlKNDkfmEPySuINTY2M
        jY0tTMzMzUyNlcR5kwwexAsJpCeWpGanphakFsH0MXFwSjUwscVMPrViY5vgJd9Vz2b56Dzu
        nMJQmV/+U2Vx6aJzhQnxnmIvrD6aK/xuvq9QGqX1wpxz/fpY1RPPVUu/er6b2lt0O5vZVfGC
        KPvLkp63YSsT7A5d3OS7+9erw3PmSy7eYh6w8oDZKUt1/n/zJid68DIUc5bxbTdSSueM72LM
        btj54P+fKYJC12+wxX99u/Dxs/eH5X/+uaeefT1f45P1moSpbk2taxzPRqfyTI7RYr7cbVnW
        nb3bTEuyOvyT4t3TF7gluu4mtZ2tXC0q7Kvks+P628BJxets+k5OaG3Ylft3Xqrn/mhFQw0J
        3Z2/xS9etvHSm9Nw+7uVunsD44aXXvt2/dQMzFlgMOW+yQ4PJZbijERDLeai4kQAzbSTUmkE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTjdElS/BoPUPu8WcVdsYLVbf7Wez
        aG3/xmTR86SJ1eJv1z0mi68Piy323tK2uLxrDpvFocnNTBbTN89htrh2/wy7xeF7V1ksHi6Z
        yGxx7uQnVot5jx0sfi0/ymjx/sd1dotTOyYzW6zf+5PNQdhjYvM7do+ds+6ye1w+W+qxaVUn
        m8f7fVfZPPq2rGL0+LxJzqP9QDdTAEcUl01Kak5mWWqRvl0CV0b/q3OMBY3mFZOfnGFuYFyp
        1sXIySEhYCKx6stC5i5GLg4hgd2MEm9/HGGGSEhJHD/xlrWLkQPIFpY4fLgYouYjo0TLh1YW
        kBo2AR2Jvre32EBsEQFxidYlq5hAipgFrjFLNKx5AZYQFtCXWLTiDZjNIqAq8fH6JmaQobwC
        1hKz7gVD7JKXeNq7HGwvp4C2xLyvc8HmCwloSTR8a2QFsXkFBCVOznwCFmcGqm/eOpt5AqPA
        LCSpWUhSCxiZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBMeYluYOxu2rPugdYmTi
        YDzEKMHBrCTCu1uPJ0GINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUw
        WSYOTqkGJvP0uIqSpkUHF1a/urVOsadiiuq5uktGbPk5a50DT+3w2/9XPeDglpyX2y+LqK+J
        cLv77eXnn5MXOX2I0es/q9rt++ec4qarZ6qXzTVcpOtgVnCk4tm+dVYPFIP2+/UcfW5q6Xt7
        Wb2R+uFt+y/e/mB7dNqi3Iw/voa8/3f5d6q/Yd1xb5nCm3lC4f9/J6Sf3r3AnO/gvYlO6p7f
        Pyk/0OUQDngjqnTp6of9IoGbGc+lT6g4VrFKnykmettOU/Gg/ORs8b5k6+sFhudy6+6bNdzY
        vqj7607p2kWBLzepHzI2krxguaQlWfDddoe2+Kj13dLp5Zc+/3v0WMXWTuPnfacrFsbzI/pK
        +mo9te/51SixFGckGmoxFxUnAgBDYholIAMAAA==
X-CMS-MailID: 20210125015636epcas1p344b530317fe3379914449197ad591eff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210125015636epcas1p344b530317fe3379914449197ad591eff
References: <20210122034547.GC509982@T590>
        <CGME20210125015636epcas1p344b530317fe3379914449197ad591eff@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Thu, Jan 21, 2021 at 09:58:03AM +0900, Changheun Lee wrote:
> > bio size can grow up to 4GB when muli-page bvec is enabled.
> > but sometimes it would lead to inefficient behaviors.
> > in case of large chunk direct I/O, - 32MB chunk read in user space -
> > all pages for 32MB would be merged to a bio structure if memory address is
> > continued phsycally. it makes some delay to submit until merge complete.
> > bio max size should be limited as a proper size.
> > 
> > When 32MB chunk read with direct I/O option is coming from userspace,
> > kernel behavior is below now. it's timeline.
> 
> IMO, the issue should only exist on sync direct IO and writeback.
> Not sure if writeback cares this small delay because user data
> has been written to page cache already.
> 
> Wrt. your big direct IO case, as I suggested, you may reduce the
> submission delay a lot by applying THP.
> 
> Or you can just hardcode the limit in case of sync dio.

As you said, this small delay is not affect in case of writeback.
It's not common, but there are needs of direct I/O from userspace.
It will be operated optional, not default in v3 patch version.
And it'll be activated with queue flag, or sysfs node.
Please, review it again.

> 
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
> > 
> > ---
> >  block/bio.c               | 17 ++++++++++++++++-
> >  include/linux/bio.h       | 13 +++----------
> >  include/linux/blk_types.h |  1 +
> >  3 files changed, 20 insertions(+), 11 deletions(-)
> > 
> > diff --git a/block/bio.c b/block/bio.c
> > index 1f2cc1fbe283..027503c2e2e7 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -284,9 +284,24 @@ void bio_init(struct bio *bio, struct bio_vec *table,
> >  
> >  	bio->bi_io_vec = table;
> >  	bio->bi_max_vecs = max_vecs;
> > +	bio->bi_max_size = UINT_MAX;
> >  }
> >  EXPORT_SYMBOL(bio_init);
> >  
> > +void bio_set_dev(struct bio *bio, struct block_device *bdev)
> > +{
> > +	if (bio->bi_disk != bdev->bd_disk)
> > +		bio_clear_flag(bio, BIO_THROTTLED);
> > +
> > +	bio->bi_disk = bdev->bd_disk;
> > +	bio->bi_partno = bdev->bd_partno;
> > +	bio->bi_max_size = blk_queue_get_max_sectors(bio->bi_disk->queue,
> > +			bio_op(bio)) << SECTOR_SHIFT;
> > +
> > +	bio_associate_blkg(bio);
> > +}
> > +EXPORT_SYMBOL(bio_set_dev);
> > +
> >  /**
> >   * bio_reset - reinitialize a bio
> >   * @bio:	bio to reset
> > @@ -877,7 +892,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
> >  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> >  
> >  		if (page_is_mergeable(bv, page, len, off, same_page)) {
> > -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> > +			if (bio->bi_iter.bi_size > bio->bi_max_size - len)
> >  				*same_page = false;
> >  				return false;
> >  			}
> > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > index 1edda614f7ce..b9803e80c259 100644
> > --- a/include/linux/bio.h
> > +++ b/include/linux/bio.h
> > @@ -113,7 +113,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
> >  	if (bio->bi_vcnt >= bio->bi_max_vecs)
> >  		return true;
> >  
> > -	if (bio->bi_iter.bi_size > UINT_MAX - len)
> > +	if (bio->bi_iter.bi_size > bio->bi_max_size - len)
> >  		return true;
> >  
> >  	return false;
> > @@ -482,20 +482,13 @@ extern struct bio_vec *bvec_alloc(gfp_t, int, unsigned long *, mempool_t *);
> >  extern void bvec_free(mempool_t *, struct bio_vec *, unsigned int);
> >  extern unsigned int bvec_nr_vecs(unsigned short idx);
> >  extern const char *bio_devname(struct bio *bio, char *buffer);
> > -
> > -#define bio_set_dev(bio, bdev) 			\
> > -do {						\
> > -	if ((bio)->bi_disk != (bdev)->bd_disk)	\
> > -		bio_clear_flag(bio, BIO_THROTTLED);\
> > -	(bio)->bi_disk = (bdev)->bd_disk;	\
> > -	(bio)->bi_partno = (bdev)->bd_partno;	\
> > -	bio_associate_blkg(bio);		\
> > -} while (0)
> > +extern void bio_set_dev(struct bio *bio, struct block_device *bdev);
> >  
> >  #define bio_copy_dev(dst, src)			\
> >  do {						\
> >  	(dst)->bi_disk = (src)->bi_disk;	\
> >  	(dst)->bi_partno = (src)->bi_partno;	\
> > +	(dst)->bi_max_size = (src)->bi_max_size;\
> >  	bio_clone_blkg_association(dst, src);	\
> >  } while (0)
> >  
> > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> > index 866f74261b3b..e5dd5b7d8fc1 100644
> > --- a/include/linux/blk_types.h
> > +++ b/include/linux/blk_types.h
> > @@ -270,6 +270,7 @@ struct bio {
> >  	 */
> >  
> >  	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
> > +	unsigned int		bi_max_size;	/* max data size we can hold */
> 
> People don't like to extend bio which can be fit in two cachelines
> exactly, and adding one 'int' will make it cross 3 cache lines.
> 

Yes, you right. good comment.
I'll not add a new variable in bio. :)

> 
> Thanks,
> Ming
> 
> 

---
Changheun Lee
Samsung Electronics
