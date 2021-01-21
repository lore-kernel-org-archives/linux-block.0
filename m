Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C68C433E6
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 09:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB3120725
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 09:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbhAUJws (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 04:52:48 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:18319 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727155AbhAUJwb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 04:52:31 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210121095141epoutp043b34089e859ac41d6d7e16678edd86bd~cNoLCMtEo0759707597epoutp04_
        for <linux-block@vger.kernel.org>; Thu, 21 Jan 2021 09:51:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210121095141epoutp043b34089e859ac41d6d7e16678edd86bd~cNoLCMtEo0759707597epoutp04_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611222701;
        bh=7YFkiECRDaCpD7tpFX2CzJQy3nZHJSkv82IKOg8emzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bh2zvSpsUew8IKOTqJbYWXdEOC3caY7/eawNLbgdJSJby0JNX+8f9o61ka8aey/ti
         PE4lBQgDSw99ypAqWKcXlnss5v7BLAL/XJZEF+rq25G/QHwf5VrF/Io8duQ0178/OI
         OCCvx64KOXysCGIk9TRWMjQYU9p0YrVLRSbpyYnA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210121095140epcas1p18e95457baf4d23dcfd18d7c9076a69d8~cNoKIn4LH1528415284epcas1p1V;
        Thu, 21 Jan 2021 09:51:40 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DLyMv4YBbz4x9Q6; Thu, 21 Jan
        2021 09:51:39 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.3A.10463.BAE49006; Thu, 21 Jan 2021 18:51:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210121095138epcas1p125bb1879c65fafe4636d71b8ab5f90cd~cNoIBaJwa0627406274epcas1p1F;
        Thu, 21 Jan 2021 09:51:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210121095138epsmtrp2f14907172b54d1d07f2bb9416064db82~cNoIAQV1e3214832148epsmtrp2I;
        Thu, 21 Jan 2021 09:51:38 +0000 (GMT)
X-AuditID: b6c32a38-f11ff700000028df-44-60094eab5514
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.A6.13470.AAE49006; Thu, 21 Jan 2021 18:51:38 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210121095138epsmtip271a0b0b8ccb9043ac2612cd9eb4511fc~cNoHwPUYo0307603076epsmtip2K;
        Thu, 21 Jan 2021 09:51:38 +0000 (GMT)
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
Date:   Thu, 21 Jan 2021 18:36:17 +0900
Message-Id: <20210121093617.29711-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <BL0PR04MB6514CF1FBBF498CB84BCA565E7A10@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGJsWRmVeSWpSXmKPExsWy7bCmvu5qP84EgzU3FSzmrNrGaLH6bj+b
        RWv7NyaLnidNrBZ/u+4xWXx9WGyx95a2xeVdc9gsDk1uZrKYvnkOs8W1+2fYLQ7fu8pi8XDJ
        RGaLcyc/sVrMe+xg8Wv5UUaL9z+us1uc2jGZ2WL93p9sDsIeE5vfsXvsnHWX3ePy2VKPTas6
        2Tze77vK5tG3ZRWjx+dNch7tB7qZAjiicmwyUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
        LS3MlRTyEnNTbZVcfAJ03TJzgL5RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BQY
        GhToFSfmFpfmpesl5+daGRoYGJkCVSbkZPTsvsBW8MGtouP2f+YGxsfGXYycHBICJhIPbr1k
        6mLk4hAS2MEo8fj7ckaQhJDAJ0aJXzc8IRLfGCUWbT/BBNPRtmgLI0RiL1BixQZ2COczo8Ta
        +y9ZQKrYBHQk+t7eYgOxRQQkJU69/MIGUsQssI9Z4tOWZ6wgCWEBfaDuN0AJDg4WAVWJZys5
        QMK8AtYSj+5eYoXYJi/xtHc5M4jNKRAr0XJxBytEjaDEyZlPwHYxA9U0b53NDDJfQuAGh8TV
        lUdYIJpdJC697YcaJCzx6vgWdghbSuLzu71sEA3djBLNbfMZIZwJjBJLni+DetRY4tPnz4wg
        1zELaEqs36UPEVaU2Pl7LiPEZj6Jd197WEFKJAR4JTrahCBKVCTOtNxnhtn1fO1OqIkeEleW
        NkJDawOjxKsFW9kmMCrMQvLQLCQPzULYvICReRWjWGpBcW56arFhgQlyHG9iBCdwLYsdjHPf
        ftA7xMjEwXiIUYKDWUmE95ElR4IQb0piZVVqUX58UWlOavEhRlNgaE9klhJNzgfmkLySeENT
        I2NjYwsTM3MzU2Mlcd4kgwfxQgLpiSWp2ampBalFMH1MHJxSDUzqydHdfLaLm9wS/EMc+JKa
        lr/7VVx14SBHn1F1gL/tm8PTI34ytVxxnn6lst2uq//5TraCwz49QV9frD7Gv9b6wMLi3+wG
        flI/9a3urH7tPvFEjKpxoefZi9P3tqd8/zOz2nNCxmn2q+cvHk1vNzx1RU3OS/RyYGj+/Nub
        vKXPfXW0eh48zSfX/1dEUWDhuV3+rC/nqtZ++G1ydvmcpRNOxS3boNPuMufPW9653KkLrtdf
        WLrwmUnNvfbgWuH8utNTyq97uC8z5/Z/Kb3XyOCOj9qf0rDV5/j2BrqdFNBe484pb3I69Uyt
        ef77/VvS7/O7SNc8vqSYUu4dkCXUcTbkpsfcBwtqK56d/lNq0aPEUpyRaKjFXFScCAA6mxfS
        aQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJXneVH2eCwcU/ihZzVm1jtFh9t5/N
        orX9G5NFz5MmVou/XfeYLL4+LLbYe0vb4vKuOWwWhyY3M1lM3zyH2eLa/TPsFofvXWWxeLhk
        IrPFuZOfWC3mPXaw+LX8KKPF+x/X2S1O7ZjMbLF+7082B2GPic3v2D12zrrL7nH5bKnHplWd
        bB7v911l8+jbsorR4/MmOY/2A91MARxRXDYpqTmZZalF+nYJXBk9uy+wFXxwq+i4/Z+5gfGx
        cRcjJ4eEgIlE26ItjF2MXBxCArsZJW7t2MUIkZCSOH7iLWsXIweQLSxx+HAxRM1HRokvW1ay
        gdSwCehI9L29BWaLCEhKnHr5hQ2kiFngCrPE5o8zwQYJC+hLLFrxhg1kEIuAqsSzlRwgYV4B
        a4lHdy+xQuySl3jau5wZxOYUiJVoubgDLC4kECNx4GcrG0S9oMTJmU9YQGxmoPrmrbOZJzAK
        zEKSmoUktYCRaRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnCMaWnuYNy+6oPeIUYm
        DsZDjBIczEoivI8sORKEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoE
        k2Xi4JRqYIo6kpiQ6J4aevnH6g0/UtVOmrzYVpylZctgkRP0c11sj3VunWXJNXOVrSlLIjXY
        RP++37TMdPX+yofpM/6K1Vpd3/Ly+DvPSOmngk5z7swqP8v673Lejzlvp3KZiS5UVnhvvTQr
        +OBM43m513//vvDn+iNle76Y/ac/qKmX1ay5eN6Xh634VPX57NZ/J505lWd7PxJgvbWzOUh/
        Pe9Mp+hXGk8/Fyy5vH1r1c1Viz7Vb3BIZE7h3dcXKc5l8eWS82+3F7HfFVr8j27pfKR5fMVd
        SfGZJxl+P93cLaHi8VmnjevcNGOO1U/Yyh9ce1r+cG+ASX7IFw2t+DzTvR+Ft5h/8BRZXWDC
        t/3+n2aRm2+UWIozEg21mIuKEwHmwIIMIAMAAA==
X-CMS-MailID: 20210121095138epcas1p125bb1879c65fafe4636d71b8ab5f90cd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210121095138epcas1p125bb1879c65fafe4636d71b8ab5f90cd
References: <BL0PR04MB6514CF1FBBF498CB84BCA565E7A10@BL0PR04MB6514.namprd04.prod.outlook.com>
        <CGME20210121095138epcas1p125bb1879c65fafe4636d71b8ab5f90cd@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>Please drop the "." at the end of the patch title.
>
>> bio size can grow up to 4GB when muli-page bvec is enabled.
>> but sometimes it would lead to inefficient behaviors.
>> in case of large chunk direct I/O, - 32MB chunk read in user space -
>> all pages for 32MB would be merged to a bio structure if memory address is
>> continued phsycally. it makes some delay to submit until merge complete.
>
>s/if memory address is continued phsycally/if the pages physical addresses are
>contiguous/
>
>> bio max size should be limited as a proper size.
>
>s/as/to/

Thank you for advice. :)

