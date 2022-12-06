Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31245C352A1
	for <linux-block@archiver.kernel.org>; Tue,  6 Dec 2022 09:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiLFJC1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Dec 2022 04:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbiLFJCW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 04:02:22 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D37C1C41E
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 01:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670317341; x=1701853341;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tDgDQqNirCT+e73E+conxaN1lIGJ4ehCQJa0Vcez7E8=;
  b=JHQCcEZI1LT57QI1W4IeAsJ+00ug1wMJPv51BUdAQICTQVXPw+6G19IP
   frMe219yYKRRumkhJ7BCGf3r8oOta5YBvzlWzbW8lpHVt5d+zlNURGB7c
   K363I1y8vf1WnYpvKaneTOtCi2fHJTnNwr4XieHAYLg5vwAo+pgF14JBH
   hfHzkNpur5S6JAgfm052deSq+bCtWxsSwA3HxZWIg6y1dCxiflzo8/wBw
   U5s9tVK0zAFNErLdfSfeGolqyqHa5MtVGyIwsrA8QPdSj9acJ7p6uqwaW
   psESWNTy/xSUNJmrkxYyYCkt8nvhP5owBztkcH+mXTZe9IweaAG6o/ak0
   w==;
X-IronPort-AV: E=Sophos;i="5.96,220,1665417600"; 
   d="scan'208";a="218260828"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2022 17:02:20 +0800
IronPort-SDR: g7anEZ64RYG8qSsOZaFizNz/YJI2V6oUqBr58OFrIG7S5Pl0j5Uucdh9W7sNkuIPd+MDM6XDqm
 91FGZn0aq0Tf19ZTtZ0/xr5rGoZLlutMaUw9zXGLd5Elnv9w8iF+C3YGCOsTLyqltbxfbLZJJJ
 ml0ZJ/3VceCARgEzfrBOFh4iisexW19zpVip05qUr6tQnbodNaqSThUC6oMbBr6OAekheI36ov
 UZJLTVhh0iT5CmMkkRyoe+yy1Zr3L4U3DoSV7PI17D5z3j+WM0hbT2hA3tnT0kMyA22U3YGNfX
 xm8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2022 00:20:52 -0800
IronPort-SDR: 74WVvIW3qJfgwEtCKkxtU/uALnycIf0CI1T4CZ3SRM0Os4S3o1iMZYJvDxT6+RUB8nsO9Pwq2q
 mMyhQTnTrI9SVUyZAaqAzjrfYlGOlhGZLO0PkKY49jm4PabkSDtGjWXB0zdOj6PfJkGOoE5nb7
 pvU5+1ck0yI1aEdc1ECDkD61mCe4IyxfSLmMfzdlVruUI+KZU024ONVf2yCBBHV2ouh9u+wVBF
 C/Lwz2uBaCVVfC09jzW2paXJBC/b5DZh14hSWGjm0TUfUkCU2zmugQb+ly3PI3gVY7HPkpybk2
 9sA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2022 01:02:21 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NRDvH61w6z1RwqL
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 01:02:19 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670317338; x=1672909339; bh=tDgDQqNirCT+e73E+conxaN1lIGJ4ehCQJa
        0Vcez7E8=; b=SJNsWdTUp4zb3n59Sjijv82P5C4Ax1p8NYTIimQJpIcuucK22AX
        cWQ+bHzcLxreoY6/6P09kU0vMdVrNlAbsuFS3927VR5Cjfgy7ZMWWceXzBx8h4Zb
        qec6l+7PnQIH+8DbfW7h6XGN/qoEUHKLVymhbR9TZNyvDSz60DpDXVXsi+LbjigO
        Lw1gkBTRBSxc/UDKuYBgYtRNkkJmpL9xtBELDr8EqnAbqbX0uF4VcNXt/Vj1Mbqs
        lJUv1vmzVtULcFt5mAuUo9VLFQ650SmRWZ2FJ8Zzp0yb+1w7J72ZbHaFWJDUIT0H
        oCNd69ZscpZwO+xoYg6i14fG78NVAYOCXoQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KE9RpgRqrjaJ for <linux-block@vger.kernel.org>;
        Tue,  6 Dec 2022 01:02:18 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NRDvF5q95z1RvLy;
        Tue,  6 Dec 2022 01:02:17 -0800 (PST)
Message-ID: <6983f8b3-a320-ce32-ef0d-273d11dd8648@opensource.wdc.com>
Date:   Tue, 6 Dec 2022 18:02:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V6 6/8] block, bfq: retrieve independent access ranges
 from request queue
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Federico Gavioli <f.gavioli97@gmail.com>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-7-paolo.valente@linaro.org>
 <5d062001-2fff-35e5-d951-a61b510727d9@opensource.wdc.com>
 <4C45BCC6-D9AB-4C70-92E2-1B54AB4A2090@linaro.org>
 <d27ca14b-e228-49b7-28a8-00ea67e8ea06@opensource.wdc.com>
 <76ADE275-1862-44F7-B9C4-4A08179A72E3@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <76ADE275-1862-44F7-B9C4-4A08179A72E3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/22 17:41, Paolo Valente wrote:
