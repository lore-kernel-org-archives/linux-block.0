Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7126DC433E0
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 08:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5262075F
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 08:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgE1Iar (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 04:30:47 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2252 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbgE1Iar (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 04:30:47 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 072064170420A9FD2543;
        Thu, 28 May 2020 09:30:46 +0100 (IST)
Received: from [127.0.0.1] (10.47.2.211) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Thu, 28 May
 2020 09:30:45 +0100
Subject: Re: blk-mq: improvement CPU hotplug (simplified version) v4
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200527180644.514302-1-hch@lst.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b98f055f-6f38-a47c-965d-b6bcf4f5563f@huawei.com>
Date:   Thu, 28 May 2020 09:29:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200527180644.514302-1-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.2.211]
X-ClientProxiedBy: lhreml708-chm.china.huawei.com (10.201.108.57) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 27/05/2020 19:06, Christoph Hellwig wrote:
> Hi all,
> 
> this series ensures I/O is quiesced before a cpu and thus the managed
> interrupt handler is shut down.
> 
> This patchset tries to address the issue by the following approach:
> 
>   - before the last cpu in hctx->cpumask is going to offline, mark this
>     hctx as inactive
> 
>   - disable preempt during allocating tag for request, and after tag is
>     allocated, check if this hctx is inactive. If yes, give up the
>     allocation and try remote allocation from online CPUs
> 
>   - before hctx becomes inactive, drain all allocated requests on this
>     hctx
> 
> The guts of the changes are from Ming Lei, I just did a bunch of prep
> cleanups so that they can fit in more nicely.  The series also depends
> on my "avoid a few q_usage_counter roundtrips v3" series.
> 
> Thanks John Garry for running lots of tests on arm64 with this previous
> version patches and co-working on investigating all kinds of issues.
> 
> A git tree is available here:
> 
>      git://git.infradead.org/users/hch/block.git blk-mq-hotplug.3
> 
> Gitweb:
> 
>      http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-mq-hotplug.3
> 
> Changes since v3:
>    - add two new patches to clean up the magic -1 tag values
>    - improve a few commit messages and comments
>    - cleanup the blk_mq_all_tag_iter implementation
>    - add a msleep to the cpu hot unplug case in __blk_mq_alloc_request
> 
> Changes since v2:
>    - don't disable preemption and use smp calls
> 

I tested this again, so:
Tested-by: John Garry <john.garry@huawei.com>

As an aside, I'm not familiar with blktests, but it may be possible to 
add something to test this. I'll look.

Cheers
