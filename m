Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10960C433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 23:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E672075B
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 23:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c91DBXh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgFEXpw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 19:45:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34484 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgFEXpv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jun 2020 19:45:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055Nh37C042841;
        Fri, 5 Jun 2020 23:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=JqTqGTpD5lPEvIy9rv8hiKVmI+4mibOk37PFkLI/YRg=;
 b=c91DBXh5PdmxmqsfwAe7zhWFvoyaBjKXwPkPCJJsXvIn8Uo2B1c75zyV72SX9KSf1joa
 9omNpR4cKfz445qF3vJ/d0hj+HZxVaoYTlckg+RtP5uUN0erirL3c5h1Hv9qeZuGsYhX
 W+7T9aGoCKJNSw5kYS+A7oduTONqBo9ch4c7fZ1R1F1wKIULsDu6XfL8hJc7GpiXXlmJ
 1OFOakV3sSk7IlHLgSy+48hTFtQBqh0g83gsE0sz9mEtd3vIvnK2VHxs1vgRJbLYUe1o
 1Q0fVvaM8x/xxy3YbFq69+YIIuOpGoEyeRTrfgPvxb6PFmVSfzpW9oZXjlT/49nphouc mQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31f9265292-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 05 Jun 2020 23:45:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055NhRug120047;
        Fri, 5 Jun 2020 23:45:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 31f92tcqxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jun 2020 23:45:35 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 055NjWtj020132;
        Fri, 5 Jun 2020 23:45:34 GMT
Received: from [10.159.235.153] (/10.159.235.153)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Jun 2020 16:45:31 -0700
Subject: Re: [PATCH v2] docs: block: Create blk-mq documentation
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        axboe@kernel.dk, corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, rdunlap@infradead.org
References: <20200605175536.19681-1-andrealmeid@collabora.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <c249992b-a7c6-b6d9-3edb-143255141da2@oracle.com>
Date:   Fri, 5 Jun 2020 16:45:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200605175536.19681-1-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9643 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050176
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9643 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 cotscore=-2147483648 bulkscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050176
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi André,

