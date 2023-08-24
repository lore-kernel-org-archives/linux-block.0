Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5824C6FA8F
	for <linux-block@archiver.kernel.org>; Thu, 24 Aug 2023 23:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjHXXlf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Aug 2023 19:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjHXXlH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2023 19:41:07 -0400
Received: from uriel.iewc.co.za (uriel.iewc.co.za [IPv6:2c0f:f720:0:3::9a49:2248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61D0FB
        for <linux-block@vger.kernel.org>; Thu, 24 Aug 2023 16:41:01 -0700 (PDT)
Received: from [154.73.32.4] (helo=tauri.local.uls.co.za)
        by uriel.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <jaco@uls.co.za>)
        id 1qZJwd-0007tR-11;
        Fri, 25 Aug 2023 01:40:55 +0200
Received: from [192.168.1.145]
        by tauri.local.uls.co.za with esmtp (Exim 4.96)
        (envelope-from <jaco@uls.co.za>)
        id 1qZJwc-0006k2-1m;
        Fri, 25 Aug 2023 01:40:54 +0200
Message-ID: <564fe606-1bbf-4f29-4f10-7142ae07321f@uls.co.za>
Date:   Fri, 25 Aug 2023 01:40:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: LVM kernel lockup scenario during lvcreate
Content-Language: en-GB
To:     Laurence Oberman <loberman@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
 <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
 <94477c459a398c47cb251afbcafbc9a6a83bba6f.camel@redhat.com>
 <977a1223-a543-a6ca-4a6c-0cf0fc6f84a0@uls.co.za>
 <69227e4091f3d9b05e739f900340f11afacdd91f.camel@redhat.com>
From:   Jaco Kroon <jaco@uls.co.za>
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <69227e4091f3d9b05e739f900340f11afacdd91f.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Laurence,
>>> One I am aware of is this
>>> commit 106397376c0369fcc01c58dd189ff925a2724a57
>>> Author: David Jeffery <djeffery@redhat.com>

I should have held off on replying until I finished looking into this.  
This looks very interesting indeed, that said, this is my first serious 
venture into the block layers of the kernel :), so the essay below is 
more for my understanding than anything else, would be great to have a 
better understanding of the underlying principles here and your feedback 
on my understanding thereof would be much appreciated.

If I understand this correctly (and that's a BIG IF) then it's possible 
that a bunch of IO requests goes into a wait queue for whatever reason 
(pending some other event?).  It's then possible that some of them 
should get woken up, and previously (prior to above) it could happen 
that only a single request gets woken up, and then that request would go 
straight back to the wait queue ... with the patch, isn't it still 
possible that all woken up requests could just go straight back to the 
wait queue (albeit less likely)?

Could the creation of a snapshot (which should based on my understanding 
of what a snapshot is block writes whilst the snapshot is being created, 
ie, make them go to the wait queue), and could it be that the process of 
setting up the snapshot (which itself involves writes) then potentially 
block due to this?  Ie, the write request that needs to get into the 
next batch to allow other writes to proceed gets blocked?

And as I write that it stops making sense to me because most likely the 
IO for creating a snapshot would only result in blocking writes to the 
LV, not to the underlying PVs which contains the metadata for the VG 
which is being updated.

But still ... if we think about this, the probability of that "bug" 
hitting would increase as the number of outstanding IO requests 
increase?  With iostat reporting r_await values upwards of 100 and 
w_await values periodically going up to 5000 (both generally in the 
20-50 range for the last few minutes that I've been watching them), it 
would make sense for me that the number of requests blocking in-kernel 
could be much higher than that, it makes perfect sense for me that it 
could be related to this.  On the other hand, IIRC iostat -dmx 1 usually 
showed only minimal if any requests in either [rw]_await during lockups.

Consider the AHCI controller on the other hand where we've got 7200 RPM 
SATA drives which are slow to begin with, now we've got traditional 
snapshots, which are also causing an IO bottleneck and artificially 
raising IO demand (much more so than thin snaps, really wish I could 
figure out the migration process to convert this whole host to thin 
pools but lvconvert scares me something crazy), so now having that first 
snapshot causes IO bottleneck (ignoring relevant metadata updates, every 
write to a not yet duplicated segment becomes a read + write + write to 
clone the written to segment to the snapshot - thin pools just a read + 
write for same), so already IO is more demanding, and now we try to 
create another snapshot.

What if some IO fails to finish (due to continually being put back into 
the wait queue), thus blocking the process of creating the snapshot to 
begin with?

I know there are numerous other people using snapshots, but I've often 
wondered how many use it quite as heavily as we do on this specific 
host?  Given the massive amount of virtual machine infrastructure on the 
one hand I think there must be quite a lot, but then I also think many 
of them use "enterprise" (for whatever your definition of that is) 
storage or something like ceph, so not based on LVM.  And more and more 
so either SSD/flash or even NVMe, which given the faster response times 
would also lower the risks of IO related problems from showing themselves.

The risk seems to be during the creation of snapshots, so IO not making 
progress makes sense.

I've back-ported the referenced path onto 6.4.12 now, which will go 
alive Saturday morning.  Perhaps we'll be sorted now.  Will also revert 
to mq-deadline which has been shown to more regularly trigger this, so 
let's see.

>
> Hello, this would usually need an NMI sent from a management interface
> as with it locked up no guarantee a sysrq c will get there from the
> keyboard.
> You could try though.
>
> As long as you have in /etc/kdump.conf
>
> path /var/crash
> core_collector makedumpfile -l --message-level 7 -d 31
>
> This will get kernel only pages and would not be very big.
>
> I could work with you privately to get what we need out of the vmcore
> and we would avoid transferring it.
Thanks.  This helps.  Let's get a core first (if it's going to happen 
again) and then take it from there.

Kind regards,
Jaco
