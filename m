Return-Path: <SRS0=BQu2=ZS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C568C432C3
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 11:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596AA2075C
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 11:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfKZLRU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 06:17:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:57374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726049AbfKZLRU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 06:17:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B98C9AB9B;
        Tue, 26 Nov 2019 11:17:16 +0000 (UTC)
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
To:     Arnd Bergmann <arnd@arndb.de>,
        "(Exiting) Baolin Wang" <baolin.wang@linaro.org>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        linux-block <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
References: <cover.1573456283.git.baolin.wang@linaro.org>
 <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
 <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
 <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
 <CADBw62pzV+5ZXBEbFvTQJ9essAd4cd7Xkz5j9AXB5rAQy0wLqA@mail.gmail.com>
 <CAMz4kuK_3q4JY1vNXe6zGHDNF8Ep-SkcUq6Z25r790VSz4+Bjw@mail.gmail.com>
 <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <f88856aa-9175-2a93-3747-c98215cb79c3@suse.de>
Date:   Tue, 26 Nov 2019 12:17:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/22/19 10:50 AM, Arnd Bergmann wrote:
> (adding Paolo as well, maybe he has some more insights)
> 
> On Mon, Nov 18, 2019 at 11:04 AM (Exiting) Baolin Wang
> <baolin.wang@linaro.org> wrote:
>> On Tue, 12 Nov 2019 at 16:48, Baolin Wang <baolin.wang7@gmail.com> wrote:
>>> On Tue, Nov 12, 2019 at 12:59 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Mon, Nov 11, 2019 at 1:58 PM Baolin Wang <baolin.wang@linaro.org> wrote:
>>>>>> - With that change in place calling a blocking __mmc_claim_host() is
>>>>>>   still a problem, so there should still be a nonblocking mmc_try_claim_host()
>>>>>>   for the submission path, leading to a BLK_STS_DEV_RESOURCE (?)
>>>>>>   return code from mmc_mq_queue_rq(). Basically mmc_mq_queue_rq()
>>>>>>   should always return right away, either after having queued the next I/O
>>>>>>   or with an error, but not waiting for the device in any way.
>>>>>
>>>>> Actually not only the mmc_claim_host() will block the MMC request
>>>>> processing, in this routine, the mmc_blk_part_switch() and
>>>>> mmc_retune() can also block the request processing. Moreover the part
>>>>> switching and tuning should be sync operations, and we can not move
>>>>> them to a work or a thread.
>>>>
>>>> Ok, I see.
>>>>
>>>> Those would also cause requests to be sent to the device or the host
>>>> controller, right? Maybe we can treat them as "a non-IO request
>>>
>>> Right.
>>>
>>>> has successfully been queued to the device" events, returning
>>>> busy from the mmc_mq_queue_rq() function and then running
>>>> the queue again when they complete?
>>>
>>> Yes, seems reasonable to me.
>>>
>>>>
>>>>>> - For the packed requests, there is apparently a very simple way to implement
>>>>>>   that without a software queue: mmc_mq_queue_rq() is allowed to look at
>>>>>>   and dequeue all requests that are currently part of the request_queue,
>>>>>>   so it should take out as many as it wants to submit at once and send
>>>>>>   them all down to the driver together, avoiding the need for any further
>>>>>>   round-trips to blk_mq or maintaining a queue in mmc.
>>>>>
>>>>> You mean we can dispatch a request directly from
>>>>> elevator->type->ops.dispatch_request()?  but we still need some helper
>>>>> functions to check if these requests can be packed (the package
>>>>> condition), and need to invent new APIs to start a packed request (or
>>>>> using cqe interfaces, which means we still need to implement some cqe
>>>>> callbacks).
>>>>
>>>> I don't know how the dispatch_request() function fits in there,
>>>> what Hannes told me is that in ->queue_rq() you can always
>>>> look at the following requests that are already queued up
>>>> and take the next ones off the list. Looking at bd->last
>>>> tells you if there are additional requests. If there are, you can
>>>> look at the next one from blk_mq_hw_ctx (not sure how, but
>>>> should not be hard to find)
>>>>
>>>> I also see that there is a commit_rqs() callback that may
>>>> go along with queue_rq(), implementing that one could make
>>>> this easier as well.
>>>
>>> Yes, we can use queue_rq()/commit_rqs() and bd->last (now bd->last may
>>> can not work well, see [1]), but like we talked before, for packed
>>> request, we still need some new interfaces (for example, a interface
>>> used to start a packed request, and a interface used to complete a
>>> packed request), but at last we got a consensus that we should re-use
>>> the CQE interfaces instead of new invention.
>>>
>>> [1] https://lore.kernel.org/patchwork/patch/1102897/
>>>
>>>>
>>>>>> - The DMA management (bounce buffer, map, unmap) that is currently
>>>>>>   done in mmc_blk_mq_issue_rq() should ideally be done in the
>>>>>>   init_request()/exit_request()  (?) callbacks from mmc_mq_ops so this
>>>>>>   can be done asynchronously, out of the critical timing path for the
>>>>>>   submission. With this, there won't be any need for a software queue.
>>>>>
>>>>> This is not true, now the blk-mq will allocate some static request
>>>>> objects (usually the static requests number should be the same with
>>>>> the hardware queue depth) saved in struct blk_mq_tags. So the
>>>>> init_request() is used to initialize the static requests when
>>>>> allocating them, and call exit_request to free the static requests
>>>>> when freeing the 'struct blk_mq_tags', such as the queue is dead. So
>>>>> we can not move the DMA management into the init_request/exit_request.
>>>>
>>>> Ok, I must have misremembered which callback that is then, but I guess
>>>> there is some other place to do it.
>>>
>>> I checked the 'struct blk_mq_ops', and I did not find a ops can be
>>> used to do DMA management. And I also checked UFS driver, it also did
>>> the DMA mapping in the queue_rq() (scsi_queue_rq() --->
>>> ufshcd_queuecommand() ---> ufshcd_map_sg()). Maybe I missed something?
>>>
>>> Moreover like I said above, for the packed request, we still need
>>> implement something (like the software queue) based on the CQE
>>> interfaces to help to handle packed requests.
>>
>> After some investigation and offline discussion with you, I still have
>> some concerns about your suggestion.
>>
>> 1) Now blk-mq have not supplied some ops to prepare a request, which is
>> used to do some DMA management asynchronously. But yes, we can
>> introduce new ops for blk-mq. But there are still some remaining
>> preparation in mmc_mq_queue_rq(), like mmc part switch. For software
>> queue, we can prepare a request totally after issuing one.
> 
> I suppose to make the submission non-blocking, all operations that
> currently block in the submission path may have to be changed first.
> 
> For the case of a partition switch (same for retune), I suppose
> something like this can be done:
> 
> - in queue_rq() check whether a partition switch is needed. If not,
>   submit the current rq
> - if a partition switch is needed, submit the partition switch cmd
>   instead, and return busy status
> - when the completion arrives for the partition switch, call back into
>   blk_mq to have it call queue_rq again.
> 
> Or possibly even (this might not be possible without signifcant
> restructuring):
> 
> - when preparing a request that would require a partition switch,
>   insert another meta-request to switch the partition ahead of it.
> 
> I do realize that this is a significant departure from how it was done
> in the past, but it seems cleaner that way to me.
> 
I would be treating the partition issue separate from the queued/batched
submission.

