Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7E0C433ED
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 18:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A25610CB
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 18:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbhDHSkf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 14:40:35 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:35688 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHSke (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 14:40:34 -0400
Received: by mail-pl1-f181.google.com with SMTP id j7so1511615plx.2;
        Thu, 08 Apr 2021 11:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tDZHg//VbeTWAN/iLYoj3TGx+dZG8QDuLjnCchpjAFI=;
        b=dQPGd52KUp43wBd4EiK8SUbGkky3U/l3/espXgZXpJEK8SV8Frp+wAZ4wHNOwrwW/v
         LBlu2P6TgJfewQ5StrRR7fz3NvPFhJhrd1ZY4nZ3Jo9NbCXF9vCPJy3EEGkkB4WT5KDn
         QDKOAH7H8FblZ0McSr+A9DyjpY3I/b68D1daOtGp8daKuhSWkTfja+ydBYdO6ohhxrPF
         jbMyd3yvHTrIYZ4VqCaP9zc+3GXCYHR0visigQ6hdXmo7d7q2ClgYW60D1AcEDFFfy58
         5n3AEEPAkFi9xjtHVpPb9R1Nahr0d74IR+N/NH7rQ6/iPWOlgirmM2KpYU4rUmAHXjRd
         MoYQ==
X-Gm-Message-State: AOAM531elILdhTdQLq/YLiuryQIjohwYqE/moBS895QDxSxL3WVpm7OW
        A7aSzKRVFq2E4adDmVVb0m0=
X-Google-Smtp-Source: ABdhPJy1qXTNL0l2LxQHo62+shYdi265CQ+aLgXvyYab0u2zMp9o7/4f4QHQKJGeCD6m+UujOY1lqA==
X-Received: by 2002:a17:902:e2d1:b029:e9:ec4:e0da with SMTP id l17-20020a170902e2d1b02900e90ec4e0damr9146313plc.85.1617907222860;
        Thu, 08 Apr 2021 11:40:22 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id i17sm180872pfd.84.2021.04.08.11.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 11:40:21 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 04780402D7; Thu,  8 Apr 2021 18:40:20 +0000 (UTC)
Date:   Thu, 8 Apr 2021 18:40:20 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Minchan Kim <minchan@kernel.org>, keescook@chromium.org,
        dhowells@redhat.com, hch@infradead.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <20210408184020.GF4332@42.do-not-panic.com>
References: <20210322204156.GM4332@42.do-not-panic.com>
 <YFkWMZ0m9nKCT69T@google.com>
 <20210401235925.GR4332@42.do-not-panic.com>
 <YGbNpLKXfWpy0ZZa@kroah.com>
 <87blap4kum.ffs@nanos.tec.linutronix.de>
 <YG6fpgmYSg/PwOrU@kroah.com>
 <nycvar.YFH.7.76.2104080957580.18270@cbobk.fhfr.pm>
 <YG66OWzum5DGcSTn@kroah.com>
 <nycvar.YFH.7.76.2104081015340.18270@cbobk.fhfr.pm>
 <YG7FGRNhIfDTqgUz@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG7FGRNhIfDTqgUz@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 08, 2021 at 10:55:53AM +0200, Greg KH wrote:
> So to add crazy complexity to the kernel, 

I agree that this can be tricky. However, driver developers are going to
open code this either way. The problem with that as well, and one of my
own reasons for striving for at least *trying* for a generic solution,
was that I am aware that driver developers may be trying a busy solution
rather than the try method. The busy approach means you could also end
up in a situation where userspace can prevent full undoing / removal
of a driver. The try method is best effort in the sense that if the
driver is going it won't be allowed.

So a sensible consideration I think is we at least choose one of these:

 a) We allow driver developers to open code it on drivers which need it on
    each and every single sysfs knob on the driver where its needed, and
    accept folks might do it wrong

 b) Provide a macro which is opt-in, ie, not doing it for all
    attributes, but perhaps one which the driver author *is* aware to
    try / put of the driver method.

 c) Document this race and other races / failings so that driver
    authors who do care about module removal are aware and know what
    to do.

In this thread two races were exposed on syfs:

  * deadlock when a sysfs attribute uses a lock which is also used on
    module __exit

  * possible race against the device's private data, and this is type
    specific. I think many people probably missed the last hunks of my
    proposed patch which added dev_type_get() which were not part of the
    deadlock fix. At least I showed how attributes for all block devices
    have an exposed race, which can crash if removal of a block device
    with del_gendisk() happens while a sysfs attribute is about to be
    used.
 
I don't think either race is trivial for a driver developer to assume a
solution for. Most focus on this thread was about the first race, the
seconod however is also very real, and likely can cause more issues on
rolling backs on error codes unrelated to rmmod...

> for an operation that can only
> be triggered manually by a root user, is not worth it in my opinion, as
> the maintainer of that code the complexity was asked to be made to.

Three things:

1) Many driver maintainers *do* care that rmmod works well. To the point
that if it does not, they feel ashamed. Reason for this is that in some
subsystems this *is* a typical test case. So although rmmod may be
a vodoo thing for core, many driver developers do want this to work
well.

As someone who also works on many test cases to expose odd issues in the
kernel unrelated to module removal, I can also say that module removal
does also expose other possible races which would otherwise be difficult
to trigger. So it is also a helfup aid as a developer working on
differen areas of the kernel.

2) Folks have pointed out that this is not just about rmmod, rolling
back removal of sysfs attributes due to error code paths is another
real scenario to consider. I don't think we have rules to tell userspace
to not muck with sysfs files after they are exposed. In fact those
uevents we send to userspace allow userspace to know exactly when to
muck with them.

3) Sadly, some sysfs attributes also purposely do things which *also*
mimic what is typically done on module removal, such as removal of an
interface, or block device. That was the case with zram, it allows
remvoal / reset of a device... Yes these are odd things to do, but we
allow for it. And sysfs users *do* need to be aware of these corner
cases if they want to support them.

There **may** be some severity to some of the issues mentioned above, to
allow really bad things to be done in userspace even without module
removal... but I didn't have time yet to expose a pattern with coccinelle
yet to see how commonplace some of these issue are. I was focusing at
first more for a generic solution if possible, as I thought that would
be better first evaluated, and to let others slowly become aware of the
issue.

  Luis
