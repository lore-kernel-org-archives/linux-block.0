Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35449 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751831AbdANVK3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Jan 2017 16:10:29 -0500
Received: by mail-wm0-f46.google.com with SMTP id r126so110032424wmr.0
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 13:10:28 -0800 (PST)
Subject: Re: [PATCH] nbd: use an idr to keep track of nbd devices
To: Josef Bacik <jbacik@fb.com>
References: <1484334292-29933-1-git-send-email-jbacik@fb.com>
 <0439c54d-228c-78fb-4790-94095ef39c93@grimberg.me>
 <DB56A2D2-42FA-46F4-A250-F5E987CB5E61@fb.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <45c6936a-a38b-e612-90d6-6087de8cab91@grimberg.me>
Date: Sat, 14 Jan 2017 23:10:23 +0200
MIME-Version: 1.0
In-Reply-To: <DB56A2D2-42FA-46F4-A250-F5E987CB5E61@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>> Hey Josef,
>>
>>> To prepare for dynamically adding new nbd devices to the system switch
>>> from using an array for the nbd devices and instead use an idr.  This
>>> copies what loop does for keeping track of its devices.
>>
>> I think ida_simple_* is simpler and sufficient here isn't it?
>
> I use more of the IDR stuff in later patches, I just haven't posted those yet because meetings.  Thanks,

Can you elaborate on the usage? What do you intend to do
that a simple ida cannot satisfy?
