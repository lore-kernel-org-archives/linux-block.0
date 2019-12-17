Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593F8C43603
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 08:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A85206A5
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 08:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfLQIQx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:16:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:60828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLQIQx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 03:16:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D3A47ACD9;
        Tue, 17 Dec 2019 08:16:50 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH v10 2/4] xen/blkback: Squeeze page pools if a
 memory pressure is detected
To:     SeongJae Park <sjpark@amazon.com>
Cc:     SeongJae Park <sj38.park@gmail.com>, axboe@kernel.dk,
        konrad.wilk@oracle.com, pdurrant@amazon.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, roger.pau@citrix.com
References: <20191217075932.4516-1-sjpark@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <f9f686ce-aeca-0947-5b2b-91e1d0c183dd@suse.com>
Date:   Tue, 17 Dec 2019 09:16:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191217075932.4516-1-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 17.12.19 08:59, SeongJae Park wrote:
> On Tue, 17 Dec 2019 07:23:12 +0100 "Jürgen Groß" <jgross@suse.com> wrote:
> 
>> On 16.12.19 20:48, SeongJae Park wrote:
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
>>>>>>>     }
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
>> No, I think we need a xenbus lock per device which will need to be
>> taken in xen_blkbk_probe(), xenbus_dev_remove() and while calling the
>> callback.
> 
> I also agree that locking should be used at last.  But, as each driver manages
> its devices and resources in their way, it could have its unique race
> conditions.  And, each unique race condition might have its unique efficient
> way to synchronize it.  Therefore, I think the synchronization should be done
> by each driver, not by xenbus and thus we should make the callback to be called
> per-driver.

xenbus controls creation and removing of devices, so applying locking
at xenbus level is the right thing to do in order to avoid races with
device removal.

In case a backend has further synchronization requirements those have to
be handled at backend level, of course.

In the end you'll need the xenbus level locking anyway in order to avoid
a race when the last backend specific device is just being removed when
the callback is about to be called for that device. Or you'd need to
call try_get_module() before calling into each backend...


Juergen
