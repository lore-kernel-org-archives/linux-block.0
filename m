Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44265 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbeHaSEn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Aug 2018 14:04:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id q127-v6so10154837ljq.11
        for <linux-block@vger.kernel.org>; Fri, 31 Aug 2018 06:57:06 -0700 (PDT)
Subject: Re: [PATCH 0/4] lightnvm: pblk: add support for chunk metadata on
 erase
To: javier@javigon.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
References: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <71f5f8b3-66d5-a0e0-85ab-cb22e5ac621c@lightnvm.io>
Date: Fri, 31 Aug 2018 15:57:03 +0200
MIME-Version: 1.0
In-Reply-To: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/31/2018 03:34 PM, Javier González wrote:
> Matias,
> 
> This patchset implements support for retrieving chunk metadata when
> submitting a reset/erase command. Patches 0 and 1 are small fixes that
> can be directly merged into your patch:
>    
>    lightnvm: move bad block and chunk state logic to core
> 
> Also, note that these do not apply on top of your for-4.20/core due them
> depending on patches that I sent before that you have not picked up yet.
> You can see them though in for-4.20/pblk. I'll rebase as patches in the
> list appear in your tree.

Thanks. It is really confusing when you guys maintains an implicit order 
and posts the patches separately. I will appreciate that patches that 
are related are posted together, such that I don't have to manually 
track what comes before another. That makes it less of a pain for me to 
keep track of and we can keep the reviews together.

This is the patches that I have in the pipeline (from before the e-mails 
from today):

   - This serie - Pending review
   - Serie: pblk: support variable OOB size - Waiting on review from Igor
   - lightnvm: pblk: recover open lines on 2.0 devices. Which doesn't 
apply due to the fixes to the pad distance patch.

> 
> Thanks,
> Javier
> 
> Javier González (4):
>    lightnvm: use right address format on 1.2 path
>    lightnvm: assign block address before slba
>    lightnvm: pblk: add helper for printing chunk state
>    lightnvm: pblk: retrieve chunk metadata on erase
> 
>   drivers/lightnvm/core.c      | 51 +++++++++++++++++++++++++++++++++++++++-----
>   drivers/lightnvm/pblk-core.c | 47 ++++++++++++++++++++++++++++++----------
>   drivers/lightnvm/pblk.h      |  9 ++++++++
>   3 files changed, 91 insertions(+), 16 deletions(-)
> 
