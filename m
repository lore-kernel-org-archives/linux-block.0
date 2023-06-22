Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB04BEB64D8
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 14:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjFVOcn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jun 2023 10:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjFVOck (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jun 2023 10:32:40 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545FF1BD1
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 07:32:39 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-460eb67244eso2653899e0c.1
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 07:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687444358; x=1690036358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jm+t5PY1z1cjmahFviY03bE+BB5wrL+Uyye59j02Ff4=;
        b=V3Ke4CwVaS6QxGzWWboyVjYD4suOn2ZJCbYjHj9tWBqFH24HUxhOeHuam3O3JbtUFt
         3EPzEQf148mdt3v3fhlJdyE3PEggOYsygUeqlQwxVrVbrC7LH47vNVzHfZ8EAZU7zPJG
         DBvDjJAyxL62XwZA8qHxtImtWjTJu9AvAiABvxVeN8+P/VbiMLDzdltO+hiWlRxygCmT
         ymGIWojaKdV9Fw4yuzXE6j+c9CR+jQr990ZKganmPO8nHz4b9Pksege0qvBJBGKliW51
         GnqgLmfPuTQsLArjrtEztdEEu+KHX3NgN55UifE5wRRgYXKmGOHW35u+snUAaG6BNpha
         xzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687444358; x=1690036358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jm+t5PY1z1cjmahFviY03bE+BB5wrL+Uyye59j02Ff4=;
        b=XiSyFn/Jmey8hDB+N+lOR2uuxHkLZOqC+/c8KRO1qusmOXNYknC/1hg3TvaTjQAYca
         A/N4gqXdzF76rOTU6Qpab83Mn+DIpT/hEx5kP4uxLaE38ZOZjjO38aR1jHpGD6GR6XLE
         iwwD7VtUq9/UmoJMWeCH05e6mR82b+KAd8bs4Up1BYHed2Cuz5CFqxCXq4UiG5TgN1jF
         U5bxJ6ej2sfbotnInf5nLNWou49w3XMFkhz8b7Wyf8K/oUFX8clUE04XHBGJ4od7DBA0
         MkSGNyIXntdLg0uqpyKF/lvhYFNBvXB1ACphS3blz86plW1EORz19LHfsx0O5LFKuCOy
         WVkQ==
X-Gm-Message-State: AC+VfDxNdeMhM3P0sbdHZRQ+Co14KD0IgA/hDTXr1hp2x8ab+nf8cKny
        lqxratLWktTPwW10S0J5ajYyndv4Kfeqbma3gLs=
X-Google-Smtp-Source: ACHHUZ47jCc+ImznUK+9lye6xPG5/ZsL6Z9UQwagb4pkDa4tOr14GYKx4mebgUA0hcPYIoAk+Kr8O25nHnaLIIED7Uk=
X-Received: by 2002:a1f:458e:0:b0:471:cd12:9c6a with SMTP id
 s136-20020a1f458e000000b00471cd129c6amr7168011vka.12.1687444358283; Thu, 22
 Jun 2023 07:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230620083857.611153-1-dlemoal@kernel.org>
In-Reply-To: <20230620083857.611153-1-dlemoal@kernel.org>
From:   Suwan Kim <suwan.kim027@gmail.com>
Date:   Thu, 22 Jun 2023 23:32:27 +0900
Message-ID: <CAFNWusY41eprBrH-95vp2uZFkxMpLh0iF7NZ8H6FznjQYSv31g@mail.gmail.com>
Subject: Re: [PATCH] block: virtio-blk: Fix handling of zone append command completion
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sam Li <faithilikerun@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 20, 2023 at 5:39=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> The introduction of completion batching with commit 07b679f70d73
> ("virtio-blk: support completion batching for the IRQ path") overlloked
> handling correctly the completion of zone append operations, which
> require an update of the request __sector field, as is done in
> virtblk_request_done(): the function virtblk_complete_batch() only
> executes virtblk_unmap_data() and virtblk_cleanup_cmd() without doing
> this update. This causes problems with zone append operations, e.g.
> zonefs complains about invalid zone append locations.
>

Hi Damien Le Moal,

Unfortunately, this commit was reverted due to io hang.
(afd384f0dbea2229fd11159efb86a5b41051c4a9)
You can see the mail thread at the block layer mailing list.

We don't have a solution about io hang yet..
So I have one question.
Is there any possibility of virtblk-driver io hang on zoned devices
without this patch?

Regards,
Suwan Kim
