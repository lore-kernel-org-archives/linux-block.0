Return-Path: <linux-block-owner@vger.kernel.org>
Received: from othala.iewc.co.za ([154.73.34.12]:59570 "EHLO othala.iewc.co.za"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751121AbeC0I7O (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Mar 2018 04:59:14 -0400
Subject: Re: disk-io lockup in 4.14.13 kernel
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "pieterk@uls.co.za" <pieterk@uls.co.za>
References: <16bae006-371f-1eea-56b6-8668249d870b@uls.co.za>
 <828103f7-7550-16a3-d482-8953adc5a234@wdc.com>
 <257ceeb7-f466-d13d-8818-829759eda587@uls.co.za>
 <1520737695.8740.4.camel@wdc.com>
 <6e2ef6eb-a610-8c52-52d8-a35e4d3f36c9@uls.co.za>
 <1520744455.8740.9.camel@wdc.com>
 <0d5c21c2-4fea-5870-e971-f90556fb4141@uls.co.za>
 <1520950225.2921.0.camel@wdc.com>
 <cca75546-a02e-bed3-fda0-0003ccc5d158@uls.co.za>
 <1520953606.2638.5.camel@wdc.com>
 <b9f2421d-6350-1136-86ea-bdb70a59b6d9@uls.co.za>
 <1520961846.2638.25.camel@wdc.com>
 <ee32fa2f-3470-0ba8-a1a6-a362877b2fcc@uls.co.za>
 <1522104980.3102.30.camel@wdc.com>
From: Jaco Kroon <jaco@uls.co.za>
Message-ID: <098b139a-53b5-b243-dc3f-67fb7efa5ff1@uls.co.za>
Date: Tue, 27 Mar 2018 10:59:00 +0200
MIME-Version: 1.0
In-Reply-To: <1522104980.3102.30.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Bart,
> The above call trace means that SysRq-l was triggered, either via the keyboard
> or through procfs. I don't think that there is any information in the above
> that reveals the root cause of why a reboot was necessary.
I triggered it hoping to get a stack trace of the process which is
deadlocking finding where the lock is being taken that ends up blocking,
but I then realized that you mentioned sleeping, which may end up not
having a stack trace because there is no process actually running?  (I'm
not that intimately familiar with kernel internals, mostly doing
user-space development, so kernel is an interesting environment for me
only, but not really part of my day-to-day activities.
>
> What I do myself to identify the root cause of weird kernel behavior is to
> rebuild the kernel with a bunch of debugging options enabled and that I try to
> repeat the trigger that caused the weird behavior. If this causes the kernel
> debugging code to produce additional output that output can be very helpful for
> identifying what is going on. This approach does not always work however.
Yea, I find debugging is often an art more than a science.  I saw a
patch for the mpt3sas issue but the email was munged and I wasn't able
to apply the patch from the email - I've emailed w.r.t. that but I've
not received a response.  Have you managed to get anything more sensible
from them?

Kind Regards,
Jaco
