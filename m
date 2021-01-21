Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23609C433E0
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 11:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE1652222B
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 11:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbhAULkc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 06:40:32 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:43596 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730685AbhAULk0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 06:40:26 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210121113931epoutp04662c0fc61897def28889a57c2b6d0dbb~cPGUnxarZ2088920889epoutp04H
        for <linux-block@vger.kernel.org>; Thu, 21 Jan 2021 11:39:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210121113931epoutp04662c0fc61897def28889a57c2b6d0dbb~cPGUnxarZ2088920889epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611229171;
        bh=xjsaCtkvJnwpBORibxMFzr9mrFt7A7Jl3lQs0qUkz74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SA4rHnOz2AHsTDQgPcgiZpJjKQrqi3g8Y/rPWYCreArQuiIeRQEErqMIVwqa5QU7E
         Dc2GHq6AjeiMFuby7wtnglaEIZw1ATNS9AwnsS8m2TWCHuyR2k8EQ3E09XaeI9kF2P
         4ymWUSDwk2W1ga1NYoNGRY9l5XoiRpHOJblfD3Zo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210121113930epcas1p2af7ddc9578527173515dffd80ee96631~cPGTky9770600906009epcas1p2B;
        Thu, 21 Jan 2021 11:39:30 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.160]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DM0mK3KPYz4x9Q2; Thu, 21 Jan
        2021 11:39:29 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.05.63458.1F769006; Thu, 21 Jan 2021 20:39:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210121113928epcas1p13c9dd6d1322979a977f24ded689b38de~cPGRdeGRz0675106751epcas1p1Z;
        Thu, 21 Jan 2021 11:39:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210121113928epsmtrp2aa0d3e15b4c3e5b5d6565417b864e05f~cPGRcWYAf1777017770epsmtrp2J;
        Thu, 21 Jan 2021 11:39:28 +0000 (GMT)
