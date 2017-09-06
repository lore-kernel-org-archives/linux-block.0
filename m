Return-Path: <linux-block-owner@vger.kernel.org>
Received: from server.coly.li ([162.144.45.48]:34152 "EHLO server.coly.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752767AbdIFPlk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Sep 2017 11:41:40 -0400
Subject: Re: [PATCH 00/13] bcache: fixes and update for 4.14
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        bcache@lists.ewheeler.net
References: <20170906062602.50497-1-colyli@suse.de>
 <20170906142002.GA19380@kernel.dk>
From: Coly Li <i@coly.li>
Message-ID: <d2a5b042-a81d-71c4-1f8c-8fc6416ed363@coly.li>
Date: Wed, 6 Sep 2017 23:41:35 +0800
MIME-Version: 1.0
In-Reply-To: <20170906142002.GA19380@kernel.dk>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2017/9/6 下午10:20, Jens Axboe wrote:
> On Wed, Sep 06 2017, Coly Li wrote:
>> Hi Jens,
>>
>> Here are 12 patchs for bcache fixes and updates, most of them were posted
>> by Eric Wheeler in 4.13 merge window, but delayed due to lack of code
>> review.
> 
> Next time, please send this _before_ the merge window opens. Not a huge
> problem for this series, since it has been posted numerous times in the
> past and already has good review coverage, but it really should have
> been in linux-next for a week or two before heading upstream.
> 
Hi Jens,

Copied, send patches _before_ merge window opens.

But could you please to give me a hint, how can I find when a specific
merge window will open ? I search LKML, and see people send pull
requests for 4.14 merge window, but I don't see any announcement for
4.14 merge window time slot.


>> There are some other patches which does not pass my test currently,
>> once they are fixed and reviewed by peer developers I will send them
>> to you for 4.14 merge window.
> 
> If they are not passing tests etc before the merge window opens, they
> are not for this cycle.

I see. There is one more patch should be in 4.14, it is OK for code, the
original author asks me to help him to compose a better commit log. I am
about to send this patch to you today or tomorrow.

Thanks for the hint.

-- 
Coly Li
