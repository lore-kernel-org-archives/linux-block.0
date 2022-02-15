Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9CCC433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 08:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiBOIsK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 03:48:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiBOIsJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 03:48:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E700EBDF4
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 00:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644914879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+0eleqiUVBeAPaQGD2Q6ihFW/Z9JIAN0Kj0GeNRsLaA=;
        b=ayphHF/zz/QRT1LtgSyf1ZNurdY3ZWjlPMleazOL4obzkYrLOaUkjPHx48MLeXSGDjEml3
        FgDcGj7sk8oOyMZq9cCqhrWx8PKM5uzJ5/FEKp9yGBqW98g1a81XVSY6c/juNsND1Haz75
        Sh5yTD9yDaBontOCOez+FBIoh5O7Jzk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-E6E4wcqkPvulRFW3FingBg-1; Tue, 15 Feb 2022 03:47:55 -0500
X-MC-Unique: E6E4wcqkPvulRFW3FingBg-1
Received: by mail-pl1-f200.google.com with SMTP id x2-20020a170902a38200b0014f252d67e2so1859966pla.13
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 00:47:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0eleqiUVBeAPaQGD2Q6ihFW/Z9JIAN0Kj0GeNRsLaA=;
        b=fU2S+tOAJmAHFPI1Vtkb1VCRA23mxoOcvXU8+CpfOsSM0faZS7gOmAacvwFLl/gSN4
         6DwxPR8oXD9y8eHYnTk9CY3uDtuE0lDRq29d8CmxmcgZgnCYHQTBSwFGMS/WEqeG/GvE
         NdSqym/abLaX+owuG9CMA7C603dDx9jJwgV32l3wRvun0f2XHX9AYELlIigxzS7Frn2/
         aqtY4J4u/6RXXrd4AqJSloAYzcL+BUBTWminm+5eUxn8G/CPEvbfd8E8WlsJXkD2bE9m
         W60ZosipooCLHsAocKBVgtj4X2/4plgrHDG6OHW3sS4Oh05fo8VMJPukoEdHFFl3GoNr
         w9tw==
X-Gm-Message-State: AOAM532dbuGKr40IsfM4iBrRqsoumr3G+umdwy+ergZNqHOum6LOfP8v
        ZG6bBOU7Q9lp/y47pw78IcGE9hkfhSIqPWky4nWfSURPU1VlekQFdzrZIqyvka7kJm0aG+weZ00
        yIlsJi4F5GM3SXhkm0MhcB10w/lmIUVi0gZq/uEo=
X-Received: by 2002:a05:6a00:9a9:: with SMTP id u41mr3233689pfg.83.1644914874661;
        Tue, 15 Feb 2022 00:47:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1RXfHqGKUOwHiOd9TXDCmkRfLOApnv8+NP4UBdUIs2zHseVmQ3Z770IwhZgE/Zg1NSmgYeteqUdN9fAOzix8=
X-Received: by 2002:a05:6a00:9a9:: with SMTP id u41mr3233676pfg.83.1644914874405;
 Tue, 15 Feb 2022 00:47:54 -0800 (PST)
MIME-Version: 1.0
References: <1644890154-64915-1-git-send-email-wangqing@vivo.com> <1644890154-64915-6-git-send-email-wangqing@vivo.com>
In-Reply-To: <1644890154-64915-6-git-send-email-wangqing@vivo.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 15 Feb 2022 09:47:43 +0100
Message-ID: <CAO-hwJJK5yeW+K_vLpWV9t3TsEdk0xCO-ETxeJsXM2c117JzNw@mail.gmail.com>
Subject: Re: [PATCH V3 5/13] hid: use time_is_after_jiffies() instead of open
 coding it
To:     Qing Wang <wangqing@vivo.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 15, 2022 at 2:56 AM Qing Wang <wangqing@vivo.com> wrote:
>
> From: Wang Qing <wangqing@vivo.com>
>
> Use the helper function time_is_{before,after}_jiffies() to improve
> code readability.
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

FWIW, this one is
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Wang, is there any plan to take this series through the trivial tree
or should each maintainer take the matching patches?

Cheers,
Benjamin

> ---
>  drivers/hid/intel-ish-hid/ipc/ipc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
> index 8ccb246..15e1423
> --- a/drivers/hid/intel-ish-hid/ipc/ipc.c
> +++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
> @@ -578,7 +578,7 @@ static void _ish_sync_fw_clock(struct ishtp_device *dev)
>         static unsigned long    prev_sync;
>         uint64_t        usec;
>
> -       if (prev_sync && jiffies - prev_sync < 20 * HZ)
> +       if (prev_sync && time_is_after_jiffies(prev_sync + 20 * HZ))
>                 return;
>
>         prev_sync = jiffies;
> --
> 2.7.4
>

