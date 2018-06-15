Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42295 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755405AbeFOQ4D (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jun 2018 12:56:03 -0400
Subject: Re: [PATCH] brd: Allow ramdisk to be allocated on selected NUMA node
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "mgorman@suse.com" <mgorman@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>
References: <20180614133832.110947-1-hare@suse.de>
 <78b2e2924ee3ef28dcb900a3807a78d6d0fe57e0.camel@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <9413635e-c293-d1eb-8edc-96d2e2d45f2d@suse.de>
Date: Fri, 15 Jun 2018 18:55:58 +0200
MIME-Version: 1.0
In-Reply-To: <78b2e2924ee3ef28dcb900a3807a78d6d0fe57e0.camel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/15/2018 04:07 PM, Bart Van Assche wrote:
> On Thu, 2018-06-14 at 15:38 +0200, Hannes Reinecke wrote:
>> For performance reasons we should be able to allocate all memory
>> from a given NUMA node, so this patch adds a new parameter
>> 'rd_numa_node' to allow the user to specify the NUMA node id.
>> When restricing fio to use the same NUMA node I'm seeing a performance
>> boost of more than 200%.
> 
> Passing this information through a kernel module parameter to the brd kernel
> module seems wrong to me. There can be multiple brd instances. Using a kernel
> module parameter makes it impossible to specify a different NUMA node for
> different brd instances.
> 
This patch has primarily done for simplicity; all the existing brd 
parameters affect _all_ ramdisks, so this patch keeps that style.

If you want soemthing more fine-grained you could use the approach 
suggested by Mel Gorman and use 'numactl' to pre-fill the ramdisk via 'dd'.

Cheers,

Hannes
