Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A752EC433B4
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 13:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E51E60FD9
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 13:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhDZNTE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 09:19:04 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52662 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhDZNTE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 09:19:04 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210426131821euoutp02f201c59ff16d962da04c4cd314ba7ce2~5auucDLua0407104071euoutp02q
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 13:18:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210426131821euoutp02f201c59ff16d962da04c4cd314ba7ce2~5auucDLua0407104071euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619443101;
        bh=L7fczByfmc0bDtQP7K1v8ewbVvb4qW3hk6vvQPSTZOI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ig4kasx9V9oicW/5c7OJNKsV7nm0xAgpmjjhTded9voZe2tXXJ+KG/D3mkBOZ5zH5
         zy4NFG1RxoWzdxGTjeIAMft6LTkVKRbIYu6QhQZuoxQtD6BRB0InMFN7MHVN2E9yCW
         2liwsPFYDq/nroD7Qlx9jVDQjLDSB5e1ZMbO/kVc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210426131820eucas1p26ee064931934c43f36d50347433ccf08~5auto8oiV0229502295eucas1p2Q;
        Mon, 26 Apr 2021 13:18:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 06.3B.09452.C9DB6806; Mon, 26
        Apr 2021 14:18:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210426131819eucas1p12bc890181711e6bb7e4c234b67406134~5aus_Y2Xm0291402914eucas1p14;
        Mon, 26 Apr 2021 13:18:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210426131819eusmtrp21698c852f855c18b3d1ca57ad5027669~5aus9MrWv0896308963eusmtrp2B;
        Mon, 26 Apr 2021 13:18:19 +0000 (GMT)
X-AuditID: cbfec7f2-ab7ff700000024ec-29-6086bd9cd399
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0B.A3.08696.B9DB6806; Mon, 26
        Apr 2021 14:18:19 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210426131818eusmtip2025a15a7ee60867690a361281f21d7e8~5auru9SF72948729487eusmtip2S;
        Mon, 26 Apr 2021 13:18:18 +0000 (GMT)
Subject: Re: [PATCH v8] bio: limit bio max size
To:     Changheun Lee <nanich.lee@samsung.com>, bvanassche@acm.org,
        Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, gregkh@linuxfoundation.org,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com, osandov@fb.com,
        patchwork-bot@kernel.org, tj@kernel.org, tom.leiming@gmail.com
