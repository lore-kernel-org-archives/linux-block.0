Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40392 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2R2O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 13:28:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17-v6so2292401plp.7
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 06:31:15 -0700 (PDT)
Subject: Re: [PATCH 0/7] pblk fixes
To: hans.ml.holmberg@owltronix.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
References: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f768c3a1-49b2-7477-ee69-f965e742e323@lightnvm.io>
Date: Wed, 29 Aug 2018 15:31:10 +0200
MIME-Version: 1.0
In-Reply-To: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/29/2018 02:23 PM, Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> This patchset contains a bunch of cleanups and bugfixes for 4.20.
> The patches depend on some of Javier's for-4.20 patches.
> 
> For ordering, see:
> 
> Branch: for-4.20/pblk
> Remote: ssh://github.com/OpenChannelSSD/linux
> 
> Hans Holmberg (7):
>    lightnvm: introduce nvm_rq_to_ppa_list
>    lightnvm: pblk: fix mapping issue on failed writes
>    lightnvm: pblk: allocate line map bitmaps using a mempool
>    lightnvm: pblk: move global caches to module init/exit
>    lightnvm: pblk: remove unused parameters in pblk_up_rq
>    lightnvm: pblk: fix up prints in pblk_read_check_rand
>    lightnvm: pblk: fix write amplificiation calculation
> 
>   drivers/lightnvm/core.c          | 14 +++------
>   drivers/lightnvm/pblk-core.c     | 25 +++++++++------
>   drivers/lightnvm/pblk-init.c     | 60 ++++++++++++++++++++++-------------
>   drivers/lightnvm/pblk-map.c      | 10 +++---
>   drivers/lightnvm/pblk-read.c     | 13 +++-----
>   drivers/lightnvm/pblk-recovery.c | 11 ++++---
>   drivers/lightnvm/pblk-sysfs.c    |  3 +-
>   drivers/lightnvm/pblk-write.c    | 68 +++++++++++++++++++++++++++-------------
>   drivers/lightnvm/pblk.h          | 11 ++++---
>   include/linux/lightnvm.h         |  5 +++
>   10 files changed, 134 insertions(+), 86 deletions(-)
> 

Thanks. I've picked up 1,3,5-7 for 4.20.
