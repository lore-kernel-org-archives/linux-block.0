Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C3CC07E9D
	for <linux-block@archiver.kernel.org>; Sat, 24 Sep 2022 01:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiIXBWZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Sep 2022 21:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbiIXBWY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 21:22:24 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9030A10911E
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 18:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663982543; x=1695518543;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j0figFZxEreBSY1Cx+kndYnHpnAJ/z2W8eA8gokM7Is=;
  b=FrNhuLAOKutgW+1hQTljCc++DrunPwu++ePniyV582t7BtEXm00L5B1O
   NHpUx1W3IszfuPwIx+IsD9ul5VdpM8i51IujRNK3YRAk6IMdo3mWAZg/m
   I+3cLucST6uQCx78Gs0Fs2n4zuCn7gejqEb+56rRKBdu6q/gYmpNSyQ0F
   q2T/inbmgAt6XJz0GxrLiSU2FA2gN+iC9Drhej+mZRX6XiKrMaI6gSNtr
   vhT0+fmFeGncJ50KbsJoaMHQPomDMBV7swhhva964rA3D90xoZuX7qzqu
   1/HO9vM/gYvvqvf8jLUrvYeTHFcdemO8rTUEOglFDdPP1OJenIquGSZUN
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,340,1654531200"; 
   d="scan'208";a="316438459"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2022 09:22:22 +0800
IronPort-SDR: LFRGRLCcscMlsoQ0L55KaWLNL15ql/qYutCcIvhfkH/Bo+nDR8HvdNITqFrf25vZGReyYUdTSo
 R6WxCIpAlA+EbggFgymZ5MrT70WRx88lhLPjW7xHiHlg19AV4nH/MB00QVUb2rv8vAp5C8Clqt
 0LJ7chYa1couQ0pWEJle0V4w/Owx+FqVCOOYeHkn2loQovNOjabQhKxTpnfSw3u+rTJqjax9sg
 8jhKoTHtujBwK+EJY9p4RWTzjFxNEjh4gWk5I16elEzVk9LVBqDSNU4NY7G9rSY6NGImAct65X
 Nxx9oUdj+LFw8vClQDnKaktz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Sep 2022 17:36:53 -0700
IronPort-SDR: bU5IdkWdBeamN0gVsM4jdz/kkthzD2nLylf523mXi3n4U+lokrTTkVC0UHBwzobE9UeKuoLZH0
 VIH4xFPmbVquyAqpnkIfMWJVVQoupIx/ZuNk9mh1XiItFlVZmnFNfDpAm0x0W8Uf8M1RVkxzri
 9fR9ZJLoy4YYOHf5UVFnvuzw5I62LThM97VkvrWGcQGEJqa+qMNlGjM9ZH8khh2gu/ShQuLvrl
 SY4BprXf/tdsNniBsmGG0akP+zmw3XSLAVGAYt5Abcj5Xy5Jxo+vFkStwQ890J9l0VgYGsZGZz
 CZQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Sep 2022 18:22:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MZB8F4D9Bz1RwtC
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 18:22:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663982540; x=1666574541; bh=j0figFZxEreBSY1Cx+kndYnHpnAJ/z2W8eA
        8gokM7Is=; b=HE3yobUHVvBYIlWMJ/QWkRq7tLCgWTCTLvjkMMdZw+WB95AjRX+
        5sh8hJ0XRIeZz765wODHqKzd3pThIGJ7h1DaqQzRukFBMavLfuqXKOv+O+jlDNKz
        cUwrBr7wSdN7I3nWPAgvo0EIgrYx9PxBSnQzKVVHhjKajrLzZxq4d51PuXGVlvZb
        fPDuUQFbAucGQEz3lEkuUYiytF+/PRJhF7nlPEfFmntVHZqc/f7q/p3waEn4uU5r
        Gw1i99kYUKzJctqq850WK0XhGTMv1O+WANuDie1uSq5GDupaNm7Ztj7WBczZj+RK
        ln0qmS/sa+8+6ciIf7J4CouDdkZ82J6XEpg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nFd-Z-dnsxET for <linux-block@vger.kernel.org>;
        Fri, 23 Sep 2022 18:22:20 -0700 (PDT)
Received: from [10.225.163.88] (unknown [10.225.163.88])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MZB8C3xM5z1RvLy;
        Fri, 23 Sep 2022 18:22:19 -0700 (PDT)
