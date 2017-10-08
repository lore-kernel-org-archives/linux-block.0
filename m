Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:43887 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbdJHE5j (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Oct 2017 00:57:39 -0400
Received: by mail-pg0-f48.google.com with SMTP id s184so10044056pgc.0
        for <linux-block@vger.kernel.org>; Sat, 07 Oct 2017 21:57:39 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] bcache: implement PI controller for writeback rate
To: Coly Li <i@coly.li>
Cc: linux-bcache@vger.kernel.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20170927174122.30341-1-mlyle@lyle.org>
 <20170927174122.30341-3-mlyle@lyle.org>
 <6d3709a2-96a7-100e-a966-eeefc11dfd39@coly.li>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <b8d88e54-a6cd-337f-f46b-19109a6d48fb@lyle.org>
Date: Sat, 7 Oct 2017 21:57:36 -0700
MIME-Version: 1.0
In-Reply-To: <6d3709a2-96a7-100e-a966-eeefc11dfd39@coly.li>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Coly--


On 10/07/2017 09:22 PM, Coly Li wrote:
[snip]
> rate:		488.2M/sec
> dirty:		91.7G
> target:		152.3G
> proportional:	-1.5G
> integral:	10.9G
> change:		0.0k/sec
> next io:	0ms
[snip]

> The backing cached device size is 7.2TB, cache device is 1.4TB, block
> size is 8kB only. I write 700G (50% of cache device size) dirty data
> onto the cache device, and start writeback by echo 1 to
> writeback_running file.
> 
> In my test, writeback spent 89 minutes to decrease dirty number from
> 700G to 147G (dirty target number is 152G). At this moment writeback
> rate was still displayed as 488.2M/sec. And after 22 minutes writeback
> rate jumped to 4.0k/sec. During the 22 minutes, (147-15.8=) 131.2G dirty
> data written out.

I see it-- if we can write faster than 488MB/sec, we inappropriately 
clamp the write rate to 488MB/sec-- this is from the old code.  In turn, 
if we're keeping up at that speed, the integral term can wind up.  I 
will fix this and clean up a couple related things.

> Is it as expected ?

It is supposed to overshoot the target, but not by this much.

I think the implementation must have changed at some point in the past 
for bch_ratelimit, because the clamping doesn't match. bch_ratelimit 
really needs a rewrite for other reasons, but I'll send the minimal fix now.

> 
> Thanks.
> 

Mike
