Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8870C433ED
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 00:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEDE761399
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 00:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245375AbhDGAeA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 20:34:00 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:34154 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbhDGAd7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 20:33:59 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210407003349epoutp02098b6c0fc7c5d898f42a7f34d73cd725~zbCxtk73T1315513155epoutp02Z
        for <linux-block@vger.kernel.org>; Wed,  7 Apr 2021 00:33:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210407003349epoutp02098b6c0fc7c5d898f42a7f34d73cd725~zbCxtk73T1315513155epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617755629;
        bh=o4MkjzNa3FaSs+DNw2mj1VxFnvGzR3/mjx09bvrT52s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tAwCbiOLmc1YPyojQY/OJtKDLLCVRpvCpJ01ugxUnZNyHptGjd09lfqKOUrGgn0us
         qTCn1sRYgWDGsZcelwMCXNuS/My5vyaElejgomVn2Y37aP8IEA2ncOxE6fXeUykzfp
         oy90YW/Cu61wWpqXlPCIcPz5z/z4CYFg96HTUduk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210407003348epcas1p3540588674f768b1025453a14eca531ec~zbCwna_vm0898408984epcas1p3x;
        Wed,  7 Apr 2021 00:33:48 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.166]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FFQP63Jgkz4x9QD; Wed,  7 Apr
        2021 00:33:46 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.F9.10347.AEDFC606; Wed,  7 Apr 2021 09:33:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210407003345epcas1p21376df37d3dfe933684139d3beaf9c51~zbCuPFI8J2153721537epcas1p2b;
        Wed,  7 Apr 2021 00:33:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210407003345epsmtrp114165258195b1cfd842e8c288accd871~zbCuOAHcD2976029760epsmtrp1q;
        Wed,  7 Apr 2021 00:33:45 +0000 (GMT)