Aligning with the 'traditional' linux way for partition handling is
definitely the way to go IMO; otherwise you'll end up having to worry
about resource allocation between distinct queues (like you have to do
now), and will be having a hard time trying to map it properly to the
underlying hardware abstraction in blk-mq.

For starters I would keep a partition marker in the driver instance, and
calculate the parition for each incoming request. If the partition is
different you'll have to insert a partition switch request before
submitting the actual one.

To do this efficiently it would be good to know if:
a) How invasive is the partition switch? Would it be feasible to eg add
a partition switch for every command? This might sound daft now, but if
we get request batching going it might not the _that_ expensive after all...
b) Can the request switch command batched together with the normal
command? IE is is possible to have them both send in one go?
If so it would make life _so_ much easier; we could submit both command
at the same time, and won't have to worry about handling internal
completions ...

>> 2) I wonder if it is appropriate that using the irq threaded context
>> to dispatch next request, actually we will still introduce a context
>> switch here. Now we will complete a request in the hard irq handler
>> and kick the softirq to do time-consuming operations, like DMA
>> unmapping , and will start next request in the hard irq handler
>> without context switch. Moreover if we remove the BLK_MQ_F_BLOCKING in
>> future like you suggested, then we can remove all context switch. And
>> I think we can dispatch next request in the softirq context (actually
>> the CQE already did).
> 
> I hope Hannes (or someone else) can comment here, as I don't
> know exactly what his objection to kicking off the next cmd in the
> hardirq was.
> 
The point being that you'll have to have a context switch anyway
(between hardirq and softirq), and you'll be able to better handle
recovery as the hardirq handler is pretty generic and the won't be any
chance of that one becoming stuck.
And, of course, modern software design :-)

> I think generally, deferring all slow operations to an irqthread
> rather than a softirq is a good idea, but I share your concern that
> this can introduce an unnecessary latency between the the
> the IRQ is signaled and the time the following cmd is sent to the
> hardware.
> > Doing everything in a single (irqthread) context is clearly simpler,
> so this would need to be measured carefully to avoid unnecessary
> complexity, but I think don't see anything stopping us from having
> the fast-path where the low-level driver first checks for any possible
> error conditions in hardirq context and the fires off a prepared cmd
> right away whenever it can before triggering the irqthread that does
> everything else. I think this has to be a per-driver optimization, so
> the common case would just have an irqthread.
> 
>> 3) For packed request support, I did not see an example that block
>> driver can dispatch a request from the IO scheduler in queue_rq() and
>> no APIs supported from blk-mq. And we do not know where can dispatch a
>> request in queue_rq(), from IO scheduler? from ctx? or from
>> hctx->dispatch list? and if this request can not be passed to host
>> now, how to do it? Seems lots of complicated things.
> 
> The only way I can see is the ->last flag, so if blk_mq submits multiple
> requests in a row to queue_rq() with this flag cleared and  calls
> ->commit_rqs() after the last one. This seems to be what the scsi
> disk driver and the nvme driver rely on, and we should be able to use
> it the same way for packed cmds, by checking each time in queue_rq()
> whether requests can/should be combined and reporting busy otherwise
> (after preparing a combined mmc cmd).
> blk_mq will then call commit_rqs, which should do the actual submission
> to the hardware driver.
> 
The ->last flag really depends on the submission thread, eg if something
in the upper layers is using on-stack plugging.
In my experience this is done only in some specific use-cases resp.
filesystems, so this is not something you can rely on to make any decisions.

> Now as you point out, the *big* problem with this is that we never
> get multiple requests together in practice, i.e. the last flag is almost
> always set, and any optimization around it has no effect.
> 
See above. I don't think the using the ->last flag is the way to go here.
What you really need to do here is to inject some 'pushback' into the
block layer so that is has a _chance_ of assembling more requests.

But the actual design really needs to take hardware features into account.

As mentioned above, initially I would concentrate on getting the
partitioning working with a single request queue; once that is done we
can look at request batching proper.

And for that you could have a look at the S/390 DASD driver (right,
Arndt?), which has a very similar concept.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      Teamlead Storage & Networking
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
