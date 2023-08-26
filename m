Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DEBC83F01
	for <linux-block@archiver.kernel.org>; Sat, 26 Aug 2023 18:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjHZST0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Aug 2023 14:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHZSTK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Aug 2023 14:19:10 -0400
Received: from uriel.iewc.co.za (unknown [IPv6:2c0f:f720:0:3::9a49:2248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A69C100
        for <linux-block@vger.kernel.org>; Sat, 26 Aug 2023 11:19:06 -0700 (PDT)
Received: from [154.73.32.4] (helo=tauri.local.uls.co.za)
        by uriel.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <jaco@uls.co.za>)
        id 1qZxrq-0007nz-2p;
        Sat, 26 Aug 2023 20:18:38 +0200
Received: from [192.168.1.145]
        by tauri.local.uls.co.za with esmtp (Exim 4.96)
        (envelope-from <jaco@uls.co.za>)
        id 1qZxrq-0001j2-1V;
        Sat, 26 Aug 2023 20:18:38 +0200
Message-ID: <8492dbe0-0985-dbb8-71b4-4541b88d3c56@uls.co.za>
Date:   Sat, 26 Aug 2023 20:18:33 +0200
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
 <564fe606-1bbf-4f29-4f10-7142ae07321f@uls.co.za>
 <b641b62d42fe890fa298dd1e3d56d685c6496441.camel@redhat.com>
From:   Jaco Kroon <jaco@uls.co.za>
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <b641b62d42fe890fa298dd1e3d56d685c6496441.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Laurence,

On 2023/08/25 14:01, Laurence Oberman wrote:
>>> Hello, this would usually need an NMI sent from a management
>>> interface
>>> as with it locked up no guarantee a sysrq c will get there from the
>>> keyboard.
>>> You could try though.
>>>
>>> As long as you have in /etc/kdump.conf
>>>
>>> path /var/crash
>>> core_collector makedumpfile -l --message-level 7 -d 31
>>>
>>> This will get kernel only pages and would not be very big.
>>>
>>> I could work with you privately to get what we need out of the
>>> vmcore
>>> and we would avoid transferring it.
>> Thanks.  This helps.  Let's get a core first (if it's going to happen
>> again) and then take it from there.
>>
>> Kind regards,
>> Jaco
>>
> Hello Jaco
> These hangs usually require the stacks to see where and why we are
> blocked. The vmcore will definitely help in that regard.

Linux crowsnest 6.4.12-uls #1 SMP PREEMPT_DYNAMIC Fri Aug 25 02:46:44 
SAST 2023 x86_64 Intel(R) Xeon(R) CPU E5-2603 v3 @ 1.60GHz GenuineIntel 
GNU/Linux

With the patch you referenced.

/proc/vmcore exists post kexec to the "new" kernel, if I just copy that 
do we need anything else?  Once I've copied /proc/vmcore and rebooted 
back into a more "normal" system, how do I start extracting information 
out of that core?

I don't have a kdump binary, or any other seemingly useful stuff even 
though I've got kexec-tools installed (which is where this comes from as 
far as I can tell) ... no /etc/kdump.conf either. Followed instructions 
here (with help from other sources):

https://www.kernel.org/doc/Documentation/kdump/kdump.txt

kdump references I can find w.r.t. /etc/kdump.conf seems to all be 
related to redhat and fedora ... neither of which applies (directly) to 
my Gentoo environment.

with 256G of RAM I'm assuming a crashkernel=512M should be sufficient?  
crashkernel=auto doesn't work.

The firmware upgrade on the controller killed reboot though ... BIOS no 
longer speak with the controller, but when performing the update the 
kernel immediately noticed that the firmware got upgraded.  So dead in 
the water at the moment.

Kind regards,
Jaco


