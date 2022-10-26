Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B89C38A2D
	for <linux-block@archiver.kernel.org>; Wed, 26 Oct 2022 11:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiJZLn2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 07:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiJZLnE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 07:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC7159247
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 04:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666784411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7irqz/NvTW4iXVUnlld6jTYNf6TWqWwg41go+5KxLrs=;
        b=d2R7UXmYhaINnwRThl8PYaasEJvsDRZpDAZF+RDInN9Pqp6KbcvOgOsQt4htFWRlJkJ7Z4
        T8aijQ2lIVLihbTr9U1gYYkDUQcXcM/qW1qP8pZZvuMkyjDnRb5K5OLlXR4NC5ITEIH3Kd
        pQMAoFT68v6QqEByhGTMWnq2eVtPh6M=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-333-7Wn_k-bGMj-YkfM3mXI7yg-1; Wed, 26 Oct 2022 07:40:09 -0400
X-MC-Unique: 7Wn_k-bGMj-YkfM3mXI7yg-1
Received: by mail-vs1-f70.google.com with SMTP id 63-20020a671542000000b003a65bca366fso4198643vsv.8
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 04:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7irqz/NvTW4iXVUnlld6jTYNf6TWqWwg41go+5KxLrs=;
        b=CYVujy0Px5uA9kDi7eYzVvO0JqkIzLGBWdlkQOeSgjwBDRCz6tEbT/Y90GfxIfgib9
         PWVDSR75xkgz/x484/i9AFeuP+C/RjYpGI5lu4qlueQ5S2DPoKeVgHv5DLJgGbRgAuKi
         8mHKdW+hMvPn79VfyXe5cErhOXmMGm9SogAojkguGOa5ZxRZXdVrsfZVFS3aqPtwivzy
         5HuvVR/n89a0LrekY06aZlu8JKLhTcVPcYvzJUU5OMpejVDqoFmXUd55l3olvG8zeAG9
         vUpXdm5rCMZze5ULdsUamK1qiPuGQJvNtSqFsG52oCh5Cj+3NCJXcWmz/g4UM/eKrGZt
         z7iw==
X-Gm-Message-State: ACrzQf2IjVAtE5q7AkC0cnV1etL7ulydcocV0UU9neiqvanlSJpPaLXr
        EuB+WEJUOU3XtcHnyPWl0NVtfLiicFiZZtrP2b1Nbs8XPqcldFicBF8OBB7fwk9BuShRg3+Fhdf
        mdrckhbdPbrX09u2s9Y5og9nAD9eIWvWPX4+Tze8=
X-Received: by 2002:ab0:1c52:0:b0:401:762b:f888 with SMTP id o18-20020ab01c52000000b00401762bf888mr12114988uaj.57.1666784409111;
        Wed, 26 Oct 2022 04:40:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Xx/yW9MkoNGJhtGZNvU1HCnJVqOGUKZ9+Ilp9RoMt0HBvwtRIHlnIf5EfLuzSY/J85/XAX7roXuGnIGICkbE=
X-Received: by 2002:ab0:1c52:0:b0:401:762b:f888 with SMTP id
 o18-20020ab01c52000000b00401762bf888mr12114979uaj.57.1666784408893; Wed, 26
 Oct 2022 04:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <1666780513-121650-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1666780513-121650-1-git-send-email-john.garry@huawei.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Wed, 26 Oct 2022 19:39:58 +0800
Message-ID: <CAFj5m9+o4Q9o-qYgwn-XLJxOn6h0JjGOscwCOHEZkxzOBCdDGA@mail.gmail.com>
Subject: Re: [PATCH v2] blk-mq: Properly init requests from blk_mq_alloc_request_hctx()
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, bvanassche@acm.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 26, 2022 at 6:04 PM John Garry <john.garry@huawei.com> wrote:
>
> Function blk_mq_alloc_request_hctx() is missing zeroing/init of rq->bio,
> biotail, __sector, and __data_len members, which blk_mq_alloc_request()
> has, so duplicate what we do in blk_mq_alloc_request().
>
> Fixes: 1f5bd336b9150 ("blk-mq: add blk_mq_alloc_request_hctx")
> Signed-off-by: John Garry <john.garry@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

