Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45300 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeHQLXw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Aug 2018 07:23:52 -0400
Received: by mail-pl0-f66.google.com with SMTP id j8-v6so3375395pll.12
        for <linux-block@vger.kernel.org>; Fri, 17 Aug 2018 01:21:25 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/1] lightnvm: move bad block and chunk state logic
 to core
To: javier@cnexlabs.com
Cc: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180816113417.3641-1-mb@lightnvm.io>
 <00698BD3-4382-4033-908F-BEB63E7FAD57@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <2ed73237-2657-17a8-7134-2267ffb7e35d@lightnvm.io>
Date: Fri, 17 Aug 2018 10:21:19 +0200
MIME-Version: 1.0
In-Reply-To: <00698BD3-4382-4033-908F-BEB63E7FAD57@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/16/2018 05:53 PM, Javier Gonzalez wrote:
>> On 16 Aug 2018, at 13.34, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> This patch moves the 1.2 and 2.0 block/chunk metadata retrieval to
>> core.
>>
>> Hi Javier, I did not end up using your patch. I had misunderstood what
>> was implemented. Instead I implemented the detection of the each chunk by
>> first sensing the first page, then the last page, and if the chunk
>> is sensed as open, a per page scan will be executed to update the write
>> pointer appropriately.
>>
> 
> I see why you want to do it this way for maintaining the chunk
> abstraction, but this is potentially very inefficient as blocks not used
> by any target will be recovered unnecessarily. 

True. It will up to the target to not ask for more metadata than 
necessary (similarly for 2.0)

Note that in 1.2, it is
> expected that targets will need to recover the write pointer themselves.
> What is more, in the normal path, this will be part of the metadata
> being stored so no wp recovery is needed. Still, this approach forces
> recovery on each 1.2 instance creation (also on factory reset). In this
> context, you are right, the patch I proposed only addresses the double
> erase issue, which was the original motivator, and left the actual
> pointer recovery to the normal pblk recovery process.
> 
> Besides this, in order to consider this as a real possibility, we need
> to measure the impact on startup time. For this, could you implement
> nvm_bb_scan_chunk() and nvm_bb_chunk_sense() more efficiently by
> recovering (i) asynchronously and (ii) concurrently across luns so that
> we can establish the recovery cost more fairly? We can look at a
> specific penalty ranges afterwards.

Honestly, 1.2 is deprecated. I don't care about the performance, I care 
about being easy to maintain, so it doesn't borg me down in the future.

Back of the envelope calculation for a 64 die SSD with 1024 blocks per 
die, and 60us read time, will take 4 seconds to scan if all chunks are 
free, a worst case something like ~10 seconds. -> Not a problem for me.

> 
> Also, the recovery scheme in pblk will change significantly by doing
> this, so I assume you will send a followup patchset reimplementing
> recovery for the 1.2 path? 

The 1.2 path shouldn't be necessary after this. That is the idea of this 
work. Obviously, the set bad block interface will have to preserved and 
called.
