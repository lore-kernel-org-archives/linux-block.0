Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E33C433DF
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 21:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF8920899
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 21:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gqOl6c43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgE0V6q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 17:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgE0V6q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 17:58:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420ADC05BD1E;
        Wed, 27 May 2020 14:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=IRTVVjTV1C3WazgNezb1yyG496ISz9nbjFNx2H7Mmps=; b=gqOl6c4382vseqQUWmR0svPgWL
        TihYGlhI0el12tSZroskvgko3dIspmltEHMjJ+11/ziABHNdmnXrospMJQ59Lkss/wR5WgmvEOT1h
        g4I/zb4sho84AF2/YbxA3W4GfmNRlOl438qzwMR7EFjG6d8q0WPidYFu11v50E6EMcZtxKngGzkr3
        0GQt51s37S6BhrvplwXk1Egldq2DU4xJj9peRMm4WzSLIW3Q0sIYem34pQDI6i4sI/R5dsqIThV3A
        91yIiA38sMavhIBllgZfOt3JcqvpjVLKYDeetVX0hxV3xJMPgxKDcsqUvawXK9k0LlwEn6SksfK1i
        dFD79TAw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1je44P-0003Qm-Lv; Wed, 27 May 2020 21:58:41 +0000
Subject: Re: [PATCH] docs: block: Create blk-mq documentation
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        axboe@kernel.dk, corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com
References: <20200527200939.77452-1-andrealmeid@collabora.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <63d78a87-0953-ada4-266d-42279f4351d8@infradead.org>
Date:   Wed, 27 May 2020 14:58:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527200939.77452-1-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/20 1:09 PM, André Almeida wrote:
> Create a documentation providing a background and explanation around the
> operation of the Multi-Queue Block IO Queueing Mechanism (blk-mq).
> 
> The reference for writing this documentation was the source code and
> "Linux Block IO: Introducing Multi-queue SSD Access on Multi-core
> Systems", by Axboe et al.
> 
> Signed-off-by: André Almeida <andrealmeid@collabora.com>
> ---
> Hello,
> 
> This commit was tested using "make htmldocs" and the HTML output has
> been verified.
> 
> Thanks,
> 	André
> ---
>  Documentation/block/blk-mq.rst | 154 +++++++++++++++++++++++++++++++++
>  Documentation/block/index.rst  |   1 +
>  2 files changed, 155 insertions(+)
>  create mode 100644 Documentation/block/blk-mq.rst
> 
> diff --git a/Documentation/block/blk-mq.rst b/Documentation/block/blk-mq.rst
> new file mode 100644
> index 000000000000..4c37b37df50e
> --- /dev/null
> +++ b/Documentation/block/blk-mq.rst
> @@ -0,0 +1,154 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================================================
> +Multi-Queue Block IO Queueing Mechanism (blk-mq)
> +================================================
> +
> +The Multi-Queue Block IO Queueing Mechanism is an API to enable fast storage
> +devices to achieve a huge number of input/output operations per second (IOPS)
> +through queueing and submitting IO requests to block devices simultaneously,
> +benefiting from the parallelism offered by modern storage devices.
> +
> +Introduction
> +============
> +
> +Background
> +----------
> +
> +Magnetic hard disks have been the de facto standard from the beginning of the
> +development of the kernel. The Block IO subsystem aimed to achieve the best
> +performance possible for those devices with a high penalty when doing random
> +access, and the bottleneck was the mechanical moving parts, a lot more slower
> +than any layer on the storage stack. One example of such optimization technique
> +involves ordering read/write requests accordingly to the current position of
> +the hard disk head.
> +
> +However, with the development of Solid State Drivers and Non-Volatile Memories

                                                Drives  ??
\
> +without mechanical parts nor random access penalty and capable of performing
> +high parallel access, the bottleneck of the stack had moved from the storage
> +device to the operating system. In order to  take advantage of the parallelism
> +in those devices design, the multi-queue mechanism was introduced.
> +
> +The former design had a single queue to store block IO requests with a single
> +lock, that did not scale well in SMP systems due to dirty data in cache and the

   lock. That did not

> +bottleneck of having a single lock for multiple processors. This setup also
> +suffered with congestion when different processes (or the same process, moving
> +to different CPUs) wanted to perform block IO. Instead of this, this API spawns

                                                  Instead of this, the blk-mq API spawns

> +multiple queues with individual entry points local to the CPU, removing the
> +need for a lock. A deeper explanation on how this works is covered in the
> +following section (`Operation`_).
> +
> +Operation
> +---------
> +
> +When the userspace performs IO to a block device (reading or writing a file,
> +for instance), the blk-mq takes action: it will store and manage IO requests to

                  blk-mq takes action:

> +the block device, acting as a middleware between the userspace (and a file

                     acting as middleware

> +system, if present) and the block device driver.
> +
> +The blk-mq has two group of queues: software staging queues and hardware

   The blk-mq mechanism has two groups
or just
   blk-mq has two groups

> +dispatch queues. When the request arrives the block layer, it will try the

                                     arrives at the block layer,

> +shortest path possible: send it directly to the hardware queue. However, there
> +are two cases that it might not to do that: if there's an IO scheduler attached

                         might not do that:

