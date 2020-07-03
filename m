Return-Path: <SRS0=jyL6=AO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48D5C433E0
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 06:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2ED6206DF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 06:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cE553Ahj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgGCG4N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:56:13 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:10734 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGCG4N (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jul 2020 02:56:13 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200703065609epoutp0433e790528c19bdc85c5acf80a99618eb~eK7PLX0v91209512095epoutp04p
        for <linux-block@vger.kernel.org>; Fri,  3 Jul 2020 06:56:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200703065609epoutp0433e790528c19bdc85c5acf80a99618eb~eK7PLX0v91209512095epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593759369;
        bh=ROo7i11KpYWLJ6kqhHGPizjWVsVjJXJyibKfvzd4P7Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cE553AhjmHD6QbEwu2vZOxK+bQA17eR6q5zicoAgmo+uMHz7dswymNMwkUvjiAQwZ
         KxFusSPenudHRqFbK86SSCwllVkzHpOf+Ht1boOS8rvP+JEdQr6HvfUBgN+Bu3DpWc
         +0nvS1hf2aPYk/mfpORWAF45uKZM8UJ8/4OC/ldI=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200703065608epcas5p273b533657d979ef5cb05747d4bb825cf~eK7OrFBbz0479804798epcas5p2y;
        Fri,  3 Jul 2020 06:56:08 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.8F.09475.886DEFE5; Fri,  3 Jul 2020 15:56:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200703065608epcas5p12a6f5466826de40ab8ad64fad0fc1017~eK7OGm-6P1304913049epcas5p1j;
        Fri,  3 Jul 2020 06:56:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200703065608epsmtrp175c145dcbc2b1fc43518d473c3883ef3~eK7OF1b0n1275312753epsmtrp1W;
        Fri,  3 Jul 2020 06:56:08 +0000 (GMT)
X-AuditID: b6c32a4b-39fff70000002503-50-5efed6883a3a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.F5.08303.886DEFE5; Fri,  3 Jul 2020 15:56:08 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200703065606epsmtip2a9be46b9668a1ed1a833fd74895e6774~eK7MxLjsk0583205832epsmtip26;
        Fri,  3 Jul 2020 06:56:06 +0000 (GMT)
Date:   Fri, 3 Jul 2020 12:23:11 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, Selvakumar S <selvakuma.s1@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
Subject: Re: [PATCH 2/2] block: enable zone-append for iov_iter of bvec type
Message-ID: <20200703065311.GB26058@test-zns>
MIME-Version: 1.0
In-Reply-To: <CY4PR04MB37516E788EC8804D7DF9780EE76A0@CY4PR04MB3751.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7bCmhm7HtX9xBs9vaFusvtvPZtHa/o3J
        YuXqo0wWj+98ZreYdOgao8XeW9oWl3fNYbPY9ns+s8XrHyfZHDg9Lp8t9di0qpPNY/fNBjaP
        vi2rGD0+b5LzaD/QzRTAFsVlk5Kak1mWWqRvl8CVsa7pL2PBDJmKnosbmBoY54h3MXJySAiY
        SMxYtp8dxBYS2M0o0X9aGML+xChx841pFyMXkP2ZUaJpw3F2mIa/6x8yQyR2MUq8WfOWEcJ5
        xiixemk7WBWLgIrE1cOvmLoYOTjYBDQlLkwuBQmLCGhJLNv3jhWknlngDZNE68FtzCAJYQEf
        iVutfcwg9bwCuhIzWytBwrwCghInZz5hAbE5BWIldv1oAisXFVCWOLDtOBPEQTM5JE52ZIG0
        Sgi4SBy85AURFpZ4dXwL1M1SEi/726DsYolfd46C3S8h0MEocb1hJgtEwl7i4p6/YDOZBTIk
        Niw4zAZh80n0/n7CBDGfV6KjTQiiXFHi3qSnrBC2uMTDGUugbA+JqQsWsUKCZAmTxOPJrxkn
        MMrNQvLOLCQrIGwric4PTayzgFYwC0hLLP/HAWFqSqzfpb+AkXUVo2RqQXFuemqxaYFxXmq5
        XnFibnFpXrpecn7uJkZwEtLy3sH46MEHvUOMTByMhxglOJiVRHgTVP/FCfGmJFZWpRblxxeV
        5qQWH2KU5mBREudV+nEmTkggPbEkNTs1tSC1CCbLxMEp1cBkF+5qb2G4aYuq7L87vn/Orjtu
        5yF14YSqelJdOetvFebtey1O3lr98/2MA0sEnJ/ZpzHc5vm338lq4sVvmZdnRsxbk75MjdXx
        ssWGrrgVJe5sJcI2ZyyZrQQfXOLbtEkzvTpJ4o/NK/P27TEn3e886OuNfn674qLYGe3ZzeFR
        Kp8+MDh41hr77sqy8O+T4Xgu2JV4cbJOx7L2dDONj9cFJ4o8/jWreOkUSbfWyup70Yef8Lwr
        1S/7NT+Zq2BX7iadaRfYcnrr9x1fdEw3ao3Jh4A/B45seMteH5RycObjORbXyn9+62WsO/w1
        +cTiuJa2NRMijj/47aoqENesWqJpHHzho9p3z92bGJtued1SYinOSDTUYi4qTgQAI+72DrED
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSvG7HtX9xBufXsFusvtvPZtHa/o3J
        YuXqo0wWj+98ZreYdOgao8XeW9oWl3fNYbPY9ns+s8XrHyfZHDg9Lp8t9di0qpPNY/fNBjaP
        vi2rGD0+b5LzaD/QzRTAFsVlk5Kak1mWWqRvl8CVceRkE0vBKcmKJSu/sDUwvhDpYuTkkBAw
        kfi7/iFzFyMXh5DADkaJ9ns7mSES4hLN136wQ9jCEiv/PQezhQSeMEr8Op0JYrMIqEhcPfyK
        qYuRg4NNQFPiwuRSkLCIgJbEsn3vWEFmMgu8Y5K4vvAAE0hCWMBH4lZrHzNIPa+ArsTM1kqI
        vUuYJO52fmIBqeEVEJQ4OfMJmM0sYCYxb/NDsHpmAWmJ5f84QMKcArESu340gZ0pKqAscWDb
        caYJjIKzkHTPQtI9C6F7ASPzKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4NjQ0trB
        uGfVB71DjEwcjIcYJTiYlUR4E1T/xQnxpiRWVqUW5ccXleakFh9ilOZgURLn/TprYZyQQHpi
        SWp2ampBahFMlomDU6qBKcMwRLJxqxDbzTfRiQ29H09zV8cXtawRN5/67R1v1hztXD1lz52x
        O3TfiPNxe03p8mDmyrPhOl+26CGjx+rejWuireY0f5KeqDP3ydkH+8xU1C+sq1qz1Lngvajn
        wwCn2xnTJN6c/CY770ZwSIeE2e92k6SZLw8fuCTva8X4ZmrepaZLx8R+XdeYksD+4LbqV+3b
        zxwNIqVzDV+uu2DIJPbYsqv8Ko/h0ou+67oef9h6/H+4VsLuA7ueXLm0JPDRmSmzo66l7l78
        9WtL8U69CZM3Fuy+JLQqru+q4D3FQ4HtU/L+fQvYNuuf1tQdu4LeaOsemTuhxO1PWue2s/XR
        j7KUt2+TjOzKaq9oPaHPkarEUpyRaKjFXFScCABUPctc/AIAAA==
X-CMS-MailID: 20200703065608epcas5p12a6f5466826de40ab8ad64fad0fc1017
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----RtrVgMPcOOSLrhJloRVgptxhQONXYtyOWZJ9JvnugceJtZ1T=_c51a9_"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200702154213epcas5p4e8d42861cb5ae91ddeccf1ed73107304
References: <1593704330-11540-1-git-send-email-joshi.k@samsung.com>
        <CGME20200702154213epcas5p4e8d42861cb5ae91ddeccf1ed73107304@epcas5p4.samsung.com>
        <1593704330-11540-3-git-send-email-joshi.k@samsung.com>
        <CY4PR04MB37516E788EC8804D7DF9780EE76A0@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------RtrVgMPcOOSLrhJloRVgptxhQONXYtyOWZJ9JvnugceJtZ1T=_c51a9_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Jul 03, 2020 at 05:32:56AM +0000, Damien Le Moal wrote:
>On 2020/07/03 0:42, Kanchan Joshi wrote:
>> zone-append with bvec iov_iter gives WARN_ON, and returns -EINVAL.
>> Add new helper to process such iov_iter and add pages in bio honoring
>> zone-append specific constraints.
>>
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>> Signed-off-by: Selvakumar S <selvakuma.s1@samsung.com>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> Signed-off-by: Javier Gonzalez <javier.gonz@samsung.com>
>> ---
>>  block/bio.c | 31 ++++++++++++++++++++++++++++---
>>  1 file changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/bio.c b/block/bio.c
>> index 0cecdbc..ade9da7 100644
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -975,6 +975,30 @@ static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
>>  	iov_iter_advance(iter, size);
>>  	return 0;
>>  }
>> +static int __bio_iov_bvec_append_add_pages(struct bio *bio, struct iov_iter *iter)
>> +{
>> +	const struct bio_vec *bv = iter->bvec;
>> +	unsigned int len;
>> +	size_t size;
>> +	struct request_queue *q = bio->bi_disk->queue;
>> +	unsigned int max_append_sectors = queue_max_zone_append_sectors(q);
>> +	bool same_page = false;
>> +
>> +	if (WARN_ON_ONCE(!max_append_sectors))
>> +		return -EINVAL;
>> +
>> +	if (WARN_ON_ONCE(iter->iov_offset > bv->bv_len))
>> +		return -EINVAL;
>> +
>> +	len = min_t(size_t, bv->bv_len - iter->iov_offset, iter->count);
>> +	size = bio_add_hw_page(q, bio, bv->bv_page, len,
>> +				bv->bv_offset + iter->iov_offset,
>> +				max_append_sectors, &same_page);
>> +	if (unlikely(size != len))
>> +		return -EINVAL;
>> +	iov_iter_advance(iter, size);
>> +	return 0;
>> +}
>>
>>  #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
>>
>> @@ -1105,9 +1129,10 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>>
>>  	do {
>>  		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
>> -			if (WARN_ON_ONCE(is_bvec))
>> -				return -EINVAL;
>> -			ret = __bio_iov_append_get_pages(bio, iter);
>> +			if (is_bvec)
>> +				ret = __bio_iov_bvec_append_add_pages(bio, iter);
>> +			else
>> +				ret = __bio_iov_append_get_pages(bio, iter);
>>  		} else {
>>  			if (is_bvec)
>>  				ret = __bio_iov_bvec_add_pages(bio, iter);
>>
>
>The only user of this function that issues zone append requests is zonefs. The
>issued requests are not using bvec iter but a user direct IO buffer iter. So
>this change would have no user at all as far as I can see. Am I missing
>something ? What IO path makes this change necessary ?

Yes, zonefs does not use bvec iter. But while enabling io-uring path for
zone-append, I hit into this condition returning -EINVAL. 

Reference (from user zone-append series cover letter):
"Append using io_uring fixed-buffer --->
This is flagged as not-supported at the moment. Reason being, for fixed-buffer
io-uring sends iov_iter of bvec type. But current append-infra in block-layer
does not support such iov_iter."

And zone-append doesn't have a problem in using bvec iter as well, so
thought that this may make infra more complete/future-proof?

>-- 
>Damien Le Moal
>Western Digital Research
>

------RtrVgMPcOOSLrhJloRVgptxhQONXYtyOWZJ9JvnugceJtZ1T=_c51a9_
Content-Type: text/plain; charset="utf-8"


------RtrVgMPcOOSLrhJloRVgptxhQONXYtyOWZJ9JvnugceJtZ1T=_c51a9_--
