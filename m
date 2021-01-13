Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47482C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 06:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0536E22D58
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 06:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbhAMGzb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 01:55:31 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:31450 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbhAMGzb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 01:55:31 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210113065447epoutp01d9ad050b429e0e862977a6436b3cc420~ZuDbUBd7H2140421404epoutp01k
        for <linux-block@vger.kernel.org>; Wed, 13 Jan 2021 06:54:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210113065447epoutp01d9ad050b429e0e862977a6436b3cc420~ZuDbUBd7H2140421404epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610520887;
        bh=zWXBIIAXQJNXur5seyEPbGyVF5FgrOOYhvfIEgU2lFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qX7Ibx0wGd8aE0IUPQ6PeBnQmYbBsVrZDrVhkniz3Ceeo5ID2YzkfNmlz5Q8fvNZ6
         sJmYpKneVyeswB1gHKFIxvbZxkX/tqTRPX0Y+NrqCdSI8m2DhsEBmoQqnubyZUkjwn
         lG8j5fALlkEF0//hpdpVhEPyQXIVA5DmTQuoa0BE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210113065446epcas1p3ff93c64b760fcb09c2fe9cb9cc40d5b5~ZuDauUu3H0235302353epcas1p3V;
        Wed, 13 Jan 2021 06:54:46 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.164]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4DFyqT0B3Vz4x9Q3; Wed, 13 Jan
        2021 06:54:45 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.53.63458.4399EFF5; Wed, 13 Jan 2021 15:54:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210113065444epcas1p4b8ee3edb314a06b1a9f92fd0e38ca856~ZuDYXozSv1980219802epcas1p4Q;
        Wed, 13 Jan 2021 06:54:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210113065444epsmtrp2ebf5f8b6db6f2379a06111de2f1d7113~ZuDYWwmXB2869128691epsmtrp2N;
        Wed, 13 Jan 2021 06:54:44 +0000 (GMT)
X-AuditID: b6c32a36-6c9ff7000000f7e2-27-5ffe9934fbc0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.0F.13470.4399EFF5; Wed, 13 Jan 2021 15:54:44 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210113065444epsmtip10130def02eda1c35f866b5b203a49c47~ZuDYKuFJI0749307493epsmtip1U;
        Wed, 13 Jan 2021 06:54:44 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     damien.lemoal@wdc.com
Cc:     Johannes.Thumshirn@wdc.com, axboe@kernel.dk,
        jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mj0123.lee@samsung.com, nanich.lee@samsung.com,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        tj@kernel.org, woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: Re: [PATCH] bio: limit bio max size.
