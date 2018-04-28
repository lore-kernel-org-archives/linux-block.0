Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37056 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeD1TbM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Apr 2018 15:31:12 -0400
Received: by mail-pf0-f195.google.com with SMTP id p6so3873860pfn.4
        for <linux-block@vger.kernel.org>; Sat, 28 Apr 2018 12:31:11 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Rework write error handling in pblk
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
Cc: linux-block@vger.kernel.org, Javier Gonzales <javier@cnexlabs.com>,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <1524548732-4326-1-git-send-email-hans.ml.holmberg@owltronix.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <7536f5dc-bc11-ae4b-b11e-9c3995142cd0@lightnvm.io>
Date: Sat, 28 Apr 2018 12:31:08 -0700
MIME-Version: 1.0
In-Reply-To: <1524548732-4326-1-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 4/23/18 10:45 PM, Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> This patch series fixes the(currently incomplete) write error handling
> in pblk by:
> 
>   * queuing and re-submitting failed writes in the write buffer
>   * evacuating valid data data in lines with write failures, so the
>     chunk(s) with write failures can be reset to a known state by the fw
> 
> Lines with failures in smeta are put back on the free list.
> Failed chunks will be reset on the next use.
> 
> If a write failes in emeta, the lba list is cached so the line can be
> garbage collected without scanning the out-of-band area.
> 
> Changes in V2:
> - Added the recov_writes counter increase to the new path
> - Moved lba list emeta reading during gc to a separate function
> - Allocating the saved lba list with pblk_malloc instead of kmalloc
> - Fixed formatting issues
> - Removed dead code
> 
> Hans Holmberg (3):
>    lightnvm: pblk: rework write error recovery path
>    lightnvm: pblk: garbage collect lines with failed writes
>    lightnvm: pblk: fix smeta write error path
> 
>   drivers/lightnvm/pblk-core.c     |  52 +++++++-
>   drivers/lightnvm/pblk-gc.c       | 102 +++++++++------
>   drivers/lightnvm/pblk-init.c     |  47 ++++---
>   drivers/lightnvm/pblk-rb.c       |  39 ------
>   drivers/lightnvm/pblk-recovery.c |  91 -------------
>   drivers/lightnvm/pblk-rl.c       |  29 ++++-
>   drivers/lightnvm/pblk-sysfs.c    |  15 ++-
>   drivers/lightnvm/pblk-write.c    | 269 ++++++++++++++++++++++++++-------------
>   drivers/lightnvm/pblk.h          |  36 ++++--
>   9 files changed, 384 insertions(+), 296 deletions(-)
> 

Thanks Hans. I've applied 1 & 3. The second did not apply cleanly to 
for-4.18/core. Could you please resend a rebased version?
