Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705FBC433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 01:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A61961380
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 01:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239470AbhDFBt1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Apr 2021 21:49:27 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:62514 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242082AbhDFBtU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Apr 2021 21:49:20 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210406014908epoutp01ae0440510f8f0cf6102bf5c9d0c12b0c~zIbQQfn8q1731717317epoutp01z
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 01:49:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210406014908epoutp01ae0440510f8f0cf6102bf5c9d0c12b0c~zIbQQfn8q1731717317epoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617673748;
        bh=i+cY6POYdCkrVMozJTyt8kBL/ujUnaLOG9/PlhmQ16I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f0BBvCBcqhne3pyi6OkeRLj1Vq6pjfZntIi/PG8SXL3VCvsy6hrvymJCLKSPzz7rG
         0vE+sfgjQtC9bxjytG6zbpOpISoD4rzMXdjxXVTJ+X95OR2ZS++sm5zdRiYYvLm648
         fdSqHOIKAClSKdoyBmVYH4Xe+L5L68sr2Z7gyroA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210406014906epcas1p4de17a227ad5092d5489c00f0948acf74~zIbO3LZrx1401514015epcas1p4_;
        Tue,  6 Apr 2021 01:49:06 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FDr6T4KTqz4x9QC; Tue,  6 Apr
        2021 01:49:05 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.41.23820.11EBB606; Tue,  6 Apr 2021 10:49:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210406014905epcas1p16830a46b7ac6af95a0e2c2c6f4c04859~zIbNF91mc1434114341epcas1p1G;
        Tue,  6 Apr 2021 01:49:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210406014904epsmtrp2525b7e9c72b76224895e802998d8c5fa~zIbNEcXzr1508315083epsmtrp2Y;
        Tue,  6 Apr 2021 01:49:04 +0000 (GMT)
X-AuditID: b6c32a37-a59ff70000015d0c-79-606bbe1102a7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.81.33967.01EBB606; Tue,  6 Apr 2021 10:49:04 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210406014904epsmtip21fbf51108f25076b17f062ad898d4b00~zIbMxqdZd3025330253epsmtip2j;
        Tue,  6 Apr 2021 01:49:04 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, gregkh@linuxfoundation.org,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com, osandov@fb.com,
        patchwork-bot@kernel.org, tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
