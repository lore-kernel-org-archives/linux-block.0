Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34239 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755028AbcKBQCO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2016 12:02:14 -0400
Received: by mail-pf0-f178.google.com with SMTP id n85so14221918pfi.1
        for <linux-block@vger.kernel.org>; Wed, 02 Nov 2016 09:02:14 -0700 (PDT)
Subject: Re: [PATCH 0/7] LightNVM patchset V2
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1477591299-26504-1-git-send-email-javier@cnexlabs.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <08d61d55-388c-bfbb-1e32-4d3aa2ca7feb@lightnvm.io>
Date: Wed, 2 Nov 2016 17:02:11 +0100
MIME-Version: 1.0
In-Reply-To: <1477591299-26504-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/27/2016 08:01 PM, Javier González wrote:
> V2: Rebase patches on Matias' for-next
> 
> Javier González (7):
>   lightnvm: enable to send hint to erase command
>   lightnvm: do not decide on device blocks
>   lightnvm: manage block list on LUN owner
>   lightnvm: drop reserve and release LUN callbacks
>   lightnvm: export set bad block table
>   lightnvm: add ECC error codes
>   lightnvm: rrpc: split bios of size > 256kb
> 
>  drivers/lightnvm/core.c      |  41 ++++++++--
>  drivers/lightnvm/gennvm.c    | 180 +++++++++++++++++++++++++------------------
>  drivers/lightnvm/gennvm.h    |  19 ++---
>  drivers/lightnvm/rrpc.c      | 128 ++++++++++++++++++++++++------
>  drivers/lightnvm/rrpc.h      |   4 +
>  drivers/lightnvm/sysblk.c    |  33 ++------
>  drivers/nvme/host/lightnvm.c |   1 +
>  include/linux/lightnvm.h     |  52 +++++++++----
>  8 files changed, 305 insertions(+), 153 deletions(-)
> 

Thanks Javier. I've picked 1-2 and 5-7 to my for-next.
