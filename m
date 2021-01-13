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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDBAC433E0
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 04:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF57B2312E
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 04:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbhAMECe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 23:02:34 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:10797 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbhAMECc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 23:02:32 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210113040150epoutp0450b82d9e750b938160e696faf1803808~Zrsa4_fwV1403514035epoutp04U
        for <linux-block@vger.kernel.org>; Wed, 13 Jan 2021 04:01:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210113040150epoutp0450b82d9e750b938160e696faf1803808~Zrsa4_fwV1403514035epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610510510;
        bh=VIxUrzTKhnvccK/onLUwZD5UiGdrKREn4EwdF+BvVsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cSFKafnrHk4CbJ7dDKCOnRLSO+oaK/Iy4kIYGjaC7mdhUoZYBq5eGyxjVJWJE60+j
         ZfWuksIrKhoPb1YdWAcOzbwa8milpxi645K+sKhfVIL3CgamDEWSG3jRpywEYcHrbw
         Iy3RIIeqAdzBpR1vdUTbN68XsG2dnokgTKw0N3r4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210113040148epcas1p2bcf737fc903dec87166c92277ce74e28~ZrsZRZcNs1933319333epcas1p2V;
        Wed, 13 Jan 2021 04:01:48 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.164]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DFtzv1MBnz4x9Q5; Wed, 13 Jan
        2021 04:01:47 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.99.02418.BA07EFF5; Wed, 13 Jan 2021 13:01:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210113040146epcas1p230596c7c3760471dca442d1f7ce4dc55~ZrsXZaHkl1710017100epcas1p2p;
        Wed, 13 Jan 2021 04:01:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210113040146epsmtrp29ce2847c5beead1becfd772b427467c6~ZrsXYW4KU1299012990epsmtrp2M;
        Wed, 13 Jan 2021 04:01:46 +0000 (GMT)
X-AuditID: b6c32a35-c23ff70000010972-46-5ffe70ab143e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.B3.13470.AA07EFF5; Wed, 13 Jan 2021 13:01:46 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210113040146epsmtip23fae37dc9881f478a8d7d7049c8e0535~ZrsXKOAYS3256232562epsmtip2C;
        Wed, 13 Jan 2021 04:01:46 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     damien.lemoal@wdc.com
Cc:     Johannes.Thumshirn@wdc.com, axboe@kernel.dk,
        jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mj0123.lee@samsung.com, nanich.lee@samsung.com,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        tj@kernel.org, yt0928.kim@samsung.com, woosung2.lee@samsung.com
