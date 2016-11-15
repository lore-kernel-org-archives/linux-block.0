Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-co1nam03on0072.outbound.protection.outlook.com ([104.47.40.72]:1920
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932823AbcKOBSk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2016 20:18:40 -0500
Subject: Re: [PATCH V4 00/15] blk-throttle: add .high limit
To: Shaohua Li <shli@fb.com>
References: <cover.1479161136.git.shli@fb.com>
 <986ada43-3217-3277-724a-5c76f8dad74e@sandisk.com>
 <20161115000529.GA15160@shli-mbp.local>
 <cac5ee16-1400-2fff-3948-fa1dea997702@sandisk.com>
 <20161115004922.GA16173@shli-mbp.local>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "axboe@fb.com" <axboe@fb.com>, "tj@kernel.org" <tj@kernel.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <1bf8605a-9920-19ea-e2ab-2f3d747e55be@sandisk.com>
Date: Mon, 14 Nov 2016 17:18:28 -0800
MIME-Version: 1.0
In-Reply-To: <20161115004922.GA16173@shli-mbp.local>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 11/14/2016 04:49 PM, Shaohua Li wrote:
> On Mon, Nov 14, 2016 at 04:41:33PM -0800, Bart Van Assche wrote:
>> Thank you for pointing me to the discussion thread about v3 of this patch
>> series. Did I see correctly that one of the conclusions was that for users
>> this mechanism is hard to configure? Are we providing a good service to
>> Linux users by providing a mechanism that is hard to configure?
>
> Yes, this is a kind of low level knob and is expected to be configured by
> experienced users. This sucks, but we really don't have good solutions. If
> anybody has better ideas, I'm happy to try.

Hello Shaohua,

An approach I have been considering to analyze further is as follows:
* For rotational media use an algorithm like BFQ to preserve 
sequentiality of workloads and to guarantee fairness. This means that 
one application submits I/O per time slot.
* For SSDs, multiplex I/O from multiple applications during a single 
time slot to keep the queue depth high. Throttle I/O if needed to 
realize fairness.

Implementing this approach requires an approach for estimating I/O cost 
based on the request characteristics (offset and size) and the device 
type (rotational or SSD). This may require measuring the time that was 
needed to process past requests and to use that information in a 
learning algorithm.

Unless someone can convince me of the opposite I think that coming up 
with an algorithm for estimating I/O cost is essential to guarantee I/O 
fairness without requesting users to perform complicated parameter 
configurations.

Bart.


