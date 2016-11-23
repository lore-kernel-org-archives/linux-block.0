Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35316 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934541AbcKWMHA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2016 07:07:00 -0500
Received: by mail-wm0-f44.google.com with SMTP id a197so74949930wmd.0
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2016 04:07:00 -0800 (PST)
Subject: Re: [PATCH 0/8] lightnvm: simplify media manager V2
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1479730237-20797-1-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <a61ef190-d698-d388-55e0-3f406f6181b9@lightnvm.io>
Date: Wed, 23 Nov 2016 13:06:57 +0100
MIME-Version: 1.0
In-Reply-To: <1479730237-20797-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 11/21/2016 01:10 PM, Javier González wrote:
> V2:
>   - Fix 2 bad memory free on error rrpc init error handling. Reported by
>     kbuild.
> 
> This patchset simplifies the generic media manager interface and moves
> lun and block functionality to lightnvm targets. This makes that
> rrpc-specific functionality is not exposed on the media manager. This is
> done in preparation for the pblk target.
> 
> Javier González (8):
>   lightnvm: move block provisioning to targets
>   lightnvm: remove get_lun operation on gennvm
>   lightnvm: remove debug lun statistics from gennvm
>   lightnvm: eliminate nvm_block abstraction on mm
>   lightnvm: eliminate nvm_lun abstraction in mm
>   lightnvm: introduce helpers for generic ops in rrpc
>   lightnvm: introduce max_phys_sects helper function
>   lightnvm: use target nvm on target-specific ops.
> 
>  drivers/lightnvm/core.c      | 154 ++++++-----
>  drivers/lightnvm/gennvm.c    | 612 ++++++++++++++++++++-----------------------
>  drivers/lightnvm/gennvm.h    |  20 +-
>  drivers/lightnvm/rrpc.c      | 443 +++++++++++++++++++++----------
>  drivers/lightnvm/rrpc.h      |  62 ++++-
>  drivers/lightnvm/sysblk.c    |  65 +++--
>  drivers/nvme/host/lightnvm.c |  14 +-
>  include/linux/lightnvm.h     | 217 +++++++--------
>  8 files changed, 885 insertions(+), 702 deletions(-)
> 

Thanks Javier. Picked up for 4.10. Please note I fixed up an
initialization bug with null_blk device in the "lightnvm: introduce
helpers for generic ops in rrpc" patch.
