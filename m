Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D384EC433EF
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 09:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1EAE610F8
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 09:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhIIJPp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 05:15:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48619 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232397AbhIIJPp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Sep 2021 05:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631178875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IwrV6CBErT/2+bjvvGF6F5wCJzktcgQy+npgzDKE6Nk=;
        b=PfpOTIlMfRbQaupMhzAWe3pGRJ8SjQSilDdtv7iIU5KdxKv5F92hXHTisfeHy+G5LCBe/F
        qjErfk2Y7nwJZqmPsC78YDuYu6lXoi/Yxkysg2bSCEGl1z4uSYA8aCmsg+Ms6N3yEXS5CJ
        5ZtHn9nFdkiPkfbKgyBw6dgNrkmmTU8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-hZYtKGaEMVCVvBKavI0eZw-1; Thu, 09 Sep 2021 05:14:34 -0400
X-MC-Unique: hZYtKGaEMVCVvBKavI0eZw-1
Received: by mail-lf1-f72.google.com with SMTP id q3-20020ac25283000000b003dedfdcf716so453493lfm.20
        for <linux-block@vger.kernel.org>; Thu, 09 Sep 2021 02:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=IwrV6CBErT/2+bjvvGF6F5wCJzktcgQy+npgzDKE6Nk=;
        b=NvNkMXg+geEAW2bhrcn0OlPNie82xGPrdic5IAXZEEIOzVb+hq70euFMFeMobuv7ni
         A1+Y/VdIR90DKPyW+f/+FO/sV06+iycMB8Oi6E0YWnTyyAv9ElYxN12ZoesQaLhV4IBz
         +cAHcOGF5IyGUX+W4CAtE89RYrbV05SlXOajVLYEUYndAsQR+lDMKm6fTNYG/20jWHSe
         ewz7LjP3gSRoFt1lLe8IcAbfAGOQOZLqINYqasR0PzgpFLXhc2a7noXl1lGSORNnMZeN
         Rl7/eX4cox+fm5hadRUurLSb7sDnP6lCgmW2U10/lUk7fmfLYn3Vi8vWRD6nc1vs9P0G
         2+tA==
X-Gm-Message-State: AOAM533N30vtObcQhZgsviULlPTIWNKmIIBoWmJdAUGpwwob0MJLJ19M
        G5dDG9vNfbYmXp9C5aU3GhIZelrZN5Ttrj4apt4ApIQ5a3sDGlojuvao6XiCI/6/XgHhn98I4vO
        YyMASyIRySvLk7RkL4sKuFo7fEblYo2UrIaVMmnQ=
X-Received: by 2002:ac2:4e90:: with SMTP id o16mr1541352lfr.473.1631178872995;
        Thu, 09 Sep 2021 02:14:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsDiFT99DBdrxcZc/J53HDM3REETEbLvvvuDLe6QjjQbYaeShD5qU4TT7liQC3NX8h+5L3NGtLZqijKlPWWRE=
X-Received: by 2002:ac2:4e90:: with SMTP id o16mr1541343lfr.473.1631178872791;
 Thu, 09 Sep 2021 02:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs-noupgFn3QjB96Z20hv-BhFLHOyFZFEtrhGpESkeoRSA@mail.gmail.com>
In-Reply-To: <CAHj4cs-noupgFn3QjB96Z20hv-BhFLHOyFZFEtrhGpESkeoRSA@mail.gmail.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Thu, 9 Sep 2021 17:14:18 +0800
Message-ID: <CAFj5m9J4sxRwQb7+nHzYOurX9QRpEgsEMCqdx4SHA4THnsJXBA@mail.gmail.com>
Subject: Re: [bug report] NULL pointer at blk_mq_put_rq_ref+0x20/0xb4 observed
 with blktests on 5.13.15
To:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 9, 2021 at 4:47 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> Hello
>
> I found this issue with blktests on[1], did we miss some patch on stable?
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> queue/5.13
>
> [   68.989907] run blktests block/006 at 2021-09-09 04:34:35
> [   69.085724] null_blk: module loaded
> [   74.271624] Unable to handle kernel NULL pointer dereference at
> virtual address 00000000000002b8
> [   74.280414] Mem abort info:
> [   74.283195]   ESR = 0x96000004
> [   74.286245]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   74.291545]   SET = 0, FnV = 0
> [   74.294587]   EA = 0, S1PTW = 0
> [   74.297720] Data abort info:
> [   74.300588]   ISV = 0, ISS = 0x00000004
> [   74.304411]   CM = 0, WnR = 0
> [   74.307368] user pgtable: 4k pages, 48-bit VAs, pgdp=000008004366e000
> [   74.313796] [00000000000002b8] pgd=0000000000000000, p4d=0000000000000000
> [   74.320577] Internal error: Oops: 96000004 [#1] SMP
> [   74.325443] Modules linked in: null_blk mlx5_ib ib_uverbs ib_core
> rfkill sunrpc vfat fat joydev acpi_ipmi ipmi_ssif cdc_ether usbnet mii
> mlx5_core psample ipmi_devintf mlxfw tls ipmi_msghandler arm_cmn
> cppc_cpufreq arm_dsu_pmu acpi_tad fuse zram ip_tables xfs ast
> i2c_algo_bit drm_vram_helper drm_kms_helper crct10dif_ce syscopyarea
> ghash_ce sysfillrect uas sysimgblt sbsa_gwdt fb_sys_fops cec
> drm_ttm_helper ttm nvme usb_storage nvme_core drm xgene_hwmon
> aes_neon_bs
> [   74.366458] CPU: 31 PID: 2511 Comm: fio Not tainted 5.13.15+ #1

Looks the fixes haven't land on linux-5.13.y:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a9ed27a764156929efe714033edb3e9023c5f321
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c2da19ed50554ce52ecbad3655c98371fe58599f

Thanks,

