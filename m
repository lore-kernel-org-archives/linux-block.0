Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46504 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2RLb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 13:11:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id b129-v6so2297941pga.13
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 06:14:38 -0700 (PDT)
Subject: Re: [PATCH 0/4] lightnvm: pblk: collection of small fixes
To: javier@javigon.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5b8881cd-019a-a1d8-86ed-0131ef3b71af@lightnvm.io>
Date: Wed, 29 Aug 2018 15:14:33 +0200
MIME-Version: 1.0
In-Reply-To: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/29/2018 11:01 AM, Javier González wrote:
> Collection of small helper function fixes, removal of unused variables
> and comment typos.
> 
> Javier González (4):
>    lightnvm: pblk: calculate line pad distance in helper
>    lightnvm: pblk: fix comment typo
>    lightnvm: pblk: remove unused variable.
>    lightnvm: pblk: guarantee emeta on line close
> 
>   drivers/lightnvm/pblk-core.c     | 13 +++++++++++--
>   drivers/lightnvm/pblk-recovery.c |  2 --
>   drivers/lightnvm/pblk-write.c    |  2 +-
>   drivers/lightnvm/pblk.h          |  6 +++---
>   4 files changed, 15 insertions(+), 8 deletions(-)
> 

Thanks. Applied 2-4. The pad distance does not compile due to missing 
update to pblk_pad_distance call from pblk-recovery.c.

Also, it looks like pblk-recovery.c is the only user. Please consider 
moving it the function from pblk.h to pblk-recovery.c
