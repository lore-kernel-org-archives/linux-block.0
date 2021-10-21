Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19459C433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 14:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F228361221
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 14:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhJUOh1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229878AbhJUOh0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 10:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634826908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VugW9XKQqql+D4jW/MwnSaiqD5NSjAuo7rb/rILE+vA=;
        b=cFz+b8GpgUJ8L3LhXQRA9WnqE7Jvqg5jM7sz9r+C+ytGV1Hvfopeao2XOL5gKQSxTUf+cD
        wrKu497PVobeWv8kdTC1WxJmhVDo7YUuvJEWmIOmvAewluXlNutdJPZ4KWbrg06ThUh19t
        wcaSjhs9Ko2Iaim7r1/xDgHbDMAnpNo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-5CKAGYiSOvCOEPs8w-cKAQ-1; Thu, 21 Oct 2021 10:35:06 -0400
X-MC-Unique: 5CKAGYiSOvCOEPs8w-cKAQ-1
Received: by mail-ed1-f70.google.com with SMTP id i7-20020a50d747000000b003db0225d219so617043edj.0
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 07:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VugW9XKQqql+D4jW/MwnSaiqD5NSjAuo7rb/rILE+vA=;
        b=D8xy/F59zH4jR2Y/jWJuBWN+0rbrHsA43oLZRwXpD4lmj1ofnb0mceP8IgQdm8WY4A
         Gi9iXQ9UtILpfQ7giILU/dQc/jhGfW45EZpdttwA2duLLlke+hKjjfCtTdhKd2NFWaSP
         yIqzuyX+J/pL2Rq88yypI8FG0Z+KQM4eVyeTxvuySxGepehLYxiPvWXrFWgzRh31SInk
         tELLF0sIa23GHpXxzzBBui4EzT0dQHl2RKlHDlq6N+f8jjAEJUduo4zzYco0M/ef/wQ1
         qzOUb8m0anKnxaSp/4P0j/mlW5H/UHF3AjSx+P/P09KmdxIe1jNgj44vyBU+TsoJ8wEc
         wttA==
X-Gm-Message-State: AOAM531y1J0DMXhbisMaqdJmnE4jhO23q5T6OpSFs6Ww8da7/oUhN0Fg
        ExfA1sKsmO9mHkyv9Iuux1YgOLaOqXwa8THrWMEyejn8LDsoqnDKhJTpECgSAu9HHQ2tpLHQEQB
        qspXd4lpI6mPg1wmKHZY/3io=
X-Received: by 2002:a17:907:961e:: with SMTP id gb30mr7883136ejc.484.1634826905604;
        Thu, 21 Oct 2021 07:35:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSRO0xBoE29HcFaVDTP+mg9VveZQjRkYIv8YWZhFjn3jIIO8pGIPgUQcl4cBQPn6cnJIg4Xw==
X-Received: by 2002:a17:907:961e:: with SMTP id gb30mr7883111ejc.484.1634826905435;
        Thu, 21 Oct 2021 07:35:05 -0700 (PDT)
Received: from steredhat (host-79-30-88-77.retail.telecomitalia.it. [79.30.88.77])
        by smtp.gmail.com with ESMTPSA id u18sm2900999eds.86.2021.10.21.07.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:35:05 -0700 (PDT)
Date:   Thu, 21 Oct 2021 16:35:03 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     cgel.zte@gmail.com
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] virtio-blk: fixup coccinelle warnings
Message-ID: <20211021143503.xp7u6qmypvhbl5th@steredhat>
References: <20211021065111.1047824-1-ye.guojin@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211021065111.1047824-1-ye.guojin@zte.com.cn>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 21, 2021 at 06:51:11AM +0000, cgel.zte@gmail.com wrote:
>From: Ye Guojin <ye.guojin@zte.com.cn>
>
>coccicheck complains about the use of snprintf() in sysfs show
>functions:
>WARNING  use scnprintf or sprintf
>
>Use sysfs_emit instead of scnprintf or sprintf makes more sense.
>
>Reported-by: Zeal Robot <zealci@zte.com.cn>
>Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
>---
> drivers/block/virtio_blk.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