>
>> 
>> When 32MB chunk read with direct I/O option is coming from userspace,
>> kernel behavior is below now. it's timeline.
>> 
>>  | bio merge for 32MB. total 8,192 pages are merged.
>>  | total elapsed time is over 2ms.
>>  |------------------ ... ----------------------->|
>>                                                  | 8,192 pages merged a bio.
>>                                                  | at this time, first bio submit is done.
>>                                                  | 1 bio is split to 32 read request and issue.
>>                                                  |--------------->
>>                                                   |--------------->
>>                                                    |--------------->
>>                                                               ......
>>                                                                    |--------------->
>>                                                                     |--------------->|
>>                           total 19ms elapsed to complete 32MB read done from device. |
>> 
>> If bio max size is limited with 1MB, behavior is changed below.
>> 
>>  | bio merge for 1MB. 256 pages are merged for each bio.
>>  | total 32 bio will be made.
>>  | total elapsed time is over 2ms. it's same.
>>  | but, first bio submit timing is fast. about 100us.
>>  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
>>       | 256 pages merged a bio.
>>       | at this time, first bio submit is done.
>>       | and 1 read request is issued for 1 bio.
>>       |--------------->
>>            |--------------->
>>                 |--------------->
>>                                       ......
>>                                                  |--------------->
>>                                                   |--------------->|
>>         total 17ms elapsed to complete 32MB read done from device. |
>> 
>> As a result, read request issue timing is faster if bio max size is limited.
>> Current kernel behavior with multipage bvec, super large bio can be created.
>> And it lead to delay first I/O request issue.
>> 
>> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
>> 
>> ---
>>  block/bio.c               | 17 ++++++++++++++++-
>>  include/linux/bio.h       | 13 +++----------
>>  include/linux/blk_types.h |  1 +
>>  3 files changed, 20 insertions(+), 11 deletions(-)
>> 
>> diff --git a/block/bio.c b/block/bio.c
>> index 1f2cc1fbe283..027503c2e2e7 100644
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -284,9 +284,24 @@ void bio_init(struct bio *bio, struct bio_vec *table,
>>  
>>  	bio->bi_io_vec = table;
>>  	bio->bi_max_vecs = max_vecs;
>> +	bio->bi_max_size = UINT_MAX;
>>  }
>>  EXPORT_SYMBOL(bio_init);
>>  
>> +void bio_set_dev(struct bio *bio, struct block_device *bdev)
>> +{
>> +	if (bio->bi_disk != bdev->bd_disk)
>> +		bio_clear_flag(bio, BIO_THROTTLED);
>> +
>> +	bio->bi_disk = bdev->bd_disk;
>> +	bio->bi_partno = bdev->bd_partno;
>> +	bio->bi_max_size = blk_queue_get_max_sectors(bio->bi_disk->queue,
>> +			bio_op(bio)) << SECTOR_SHIFT;
>> +
>> +	bio_associate_blkg(bio);
>> +}
>> +EXPORT_SYMBOL(bio_set_dev);
>> +
>>  /**
>>   * bio_reset - reinitialize a bio
>>   * @bio:	bio to reset
>> @@ -877,7 +892,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
>>  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
>>  
>>  		if (page_is_mergeable(bv, page, len, off, same_page)) {
>> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
>> +			if (bio->bi_iter.bi_size > bio->bi_max_size - len)
>>  				*same_page = false;
>>  				return false;
>>  			}
>> diff --git a/include/linux/bio.h b/include/linux/bio.h
>> index 1edda614f7ce..b9803e80c259 100644
>> --- a/include/linux/bio.h
>> +++ b/include/linux/bio.h
>> @@ -113,7 +113,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
>>  	if (bio->bi_vcnt >= bio->bi_max_vecs)
>>  		return true;
>>  
>> -	if (bio->bi_iter.bi_size > UINT_MAX - len)
>> +	if (bio->bi_iter.bi_size > bio->bi_max_size - len)
>>  		return true;
>>  
>>  	return false;
>> @@ -482,20 +482,13 @@ extern struct bio_vec *bvec_alloc(gfp_t, int, unsigned long *, mempool_t *);
>>  extern void bvec_free(mempool_t *, struct bio_vec *, unsigned int);
>>  extern unsigned int bvec_nr_vecs(unsigned short idx);
>>  extern const char *bio_devname(struct bio *bio, char *buffer);
>> -
>> -#define bio_set_dev(bio, bdev) 			\
>> -do {						\
>> -	if ((bio)->bi_disk != (bdev)->bd_disk)	\
>> -		bio_clear_flag(bio, BIO_THROTTLED);\
>> -	(bio)->bi_disk = (bdev)->bd_disk;	\
>> -	(bio)->bi_partno = (bdev)->bd_partno;	\
>> -	bio_associate_blkg(bio);		\
>> -} while (0)
>> +extern void bio_set_dev(struct bio *bio, struct block_device *bdev);
>>  
>>  #define bio_copy_dev(dst, src)			\
>>  do {						\
>>  	(dst)->bi_disk = (src)->bi_disk;	\
>>  	(dst)->bi_partno = (src)->bi_partno;	\
>> +	(dst)->bi_max_size = (src)->bi_max_size;\
>>  	bio_clone_blkg_association(dst, src);	\
>>  } while (0)
>>  
>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>> index 866f74261b3b..e5dd5b7d8fc1 100644
>> --- a/include/linux/blk_types.h
>> +++ b/include/linux/blk_types.h
>> @@ -270,6 +270,7 @@ struct bio {
>>  	 */
>>  
>>  	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
>> +	unsigned int		bi_max_size;	/* max data size we can hold */
>>  
>>  	atomic_t		__bi_cnt;	/* pin count */
>
>This modification comes at the cost of increasing the bio structure size to
>simply tell the block layer "do not delay BIO splitting"...
>
>I think there is a much simpler approach. What about:
>
>1) Use a request queue flag to indicate "limit BIO size"
>2) modify __bio_try_merge_page() to look at that flag to disallow page merging
>if the bio size exceeds blk_queue_get_max_sectors(), or more ideally a version
>of it that takes into account the bio start sector.
>3) Set the "limit bio size" queue flag in the driver of the device that benefit
>from this change. Eventually, that could also be controlled through sysfs.
>
>With such change, you will get the same result without having to increase the
>BIO structure size.

