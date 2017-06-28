Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:50789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751587AbdF1POy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 11:14:54 -0400
Subject: Re: LightNVM pblk: read/write of random kernel memory
To: Javier Gonzalez <javier@cnexlabs.com>
Cc: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <42c49a3a-447b-8a31-91b5-92264f196085@gmx.net>
 <BE9E3136-5D3F-44E7-ACE4-49FEC95B330A@cnexlabs.com>
 <7a0a2821-0007-7af0-7eb8-d58650123718@gmx.net>
 <CE85E6EB-69AF-4A02-B7DF-F70F2F7E54A3@cnexlabs.com>
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Message-ID: <eee8f965-64e2-c9f0-21ef-b8419c9431e9@gmx.net>
Date: Wed, 28 Jun 2017 17:14:35 +0200
MIME-Version: 1.0
In-Reply-To: <CE85E6EB-69AF-4A02-B7DF-F70F2F7E54A3@cnexlabs.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Javier,

On 28.06.2017 16:58, Javier Gonzalez wrote:
>> On 28 Jun 2017, at 16.33, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net> wrote:
>>
>> thanks for the pointer to the github reporting page.
>> I'll answer your questions here (to make then indexable by search
>> engines in case someone else stumbles upon this) and link to newly
>> created github issues for the various problems I encountered.
>>
> Ok. I answered each issue directly on the github. A couple og things
> inline though, for completion.

Thanks.

 
>> On 28.06.2017 13:07, Javier Gonzalez wrote:
>>> I'll take the question here, but please use our github [1] to report
>>> errors and ask questions instead (including this thread). No need to
>>> spam the rest of the linux-block mailing list for LightNVM specific
>>> matters - unless of course, you want to discuss specific parts of the
>>> code.
>>>
>>> [1] https://github.com/OpenChannelSSD
>>>
>>>> On 28 Jun 2017, at 01.30, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net> wrote:
>>>>
>>>> I'm currently having trouble with LightNVM pblk with kernel 4.12-rc7 on
>>>> Ubuntu 16.04.2 x86_64 in a Qemu VM using latest
>>>> https://github.com/OpenChannelSSD/qemu-nvme .
>>>>
>>>> I'm creating a pblk device inside the VM with the following command:
>>>> [...]
>>>>
>>>> This might either be a bug in the OpenChannelSSD qemu tree, or it might
>>>> be a kernel bug.
>>>>
>>>> I also got warnings like the below:
>>> In the 4.12 patches for pblk we do not have an error state machine. This
>>> is, when writes fail on the device (on qemu in this case), we did not
>>> communicate this to the application. This bad error handling results in
>>> unexpected side-errors like the one you are experiencing. On the patches
>>> for 4.13, we have implemented the error state machine, so this type of
>>> errors should be better handled.
>> Oh. Shouldn't a minimal version of those patches get merged into 4.12
>> (or 4.12-stable once 4.12 is released) to avoid releasing a kernel with
>> a data corruption bug?
> This is only in case the device fails, how we handle the error on the
> host. If the device is not accepting writes for some reason, data is
> lost anyway. So I don't think we need the fix for stable.

This is odd. AFAICS qemu isn't configured to simulate device failure, so
in theory this should never have happened. Can you think of any reason
why this code path was triggered? Should I open a separate github issue
for that?


>>> You can pick up the code from out github (linux.git - branch:
>>> pblk.for-4.13) or take it directly form Jens' for-4.13/core
>> Thanks. A full kernel compile will take some time, though. Do you happen
>> to have a Ubuntu-compatible kernel .deb for the new code?
> We thought about, but never actually did it (to share at least). I see
> it might be useful :) For the time being, I'll share a minimal .config
> for qemu, which takes a couple of minutes to compile.

Thanks!

 
>> [various bugs]
>> Filed as https://github.com/OpenChannelSSD/linux/issues/28
>> Filed as https://github.com/OpenChannelSSD/linux/issues/29
>> Filed as https://github.com/OpenChannelSSD/linux/issues/30
>> Filed as https://github.com/OpenChannelSSD/linux/issues/31
>>
>> Regards,
>> Carl-Daniel
> Javier

Regards,
Carl-Daniel
