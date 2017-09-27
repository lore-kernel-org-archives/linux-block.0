Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36315 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbdI0Use (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Sep 2017 16:48:34 -0400
Received: by mail-qk0-f196.google.com with SMTP id q77so377090qke.3
        for <linux-block@vger.kernel.org>; Wed, 27 Sep 2017 13:48:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5986f13b-013d-5252-fc70-51dcd40e7335@kernel.dk>
References: <20170926095412.74028-1-colyli@suse.de> <20170926095412.74028-2-colyli@suse.de>
 <4c14e77e-577f-b7b7-d63a-b4b3a4d9e757@coly.li> <5986f13b-013d-5252-fc70-51dcd40e7335@kernel.dk>
From: Michael Lyle <mlyle@lyle.org>
Date: Wed, 27 Sep 2017 13:48:32 -0700
Message-ID: <CAJ+L6qeQu0A17gGb1RVu8g_JvzcvJ2uSDj+9vC-hsUEFqM-fAw@mail.gmail.com>
Subject: Re: [PATCH 1/1] bcache: use llist_for_each_entry_safe() in __closure_wake_up()
To: Jens Axboe <axboe@kernel.dk>
Cc: Coly Li <i@coly.li>, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Jens--

I think it's a race condition-- the individual closures remain valid.
It's just that the list element has different meanings-- it's either a
list actively being used to wake, or a linkage on one of several lists
that is being used to await wake.  If a closure goes back to wait very
quickly after being woken, it can end up connecting its new wait-list
with the being-woken list.

Mike

On Wed, Sep 27, 2017 at 1:27 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 09/27/2017 09:16 PM, Coly Li wrote:
>> Hi Jens,
>>
>> Could you please take a look on this patch? It will be helpful if we can
>> have it in 4.14, then we can fix a bug introduced in 4.14-rc1.
>>
>> This patch is reported by Michael Lyle, reviewed by Byungchul Park, and
>> finally verified by Michael Lyle after I posted the patch.
>
> It looks fine to me, I'll get it queued up. BTW, it's technically
> a use-after-free bug, not a race condition.
>
> --
> Jens Axboe
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bcache" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