X-AuditID: b6c32a39-6f1f1a800002286b-b2-606cfdeaee0a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.F6.08745.9EDFC606; Wed,  7 Apr 2021 09:33:45 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210407003345epsmtip11f1ccc23d554af378620a7afcecf2d3a~zbCt5gemr2356823568epsmtip1Z;
        Wed,  7 Apr 2021 00:33:45 +0000 (GMT)
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
Date:   Wed,  7 Apr 2021 09:16:12 +0900
Message-Id: <20210407001612.17631-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <YGwOiL7tN905H0h0@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfVAUZRzHfXaP3YWElhPkGQg6d9QGFLgDDx9BiJSaHWPqRv6QKSfugB0g
        783bO0fKmahLIEA8BtIJkDJNCEUaQDoI0FAHNcgJxORUXpSSl4CGl0bgrO5upfjv+3uez/f5
        znf3eShcPEH4U1laI2fQqtQM4SFqvhocHjrxTK2UlhT6oMraZoDOPzxOoKN5f2HIfKaeQD9Z
        vsZQ0egnbuhZwSCGFkZ41G7bgvpaKwnUWWrG0MnGShzdHeom0dXBfhEaOVuCo59vzrqhqsfx
        aKn6OkAzT38l0S1rKY7q2xeJeF+2xDxNsi3lD0m2sSaE7esxsQ21nxHs5VMXSHamo59gi5tq
        ATvXEMTmXSnEFB7vqHdmcqp0ziDhtGm69CxtRizzZlLK7hR5lFQWKtuBtjMSrUrDxTIJiYrQ
        N7LUjoKM5JBKbXIsKVQ8z4TH7TToTEZOkqnjjbEMp09X62VSfRiv0vAmbUZYmk4TLZNKI+QO
        UqnObMuZwPSnIw63V3VhOeAHpgC4U5DeBstm75EFwIMS01YAu9vrcGGYBbC/bBEThjkA7x0d
        x1cs18wXCGGjFcCzNfn4f9RY4ThwUgS9FRZP2Qin9qGD4Oh9uwvC6TEcnsh/4DpqHR0NF6yT
        mFOL6E3wzPR90qk96Rh4+UYLJsS9DO1DRS7enQ6Gtd0TbgLjDW9+MSpyatzBmC9VuAIgPU/B
        pY67hGBOgFXLhc8PWgcnuppIQfvD8eO5pGAoBNCc+yUQBouj0JNzzx2RcHZuzrFBOSKCYX1r
        uLC8AbYsnwJCshecXihycyKQ9oT5uWIB2Qi7Px3CV7Ke1K2UYeFk9TWXVUwfgZO2RtICJOWr
        +pSv6lP+f/BXAK8F6zk9r8ngeJlevvonNwDXpQ/ZYQUnp/4M6wQYBToBpHDGx9N67IBS7Jmu
        yv6AM+hSDCY1x3cCueNrl+D+vmk6x6vRGlNk8ojIyEi0LWp7lDyS8fNMlQ6niOkMlZE7wHF6
        zrDiwyh3/xzMb6Mmfe/nj4kEb1Hj4G3bu3puyOBhveM7tz7w/YO+A3HMWjp78vWPvp/62zfv
        /PLYvKlnqWJ/yLGAb61KU3AivrZ331CSTVucfam0bqaHvwKCLPFNFmND56NNePI39u49ildL
        p1IDDxEXS9tt9n92adf8EXb4x5i9d64rbJrZLWj3QKqhucJrTW5c73uvUBelw7cL9BV1IS+9
        5tf3+0Kl8iC7OSB4oNx+4zeq4+2B0OwT0X6Kzc17UFcCmP94f/7SyOTW+uQKJfnhYuNoYHXb
        gyrJ6cRblaBN/RZDm385shgwXHau7ZF/Ta8uBqPZpA3kdwsvJItaX4zZ5xX3dHnREu7NiPhM
        lSwEN/CqfwEroqXLfQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSnO7LvzkJBr9uCFnMWbWN0WL13X42
        i9b2b0wWzYvXs1mcnrCIyaLnSROrxd+ue0wWXx8WW+y9pW1xedccNotDk5uZLKZvnsNsce3+
        GXaLw/euslg8XDKR2eLcyU+sFvMeO1j8Wn6U0eL9j+vsFqd2TGa2WL/3J5uDqMfE5nfsHjtn
        3WX32LxCy+Py2VKPTas62Tz2z13D7vF+31U2j74tqxg9Pm+S82g/0M0UwBXFZZOSmpNZllqk
        b5fAlbGn4RVTwUKjir3zjjM1MO5W6mLk5JAQMJE40ryGrYuRi0NIYAejxPQT+xghElISx0+8
        Ze1i5ACyhSUOHy6GqPnIKHFmbyMzSA2bgI5E39tbbCC2iICcxJPbf5hBipgFmlgkrp9fDTZI
        WMBK4uuO10wgNouAqsTid7fZQWxeAWuJ/Sd2MkEsk5f4c78HbCingKbEqjOvWEFsIQENid1f
        nzBC1AtKnJz5hAXEZgaqb946m3kCo8AsJKlZSFILGJlWMUqmFhTnpucWGxYY5aWW6xUn5haX
        5qXrJefnbmIEx6KW1g7GPas+6B1iZOJgPMQowcGsJMK7ozc7QYg3JbGyKrUoP76oNCe1+BCj
        NAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYm2/VtuVOeS2lJ/fFUqYhi60/5bWF53PBi
        8/Gy2RKc8u9TDLjeZwifSt59c9+rnltT65er199Z+fy5WmTBA4XvvsrVDMn9qQaCnXk3umwF
        /Kw3nL9ptXO29UrxlQ8nMrrnHNywp/6PSvu0vP923g/eZik3y7m94vpebLFR72lCuWDfget8
        J/uszX6w3dkg/+628HGfWF7GP/FzO6Uc/x058TBWZ1/EPcdHEYkvm5ZrbjJ74LBfO0vD2v2i
        7SYvRW7t3/98Ji9pfPGuI4vP43/Hz+JZjolbjtSX/atl6V2+1GySx75bGRNqmVJmeXv92qjm
        nb4+fltUgbIXi9r27ct6WkQN2Tv+OykfOXXvuIESS3FGoqEWc1FxIgDXsDKTNAMAAA==
X-CMS-MailID: 20210407003345epcas1p21376df37d3dfe933684139d3beaf9c51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210407003345epcas1p21376df37d3dfe933684139d3beaf9c51
References: <YGwOiL7tN905H0h0@kroah.com>
        <CGME20210407003345epcas1p21376df37d3dfe933684139d3beaf9c51@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Tue, Apr 06, 2021 at 10:31:28AM +0900, Changheun Lee wrote:
> > > bio size can grow up to 4GB when muli-page bvec is enabled.
> > > but sometimes it would lead to inefficient behaviors.
> > > in case of large chunk direct I/O, - 32MB chunk read in user space -
> > > all pages for 32MB would be merged to a bio structure if the pages
> > > physical addresses are contiguous. it makes some delay to submit
> > > until merge complete. bio max size should be limited to a proper size.
> > > 
> > > When 32MB chunk read with direct I/O option is coming from userspace,
> > > kernel behavior is below now in do_direct_IO() loop. it's timeline.
> > > 
> > >  | bio merge for 32MB. total 8,192 pages are merged.
> > >  | total elapsed time is over 2ms.
> > >  |------------------ ... ----------------------->|
> > >                                                  | 8,192 pages merged a bio.
> > >                                                  | at this time, first bio submit is done.
> > >                                                  | 1 bio is split to 32 read request and issue.
> > >                                                  |--------------->
> > >                                                   |--------------->
> > >                                                    |--------------->
> > >                                                               ......
> > >                                                                    |--------------->
> > >                                                                     |--------------->|
> > >                           total 19ms elapsed to complete 32MB read done from device. |
> > > 
> > > If bio max size is limited with 1MB, behavior is changed below.
> > > 
> > >  | bio merge for 1MB. 256 pages are merged for each bio.
> > >  | total 32 bio will be made.
> > >  | total elapsed time is over 2ms. it's same.
> > >  | but, first bio submit timing is fast. about 100us.
> > >  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
> > >       | 256 pages merged a bio.
> > >       | at this time, first bio submit is done.
> > >       | and 1 read request is issued for 1 bio.
> > >       |--------------->
> > >            |--------------->
> > >                 |--------------->
> > >                                       ......
> > >                                                  |--------------->
> > >                                                   |--------------->|
> > >         total 17ms elapsed to complete 32MB read done from device. |
> > > 
> > > As a result, read request issue timing is faster if bio max size is limited.
> > > Current kernel behavior with multipage bvec, super large bio can be created.
> > > And it lead to delay first I/O request issue.
> > > 
> > > Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> > > ---
> > >  block/bio.c            | 13 ++++++++++++-
> > >  include/linux/bio.h    |  2 +-
> > >  include/linux/blkdev.h |  3 +++
> > >  3 files changed, 16 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/block/bio.c b/block/bio.c
> > > index 1f2cc1fbe283..c528e1f944c7 100644
> > > --- a/block/bio.c
> > > +++ b/block/bio.c
> > > @@ -287,6 +287,17 @@ void bio_init(struct bio *bio, struct bio_vec *table,
> > >  }
> > >  EXPORT_SYMBOL(bio_init);
> > >  
> > > +unsigned int bio_max_size(struct bio *bio)
> > > +{
> > > +	struct request_queue *q = bio->bi_disk->queue;
> > > +
> > > +	if (blk_queue_limit_bio_size(q))
> > > +		return blk_queue_get_max_sectors(q, bio_op(bio))
> > > +			<< SECTOR_SHIFT;
> > > +
> > > +	return UINT_MAX;
> > > +}
> > > +
> > >  /**
> > >   * bio_reset - reinitialize a bio
> > >   * @bio:	bio to reset
> > > @@ -877,7 +888,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
> > >  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> > >  
> > >  		if (page_is_mergeable(bv, page, len, off, same_page)) {
> > > -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> > > +			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {
> > >  				*same_page = false;
> > >  				return false;
> > >  			}
> > > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > > index 1edda614f7ce..13b6f6562a5b 100644
> > > --- a/include/linux/bio.h
> > > +++ b/include/linux/bio.h
> > > @@ -113,7 +113,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
> > >  	if (bio->bi_vcnt >= bio->bi_max_vecs)
> > >  		return true;
> > >  
> > > -	if (bio->bi_iter.bi_size > UINT_MAX - len)
> > > +	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
> > >  		return true;
> > >  
> > >  	return false;
> > > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > > index f94ee3089e01..3aeab9e7e97b 100644
> > > --- a/include/linux/blkdev.h
> > > +++ b/include/linux/blkdev.h
> > > @@ -621,6 +621,7 @@ struct request_queue {
> > >  #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
> > >  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
> > >  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
> > > +#define QUEUE_FLAG_LIMIT_BIO_SIZE 30	/* limit bio size */
> > >  
> > >  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
> > >  				 (1 << QUEUE_FLAG_SAME_COMP) |		\
> > > @@ -667,6 +668,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
> > >  #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
> > >  #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
> > >  #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
> > > +#define blk_queue_limit_bio_size(q)	\
> > > +	test_bit(QUEUE_FLAG_LIMIT_BIO_SIZE, &(q)->queue_flags)
> > >  
> > >  extern void blk_set_pm_only(struct request_queue *q);
> > >  extern void blk_clear_pm_only(struct request_queue *q);
> > > -- 
> > > 2.28.0
> > > 
> > 
> > Please feedback to me if more modification is needed to apply. :)
> 
> You are adding code that tests for a value to be set, yet you never set
> it in this code so why is it needed at all?

This patch is a solution for some inefficient case of multipage bvec like
as current DIO scenario. So it's not set as a default.
It will be set when bio size limitation is needed in runtime.

> 
> thanks,
> 
> greg k-h

---
Changheun Lee