Date:   Wed, 13 Jan 2021 15:39:36 +0900
Message-Id: <20210113063936.4189-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <CH2PR04MB6522091DE371F5EB7EE98200E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmnq7JzH/xBm/mWFisvtvPZtHa/o3J
        oudJE6vF3657TBZfHxZb7L2lbXF51xw2i+mb5zBbXLt/ht3i3MlPrBbzHjtY/Fp+lNHi1I7J
        zBbr9/5kc+DzuHy21GPTqk42j74tqxg9Pm+S82g/0M0UwBqVY5ORmpiSWqSQmpecn5KZl26r
        5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdKWSQlliTilQKCCxuFhJ386mKL+0JFUh
        I7+4xFYptSAlp8DQoECvODG3uDQvXS85P9fK0MDAyBSoMiEnY+qK9ywF9+0qXpz6y9rAuNuo
        i5GTQ0LAROJF20Y2EFtIYAejxNSrXl2MXED2J0aJN/tuMUM43xglnvY3M8F0POz8yAjRsZdR
        4vAHqKLPjBLnXjawgiTYBHQk+t7eAhsrIiApcerlFzaQImaBc0wSR9c/ASsSFjCUOH98P1gR
        i4CqxP9XK5lBbF4BK4mn29rYIbbJSzztXQ4W5xSIlZiyYB8rRI2gxMmZT1hAbGagmuats8Gu
        kBCYySHRfXg5G0Szi8S9/UdZIGxhiVfHt0ANlZL4/G4vG0RDN6NEc9t8RghnAqPEkufLoB41
        lvj0+TNQggNohabE+l36EGFFiZ2/5zJCbOaTePe1hxWkREKAV6KjTQiiREXiTMt9Zphdz9fu
        hJroITFnzQVWSHBtYJRYveoI4wRGhVlIHpqF5KFZCJsXMDKvYhRLLSjOTU8tNiwwQo7jTYzg
        hKtltoNx0tsPeocYmTgYDzFKcDArifAWdf+NF+JNSaysSi3Kjy8qzUktPsRoCgzuicxSosn5
        wJSfVxJvaGpkbGxsYWJmbmZqrCTOm2jwIF5IID2xJDU7NbUgtQimj4mDU6qBqT9h3aP62C8l
        sle6AxY1hDIq5eo6prkwz2X8L++dxTvxjM7l2Ywbl8RO1ZX7l8wQ+D/3wo41cUzL7r07l6/6
        yu9en8MyJhFlxcTaKxtdH57e6vv4ov38p+L2vE/cYgUmTlpxfuVywV8SBxZeZprAr/ZzUfnH
        L28/SRmrSjycleU2/2TaTVGueVkOW2+JGrIXuYQfji9q01r4Jri7RNkq7NKnJIXiK2d91yYk
        Gb6sECifxL/fUj479xfjHP+iH3GuPXuYZXsi/998dsnq94Ta1dOUOqd7vfaoFN/5OFh5buPx
        e8HLT7ZLWDzUCbFctXX9Em+Jd6lSTm+n/8vuPO8asv2mZOGh7YvPCZ7YMCF7phJLcUaioRZz
        UXEiADVwi3tBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnK7JzH/xBru3cVisvtvPZtHa/o3J
        oudJE6vF3657TBZfHxZb7L2lbXF51xw2i+mb5zBbXLt/ht3i3MlPrBbzHjtY/Fp+lNHi1I7J
        zBbr9/5kc+DzuHy21GPTqk42j74tqxg9Pm+S82g/0M0UwBrFZZOSmpNZllqkb5fAlTF1xXuW
        gvt2FS9O/WVtYNxt1MXIySEhYCLxsPMjYxcjF4eQwG5GieuPTrNDJKQkjp94y9rFyAFkC0sc
        PlwMEhYS+MgocaYpA8RmE9CR6Ht7iw3EFhGQlDj18gsbyBxmgTtMEhsmrmMFSQgLGEqcP74f
        rIhFQFXi/6uVzCA2r4CVxNNtbVC75CWe9i4Hi3MKxEpMWbCPFWJZjMTOvZtZIeoFJU7OfMIC
        YjMD1Tdvnc08gVFgFpLULCSpBYxMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgmNC
        S3MH4/ZVH/QOMTJxMB5ilOBgVhLhLer+Gy/Em5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXgh
        gfTEktTs1NSC1CKYLBMHp1QD04SrYdnfMmznHYlcoCP9zUVToN3wwganpuY6heYSA6PYMP2O
        7jzd9LTX55/NstnxaKKd+UtmZyO7/s6y7YHBV31Dpav+N/f5fnp3i/vb1wnu3fpzqj8bzmLn
        zBfaaLhhb99ZtaupRanTElMN55jxGP5JaplhLpB0eV6uVLWJc0Tyww9vw5atKmn+mdGwqtdy
        Q7/79baiWaKlGRn9p69pfNq7Yl5Y+4slU/X7hUPla0sNOQp4tq64t0Lg+wGBpvxVi8QaNOSV
        3HPm9RzWEikQczsbm/Rid1qNXN/rds/iwp9soudWTWdu+zPbtenMzi8i97a/MN980Tfxmdmi
        k/1WZrpuy36dOOj8Y9eqpn1KLMUZiYZazEXFiQCnu7V6+AIAAA==
X-CMS-MailID: 20210113065444epcas1p4b8ee3edb314a06b1a9f92fd0e38ca856
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210113065444epcas1p4b8ee3edb314a06b1a9f92fd0e38ca856
References: <CH2PR04MB6522091DE371F5EB7EE98200E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
        <CGME20210113065444epcas1p4b8ee3edb314a06b1a9f92fd0e38ca856@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>On 2021/01/13 13:01, Changheun Lee wrote:
>>> On 2021/01/12 21:14, Changheun Lee wrote:
>>>>> On 2021/01/12 17:52, Changheun Lee wrote:
>>>>>> From: "Changheun Lee" <nanich.lee@samsung.com>
>>>>>>
>>>>>> bio size can grow up to 4GB when muli-page bvec is enabled.
>>>>>> but sometimes it would lead to inefficient behaviors.
>>>>>> in case of large chunk direct I/O, - 64MB chunk read in user space -
>>>>>> all pages for 64MB would be merged to a bio structure if memory address is
>>>>>> continued phsycally. it makes some delay to submit until merge complete.
>>>>>> bio max size should be limited as a proper size.
>>>>>
>>>>> But merging physically contiguous pages into the same bvec + later automatic bio
>>>>> split on submit should give you better throughput for large IOs compared to
>>>>> having to issue a bio chain of smaller BIOs that are arbitrarily sized and will
>>>>> likely need splitting anyway (because of DMA boundaries etc).
>>>>>
>>>>> Do you have a specific case where you see higher performance with this patch
>>>>> applied ? On Intel, BIO_MAX_SIZE would be 1MB... That is arbitrary and too small
>>>>> considering that many hardware can execute larger IOs than that.
>>>>>
>>>>
>>>> When I tested 32MB chunk read with O_DIRECT in android, all pages of 32MB
>>>> is merged into a bio structure.
>>>> And elapsed time to merge complete was about 2ms.
>>>> It means first bio-submit is after 2ms.
>>>> If bio size is limited with 1MB with this patch, first bio-submit is about
>>>> 100us by bio_full operation.
>>>
>>> bio_submit() will split the large BIO case into multiple requests while the
>>> small BIO case will likely result one or two requests only. That likely explain
>>> the time difference here. However, for the large case, the 2ms will issue ALL
>>> requests needed for processing the entire 32MB user IO while the 1MB bio case
>>> will need 32 different bio_submit() calls. So what is the actual total latency
>>> difference for the entire 32MB user IO ? That is I think what needs to be
>>> compared here.
>>>
>>> Also, what is your device max_sectors_kb and max queue depth ?
>>>
>> 
>> 32MB total latency is about 19ms including merge time without this patch.
>> But with this patch, total latency is about 17ms including merge time too.
>> Actually 32MB read time from device is same - about 16.7ms - in driver layer.
>> No need to hold more I/O than max_sectors_kb during bio merge.
>> My device is UFS. and max_sectors_kb is 1MB, queue depth is 32.
>
>This may be due to the CPU being slow: it takes time to build the 32MB BIO,
>during which the device is idling. With the 1MB BIO limit, the first BIO hits
>the drive much more quickly, reducing idle time of the device and leading to
>higher throughput. But there are 31 more BIOs to build and issue after the first
>one... That does create a pipeline of requests keeping the device busy, but that
>also likely keeps your CPU a lot more busy building these additional BIOs.
>Overall, do you see a difference in CPU load for the 32MB BIO case vs the 1MB
>max BIO case ? Any increase in CPU load with the lower BIO size limit ?
>

CPU load is more than 32MB bio size. Because bio_sumbit progress is doing in parallel.
But I tested it same CPU operation frequency, So there are no difference of CPU speed.
Logically, bio max size is 4GB now. it's not realistic I know, but 4GB merge to a bio
will takes much time even if CPU works fast.
This is why I think bio max size should be limited.

