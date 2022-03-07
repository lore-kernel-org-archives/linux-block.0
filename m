Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADC5C4332F
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 16:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiCGQ5X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242639AbiCGQ5X (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 11:57:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 769957E0A5
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 08:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646672187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GKvX1sl7p58ECEtwztu/8ZgveUC73k+ES14SIrLarpQ=;
        b=eA8BHRsaBl1CBRisaXrIJOluFFLgl7mvVmqgUGwhUNZjdNSOT8paZzDxRW0m0gBKnnz8Fb
        M0jFlOHeCLX87qcxtLIex9QZgfsrpMMgemNkbUXbDrpMtW4dlClOq9wl1HZSVELdxwmyQT
        543dR55uEnhfuydgDkOfBMkloeW8RSY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-FVqSVMb6NGqHZiw4JcXSSQ-1; Mon, 07 Mar 2022 11:56:26 -0500
X-MC-Unique: FVqSVMb6NGqHZiw4JcXSSQ-1
Received: by mail-qv1-f72.google.com with SMTP id f14-20020a0caa8e000000b0043329d67255so13429919qvb.8
        for <linux-block@vger.kernel.org>; Mon, 07 Mar 2022 08:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GKvX1sl7p58ECEtwztu/8ZgveUC73k+ES14SIrLarpQ=;
        b=bVFNUOIiu5jCDFR1/FzOGcSamesGa6b6BD5zN6Y2JRerXrto/+zLS/ofkrtgKiLmGS
         x2Oeq0Ujcm+1yEvbO46hwjrTzub0NXPYRUqTIh5XDdTaSUzY+s+V95A/SzNxJJuOPFJj
         zIdOQo0Ri5mmXjKdSUJ+Myjkile8t21mtiekRsbWGk0CAMfHzXFRYfPu46XNxzr6mJ5j
         WghZSYqAAKyqm00hPOZ7+X+PfA5Bg7rOHMqUiyZZHZiFO1rwljJY0OfKNnhQktvo6F7R
         Q1qGYAV6gymnts1ismSvLQ+iC8Yj80VKQib7jYph/8IowkaNeJBPWUTTJG1TKSIzeLUP
         /CBg==
X-Gm-Message-State: AOAM530xWQHnIiZ9vEUhbZhnICwDkvtGbDfUzrCNZA3hrTf38/g2qwPy
        BKE1BtpQxfNvLJgYuDN8yuECPkQe1uYBTYbyY4KPyHpoGGWQxn70HFRxFXt8pw2jA71UCS2mYt5
        Hv3WcWaIsFNkJagqdVqKgVw==
X-Received: by 2002:a37:e303:0:b0:47b:b0e1:fc3f with SMTP id y3-20020a37e303000000b0047bb0e1fc3fmr7411350qki.108.1646672185820;
        Mon, 07 Mar 2022 08:56:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgimeaJmCviuje97Vzy/Bu8ddKoAbj4Lj2WFLdHhsuRx8YeCO+5ZEp3hBleQ9OYyyKUFJxWg==
X-Received: by 2002:a37:e303:0:b0:47b:b0e1:fc3f with SMTP id y3-20020a37e303000000b0047bb0e1fc3fmr7411341qki.108.1646672185573;
        Mon, 07 Mar 2022 08:56:25 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id l19-20020a05622a175300b002de935a94c9sm9086902qtk.8.2022.03.07.08.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 08:56:25 -0800 (PST)
Date:   Mon, 7 Mar 2022 11:56:24 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-raid@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Song Liu <song@kernel.org>
Subject: Re: remove bio_devname
Message-ID: <YiY5OLhi1WMFUgGH@redhat.com>
References: <20220304180105.409765-1-hch@lst.de>
 <164666057398.15541.7415780807920631127.b4-ty@kernel.dk>
 <YiY2wUVIz3NXIjlc@redhat.com>
 <20220307164814.GA12591@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307164814.GA12591@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 07 2022 at 11:48P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Mar 07, 2022 at 11:45:53AM -0500, Mike Snitzer wrote:
> > Should those go through block too? Or is there no plan to remove
> > bdevname()?
> 
> My preference would be:  do the full bio_devname removal through Jens'
> tree and you keep the bvdevname removal.  I hope bdevname will go away
> as well, but certainly not in this merge window.

OK, sounds good. Thanks