Cc:     jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <cb011703-4781-fd8e-d628-3dc488e0de7d@samsung.com>
Date:   Mon, 26 Apr 2021 15:18:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210421094745.29660-1-nanich.lee@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTZxjNe+/t7W1J8VLFvqKB2AwTQcrYWPZmU8KUzItEZ4JG52c7vAE3
        qKS1os5shAbBWqfQOFwL4gcOUpFKoQy6gLUIjDGrsfIxh2zE/jAIKx/iKKZsXK7b+Heec85z
        nvckL4VLC8kI6rD6KKtRq7LlpJho6gx44spbTyvfDnZLULm1CaCbT8+TqP6STYC+HQ/gqLDo
        FYb0120k6rlwDUNGX4EABQ1DGJoe1qLWJ7HI6ywnkdukx1BZQzmO+n7/RYjah3oJNFxVgiNP
        96QAXX6WjGarOwDyz/QL0c/NJhzZWgNksozxPk5jSvR/CpkW81Mh01ATw3jv6xi79QzJ3Kmo
        FTL+tl6S+abRCpgpeyRT5DqLbQ/ZI15/iM0+fIzVxCcpxVnTjmIstyrl+O2CPkE+ePCOAYgo
        SCfCtppO0gDElJSuAfBXxw+AH14CWFfa/0aZAnDy3rjAAKiFlRfnj/F8NYCDnRaCHybm1wdK
        SC53KR0P/a/9OCcso6cw+HxmQMgJOOeqb9jEYZJOgIYxw8KChE6CtWWzOIcJOhpW+n8jOBxO
        Z8AHz3qFvCcMdn/nW+BF9Hp4rv7Wm8woqHdYcB7L4BNfJcaXeyWCzR4R/+oUaAyG8PRSONLV
        KOTxKvh3C2cXz2M9gMMeLpMbjAB6Cy4B3vUhHPTMklwQTq+FNmc8T38En1/7HuPzQ+HAWBj/
        hFBY2lSG87QEFp+W8u410NxV99/Zuw8f4ReA3LyomHlRGfOiMub/714BhBXIWJ02J5PVJqjZ
        PIVWlaPVqTMVGUdy7GD+p/bMdU02g4qRCYUbYBRwA0jh8mUS0lmolEoOqU6cZDVHDmp02azW
        DVZShFwmsVpqD0rpTNVR9guWzWU1/6oYJYrIx6TFE1Euk+d+MDInNeLU2vE1f6BdXlt9i5R4
        X7skckN64V9XFUyiUrb1g5ZVln11jVWxzhum5fvfU0W/Hnn0WfIL8sDox8dTDU2rq5xp1Jwi
        15m1OdXTFewrchTvsCc99EbXhG8cAgL5yneHNoymV369V7R1yUbUzrbduAy3xR2o7T+1Tjpu
        ce2f7jNFbXHE3EuwW7JwoevHlNIVZ2Iqw/Ouxt4Z22bGfRGb8mdUu0Pk+OPBnzr2dfjCzg1m
        oLMvE4XD6hMu5Zehqz/tMU59Mrdi9K3lt+Vx0u0320/u3jy3Z/Yrd8C67krH52lxxp17dbsy
        AkRe48WKzGpR+k78Lrp1UU5os1QJMbhGq/oHFw5yZBgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsVy+t/xe7qz97YlGDx5LGMxZ9U2RovVd/vZ
        LDbOWM9qMe3DT2aL1vZvTBbNi9ezWZyesIjJoudJE6vF3657TBZfHxZb7L2lbXF51xw2i0OT
        m5kspm+ew2xx7f4ZdovD966yWDxcMpHZ4tzJT6wW8x47WPxafpTR4v2P6+wWp3ZMZrZYv/cn
        m4O4x+Ur3h4Tm9+xe+ycdZfdY/MKLY/LZ0s9Nq3qZPPYP3cNu8f7fVfZPPq2rGL0+LxJzqP9
        QDdTAHeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2C
        XsbXrR1MBUtcKjY0XWNtYDxv1MXIwSEhYCLxur+si5GLQ0hgKaNE+71njF2MnEBxGYmT0xpY
        IWxhiT/Xutggit4zStx98xUsISygL/H+93tmkISIwGcmiZt/l7KAJJgFPjJKvLoN1dHPKPFx
        xRSwDjYBQ4mutyCjODl4Bewk1kz/xQxiswioSsx/fxusWVQgWWL1782sEDWCEidnPgGLcwrY
        SPRuXMsOscBMYt7mh8wQtrxE89bZULa4xK0n85kmMArNQtI+C0nLLCQts5C0LGBkWcUoklpa
        nJueW2ykV5yYW1yal66XnJ+7iRGYRrYd+7llB+PKVx/1DjEycTAeYpTgYFYS4WXb1ZogxJuS
        WFmVWpQfX1Sak1p8iNEU6J+JzFKiyfnARJZXEm9oZmBqaGJmaWBqaWasJM5rcmRNvJBAemJJ
        anZqakFqEUwfEwenVAOTxn8JeS0XnYnJ8lUHVs+3LFI5e3zh0V8rGdiPmwbPZYzkjxSsufDt
        1pU7bEbLXO40cL+cyz4p92XMrbfbKxI3rtHQLbb9Vz/lxYOnT6buczka2n/joPmuitUPo3+U
        2PXfPK7ktKf9X/fE/FV/emWSu46/MJYTnO5bfT9ix5agYJb0S3msYrteCO8191/9hf/48sW2
        8y6e4X02r6FvnvDZpZ47H/p56D6fvd7yodityDv94XOrjjyvy3g1ucJIIXKaY2TxteutHXZ8
        7Xy957+une34v6/5xeOQzWcF0hmWmHaH/kqLt0qKXRM3lUfSyHmR15VdD7t2PKw/btaRs7Dc
        a6LEDe6I3KfC6l7mRgJpSizFGYmGWsxFxYkAGv+0nawDAAA=
