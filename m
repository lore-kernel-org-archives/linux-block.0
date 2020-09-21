Return-Path: <SRS0=nPog=C6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F4CC43465
	for <linux-block@archiver.kernel.org>; Mon, 21 Sep 2020 00:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9412C207EA
	for <linux-block@archiver.kernel.org>; Mon, 21 Sep 2020 00:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgIUA5a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Sep 2020 20:57:30 -0400
Received: from smtp.infotech.no ([82.134.31.41]:45464 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgIUA5a (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Sep 2020 20:57:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 90ABB20424C;
        Mon, 21 Sep 2020 02:57:28 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id giJNlnowmhTX; Mon, 21 Sep 2020 02:57:22 +0200 (CEST)
Received: from [192.168.48.23] (host-45-78-251-166.dyn.295.ca [45.78.251.166])
        by smtp.infotech.no (Postfix) with ESMTPA id 3FF2020417C;
        Mon, 21 Sep 2020 02:57:20 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH] lib/scatterlist: Fix memory leak in sgl_alloc_order()
To:     Markus Elfring <Markus.Elfring@web.de>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
References: <e69e9865-a599-5bd9-95b1-7d57c7e2e90c@web.de>
 <1608a0b7-6960-afce-aa39-6785036b01e0@interlog.com>
 <d8eb3d0e-52e2-1dab-ac02-774fdbd9c18c@web.de>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <9ee6e304-0f96-ea5b-f1ca-84e57345b237@interlog.com>
Date:   Sun, 20 Sep 2020 20:57:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d8eb3d0e-52e2-1dab-ac02-774fdbd9c18c@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-09-20 4:11 p.m., Markus Elfring wrote:
>>>> Noticed that when sgl_alloc_order() failed with order > 0 that
>>>> free memory on my machine shrank. That function shouldn't call
>>>> sgl_free() on its error path since that is only correct when
>>>> order==0 .
>>>
>>> * Would an imperative wording become helpful for the change description?
> …
>> … and the term "imperative wording" rings no
>> bells in my grammatical education. …
> 
> I suggest to take another look at the published Linux development documentation.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=bdcf11de8f776152c82d2197b255c2d04603f976#n151
> 
> 
>>> * How do you think about to add the tag “Fixes” to the commit message?r
>>
>> In the workflow I'm used to, others (closer to LT) make that decision.
>> Why waste my time?
> 
> I find another bit of guidance relevant.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=bdcf11de8f776152c82d2197b255c2d04603f976#n183
> 
> 
>>> * Will an other patch subject be more appropriate?
>>
>> Twas testing a 6 GB allocation with said function on my 8 GB laptop.
>> It failed and free told me 5 GB had disappeared …
> …
> 
> Have we got any different expectations for the canonical patch subject line?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=bdcf11de8f776152c82d2197b255c2d04603f976#n684
> 
> I am curious how the software will evolve further also according to your
> system test experiences.

Sorry, I didn't come down in the last shower, it's not my first bug fix.
Try consulting 'git log' and look for my name or the MAINTAINERS file.
The culprits are usually happy as was the case with this patch. It's
ack-ed and I would be very surprised if Jens Axboe doesn't accept it.

It is an obvious flaw. Fix it and move on. Alternatively supply your own
patch that ticks all the above boxes.


If you want to talk about something substantial, then why do we have a
function named sgl_free() that only works properly if, for example, the
sgl_alloc_order() function creating the sgl used order==0 ? IMO sgl_free()
should be removed or renamed.

Doug Gilbert


BTW The "imperative mood" stuff in that document is nonsense, at least
in English. Wikipedia maps that term back to "the imperative" as in
"Get thee to a nunnery" and "Et tu, Brute".

