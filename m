Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73629C49361
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 09:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E522613F5
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 09:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhFQKBM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbhFQKBG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 06:01:06 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F22C0617A6
        for <linux-block@vger.kernel.org>; Thu, 17 Jun 2021 02:58:57 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id l194so247225vkl.4
        for <linux-block@vger.kernel.org>; Thu, 17 Jun 2021 02:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYaWFAmTtxmIx4SKywhtr8a4SqDaDzqjBCGGtLGU/+0=;
        b=fUo7M6mqD7YawUEwJgqJhK4QCX7qicV+JHxE6Mz0lXGSaBU31SAJMVRa7XGotjPjMU
         +8Al2APuUOPSIOVVFcgiDqUsyr2SvVrnMW+CMK1u7Bi7V4baL9c9qktdkFy084SnMhO6
         yGF3Kx3cToUXzpZCKmQI3i9OHv9jyd07uvM0p7ZjzX/Bkb45W8tTFFBRTdxiTWIwKaHJ
         lYZ0H80ZT1ddFwbXLLqpJWs6jLi6ZTphvA/h+WBQtBhTAH7+vJaWd5P7hk1gGRlayBzm
         CpzV8VeO8RBkgBXCxGugW2iOzuyhq1EZmMdxq+VsL0cG1ZfevF6UDS0/E3vJZAbl29x/
         EegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYaWFAmTtxmIx4SKywhtr8a4SqDaDzqjBCGGtLGU/+0=;
        b=cYYPufkDw63ZkdHAEledSIuGzyJShOuRkCCjoX1RuShyszlo8xYt5lZZtVC7Ing0VM
         jXn2KT4SQ10lfmmqK7XOPP9TquJgtq26QZ2qnGsKCpBqa99VFuP83CuEv8tPhcuN448o
         f7jVTQI/0RRXqeqm6/POaE7H1jivppviecisaeNnQdghekRFVTW4l8AYOhc7JNq57cRI
         uuP0MxbYCoUNPOHRJdgX/cWIx4fvrwySlIgPkNRh2cbK85Z8+MoUXP2Sa7/lf8pu+5+e
         aVTq1KTBh1oJiOEkDqHlWBPC/1dOQ5AOCG2m98ueMkvO/e/d5sbD/ygO8hWzIaRfQZlp
         EBIQ==
X-Gm-Message-State: AOAM533HGinPmnuYemyqW27Id6sQO6q8S0rLeW9//OVsNfSuXUYx5tz1
        lh1Lu1MnBlR/JLQTrXQ7XY14jGJnPWz1Hherj9QC9g==
X-Google-Smtp-Source: ABdhPJyIZga3abYOI3nzgl4Yaha/nsc+4zOdXfgH0s0eyQC6r6mAcL/fEYaekMcxaUc/gITsdWnBqo6q89C6TK3jJ2c=
X-Received: by 2002:a1f:9542:: with SMTP id x63mr3031503vkd.15.1623923936658;
 Thu, 17 Jun 2021 02:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210616053934.880951-1-hch@lst.de>
In-Reply-To: <20210616053934.880951-1-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Jun 2021 11:58:20 +0200
Message-ID: <CAPDyKFpAeUfMuXxbYE62Hjdjs==9zDZthvTDjBnrDd6v9iPGQQ@mail.gmail.com>
Subject: Re: convert the mmc driver to use blk_mq_alloc_disk
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

+ Jens

On Wed, 16 Jun 2021 at 07:39, Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Ulf,
>
> can you take a look at this series which converts the mmc driver to the
> new blk_mq_alloc_disk interface.  It is based upon Jens' for-5.14/block
> or for-next trees.

I don't see any issues with queuing this via Jens' tree, as I have
only a few minor changes queued in my mmc tree that touch the
corresponding files. None of which should cause a merge conflict, I
think.

>
> Diffstat:
>  block.c |   28 ++++------------------------
>  queue.c |   23 ++++++++++-------------
>  queue.h |    2 +-
>  3 files changed, 15 insertions(+), 38 deletions(-)

Kind regards
Uffe
