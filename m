Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1359C433DB
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 12:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 760A023109
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 12:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbhALMOo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 07:14:44 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:57092 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732744AbhALMOn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 07:14:43 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210112121359epoutp02ecc8228d5f32c5b706b4690d0dde8c1a~Zew14n5tH3096830968epoutp02h
        for <linux-block@vger.kernel.org>; Tue, 12 Jan 2021 12:13:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210112121359epoutp02ecc8228d5f32c5b706b4690d0dde8c1a~Zew14n5tH3096830968epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610453639;
        bh=T6hBGVL8Nc7dnYMEcTZfUcdEeuqzjalUKBYfIb234L0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rW8kR1nwpAEgqT56G4fhHrj6/ibJokd1N3TBpw+oAvXY3AHz4JhhxhqJUgtCMaC6m
         89nea9W3wFCA1v6B/GVS7OrMdX1rdxDcFi8bAjKTyjpInGs/ohyaSVsu7AwhowNLNR
         atibC+fNZXhSTkV0JRiEux/QcHcUStT1ZOXmSoo4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210112121358epcas1p33e4c178b5e8ce163996d964e0e06ef03~Zew1BEYv31079310793epcas1p3V;
        Tue, 12 Jan 2021 12:13:58 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.160]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4DFTyF27bwz4x9Pr; Tue, 12 Jan
        2021 12:13:57 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.86.09577.5829DFF5; Tue, 12 Jan 2021 21:13:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210112121356epcas1p124baa93f10eb3400539ba4db27c18955~Zewyx_Q_11418914189epcas1p1D;
        Tue, 12 Jan 2021 12:13:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210112121356epsmtrp1c45d7090c900448c51e2c13c843ecdb6~Zewyt1Uvq2474724747epsmtrp1E;
        Tue, 12 Jan 2021 12:13:56 +0000 (GMT)
X-AuditID: b6c32a39-c13ff70000002569-87-5ffd92852d35
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.61.13470.3829DFF5; Tue, 12 Jan 2021 21:13:56 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210112121355epsmtip192cfb07e97ab9d8e12afad9d24e23ed3~Zewyf_NiH2401824018epsmtip1N;
        Tue, 12 Jan 2021 12:13:55 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     damien.lemoal@wdc.com
Cc:     Johannes.Thumshirn@wdc.com, axboe@kernel.dk,
        jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mj0123.lee@samsung.com, nanich.lee@samsung.com,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        tj@kernel.org, yt0928.kim@samsung.com
Subject: Re: Re: [PATCH] bio: limit bio max size. 
Date:   Tue, 12 Jan 2021 20:58:46 +0900
Message-Id: <20210112115846.31415-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <BL0PR04MB6514F7F944D70DE024494544E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmrm7rpL/xBv8Wc1isvtvPZtHa/o3J
        oudJE6vF3657TBZfHxZb7L2lbXF51xw2i+mb5zBbXLt/ht3i3MlPrBbzHjtY/Fp+lNFi/d6f
        bA68HpfPlnpsWtXJ5tG3ZRWjx+dNch7tB7qZAlijcmwyUhNTUosUUvOS81My89JtlbyD453j
        Tc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgA5UUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gq
        pRak5BQYGhToFSfmFpfmpesl5+daGRoYGJkCVSbkZGw/u4+54K9ExYufc9kbGL8LdzFyckgI
        mEicurKQsYuRi0NIYAejxOEL3VDOJ0aJto5GZgjnG6PE31Oz2GBapk6+xg6R2Mso0Xi6jwXC
        +cwosWbZNLAqNgEdib63t8BsEQFJiVMvv7CBFDELbGKSONe7BWgJB4ewgJHEl3klICaLgKrE
        sYfiIOW8AtYSXz+eYoZYJi/xtHc5mM0pECuxbFEvM0SNoMTJmU9YQGxmoJrmrbPBLpUQmMgh
        seH9L0aIZheJN3dALgWxhSVeHd8CZUtJvOxvY4do6GaUaG6bzwjhTGCUWPJ8GRNElbHEp8+f
        wQ5lFtCUWL9LHyKsKLHz91xGiM18Eu++9rCClEgI8Ep0tAlBlKhInGm5zwyz6/nanVATPSTe
        rr8EDd8NjBLnr25lm8CoMAvJQ7OQPDQLYfMCRuZVjGKpBcW56anFhgWmyHG8iRGcZrUsdzBO
        f/tB7xAjEwfjIUYJDmYlEd6i7r/xQrwpiZVVqUX58UWlOanFhxhNgaE9kVlKNDkfmOjzSuIN
        TY2MjY0tTMzMzUyNlcR5kwwexAsJpCeWpGanphakFsH0MXFwSjUw9Z7PzH9wZ0O+it72S4ba
        /3fMKfnfc4Vzh36s02+zo7/bX83726p0OnRjlO2nZMP9K7IMtMUDbk6cbDPXt1rQZpHAvcpc
        b0YT9r4pd/bxM7zgn1kcJZnwnLmo9PGMwIeuL+VeqW9hypuaY/PrmPF3e4eQeW+Pd9pb/7px
        52y9X7lEeKr+knTNC2zPzmfLnJ25UemsUN8vQ9dL3EuP59+SXWfywOprwaXbCjMS3vWm1WhN
        2R3Mu+VV2cbz2zMerPzLI/zu2c1vnQqZDRqcW3pZ9x9n/mPyXvdbv21EySftNztWnugWCk59
        udxkSdvfZ1LRmrdnH8tn6Hl+VJKZbX97fFyyy9KELB022xhd/WkvlViKMxINtZiLihMBfxhZ
        VzwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnG7LpL/xBrNmMlmsvtvPZtHa/o3J
        oudJE6vF3657TBZfHxZb7L2lbXF51xw2i+mb5zBbXLt/ht3i3MlPrBbzHjtY/Fp+lNFi/d6f
        bA68HpfPlnpsWtXJ5tG3ZRWjx+dNch7tB7qZAlijuGxSUnMyy1KL9O0SuDK2n93HXPBXouLF
        z7nsDYzfhbsYOTkkBEwkpk6+xt7FyMUhJLCbUeJM5xZmiISUxPETb1m7GDmAbGGJw4eLIWo+
        Mko0P5kHVsMmoCPR9/YWG4gtIiApcerlFzaQImaBA0wS0y59YAFpFhYwkvgyrwTEZBFQlTj2
        UByknFfAWuLrx1NQq+QlnvYuB7M5BWIlli3qBbOFBGIkll2eyAZRLyhxcuYTFhCbGai+eets
        5gmMArOQpGYhSS1gZFrFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcB1qaOxi3r/qg
        d4iRiYPxEKMEB7OSCG9R9994Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqem
        FqQWwWSZODilGphOztoo9TJ6/4Wu2t0vPgqryk86skgss3ZmpWCV9MmLe3+s/vzbXu99+rx1
        OqHbJN83Xc7lMHyT7rqfQ+pSxbzwWvY7dY+UEmZHxxzO7X/9INnyhP3ivYcSg1m4ZxU27cpY
        5cWr3FZY5/Bxyezg2xL9NpxXOn4eLapcM+tq1SL/xV0yD4t8Hfrjyiz46tVT+c3X2v8L6Xqs
        V6nwd1698lv9kNitqnXff25jvfxGKenQcfXtx8UWxstH+JjUrvF/npxp+a5pqpyIcIvXkcUq
        rHfWCfqtMjDPzM5+cPvA28sLIhOu//TdI7d4kWaV2Tz/wrMti263tTctaT/QVFZbFtK8y8T4
        xRPTt1nKXz8c6VZiKc5INNRiLipOBABcEUlw8gIAAA==
