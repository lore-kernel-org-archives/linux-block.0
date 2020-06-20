Return-Path: <SRS0=essW=AB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDB7C433DF
	for <linux-block@archiver.kernel.org>; Sat, 20 Jun 2020 00:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7354322581
	for <linux-block@archiver.kernel.org>; Sat, 20 Jun 2020 00:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgFTAQj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 20:16:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35786 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730616AbgFTAQj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 20:16:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 2554B2A52D2
Subject: Re: [PATCH v3] docs: block: Create blk-mq documentation
To:     Jens Axboe <axboe@kernel.dk>, corbet@lwn.net,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, rdunlap@infradead.org,
        dongli.zhang@oracle.com
References: <20200619200114.6896-1-andrealmeid@collabora.com>
 <c2f83c87-f473-4d30-2430-442e957de14f@kernel.dk>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <36fcdfc6-4ba2-fdfc-411c-e337d2d86ea5@collabora.com>
Date:   Fri, 19 Jun 2020 21:16:29 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c2f83c87-f473-4d30-2430-442e957de14f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/20 5:56 PM, Jens Axboe wrote:
> On 6/19/20 2:01 PM, André Almeida wrote:
>> Create a documentation providing a background and explanation around the
>> operation of the Multi-Queue Block IO Queueing Mechanism (blk-mq).
>>
>> The reference for writing this documentation was the source code and
>> "Linux Block IO: Introducing Multi-queue SSD Access on Multi-core
>> Systems", by Axboe et al.
>>
>> Signed-off-by: André Almeida <andrealmeid@collabora.com>
>> ---
>> Changes from v2:
>> - More fixed typos
>> - Once again, reworked the definition of `blk_mq_hw_ctx` in "Hardware
>>   dispatch queues" section
>>
>> Changes from v1:
>> - Fixed typos
>> - Reworked blk_mq_hw_ctx
>>
>> Hello,
>>
>> This commit was tested using "make htmldocs" and the HTML output has
>> been verified.
>>
>> Thanks,
>> 	André
>> ---
>>  Documentation/block/blk-mq.rst | 155 +++++++++++++++++++++++++++++++++
>>  Documentation/block/index.rst  |   1 +
>>  2 files changed, 156 insertions(+)
>>  create mode 100644 Documentation/block/blk-mq.rst
>>
>> diff --git a/Documentation/block/blk-mq.rst b/Documentation/block/blk-mq.rst
>> new file mode 100644
>> index 000000000000..d1b8f04a822d
>> --- /dev/null
>> +++ b/Documentation/block/blk-mq.rst
>> @@ -0,0 +1,155 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +================================================
>> +Multi-Queue Block IO Queueing Mechanism (blk-mq)
>> +================================================
>> +
>> +The Multi-Queue Block IO Queueing Mechanism is an API to enable fast storage
>> +devices to achieve a huge number of input/output operations per second (IOPS)
>> +through queueing and submitting IO requests to block devices simultaneously,
>> +benefiting from the parallelism offered by modern storage devices.
>> +
>> +Introduction
>> +============
>> +
>> +Background
>> +----------
>> +
>> +Magnetic hard disks have been the de facto standard from the beginning of the
>> +development of the kernel. The Block IO subsystem aimed to achieve the best
>> +performance possible for those devices with a high penalty when doing random
>> +access, and the bottleneck was the mechanical moving parts, a lot slower than
>> +any layer on the storage stack. One example of such optimization technique
>> +involves ordering read/write requests according to the current position of the
>> +hard disk head.
>> +
>> +However, with the development of Solid State Drives and Non-Volatile Memories
>> +without mechanical parts nor random access penalty and capable of performing
>> +high parallel access, the bottleneck of the stack had moved from the storage
>> +device to the operating system. In order to take advantage of the parallelism
>> +in those devices' design, the multi-queue mechanism was introduced.
>> +
>> +The former design had a single queue to store block IO requests with a single
>> +lock. That did not scale well in SMP systems due to dirty data in cache and the
>> +bottleneck of having a single lock for multiple processors. This setup also
>> +suffered with congestion when different processes (or the same process, moving
>> +to different CPUs) wanted to perform block IO. Instead of this, the blk-mq API
>> +spawns multiple queues with individual entry points local to the CPU, removing
>> +the need for a lock. A deeper explanation on how this works is covered in the
>> +following section (`Operation`_).
>> +
>> +Operation
>> +---------
>> +
>> +When the userspace performs IO to a block device (reading or writing a file,
>> +for instance), blk-mq takes action: it will store and manage IO requests to
>> +the block device, acting as middleware between the userspace (and a file
>> +system, if present) and the block device driver.
>> +
>> +blk-mq has two group of queues: software staging queues and hardware dispatch
>> +queues. When the request arrives at the block layer, it will try the shortest
>> +path possible: send it directly to the hardware queue. However, there are two
>> +cases that it might not do that: if there's an IO scheduler attached at the
>> +layer or if we want to try to merge requests. In both cases, requests will be
>> +sent to the software queue.
>> +
>> +Then, after the requests are processed by software queues, they will be placed
>> +at the hardware queue, a second stage queue were the hardware has direct access
>> +to process those requests. However, if the hardware does not have enough
>> +resources to accept more requests, blk-mq will places requests on a temporary
>> +queue, to be sent in the future, when the hardware is able.
>> +
>> +Software staging queues
>> +~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +The block IO subsystem adds requests (represented by struct
>> +:c:type:`blk_mq_ctx`) in the software staging queues in case that they weren't
> 
> This reads a bit funny, did you want to put the blk_mq_ctx thing after
> the "software staging queues"? Right now it looks like the requests are
> of that type, which of course isn't true.
> 

Oops, good catch.

>> +sent directly to the driver. A request is a collection of BIOs. They arrived at
> 
> I'd say "one or more BIOs", as there can be just one.
> 

Done.

>> +IO Schedulers
>> +^^^^^^^^^^^^^
>> +
>> +There are several schedulers implemented by the block layer, each one following
>> +a heuristic to improve the IO performance. They are "pluggable" (as in plug
>> +and play), in the sense of they can be selected at run time using sysfs. You
>> +can read more about Linux's IO schedulers `here
>> +<https://www.kernel.org/doc/html/latest/block/index.html>`_. The scheduling
>> +happens only between requests in the same queue, so it is not possible to merge
>> +requests from different queues, otherwise there would be cache trashing and a
>> +need to have a lock for each queue. After the scheduling, the requests are
>> +eligible to be sent to the hardware. One of the possible schedulers to be
>> +selected is the NOOP scheduler, the most straightforward one, that implements a
>> +simple FIFO, without performing any reordering. This is useful in the following
> 
> NOOP is a relic from the single queue days, the basic "doesn't do much"
> scheduler is NONE these days. And it doesn't provide FIFO ordering,
> requests will basically just end up in whatever software queue the
> process is running on. When someone runs the hardware queue, the
> software queues mapped to that hardware queue will be drained in
> sequence according to their mapping (generally from 0..N, if 0..N are
> mapped to that hardware queue).
> 

Thanks for the feedback. I replaced this part of the text with a basic
explanation about NONE scheduler based on your words.

v4 on the way.
