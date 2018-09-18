Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34782 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729250AbeIROIz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Sep 2018 10:08:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id u1-v6so1207339eds.1
        for <linux-block@vger.kernel.org>; Tue, 18 Sep 2018 01:37:20 -0700 (PDT)
Subject: Re: [PATCH 0/4] lightnvm: pblk: fixes for read buffer
To: javier@javigon.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1537257785-31630-1-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <4b97830b-61c9-302d-5882-1ac51a94ea16@lightnvm.io>
Date: Tue, 18 Sep 2018 10:37:17 +0200
MIME-Version: 1.0
In-Reply-To: <1537257785-31630-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/18/2018 10:03 AM, Javier González wrote:
> This patchet's main motivation is to account for a corner case in which
> the read constrains imposed by the device are not respected by pblk. In
> the process, it also refactors parts of the read ring buffer to simplify
> creation/deletion operations and improve readability.
> 
> Note that the checkpatch warnings on missing comments for memory
> barriers are false positives.
> 
> The code is also available in the for-4.20/pblk branch in the OCSSD github
> project.
> 
> Thanks,
> Javier
> 
> Javier González (4):
>    lightnvm: pblk: remove unused function
>    lightnvm: pblk: encapsulate rb pointer operations
>    lightnvm: pblk: move ring buffer alloc/free rb init
>    lightnvm: pblk: guarantee mw_cunits on read buffer
> 
>   drivers/lightnvm/pblk-init.c  |  21 +++------
>   drivers/lightnvm/pblk-rb.c    | 100 +++++++++++++++++++-----------------------
>   drivers/lightnvm/pblk-write.c |   7 +--
>   drivers/lightnvm/pblk.h       |  11 ++---
>   4 files changed, 57 insertions(+), 82 deletions(-)
> 

Applied for 4.20.