X-AuditID: b6c32a36-6c9ff7000000f7e2-f2-600967f1241a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.A4.08745.0F769006; Thu, 21 Jan 2021 20:39:28 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210121113928epsmtip2a63968e34a88abec2ca6764a4d7ae590~cPGRMLNSh2137021370epsmtip2n;
        Thu, 21 Jan 2021 11:39:28 +0000 (GMT)
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
Subject: Re: [PATCH v2] bio: limit bio max size 
Date:   Thu, 21 Jan 2021 20:24:08 +0900
Message-Id: <20210121112408.31039-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <7e3d12129d488a45e6117e311e38d41d276b1549.camel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGJsWRmVeSWpSXmKPExsWy7bCmru7HdM4Eg44JghZzVm1jtFh9t5/N
        orX9G5NFz5MmVou/XfeYLL4+LLbYe0vb4vKuOWwWhyY3M1lM3zyH2eLa/TPsFofvXWWxeLhk
        IrPFuZOfWC3mPXaw+LX8KKPF+x/X2S1O7ZjMbLF+7082B2GPic3v2D12zrrL7nH5bKnHplWd
        bB7v911l8+jbsorR4/MmOY/2A91MARxROTYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqG
        lhbmSgp5ibmptkouPgG6bpk5QN8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgoM
        DQr0ihNzi0vz0vWS83OtDA0MjEyBKhNyMi5+O81acDWxoqX7IEsD4w+XLkZODgkBE4mP/16z
        dzFycQgJ7GCUeLxwLTOE84lRYsKc04wgVUICnxkl5i5U7mLkAOuY+lISomYXo8T+cx2MEA5Q
        zc+HM9lAGtgEdCT63t4Cs0UEJCVOvfzCBlLELLCPWeLTlmesIAlhAQOJhk9PwIpYBFQllt5/
        CLaNV8BaYs7MSYwQ98lLPO1dzgxicwq4Sny71AVVIyhxcuYTFhCbGaimeetssLMlBK5wSJz9
        Mhmq2UXi0PNbrBC2sMSr41vYIWwpic/v9rJBNHQzSjS3zWeEcCYwSix5vowJospY4tPnz4wg
        TzMLaEqs36UPEVaU2Pl7LiPEZj6Jd197WCHhwivR0SYEUaIicablPjPMrudrd0JN9JBYOr8D
        Gr4zGCXOHn/OOIFRYRaSh2YheWgWwuYFjMyrGMVSC4pz01OLDQuMkON4EyM4gWuZ7WCc9PaD
        3iFGJg7GQ4wSHMxKIryPLDkShHhTEiurUovy44tKc1KLDzGaAoN7IrOUaHI+MIfklcQbmhoZ
        GxtbmJiZm5kaK4nzJho8iBcSSE8sSc1OTS1ILYLpY+LglGpgYthmqaWfwJI48X9wGsv1a3N/
        VscIs6QUVLTs/Je5IHzFwo2y/wICO/s8ZX+n8+3JrxH7Hv4p4uLy58HdmlK54cWxTCUxj9JT
        Ag43TprHZ+rvqnigIjry+Hb1nep71tawVW+4v7fvxr2G/KqmxFPr97gnmVznWmv8RcbRJ0Ui
        SIVlyvnZTkaLFR6mGtgb7dYw/uMsdJDh3lOhbGnrsPC5ro3XTeQ49pv9Ov5Vj/PM38l7bS1f
        PboX/v/pM3+ZB7xVIYFXig/p6xptmmmy8rGg3d5zN76fcbxdZLJS2qO2SiVpEk9qSblGr8Gj
        n+EuLNOLnHSullblqdcvM7E74rR0Us3Kd1ZvPv9tLK2NdVJiKc5INNRiLipOBABDsE+uaQQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXvdDOmeCwc3lwhZzVm1jtFh9t5/N
        orX9G5NFz5MmVou/XfeYLL4+LLbYe0vb4vKuOWwWhyY3M1lM3zyH2eLa/TPsFofvXWWxeLhk
        IrPFuZOfWC3mPXaw+LX8KKPF+x/X2S1O7ZjMbLF+7082B2GPic3v2D12zrrL7nH5bKnHplWd
        bB7v911l8+jbsorR4/MmOY/2A91MARxRXDYpqTmZZalF+nYJXBkXv51mLbiaWNHSfZClgfGH
        SxcjB4eEgInE1JeSXYxcHEICOxgllm7tZO9i5ASKS0kcP/GWFaJGWOLw4WKImo+MEo0dz5lA
        atgEdCT63t5iA7FFBCQlTr38wgZSxCxwhVli88eZjCAJYQEDiYZPT8CKWARUJZbefwgW5xWw
        lpgzcxIjxDJ5iae9y5lBbE4BV4lvl7oYQRYLCbhInJiWBlEuKHFy5hMWEJsZqLx562zmCYwC
        s5CkZiFJLWBkWsUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERxhWlo7GPes+qB3iJGJ
        g/EQowQHs5II7yNLjgQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbB
        ZJk4OKUamAqTPLRYHm0PXM29ylJVWsrAXk+iriXB9KRPo2G46wdnzXI7KXbDIwtqXm5/ciZF
        LLti74Urv/T+as2xtxTfaJqboma1qThwue3sgk3OJr//Xa9NO8eruHL6+cVzhK/2+2VXHnyp
        dTE4sFL2M4+qSPSCIwXsHiEfl/Xfu3Yud+a22RYvVk551ZGpqTNF7OqHXTV/A33V+V8UPw7f
        sjn+hjBTsvkrdt4036TWOxIT5yvOKo/41v/g1Bu5WX8mi0b+Lch98IW11EY2YdfNVXXuc3+d
        4Pm6ZuW2aRWcm+qLby5Pbl39o8rl4n8dj/0uW+t3XFhi4+9S2fpl2s7TezO1W/h0q+UOzEyM
        f5xqzCvvr8RSnJFoqMVcVJwIAABwuu4fAwAA
X-CMS-MailID: 20210121113928epcas1p13c9dd6d1322979a977f24ded689b38de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210121113928epcas1p13c9dd6d1322979a977f24ded689b38de
References: <7e3d12129d488a45e6117e311e38d41d276b1549.camel@wdc.com>
        <CGME20210121113928epcas1p13c9dd6d1322979a977f24ded689b38de@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Thu, 2021-01-21 at 18:36 +0900, Changheun Lee wrote:
> > > Please drop the "." at the end of the patch title.
> > > 
> > > > bio size can grow up to 4GB when muli-page bvec is enabled.
> > > > but sometimes it would lead to inefficient behaviors.
> > > > in case of large chunk direct I/O, - 32MB chunk read in user space -
> > > > all pages for 32MB would be merged to a bio structure if memory address
> > > > is
> > > > continued phsycally. it makes some delay to submit until merge complete.
> > > 
> > > s/if memory address is continued phsycally/if the pages physical addresses
> > > are
> > > contiguous/
> > > 
> > > > bio max size should be limited as a proper size.
> > > 
> > > s/as/to/
> > 
> > Thank you for advice. :)
> > 
> > > 
> > > > 
> > > > When 32MB chunk read with direct I/O option is coming from userspace,
> > > > kernel behavior is below now. it's timeline.
> > > > 
> > > >  | bio merge for 32MB. total 8,192 pages are merged.
> > > >  | total elapsed time is over 2ms.
> > > >  |------------------ ... ----------------------->|
> > > >                                                  | 8,192 pages merged a
> > > > bio.
> > > >                                                  | at this time, first
> > > > bio submit is done.
> > > >                                                  | 1 bio is split to 32
> > > > read request and issue.
> > > >                                                  |--------------->
> > > >                                                   |--------------->
> > > >                                                    |--------------->
> > > >                                                               ......
> > > >                                                                    |-----
> > > > ---------->
> > > >                                                                     |----
> > > > ----------->|
> > > >                           total 19ms elapsed to complete 32MB read done
> > > > from device. |
> > > > 
> > > > If bio max size is limited with 1MB, behavior is changed below.
> > > > 
> > > >  | bio merge for 1MB. 256 pages are merged for each bio.
> > > >  | total 32 bio will be made.
> > > >  | total elapsed time is over 2ms. it's same.
> > > >  | but, first bio submit timing is fast. about 100us.
> > > >  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
> > > >       | 256 pages merged a bio.
> > > >       | at this time, first bio submit is done.
> > > >       | and 1 read request is issued for 1 bio.
> > > >       |--------------->
> > > >            |--------------->
> > > >                 |--------------->
> > > >                                       ......
> > > >                                                  |--------------->
> > > >                                                   |--------------->|
> > > >         total 17ms elapsed to complete 32MB read done from device. |
> > > > 
> > > > As a result, read request issue timing is faster if bio max size is
> > > > limited.
> > > > Current kernel behavior with multipage bvec, super large bio can be
> > > > created.
> > > > And it lead to delay first I/O request issue.
> > > > 
> > > > Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> > > > 
> > > > ---
> > > >  block/bio.c               | 17 ++++++++++++++++-
> > > >  include/linux/bio.h       | 13 +++----------
> > > >  include/linux/blk_types.h |  1 +
> > > >  3 files changed, 20 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/block/bio.c b/block/bio.c
> > > > index 1f2cc1fbe283..027503c2e2e7 100644
> > > > --- a/block/bio.c
> > > > +++ b/block/bio.c
> > > > @@ -284,9 +284,24 @@ void bio_init(struct bio *bio, struct bio_vec
> > > > *table,
> > > >  
> > > >  	bio->bi_io_vec = table;
> > > >  	bio->bi_max_vecs = max_vecs;
> > > > +	bio->bi_max_size = UINT_MAX;
> > > >  }
> > > >  EXPORT_SYMBOL(bio_init);
> > > >  
> > > > +void bio_set_dev(struct bio *bio, struct block_device *bdev)
> > > > +{
> > > > +	if (bio->bi_disk != bdev->bd_disk)
> > > > +		bio_clear_flag(bio, BIO_THROTTLED);
> > > > +
> > > > +	bio->bi_disk = bdev->bd_disk;
> > > > +	bio->bi_partno = bdev->bd_partno;
> > > > +	bio->bi_max_size = blk_queue_get_max_sectors(bio->bi_disk-
> > > > >queue,
> > > > +			bio_op(bio)) << SECTOR_SHIFT;
> > > > +
> > > > +	bio_associate_blkg(bio);
> > > > +}
> > > > +EXPORT_SYMBOL(bio_set_dev);
> > > > +
> > > >  /**
> > > >   * bio_reset - reinitialize a bio
> > > >   * @bio:	bio to reset
> > > > @@ -877,7 +892,7 @@ bool __bio_try_merge_page(struct bio *bio, struct
> > > > page *page,
> > > >  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> > > >  
> > > >  		if (page_is_mergeable(bv, page, len, off, same_page)) {
> > > > -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> > > > +			if (bio->bi_iter.bi_size > bio->bi_max_size -
> > > > len)
> > > >  				*same_page = false;
> > > >  				return false;
> > > >  			}
> > > > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > > > index 1edda614f7ce..b9803e80c259 100644
> > > > --- a/include/linux/bio.h
> > > > +++ b/include/linux/bio.h
> > > > @@ -113,7 +113,7 @@ static inline bool bio_full(struct bio *bio, unsigned
> > > > len)
> > > >  	if (bio->bi_vcnt >= bio->bi_max_vecs)
> > > >  		return true;
> > > >  
> > > > -	if (bio->bi_iter.bi_size > UINT_MAX - len)
> > > > +	if (bio->bi_iter.bi_size > bio->bi_max_size - len)
> > > >  		return true;
> > > >  
> > > >  	return false;
> > > > @@ -482,20 +482,13 @@ extern struct bio_vec *bvec_alloc(gfp_t, int,
> > > > unsigned long *, mempool_t *);
> > > >  extern void bvec_free(mempool_t *, struct bio_vec *, unsigned int);
> > > >  extern unsigned int bvec_nr_vecs(unsigned short idx);
> > > >  extern const char *bio_devname(struct bio *bio, char *buffer);
> > > > -
> > > > -#define bio_set_dev(bio, bdev) 			\
> > > > -do {						\
> > > > -	if ((bio)->bi_disk != (bdev)->bd_disk)	\
> > > > -		bio_clear_flag(bio, BIO_THROTTLED);\
> > > > -	(bio)->bi_disk = (bdev)->bd_disk;	\
> > > > -	(bio)->bi_partno = (bdev)->bd_partno;	\
> > > > -	bio_associate_blkg(bio);		\
> > > > -} while (0)
> > > > +extern void bio_set_dev(struct bio *bio, struct block_device *bdev);
> > > >  
> > > >  #define bio_copy_dev(dst, src)			\
> > > >  do {						\
> > > >  	(dst)->bi_disk = (src)->bi_disk;	\
> > > >  	(dst)->bi_partno = (src)->bi_partno;	\
> > > > +	(dst)->bi_max_size = (src)->bi_max_size;\
> > > >  	bio_clone_blkg_association(dst, src);	\
> > > >  } while (0)
> > > >  
> > > > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> > > > index 866f74261b3b..e5dd5b7d8fc1 100644
> > > > --- a/include/linux/blk_types.h
> > > > +++ b/include/linux/blk_types.h
> > > > @@ -270,6 +270,7 @@ struct bio {
> > > >  	 */
> > > >  
> > > >  	unsigned short		bi_max_vecs;	/* max bvl_vecs we can
> > > > hold */
> > > > +	unsigned int		bi_max_size;	/* max data size we can
> > > > hold */
> > > >  
> > > >  	atomic_t		__bi_cnt;	/* pin count */
> > > 
> > > This modification comes at the cost of increasing the bio structure size to
> > > simply tell the block layer "do not delay BIO splitting"...
> > > 
> > > I think there is a much simpler approach. What about:
> > > 
> > > 1) Use a request queue flag to indicate "limit BIO size"
> > > 2) modify __bio_try_merge_page() to look at that flag to disallow page
> > > merging
> > > if the bio size exceeds blk_queue_get_max_sectors(), or more ideally a
> > > version
> > > of it that takes into account the bio start sector.
> > > 3) Set the "limit bio size" queue flag in the driver of the device that
> > > benefit
> > > from this change. Eventually, that could also be controlled through sysfs.
> > > 
> > > With such change, you will get the same result without having to increase
> > > the
> > > BIO structure size.
> > 
> > I have a qustion.
> > Is adding new variable in bio not possible?
> 
> It is possible, but since it is a critical kernel resource used a lot, keeping
> it as small as possible for performance reasons is strongly desired. So if
> there is a coding scheme that can avoid increasing struct bio size, it should
> be explored first and discarded only with very good reasons.

