Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8ABC433FE
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 13:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57BA461075
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 13:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238953AbhJFN07 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 09:26:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37183 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238816AbhJFN0b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Oct 2021 09:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633526679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PhQKrj6CTy/IMZheSbTjJtRay2DZf3eElNhZxG86YDA=;
        b=gamzASfGW1zy01leG0yG/fakckqO2qQctWNmqVcReBRcBC3BTo8uOVi7DbjMNa3BK7kaUX
        Rz/l5Didd0tBzQQ3t8wS8gxEiVhNTXwDyZzZmKVPj4cHEuhkCwy/SY8J4MJRu78LGNnGjS
        8R9XxbStR8Jnl2/w3jqLP6QpKJhtfgA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-DwnW2eXnOS2WD3k3zG3M2g-1; Wed, 06 Oct 2021 09:24:37 -0400
X-MC-Unique: DwnW2eXnOS2WD3k3zG3M2g-1
Received: by mail-qt1-f198.google.com with SMTP id 100-20020aed30ed000000b002a6b3dc6465so2250432qtf.13
        for <linux-block@vger.kernel.org>; Wed, 06 Oct 2021 06:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PhQKrj6CTy/IMZheSbTjJtRay2DZf3eElNhZxG86YDA=;
        b=oZX7EnQBCYA3NP06BULNG/xes1MdxxJObVPPWJkjx8Ek77tN0BQh7bH2b3ed/d6IgG
         prE/yjBZ6cEjyiHc/A+IhzUQCr+qTZjpwPTSWX5CsQSypU+5esWzcpT6W1BKgIxCnjHQ
         NSMBXIFwN7+brvJR52FsrUrkdVwFR6qVIxVURIh4tfKtlCICeXHURsfRziHDrUQArXiF
         31T6wGu+Udn4eTn5XVSipwne2Y8oi/xPMR4nf5AFKhjvFh14HSEfkT4zap8Jq01yN7Fu
         ASP7Gas+MFtpcNyeHpzXJg0XRGzKF9u47ap0KvBPv4vSy1MCm81hqOFZdhcpKAVGhxqs
         jp0w==
X-Gm-Message-State: AOAM532kJX7YHocPFdi/sxS2IXuVDGQY3YqLB1MO9rFVYhkevDV5qaED
        bWuE8pA+dI0odqDSKv/xqOFGi5N6knX/PlYfBl9nmqZj/3dRMhvaE73EUVhuOpuJCmbPeuRjLl3
        3Op3W3DnJQVCjSrpp7CCF1vZU6/zfUQpLu4pbmJ8Mtv1vy5B6wsRJ6Id2FvyraL9Q4AWcsu+4
X-Received: by 2002:a37:9d16:: with SMTP id g22mr19915891qke.158.1633526677041;
        Wed, 06 Oct 2021 06:24:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwU5K9sLtf2F8/ZVmQbICWiONRseEkHUAhaNdvw8PixzCkidZf3Sgubc2NbR+xRlb/+oJjIrw==
X-Received: by 2002:a37:9d16:: with SMTP id g22mr19915860qke.158.1633526676823;
        Wed, 06 Oct 2021 06:24:36 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id s14sm5011152qtc.9.2021.10.06.06.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 06:24:36 -0700 (PDT)
Date:   Wed, 6 Oct 2021 09:24:35 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Satya Tangirala <satyaprateek2357@gmail.com>, dm-devel@redhat.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v4 1/4] blk-crypto-fallback: properly prefix function and
 struct names
Message-ID: <YV2jk1su5caAZmVP@redhat.com>
References: <20210929163600.52141-1-ebiggers@kernel.org>
 <20210929163600.52141-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929163600.52141-2-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 29 2021 at 12:35P -0400,
Eric Biggers <ebiggers@kernel.org> wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> For clarity, avoid using just the "blk_crypto_" prefix for functions and
> structs that are specific to blk-crypto-fallback.  Instead, use
> "blk_crypto_fallback_".  Some places already did this, but others
> didn't.
> 
> This is also a prerequisite for using "struct blk_crypto_keyslot" to
> mean a generic blk-crypto keyslot (which is what it sounds like).
> Rename the fallback one to "struct blk_crypto_fallback_keyslot".
> 
> No change in behavior.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