> 
> 
>> Il giorno 6 dic 2022, alle ore 09:29, Damien Le Moal <damien.lemoal@opensource.wdc.com> ha scritto:
>>
>> On 12/6/22 17:06, Paolo Valente wrote:
>>>
>>>
>>>> Il giorno 21 nov 2022, alle ore 02:01, Damien Le Moal <damien.lemoal@opensource.wdc.com> ha scritto:
>>>>
>>>
>>> ...
>>>
>>>>
>>>>> }
>>>>>
>>>>> static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
>>>>> @@ -7144,6 +7159,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>>>>> {
>>>>> 	struct bfq_data *bfqd;
>>>>> 	struct elevator_queue *eq;
>>>>> +	unsigned int i;
>>>>> +	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
>>>>>
>>>>> 	eq = elevator_alloc(q, e);
>>>>> 	if (!eq)
>>>>> @@ -7187,10 +7204,31 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>>>>> 	bfqd->queue = q;
>>>>>
>>>>> 	/*
>>>>> -	 * Multi-actuator support not complete yet, default to single
>>>>> -	 * actuator for the moment.
>>>>> +	 * If the disk supports multiple actuators, we copy the independent
>>>>> +	 * access ranges from the request queue structure.
>>>>> 	 */
>>>>> -	bfqd->num_actuators = 1;
>>>>> +	spin_lock_irq(&q->queue_lock);
>>>>> +	if (ia_ranges) {
>>>>> +		/*
>>>>> +		 * Check if the disk ia_ranges size exceeds the current bfq
>>>>> +		 * actuator limit.
>>>>> +		 */
>>>>> +		if (ia_ranges->nr_ia_ranges > BFQ_MAX_ACTUATORS) {
>>>>> +			pr_crit("nr_ia_ranges higher than act limit: iars=%d, max=%d.\n",
>>>>> +				ia_ranges->nr_ia_ranges, BFQ_MAX_ACTUATORS);
>>>>> +			pr_crit("Falling back to single actuator mode.\n");
>>>>> +			bfqd->num_actuators = 0;
>>>>> +		} else {
>>>>> +			bfqd->num_actuators = ia_ranges->nr_ia_ranges;
>>>>> +
>>>>> +			for (i = 0; i < bfqd->num_actuators; i++)
>>>>> +				bfqd->ia_ranges[i] = ia_ranges->ia_range[i];
>>>>> +		}
>>>>> +	} else {
>>>>> +		bfqd->num_actuators = 0;
>>>>
>>>> That is very weird. The default should be 1 actuator.
>>>> ia_ranges->nr_ia_ranges is 0 when the disk does not provide any range
>>>> information, meaning it is a regular disk with a single actuator.
>>>
>>> Actually, IIUC this assignment to 0 seems to be done exactly when you
>>> say that it should be done, i.e., when the disk does not provide any
>>> range information (ia_ranges is NULL). Am I missing something else?
>>
>> No ranges reported means no extra actuators, so a single actuator an
>> single LBA range for the entire device.
> 
> I'm still confused, sorry.  Where will I read sector ranges from, if
> no sector range information is available (ia_ranges is NULL)?

start = 0 and nr_sectors = bdev_nr_sectors(bdev).
No ia_ranges to read.

> 
>> In that case, bfq should process
>> all IOs using bfqd->ia_ranges[0]. The get range function will always
>> return that range. That makes the code clean and avoids different path for
>> nr_ranges == 1 and nr_ranges > 1. No ?
> 
> Apart from the above point, for which maybe there is some other
> source of information for getting ranges, I see the following issue.
> 
> What you propose is to save sector information and trigger the
> range-checking for loop also for the above single-actuator case.  Yet
> txecuting (one iteration of) that loop will will always result in
> getting a 0 as index.  So, what's the point is saving data and
> executing code on each IO, for getting a static result that we already
> know we will get?

Surely, you can add an "if (bfqd->num_actuators ==1)" optimization in
strategic places to optimize for regular devices with a single actuator,
which bfqd->num_actuators == 1 *exactly* describes. Having
"bfqd->num_actuators = 0" makes no sense to me.

But if you feel strongly about this, feel free to ignore this.

> 
> Thanks,
> Paolo
> 
>>
>>>
>>> Once again, all other suggestions applied. I'm about to submit a V7.
>>>
>>> Thanks,
>>> Paolo
>>>
>>
>> -- 
>> Damien Le Moal
>> Western Digital Research
> 

-- 
Damien Le Moal
Western Digital Research

