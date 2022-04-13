Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C94C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 03:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiDMDF1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 23:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiDMDFZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 23:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FCFA50B30
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 20:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649818984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1YkZJ2FmfvZkHadYpDW8t4reFTcTKRda4JrY5UE63qU=;
        b=eQT2c5+PiuPuV89Y95sjL4K0zloNqXROKX6GLbMCDr3rHGZzVa9YUW3GaHNHAwqITRJPHv
        8GK6eUlA7JsKLYgVWbLMf/50ysTaCniceOTaaCSitCzvFR6QiRPySYZqwWacdR1IHaVVGO
        r1oVRMVLZG3Skb0IXHxsHy9Bxz9deeg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-9KDNDrN-MaCz0AAYtzY8iw-1; Tue, 12 Apr 2022 23:03:03 -0400
X-MC-Unique: 9KDNDrN-MaCz0AAYtzY8iw-1
Received: by mail-pj1-f71.google.com with SMTP id u4-20020a17090a5e4400b001cba059a4fbso405730pji.7
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 20:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1YkZJ2FmfvZkHadYpDW8t4reFTcTKRda4JrY5UE63qU=;
        b=JbsfzpVnTGTgP37f3z5IkwexXrPNk4b54D3qU9nJWcRzzXl2ab4qXii2aw0djvtF4+
         y62nnSVSaUnn5DBPaaEVgddPJRy8FpMt14vT601MeEBC0uO/dMUXzTrIJ1uVmc4tB5PW
         OlltXSvf1aijhpWefy+QPx5VBdTkurXQQEZYUi/ijmAFzM0vNXBMq6O2Q3V0lbjt04IV
         QKA5WcXArU54p8C7FwEOfMNRk8ISf5ZrRUWVO1JHx0Q/0ySn9vwqh/Forux0RD3GqGxU
         sQnkBFBkeKwo6CzELC2NezbUVYg0cqxHmzSwUOarSmzADAw8i/iXXvmW4/1WPM5OiTaQ
         Xtrw==
X-Gm-Message-State: AOAM532bHyrO8NILBeLxVBQIhhKIt5XCCJW9MTz0JJHLqhRlP4WX/41x
        /Tn1HzUxBEhKMokihr9mKToA0TE99XEq5fqgfBifGPBZr6LjgpQQtvmRo3yFM2sd8lbjs9TuRfo
        3n3+apSfaMrrYzMvQzi7+bMP59fb4cdHiwHaxjYE=
X-Received: by 2002:a63:1821:0:b0:39c:c771:dc2 with SMTP id y33-20020a631821000000b0039cc7710dc2mr24117765pgl.507.1649818978936;
        Tue, 12 Apr 2022 20:02:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFjVGyHvK8chYl/HqZK3kSid3N5u26Wdnk+x9sl3TieR62BnlG8/FixYxuXZdob36SvCIArHwrJyNqfxRcKfo=
X-Received: by 2002:a63:1821:0:b0:39c:c771:dc2 with SMTP id
 y33-20020a631821000000b0039cc7710dc2mr24117749pgl.507.1649818978715; Tue, 12
 Apr 2022 20:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
In-Reply-To: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 13 Apr 2022 11:02:47 +0800
Message-ID: <CAHj4cs-HD_uQ_=SQKyFcUJvxFmiJMZSxX5uaqCAkN3h2Zw93ZQ@mail.gmail.com>
Subject: Re: can't run nvme-mp blktests
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 13, 2022 at 8:24 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> I do have CONFIG_NVME_MULTIPATH=y but I also have:
>
> cat /etc/modprobe.d/nvme.conf
> options nvme_core multipath=N
>
> And yet I always end up booting with:
>
> cat /sys/module/nvme_core/parameters/multipath
> Y
>
> So trying to run:
>
> nvme_trtype=rdma ./check nvmeof-mp
>
> I end up with the warning:
>
> nvmeof-mp/***                                                [not run]
>     CONFIG_NVME_MULTIPATH has been set in .config and multipathing has been enabled in the nvme_core kernel module
>
> Are there times where one cannot disable multipath? I'm not using
> any nvme drive at boot, but I do use one for a random data parition.

So the multipath is not updated with N, pls try manually removing the
nvme_core module and retest.
Or just reboot can also help update the parameter.

BTW, to run blktests nvmeof-mp, the correct way is:
# ./check nvmeof-mp
# use_siw=1 ./check nvmeof-mp

>
> Any tips?
>
>   Luis
>


-- 
Best Regards,
  Yi Zhang

