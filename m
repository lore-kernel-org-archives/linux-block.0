Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8735CC6FA8F
	for <linux-block@archiver.kernel.org>; Thu, 24 Aug 2023 20:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbjHXUR1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Aug 2023 16:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbjHXUQ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2023 16:16:56 -0400
Received: from uriel.iewc.co.za (uriel.iewc.co.za [IPv6:2c0f:f720:0:3::9a49:2248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE101BEF
        for <linux-block@vger.kernel.org>; Thu, 24 Aug 2023 13:16:53 -0700 (PDT)
Received: from [154.73.32.4] (helo=tauri.local.uls.co.za)
        by uriel.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <jaco@uls.co.za>)
        id 1qZGl4-0002v1-20;
        Thu, 24 Aug 2023 22:16:46 +0200
Received: from [192.168.1.145]
        by tauri.local.uls.co.za with esmtp (Exim 4.96)
        (envelope-from <jaco@uls.co.za>)
        id 1qZGl4-0006Wy-0a;
        Thu, 24 Aug 2023 22:16:46 +0200
Message-ID: <89e04f1a-26cd-32fe-1952-366bb7df895b@uls.co.za>
Date:   Thu, 24 Aug 2023 22:16:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: LVM kernel lockup scenario during lvcreate
Content-Language: en-GB
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
 <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
 <102b1994-74ff-c099-292c-f5429ce768c3@uls.co.za>
 <6b066ab5-7806-5a23-72a5-073153259116@acm.org>
 <544f4434-a32a-1824-b57a-9f7ff12dbb4f@uls.co.za>
 <a6d73e89-7a0c-3173-5f70-cd12cc7ef158@acm.org>
 <18d1c5a6-acd3-88cf-f997-80d97f43ab5c@uls.co.za>
 <0beea79c-af29-9f8f-e1f4-c8deba5a65c8@uls.co.za>
 <07d8b189-9379-560b-3291-3feb66d98e5c@acm.org>
 <ea29d76f-99c0-fcf2-09a3-4cc2e18f87da@uls.co.za>
 <1cf96e3b-e5e0-bcdb-df2b-ef9cbe51f9ca@acm.org>
 <ef2812b4-7853-9dda-85dd-210636840a59@uls.co.za>
 <d4b1c5d7-020b-7ef9-ee43-e78891649a3c@uls.co.za>
 <01b46e84-39f6-ec74-88d3-5735d7ac4a47@acm.org>
From:   Jaco Kroon <jaco@uls.co.za>
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <01b46e84-39f6-ec74-88d3-5735d7ac4a47@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2023/08/24 19:13, Bart Van Assche wrote:
> On 8/24/23 00:29, Jaco Kroon wrote:
>> We're definitely seeing the same thing on another host using an ahci 
>> controller.  This seems to hint that it's not a firmware issue, as 
>> does the fact that this happens much less frequently with the none 
>> scheduler.
>
> That is unexpected. I don't think there is enough data available yet to
> conclude whether these issues are identical or not?
It's hard for me to even conclude that two consecutive crashes are even 
exactly the same issue ... however, there's strong correlation in that 
there generally are lvcreate commands in D state which to me hints that 
it's something to do with LVM snapshot creation (both traditional - ahci 
controller, and thing - super micro).
>
>> I will make a plan to action the firmware updates on the raid 
>> controller over the weekend regardless, just in order to eliminate 
>> that.  I will then revert to mq-deadline. Assuming this does NOT fix 
>> it, how would I go about assessing if this is a controller firmware 
>> issue or a Linux kernel issue?
>
> If the root cause would be an issue in the mq-deadline scheduler or in
> the core block layer then there would be many more reports about I/O
> lockups. For this case I think that it's very likely that the root 
> cause is either the I/O controller driver or the I/O controller firmware.

I tend to agree with that.  And given the fact that we probably have in 
excess of 50 hosts and it generally just seems to be these two hosts in 
question that bites into this ... I agree with your assessment.  Except 
that at least the AHCI host never *used* to do this and only fairly 
recently started with this behaviour.

So here's what I personally *think* makes these two hosts unique:

1.  The ACHI controller hosts unfortunately ~15 years back was set up 
with "thick" volumes and use traditional snapshots (The hardware has 
been replaced piecemeal over the years so none of the original hardware 
is still in use).  This started exhibiting the same behaviour where for 
reasons I can't go into we started making multiple snapshots of the same 
origin LV simultaneously - this is unfortunate, thin snaps would be way 
more performant during the few hours where these two snaps are required.

2.  The LSI controller on the SM host uses a thin pool of of 125TB and 
contains 27 "origins", 26 of which follows this pattern on a daily basis:
2.1  Create thin snap of ${name} as fsck_${name}.
2.2  fsck gets run on the snapshot to ensure consistency.  If this 
fails, bail out and report error to management systems.
2.3 if save_${name} exist, remote it.
2.4 rename fsck_${name} to save_${name}.

3.  IO on the SM host often goes in excess of 1GB/s and often "idles" 
around 400MB/s, which I'm sure in the bigger scheme of things isn't 
really that heavy of a load, but considering most of our other hosts 
barely peak at 150MB/s and generally don't do more than 10MB/s it's 
significant for us.  Right now as I'm typing this we're doing between 
1500 and 3000 reads/s (saw it peak just over 6000 now) and 500-1000 
writes/s (and peaked just over 3000).  I'm well aware there are systems 
with much higher IOPs values, but for us this is fairly high, even a few 
years back I saw statistics on systems doing 10k+ IOPs.

4.  Majority of our hosts with raid controllers are megaraid, I can't 
think of any other hosts off the top of my head also using mpt3sas, but 
we do have a number with AHCI.  This supports the theory again that it's 
the firmware on the controller, so I'll be sure to do that on Sat 
morning too when I've got a reboot slot. Hopefully that'll just make the 
problem go away.

Thanks for all the help in this, really appreciated.  I know we seem to 
be running in circles, but I believe we are making progress even if 
slowly, at a minimum I'm learning quite a bit which in and by itself is 
putting us in a better position to figure this out.  I do think that it 
could be controller, but as I've stated before as well, we've previously 
seen issues with snapshot creation for many years now, killing dmeventd 
sorted that out except on these two hosts now.  And they are special in 
that they create multiple snapshots of the same origin.  Perhaps that's 
the clue since frankly that's the one thing they share, and the one 
thing that makes them distinct from the other hosts we run.

Kind regards,
Jaco


