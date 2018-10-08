Return-Path: <linux-block-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:48710 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeJHN4z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Oct 2018 09:56:55 -0400
Date: Sun, 07 Oct 2018 23:46:41 -0700 (PDT)
Message-Id: <20181007.234641.2199470135547877917.davem@davemloft.net>
To: keescook@chromium.org
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunvdc: Remove VLA usage
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAGXu5jKV3eLJJsemxNEjZuANRd8-TnRkMSmiztVyY5mgC2ySHw@mail.gmail.com>
References: <20180906000926.GA18830@beast>
        <CAGXu5jJ-Hbj143Sv7ikxmLnBPyvcd1cGoT5fSbwG21LomnsORw@mail.gmail.com>
        <CAGXu5jKV3eLJJsemxNEjZuANRd8-TnRkMSmiztVyY5mgC2ySHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Sun, 7 Oct 2018 23:16:01 -0700

> On Mon, Sep 24, 2018 at 8:19 PM, Kees Cook <keescook@chromium.org> wrote:
>> On Wed, Sep 5, 2018 at 5:09 PM, Kees Cook <keescook@chromium.org> wrote:
>>> In the quest to remove all stack VLA usage from the kernel[1], this
>>> moves the math for cookie calculation into macros and allocates a fixed
>>> size array for the maximum number of cookies and adds a runtime sanity check.
>>> (Note that the size was always fixed, but just hidden from the compiler.)
>>>
>>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> Friendly ping. Jens, can you take this?
> 
> Dave, should this go via you instead? I'll take it via my tree if no
> one else wants it...

Please resend to me and CC: sparclinux@vger.kernel.org and I'll take it.

Thanks.