X-CMS-MailID: 20210112121356epcas1p124baa93f10eb3400539ba4db27c18955
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210112121356epcas1p124baa93f10eb3400539ba4db27c18955
References: <BL0PR04MB6514F7F944D70DE024494544E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
        <CGME20210112121356epcas1p124baa93f10eb3400539ba4db27c18955@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>On 2021/01/12 17:52, Changheun Lee wrote:
>> From: "Changheun Lee" <nanich.lee@samsung.com>
>> 
>> bio size can grow up to 4GB when muli-page bvec is enabled.
>> but sometimes it would lead to inefficient behaviors.
>> in case of large chunk direct I/O, - 64MB chunk read in user space -
>> all pages for 64MB would be merged to a bio structure if memory address is
>> continued phsycally. it makes some delay to submit until merge complete.
>> bio max size should be limited as a proper size.
>
>But merging physically contiguous pages into the same bvec + later automatic bio
>split on submit should give you better throughput for large IOs compared to
>having to issue a bio chain of smaller BIOs that are arbitrarily sized and will
>likely need splitting anyway (because of DMA boundaries etc).
>
>Do you have a specific case where you see higher performance with this patch
>applied ? On Intel, BIO_MAX_SIZE would be 1MB... That is arbitrary and too small
>considering that many hardware can execute larger IOs than that.
>

When I tested 32MB chunk read with O_DIRECT in android, all pages of 32MB
is merged into a bio structure.
And elapsed time to merge complete was about 2ms.
It means first bio-submit is after 2ms.
If bio size is limited with 1MB with this patch, first bio-submit is about
100us by bio_full operation.
It's not large delay and can't be observed with low speed device.
But it's needed to reduce merge delay for high speed device.
I improved 512MB sequential read performance from 1900MB/s to 2000MB/s
with this patch on android platform.
As you said, 1MB might be small for some device.
But method is needed to re-size, or select the bio max size.

>
>> 
>> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
>> ---
>>  block/bio.c         | 2 +-
>>  include/linux/bio.h | 3 ++-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/block/bio.c b/block/bio.c
>> index 1f2cc1fbe283..dbe14d675f28 100644
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -877,7 +877,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
>>  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
>>  
>>  		if (page_is_mergeable(bv, page, len, off, same_page)) {
>> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
>> +			if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len) {
>>  				*same_page = false;
>>  				return false;
>>  			}
>> diff --git a/include/linux/bio.h b/include/linux/bio.h
>> index 1edda614f7ce..0f49b354b1f6 100644
>> --- a/include/linux/bio.h
>> +++ b/include/linux/bio.h
>> @@ -20,6 +20,7 @@
>>  #endif
>>  
>>  #define BIO_MAX_PAGES		256
>> +#define BIO_MAX_SIZE		(BIO_MAX_PAGES * PAGE_SIZE)
>>  
>>  #define bio_prio(bio)			(bio)->bi_ioprio
>>  #define bio_set_prio(bio, prio)		((bio)->bi_ioprio = prio)
>> @@ -113,7 +114,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
>>  	if (bio->bi_vcnt >= bio->bi_max_vecs)
>>  		return true;
>>  
>> -	if (bio->bi_iter.bi_size > UINT_MAX - len)
>> +	if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len)
>>  		return true;
>>  
>>  	return false;
>> 
>
>
>-- 
>Damien Le Moal
>Western Digital Research
