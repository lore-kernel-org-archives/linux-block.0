Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33339 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753575AbdDDP4Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2017 11:56:25 -0400
MIME-Version: 1.0
In-Reply-To: <871st8kxnk.fsf@dmlp.sw.ru>
References: <1491204212-9952-1-git-send-email-dmonakhov@openvz.org>
 <1491204212-9952-8-git-send-email-dmonakhov@openvz.org> <CACVXFVPWe0ABh5CsXryqXi7Umtvvzcq=jp2n+t=JDRWSZJsbFA@mail.gmail.com>
 <871st8kxnk.fsf@dmlp.sw.ru>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 4 Apr 2017 23:56:23 +0800
Message-ID: <CACVXFVN3LmbtyAa95dpzFit5johAG+WizPNk21=7KcbLM1E5_g@mail.gmail.com>
Subject: Re: [PATCH 7/7] Guard bvec iteration logic v2
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Apr 4, 2017 at 11:19 PM, Dmitry Monakhov <dmonakhov@openvz.org> wrote:
> Ming Lei <tom.leiming@gmail.com> writes:
>
>> On Mon, Apr 3, 2017 at 3:23 PM, Dmitry Monakhov <dmonakhov@openvz.org> wrote:
>>> Currently if some one try to advance bvec beyond it's size we simply
>>> dump WARN_ONCE and continue to iterate beyond bvec array boundaries.
>>> This simply means that we endup dereferencing/corrupting random memory
>>> region.
>>>
>>> Sane reaction would be to propagate error back to calling context
>>> But bvec_iter_advance's calling context is not always good for error
>>> handling. For safity reason let truncate iterator size to zero which
>>
>> IMO, we can avoid continuing to iterate by checking the return value,
>> and looks it is rude to just set iterator size as 0.
> But situation itself is horrible already. IMHO this is BUG_ON situation,

Not sure it is a real BUG_ON() since corrupt bvec array shouldn't happen
because we usually don't modify bvec array directly and just copy to local
variable for further access, but dereferencing random memory might happen.

> but since Linus hate bugons, I try to replace with something loud, but
> very safe. Since there is no guarantee that caller will ignore an error
> and try to dereference bvec the only safe thing we can to is to clamp
> iterator to zero to prevent any possible usage in future.

Since you prevent the case from happening, no dereference invalid bvec
can happen any more, but may cause dead loop. Setting iterator size as
zero can break the dead loop, but the driver still may not know this error
and continue to do its following work.

Don't have a better idea now, and looks it is fine to set iter.bi_size as
zero at the beginning of guarding bvec iteration.



Thanks,
Ming Lei
