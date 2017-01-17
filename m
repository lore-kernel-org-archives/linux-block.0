Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48027 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750728AbdAQASW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2017 19:18:22 -0500
Date: Mon, 16 Jan 2017 18:17:44 -0600
From: Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH] nbd: use an idr to keep track of nbd devices
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Message-ID: <1484612264.10374.0@smtp.office365.com>
In-Reply-To: <7c2ddd83-5d09-5ffb-3c39-524d17c24796@grimberg.me>
References: <1484334292-29933-1-git-send-email-jbacik@fb.com>
        <0439c54d-228c-78fb-4790-94095ef39c93@grimberg.me>
        <DB56A2D2-42FA-46F4-A250-F5E987CB5E61@fb.com>
        <45c6936a-a38b-e612-90d6-6087de8cab91@grimberg.me>
        <1484442837.7132.1@smtp.office365.com>
        <7c2ddd83-5d09-5ffb-3c39-524d17c24796@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jan 16, 2017 at 3:29 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
> Hey Josef,
> 
>> I'm going to use it the same way loop does, there will be a
>> /dev/nbd-control where you can say ADD, REMOVE, and GET_NEXT. I need 
>> the
>> search functionality to see if we are adding something that already
>> exists, and to see what is the next unused device that can be used 
>> for a
>> connection.  Looking at the ida api it does not appear I can do 
>> that. If
>> I'm wrong then please point out an example I can look at, because I
>> haven't been able to find one.  Thanks,
> 
> Nope, ida doesn't have search functionality. Having said that, will it
> suffice to have the idr tree without a separate data structure? 
> because
> the tree mutation under idr_for_each is not allowed. For example,
> I'd expect that nbd module unload will iterate over the existing
> devices and destroy them which requires a separate tracking of
> them, also, I think that the idr user needs to take care of locking
> (unlike ida).

So I don't plan on messing with it under idr_for_each.  I'm basically 
copying+pasting what loop is doing and doing :1,$s/loop/nbd/g and 
hoping for the best.  I'm going to add reference counting to the nbd 
devices obviously to keep us from removing in use nbd devices.  The 
idr_for_each in the unload doesn't actually remove the devices from the 
idr, it just free's them.

Also so I don't have to find the other thread I did manage to test with 
per-device workqueues and a global workqueue and the performance was 
the same, I'll make that change to the other patch and resend it when I 
finish all this work so you can see the full picture.  Thanks!

Josef

