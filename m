Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BEFC6FA8F
	for <linux-block@archiver.kernel.org>; Thu, 24 Aug 2023 20:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243361AbjHXUBs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Aug 2023 16:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243471AbjHXUBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2023 16:01:45 -0400
Received: from uriel.iewc.co.za (uriel.iewc.co.za [IPv6:2c0f:f720:0:3::9a49:2248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683DA170F
        for <linux-block@vger.kernel.org>; Thu, 24 Aug 2023 13:01:39 -0700 (PDT)
Received: from [154.73.32.4] (helo=tauri.local.uls.co.za)
        by uriel.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <jaco@uls.co.za>)
        id 1qZGWK-0002Yk-2g;
        Thu, 24 Aug 2023 22:01:32 +0200
Received: from [192.168.1.145]
        by tauri.local.uls.co.za with esmtp (Exim 4.96)
        (envelope-from <jaco@uls.co.za>)
        id 1qZGWK-0006XW-0N;
        Thu, 24 Aug 2023 22:01:32 +0200
Message-ID: <977a1223-a543-a6ca-4a6c-0cf0fc6f84a0@uls.co.za>
Date:   Thu, 24 Aug 2023 22:01:28 +0200
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
From:   Jaco Kroon <jaco@uls.co.za>
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <94477c459a398c47cb251afbcafbc9a6a83bba6f.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2023/08/24 19:29, Laurence Oberman wrote:

> On Mon, 2023-06-12 at 11:40 -0700, Bart Van Assche wrote:
>> On 6/9/23 00:29, Jaco Kroon wrote:
>>> I'm attaching dmesg -T and ps axf.  dmesg in particular may provide
>>> clues as it provides a number of stack traces indicating stalling
>>> at
>>> IO time.
>>>
>>> Once this has triggered, even commands such as "lvs" goes into
>>> uninterruptable wait, I unfortunately didn't test "dmsetup ls" now
>>> and triggered a reboot already (system needs to be up).
>> To me the call traces suggest that an I/O request got stuck.
>> Unfortunately call traces are not sufficient to identify the root
>> cause
>> in case I/O gets stuck. Has debugfs been mounted? If so, how about
>> dumping the contents of /sys/kernel/debug/block/ into a tar file
>> after
>> the lockup has been reproduced and sharing that information?
>>
>> tar -czf- -C /sys/kernel/debug/block . >block.tgz
>>
>> Thanks,
>>
>> Bart.
>>
> One I am aware of is this
> commit 106397376c0369fcc01c58dd189ff925a2724a57
> Author: David Jeffery <djeffery@redhat.com>
>
> Can we try get a vmcore (assuming its not a secure site)

Certainly.  Obviously on any host handling any kind of sensitive data 
there is a likelihood that sensitive data may be present in the vmcore, 
as such I more than happy to create a vmcore, I'm assuming this will 
create a kernel version of a core dump ... with 256GB of RAM (most of 
which goes towards disk caches) I'm further assuming this file can be 
potentially large.  Where will this get stored should the capture be 
made?  (I need to ensure that the filesystem has sufficient storage 
available)

>
> Add these to /etc/sysctl.conf
>
> kernel.panic_on_io_nmi = 1
> kernel.panic_on_unrecovered_nmi = 1
> kernel.unknown_nmi_panic = 1
>
> Run sysctl -p
> Ensure kdump is running and can capture a vmcore
Done.  Had to enable a few extra kernel options to get all the other 
requirements, so scheduled a reboot to activate the new kernel. This 
will happen on Saturday morning very early.
>
> When it locks up again
> send an NMI via the SuperMicro Web Managemnt interface

Possible to send from sysrq at the keyboard?  Otherwise I'll just need 
to set up the RMI, will just be easier to do this from the keyboard if 
possible, it's not always if it's left too late.

>
> Share the vmcore, or we can have you capture some specifics from it to
> triage.

I'd prefer you let me know what you need ... security concerns and all 
... frankly, I highly doubt there is any data that is really so 
sensitive that it can be classified as "top secret" but we do have NDAs 
in place prohibiting me from sharing anything that may potentially 
contain customer related data ...

Kind regards,
Jaco