I have a qustion.
Is adding new variable in bio not possible?
Additional check for every page merge like as below is inefficient I think.

bool __bio_try_merge_page(struct bio *bio, struct page *page,
		unsigned int len, unsigned int off, bool *same_page)
{
	...
		if (page_is_mergeable(bv, page, len, off, same_page)) {
			if (bio->bi_iter.bi_size > UINT_MAX - len) {
				*same_page = false;
				return false;
			}

+			if (blk_queue_limit_bio_max_size(bio) &&
+			   (bio->bi_iter.bi_size > blk_queue_get_bio_max_size(bio) - len)) {
+				*same_page = false;
+				return false;
+			}

			bv->bv_len += len;
			bio->bi_iter.bi_size += len;
			return true;
		}
	...
}


static inline bool bio_full(struct bio *bio, unsigned len)
{
	...
	if (bio->bi_iter.bi_size > UINT_MAX - len)
		return true;

+	if (blk_queue_limit_bio_max_size(bio) &&
+	   (bio->bi_iter.bi_size > blk_queue_get_bio_max_size(bio) - len))
+		return true;
	...
}


Page merge is CPU-bound job as you said.
How about below with adding of bi_max_size in bio?

bool __bio_try_merge_page(struct bio *bio, struct page *page,
		unsigned int len, unsigned int off, bool *same_page)
{
	...
		if (page_is_mergeable(bv, page, len, off, same_page)) {
-			if (bio->bi_iter.bi_size > UINT_MAX - len) {
+			if (bio->bi_iter.bi_size > bio->bi_max_size - len) {
				*same_page = false;
				return false;
			}

			bv->bv_len += len;
			bio->bi_iter.bi_size += len;
			return true;
		}
	...
}


static inline bool bio_full(struct bio *bio, unsigned len)
{
	...
-	if (bio->bi_iter.bi_size > UINT_MAX - len)
+	if (bio->bi_iter.bi_size > bio->bi_max_size - len)
		return true;
	...
}

+void bio_set_dev(struct bio *bio, struct block_device *bdev)
+{
+	if (bio->bi_disk != bdev->bd_disk)
+		bio_clear_flag(bio, BIO_THROTTLED);
+
+	bio->bi_disk = bdev->bd_disk;
+	bio->bi_partno = bdev->bd_partno;
+	if (blk_queue_limit_bio_max_size(bio))
+		bio->bi_max_size = blk_queue_get_bio_max_size(bio);
+
+	bio_associate_blkg(bio);
+}
+EXPORT_SYMBOL(bio_set_dev);

>-- 
>Damien Le Moal
>Western Digital Research

---
Changheun Lee
Samsung Electronics
