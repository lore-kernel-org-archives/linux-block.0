Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60158C433B4
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 10:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26BEF613AE
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 10:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhDTKJI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 06:09:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231313AbhDTKJH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 06:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618913316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a1pYqsNDnaImaveZt19WFrefpysHdoYlJwKJGNtTNq4=;
        b=AcHYZmXYqbeEh4cX5cSX0Z4yYp6A7Ns0ZkqGEEZYCLN3stlRASx5jEyXL3d1sp/Dag+WBO
        T/WsXj90eUTuPgo6b+Jb1BnmN8KrA16qoJ8bFnUzF37C4LYlE/7qNIGDgxoV+/arstHLXX
        7hJ9Keja2FbZVLxxZTeFqqn9P29+L4A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-WU_c-e7kOtqDaih1Jr0ECQ-1; Tue, 20 Apr 2021 06:08:34 -0400
X-MC-Unique: WU_c-e7kOtqDaih1Jr0ECQ-1
Received: by mail-wr1-f71.google.com with SMTP id h60-20020adf90420000b029010418c4cd0cso9763730wrh.12
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 03:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a1pYqsNDnaImaveZt19WFrefpysHdoYlJwKJGNtTNq4=;
        b=W2hjRyJNVnihL9+5Mpx5F0ryZNaG3zG1H/O/3ygt3zdmGlcDvN7ELDDEYA2Mz7rLA5
         ArElp+E4XR8fEyiON+drglXvz2wVsnRatKTKkZKDfu91AapsZAUVVqW1LPf63SyD+P6G
         Y/6g2ZYUHYb9O/J07Um//PGf2VhFYlsEWEJvBOgmcFP3cAJUvScl3LYRO8wP3ovLxVuH
         elItkO7fVtbOz1eM2K9TOcedORLtQsPS25kXetXakhXfnDveM1T/BE0DkePVlNMrLvd8
         pkcZcqOpKSzk3HJ9ZzIC4LInC89agqTd93L40fbdD7ag3CvBUs85GrdKxhM9OrVe2sP1
         MUsQ==
X-Gm-Message-State: AOAM530OmYImTltc9Uq794R5fyZHzPNMopiJX/rpgYukQ+pyMnIWDdDM
        Ufqj4yCMFlXsbrXWRElPXpZ6nTJ16xrU4yDWR1mX51CBlukHBs3MJ42HKi0nypJb5ugiHp4KeSN
        mxYOyf9TZJl0VKVXhuj9TYp8=
X-Received: by 2002:adf:bbd2:: with SMTP id z18mr19583497wrg.274.1618913313338;
        Tue, 20 Apr 2021 03:08:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiOVtXxYFOUh6+eZ32xEpHAEZlXERzd+C/fJVENNgoKL6Wlrxpy9j9zC3V92YoEbuatNntfw==
X-Received: by 2002:adf:bbd2:: with SMTP id z18mr19583476wrg.274.1618913313205;
        Tue, 20 Apr 2021 03:08:33 -0700 (PDT)
Received: from redhat.com ([2a10:800a:cdef:0:114d:2085:61e4:7b41])
        by smtp.gmail.com with ESMTPSA id u8sm26806244wrr.42.2021.04.20.03.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 03:08:32 -0700 (PDT)
Date:   Tue, 20 Apr 2021 06:08:29 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Enrico Granata <egranata@google.com>, jasowang@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio_blk: Add support for lifetime feature
Message-ID: <20210420060807-mutt-send-email-mst@kernel.org>
References: <20210416194709.155497-1-egranata@google.com>
 <20210420070129.GA3534874@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420070129.GA3534874@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 20, 2021 at 08:01:29AM +0100, Christoph Hellwig wrote:
> Just to despit my 2 cents again:  I think the way this is specified
> in the virtio spec is actively harmful and we should not suport it in
> Linux.
> 
> If others override me we at least need to require a detailed
> documentation of these fields as the virto spec does not provide it.
> 
> Please also do not add pointless over 80 character lines, and follow
> the one value per sysfs file rule.

Enrico would you like to raise the issues with the virtio TC
for resolution?

-- 
MST