Subject: [RESEND PATCH v5 1/2] bio: limit bio max size
Date:   Tue,  6 Apr 2021 10:31:28 +0900
Message-Id: <20210406013128.16284-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210316074401.4594-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEJsWRmVeSWpSXmKPExsWy7bCmrq7gvuwEg2+tChZzVm1jtFh9t5/N
        orX9G5NF8+L1bBanJyxisuh50sRq8bfrHpPF14fFFntvaVtc3jWHzeLQ5GYmi+mb5zBbHL53
        lcXi4ZKJzBbnTn5itZj32MHi1/KjjBbvf1xntzi1YzKzxfq9P9kcRDwmNr9j99g56y67x+YV
        Wh6Xz5Z6bFrVyeaxf+4ado/3+66yefRtWcXo8XmTnEf7gW6mAK6oHJuM1MSU1CKF1Lzk/JTM
        vHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoN+UFMoSc0qBQgGJxcVK+nY2Rfml
        JakKGfnFJbZKqQUpOQWGBgV6xYm5xaV56XrJ+blWhgYGRqZAlQk5GZ/nfWEtmKBd8fLAR6YG
        xna5LkZODgkBE4mPH9cxg9hCAjsYJTY0eHQxcgHZnxglXl88zwLhfGOUWLZhLytMx6F73cwQ
        ib2MEie/L2GDaP/MKLH0gQaIzSagI9H39hYbSJGIwFYmiZZrh8E6mAV2As3dPhtsobCAmcTe
        v18YQWwWAVWJv8uagPZxcPAKWEt0r06B2CYv8ed+DzNImBMovG5tDEiYV0BQ4uTMJywgNjNQ
        SfPW2WDjJQTecEjcv3AU6lIXid379kDZwhKvjm9hh7ClJD6/28sG0dDNKNHcNp8RwpnAKLHk
        +TImiCpjiU+fPzOCbGYW0JRYv0sfIqwosfP3XEaIzXwS7772sIKUSAjwSnS0CUGUqEicabnP
        DLPr+dqdTBAlHhJHG5QhAdfHKNH0aQbLBEaFWUj+mYXkn1kIixcwMq9iFEstKM5NTy02LDBG
        juFNjODErmW+g3Ha2w96hxiZOBgPMUpwMCuJ8O7ozU4Q4k1JrKxKLcqPLyrNSS0+xGgKDOuJ
        zFKiyfnA3JJXEm9oamRsbGxhYmZuZmqsJM6bZPAgXkggPbEkNTs1tSC1CKaPiYNTqoFJ1eSf
        3s0J/1++l+mYZ9P4q2/mHkUeji/MHRIMcuw7XycHWlwXidn46O3tiX8u2ul2bl/UEyR3rYh5
        Tt6ZaSdee+9bd+Cq3rK20m8d8RMcTWWzpQ+4i1llM0dtzMraNnMJp4GJjlIm18o2b43NMnG7
        JXtSuIskss7bnq/nbenSPXWgOLvh+0yNXfPPdJXmbwn7NOclc4vUlAWBwtPNLrK9+PywWm7m
        sen35vfxqoQ77Tq3dKJw0KyZNTcqlR7W611ft3rRBa6n2yb7m/6UqymqlttvkXlR43vOe4Fl
        L+2Vpn0R+S5ceXpa2FoOTk/+I3y98fb3YkTvpy5yvcbqlaDq1spx0tAkukx1ZduHkCtKLMUZ
        iYZazEXFiQBEccdidQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSvK7AvuwEg7PbjC3mrNrGaLH6bj+b
        RWv7NyaL5sXr2SxOT1jEZNHzpInV4m/XPSaLrw+LLfbe0ra4vGsOm8Whyc1MFtM3z2G2OHzv
        KovFwyUTmS3OnfzEajHvsYPFr+VHGS3e/7jObnFqx2Rmi/V7f7I5iHhMbH7H7rFz1l12j80r
        tDwuny312LSqk81j/9w17B7v911l8+jbsorR4/MmOY/2A91MAVxRXDYpqTmZZalF+nYJXBmf
        531hLZigXfHywEemBsZ2uS5GTg4JAROJQ/e6mbsYuTiEBHYzSkw4/5AJIiElcfzEW9YuRg4g
        W1ji8OFiiJqPjBJTvuxnBalhE9CR6Ht7iw0kISJwlEliw9VjYJOYBQ4yShyffYYRpEpYwExi
        798vYDaLgKrE32VNLCBTeQWsJbpXp0Ask5f4c7+HGSTMCRRetzYGxBQSsJK4vcMApIJXQFDi
        5MwnLCA2M1B189bZzBMYBWYhSc1CklrAyLSKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93
        EyM4+rQ0dzBuX/VB7xAjEwfjIUYJDmYlEd4dvdkJQrwpiZVVqUX58UWlOanFhxilOViUxHkv
        dJ2MFxJITyxJzU5NLUgtgskycXBKNTDt0Li8Ynv+zXVPef1YnlXlm7de/1XqMvGKcLb5UvHT
        0TaKz2uO7TgUY7s3QS3ku5bVvnvHu9v8bh9zsT/jxcJbo/Vs5bYAxbYte+cIRmeseJdomnW8
        WT5tdwqP4a+pGXEXE98sTTrWYOVewRa28Nm9s0Z3vT02tPtr56r4v4v7wWp1eOFf+S2xMhZv
        74r8v2koJHkxKj1w20bLxCk6d2N1Um9LzLswv0Jm6ratRyPlrhoU7rr8yvsrR57/m7XXZdMX
        b7C48+bml4dXFn3IaEi91ruidn/DliP6BpsLVNLvCF7vsMv/esD9ANuV36HOgk9bbbrqctYt
        shNaK+71QoyB7WLmnprgF7+Vz/5lrElSYinOSDTUYi4qTgQAH+n3PS0DAAA=
X-CMS-MailID: 20210406014905epcas1p16830a46b7ac6af95a0e2c2c6f4c04859
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210406014905epcas1p16830a46b7ac6af95a0e2c2c6f4c04859
References: <20210316074401.4594-1-nanich.lee@samsung.com>
        <CGME20210406014905epcas1p16830a46b7ac6af95a0e2c2c6f4c04859@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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