Subject: Re: Re: [PATCH] bio: limit bio max size.
Date:   Wed, 13 Jan 2021 12:46:37 +0900
Message-Id: <20210113034637.1382-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <CH2PR04MB65225EDDA7069CCD47A459A5E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmvu7qgn/xBneWs1msvtvPZtHa/o3J
        oudJE6vF3657TBZfHxZb7L2lbXF51xw2i+mb5zBbXLt/ht3i3MlPrBbzHjtY/Fp+lNHi1I7J
        zBbr9/5kc+DzuHy21GPTqk42j74tqxg9Pm+S82g/0M0UwBqVY5ORmpiSWqSQmpecn5KZl26r
        5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdKWSQlliTilQKCCxuFhJ386mKL+0JFUh
        I7+4xFYptSAlp8DQoECvODG3uDQvXS85P9fK0MDAyBSoMiEn4+XcTUwFM9Urem5NZ25g3Cbf
        xcjJISFgIvHvzBkmEFtIYAejxNp9HhD2J0aJbVclIOxvjBLTu21g6h9dec7WxcgFFN/LKDHz
        wmpmiKLPjBKX12qC2GwCOhJ9b2+xgdgiApISp15+AWtgFjjHJPFizT0WkISwgKHE+eP7wYpY
        BFQlbi0+ywpi8wpYSbzru8QEsU1e4mnvcqAFHBycArESdzdFQpQISpyc+QRsDDNQSfPW2cwg
        8yUEZnJIPH3Rww7R6yKxY/8uZghbWOLV8S1QcSmJz+/2skE0dDNKNLfNZ4RwJjBKLHm+DGqz
        scSnz58ZQTYzC2hKrN+lDxFWlNj5ey4jxGY+iXdfe1hBSiQEeCU62oQgSlQkzrTcZ4bZ9Xzt
        TqiJHhIvrp5jh4TcBkaJv3++sk5gVJiF5KFZSB6ahbB5ASPzKkax1ILi3PTUYsMCQ+QI3sQI
        TrVapjsYJ779oHeIkYmD8RCjBAezkghvUfffeCHelMTKqtSi/Pii0pzU4kOMpsDQnsgsJZqc
        D0z2eSXxhqZGxsbGFiZm5mamxkrivEkGD+KFBNITS1KzU1MLUotg+pg4OKUamFSCxO5zRF4P
        ChNXc5e31izIyzwfdWdB35/nuW/svb1sf7FIn1v5NXFCY9Lr6bkGJQ8Lp79NaF+g0pC+enJb
        0fK7MbHrJ0QdemvD5Wbx9r3X/yOp/WpLIw637pryRnlliuKEs3ZPy23qeHOWVaSoveSr73ew
        jHP8+WDrh2vB2fxy/zYyRec+8t3I8Lr1YvjHZ8Hbi0XvOZccfJliVqN10aLZv7fgm4beIZ32
        hD62A+9/hW2/eOtSwsu1C5bEiylM7vq6NYrD7oHeL53Qz9GVLra3i7+Hnd9S0PnpW5bqBqV4
        zp8NNZuefoqbdfHBPMmDE6SrU8L3/z/HP7sj6ewxl2f1c39bvdJcOlXr/JwFZ5VYijMSDbWY
        i4oTAX54FDM+BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvO6qgn/xBjvWS1usvtvPZtHa/o3J
        oudJE6vF3657TBZfHxZb7L2lbXF51xw2i+mb5zBbXLt/ht3i3MlPrBbzHjtY/Fp+lNHi1I7J
        zBbr9/5kc+DzuHy21GPTqk42j74tqxg9Pm+S82g/0M0UwBrFZZOSmpNZllqkb5fAlfFy7iam
        gpnqFT23pjM3MG6T72Lk5JAQMJF4dOU5WxcjF4eQwG5GiVVX3rFAJKQkjp94y9rFyAFkC0sc
        PlwMUfORUeL2vzNsIDVsAjoSfW9vgdkiApISp15+ARvELHCHSWJR501mkISwgKHE+eP7wYpY
        BFQlbi0+ywpi8wpYSbzru8QEsUxe4mnvcmaQZZwCsRJ3N0WChIUEYiS+r5rCDlEuKHFy5hOw
        25iBypu3zmaewCgwC0lqFpLUAkamVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwTGh
        pbmDcfuqD3qHGJk4GA8xSnAwK4nwFnX/jRfiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQ
        QHpiSWp2ampBahFMlomDU6qBSZdZe/tySfc242ylbfkT/HgvyyY1iHy/4JUo9Wft4yjJt9Mu
        K0+fODXw2KtDRqfU12Xqrl4t7Ch9esqm2XePz7WsNuewnpQXx1diOlU64Nwy1orcC9d/L7NK
        YS1T3ZwpLue81jjEt9A1vML0PFvqvCfhTCJNoSqpgUWfOxqKWI45VuRmz9DQ80ljVDi7bklE
        ywWdz5x7t8a/OhL21LqOZ9Xiky/X8F9/ektf6aJH3nFF90Y256Cbi4JUc8pjZq6bNP+JvMuO
        FSpW0kqmf/d9SInc4Rut6F8wed7yEgsfkxi+401qrvKV+8NMVWovadl5m/+6zaRR8uyImLfX
        7rLF/rkz+5yEvkyQlLBesFuJpTgj0VCLuag4EQDvCtIe+AIAAA==
X-CMS-MailID: 20210113040146epcas1p230596c7c3760471dca442d1f7ce4dc55
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210113040146epcas1p230596c7c3760471dca442d1f7ce4dc55
References: <CH2PR04MB65225EDDA7069CCD47A459A5E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
        <CGME20210113040146epcas1p230596c7c3760471dca442d1f7ce4dc55@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>On 2021/01/12 21:14, Changheun Lee wrote:
>>> On 2021/01/12 17:52, Changheun Lee wrote:
>>>> From: "Changheun Lee" <nanich.lee@samsung.com>
>>>>
>>>> bio size can grow up to 4GB when muli-page bvec is enabled.
>>>> but sometimes it would lead to inefficient behaviors.
>>>> in case of large chunk direct I/O, - 64MB chunk read in user space -
>>>> all pages for 64MB would be merged to a bio structure if memory address is
>>>> continued phsycally. it makes some delay to submit until merge complete.
>>>> bio max size should be limited as a proper size.
>>>
>>> But merging physically contiguous pages into the same bvec + later automatic bio
>>> split on submit should give you better throughput for large IOs compared to
>>> having to issue a bio chain of smaller BIOs that are arbitrarily sized and will
>>> likely need splitting anyway (because of DMA boundaries etc).
>>>
>>> Do you have a specific case where you see higher performance with this patch
>>> applied ? On Intel, BIO_MAX_SIZE would be 1MB... That is arbitrary and too small
>>> considering that many hardware can execute larger IOs than that.
>>>
>> 
>> When I tested 32MB chunk read with O_DIRECT in android, all pages of 32MB
>> is merged into a bio structure.
>> And elapsed time to merge complete was about 2ms.
>> It means first bio-submit is after 2ms.
>> If bio size is limited with 1MB with this patch, first bio-submit is about
>> 100us by bio_full operation.
>
>bio_submit() will split the large BIO case into multiple requests while the
>small BIO case will likely result one or two requests only. That likely explain
>the time difference here. However, for the large case, the 2ms will issue ALL
>requests needed for processing the entire 32MB user IO while the 1MB bio case
>will need 32 different bio_submit() calls. So what is the actual total latency
>difference for the entire 32MB user IO ? That is I think what needs to be
>compared here.
>
>Also, what is your device max_sectors_kb and max queue depth ?
>

32MB total latency is about 19ms including merge time without this patch.
But with this patch, total latency is about 17ms including merge time too.
Actually 32MB read time from device is same - about 16.7ms - in driver layer.
No need to hold more I/O than max_sectors_kb during bio merge.
My device is UFS. and max_sectors_kb is 1MB, queue depth is 32.

>> It's not large delay and can't be observed with low speed device.
>> But it's needed to reduce merge delay for high speed device.
>> I improved 512MB sequential read performance from 1900MB/s to 2000MB/s
>> with this patch on android platform.
>> As you said, 1MB might be small for some device.
>> But method is needed to re-size, or select the bio max size.
>
>At the very least, I think that such limit should not be arbitrary as your patch
>proposes but rely on the device characteristics (e.g.
>max_hw_sectors_kb/max_sectors_kb and queue depth).
>

I agree with your opinion, I thought same as your idea. For that, deep research
is needed, proper timing to set and bio structure modification, etc ...
Current is simple patch for default bio max size.
Before applying of multipage bvec, bio max size was 1MB in kernel 4.x by BIO_MAX_PAGES.
So I think 1MB bio max size is reasonable as a default.

>> 
>>>
>>>>
>>>> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
>>>> ---
>>>>  block/bio.c         | 2 +-
>>>>  include/linux/bio.h | 3 ++-
>>>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/block/bio.c b/block/bio.c
>>>> index 1f2cc1fbe283..dbe14d675f28 100644
>>>> --- a/block/bio.c
>>>> +++ b/block/bio.c
>>>> @@ -877,7 +877,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
>>>>  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
>>>>  
>>>>  		if (page_is_mergeable(bv, page, len, off, same_page)) {
>>>> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {
>>>> +			if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len) {
>>>>  				*same_page = false;
>>>>  				return false;
>>>>  			}
>>>> diff --git a/include/linux/bio.h b/include/linux/bio.h
>>>> index 1edda614f7ce..0f49b354b1f6 100644
>>>> --- a/include/linux/bio.h
>>>> +++ b/include/linux/bio.h
>>>> @@ -20,6 +20,7 @@
>>>>  #endif
>>>>  
>>>>  #define BIO_MAX_PAGES		256
>>>> +#define BIO_MAX_SIZE		(BIO_MAX_PAGES * PAGE_SIZE)
>>>>  
>>>>  #define bio_prio(bio)			(bio)->bi_ioprio
>>>>  #define bio_set_prio(bio, prio)		((bio)->bi_ioprio = prio)
>>>> @@ -113,7 +114,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
>>>>  	if (bio->bi_vcnt >= bio->bi_max_vecs)
>>>>  		return true;
>>>>  
>>>> -	if (bio->bi_iter.bi_size > UINT_MAX - len)
>>>> +	if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len)
>>>>  		return true;
>>>>  
>>>>  	return false;
>>>>
>>>
>>>
>>> -- 
>>> Damien Le Moal
>>> Western Digital Research
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

