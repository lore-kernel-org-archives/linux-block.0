Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37507 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbeH2STq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 14:19:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id h69-v6so2354206pfd.4
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 07:22:35 -0700 (PDT)
Subject: Re: [PATCH 0/4] Introduce trace events for pblk
To: hans.ml.holmberg@owltronix.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
References: <1535545877-770-1-git-send-email-hans.ml.holmberg@owltronix.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <6ceb3e39-16bc-af1e-ed8f-f24b7fba2bb5@lightnvm.io>
Date: Wed, 29 Aug 2018 16:22:30 +0200
MIME-Version: 1.0
In-Reply-To: <1535545877-770-1-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/29/2018 02:31 PM, Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> This patchset adds trace events for tracking the internal state of
> pblk. I've used the events extensively the last few months, and
> they have proven very useful.
> 
> The patches depend on some of Javier's for-4.20 patches.
> For ordering, see:
> 
> Branch: for-4.20/pblk
> Remote: ssh://github.com/OpenChannelSSD/linux
> 
> Hans Holmberg (4):
>    lightnvm: pblk: add trace events for chunk states
>    lightnvm: pblk: add trace events for line state changes
>    lightnvm: pblk: add trace events for pblk state changes
>    lightnvm: pblk: add tracing for chunk resets
> 
>   drivers/lightnvm/pblk-core.c     |  69 ++++++++++++++++++-
>   drivers/lightnvm/pblk-gc.c       |   8 +++
>   drivers/lightnvm/pblk-init.c     |   8 +++
>   drivers/lightnvm/pblk-recovery.c |   6 ++
>   drivers/lightnvm/pblk-trace.h    | 145 +++++++++++++++++++++++++++++++++++++++
>   drivers/lightnvm/pblk-write.c    |  10 ++-
>   drivers/lightnvm/pblk.h          |  14 ++++
>   7 files changed, 256 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/lightnvm/pblk-trace.h
> 

Thanks. Applied for 4.20.
