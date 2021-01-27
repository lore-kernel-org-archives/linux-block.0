Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2541C433DB
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 16:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85E4D20798
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 16:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343908AbhA0QOs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 11:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbhA0QNz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 11:13:55 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD522C06174A
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 08:13:11 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id n6so3087622edt.10
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 08:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yCJr5LaWhWMU0GEv1VBLBRwE+7yrkKij+9EAYt1Xy1Y=;
        b=bPf2zHTV4+wJn2TwThn/ciUqtN5J+OBKLsllaBgPD9jYr7oo+SFzuqeWtlZyojcvxx
         0Z3iEq8J+5enD78FQ4TqXtZen+55GTxa2Eg9espAPPmehigHIEbAnPLLan09hbTWaUYk
         zMs9FosvenRGKAXIdYMno2Fi8MfUjLuxPedQX0yXrdv/a4Mvi0acS81fB5jTtbPOv3Bg
         A9hdVjuOnlbd1ykNcWiZNKI2DivE2fxjHkE62bZJBMgcxsZITg6wz6zqfLT4AYyzH+pS
         o7OUrr4JZYb4U4h0DXZsWAZOtzStcCwsX6SCTrx3a//Mm0cJD7Npa1ZeOgJe27NVCpUL
         JEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCJr5LaWhWMU0GEv1VBLBRwE+7yrkKij+9EAYt1Xy1Y=;
        b=i2Ctn/mpDFL1OMpuLHcAka6nN0MqVNowQNHJZAStXimr23/nAmliOixfXED+xLFeTn
         ns/YgkaiukeRoGWDcEIltLfJPe0+HV7WWikYNqxr+5LF7OHqRIKMIuovr7JAn14OvqPH
         0pZj9x2YvB8paW4GPliHF6EqhCikHqA40aHDoZnDPMCg9vdm+JiXxPIJRM+NS+dN3g7q
         cVoaboog2mRz6h8yj032FPgPm1wy9CGuTMiEBpD0tRngzFmhpkmGECWq4HJzIt6TiX+F
         wfX73C2Qhs2Ce4FMDVoQUpafHiPl8cg7TpBxhrL5LyLe8GLLIQkIZ0gEjZ1lLFDGBu6b
         jgGA==
X-Gm-Message-State: AOAM531Gad2hR/thQ8Dn9Sjj8suRkeXOm08X1bFuamUhfCGIm7/LuLgg
        hk8h/lIaoWjGpRSwusOkX/xcR9hTDgb0YVL/r6g80w==
X-Google-Smtp-Source: ABdhPJxx5owWBx3b1CUl8+dsHwfcv0N4UFWJBm3EBtbpVbarbqqVzqrRDi4HH2oGoHcMmLrl2KO11jdURI5j8PiP/5c=
X-Received: by 2002:aa7:d803:: with SMTP id v3mr9489359edq.153.1611763990574;
 Wed, 27 Jan 2021 08:13:10 -0800 (PST)
MIME-Version: 1.0
References: <20210126144630.230714-1-pasha.tatashin@soleen.com>
 <20210126144630.230714-2-pasha.tatashin@soleen.com> <daf21294-f51e-3f03-8a46-d0181104d9e3@kernel.dk>
In-Reply-To: <daf21294-f51e-3f03-8a46-d0181104d9e3@kernel.dk>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 27 Jan 2021 11:12:34 -0500
Message-ID: <CA+CK2bBvKpWFtPz+OmjX5SJuAfL4hAaLbHmfRok4Ueo2toeTiA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] loop: scale loop device by introducing per device lock
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>, lukas.bulwahn@gmail.com,
        hch@lst.de, Petr Vorel <pvorel@suse.cz>, ming.lei@redhat.com,
        mzxreary@0pointer.de, mcgrof@kernel.org, zhengbin13@huawei.com,
        maco@android.com, Colin King <colin.king@canonical.com>,
        evgreen@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 26, 2021 at 3:09 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/26/21 7:46 AM, Pavel Tatashin wrote:
> > Currently, loop device has only one global lock: loop_ctl_mutex.
> >
> > This becomes hot in scenarios where many loop devices are used.
> >
> > Scale it by introducing per-device lock: lo_mutex that protects
> > modifications of all fields in struct loop_device.
> >
> > Keep loop_ctl_mutex to protect global data: loop_index_idr, loop_lookup,
> > loop_add.
> >
> > The new lock ordering requirement is that loop_ctl_mutex must be taken
> > before lo_mutex.
>
> Applied, thanks.

Great, thank you!

Pasha

>
> --
> Jens Axboe
>
