Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:64396 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752610AbeC0Pgp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Mar 2018 11:36:45 -0400
Subject: Re: disk-io lockup in 4.14.13 kernel
To: Jaco Kroon <jaco@uls.co.za>,
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
 <098b139a-53b5-b243-dc3f-67fb7efa5ff1@uls.co.za>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <77fd4247-e71f-6eac-c59a-dedb739453a6@wdc.com>
Date: Tue, 27 Mar 2018 08:36:45 -0700
MIME-Version: 1.0
In-Reply-To: <098b139a-53b5-b243-dc3f-67fb7efa5ff1@uls.co.za>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/27/18 01:59, Jaco Kroon wrote:
> I triggered it hoping to get a stack trace of the process which is
> deadlocking finding where the lock is being taken that ends up blocking,
> but I then realized that you mentioned sleeping, which may end up not
> having a stack trace because there is no process actually running?  (I'm
> not that intimately familiar with kernel internals, mostly doing
> user-space development, so kernel is an interesting environment for me
> only, but not really part of my day-to-day activities.

Usually I proceed as follows to obtain more information about a lockup:
* Trigger SysRq-w (shows tasks that are in uninterruptible wait state).
* If the output that appears does not provide enough information, 
trigger SysRq-t (shows all tasks).
* If it seems like a block layer request got stuck, also analyze the 
output of the following command:

find /sys/kernel/debug/block -type f |
grep -vE \
'/(poll_stat|write_hints|completed|merged|dispatched|run|queued)' | 
xargs grep -a .

> I saw a
> patch for the mpt3sas issue but the email was munged and I wasn't able
> to apply the patch from the email.

That's weird. Saving that patch ("Save as mbox") and applying it with 
"git am" works fine for me. See also 
https://www.mail-archive.com/linux-scsi@vger.kernel.org/msg72175.html.

Because I was too busy during the past two weeks I have not yet had the
time to have a close look at that patch. But I hope to find some time 
soon to have a closer look.

Bart.
