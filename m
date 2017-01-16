Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36663 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750834AbdAPV3y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2017 16:29:54 -0500
Received: by mail-wm0-f48.google.com with SMTP id c85so175086909wmi.1
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2017 13:29:54 -0800 (PST)
Subject: Re: [PATCH] nbd: use an idr to keep track of nbd devices
To: Josef Bacik <jbacik@fb.com>
References: <1484334292-29933-1-git-send-email-jbacik@fb.com>
 <0439c54d-228c-78fb-4790-94095ef39c93@grimberg.me>
 <DB56A2D2-42FA-46F4-A250-F5E987CB5E61@fb.com>
 <45c6936a-a38b-e612-90d6-6087de8cab91@grimberg.me>
 <1484442837.7132.1@smtp.office365.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7c2ddd83-5d09-5ffb-3c39-524d17c24796@grimberg.me>
Date: Mon, 16 Jan 2017 23:29:50 +0200
MIME-Version: 1.0
In-Reply-To: <1484442837.7132.1@smtp.office365.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hey Josef,

> I'm going to use it the same way loop does, there will be a
> /dev/nbd-control where you can say ADD, REMOVE, and GET_NEXT. I need the
> search functionality to see if we are adding something that already
> exists, and to see what is the next unused device that can be used for a
> connection.  Looking at the ida api it does not appear I can do that. If
> I'm wrong then please point out an example I can look at, because I
> haven't been able to find one.  Thanks,

Nope, ida doesn't have search functionality. Having said that, will it
suffice to have the idr tree without a separate data structure? because
the tree mutation under idr_for_each is not allowed. For example,
I'd expect that nbd module unload will iterate over the existing
devices and destroy them which requires a separate tracking of
them, also, I think that the idr user needs to take care of locking
(unlike ida).
