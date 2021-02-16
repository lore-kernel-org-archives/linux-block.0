Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE6FC433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 06:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C39264D9A
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 06:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhBPG7e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Feb 2021 01:59:34 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:18823 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhBPG7d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Feb 2021 01:59:33 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210216065850epoutp0455ceef996baf0f4cbcb3acfc7b65e0a5~kKCqnLetr0461604616epoutp04I
        for <linux-block@vger.kernel.org>; Tue, 16 Feb 2021 06:58:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210216065850epoutp0455ceef996baf0f4cbcb3acfc7b65e0a5~kKCqnLetr0461604616epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613458730;
        bh=msi/Qe3vFnQpELUc4a+s+F9IiMqwTL74fLpfFaOgmJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tbpu8EqAUbwIpLUyl+DhS0fS7NLjwwINBCZTMNQnbzvKBksSdaDL9Az99cvo397dH
         fqEOx6pIzGFPfBh1Bph1ZrvHCdPpdIuqb2PX6hMWsdASBXJJvKkORblYA8DQArf7ap
         EpNiM13k2eG1+VUslhYkV/xGWMb3Bee0wZHCT148=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210216065849epcas1p4f3974c07993cc02ecdfe061787a88276~kKCqDGkMy2270222702epcas1p4o;
        Tue, 16 Feb 2021 06:58:49 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.163]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DfsJQ2BX9z4x9Q1; Tue, 16 Feb
        2021 06:58:46 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.FF.09577.62D6B206; Tue, 16 Feb 2021 15:58:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210216065845epcas1p2dcb0d476c5118999d6d764badf05c1c5~kKCmfL0m00283902839epcas1p2I;
        Tue, 16 Feb 2021 06:58:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210216065845epsmtrp206f080ca4168a84b9f07fe67d51cf943~kKCmdyi0J0295502955epsmtrp2f;
        Tue, 16 Feb 2021 06:58:45 +0000 (GMT)
X-AuditID: b6c32a39-193b3a8000002569-20-602b6d26bd98
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.8F.13470.52D6B206; Tue, 16 Feb 2021 15:58:45 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210216065845epsmtip1951eb470d7be7346f780836551078077~kKCmL48iJ0043700437epsmtip1S;
        Tue, 16 Feb 2021 06:58:45 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     gregkh@linuxfoundation.org, Johannes.Thumshirn@wdc.com,
        asml.silence@gmail.com, axboe@kernel.dk, damien.lemoal@wdc.com,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com, osandov@fb.com,
        patchwork-bot@kernel.org, tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, nanich.lee@samsung.com,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: [PATCH v5 1/2] bio: limit bio max size
