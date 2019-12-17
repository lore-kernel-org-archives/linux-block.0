Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE083C43603
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 13:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6E320716
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 13:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfLQNvx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:51:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:48134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbfLQNvx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 08:51:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B5CBDAB91;
        Tue, 17 Dec 2019 13:51:50 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH v10 2/4] xen/blkback: Squeeze page pools if a
 memory pressure is detected
To:     SeongJae Park <sjpark@amazon.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     SeongJae Park <sj38.park@gmail.com>, sjpark@amazon.de,
        axboe@kernel.dk, konrad.wilk@oracle.com, pdurrant@amazon.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <20191217131526.17300-1-sjpark@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <9c465967-3bbf-595b-b61c-c44fa95e41d5@suse.com>
Date:   Tue, 17 Dec 2019 14:51:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191217131526.17300-1-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 17.12.19 14:15, SeongJae Park wrote:
> On Tue, 17 Dec 2019 12:39:15 +0100 "Roger Pau Monné" <roger.pau@citrix.com> wrote:
> 
>> On Mon, Dec 16, 2019 at 08:48:03PM +0100, SeongJae Park wrote:
>>> On on, 16 Dec 2019 17:23:44 +0100, Jürgen Groß wrote:
>>>
>>>> On 16.12.19 17:15, SeongJae Park wrote:
>>>>> On Mon, 16 Dec 2019 15:37:20 +0100 SeongJae Park <sjpark@amazon.com> wrote:
>>>>>
>>>>>> On Mon, 16 Dec 2019 13:45:25 +0100 SeongJae Park <sjpark@amazon.com> wrote:
>>>>>>
>>>>>>> From: SeongJae Park <sjpark@amazon.de>
>>>>>>>
>>>>> [...]
>>>>>>> --- a/drivers/block/xen-blkback/xenbus.c
>>>>>>> +++ b/drivers/block/xen-blkback/xenbus.c
>>>>>>> @@ -824,6 +824,24 @@ static void frontend_changed(struct xenbus_device *dev,
>>>>>>>    }
>>>>>>>    
>>>>>>>    
>>>>>>> +/* Once a memory pressure is detected, squeeze free page pools for a while. */
>>>>>>> +static unsigned int buffer_squeeze_duration_ms = 10;
>>>>>>> +module_param_named(buffer_squeeze_duration_ms,
>>>>>>> +		buffer_squeeze_duration_ms, int, 0644);
>>>>>>> +MODULE_PARM_DESC(buffer_squeeze_duration_ms,
>>>>>>> +"Duration in ms to squeeze pages buffer when a memory pressure is detected");
>>>>>>> +
>>>>>>> +/*
>>>>>>> + * Callback received when the memory pressure is detected.
>>>>>>> + */
>>>>>>> +static void reclaim_memory(struct xenbus_device *dev)
>>>>>>> +{
>>>>>>> +	struct backend_info *be = dev_get_drvdata(&dev->dev);
>>>>>>> +
>>>>>>> +	be->blkif->buffer_squeeze_end = jiffies +
>>>>>>> +		msecs_to_jiffies(buffer_squeeze_duration_ms);
>>>>>>
>>>>>> This callback might race with 'xen_blkbk_probe()'.  The race could result in
>>>>>> __NULL dereferencing__, as 'xen_blkbk_probe()' sets '->blkif' after it links
>>>>>> 'be' to the 'dev'.  Please _don't merge_ this patch now!
>>>>>>
>>>>>> I will do more test and share results.  Meanwhile, if you have any opinion,
>>>>>> please let me know.
>>>
>>> I reduced system memory and attached bunch of devices in short time so that
>>> memory pressure occurs while device attachments are ongoing.  Under this
>>> circumstance, I was able to see the race.
>>>
>>>>>
>>>>> Not only '->blkif', but 'be' itself also coule be a NULL.  As similar
>>>>> concurrency issues could be in other drivers in their way, I suggest to change
>>>>> the reclaim callback ('->reclaim_memory') to be called for each driver instead
>>>>> of each device.  Then, each driver could be able to deal with its concurrency
>>>>> issues by itself.
>>>>
>>>> Hmm, I don't like that. This would need to be changed back in case we
>>>> add per-guest quota.
>>>
>>> Extending this callback in that way would be still not too hard.  We could use
>>> the argument to the callback.  I would keep the argument of the callback to
>>> 'struct device *' as is, and will add a comment saying 'NULL' value of the
>>> argument means every devices.  As an example, xenbus would pass NULL-ending
>>> array of the device pointers that need to free its resources.
>>>
>>> After seeing this race, I am now also thinking it could be better to delegate
>>> detailed control of each device to its driver, as some drivers have some
>>> complicated and unique relation with its devices.
>>>
>>>>
>>>> Wouldn't a get_device() before calling the callback and a put_device()
>>>> afterwards avoid that problem?
>>>
>>> I didn't used the reference count manipulation operations because other similar
>>> parts also didn't.  But, if there is no implicit reference count guarantee, it
>>> seems those operations are indeed necessary.
>>>
>>> That said, as get/put operations only adjust the reference count, those will
>>> not make the callback to wait until the linking of the 'backend' and 'blkif' to
>>> the device (xen_blkbk_probe()) is finished.  Thus, the race could still happen.
>>> Or, am I missing something?
>>
>> I would expect the device is not added to the list of backend devices
>> until the probe hook has finished with a non-error return code. Ie:
>> bus_for_each_dev should _not_ iterate over devices for which the probe
>> function hasn't been run to competition without errors.
>>
>> The same way I would expect the remove hook to first remove the device
>> from the list of backend devices and then run the remove hook.
>>
>> blkback uses an ad-hoc reference counting mechanism, but if the above
>> assumptions are true I think it would be enough to take an extra
>> reference in xen_blkbk_probe and drop it in xen_blkbk_remove.
> 
> Well, if the assumption is true, wouldn't the Juergen's approach solved the
> problem?  As previously said, I tried the approach but failed to solve this
> race.  The assumption is wrong or I missed something.  I think Juergen also
> think the assumption is not true as he suggested use of locking but not sure.
> Juergen, if I misunderstood, please let me know.

bus_for_each_dev() does no locking at all. All it does is
taking krefs on the iterated objects in order to avoid them
to be freed under its feet.


Juergen
