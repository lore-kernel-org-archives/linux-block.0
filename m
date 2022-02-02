Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33C4C433EF
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 18:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiBBSdG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 13:33:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230086AbiBBSdG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Feb 2022 13:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643826785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=53Uot1wvZSt1uP0+nqAgLg+8waHH8Mj8+skF7+R4kzQ=;
        b=YiCy9Gqm/S1JoEqKdSH7eoyNCHA/5nI7JQ4cMhBSSfffxdjnO3FhjLZZKLgbHOhOM2Iwe7
        w4440VBXbie9EEhqppjCtHJrrR6cPS3hY/ZHOi0B1B8cPhPT+jEIgUrjHuN6i5z5Tk3j5u
        VNYfrxasiSM3IKWf65rzvGIoTeGP8DY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-cSb8k-KcMweZgVym1ew0OQ-1; Wed, 02 Feb 2022 13:33:04 -0500
X-MC-Unique: cSb8k-KcMweZgVym1ew0OQ-1
Received: by mail-qk1-f200.google.com with SMTP id z1-20020ae9f441000000b00507a22b2d00so362303qkl.8
        for <linux-block@vger.kernel.org>; Wed, 02 Feb 2022 10:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=53Uot1wvZSt1uP0+nqAgLg+8waHH8Mj8+skF7+R4kzQ=;
        b=jOGo6ouG4w/c0mPcrAIQP2BVPHcSZvbIhFM4TWHUFomplNQFpVPQ2yvGhyluSOq7kf
         KMDHP6wiZr4xRxDK13Oc8zI1hpnm8t1DECQI44x0q3n53muau54GHj9brIntOFgFSeXt
         0ETrmxMTfcr975OYZK6B4JRbjvJDnLUIUut7VuJCch9dKiO0Ae2Yum2gIY1PM/JDqrqW
         S19ayxYzwM/3I8n00C5TYmBVaRz56LS67ta4Jfm8nZXB9ZnMlo5Lz8wUu2v+fjgslko3
         na4t09BOo5xUhwrO3uyPLFKfvplaTTddmQlZk6VBl8ATmbfN40Kyt9hWUBgS8pTVJAeK
         4IUA==
X-Gm-Message-State: AOAM530KLPjBQDiprDK62leWU52zSssDMGy/4PM/DzKMJ7VVv3hVrYpv
        HjM/V8DDau3mvBQleFAZJZBEsW3m99ugPJF6XDCSDP6ICjI5wz5XrHuY/YESgh6HhSAQX2Vfxhn
        0Y8W9wuFOvm+XVCTvVPbcIw==
X-Received: by 2002:ad4:5745:: with SMTP id q5mr27182553qvx.55.1643826784146;
        Wed, 02 Feb 2022 10:33:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+xpPw5Ufa5QPVUE8hEtOkyVx76EUcpxqMD2VGXdH8iCwT01cOCO2Iq6GBrYUrepIug8Ij6w==
X-Received: by 2002:ad4:5745:: with SMTP id q5mr27182538qvx.55.1643826783950;
        Wed, 02 Feb 2022 10:33:03 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id o1sm13822596qkp.49.2022.02.02.10.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 10:33:03 -0800 (PST)
Date:   Wed, 2 Feb 2022 13:33:02 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com
Subject: Re: [PATCH 07/13] dm: retun the clone bio from alloc_tio
Message-ID: <YfrOXqVVwcwIoArj@redhat.com>
References: <20220202160109.108149-1-hch@lst.de>
 <20220202160109.108149-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202160109.108149-8-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 02 2022 at 11:01P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Return the clone bio embedded into the tio as that is what the callers
> actually want.  Similar for the free side.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Small nit, subject has typo: s/retun/return/

