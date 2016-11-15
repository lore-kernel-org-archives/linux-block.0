Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0078.outbound.protection.outlook.com ([104.47.42.78]:61388
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751599AbcKOTxs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Nov 2016 14:53:48 -0500
Subject: Re: [PATCH V4 00/15] blk-throttle: add .high limit
To: Shaohua Li <shli@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>
References: <cover.1479161136.git.shli@fb.com>
 <986ada43-3217-3277-724a-5c76f8dad74e@sandisk.com>
 <20161115000529.GA15160@shli-mbp.local>
 <cac5ee16-1400-2fff-3948-fa1dea997702@sandisk.com>
 <20161115004922.GA16173@shli-mbp.local>
 <1bf8605a-9920-19ea-e2ab-2f3d747e55be@sandisk.com>
 <20161115012857.GA17239@shli-mbp.local>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "axboe@fb.com" <axboe@fb.com>, "tj@kernel.org" <tj@kernel.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <6f33c69f-f382-1515-d83d-f1109f982ab3@sandisk.com>
Date: Tue, 15 Nov 2016 11:53:39 -0800
MIME-Version: 1.0
In-Reply-To: <20161115012857.GA17239@shli-mbp.local>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 11/14/2016 05:28 PM, Shaohua Li wrote:
> On Mon, Nov 14, 2016 at 05:18:28PM -0800, Bart Van Assche wrote:
>> Unless someone can convince me of the opposite I think that coming up with
>> an algorithm for estimating I/O cost is essential to guarantee I/O fairness
>> without requesting users to perform complicated parameter configurations.
>
> That's what I tried before:
> http://marc.info/?l=linux-kernel&m=145617863208940&w=2

That URL refers to v2 of this patch series. Sorry but I have not found 
the I/O cost estimation algorithm I was referring to in v2 of this patch 
series.

Bart.