Date:   Tue, 16 Feb 2021 15:42:42 +0900
Message-Id: <20210216064242.14979-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <YCtkAZNIgehq3ewF@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNJsWRmVeSWpSXmKPExsWy7bCmga5arnaCwbtN3BZzVm1jtFh9t5/N
        orX9G5NF8+L1bBanJyxisuh50sRq8bfrHpPF14fFFntvaVtc3jWHzeLQ5GYmi+mb5zBbXLt/
        ht3i8L2rLBYPl0xktjh38hOrxbzHDha/lh9ltHj/4zq7xakdk5kt1u/9yeYg6jGx+R27x85Z
        d9k9Nq/Q8rh8ttRj06pONo/9c9ewe7zfd5XNo2/LKkaPz5vkPNoPdDMFcEXl2GSkJqakFimk
        5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAPaikUJaYUwoUCkgsLlbS
        t7Mpyi8tSVXIyC8usVVKLUjJKTA0KNArTswtLs1L10vOz7UyNDAwMgWqTMjJOHrmO0vBbZ2K
        p++XsjUwzpHvYuTkkBAwkWi8+oG5i5GLQ0hgB6PEm0XzGCGcT4wS+1euYIdwvjFKbPr6ngWm
        5dmRtVAtexklVp67zALhfGaUuHthFhNIFZuAjkTf21tsIAkRga1MEjfvtoI5zAIXGSX+zbgA
        NktYwFji7K4vjCA2i4CqxPUpC9hBbF4Ba4k3/+YzQeyTl3jau5wZxOYU0JR48vogVI2gxMmZ
        T8DmMAPVNG+dDXaThMAHDonGdbugml0k5h3aywphC0u8Or6FHcKWkvj8bi8bREM3o0Rz23xG
        CGcCo8SS58uguo0lPn3+DJTgAFqhKbF+lz5EWFFi5++5jBCb+STefe1hBSmREOCV6GgTgihR
        kTjTcp8ZZtfztTuhJnpI7O35Ana0kECNxMeFS9kmMCrMQvLPLCT/zEJYvICReRWjWGpBcW56
        arFhgSlyLG9iBKd6LcsdjNPfftA7xMjEwXiIUYKDWUmEl/2zVoIQb0piZVVqUX58UWlOavEh
        RlNgaE9klhJNzgdmm7ySeENTI2NjYwsTM3MzU2Mlcd4kgwfxQgLpiSWp2ampBalFMH1MHJxS
        DUzNf903O9/p3VGtwfYqJmXPw95bZftSwu/zxopeWx/QUZKown/Ka+/9dd+6ZNtnPU8KTOWd
        aKiSlq/Xdu7ukY74Gt66948Sphu+49FTNzr88c87g2JLsdefn8mtvK5WMKP/wWHnOGCaryhk
        dVnwKVXyd+PNrytYN/wRnHp3avo1v9anrF59Ujwbtz0Tu5S09PS727U3l6w8uuj/YbkvHlWO
        +j/Zv/51/z1x41fHmh2rfqwU2l9v+ujsZjdvffvS9LxJwofDd2hc87va4HTp3SXr3w6RzpVX
        WuOZCjKVtkxVnumk3itccIb5l+fC/gwD0Vt1L5dtMhc5PbPy7dYHQsyXT2glmepqb4zy9eb0
        /KLEUpyRaKjFXFScCAAEO4hwfgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWy7bCSnK5qrnaCwacWZYs5q7YxWqy+289m
        0dr+jcmiefF6NovTExYxWfQ8aWK1+Nt1j8ni68Nii723tC0u75rDZnFocjOTxfTNc5gtrt0/
        w25x+N5VFouHSyYyW5w7+YnVYt5jB4tfy48yWrz/cZ3d4tSOycwW6/f+ZHMQ9ZjY/I7dY+es
        u+wem1doeVw+W+qxaVUnm8f+uWvYPd7vu8rm0bdlFaPH501yHu0HupkCuKK4bFJSczLLUov0
        7RK4Mo6e+c5ScFun4un7pWwNjHPkuxg5OSQETCSeHVnL3MXIxSEksJtRYv6NqSwQCSmJ4yfe
        snYxcgDZwhKHDxdD1HxklDj6YBszSA2bgI5E39tbbCAJEYGjTBLb7/SzgjjMAreBJp17wQZS
        JSxgLHF21xdGEJtFQFXi+pQF7CA2r4C1xJt/85kgtslLPO1dDjaVU0BT4snrg2A1QgIaEmd7
        9rJA1AtKnJz5BMxmBqpv3jqbeQKjwCwkqVlIUgsYmVYxSqYWFOem5xYbFhjmpZbrFSfmFpfm
        pesl5+duYgRHo5bmDsbtqz7oHWJk4mA8xCjBwawkwsv+WStBiDclsbIqtSg/vqg0J7X4EKM0
        B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqagtJizG7K8JgZXLj589c+ECF+2jexX954R
        WSh1ekd4SKpbnFbdvcVTNyzQrP/6bvvbCd+uPgidwpaiFnv6ykvRjZdYcguYPdcrcU+JLznW
        6jnz6KWmVnVfSc66Bd+cLjt7/spb+ufyXTvbzy4Ltt7X26icfuyr8yK5BA3liCgF61tXi5f3
        Zy2bsbv0wR3fXGWnhsD8uDhL0fs70kt9VO7yZFxNFPvn1uTXPeWYRP3KFOfp0WoMXcKOi/UD
        Hdl5Rc34MszLs9eUtVXcFLzerfvnjji/WXes/wZnI4s4gyWmqTOqL1h/WyRX5nI16YP6qf7d
        By7oV7CG5thVO89YycXTZtT8fkUd71fd1S82KrEUZyQaajEXFScCAEaA5Ao1AwAA
X-CMS-MailID: 20210216065845epcas1p2dcb0d476c5118999d6d764badf05c1c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210216065845epcas1p2dcb0d476c5118999d6d764badf05c1c5
References: <YCtkAZNIgehq3ewF@kroah.com>
        <CGME20210216065845epcas1p2dcb0d476c5118999d6d764badf05c1c5@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> 
