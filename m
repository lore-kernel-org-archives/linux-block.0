Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34007 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755237AbcJNQkk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Oct 2016 12:40:40 -0400
Date: Fri, 14 Oct 2016 12:40:36 -0400
From: Tejun Heo <tj@kernel.org>
To: Kyle Sanderson <kyle.leet@gmail.com>
Cc: jmoyer@redhat.com, Paolo Valente <paolo.valente@unimore.it>,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-block@vger.kernel.org,
        Shaohua Li <shli@fb.com>, Jens Axboe <axboe@fb.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vivek Goyal <vgoyal@redhat.com>, Kernel-team@fb.com,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Fwd: [PATCH V3 00/11] block-throttle: add .high limit
Message-ID: <20161014164036.GA6320@mtj.duckdns.org>
References: <278BCC7B-ED58-4FDF-9243-FAFC3F862E4D@unimore.it>
 <20161004172852.GB73678@anikkar-mbp.local.dhcp.thefacebook.com>
 <EE90477C-FD56-48C1-8A45-97AF39A8BB0C@unimore.it>
 <20161004185413.GF4205@htj.duckdns.org>
 <F9A2F063-F5A2-49A6-8DFE-91ACDE380645@unimore.it>
 <20161004191427.GG4205@htj.duckdns.org>
 <B8B66027-D652-46E2-A0C6-81F227817571@unimore.it>
 <20161004202754.GJ4205@htj.duckdns.org>
 <CACsaVZ+AqSXHTRdpdrQQp6PuynEPeB-5YOyweWsenjvuKsD12w@mail.gmail.com>
 <CACsaVZ+azEP+fH5Dg-8soH8QjWBRnL-2B4Uuj4YF2hUnoyvzgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACsaVZ+azEP+fH5Dg-8soH8QjWBRnL-2B4Uuj4YF2hUnoyvzgA@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Kyle.

On Sat, Oct 08, 2016 at 06:15:14PM -0700, Kyle Sanderson wrote:
> How is this even a discussion when hard numbers, and trying any
> reproduction case easily reproduce the issues that CFQ causes. Reading
> this thread, and many others only grows not only my disappointment,
> but whenever someone launches kterm or scrot and their machine
> freezes, leaves a selective few individuals completely responsible for
> this. Help those users, help yourself, help Linux.

So, just to be clear.  I wasn't arguing against bfq replacing cfq (or
anything along that line) but that proportional control, as
implemented, would be too costly for many use cases and thus we need
something along the line of what Shaohua is proposing.

FWIW, it looks like the only way we can implement proportional control
on highspeed ssds with acceptable overhead is somehow finding a way to
calculate the cost of each IO and throttle IOs according to that while
controlling for latency as necessary.  Slice scheduling with idling
seems too expensive with highspeed devices with high io depth.

Thanks.

-- 
tejun
