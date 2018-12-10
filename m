Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C109C04EB8
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 13:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD7620870
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 13:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzDeZ9Ku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD7620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeLJNpu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:45:50 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:39253 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbeLJNpu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 08:45:50 -0500
Received: by mail-oi1-f179.google.com with SMTP id i6so8969281oia.6;
        Mon, 10 Dec 2018 05:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zZyLLUhZXcYJ2LtJLGESHBqFDN04cjKgYPLf3lUGB3w=;
        b=NzDeZ9KudDpiXL9cdONJSrPvKBsw5xsCqlcR36gRoKo7fa3HU8xHnR7sDtDApmo7By
         78Yv7t8uaY0AVR2yAs/0NOq4fHbkiF3cdlS/NVfLC2XBKdJPs03wvHz5oGiEs1j2NgFa
         ZiZzDJh8lx/Y5U9BgFARDcjBu4wBhz9MSTOOQxK/Y4vw9OfRfHLzcyGO/98wx+cMjptz
         eiVzZ1tQ57KZFCyNkcugCAZL/+lB5o8wdR8V23hYlxMKJ082ob2+P3ZGL/ru9U7HQI75
         bXuBZahoJqwzfmM+IpO9vCHnKTNjeR7KLlTPBc2xt0KMkckofr/Et8CT3giTkJ5Yjwtt
         q27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zZyLLUhZXcYJ2LtJLGESHBqFDN04cjKgYPLf3lUGB3w=;
        b=MhMBgMcajl9W3GeB4Scx1xcWUnhjBHdWX52fzgwWWZ3KfuN8boa45YyTD0p2wum7kH
         6+Qwm7YCpzSsPxxnyXTBMlA+0WkOPsZpyUy3x6c6s1vGo7MBxgqcm5KfGs5Y68YVzprj
         zl5ZsnffrQkFMx5cHagp6pF36h56F5lP/v/Z5e8ieafVnIGgoVrGS/yLwyJJUYD7rq8H
         q31c28gaCMutwuxS7Ed2ks1kJvpdiWCoQjm2AS5me2SHQUQZ12Ul2JGQK6pDLm3b76bN
         zstcVaY3KKS6Eh4JVdQkxgJNTHFV76on+AFJ9F02Jqd+NoUU6zVMhEVUCqaHQM9ScqnW
         aQWw==
X-Gm-Message-State: AA+aEWbg7J+XXTPNgg2tn1Nw6apta7y+18X9xF91dpnZxy+4ZIo0FZkd
        ABeZbEmmMWmA4Dy+YULW3rQ06d7ObDULvXABUoI=
X-Google-Smtp-Source: AFSGD/VyqY0leLtqw14agbiYFVZ8Dv7/cBcu+Dcc7nQUmMczgwsozhrzRAXtZK/d9d42XPDYqP2jGBqoqqjc15n9DZs=
X-Received: by 2002:aca:ad14:: with SMTP id w20mr7145422oie.3.1544449548608;
 Mon, 10 Dec 2018 05:45:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:2819:0:0:0:0:0 with HTTP; Mon, 10 Dec 2018 05:45:47
 -0800 (PST)
In-Reply-To: <5534B7D4-A5D9-4F44-9620-970A7F9EC140@linaro.org>
References: <20181119103424.3853-1-paolo.valente@linaro.org>
 <20181120162816.GV2509588@devbig004.ftw2.facebook.com> <25296DAE-73EC-46CC-9A98-A8B7E9017BB7@linaro.org>
 <7D7FAB43-5F62-4402-A9B3-E7C2E30AE680@linaro.org> <20181130184256.GI2509588@devbig004.ftw2.facebook.com>
 <5534B7D4-A5D9-4F44-9620-970A7F9EC140@linaro.org>
From:   Angelo Ruocco <angelo.ruocco.90@gmail.com>
Date:   Mon, 10 Dec 2018 14:45:47 +0100
Message-ID: <CADiTV-29TmkB5-k=TtQfoJqjP2Qv7GSsGLXAPBaTB6DoQ+6yyw@mail.gmail.com>
Subject: Re: [PATCH V2 00/10] unify the interface of the proportional-share
 policy in blkio/io
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     "'Paolo Valente' via bfq-iosched" <bfq-iosched@googlegroups.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, oleksandr@natalenko.name,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

2018-11-30 19:53 GMT+01:00, Paolo Valente <paolo.valente@linaro.org>:
>
>
>> Il giorno 30 nov 2018, alle ore 19:42, Tejun Heo <tj@kernel.org> ha
>> scritto:
>>
>> Hello, Paolo.
>>
>> On Fri, Nov 30, 2018 at 07:23:24PM +0100, Paolo Valente wrote:
>>>> Then we understood that exactly the same happens with throttling, in
>>>> case the latter is activated on different devices w.r.t. bfq.
>>>>
>>>> In addition, the same may happen, in the near future, with the
>>>> bandwidth controller Josef is working on.  If the controller can be
>>>> configured per device, as with throttling, then statistics may differ,
>>>> for the same interface files, between bfq, throttling and that
>>>> controller.
>>
>> So, regardless of how all these are implemented, what's presented to
>> user should be consistent and clear.  There's no other way around it.
>> Only what's relevant should be visible to userspace.
>>
>>> have you had time to look into this?  Any improvement to this
>>> interface is ok for us. We are only interested in finally solving this
>>> interface issue, as, for what concerns us directly, it has been
>>> preventing legacy code to use bfq for years.
>>
>> Unfortunately, I don't have any implementation proposal, but we can't
>> show things this way to userspace.
>>
>
> Well, this is not very helpful to move forward :)
>
> Let me try to repeat the problem, to try to help you help us unblock
> the situation.
>
> If we have multiple entities attached to the same interface output
> file, you don't find it clear that each entity shows the number it
> wants to show.  But you have no idea either of how that differentiated
> information should be shown.  Is this the situation, or is the problem
> somewhere 'above' this level?
>
> If the problem is as I described it, here are some proposal attempts:
> 1) Do you want file sharing to be allowed only if all entities will
> output the same number?  (this seems excessive, but maybe it makes
> sense)
> 2) Do you want only one number to be shown, equal to the sum of the
> numbers of each entity?  (in some cases, this may make sense)
> 3) Do you prefer an average?
> 4) Do you have any other idea, even if just germinal?

To further add to what Paolo said and better expose the problem, I'd like to
say that all those proposals have issues.
If we only allow "same output" cftypes to be shared then we lose all the
flexibility of this solution, and we need a way for an entity to know other
entities internal variables beforehand, which sounds at least very hard, and
maybe is not even an acceptable thing to do.
To put the average, sum or some other mathematical function in the file only
makes sense for certain cftypes, so also doesn't sound like a good idea. In
fact I can think of scenarios where only seeing the different values of the
entities makes sense for a user.

I understand that the problem is inconsistency: having a file that behaves
differently depending on the situation, and the only way to prevent this I can
think of is to *always* show the entity owner of a certain file (or part of the
output), even when the output would be the same among entities or when the
file is not currently shared but could be. Can this be an acceptable solution?

Angelo

>
> Looking forward to your feedback,
> Paolo
>
>
>> Thanks.
>>
>> --
>> tejun
>>
>> --
>> You received this message because you are subscribed to the Google Groups
>> "bfq-iosched" group.
>> To unsubscribe from this group and stop receiving emails from it, send an
>> email to bfq-iosched+unsubscribe@googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
>
>