> +at the layer or if we want to try to merge requests. In both cases, requests
> +will be sent to the software queue.
> +
> +Then, after the requests being processed at software queues, they will be

         after the requests are processed at [or by] software queues,

> +placed at the hardware queue, a second stage queue were the hardware has direct
> +access to process those requests. However, if the hardware has not enough

                                                     hardware does not have enough

> +resources to accept more requests, it will place requests at temporary queue,

What does "it" refer to?             ^^^^
                                              places requests on a temporary queue,

> +to be sent in the future, when the hardware is able.
> +
> +Software staging queues
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The block IO subsystem adds requests (represented by struct
> +:c:type:`blk_mq_ctx`) in the software staging queues in case that they weren't
> +sent directly to the driver. A request is a collection of BIOs. They arrived at
> +the block layer through the data structures struct :c:type:`bio`. The block

                               data structure

> +layer will then build a new structure from it, the struct :c:type:`request`
> +that will be used to communicate with the device driver. Each queue has its
> +owns lock and the number of queues is defined by a per-CPU or per-node basis.

   own

> +
> +The staging queue can be used to merge requests for adjacent sectors. For
> +instance, requests for sector 3-6, 6-7, 7-9 can become one request for 3-9.
> +Even if random access to SSDs and NVMs have the same time of response compared
> +to sequential access, grouped requests for sequential access decreases the
> +number of individual requests. This technique of merging requests is called
> +plugging.
> +
> +Along with that, the requests can be reordered to ensure fairness of system
> +resources (e.g. to ensure that no application suffer from starvation) and/or to

                                                 suffers

> +improve IO performance, by an IO scheduler.
> +
> +IO Schedulers
> +^^^^^^^^^^^^^
> +
> +There are several schedulers implemented by the block layer, each one following
> +a heuristics to improve the IO performance. They are "pluggable" (as in plug

   a heuristic

> +and play), in the sense of they can be selected at run time using sysfs. You
> +can read more about Linux's IO schedulers `here
> +<https://www.kernel.org/doc/html/latest/block/index.html>`_. The scheduling
> +happens only between requests in the same queue, so it is not possible to merge
> +requests from different queues, otherwise there would be cache trashing and a
> +need to have a lock for each queue. After the scheduling, the requests are
> +eligible to be sent to the hardware. One of the possibles schedulers to be

                                                   possible

> +selected is the NOOP scheduler, the most straightforward one, that implements a
> +simple FIFO, without performing any reordering. This is useful in the following
> +scenarios: when scheduling will be performed in a next step somewhere in the
> +stack, like block devices controllers; the actual sector position of blocks are

                     device

> +transparent for the host, meaning it hasn't enough information to take a proper
> +decision; or the overhead of reordering is higher than the handicap of
> +non-sequential accesses.
> +
> +Hardware dispatch queues
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The hardware queue is a memory space shared with the block device (e.g. DMA)
> +where the hardware can access and dispatch requests (represented by struct
> +:c:type:`blk_mq_hw_ctx`). To run this queue, the block layer removes
> +requests from the associated software queues and tries to dispatch to the
> +hardware.

This paragraph (above) says to me that these HW devices understand struct blk_mq_hw_ctx.
Is that correct?  Is is some kind of standard?  If so, where?

> +If it's not possible to send the requests directly to hardware, they will be
> +added to a linked list (:c:type:`hctx->dispatched`) of requests. Then,
> +next time the block layer runs a queue, it will send the requests laying at the
> +:c:type:`dispatched` list first, to ensure a fairness dispatch with those
> +requests that were ready to be sent first. The number of hardware queues
> +depends on the number of hardware context supported by the hardware and its

                                     contexts

> +device driver, but it will not be more than the number of cores of the system.
> +There is no reordering at this stage, and each software queues has a set of

                                                           queue

> +hardware queues to send requests for.
> +
> +.. note::
> +
> +        Neither the block layer nor the device protocols guarantee
> +        the order of completion of requests. This must be handled by
> +        higher layers, like the filesystem.
> +
> +Tag-based completion
> +~~~~~~~~~~~~~~~~~~~~
> +
> +In order to indicate which request has been completed, every request is
> +identified by an integer, ranging from 0 to the dispatch queue size. This tag
> +is generated by the block layer and later reused by the device driver, removing
> +the need to create a redundant identifier. When a request is completed in the
> +drive, the tag is sent back to the block layer to notify it of the finalization.
> +This removes the need to do a linear search to find out which IO has been
> +completed.
> +
> +Further reading
> +---------------
> +
> +- `Linux Block IO: Introducing Multi-queue SSD Access on Multi-core Systems <http://kernel.dk/blk-mq.pdf>`_
> +
> +- `NOOP scheduler <https://en.wikipedia.org/wiki/Noop_scheduler>`_
> +
> +- `Null block device driver <https://www.kernel.org/doc/html/latest/block/null_blk.html>`_
> +
> +Source code documentation
> +=========================
> +
> +.. kernel-doc:: include/linux/blk-mq.h
> +
> +.. kernel-doc:: block/blk-mq.c


thanks for the documentation.
-- 
~Randy

