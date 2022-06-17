Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0C5C43334
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 12:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiFQMAk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 08:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiFQMAj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 08:00:39 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C4B68983
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 05:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655467238; x=1687003238;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JSCArWXMMqHEQnGe7uVtcGctq9VFYpn+aoqkavnQWpU=;
  b=KNOT8X/GSCaZciIIZGZApagtsNVgrO4h5Be1ap4uet1mW0fnTnDDo1Pw
   xsAb+O5c3bS4fY5l72n+1dsNnhHe+1hkCOd6hGi0rCzdkK5iKxTof+VXz
   zSfOMyB5/4X7tPpIaiuz1cB+ArAVOiC/8c8OgMd3x6IVJfIVTtt/gYybH
   dZ0ML1Ofcy5khOcOgLOMHXXNMd5Wyj/DcVRbL3ZLbAXIFwFCkaN2J09PW
   yYAwCh5aoFUN0kMDjZqi8hkO+CHRW3ZBbKHyyFSKacgR8lBeynu/+Wzvu
   hP6+V/oQriooHQaqxiU2bKuIOYP5otsxlR2enHDUNQK36Xd92t/DRRReQ
   g==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="208282742"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 20:00:37 +0800
IronPort-SDR: 1Q467nCxwhok4IespAKrC94ouh6JebCTzsVoHlJrniSwe8hi7EjF3CKaBeQkhK1RF+XwvIuR5p
 hAIVGuJbxWKHcadfaHwDFJvjpoGLdNVArWpevPrSf/dmcuY4BismorgUTW/RbIjEYJM7r54eWc
 jFdjh1EsU1WciyTCp16mMy1Wu0aE/ahgt1cQ6yXKFpCoO1YXXxvSoYmM/HLUy2jsdJeAVXDseT
 jaQsT6de5JQQBDyfdFtT3ocoQ853x70JUJyNgr2F6xIRDsV+yMa/l9BsWdwp1WDQqlccQfomHc
 aWl+dAe9iy1NMFdo4G2nZwJZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2022 04:18:50 -0700
IronPort-SDR: cZeYyOnVZ19RG9r7HLqI6tM/kfJ0fgOu/RmJS489C6jPuxL/tSUTwqPML05FrQFuMqqSjPj2Dk
 7X8OawD0ag+myzxdW2opvL2VEmNb6m4Ve8qQs9j4iWpq3D0RKuea2MlxRH6q0x9ULf8zbEPCUe
 ObMS+OeA395rVeTgl2mUmefFnpyw1lj8Zp2j+QN1gxqjta63ZURynath8GyzjMv4H32+hfnwyk
 kYZSmEQBWbOHnY28xuq57+iK/sPiZaIfLzLbM6MTGfqMPCaXZKY8kYvERF5YJrAQkjB7tOtPs6
 Inc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2022 05:00:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPd0P3ljLz1Rwrw
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 05:00:37 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655467237; x=1658059238; bh=JSCArWXMMqHEQnGe7uVtcGctq9VFYpn+aoq
        kavnQWpU=; b=i2yWdsVDOZmEhx4fSHgNHq3C8jy7iAiu2jnPsrxahRnWNNNOcgZ
        OPKyV6UM2VsMO7HfRb5alCe7yg0uRH/nZZkgmqd1jRzZ+8ybxcHo/Y7aoe8HStP3
        XCogHTKLEfiHoQMXt8+MFobvzhjNnBSccnqshSqK5Xr63/arCGPW1qjt20WUuBbB
        crKFK7qG/LvmPmX9z3XZSYzcBWp6Do2LN+N+q52+7MDXQdJ9o3WIE0D9JhLqjehV
        Vif5a+0/ozob2RXrwlCtKGkF47zWE7gniwyvvuURcX2gluNC95MP0xArQQJpErSD
        K5B2oz+eXkckNskDX6PLI/evFsD7zzwUB7Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bUqv5J1nWNN0 for <linux-block@vger.kernel.org>;
        Fri, 17 Jun 2022 05:00:37 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPd0N1bcCz1Rvlc;
        Fri, 17 Jun 2022 05:00:35 -0700 (PDT)
Message-ID: <0ba1724b-eeb2-64b4-28ea-68f1e5d394a3@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 21:00:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 8/8] block: Always initialize bio IO priority on submit
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20220615160437.5478-1-jack@suse.cz>
 <20220615161616.5055-8-jack@suse.cz>
 <ece0af04-80c8-e0c3-702b-0d0d17f61ea9@opensource.wdc.com>
 <20220616112303.wywyhkvyr74ipdls@quack3.lan>
 <ae8fbc74-64b7-2d2e-ba46-cc72851e30b5@opensource.wdc.com>
 <20220617115208.mv55swrdcf44tw5a@quack3>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220617115208.mv55swrdcf44tw5a@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/22 20:52, Jan Kara wrote:
> On Fri 17-06-22 09:05:12, Damien Le Moal wrote:
>> On 6/16/22 20:23, Jan Kara wrote:
>>> On Thu 16-06-22 12:15:25, Damien Le Moal wrote:
>>>> On 6/16/22 01:16, Jan Kara wrote:
>>>>> Currently, IO priority set in task's IO context is not reflected in the
>>>>> bio->bi_ioprio for most IO (only io_uring and direct IO set it). This
>>>>> results in odd results where process is submitting some bios with one
>>>>> priority and other bios with a different (unset) priority and due to
>>>>> differing priorities bios cannot be merged. Make sure bio->bi_ioprio is
>>>>> always set on bio submission.
>>>>>
>>>>> Signed-off-by: Jan Kara <jack@suse.cz>
>>>>> ---
>>>>>   block/blk-mq.c | 6 ++++++
>>>>>   1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>>> index e17d822e6051..e976f696babc 100644
>>>>> --- a/block/blk-mq.c
>>>>> +++ b/block/blk-mq.c
>>>>> @@ -2793,7 +2793,13 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
>>>>>   static void bio_set_ioprio(struct bio *bio)
>>>>>   {
>>>>> +	unsigned short ioprio_class;
>>>>> +
>>>>>   	blkcg_set_ioprio(bio);
>>>>
>>>> Shouldn't this function set the default using the below "if" code ?
>>>>
>>>>> +	ioprio_class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
>>>>> +	/* Nobody set ioprio so far? Initialize it based on task's nice value */
>>>>
>>>> I do not think that the ioprio_class variable is useful.
>>>> This can be:
>>>>
>>>> 	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
>>>> 		bio->bi_ioprio = get_current_ioprio();
>>>
>>> You are right. Fixed.
>>
>> What about moving this inside blkcg_set_ioprio() ? bio_set_ioprio() would
>> then not be needed at all and blkcg_set_ioprio() called directly ?
> 
> What I dislike about this is that it is counterintuitive that
> blkcg_set_prio() does anything when blkcgs are disabled in kernel config
> (and it would have to to keep things working). So if you dislike
> bio_set_ioprio(), I can just opencode this function in its single call
> site. Would that be better?

Ah, yes, blkcg may be disabled. Got it. So sure, bio_set_ioprio() is fine
as is.

> 
> 								Honza


-- 
Damien Le Moal
Western Digital Research