> On Tue, Feb 16, 2021 at 11:00:32AM +0900, Changheun Lee wrote:
> > Please feedback to me if more modification is needed to apply. :)
> 
> No context here :(
> 

I'm so sorry. I missed it.

> bio size can grow up to 4GB when muli-page bvec is enabled.
> but sometimes it would lead to inefficient behaviors.
> in case of large chunk direct I/O, - 32MB chunk read in user space -
> all pages for 32MB would be merged to a bio structure if the pages
> physical addresses are contiguous. it makes some delay to submit
> until merge complete. bio max size should be limited to a proper size.
> 
> When 32MB chunk read with direct I/O option is coming from userspace,
> kernel behavior is below now in do_direct_IO() loop. it's timeline.
> 
>  | bio merge for 32MB. total 8,192 pages are merged.
>  | total elapsed time is over 2ms.
>  |------------------ ... ----------------------->|
>                                                  | 8,192 pages merged a bio.
>                                                  | at this time, first bio submit is done.
>                                                  | 1 bio is split to 32 read request and issue.
>                                                  |--------------->
>                                                   |--------------->
>                                                    |--------------->
>                                                               ......
>                                                                    |--------------->
>                                                                     |--------------->|
>                           total 19ms elapsed to complete 32MB read done from device. |
> 
> If bio max size is limited with 1MB, behavior is changed below.
> 
>  | bio merge for 1MB. 256 pages are merged for each bio.
>  | total 32 bio will be made.
>  | total elapsed time is over 2ms. it's same.
>  | but, first bio submit timing is fast. about 100us.
>  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
>       | 256 pages merged a bio.
>       | at this time, first bio submit is done.
>       | and 1 read request is issued for 1 bio.
>       |--------------->
>            |--------------->
>                 |--------------->
>                                       ......
>                                                  |--------------->
>                                                   |--------------->|
>         total 17ms elapsed to complete 32MB read done from device. |
> 
> As a result, read request issue timing is faster if bio max size is limited.
> Current kernel behavior with multipage bvec, super large bio can be created.
> And it lead to delay first I/O request issue.
> 
> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> ---
>  block/bio.c            | 13 ++++++++++++-
>  include/linux/bio.h    |  2 +-
>  include/linux/blkdev.h |  3 +++
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 1f2cc1fbe283..c528e1f944c7 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -287,6 +287,17 @@ void bio_init(struct bio *bio, struct bio_vec *table,
>  }
>  EXPORT_SYMBOL(bio_init);
>  
> +unsigned int bio_max_size(struct bio *bio)
> +{
> +	struct request_queue *q = bio->bi_disk->queue;
> +
> +	if (blk_queue_limit_bio_size(q))
> +		return blk_queue_get_max_sectors(q, bio_op(bio))
> +			<< SECTOR_SHIFT;
> +
> +	return UINT_MAX;
> +}
> +
>  /**
>   * bio_reset - reinitialize a bio
>   * @bio:	bio to reset
> @@ -877,7 +888,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
>  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
>  
>  		if (page_is_mergeable(bv, page, len, off, same_page)) {
> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> +			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {
>  				*same_page = false;
>  				return false;
>  			}
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 1edda614f7ce..13b6f6562a5b 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -113,7 +113,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
>  	if (bio->bi_vcnt >= bio->bi_max_vecs)
>  		return true;
>  
> -	if (bio->bi_iter.bi_size > UINT_MAX - len)
> +	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
>  		return true;
>  
>  	return false;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f94ee3089e01..3aeab9e7e97b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -621,6 +621,7 @@ struct request_queue {
>  #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
>  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
>  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
> +#define QUEUE_FLAG_LIMIT_BIO_SIZE 30	/* limit bio size */
>  
>  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
>  				 (1 << QUEUE_FLAG_SAME_COMP) |		\
> @@ -667,6 +668,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
>  #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
>  #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
>  #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
> +#define blk_queue_limit_bio_size(q)	\
> +	test_bit(QUEUE_FLAG_LIMIT_BIO_SIZE, &(q)->queue_flags)
>  
>  extern void blk_set_pm_only(struct request_queue *q);
>  extern void blk_clear_pm_only(struct request_queue *q);
> -- 
> 2.28.0
> 

Please feedback to me if more modification is needed to apply. :)

---
Changheun Lee