On 6/5/20 10:55 AM, André Almeida wrote:
> Create a documentation providing a background and explanation around the
> operation of the Multi-Queue Block IO Queueing Mechanism (blk-mq).
> 
> The reference for writing this documentation was the source code and
> "Linux Block IO: Introducing Multi-queue SSD Access on Multi-core
> Systems", by Axboe et al.
> 
> Signed-off-by: André Almeida <andrealmeid@collabora.com>
> ---
> Changes from v1:
> - Fixed typos
> - Reworked blk_mq_hw_ctx
> 
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
> index 000000000000..1f702adbc577
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
> +However, with the development of Solid State Drives and Non-Volatile Memories
> +without mechanical parts nor random access penalty and capable of performing
> +high parallel access, the bottleneck of the stack had moved from the storage
> +device to the operating system. In order to  take advantage of the parallelism
> +in those devices design, the multi-queue mechanism was introduced.
> +
> +The former design had a single queue to store block IO requests with a single
> +lock. That did not scale well in SMP systems due to dirty data in cache and the
> +bottleneck of having a single lock for multiple processors. This setup also
> +suffered with congestion when different processes (or the same process, moving
> +to different CPUs) wanted to perform block IO. Instead of this, the blk-mq API
> +spawns multiple queues with individual entry points local to the CPU, removing
> +the need for a lock. A deeper explanation on how this works is covered in the
> +following section (`Operation`_).
> +
> +Operation
> +---------
> +
> +When the userspace performs IO to a block device (reading or writing a file,
> +for instance), blk-mq takes action: it will store and manage IO requests to
> +the block device, acting as middleware between the userspace (and a file
> +system, if present) and the block device driver.
> +
> +blk-mq has two group of queues: software staging queues and hardware dispatch
> +queues. When the request arrives at the block layer, it will try the shortest
> +path possible: send it directly to the hardware queue. However, there are two
> +cases that it might not do that: if there's an IO scheduler attached at the
> +layer or if we want to try to merge requests. In both cases, requests will be
> +sent to the software queue.
> +
> +Then, after the requests are processed by software queues, they will be placed
> +at the hardware queue, a second stage queue were the hardware has direct access
> +to process those requests. However, if the hardware does not have enough
> +resources to accept more requests, blk-mq will places requests on a temporary
> +queue, to be sent in the future, when the hardware is able.
> +
> +Software staging queues
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The block IO subsystem adds requests (represented by struct
> +:c:type:`blk_mq_ctx`) in the software staging queues in case that they weren't
> +sent directly to the driver. A request is a collection of BIOs. They arrived at
> +the block layer through the data structure struct :c:type:`bio`. The block
> +layer will then build a new structure from it, the struct :c:type:`request`
> +that will be used to communicate with the device driver. Each queue has its
> +own lock and the number of queues is defined by a per-CPU or per-node basis.
> +
> +The staging queue can be used to merge requests for adjacent sectors. For
> +instance, requests for sector 3-6, 6-7, 7-9 can become one request for 3-9.
> +Even if random access to SSDs and NVMs have the same time of response compared
> +to sequential access, grouped requests for sequential access decreases the
> +number of individual requests. This technique of merging requests is called
> +plugging.
> +
> +Along with that, the requests can be reordered to ensure fairness of system
> +resources (e.g. to ensure that no application suffers from starvation) and/or to
> +improve IO performance, by an IO scheduler.
> +
> +IO Schedulers
> +^^^^^^^^^^^^^
> +
> +There are several schedulers implemented by the block layer, each one following
> +a heuristic to improve the IO performance. They are "pluggable" (as in plug
> +and play), in the sense of they can be selected at run time using sysfs. You
> +can read more about Linux's IO schedulers `here
> +<https://www.kernel.org/doc/html/latest/block/index.html>`_. The scheduling
> +happens only between requests in the same queue, so it is not possible to merge
> +requests from different queues, otherwise there would be cache trashing and a
> +need to have a lock for each queue. After the scheduling, the requests are
> +eligible to be sent to the hardware. One of the possible schedulers to be
> +selected is the NOOP scheduler, the most straightforward one, that implements a
> +simple FIFO, without performing any reordering. This is useful in the following
> +scenarios: when scheduling will be performed in a next step somewhere in the
> +stack, like block device controllers; the actual sector position of blocks are
> +transparent for the host, meaning it hasn't enough information to take a proper
> +decision; or the overhead of reordering is higher than the handicap of
> +non-sequential accesses.
> +
> +Hardware dispatch queues
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The hardware queues (represented by struct :c:type:`blk_mq_hw_ctx`) have a 1:1
> +correspondence to the device driver's submission queues, and are the last step

I am not clear with the definition of "submission queues". Is it the device
queue with DMA ring buffer?

If it is the DMA ring buffer, multiple blk_mq_hw_ctx would map to the same DMA
ring buffer, e.g., multiple nvme namespaces would share the same tagset. This is
not 1:1 any longer.

> +of the block layer submission code before the low level device driver taking
> +ownership of the request. To run this queue, the block layer removes requests
> +from the associated software queues and tries to dispatch to the hardware.
> +
> +If it's not possible to send the requests directly to hardware, they will be
> +added to a linked list (:c:type:`hctx->dispatch`) of requests. Then,
> +next time the block layer runs a queue, it will send the requests laying at the
> +:c:type:`dispatch` list first, to ensure a fairness dispatch with those
> +requests that were ready to be sent first. The number of hardware queues
> +depends on the number of hardware contexts supported by the hardware and its
> +device driver, but it will not be more than the number of cores of the system.
> +There is no reordering at this stage, and each software queue has a set of
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

Assume I am a beginner and does not know about blk-mq well. What I expect is to
expand this sections to explain the usage of sbitmap to manage tags, e.g., like
the comments in block/blk-mq-tag.c or block/blk-mq-tag.h.

In addition, I would be interested in that percpu-refcount is used to track the
lifecycle of requests.

I have no idea how much detail is required for a kernel doc. The is just the
feedback from me by assuming the audience is beginner :)

Thank you very much!

Dongli Zhang
