Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35948 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932872AbdCXRwS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2017 13:52:18 -0400
Received: by mail-vk0-f50.google.com with SMTP id s68so11578569vke.3
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2017 10:52:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490376549.3312.3.camel@sandisk.com>
References: <20170324123621.5227-1-tom.leiming@gmail.com> <20170324123621.5227-4-tom.leiming@gmail.com>
 <1490376549.3312.3.camel@sandisk.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 25 Mar 2017 01:52:02 +0800
Message-ID: <CACVXFVPAJsChTvDRvS8=PiciNVOXU1U=zOm9y=cgk8Ujo6Vr3g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] block: rename blk_mq_freeze_queue_start()
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hare@suse.de" <hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Mar 25, 2017 at 1:29 AM, Bart Van Assche
<Bart.VanAssche@sandisk.com> wrote:
> On Fri, 2017-03-24 at 20:36 +0800, Ming Lei wrote:
>> As the .q_usage_counter is used by both legacy and
>> mq path, we need to block new I/O if queue becomes
>> dead in blk_queue_enter().
>>
>> So rename it and we can use this function in both
>> pathes.
>
> Should "pathes" be changed into "paths" in the commit message? Additionally,
> this patch breaks the symmetry the comment in blk_mq_freeze_queue() refers
> to. Anyway:

Really? Is there one function named as blk_mq_freeze_queue_end()?

The comment means blk_mq_freeze_queue() vs. blk_mq_unfreeze_queue(), which can't
be affected by this patch.


Thanks,
Ming Lei
