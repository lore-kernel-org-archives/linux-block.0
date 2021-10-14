Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FABC433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 09:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA4E6101D
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 09:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbhJNJZn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 05:25:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229468AbhJNJZn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 05:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634203418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zpnHbQU/P3dvZjk8T87puDae5n+9jnJ7vmvPjzHElVE=;
        b=Jaz9LrFIUOjSJ5wwpKvUaxd7mRO9iW3Y6ZYv7bBYqRDPgSDJZqyHDrbQebkhMWx7ahjeh2
        PcK5Qf25FftLNCrhO3vbcXFHls2u9vjyHLisCOopTNQbpbpdi/ff6rNjP0yRYqBtb1KF4H
        G1MVrTjg0jpIFjN91VtPsc8uskmznhE=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-CAVijNKIOBS_6ysi-cN9iA-1; Thu, 14 Oct 2021 05:23:36 -0400
X-MC-Unique: CAVijNKIOBS_6ysi-cN9iA-1
Received: by mail-yb1-f198.google.com with SMTP id z130-20020a256588000000b005b6b4594129so6330917ybb.15
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 02:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zpnHbQU/P3dvZjk8T87puDae5n+9jnJ7vmvPjzHElVE=;
        b=J28EV4L5h2gTrewOAt6M8xJASmyByrWSQfPf3F50o+SBkjjjj69wSWAZgk9DcDYC8B
         gBz5PGNN+AM4vcgFdtgcbiyMk2p8CNWSO2I4LeHwpyOCZEXdyMRq10eC9XVotABNcxvw
         x1lsAzU8cgUf1jsaXYDgZ5CrIvh/NihfcZyTBPzjbFzVWzCHEq5HtEhl402b4A+GLj1D
         EWbNPmRyAZx1KWU7adfdyJRzU82F39EUYS5OR5MXJFw8wPgXgoapE61OYnUshMoXsnxs
         thcXl/dIa/gebvvtLjFT/K4B10BL+NPIYFj2jZRth3/RoCBHJs7AotAOYD68OigMub3z
         ArPQ==
X-Gm-Message-State: AOAM530ihVH+DWjROraM/Uq1I2iUxP0CMXpLqQzYiZJZ2Uvm0wPSGMV5
        bLpqHSFEkJQJIVM37V7hocwjSuUwEEE/3Z+kUpu21+QA18NODqR3ZDrV1kyOCOAfDVm0k8ImSX2
        c4C+gxaN7XKQgkCcnrCFy4pllW1uv/IALQjFx5zs=
X-Received: by 2002:a25:3104:: with SMTP id x4mr5066300ybx.512.1634203416178;
        Thu, 14 Oct 2021 02:23:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwhlLQYkeARYzsLFNQ4Hlk7VXH35Eo9ANXpgP2MPz3S6LiBmE+ahMkjoO2xkAdlfR7eUOv1BlFaXbx2s4ARtQ=
X-Received: by 2002:a25:3104:: with SMTP id x4mr5066281ybx.512.1634203415959;
 Thu, 14 Oct 2021 02:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210929071241.934472-1-hch@lst.de>
In-Reply-To: <20210929071241.934472-1-hch@lst.de>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 14 Oct 2021 17:23:25 +0800
Message-ID: <CAHj4cs8tYY-ShH=QdrVirwXqX4Uze6ewZAGew_oRKLL_CCLNJg@mail.gmail.com>
Subject: Re: tear down file system I/O in del_gendisk v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patchset fixed the NULL pointer issue triggered by blktests block/025
https://lore.kernel.org/linux-block/YWfJ06KX3HT1nANX@infradead.org/T/#mbf26cd34c88660ce0221dd7933b294a0b0298319

Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Wed, Sep 29, 2021 at 3:14 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Ming reported that for SCSI we have a lifetime problem now that
> the BDI moved from the request_queue to the disk as del_gendisk
> doesn't finish all outstanding file system I/O.  It turns out
> this actually is an older problem, although the case where it could
> be hit before was very unusual (unbinding of a SCSI upper driver
> while the scsi_device stays around).  This series fixes this by
> draining all I/O in del_gendisk.
>
> Changes since v2:
>  - move the call to submit_bio_checks into freeze protection
>
> Changes since v1:
>  - fix a commit log typo
>  - keep the existing nowait vs queue dying semantics in bio_queue_enter
>  - actually keep q_usage_counter in atomic mode after del_gendisk
>


-- 
Best Regards,
  Yi Zhang

