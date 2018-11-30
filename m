Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742A7C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 13:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3991020863
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 13:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="mU7nIxri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3991020863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbeLAANG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:13:06 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:40760 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeLAANG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 19:13:06 -0500
Received: by mail-vk1-f195.google.com with SMTP id v70so1239121vkv.7
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 05:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IDtMRg0zgn6xq15KCJn5c+fN9JPBj5A8IS2HYJ/TT68=;
        b=mU7nIxrivMY1Mlw9byZnsNPh40AiohDnKtANoB7bXigcCvBGBbgJCt54MpnSXW47lv
         5DYa7haDvcXF4NrrMilntg7fcp7/2n3KQnUyf1ykbYdnzalQBVw4To6ypxdpPAVAnoVP
         mjWFqlveRVggtYRYsp4JUkmxcqqlxYR81B3pYfp+0dql8sWbK/gPTV4zDWEI+/QuMDWV
         bDu7jFQ0qB0biSbcwSt1hJ5dGioGoBurtlZMIwuPEbvslqvd1FXueixYnQO67MGx3ZpX
         k71co2R+POW7+2eXLVzgscQodDR+SSkJNQ2RKo0vhmu+d/UHVRHCxRJrYz35VosOfsHF
         J3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IDtMRg0zgn6xq15KCJn5c+fN9JPBj5A8IS2HYJ/TT68=;
        b=gNeNsJ7jDXW6eUSK+t1vqp6SpoQhukA6eiKWJAumSXf/T3vFej0YSrPwEzY+eh7l8C
         2p3hyJnXYUtHLW9dd1b1D4L8E6A31xN5UVHmsUXqd5Rrn6oKRdMtsrxXnAlx1T8JHm2N
         ZnW79SpzxJW5NRyFdAcv8GVTBmDTLp1UOgBWJprol+PFttQut79aPTDUE92kZWcNTWhz
         cJolN8+fDaaLJ6Usy17q55ysbUEMW1SCoIG+On4QNN7N4q/PBaOfb5Fc6pJ4zKzbTeKX
         qwdUl7HyQMCdxqLBFhrLStyGjWgJ6s9DtpF3lRP3kclb+haYkpcSxp8JcVE9EgRt++Wo
         3Y7Q==
X-Gm-Message-State: AA+aEWYh+5iovrwDCIf1I2kB8eh7kxrcUqIQKCT6zJcy9xo2YAYJQKjH
        6Eq/qrGO4Mdb0uP6kW8d1zQv89b6PhdW2qWpwxQHJeQ80vE=
X-Google-Smtp-Source: AFSGD/V6BUaaQqB15u86NjSQYt96uU8xf3U/7QmbpWgT1W+YNhkIaYpGff8wopV48JuFZ3JGHW/RMjti/Ozo4zY28f4=
X-Received: by 2002:a1f:8b48:: with SMTP id n69mr2443426vkd.12.1543583030568;
 Fri, 30 Nov 2018 05:03:50 -0800 (PST)
MIME-Version: 1.0
References: <20181130114402.43793-1-igor.j.konopko@intel.com>
In-Reply-To: <20181130114402.43793-1-igor.j.konopko@intel.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Fri, 30 Nov 2018 14:03:39 +0100
Message-ID: <CANr-nt33vO=egptfmCxDEdom5CKEEQ=NA1R5_z0Pe951-cPmSw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] lightnvm: Flexible metadata
To:     igor.j.konopko@intel.com
Cc:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        Javier Gonzalez <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I just started a regression test on this patch set that'll run over
the weekend. I'll add a tested-by if everything checks out.

All the best,
Hans
On Fri, Nov 30, 2018 at 12:49 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>
> This series of patches extends the way how pblk can
> store L2P sector metadata. After this set of changes
> any size of NVMe metadata is supported in pblk.
> Also there is an support for case without NVMe metadata.
>
> Changes v4 --> v5:
> -rebase on top of ocssd/for-4.21/core
>
> Changes v3 --> v4:
> -rename nvm_alloc_dma_pool() to nvm_create_dma_pool()
> -split pblk_get_meta() calls and lba setting into
> two operations for better core readability
> -fixing compilation with CONFIG_NVM disabled
> -getting rid of unnecessary memcpy for packed metadata
> on write path
> -support for drives with oob size >0 and <16B in packed
> metadata mode
> -minor commit message updates
>
> Changes v2 --> v3:
> -Rebase on top of ocssd/for-4.21/core
> -get/set_meta_lba helpers were removed
> -dma reallocation was replaced with single allocation
> -oob metadata size was added to pblk structure
> -proper checks on pblk creation were added
>
> Changes v1 --> v2:
> -Revert sector meta size back to 16b for pblk
> -Dma pool for larger oob meta are handled in core instead of pblk
> -Pblk oob meta helpers uses __le64 as input outpu instead of u64
> -Other minor fixes based on v1 patch review
>
> Igor Konopko (5):
>   lightnvm: pblk: Move lba list to partial read context
>   lightnvm: pblk: Helpers for OOB metadata
>   lightnvm: Flexible DMA pool entry size
>   lightnvm: Disable interleaved metadata
>   lightnvm: pblk: Support for packed metadata
>
>  drivers/lightnvm/core.c          |  9 ++++--
>  drivers/lightnvm/pblk-core.c     | 61 +++++++++++++++++++++++++++++++------
>  drivers/lightnvm/pblk-init.c     | 44 +++++++++++++++++++++++++--
>  drivers/lightnvm/pblk-map.c      | 20 +++++++-----
>  drivers/lightnvm/pblk-rb.c       |  3 ++
>  drivers/lightnvm/pblk-read.c     | 66 +++++++++++++++++++++++-----------------
>  drivers/lightnvm/pblk-recovery.c | 25 +++++++++------
>  drivers/lightnvm/pblk-sysfs.c    |  7 +++++
>  drivers/lightnvm/pblk-write.c    |  9 +++---
>  drivers/lightnvm/pblk.h          | 24 +++++++++++++--
>  drivers/nvme/host/lightnvm.c     |  6 ++--
>  include/linux/lightnvm.h         |  3 +-
>  12 files changed, 209 insertions(+), 68 deletions(-)
>
> --
> 2.14.5
>
