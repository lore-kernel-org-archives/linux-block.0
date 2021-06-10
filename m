Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49941C48BE0
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 00:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB06613F1
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 00:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhFJArw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 20:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229639AbhFJArw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Jun 2021 20:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623285956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2st2i4D0Ta4QNo0mDm2dIev0r9x+DU0qtkCNCQsXxYY=;
        b=C2X8B4Nv1vRFvQhbZvVEQAJ8tP4LrOHAgIlCupmnhhykKpoe0bDyKW8ZWSCBtaP/eedLPU
        gEtNlQ4TQ3jm1iwY2f769P11zl0lE2GbXNVyey2MIbSs9JCN9wslQMIHmdI5OQ2PvAJ6rr
        /MyS8wH6MFRdFO8au1i6pOyYf4JctrU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-rWgDW6stPOCdo3mP2DAOeA-1; Wed, 09 Jun 2021 20:45:55 -0400
X-MC-Unique: rWgDW6stPOCdo3mP2DAOeA-1
Received: by mail-yb1-f198.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so33748991ybo.11
        for <linux-block@vger.kernel.org>; Wed, 09 Jun 2021 17:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2st2i4D0Ta4QNo0mDm2dIev0r9x+DU0qtkCNCQsXxYY=;
        b=mNuIXmEeMDXe3yDABVlWH1AxpPeIIWD2xIcF/L+BmRbJHiVkkIcEDhnpRTNUfjVXvT
         ixz/9XrZM7wq8EfatxWXumJQJTZ3B4rhmL8JDNgDjWPrn00/ci9H7gpVDk28IgQxOBN/
         LbH+WC/TKadHbMqRIzdsKILSN+e7Cdbjpb70Oap66NbNSNcMVm4XmmMuVgQwKhtrZ7Vy
         60fJss6MZzZsuTwfU1LY17v65QrDvu8lycLHBlTWYYG3QC46AszLLtxsOtvL0UNpTYfl
         Y2ZBgf7SJHRMgztk3ywPF3RaNn7vT2y6yYHgMxAZoGq6KSjoVnWd1rNG+9V8e8JLlinN
         UHqg==
X-Gm-Message-State: AOAM53360bHBLzrKi5WAyXXiZnmDzkJOrC8kNgcOtgr4yv337CZ7YS6u
        kCeHnLYEu0lfFWlm3u96RLZtQh6HaZek38oY3zBMxYltDONbhVz5r/9YR+ZbsLOx2WUMBSZlPHK
        XgLn7zVpnnFhkGBbISaDfT7KOhRO93vNlfU89vJ0=
X-Received: by 2002:a5b:ec4:: with SMTP id a4mr3681282ybs.209.1623285954950;
        Wed, 09 Jun 2021 17:45:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFx6UCqYoch4/m72PJo4nE7e4O8dPzhhxvV6Oe7BA3wN3CTvInRWaLAhmi/XctroYv9kfGWDZO1rwDSW7NJ30=
X-Received: by 2002:a5b:ec4:: with SMTP id a4mr3681269ybs.209.1623285954796;
 Wed, 09 Jun 2021 17:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210609015822.103433-1-ming.lei@redhat.com>
In-Reply-To: <20210609015822.103433-1-ming.lei@redhat.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 10 Jun 2021 08:45:43 +0800
Message-ID: <CAHj4cs-dmHwkbWrn7aH18GvxE3t+eqK9HMLMbmuSALyGOP_WnQ@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] block: fix race between adding wbt and normal IO
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for the fix.

Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Wed, Jun 9, 2021 at 9:58 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> Hello,
>
> Yi reported several kernel panics on:
>
> [16687.001777] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> ...
> [16687.163549] pc : __rq_qos_track+0x38/0x60
>
> or
>
> [  997.690455] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
> ...
> [  997.850347] pc : __rq_qos_done+0x2c/0x50
>
> Turns out it is caused by race between adding wbt and normal IO.
>
> Fix the issue by freezing request queue when adding/deleting rq qos.
>
> V3:
>         - use ->queue_lock for protecting concurrent adding/deleting rqos on
>           same queue
>
> V2:
>         - switch to the approach of freezing queue, which is more generic
>           than V1.
>
>
>
> Ming Lei (2):
>   block: fix race between adding/removing rq qos and normal IO
>   block: mark queue init done at the end of blk_register_queue
>
>  block/blk-rq-qos.h | 24 ++++++++++++++++++++++++
>  block/blk-sysfs.c  | 29 +++++++++++++++--------------
>  2 files changed, 39 insertions(+), 14 deletions(-)
>
> Cc: Yi Zhang <yi.zhang@redhat.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> --
> 2.31.1
>


-- 
Best Regards,
  Yi Zhang

