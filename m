Return-Path: <SRS0=FzxQ=5P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD26C2D0E9
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 08:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5244E206E6
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 08:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ck8aHNOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbgC3IGy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:06:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42360 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbgC3IGy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Mar 2020 04:06:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id q19so16976822ljp.9
        for <linux-block@vger.kernel.org>; Mon, 30 Mar 2020 01:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cpbDZfow9EQI0zYacEZrYwnx2hWkfZaFUAfP7urhVtE=;
        b=ck8aHNOKemLr0eK1wFhecWUyMMN3tcx9swMXPJ0V3neZKS4sIYl/mPMbO4EODJkGnI
         rjR/jc8+jKG8EUpLsubvgbYDv6aAA8KpmBh/zqfz6pFqkvmopCMlIGpkzKQBXgEHFXW2
         LsBH0HQXBz+j94liTozEh/azRyZXW2fvNiv0zPxiYiKC/cCq/07MSlE2Q0EMLrbA98zp
         zCDrN5bxxpwzsCohTlzHQcf6qdYe89dQyq/der2we94ucljjrYD9VaFWG3oZIu97obSz
         g1xdv30ICv95KGl6jkShHsbkaHIK7wEumGrEIL/BNPnhDQrH+w9ndWQ67OOu5hGevJHc
         COGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cpbDZfow9EQI0zYacEZrYwnx2hWkfZaFUAfP7urhVtE=;
        b=Be+iYOZIM2f5xhYRnRGMQ+tECOpUccFjlVYB1OOnoB2mex1nxxVBgSnsVP2frGFkW/
         sCt36JjUutwwpjmzsPrKn2RxLYzTOguNEjrNXAc1GZ7bSMtTW5MBU6XahWwAh/Utu3OC
         IRn8a/0MOqVmxwcVmyPcDujCGKlouRm+hVjoKN16ZUy+CxsHuRh8tRgCYoYjZEg9xh65
         oLIP8LMPVkk3GBT06CO/DNi9H7DmuNxUqrScO4UjpYWvsy6ErcqVExwT7oUKzy98TKn7
         GDjbcmesqQLxS9EjPDJFjSGgFj3CoW0C5nbwrXFDF4tQ35HxZpv/c3tiRQEA3xXaltBA
         +xeA==
X-Gm-Message-State: AGi0PuZLwe4TbqzsZ93Ka8pGJ20tKZzZzlWWq/iSeswf/7gO4dTjNi8X
        iXsGVFeIn9c3316V13TVtT8kMmYUF3BfB92Y11w85g==
X-Google-Smtp-Source: APiQypKAiv1jPaqjKxNV+zU6ogBE5juUHor9Z0AyiIZ7ER2rx7XTj8laM7vv3RqFYFq7GdyafC6WX2Yc4yOmE6ij+uk=
X-Received: by 2002:a2e:81c9:: with SMTP id s9mr6403337ljg.69.1585555611959;
 Mon, 30 Mar 2020 01:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200329140459.18155-1-maco@android.com> <20200330010024.GA23640@ming.t460p>
In-Reply-To: <20200330010024.GA23640@ming.t460p>
From:   Martijn Coenen <maco@android.com>
Date:   Mon, 30 Mar 2020 10:06:41 +0200
Message-ID: <CAB0TPYG4N-2Gg95VwQuQBQ8rvjC=4NQJP4syJWS3Q6CO28HzTQ@mail.gmail.com>
Subject: Re: [PATCH] loop: Add LOOP_SET_FD_WITH_OFFSET ioctl.
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On Mon, Mar 30, 2020 at 3:00 AM Ming Lei <ming.lei@redhat.com> wrote:
> The new ioctl LOOP_SET_FD_WITH_OFFSET looks not generic enough, could
> you consider to add one ioctl LOOP_SET_FD_AND_STATUS to cover both
> SET_FD and SET_STATUS so that using two ioctl() to setup loop can become
> deprecated finally?

I originally started out doing that. However, it is a significantly
larger refactoring of the loop driver, and it makes things like error
handling more complex. I thought configuring loop with an offset is
the most common case. But if there's a preference to do an ioctl that
takes the full status, I can work on that.

Best,
Martijn

>
>
> Thanks,
> Ming
>
