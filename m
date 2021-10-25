Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C003C433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 17:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B4C60F22
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 17:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbhJYRK5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 13:10:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234474AbhJYREV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 13:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635181318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iOqztots9uZKwSQu0h1UICZOLJs0OYqyRoPLyAIfYPU=;
        b=izJH1/Crw7gaQzY/QMkEVxJ4FF1bq60WeKHisO2RxvSgNR7rzHkDvT6TGYtxMfBw0NNesU
        TQCua6Lqiex7uzV93DAPvxUXpWYyxmFLbT5coDZ9Ia44lpkK7U5ylqbFW3CG+p66x1aL1N
        S+OLTRsQs1AWUtm98PmOu1vmlQI1rpU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-tE1gyOJxMoSNQIkBfAqHXA-1; Mon, 25 Oct 2021 13:01:56 -0400
X-MC-Unique: tE1gyOJxMoSNQIkBfAqHXA-1
Received: by mail-wm1-f71.google.com with SMTP id b79-20020a1c1b52000000b0032328337393so201425wmb.1
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 10:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iOqztots9uZKwSQu0h1UICZOLJs0OYqyRoPLyAIfYPU=;
        b=KlNnB0JHX9S4eDzJtJ/pIJnfpr+604pScehKLYlDDlbDyQVKaCfg/IPEwrjaVNa3g+
         Yx5dA8+Nq5PXudLEz8M9RijCM8WfO/x/ynvytIHo/Eds9hJ9Po2zd8PN/EBH2NFdjEcf
         Q/4bEUMNyS/6maCK0J++HM/MIAYbQr0TM1yzJlQ/Czsc5w1ERUnxEGNXsHptnMNmhfc3
         11y8rxlQANi+1dHBGnpRi1lWVGbp8/EUA1UHhEonExsPZDDY39ySUwaZEK6Z7sO9zA18
         4EaFNPLx5aocS3ebXfnP+U65joHrk2nZ5jE/NVcEcH96Or0dX8its3fHbiB8MTDoAL3u
         +ULg==
X-Gm-Message-State: AOAM533Ry5WOmDay8+PL2ZBGJLidcUcGzt1yY8RdFxsBfm25xnkwHaAx
        Hr1cFF8RER5zsnzjTrQbxj9rd56VkGQzPofNZI/iuxTXakpfFt+mFBUMmdu36q2X53czNUksrJy
        5O+sr4tuMS+5Ob4NWA626ZXI=
X-Received: by 2002:a05:600c:3511:: with SMTP id h17mr49729782wmq.144.1635181314594;
        Mon, 25 Oct 2021 10:01:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykMYYstKXiUf9n35P0ddmilxiuNYzTQRX70Dq1rRxHPfALd75DbAun/bZEPwwCibGSmSEIjA==
X-Received: by 2002:a05:600c:3511:: with SMTP id h17mr49729761wmq.144.1635181314388;
        Mon, 25 Oct 2021 10:01:54 -0700 (PDT)
Received: from redhat.com ([2.55.12.86])
        by smtp.gmail.com with ESMTPSA id u6sm11411331wmc.29.2021.10.25.10.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 10:01:53 -0700 (PDT)
Date:   Mon, 25 Oct 2021 13:01:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     axboe@kernel.dk, hch@lst.de, josef@toxicpanda.com,
        jasowang@redhat.com, stefanha@redhat.com, kwolf@redhat.com,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 0/4] Add blk_validate_block_size() helper for drivers
 to validate block size
Message-ID: <20211025130130-mutt-send-email-mst@kernel.org>
References: <20211025142506.167-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025142506.167-1-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 25, 2021 at 10:25:02PM +0800, Xie Yongji wrote:
> The block layer can't support the block size larger than
> page size yet, so driver needs to validate the block size
> before setting it. Now this validation is done in device drivers
> with some duplicated codes. This series tries to add a block
> layer helper for it and makes loop driver, nbd driver and
> virtio-blk driver use it.
> 
> V1 to V2:
> - Return and print error if validation fails in virtio-blk driver

Please document how all this was tested.

> Xie Yongji (4):
>   block: Add a helper to validate the block size
>   nbd: Use blk_validate_block_size() to validate block size
>   loop: Use blk_validate_block_size() to validate block size
>   virtio-blk: Use blk_validate_block_size() to validate block size
> 
>  drivers/block/loop.c       | 17 ++---------------
>  drivers/block/nbd.c        |  3 ++-
>  drivers/block/virtio_blk.c | 11 +++++++++--
>  include/linux/blkdev.h     |  8 ++++++++
>  4 files changed, 21 insertions(+), 18 deletions(-)
> 
> -- 
> 2.11.0

