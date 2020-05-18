Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B65FC433DF
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 11:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D3E020758
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 11:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgERLuM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 07:50:12 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2219 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726585AbgERLuM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 07:50:12 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 34342C964F80A3DCC410;
        Mon, 18 May 2020 12:50:11 +0100 (IST)
Received: from [127.0.0.1] (10.210.170.146) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 18 May
 2020 12:50:10 +0100
Subject: Re: blk-mq: improvement CPU hotplug (simplified version) v2
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200518063937.757218-1-hch@lst.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6241656e-0bf7-b32d-493e-e3f870a4d031@huawei.com>
Date:   Mon, 18 May 2020 12:49:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200518063937.757218-1-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.146]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/05/2020 07:39, Christoph Hellwig wrote:
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
>      git://git.infradead.org/users/hch/block.git blk-mq-hotplug
> 
> Gitweb:
> 
>      http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-mq-hotplug
> .
> 

FWIW, I tested this series for cpu hotplug and it looked ok.

john
