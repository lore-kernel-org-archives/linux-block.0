Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34749 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbcJEDTl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2016 23:19:41 -0400
Received: by mail-pf0-f180.google.com with SMTP id e6so26691314pfk.1
        for <linux-block@vger.kernel.org>; Tue, 04 Oct 2016 20:19:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161003220040.GA1259@localhost.localdomain>
References: <20160926230030.GB24200@localhost.localdomain> <20160927172536.53a1315f@tom-ThinkPad-T450>
 <20161003220040.GA1259@localhost.localdomain>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 5 Oct 2016 11:19:39 +0800
Message-ID: <CACVXFVOrQHdZkqq+F159pd67iaj=Cx2hRG=uj-Mfr_m1OV9t+Q@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: Return invalid cookie if bio was split
To: Keith Busch <keith.busch@intel.com>
Cc: linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Oct 4, 2016 at 6:00 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Tue, Sep 27, 2016 at 05:25:36PM +0800, Ming Lei wrote:
>> On Mon, 26 Sep 2016 19:00:30 -0400
>> Keith Busch <keith.busch@intel.com> wrote:
>>
>> > The only user of polling requires its original request be completed in
>> > its entirety before continuing execution. If the bio needs to be split
>> > and chained for any reason, the direct IO path would have waited for just
>> > that split portion to complete, leading to potential data corruption if
>> > the remaining transfer has not yet completed.
>>
>> The issue looks a bit tricky because there is no per-bio place for holding
>> the cookie, and generic_make_request() only returns the cookie for the
>> last bio in the current bio list, so maybe we need the following patch too.
>
> I'm looking more into this, and I can't see why we're returning a cookie
> to poll on in the first place. blk_poll is only invoked when we could have
> called io_schedule, so we expect the task state gets set to TASK_RUNNING
> when all the work completes. So why do we need to poll for a specific
> tag instead of polling until task state is set back to running?

But .poll() need to check if the specific request is completed or not,
then blk_poll() can set 'current' as RUNNING if it is completed.

blk_poll():
                ...
                ret = q->mq_ops->poll(hctx, blk_qc_t_to_tag(cookie));
                if (ret > 0) {
                        hctx->poll_success++;
                        set_current_state(TASK_RUNNING);
                        return true;
                }
                ...


>
> I've tried this out and it seems to work fine, and should fix any issues
> from split IO requests. It also helps direct IO polling, since it can
> have a list of bios, but can only save one cookie.

I am glad to take a look the patch if you post it out.

Thanks,
Ming Lei