X-CMS-MailID: 20210426131819eucas1p12bc890181711e6bb7e4c234b67406134
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210421100544epcas1p13c2c86e84102f0955dd591f72e45756a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210421100544epcas1p13c2c86e84102f0955dd591f72e45756a
References: <CGME20210421100544epcas1p13c2c86e84102f0955dd591f72e45756a@epcas1p1.samsung.com>
        <20210421094745.29660-1-nanich.lee@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Changheu,

On 21.04.2021 11:47, Changheun Lee wrote:
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
>   | bio merge for 32MB. total 8,192 pages are merged.
>   | total elapsed time is over 2ms.
>   |------------------ ... ----------------------->|
>                                                   | 8,192 pages merged a bio.
>                                                   | at this time, first bio submit is done.
>                                                   | 1 bio is split to 32 read request and issue.
>                                                   |--------------->
>                                                    |--------------->
>                                                     |--------------->
>                                                                ......
>                                                                     |--------------->
>                                                                      |--------------->|
>                            total 19ms elapsed to complete 32MB read done from device. |
>
> If bio max size is limited with 1MB, behavior is changed below.
>
>   | bio merge for 1MB. 256 pages are merged for each bio.
>   | total 32 bio will be made.
>   | total elapsed time is over 2ms. it's same.
>   | but, first bio submit timing is fast. about 100us.
>   |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
>        | 256 pages merged a bio.
>        | at this time, first bio submit is done.
>        | and 1 read request is issued for 1 bio.
>        |--------------->
>             |--------------->
>                  |--------------->
>                                        ......
>                                                   |--------------->
>                                                    |--------------->|
>          total 17ms elapsed to complete 32MB read done from device. |
>
> As a result, read request issue timing is faster if bio max size is limited.
> Current kernel behavior with multipage bvec, super large bio can be created.
> And it lead to delay first I/O request issue.
>
> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>

