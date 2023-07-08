Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8C9EB64DA
	for <linux-block@archiver.kernel.org>; Sat,  8 Jul 2023 05:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjGHFhB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 8 Jul 2023 01:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHFg7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 8 Jul 2023 01:36:59 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC2C2108
        for <linux-block@vger.kernel.org>; Fri,  7 Jul 2023 22:36:56 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40355c95677so18328051cf.2
        for <linux-block@vger.kernel.org>; Fri, 07 Jul 2023 22:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688794615; x=1691386615;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/6X+3H1ljfy7IjsbLjk8teqFst7rLlyJv0xIACsaZ2M=;
        b=YTtOX0w+o9n/CPVzXDv1lowkOGTsW9kVS4l1u0GlN+P4+Pe6TRMgaq+o7QEeDp1B1f
         7vM6U77MpQ9uceQKGo0/a+NnWjsimwHU6ohZpZeFLkemHDBGS0frgwzmdlyfUOOBAbxU
         ET+4I+z7GIBzMBcsWS/933I401edCFOFcHQNgUzaGht1OEi7TIAKdIBtTQz9Kzgb2tiU
         tw5cc4FxstdLt4ipYhJ9ZMkYCPe29jz+lLQa4scUKCUFk/nlfJ+gnP1h7/hQnqFLSwvv
         /cA8qPKZNBaudKaHEGn+LQXo3rJzTpV5iLzFhKIQjljhwcsODwxFNmwiIbD6qae1PQVx
         1cdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688794615; x=1691386615;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6X+3H1ljfy7IjsbLjk8teqFst7rLlyJv0xIACsaZ2M=;
        b=NW7jbNjUiOcIBJ/WpWd2q26S0MWdB8gxwIgt+AaLkiqbtpa8pUoRwa9blz9XZOXiMR
         80NlGwv5WKY+iVl/zdlLYh4KqBBL93GRTe2dDXTTHaXFZdz+k6PuNNetXduoV+n4XBQX
         UQXmfoXVnWkFokrapotezRBolMsPJrnSpa8IHTGLSEG9CjowxbmYfcNW/uMK61bF50E4
         I6MnWPl7LM1hgN0OooznlkM0nnO/lJgy2Mvuq0L00T/R7+D+GJEZh4K8oeEaejRIWUVK
         jeCjXoFAFOB0bMstaZwd8nOl9rwpVm2QAuTJUQAD1S7VEY9R03bAOBO+v8zn47YSsNqz
         13tg==
X-Gm-Message-State: ABy/qLbbPXOV3qTYJFtSEJOCzR5Mqc86XciRTisNHWvsYWXV1W/10eeV
        3LKQJmpSCnKjDKOanhw3Qu/X
X-Google-Smtp-Source: APBJJlG+a1EKnj+jvMEDInNdvc1r1W/hz+0/12Nwm+mpbZz0DyPSVNjr9MqOf37m7Bq8n/2COLAfQA==
X-Received: by 2002:a05:620a:4051:b0:767:923:48d8 with SMTP id i17-20020a05620a405100b00767092348d8mr6721872qko.27.1688794615250;
        Fri, 07 Jul 2023 22:36:55 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id c11-20020ae9e20b000000b0075cebaa1540sm2479491qkc.58.2023.07.07.22.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 22:36:54 -0700 (PDT)
Date:   Sat, 08 Jul 2023 01:36:54 -0400
Message-ID: <b460c0317dfbd5b4668015e104ea3e92.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk,
        agk@redhat.com, snitzer@kernel.org, eparis@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, audit@vger.kernel.org,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH RFC v10 1/17] security: add ipe lsm
References: <1687986571-16823-2-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1687986571-16823-2-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 28, 2023 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> Integrity Policy Enforcement (IPE) is an LSM that provides an
> complimentary approach to Mandatory Access Control than existing LSMs
> today.
> 
> Existing LSMs have centered around the concept of access to a resource
> should be controlled by the current user's credentials. IPE's approach,
> is that access to a resource should be controlled by the system's trust
> of a current resource.
> 
> The basis of this approach is defining a global policy to specify which
> resource can be trusted.
> 
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> ---
>  MAINTAINERS           |  7 +++++++
>  security/Kconfig      | 11 ++++++-----
>  security/Makefile     |  1 +
>  security/ipe/Kconfig  | 17 +++++++++++++++++
>  security/ipe/Makefile | 10 ++++++++++
>  security/ipe/ipe.c    | 37 +++++++++++++++++++++++++++++++++++++
>  security/ipe/ipe.h    | 16 ++++++++++++++++
>  7 files changed, 94 insertions(+), 5 deletions(-)
>  create mode 100644 security/ipe/Kconfig
>  create mode 100644 security/ipe/Makefile
>  create mode 100644 security/ipe/ipe.c
>  create mode 100644 security/ipe/ipe.h

...

> diff --git a/MAINTAINERS b/MAINTAINERS
> index a82795114ad4..ad00887d38ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10278,6 +10278,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
>  F:	security/integrity/
>  F:	security/integrity/ima/
>  
> +INTEGRITY POLICY ENFORCEMENT (IPE)
> +M:	Fan Wu <wufan@linux.microsoft.com>
> +L:	linux-security-module@vger.kernel.org
> +S:	Supported
> +T:	git git://github.com/microsoft/ipe.git

Using the raw git protocol doesn't seem to work with GH, I think you
need to refernce the git/https URL:

 https://github.com/microsoft/ipe.git

> +F:	security/ipe/
> +
>  INTEL 810/815 FRAMEBUFFER DRIVER
>  M:	Antonino Daplas <adaplas@gmail.com>
>  L:	linux-fbdev@vger.kernel.org
> diff --git a/security/Kconfig b/security/Kconfig
> index 97abeb9b9a19..daa4626ea99c 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -202,6 +202,7 @@ source "security/yama/Kconfig"
>  source "security/safesetid/Kconfig"
>  source "security/lockdown/Kconfig"
>  source "security/landlock/Kconfig"
> +source "security/ipe/Kconfig"
>  
>  source "security/integrity/Kconfig"
>  
> @@ -241,11 +242,11 @@ endchoice
>  
>  config LSM
>  	string "Ordered list of enabled LSMs"
> -	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> -	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> -	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
> -	default "landlock,lockdown,yama,loadpin,safesetid,bpf" if DEFAULT_SECURITY_DAC
> -	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"
> +	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,bpf,ipe" if DEFAULT_SECURITY_SMACK
> +	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,bpf,ipe" if DEFAULT_SECURITY_APPARMOR
> +	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf,ipe" if DEFAULT_SECURITY_TOMOYO
> +	default "landlock,lockdown,yama,loadpin,safesetid,bpf,ipe" if DEFAULT_SECURITY_DAC
> +	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf,ipe"

Generally speaking the BPF LSM should be the last entry in the LSM
list to help prevent issues caused by a BPF LSM returning an improper
error and shortcutting a LSM after it.

>  	help
>  	  A comma-separated list of LSMs, in initialization order.
>  	  Any LSMs left off this list, except for those with order

...

> diff --git a/security/ipe/Makefile b/security/ipe/Makefile
> new file mode 100644
> index 000000000000..571648579991
> --- /dev/null
> +++ b/security/ipe/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) Microsoft Corporation. All rights reserved.
> +#
> +# Makefile for building the IPE module as part of the kernel tree.
> +#
> +
> +obj-$(CONFIG_SECURITY_IPE) += \
> +	hooks.o \
> +	ipe.o \

It doesn't look like security/ipe/hook.c is included in this patch.

It is important to ensure that each patch compiles after it is
applied.

--
paul-moore.com
