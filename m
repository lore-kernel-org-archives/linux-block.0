Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36188 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeKGSRA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Nov 2018 13:17:00 -0500
Received: by mail-lj1-f196.google.com with SMTP id s15-v6so14023893lji.3
        for <linux-block@vger.kernel.org>; Wed, 07 Nov 2018 00:47:37 -0800 (PST)
Subject: Re: [PATCH v3 0/7] PBLK Bugfixes and cleanups
To: hans.ml.holmberg@owltronix.com
Cc: javier@cnexlabs.com, sboisvert@gydle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hans.holmberg@cnexlabs.com
References: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <b73d4c3e-bc2e-9a7d-cc8d-abf5dacb874e@lightnvm.io>
Date: Wed, 7 Nov 2018 09:47:34 +0100
MIME-Version: 1.0
In-Reply-To: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 11/06/2018 02:33 PM, Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> This series is a slew of bugfixes and cleanups for PBLK, mostly
> fixing issues found during corner-case testing in QEMU.
> 
> Changes since v1:
> 	Messed up from:, now the patches apply with the correct author
> 	Pardon the mess.
> 
> Changes since v2:
> 	Fixed kbuild reported issue and potential divide by zero in:
> 		("lightnvm: pblk: set conservative threshold for user writes")
> 	Fixed commit message nitpicks reported by Sebastien
> 
> The patch-set applies on top of:
> 	remote https://github.com/OpenChannelSSD/linux.git
> 	branch for-4.21/core
> 
> Hans Holmberg (7):
>    lightnvm: pblk: fix resubmission of overwritten write err lbas
>    lightnvm: pblk: account for write error sectors in emeta
>    lightnvm: pblk: stop writes gracefully when running out of lines
>    lightnvm: pblk: set conservative threshold for user writes
>    lightnvm: pblk: remove unused macro
>    lightnvm: pblk: fix pblk_lines_init error handling path
>    lightnvm: pblk: remove dead code in pblk_recov_l2p
> 
>   drivers/lightnvm/pblk-init.c     | 45 ++++++++++++++++++--------
>   drivers/lightnvm/pblk-map.c      | 47 ++++++++++++++++-----------
>   drivers/lightnvm/pblk-recovery.c |  1 -
>   drivers/lightnvm/pblk-rl.c       |  5 ++-
>   drivers/lightnvm/pblk-write.c    | 55 +++++++++++++++++++++++---------
>   drivers/lightnvm/pblk.h          | 16 ++++++++--
>   6 files changed, 116 insertions(+), 53 deletions(-)
> 

Sebastien, would you like me add your Reviewed-by?