Message-ID: <4e9ae1d2-1db4-aff6-e280-6ea282161b7b@opensource.wdc.com>
Date:   Sat, 24 Sep 2022 10:22:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/5] block: enable batched allocation for
 blk_mq_alloc_request()
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Pankaj Raghav <p.raghav@samsung.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, joshi.k@samsung.com,
        Pankaj Raghav <pankydev8@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20220922182805.96173-1-axboe@kernel.dk>
 <20220922182805.96173-2-axboe@kernel.dk>
 <CGME20220923145245eucas1p107655755f446bb1e1318539a3f82d301@eucas1p1.samsung.com>
 <20220923145236.pr7ssckko4okklo2@quentin>
 <c7b76fa1-f7e3-3ac6-c92d-35baa0d9a40a@samsung.com>
 <2e484ccb-b65b-2991-e259-d3f7be6ad1a6@kernel.dk>
 <a06df4ba-a968-0ee1-f8ff-062def0ec031@opensource.wdc.com>
 <ba0b3ae4-7001-af42-3549-cc52049ccccb@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ba0b3ae4-7001-af42-3549-cc52049ccccb@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/24/22 10:01, Jens Axboe wrote:
> On 9/23/22 6:59 PM, Damien Le Moal wrote:
>> On 9/24/22 05:54, Jens Axboe wrote:
>>> On 9/23/22 9:13 AM, Pankaj Raghav wrote:
>>>> On 2022-09-23 16:52, Pankaj Raghav wrote:
>>>>> On Thu, Sep 22, 2022 at 12:28:01PM -0600, Jens Axboe wrote:
>>>>>> The filesystem IO path can take advantage of allocating batches of
>>>>>> requests, if the underlying submitter tells the block layer about it
>>>>>> through the blk_plug. For passthrough IO, the exported API is the
>>>>>> blk_mq_alloc_request() helper, and that one does not allow for
>>>>>> request caching.
>>>>>>
>>>>>> Wire up request caching for blk_mq_alloc_request(), which is generally
>>>>>> done without having a bio available upfront.
>>>>>>
>>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>>> ---
>>>>>>  block/blk-mq.c | 80 ++++++++++++++++++++++++++++++++++++++++++++------
>>>>>>  1 file changed, 71 insertions(+), 9 deletions(-)
>>>>>>
>>>>> I think we need this patch to ensure correct behaviour for passthrough:
>>>>>
>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>>> index c11949d66163..840541c1ab40 100644
>>>>> --- a/block/blk-mq.c
>>>>> +++ b/block/blk-mq.c
>>>>> @@ -1213,7 +1213,7 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
>>>>>         WARN_ON(!blk_rq_is_passthrough(rq));
>>>>>  
>>>>>         blk_account_io_start(rq);
>>>>> -       if (current->plug)
>>>>> +       if (blk_mq_plug(rq->bio))
>>>>>                 blk_add_rq_to_plug(current->plug, rq);
>>>>>         else
>>>>>                 blk_mq_sched_insert_request(rq, at_head, true, false);
>>>>>
>>>>> As the passthrough path can now support request caching via blk_mq_alloc_request(),
>>>>> and it uses blk_execute_rq_nowait(), bad things can happen at least for zoned
>>>>> devices:
>>>>>
>>>>> static inline struct blk_plug *blk_mq_plug( struct bio *bio)
>>>>> {
>>>>> 	/* Zoned block device write operation case: do not plug the BIO */
>>>>> 	if (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio)))
>>>>> 		return NULL;
>>>>> ..
>>>>
>>>> Thinking more about it, even this will not fix it because op is
>>>> REQ_OP_DRV_OUT if it is a NVMe write for passthrough requests.
>>>>
>>>> @Damien Should the condition in blk_mq_plug() be changed to:
>>>>
>>>> static inline struct blk_plug *blk_mq_plug( struct bio *bio)
>>>> {
>>>> 	/* Zoned block device write operation case: do not plug the BIO */
>>>> 	if (bdev_is_zoned(bio->bi_bdev) && !op_is_read(bio_op(bio)))
>>>> 		return NULL;
>>>
>>> That looks reasonable to me. It'll prevent plug optimizations even
>>> for passthrough on zoned devices, but that's probably fine.
>>
>> Could do:
>>
>> 	if (blk_op_is_passthrough(bio_op(bio)) ||
>> 	    (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio))))
>> 		return NULL;
>>
>> Which I think is way cleaner. No ?
>> Unless you want to preserve plugging with passthrough commands on regular
>> (not zoned) drives ?
> 
> We most certainly do, without plugging this whole patchset is not
> functional. Nor is batched dispatch, for example.

OK. Then the change to !op_is_read() is fine then.

> 

-- 
Damien Le Moal
Western Digital Research

