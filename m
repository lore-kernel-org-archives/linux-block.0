Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3E5C433DB
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 13:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4DD619BD
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 13:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhC3NVv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbhC3NVe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 09:21:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E46C061574
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 06:21:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j9so14510956wrx.12
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 06:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LkSzsuk6OkyHhMGQ1Io4HJGGD7LNCqzmJHjPWX4H0o8=;
        b=F1neuwXtz2jRrEO3s517BZAonUG9yq+a+buAzWhClqrFM43jqzvc07jkCvWF5txvUi
         sfjwuWoIzE8Eh3kFlUXyoC4iNUL1aycY1lpLUUKk/gmhbRnfpMzA1ckl86/YANQQPxE+
         r+cBg8JayJKdSSSGOOL7O5GAgbJB07wqKLKA0AIV28CWFa/mDLsZghznGf27CxSLaapP
         UgvecC8skd71MO6Q6iQaxkGe3pvMEFaxMQSibQiuX3k2XqvNG1eoqDqkbjI4Cfw6SOQp
         FK4OvJmZlREKEbpUWJm/NFpskLZrRUPGLT+uQSlz2sOpYBDH8nhUVsAVTcAYrtqOuhJa
         E9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LkSzsuk6OkyHhMGQ1Io4HJGGD7LNCqzmJHjPWX4H0o8=;
        b=DBYDjXQkF52nkjLbFUhpiaJ7FholggTuT87JyAGzrvRaxYsunJXFc13JJyjhLhG8yr
         4DAUVHC7t73eawOZeHe9nubRizzgB/35p4jG+h3pNQUdQU1BFr4fO8MG68HH/0R4odGQ
         XpNURRP0Z0eyqCM/PrB46o7m1xSkjr2DMmU8UZ632dfFxDwQcLJK4f/ZvTJLhMACnvHj
         NtPs1O8SEdz2UM35ZfFHR/yn1k3NzZdSA6BnATR9ZfysOY4QGzRFfInbkZCcHQSHB33g
         cTKZQD/Ap3C8S+trW+hznjs5Y7745mgAB60gwpXmLq+NgPrTPbftPyL+VO7ohyj+JwT+
         oAEw==
X-Gm-Message-State: AOAM530l+hIOxOdI+9v2uVW8r39k4rqpRFAl+U+/SHW3dttiy+MEJEZx
        zhjJ7MN4oPkUVwmK4aUuLSy7eA==
X-Google-Smtp-Source: ABdhPJz9oD6yg4b32zNBbtgJAbD0h97AdahA/HWCNM/n6pjsO2hXvdH3WUU3ljzj3XmMUS4sQ/OGZA==
X-Received: by 2002:a5d:6a11:: with SMTP id m17mr35100628wru.361.1617110492938;
        Tue, 30 Mar 2021 06:21:32 -0700 (PDT)
Received: from dell ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id m9sm34291744wro.52.2021.03.30.06.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:21:32 -0700 (PDT)
Date:   Tue, 30 Mar 2021 14:21:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        drbd-dev@lists.linbit.com, Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH 00/11] Rid W=1 warnings from Block
Message-ID: <20210330132130.GK2916463@dell>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 12 Mar 2021, Lee Jones wrote:

> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> Lee Jones (11):
>   block: rsxx: core: Remove superfluous const qualifier
>   block: drbd: drbd_interval: Demote some kernel-doc abuses and fix
>     another header
>   block: mtip32xx: mtip32xx: Mark debugging variable 'start' as
>     __maybe_unused
>   block: drbd: drbd_state: Fix some function documentation issues
>   block: drbd: drbd_receiver: Demote non-conformant kernel-doc headers
>   block: drbd: drbd_main: Remove duplicate field initialisation
>   block: drbd: drbd_nl: Make conversion to 'enum drbd_ret_code' explicit
>   block: drbd: drbd_main: Fix a bunch of function documentation
>     discrepancies
>   block: drbd: drbd_receiver: Demote less than half complete kernel-doc
>     header
>   block: xen-blkfront: Demote kernel-doc abuses
>   block: drbd: drbd_nl: Demote half-complete kernel-doc headers

Would you like me to resubmit these?

>  drivers/block/drbd/drbd_interval.c |  8 +++++---
>  drivers/block/drbd/drbd_main.c     | 30 +++++++++++++++---------------
>  drivers/block/drbd/drbd_nl.c       | 17 ++++++++++-------
>  drivers/block/drbd/drbd_receiver.c | 26 ++++++++++++--------------
>  drivers/block/drbd/drbd_state.c    |  7 ++++---
>  drivers/block/mtip32xx/mtip32xx.c  |  2 +-
>  drivers/block/rsxx/core.c          |  2 +-
>  drivers/block/xen-blkfront.c       |  6 +++---
>  8 files changed, 51 insertions(+), 47 deletions(-)
> 
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: drbd-dev@lists.linbit.com
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Joshua Morris <josh.h.morris@us.ibm.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
> Cc: linux-block@vger.kernel.org
> Cc: Philip Kelleher <pjk1939@linux.ibm.com>
> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> Cc: "Roger Pau Monné" <roger.pau@citrix.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: xen-devel@lists.xenproject.org

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
