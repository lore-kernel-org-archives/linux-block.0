Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FB7C54EBE
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 23:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbjAIX4s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbjAIX4q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 18:56:46 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2A7A198
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673308606; x=1704844606;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+TlWuekJ8fuolmeoc/wumuQqkFXTu1J8g2rayjTSivg=;
  b=OgI4TV+sSw3RHi96X4jrvyWxrKZrYo/FJs8VhK8sdbkP2sNAbAshq27A
   ACsA3FLQ1TIqSsM4TulRePuNnlb7sd4djpuy+8tmrJVWQf3RP3ExNzWFI
   3Y+te56DFoK5XGovHrm7YpzeengVM+CjNRqTPvJY8csRbFevBqTwDorVx
   XlzFqSEBIs3z2YVlfSaz2GRlr8s3TjXgzRzKM+VrK8jM4MsCY/w30mKSg
   bHqhW7JTlaBwJJLtGKTsnoB6DMaYStEbknE40fiGElmR3dHkvvVOhhv47
   AktxwSpuZy2ixWijWYKEjEf7PTKXYFj6mCrDO1USU6iBStqDLa6zXgFqZ
   g==;
X-IronPort-AV: E=Sophos;i="5.96,313,1665417600"; 
   d="scan'208";a="225443706"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 07:56:45 +0800
IronPort-SDR: m2VaAwn2+Hq/KRVvvihtrjWZx+6nJSfZ09srlkYvcSRDYeefbusTyqjcZoZOhRBwdUpWxyB8Ph
 r0KNjWXHvmmcaQhmCtsGFsc8LohAAfBGgL8A/1iRWVsLz247dFJMqjneAXMlfSvHyavss934if
 b8y0T2xr67Ti282aJ5WUs13ZoNlQBGZ/xc9U6fO1Z1xycgcgrkK1nyYp3byK6iJPI8McAL5nfV
 +WivjLT5srn6s49nicf+DFPNtM4AawaXkyvBUIKGdgeMmfg6LnXI2Ls6rGADec/ky0/xFljBo4
 zcA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 15:14:36 -0800
IronPort-SDR: y899p4Qf/Fyb6u1Cuan9kloPZbCWfEGOLD6lA4zmRJHWlr0mt1bY6IidZh7TUHwmf4ukDtj+MM
 8lL9okwsp9cGBzxnAD5OCC6Qivp5BmX6+DqFhm6SWVBppi9Py5g46n1vN9TxC1ZSsbSa9TYZeQ
 QJ9sBgusiAWhKIGwzbGncZp+aAOVYFYSE74VqFG8Thvve6Qiten7BLuHM+COhWEPXfnlx168f9
 8AwvKCuwOy6U+olJTEVPNfebNheA3810z42rMtxWIL8mBb+zA4zTcAJEC/a8+3/NNtiM1VkXbw
 DGA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 15:56:46 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NrW7d38sfz1RwtC
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:56:45 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673308604; x=1675900605; bh=+TlWuekJ8fuolmeoc/wumuQqkFXTu1J8g2r
        ayjTSivg=; b=M5jC2rG/zBfFRkvsyWiusftlLvraeU6ITlQrbh9dvHQohAAd2DD
        AK32q3R4ijSa9Ee+keEjAS+xIuu6SwMztCivbCC7LtgWnRbA6I6wv2Devm/lHPNE
        ou3/QU6O5Plnd3DaSL0mlp0w238SHW4q4LfupHQyaHgOWIUpA9Lb01Z4fXne4jWi
        f4viNwCJy1aGyfvKSb6rDdb0UoqWteL6fq6vFT1Yq77ujzK8zKax8R4akKcRC4ke
        chyYZz0n5CRde8/ctAVW++aXTlR+2a9uWES3pyydiUVO/8kd+eiMPPEnNnw56UVd
        HWz6YoEU8S/gpZFvHhUvxOy5uKRNhz+laUg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Dp6bPuchqFF8 for <linux-block@vger.kernel.org>;
        Mon,  9 Jan 2023 15:56:44 -0800 (PST)
Received: from [10.225.163.12] (unknown [10.225.163.12])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NrW7b67rVz1RvLy;
        Mon,  9 Jan 2023 15:56:43 -0800 (PST)
Message-ID: <a4f42abc-08dd-9a2e-3e6d-371e3ed695d2@opensource.wdc.com>
Date:   Tue, 10 Jan 2023 08:56:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/8] block/mq-deadline: Only use zone locking if necessary
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-5-bvanassche@acm.org>
 <92096c6d-fe0a-7b5b-222f-c532286c0c8b@opensource.wdc.com>
 <7bf28b7e-7301-29b5-c610-dff04ad6337f@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7bf28b7e-7301-29b5-c610-dff04ad6337f@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/23 08:51, Bart Van Assche wrote:
> On 1/9/23 15:46, Damien Le Moal wrote:
>> On 1/10/23 08:27, Bart Van Assche wrote:
>>> Measurements have shown that limiting the queue depth to one for zoned
>>> writes has a significant negative performance impact on zoned UFS devices.
>>> Hence this patch that disables zone locking from the mq-deadline scheduler
>>> for storage controllers that support pipelining zoned writes. This patch is
>>> based on the following assumptions:
>>> - Applications submit write requests to sequential write required zones
>>>    in order.
>>> - It happens infrequently that zoned write requests are reordered by the
>>>    block layer.
>>> - The storage controller does not reorder write requests that have been
>>>    submitted to the same hardware queue. This is the case for UFS: the
>>>    UFSHCI specification requires that UFS controllers process requests in
>>>    order per hardware queue.
>>> - The I/O priority of all pipelined write requests is the same per zone.
>>> - Either no I/O scheduler is used or an I/O scheduler is used that
>>>    submits write requests per zone in LBA order.
>>>
>>> If applications submit write requests to sequential write required zones
>>> in order, at least one of the pending requests will succeed. Hence, the
>>> number of retries that is required is at most (number of pending
>>> requests) - 1.
>>
>> But if the mid-layer decides to requeue a write request, the workqueue
>> used in the mq block layer for requeuing is going to completely destroy
>> write ordering as that is outside of the submission path, working in
>> parallel with it... Does blk_queue_pipeline_zoned_writes() == true also
>> guarantee that a write request will *never* be requeued before hitting the
>> adapter/device ?
> 
> We don't need the guarantee that reordering will never happen. What we 
> need is that reordering happens infrequently (e.g. less than 1% of the 
> cases). This is what the last paragraph before your reply refers to. 
> Maybe I should expand that paragraph.

But my point is that if a request goes through the block layer requeue, it
will be out of order, and will be submitted out of order again, and will
fail again. Unless you stall dispatching, wait for all requeues to come
back in the scheduler, and then start trying again, I do not see how you
can guarantee that retrying the unaligned writes will ever succeed.

I am talking in the context of host-managed devices here.

-- 
Damien Le Moal
Western Digital Research

