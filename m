Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0701BC433EF
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 17:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFFFD61051
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 17:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244067AbhIFRhT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Sep 2021 13:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40495 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243819AbhIFRhS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Sep 2021 13:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630949773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+a05OosEmaf1AUa3FK5vtidgTLGJcrBZj/K8KbUsPU0=;
        b=EBguDvHEb0Sqe2q6T7mGAGxXHFtJby3VWc9FN/phZIhm3zx9xLNnZTUZxRmhzBGIYpVzDC
        x1UnH7BXSToZrm9acthMW0xog6COHAZbMfpEHjLgQElzekWeH1BqsxqsqTleFX4eNgqHMf
        Dy8bq5gS040RLgHq61scz7K1oPDjuVc=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-Lt3ae4ZPOeq8DMWE99djSg-1; Mon, 06 Sep 2021 13:36:12 -0400
X-MC-Unique: Lt3ae4ZPOeq8DMWE99djSg-1
Received: by mail-vs1-f70.google.com with SMTP id t1-20020a67d901000000b002c6681409f9so2145048vsj.2
        for <linux-block@vger.kernel.org>; Mon, 06 Sep 2021 10:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+a05OosEmaf1AUa3FK5vtidgTLGJcrBZj/K8KbUsPU0=;
        b=dr0g6sVbJC02pddymflimdohcocCPCPfL9zu053xxqp5s+bfVVuzuxqgYbfIqJhc+q
         /iZv2tEMy0pxrqt8mb7PuCF33RK56k5CKhGBEEjXz+pKISSe877vYEi5GpDxikasS08c
         SmnBvTMe1/mYToT3B+wayFGi5afcOr3nhbXJciQo/l+cCBmfDIjdnGMJjwBl8SNngldW
         V13e8R+IDiH6kyDhKCXVkX4gLm/XhM1e/wtdhZctSx8YVM4MPkcaVMTpMjphHunxzyZS
         i+sWx/pJn43oS0Ibd8NUYqGoyKTNtkSIZMxdo0zqYTbJZ6ERnmtJ2Mx+dG9tJIrbIE20
         zvYA==
X-Gm-Message-State: AOAM530Nw8swnFSZLkZhNHFY6PKrOTlzyoafPKCVBajonecQH/VyGcQI
        zOBSkihAqZYfUZX4RtAlaG/yZ22JLrjF58zZ4aDrxG5xI8bKFADOiF6c8iZhg651uuYyLIbXFx+
        RPen7kWdbTsxFaL9wQIHG1j4lJKTJ1B8N7exdZGQ=
X-Received: by 2002:a05:6102:21d9:: with SMTP id r25mr7030149vsg.57.1630949772006;
        Mon, 06 Sep 2021 10:36:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/AHyoVPtNR2gkeux1WVXi3KRa0vVWR6NQBmSyYp32AXvCeXirj6wdV1vgyMm8xZBnFb2qqEod38y4Al68YH4=
X-Received: by 2002:a05:6102:21d9:: with SMTP id r25mr7030141vsg.57.1630949771833;
 Mon, 06 Sep 2021 10:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210906163831.263809-1-jfaracco@redhat.com> <56e17907-83d7-7b45-8b0f-5d80d9005c70@kernel.dk>
In-Reply-To: <56e17907-83d7-7b45-8b0f-5d80d9005c70@kernel.dk>
From:   Julio Faracco <jfaracco@redhat.com>
Date:   Mon, 6 Sep 2021 14:36:00 -0300
Message-ID: <CAHtYXivVcodcR5b2aYnFvhgAJ7yEr0+jYzPZ+w-JxRRzuWJyfA@mail.gmail.com>
Subject: Re: [PATCH] block: include dd_queued{,_show} into proper BLK_DEBUG_FS guard
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Jens.

On Mon, Sep 6, 2021 at 1:44 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/6/21 10:38 AM, Julio Faracco wrote:
> > This commit fixes a compilation issue to an unused function if
> > BLK_DEBUG_FS setting is not enabled. This usually happens in tiny
> > kernels with several debug options disabled. For further details,
> > see the message below:
> >
> > ../block/mq-deadline.c:274:12: error: =E2=80=98dd_queued=E2=80=99 defin=
ed but not used [-Werror=3Dunused-function]
> >   274 | static u32 dd_queued(struct deadline_data *dd, enum dd_prio pri=
o)
> >       |            ^~~~~~~~~
> > cc1: all warnings being treated as errors
>
> This is like the 10th one of these... The patch has been queued up for
> about a week, if you check linux-next or the block tree. It's going
> upstream soon, in fact it was already sent in yesterday.

I noticed after seeing the same patch earlier this morning, but it was
too late to undo.
Discard my patch, pls.

>
> --
> Jens Axboe
>

--
Julio Faracco

