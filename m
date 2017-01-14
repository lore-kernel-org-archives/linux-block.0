Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36799 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751831AbdANVPp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Jan 2017 16:15:45 -0500
Received: by mail-wm0-f65.google.com with SMTP id r126so20660674wmr.3
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 13:15:44 -0800 (PST)
Subject: Re: [PATCH] nbd: create a recv workqueue per nbd device
To: Josef Bacik <jbacik@fb.com>
References: <1484322673-10606-1-git-send-email-jbacik@fb.com>
 <ef333dc1-64c6-ac46-5dd3-c62509e7dd89@grimberg.me>
 <C2506CBE-045B-4644-A0FD-4A8BA2F4EFD1@fb.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cd41cf6a-ea9b-8759-ce26-de850ef04e16@grimberg.me>
Date: Sat, 14 Jan 2017 23:15:40 +0200
MIME-Version: 1.0
In-Reply-To: <C2506CBE-045B-4644-A0FD-4A8BA2F4EFD1@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>> Hey Josef,
>>
>>> Since we are in the memory reclaim path we need our recv work to be on a
>>> workqueue that has WQ_MEM_RECLAIM set so we can avoid deadlocks.  Also
>>> set WQ_HIGHPRI since we are in the completion path for IO.
>>
>> Really a workqueue per device?? Did this really give performance
>> advantage? Can this really scale with number of devices?
>
> I don't see why not, especially since these things run the whole time the device is active.  I have patches forthcoming to make device creation dynamic so we don't have a bunch all at once.  That being said I'm not married to the idea, just seemed like a good idea at the time and not particularly harmful.  Thanks,

I just don't see how having a worqueue per device helps anything? There
are plenty of active workers per workqueue and even if its not enough
you can specify more with max_active.

I guess what I'm trying to say is that I don't understand what this is
solving. The commit message explains why you need WQ_MEM_RECLAIM and why
you want WQ_HIGHPRI, but does not explain why workqueue per device is
helping/solving anything.