I see your point.
I agree with you. it's important thing. :)

> 
> > Additional check for every page merge like as below is inefficient I think.
> 
> For the general case of devices that do not care about limiting the bio size
> (like now), this will add one boolean evaluation (queue flag test). That's it.
> For your case, sure you now have 2 boolean evals instead of one. But that must
> be put in perspective with the cost of increasing the bio size.
> 
> > 
> > bool __bio_try_merge_page(struct bio *bio, struct page *page,
> > 		unsigned int len, unsigned int off, bool *same_page)
> > {
> > 	...
> > 		if (page_is_mergeable(bv, page, len, off, same_page)) {
> > 			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> > 				*same_page = false;
> > 				return false;
> > 			}
> > 
> > +			if (blk_queue_limit_bio_max_size(bio) &&
> > +			   (bio->bi_iter.bi_size >
> > blk_queue_get_bio_max_size(bio) - len)) {
> > +				*same_page = false;
> > +				return false;
> > +			}
> > 
> > 			bv->bv_len += len;
> > 			bio->bi_iter.bi_size += len;
> > 			return true;
> > 		}
> > 	...
> > }
> > 
> > 
> > static inline bool bio_full(struct bio *bio, unsigned len)
> > {
> > 	...
> > 	if (bio->bi_iter.bi_size > UINT_MAX - len)
> > 		return true;
> > 
> > +	if (blk_queue_limit_bio_max_size(bio) &&
> > +	   (bio->bi_iter.bi_size > blk_queue_get_bio_max_size(bio) - len))
> > +		return true;
> > 	...
> > }
> > 
> > 
> > Page merge is CPU-bound job as you said.
> > How about below with adding of bi_max_size in bio?
> 
> I am not a fan of adding a bio field for using it only in one place.
> This is only my opinion. I will let others comment about this, but personnally
> I would rather do something like this:
> 
> #define blk_queue_limit_bio_merge_size(q) \
> test_bit(QUEUE_FLAG_LIMIT_MERGE, &(q)->queue_flags)
> 
> static inline unsigned int bio_max_merge_size(struct bio *bio)
> {
> struct request_queue *q = bio->bi_disk->queue;
> 
> if (blk_queue_limit_bio_merge_size(q))
> return blk_queue_get_max_sectors(q, bio_op(bio))
> << SECTOR_SHIFT;
> return UINT_MAX;
> }
> 
> and use that helper in __bio_try_merge_page(), e.g.:
> 
> if (bio->bi_iter.bi_size > bio_max_merge_size(bio) - len) {
> *same_page = false;
> return false;
> }
> 
> No need to change the bio struct.
> 
> If you measure performance with and without this change on nullblk, you can
> verify if it has any impact for regular devices. And for your use case, that
> should give you the same performance.
> 

