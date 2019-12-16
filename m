Return-Path: <SRS0=l7do=2G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD98C43603
	for <linux-block@archiver.kernel.org>; Mon, 16 Dec 2019 16:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6EA206D7
	for <linux-block@archiver.kernel.org>; Mon, 16 Dec 2019 16:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfLPQXv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:23:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:55622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfLPQXv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Dec 2019 11:23:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 43EF2B229;
        Mon, 16 Dec 2019 16:23:49 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH v10 2/4] xen/blkback: Squeeze page pools if a
 memory pressure is detected
To:     SeongJae Park <sjpark@amazon.com>, axboe@kernel.dk,
        konrad.wilk@oracle.com, roger.pau@citrix.com
Cc:     pdurrant@amazon.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
        sj38.park@gmail.com
References: <20191216161549.26976-1-sjpark@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <2ad62cc8-ae78-6087-f277-923dc076383a@suse.com>
Date:   Mon, 16 Dec 2019 17:23:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191216161549.26976-1-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 16.12.19 17:15, SeongJae Park wrote:
> On Mon, 16 Dec 2019 15:37:20 +0100 SeongJae Park <sjpark@amazon.com> wrote:
> 
>> On Mon, 16 Dec 2019 13:45:25 +0100 SeongJae Park <sjpark@amazon.com> wrote:
>>
>>> From: SeongJae Park <sjpark@amazon.de>
>>>
> [...]
>>> --- a/drivers/block/xen-blkback/xenbus.c
>>> +++ b/drivers/block/xen-blkback/xenbus.c
>>> @@ -824,6 +824,24 @@ static void frontend_changed(struct xenbus_device *dev,
>>>   }
>>>   
>>>   
>>> +/* Once a memory pressure is detected, squeeze free page pools for a while. */
>>> +static unsigned int buffer_squeeze_duration_ms = 10;
>>> +module_param_named(buffer_squeeze_duration_ms,
>>> +		buffer_squeeze_duration_ms, int, 0644);
>>> +MODULE_PARM_DESC(buffer_squeeze_duration_ms,
>>> +"Duration in ms to squeeze pages buffer when a memory pressure is detected");
>>> +
>>> +/*
>>> + * Callback received when the memory pressure is detected.
>>> + */
>>> +static void reclaim_memory(struct xenbus_device *dev)
>>> +{
>>> +	struct backend_info *be = dev_get_drvdata(&dev->dev);
>>> +
>>> +	be->blkif->buffer_squeeze_end = jiffies +
>>> +		msecs_to_jiffies(buffer_squeeze_duration_ms);
>>
>> This callback might race with 'xen_blkbk_probe()'.  The race could result in
>> __NULL dereferencing__, as 'xen_blkbk_probe()' sets '->blkif' after it links
>> 'be' to the 'dev'.  Please _don't merge_ this patch now!
>>
>> I will do more test and share results.  Meanwhile, if you have any opinion,
>> please let me know.
> 
> Not only '->blkif', but 'be' itself also coule be a NULL.  As similar
> concurrency issues could be in other drivers in their way, I suggest to change
> the reclaim callback ('->reclaim_memory') to be called for each driver instead
> of each device.  Then, each driver could be able to deal with its concurrency
> issues by itself.

Hmm, I don't like that. This would need to be changed back in case we
add per-guest quota.

Wouldn't a get_device() before calling the callback and a put_device()
afterwards avoid that problem?


Juergen
