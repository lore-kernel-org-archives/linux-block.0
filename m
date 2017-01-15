Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51409 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750738AbdAOBO3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Jan 2017 20:14:29 -0500
Date: Sat, 14 Jan 2017 20:13:57 -0500
From: Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH] nbd: use an idr to keep track of nbd devices
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Message-ID: <1484442837.7132.1@smtp.office365.com>
In-Reply-To: <45c6936a-a38b-e612-90d6-6087de8cab91@grimberg.me>
References: <1484334292-29933-1-git-send-email-jbacik@fb.com>
        <0439c54d-228c-78fb-4790-94095ef39c93@grimberg.me>
        <DB56A2D2-42FA-46F4-A250-F5E987CB5E61@fb.com>
        <45c6936a-a38b-e612-90d6-6087de8cab91@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Jan 14, 2017 at 4:10 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
> 
>>> Hey Josef,
>>> 
>>>> To prepare for dynamically adding new nbd devices to the system 
>>>> switch
>>>> from using an array for the nbd devices and instead use an idr.  
>>>> This
>>>> copies what loop does for keeping track of its devices.
>>> 
>>> I think ida_simple_* is simpler and sufficient here isn't it?
>> 
>> I use more of the IDR stuff in later patches, I just haven't posted 
>> those yet because meetings.  Thanks,
> 
> Can you elaborate on the usage? What do you intend to do
> that a simple ida cannot satisfy?

I'm going to use it the same way loop does, there will be a 
/dev/nbd-control where you can say ADD, REMOVE, and GET_NEXT. I need 
the search functionality to see if we are adding something that already 
exists, and to see what is the next unused device that can be used for 
a connection.  Looking at the ida api it does not appear I can do that. 
 If I'm wrong then please point out an example I can look at, because I 
haven't been able to find one.  Thanks,

Josef

