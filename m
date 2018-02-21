Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46842 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeBUIKB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Feb 2018 03:10:01 -0500
Received: by mail-lf0-f68.google.com with SMTP id r80so1079414lfe.13
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 00:10:01 -0800 (PST)
Subject: Re: [PATCH 0/3] pblk bugfixes
To: hans.ml.holmberg@owltronix.com
Cc: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <1519200181-10886-1-git-send-email-hans.ml.holmberg@owltronix.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <40fb8893-3c8a-d471-e78a-4a2eea079884@lightnvm.io>
Date: Wed, 21 Feb 2018 09:09:58 +0100
MIME-Version: 1.0
In-Reply-To: <1519200181-10886-1-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/21/2018 09:02 AM, hans.ml.holmberg@owltronix.com wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> This is a slew of generic bugfixes to pblk
> 
> The patches apply on top of:
> https://github.com/OpenChannelSSD/linux branch for-4.17/core
> 
> Hans Holmberg (3):
>    lightnvm: pblk: delete writer kick timer before stopping thread
>    lightnvm: pblk: allow allocation of new lines during shutdown
>    lightnvm: pblk: prevent race in pblk_rb_flush_point_set
> 
>   drivers/lightnvm/pblk-core.c | 7 -------
>   drivers/lightnvm/pblk-init.c | 2 +-
>   drivers/lightnvm/pblk-rb.c   | 7 ++++---
>   3 files changed, 5 insertions(+), 11 deletions(-)
> 

Thanks Hans. Applied.
