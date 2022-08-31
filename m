Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36548ECAAD1
	for <linux-block@archiver.kernel.org>; Wed, 31 Aug 2022 12:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiHaMow (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 08:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiHaMov (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 08:44:51 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F651F7
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 05:44:44 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bx38so14469074ljb.10
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=h1AvYi1T0tvN+qAq+tLjrW2ls7Mfnokdm9PQJyf9qdE=;
        b=BDvrWjU9jmCImvbODCmDq21Wtv1nlWEPLDYpsbmyBo3NtAZuOnBDai4Y1Gq9rK0BfX
         vNXR8PhCVoYSb59GriRT9LmvGtxF5+GnA6QtxwXUVk2fyBjMQNlMmwgqBNdexh4O9GGN
         IdjYo9y7LFFTUTfFPM1ktjdihvt3BHzzF9EdC2Q7YyUU94+MKTqmYtNEUYXq4UvMmBNs
         vzJUoWQYDojv8czvokh9VIEdxDLvJY0IpsIFOh24tVtlGjEfyzUlxMvlP0TC+hjBs+3D
         hz12EPfgIuKNvSJcZCIpnF6xMvp4HzBM4PS9Fa/8HezM1zKpCHd6ZmfUc6P2QMjRDL0a
         TEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=h1AvYi1T0tvN+qAq+tLjrW2ls7Mfnokdm9PQJyf9qdE=;
        b=XufYnfCTox0oaVKKTLJjKPGEXBQjPQp6ipHHZO5M6IzXATaCswlEBaX9c18WiaVYNb
         spZ3aC3vr/6844O3ZQ/uIPd0J1VNG1n9fr3LGnIzgE6DTrD/c6PftzHNmAEyVlw7rGh1
         XDGoeIDStwUnFtQ+ra5VK5aAtEn3urIMdmj5vk1iFkH4dharMyJZQLhJ7809erervdRy
         LyM7sns5BSpirJm9zpQjQYoGg19iupTQF77UjCar8fVDbXXmmLFpZ2k9e2Gmhsa9KCM/
         e8n+DjdKQIhyvJH7PY9c7f2KQUOG/ou8A7P9UVBiTBpvbefzKp4NFLrGqCcJMHeJl2t1
         lc6w==
X-Gm-Message-State: ACgBeo0d/OWNr78lvj3CtGBZn5s9pXqH0tlaIHEGt6uFQy9WYeoRbpwo
        07ZZyk5b/8YOu6e0yUSyuek=
X-Google-Smtp-Source: AA6agR5HbjxyrE7/PCyrtvAi16FIg9PfQRtO4chFw6GhtsYpfJgF2tmegt6nqMwMj+LnxTGKJYVs0A==
X-Received: by 2002:a05:651c:4ca:b0:268:10c2:87bc with SMTP id e10-20020a05651c04ca00b0026810c287bcmr1871489lji.241.1661949883070;
        Wed, 31 Aug 2022 05:44:43 -0700 (PDT)
Received: from localhost (87-49-45-210-mobile.dk.customer.tdc.net. [87.49.45.210])
        by smtp.gmail.com with ESMTPSA id o18-20020a05651205d200b0048bd7136ef3sm1979215lfo.221.2022.08.31.05.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:44:42 -0700 (PDT)
Date:   Wed, 31 Aug 2022 14:44:41 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, acourbot@chromium.org, hch@infradead.org,
        linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2] virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()
Message-ID: <20220831124441.ai5xratdpemiqmyv@quentin>
References: <20220830150153.12627-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830150153.12627-1-suwan.kim027@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 31, 2022 at 12:01:53AM +0900, Suwan Kim wrote:
> If a request fails at virtio_queue_rqs(), it is inserted to requeue_list
> and passed to virtio_queue_rq(). Then blk_mq_start_request() can be called
> again at virtio_queue_rq() and trigger WARN_ON_ONCE like below trace because
> request state was already set to MQ_RQ_IN_FLIGHT in virtio_queue_rqs()
> despite the failure.
> 
> To avoid calling blk_mq_start_request() twice, This patch moves the
> execution of blk_mq_start_request() to the end of virtblk_prep_rq().
> And instead of requeuing failed request to plug list in the error path of
> virtblk_add_req_batch(), it uses blk_mq_requeue_request() to change failed
> request state to MQ_RQ_IDLE. Then virtblk can safely handle the request
> on the next trial.
> 
> Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
> Reported-by: Alexandre Courbot <acourbot@chromium.org>
> Tested-by: Alexandre Courbot <acourbot@chromium.org>
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
Looks good.
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
