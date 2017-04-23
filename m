Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34199 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163051AbdDWSAp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Apr 2017 14:00:45 -0400
Received: by mail-lf0-f47.google.com with SMTP id t144so63976884lff.1
        for <linux-block@vger.kernel.org>; Sun, 23 Apr 2017 11:00:44 -0700 (PDT)
Subject: Re: [PATCH 0/5] lightnvm: pblk extra patches for 4.12
To: Jens Axboe <axboe@fb.com>
References: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
Cc: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <49082c5d-963c-d463-3a84-206308d9bff2@lightnvm.io>
Date: Sun, 23 Apr 2017 20:00:41 +0200
MIME-Version: 1.0
In-Reply-To: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/22/2017 01:32 AM, Javier González wrote:
> Hi Matias,
>
> This is a couple of bug fixes for the pblk release patch.
>
> Thanks,
> Javier
>
> Javier González (5):
>   lightnvm: pblk: fix race condition on line retry
>   lightnvm: pblk: fix bad error check
>   lightnvm: pblk: fix memory leak on error path
>   lightnvm: pblk: free metadata on line alloc failure
>   lightnvm: pblk: fix erase counters on error fail
>
>  drivers/lightnvm/pblk-core.c  | 60 ++++++++++++++++++++++++++-----------------
>  drivers/lightnvm/pblk-gc.c    |  2 +-
>  drivers/lightnvm/pblk-init.c  |  9 ++++---
>  drivers/lightnvm/pblk-map.c   |  4 +--
>  drivers/lightnvm/pblk-rl.c    |  6 +++--
>  drivers/lightnvm/pblk-write.c |  7 +++--
>  drivers/lightnvm/pblk.h       |  6 ++---
>  7 files changed, 57 insertions(+), 37 deletions(-)
>

Hi Jens,

Could you pick these up as well? This will properly be the last for the 
4.12 window. Thank you!

-Matias
