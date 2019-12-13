Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDA7C43603
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 09:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC7E2077B
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 09:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLMJdt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:33:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:38784 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbfLMJdt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 04:33:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 477BBAD3B;
        Fri, 13 Dec 2019 09:33:47 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH v7 2/3] xen/blkback: Squeeze page pools if a
 memory pressure is detected
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        SeongJae Park <sj38.park@gmail.com>
Cc:     axboe@kernel.dk, sjpark@amazon.com, konrad.wilk@oracle.com,
        pdurrant@amazon.com, SeongJae Park <sjpark@amazon.de>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <20191212152757.GF11756@Air-de-Roger>
 <20191212160658.10466-1-sj38.park@gmail.com>
 <20191213092742.GG11756@Air-de-Roger>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <8425d77b-37cf-d959-9466-7bc1d4d99642@suse.com>
Date:   Fri, 13 Dec 2019 10:33:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191213092742.GG11756@Air-de-Roger>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13.12.19 10:27, Roger Pau Monné wrote:
> On Thu, Dec 12, 2019 at 05:06:58PM +0100, SeongJae Park wrote:
>> On Thu, 12 Dec 2019 16:27:57 +0100 "Roger Pau Monné" <roger.pau@citrix.com> wrote:
>>
>>>> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
>>>> index fd1e19f1a49f..98823d150905 100644
>>>> --- a/drivers/block/xen-blkback/blkback.c
>>>> +++ b/drivers/block/xen-blkback/blkback.c
>>>> @@ -142,6 +142,21 @@ static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
>>>>   		HZ * xen_blkif_pgrant_timeout);
>>>>   }
>>>>   
>>>> +/* Once a memory pressure is detected, squeeze free page pools for a while. */
>>>> +static unsigned int buffer_squeeze_duration_ms = 10;
>>>> +module_param_named(buffer_squeeze_duration_ms,
>>>> +		buffer_squeeze_duration_ms, int, 0644);
>>>> +MODULE_PARM_DESC(buffer_squeeze_duration_ms,
>>>> +"Duration in ms to squeeze pages buffer when a memory pressure is detected");
>>>> +
>>>> +static unsigned long buffer_squeeze_end;
>>>> +
>>>> +void xen_blkbk_reclaim_memory(struct xenbus_device *dev)
>>>> +{
>>>> +	buffer_squeeze_end = jiffies +
>>>> +		msecs_to_jiffies(buffer_squeeze_duration_ms);
>>>
>>> I'm not sure this is fully correct. This function will be called for
>>> each blkback instance, but the timeout is stored in a global variable
>>> that's shared between all blkback instances. Shouldn't this timeout be
>>> stored in xen_blkif so each instance has it's own local variable?
>>>
>>> Or else in the case you have 1k blkback instances the timeout is
>>> certainly going to be longer than expected, because each call to
>>> xen_blkbk_reclaim_memory will move it forward.
>>
>> Agreed that.  I think the extended timeout would not make a visible
>> performance, though, because the time that 1k-loop take would be short enough
>> to be ignored compared to the millisecond-scope duration.
>>
>> I took this way because I wanted to minimize such structural changes as far as
>> I can, as this is just a point-fix rather than ultimate solution.  That said,
>> it is not fully correct and very confusing.  My another colleague also pointed
>> out it in internal review.  Correct solution would be to adding a variable in
>> the struct as you suggested or avoiding duplicated update of the variable by
>> initializing the variable once the squeezing duration passes.  I would prefer
>> the later way, as it is more straightforward and still not introducing
>> structural change.  For example, it might be like below:
>>
>> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
>> index f41c698dd854..6856c8ef88de 100644
>> --- a/drivers/block/xen-blkback/blkback.c
>> +++ b/drivers/block/xen-blkback/blkback.c
>> @@ -152,8 +152,9 @@ static unsigned long buffer_squeeze_end;
>>   
>>   void xen_blkbk_reclaim_memory(struct xenbus_device *dev)
>>   {
>> -       buffer_squeeze_end = jiffies +
>> -               msecs_to_jiffies(buffer_squeeze_duration_ms);
>> +       if (!buffer_squeeze_end)
>> +               buffer_squeeze_end = jiffies +
>> +                       msecs_to_jiffies(buffer_squeeze_duration_ms);
>>   }
>>   
>>   static inline int get_free_page(struct xen_blkif_ring *ring, struct page **page)
>> @@ -669,10 +670,13 @@ int xen_blkif_schedule(void *arg)
>>                  }
>>   
>>                  /* Shrink the free pages pool if it is too large. */
>> -               if (time_before(jiffies, buffer_squeeze_end))
>> +               if (time_before(jiffies, buffer_squeeze_end)) {
>>                          shrink_free_pagepool(ring, 0);
>> -               else
>> +               } else {
>> +                       if (unlikely(buffer_squeeze_end))
>> +                               buffer_squeeze_end = 0;
>>                          shrink_free_pagepool(ring, max_buffer_pages);
>> +               }
>>   
>>                  if (log_stats && time_after(jiffies, ring->st_print))
>>                          print_stats(ring);
>>
>> May I ask you what way would you prefer?
> 
> I'm not particularly found of this approach, as I think it's racy. Ie:
> you would have to add some kind of lock to make sure the contents of
> buffer_squeeze_end stay unmodified during the read and set cycle, or
> else xen_blkif_schedule will race with xen_blkbk_reclaim_memory.
> 
> This is likely not a big deal ATM since the code will work as
> expected in most cases AFAICT, but I would still prefer to have a
> per-instance buffer_squeeze_end added to xen_blkif, given that the
> callback is per-instance. I wouldn't call it a structural change, it's
> just adding a variable to a struct instead of having a shared one, but
> the code is almost the same as the current version.

FWIW, I agree.


Juergen
