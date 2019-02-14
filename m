Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328BFC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 18:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021142089F
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 18:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kApAc8ju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfBNSAq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:00:46 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38103 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbfBNSAp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 13:00:45 -0500
Received: by mail-lf1-f67.google.com with SMTP id n15so5221207lfe.5
        for <linux-block@vger.kernel.org>; Thu, 14 Feb 2019 10:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cNdmBhJV6l2CrpOn23AdUvuvbdoQzPMeGeladPJyn9A=;
        b=kApAc8juLL1jfsml6kvJ912qHNEFbMQMO0HAg6aPT+R9mD7nmIVEz9780OYMNDENsy
         5KLMqJuFyeTsEIyCMUFclXbwU7ny5JbACEz1fgVxx2hHfBVKBTdRRLgqMPi14FyENs/b
         phPeh1WjjPTFjNPwtwKLdYKZ2aZAM/miG+sR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cNdmBhJV6l2CrpOn23AdUvuvbdoQzPMeGeladPJyn9A=;
        b=OuhJFewbwKUHeqwNbsRjDGOssuGnmHrdbYdJmvmM9f7LlfJm8yKLOyKQq+wzXXJlXn
         2ecCuK8jAzPeoI6t8MJT1S8Vue2PE+dZk7FEFveeHVmQjbmjLj8q+7axvHUV4T/NRJZ4
         FOk0siQJg5Wd5PtwiMqg5qmdBDAtvqMJDB09gSuB4yI0I4aIWUwaTeTlWp0qVErYPvgI
         dNqBK5GCZgRopCaq82a61JgzvZys6cPwXh8AFEWrZqlakW9iZTT7EmjDe19D/9Xot21h
         QOvgs7SzU8cyGSQ8Rl6gI6xyiSRBtj/rmZhrkLnAAYbl6Tl8QD4gb03hLXtUtX8ikXAP
         /cuw==
X-Gm-Message-State: AHQUAuZD7eKYpm2CA9B9KesddvuDo0qdrdzSIne+dcsYpYzOU+jLxsSa
        UfA3XGgfBM08xEmmrpWs40EfbW3S7Lg=
X-Google-Smtp-Source: AHgI3IaSPvZ/CAhZr+hI4RVJN4Hfim0MEZCUHWaLvEkmbgwJPjGsvcni1AFtAZAvrkkfuOhLhIGTLA==
X-Received: by 2002:a19:5504:: with SMTP id n4mr3186541lfe.43.1550167243715;
        Thu, 14 Feb 2019 10:00:43 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id g6sm610173lfh.35.2019.02.14.10.00.42
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 10:00:42 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id f24-v6so6073160ljk.0
        for <linux-block@vger.kernel.org>; Thu, 14 Feb 2019 10:00:42 -0800 (PST)
X-Received: by 2002:a2e:99c9:: with SMTP id l9mr2782851ljj.60.1550167242216;
 Thu, 14 Feb 2019 10:00:42 -0800 (PST)
MIME-Version: 1.0
References: <20190207205730.199332-1-evgreen@chromium.org> <20190207205730.199332-3-evgreen@chromium.org>
 <yq1d0nvqeix.fsf@oracle.com>
In-Reply-To: <yq1d0nvqeix.fsf@oracle.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 14 Feb 2019 10:00:05 -0800
X-Gmail-Original-Message-ID: <CAE=gft6bdM2dLc9RhGYMWp8bz6_c-W8Yy-CUTM9wXe+UiYkXEw@mail.gmail.com>
Message-ID: <CAE=gft6bdM2dLc9RhGYMWp8bz6_c-W8Yy-CUTM9wXe+UiYkXEw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] loop: Better discard support for block devices
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 13, 2019 at 6:40 PM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Evan,
>
> > If the backing device for a loop device is a block device, then mirror
> > the discard properties of the underlying block device into the loop
> > device. While in there, differentiate between REQ_OP_DISCARD and
> > REQ_OP_WRITE_ZEROES, which are different for block devices, but which
> > the loop device had just been lumping together.
>
> Bubbling up the queue limits from the backing device is fine. However,
> I'm not sure why you are requiring a filesystem to be on a
> discard-capable device for REQ_OP_DISCARD to have an effect? Punching a
> hole in a file is semantically the same as discarding.
>

Hi Martin,
Thanks so much for taking a look at this patch, I was getting nervous
it was languishing again. I got confused by this comment though. My
intention was to not change behavior for loop devices backed by a
regular file system file. The changes in loop_config_discard() should
result in QUEUE_FLAG_DISCARD being set for backings of regular files
that support f_op->fallocate(), same as before my patch. The change in
lo_discard() to call blk_queue_discard() on the loopback queue itself
was just shorthand to avoid duplicating all those if statements from
loop_config_discard again. Am I missing a spot where I've implicitly
changed the behavior for file-backed loop devices?
-Evan