OK. I'll wait others comment too for a few days.
I'll prepare v3 patch as you like if there are no feedback. :)
v2 patch has a compile error already by my misstyping. :(

> > 
> > bool __bio_try_merge_page(struct bio *bio, struct page *page,
> > 		unsigned int len, unsigned int off, bool *same_page)
> > {
> > 	...
> > 		if (page_is_mergeable(bv, page, len, off, same_page)) {
> > -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> > +			if (bio->bi_iter.bi_size > bio->bi_max_size - len) {
> > 				*same_page = false;
> > 				return false;
> > 			}
> > 
> > 			bv->bv_len += len;
> > 			bio->bi_iter.bi_size += len;
> > 			return true;
> > 		}
> > 	...
> > }
> > 
> > 
> > static inline bool bio_full(struct bio *bio, unsigned len)
> > {
> > 	...
> > -	if (bio->bi_iter.bi_size > UINT_MAX - len)
> > +	if (bio->bi_iter.bi_size > bio->bi_max_size - len)
> > 		return true;
> > 	...
> > }
> > 
> > +void bio_set_dev(struct bio *bio, struct block_device *bdev)
> > +{
> > +	if (bio->bi_disk != bdev->bd_disk)
> > +		bio_clear_flag(bio, BIO_THROTTLED);
> > +
> > +	bio->bi_disk = bdev->bd_disk;
> > +	bio->bi_partno = bdev->bd_partno;
> > +	if (blk_queue_limit_bio_max_size(bio))
> > +		bio->bi_max_size = blk_queue_get_bio_max_size(bio);
> > +
> > +	bio_associate_blkg(bio);
> > +}
> > +EXPORT_SYMBOL(bio_set_dev);
> > 
> > > -- 
> > > Damien Le Moal
> > > Western Digital Research
> > 
> > ---
> > Changheun Lee
> > Samsung Electronics
> 
> -- 
> Damien Le Moal
> Western Digital
> 

---
Changheun Lee
Samsung Electronics