>> 
>>>> It's not large delay and can't be observed with low speed device.
>>>> But it's needed to reduce merge delay for high speed device.
>>>> I improved 512MB sequential read performance from 1900MB/s to 2000MB/s
>>>> with this patch on android platform.
>>>> As you said, 1MB might be small for some device.
>>>> But method is needed to re-size, or select the bio max size.
>>>
>>> At the very least, I think that such limit should not be arbitrary as your patch
>>> proposes but rely on the device characteristics (e.g.
>>> max_hw_sectors_kb/max_sectors_kb and queue depth).
>>>
>> 
>> I agree with your opinion, I thought same as your idea. For that, deep research
>> is needed, proper timing to set and bio structure modification, etc ...
>
>Why would you need any BIO structure modifications ? Your patch is on the right
>track if limiting the BIO size is the right solution (I am not still completely
>convinced). E.g., the code:
>
>if (page_is_mergeable(bv, page, len, off, same_page)) {
>if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len) {
>*same_page = false;
>return false;
>}
>
>could just become:
>
>if (page_is_mergeable(bv, page, len, off, same_page)) {
>if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {
>*same_page = false;
>return false;
>}
>
>With bio_max_size() being something like:
>
>static inline size_t bio_max_size(struct bio *bio)
>{
>sector_t max_sectors = blk_queue_get_max_sectors(bio->bi_disk->queue,
>bio_op(bio));
>
>return max_sectors << SECTOR_SHIFT;
>}
>
>Note that this is not super efficient as a BIO maximum size depends on the BIO
>offset too (its start sector). So writing something similar to
>blk_rq_get_max_sectors() would probably be better.

Good suggestion. :)

>
>> Current is simple patch for default bio max size.
>> Before applying of multipage bvec, bio max size was 1MB in kernel 4.x by BIO_MAX_PAGES.
>> So I think 1MB bio max size is reasonable as a default.
>
>max_sectors_kb is always defined for any block device so I do not think there is
>a need for any arbitrary default value.
>
>Since such optimization likely very much depend on the speed of the system CPU
>and of the storage device used, it may be a good idea to have this configurable
>through sysfs. That is, bio_max_size() simply returns UINT_MAX leading to no
>change from the current behavior if the optimization is disabled (default) and
>max_sectors_kb if it is enabled.
>

OK, I agree with you. It will be best for all now.
I'll try to make this.

>> 
>>>>
>>>>>
>>>>>>
>>>>>> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
>>>>>> ---
>>>>>>  block/bio.c         | 2 +-
>>>>>>  include/linux/bio.h | 3 ++-
>>>>>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/block/bio.c b/block/bio.c
>>>>>> index 1f2cc1fbe283..dbe14d675f28 100644
>>>>>> --- a/block/bio.c
>>>>>> +++ b/block/bio.c
>>>>>> @@ -877,7 +877,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
>>>>>>  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
>>>>>>  
>>>>>>  		if (page_is_mergeable(bv, page, len, off, same_page)) {
>>>>>> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
>>>>>> +			if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len) {
>>>>>>  				*same_page = false;
>>>>>>  				return false;
>>>>>>  			}
>>>>>> diff --git a/include/linux/bio.h b/include/linux/bio.h
>>>>>> index 1edda614f7ce..0f49b354b1f6 100644
>>>>>> --- a/include/linux/bio.h
>>>>>> +++ b/include/linux/bio.h
>>>>>> @@ -20,6 +20,7 @@
>>>>>>  #endif
>>>>>>  
>>>>>>  #define BIO_MAX_PAGES		256
>>>>>> +#define BIO_MAX_SIZE		(BIO_MAX_PAGES * PAGE_SIZE)
>>>>>>  
>>>>>>  #define bio_prio(bio)			(bio)->bi_ioprio
>>>>>>  #define bio_set_prio(bio, prio)		((bio)->bi_ioprio = prio)
>>>>>> @@ -113,7 +114,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
>>>>>>  	if (bio->bi_vcnt >= bio->bi_max_vecs)
>>>>>>  		return true;
>>>>>>  
>>>>>> -	if (bio->bi_iter.bi_size > UINT_MAX - len)
>>>>>> +	if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len)
>>>>>>  		return true;
>>>>>>  
>>>>>>  	return false;
>>>>>>
>>>>>
>>>>>
>>>>> -- 
>>>>> Damien Le Moal
>>>>> Western Digital Research
>>>>
>>>
>>>
>>> -- 
>>> Damien Le Moal
>>> Western Digital Research
>>>
>> 
>> ---
>> Changheun Lee
>> Samsung Electronics
>> 
>> 
>
>
>-- 
>Damien Le Moal
>Western Digital Research
>

---
Changheun Lee
Samsung Electronics