This patch landed in linux-next 20210426 as commit 42fb54fbc707 ("bio: 
limit bio max size"). Sadly it causes the following regression during 
boot on my test systems:

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 0000023c
pgd = (ptrval)
[0000023c] *pgd=00000000
Internal error: Oops: 5 [#2] SMP ARM
Modules linked in:
CPU: 0 PID: 186 Comm: systemd-udevd Tainted: G      D 
5.12.0-next-20210426 #3045
Hardware name: Generic DT based system
PC is at bio_add_hw_page+0x58/0x1fc
LR is at bio_add_pc_page+0x40/0x5c
pc : [<c06c5bf0>]    lr : [<c06c5dd4>]    psr: 20000013
sp : c3cc7de0  ip : ffffffff  fp : 00000000
r10: 00000cc0  r9 : c20b2000  r8 : c21b5680
r7 : dbc51b80  r6 : c30d0540  r5 : 00000014  r4 : c21b5680
r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : c30d0540
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 43ccc06a  DAC: 00000051
Register r0 information: slab request_queue start c30d0540 pointer offset 0
Register r1 information: NULL pointer
Register r2 information: NULL pointer
Register r3 information: NULL pointer
Register r4 information: slab kmalloc-128 start c21b5680 pointer offset 
0 size 128
Register r5 information: non-paged memory
Register r6 information: slab request_queue start c30d0540 pointer offset 0
Register r7 information: non-slab/vmalloc memory
Register r8 information: slab kmalloc-128 start c21b5680 pointer offset 
0 size 128
Register r9 information: slab kmalloc-4k start c20b2000 pointer offset 0 
size 4096
Register r10 information: non-paged memory
Register r11 information: NULL pointer
Register r12 information: non-paged memory
Process systemd-udevd (pid: 186, stack limit = 0x(ptrval))
Stack: (0xc3cc7de0 to 0xc3cc8000)
...
[<c06c5bf0>] (bio_add_hw_page) from [<c06c5dd4>] (bio_add_pc_page+0x40/0x5c)
[<c06c5dd4>] (bio_add_pc_page) from [<c06cf0ac>] 
(blk_rq_map_kern+0x234/0x304)
[<c06cf0ac>] (blk_rq_map_kern) from [<c0a54634>] (serial_show+0x64/0xd4)
[<c0a54634>] (serial_show) from [<c0a228ac>] (dev_attr_show+0x18/0x48)
[<c0a228ac>] (dev_attr_show) from [<c054721c>] (sysfs_kf_seq_show+0x88/0xf4)
[<c054721c>] (sysfs_kf_seq_show) from [<c04d7a44>] 
(seq_read_iter+0x10c/0x4bc)
[<c04d7a44>] (seq_read_iter) from [<c04adf60>] (vfs_read+0x1d4/0x2e0)
[<c04adf60>] (vfs_read) from [<c04ae47c>] (ksys_read+0x5c/0xd0)
[<c04ae47c>] (ksys_read) from [<c03000c0>] (ret_fast_syscall+0x0/0x58)
Exception stack(0xc3cc7fa8 to 0xc3cc7ff0)
...
Code: e1520003 9a000021 e5942004 e5941020 (e592223c)
---[ end trace 51c4d8003ec70244 ]---

It can be also reproduced with qemu and ARM 32bit virt machine. 
Reverting it on top of linux-next 20210426 fixes the issue. If you need 
more information, let me know.

> ---
>   block/bio.c            | 9 ++++++++-
>   block/blk-settings.c   | 5 +++++
>   include/linux/bio.h    | 4 +++-
>   include/linux/blkdev.h | 2 ++
>   4 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index 50e579088aca..9e5061ecc317 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -255,6 +255,13 @@ void bio_init(struct bio *bio, struct bio_vec *table,
>   }
>   EXPORT_SYMBOL(bio_init);
>   
> +unsigned int bio_max_size(struct bio *bio)
> +{
> +	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> +
> +	return q->limits.bio_max_bytes;
> +}
> +
>   /**
>    * bio_reset - reinitialize a bio
>    * @bio:	bio to reset
> @@ -866,7 +873,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
>   		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
>   
>   		if (page_is_mergeable(bv, page, len, off, same_page)) {
> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
> +			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {
>   				*same_page = false;
>   				return false;
>   			}
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index b4aa2f37fab6..cd3dcb5afe50 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -37,6 +37,7 @@ EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);
>    */
>   void blk_set_default_limits(struct queue_limits *lim)
>   {
> +	lim->bio_max_bytes = UINT_MAX;
>   	lim->max_segments = BLK_MAX_SEGMENTS;
>   	lim->max_discard_segments = 1;
>   	lim->max_integrity_segments = 0;
> @@ -168,6 +169,10 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
>   				 limits->logical_block_size >> SECTOR_SHIFT);
>   	limits->max_sectors = max_sectors;
>   
> +	if (check_shl_overflow(max_sectors, SECTOR_SHIFT,
> +				&limits->bio_max_bytes))
> +		limits->bio_max_bytes = UINT_MAX;
> +
>   	q->backing_dev_info->io_pages = max_sectors >> (PAGE_SHIFT - 9);
>   }
>   EXPORT_SYMBOL(blk_queue_max_hw_sectors);
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index d0246c92a6e8..e5add63da3af 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -106,6 +106,8 @@ static inline void *bio_data(struct bio *bio)
>   	return NULL;
>   }
>   
> +extern unsigned int bio_max_size(struct bio *bio);
> +
>   /**
>    * bio_full - check if the bio is full
>    * @bio:	bio to check
> @@ -119,7 +121,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
>   	if (bio->bi_vcnt >= bio->bi_max_vecs)
>   		return true;
>   
> -	if (bio->bi_iter.bi_size > UINT_MAX - len)
> +	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)
>   		return true;
>   
>   	return false;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 158aefae1030..c205d60ac611 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -312,6 +312,8 @@ enum blk_zoned_model {
>   };
>   
>   struct queue_limits {
> +	unsigned int		bio_max_bytes;
> +
>   	unsigned long		bounce_pfn;
>   	unsigned long		seg_boundary_mask;
>   	unsigned long		virt_boundary_mask;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

