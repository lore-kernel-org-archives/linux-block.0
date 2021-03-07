Return-Path: <SRS0=nGPF=IF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1351BC433DB
	for <linux-block@archiver.kernel.org>; Sun,  7 Mar 2021 20:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDB0E6516B
	for <linux-block@archiver.kernel.org>; Sun,  7 Mar 2021 20:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhCGUkx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Mar 2021 15:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbhCGUkw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Mar 2021 15:40:52 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9523AC06174A
        for <linux-block@vger.kernel.org>; Sun,  7 Mar 2021 12:40:52 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso1929791pjb.4
        for <linux-block@vger.kernel.org>; Sun, 07 Mar 2021 12:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zFKZ+plkHJCabvx87gFRsKwL2LA7EPxXKyKCRVNXqdA=;
        b=ZC2D4D/aVHsWUTTm3RDAJVPFkV2BW4wgA+aydBJa7A3Ljuft7+StGQJHZ6gBOMQdLZ
         TwXW6sHJ0LZz3/IcmbJN+eORuW85NwiusviPvNFwFNcjXqT+rJtcXJI6glhl/6WkrHzK
         yltWygrAXucJYoo9LaiJ5CEKX2f9J3yiOxai9498SuJOINnVfyUGW28J7x5xYqRF9GdP
         3cx7Ln/LVUGAhSR13x7TPq2vgsBn9P9C9OXxl1EvDEOycAaZhsJQ/4F8afmDllSRdh/l
         i8gr8q2OQgdooF11kubysMaxHEKgjeFYXFCVvctRfhs8B4in82CTEvoZFMkrhQ3A9uZ4
         GUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zFKZ+plkHJCabvx87gFRsKwL2LA7EPxXKyKCRVNXqdA=;
        b=mIbE9ebiJR6kXFJSpP+g3CKpf7JTeAeVLLg3TSsl/5xV83Oelo1eH/Kp+TnlGh5NlZ
         0kZpLAzq/V4Mn7iZIADLRMRrA2siIWK4zv+HnWMESWgxlNErg47rc1tjBnyqH13tB7Id
         jWkY0aXmW9W+QZWzPSeUfV0EXYd2n+x8PLjt2uMyt/2E7VXAJaMa4ZnGnxNBy2vGxHCt
         8xzW9UZh3fkxBRjU+/8kc2e1CYurENZcXdAipXdw1kB5IAYsl4rn3mHLQsb2e7xvdOzQ
         jUVagllD3I7MISG1YOkQaHZ5jd+WVUHqCrIZRQGp/F4suhK/KnqyrzmeO85KJIEhWulo
         xV0g==
X-Gm-Message-State: AOAM532bdhFPEsMR8LzgpovuHbEL4uNicAboYpBGDBxh8FJDX7EAflH0
        2/RKiqYaa9TAu2phbT4m7nTlVQ==
X-Google-Smtp-Source: ABdhPJxutYvFuc6odYhs2QIdmOO58P3Xh4VTykp4Ddo2cZVxikmzufFvnF4B/oGyr28tfkB/kQnOFg==
X-Received: by 2002:a17:90a:d590:: with SMTP id v16mr20747172pju.118.1615149652099;
        Sun, 07 Mar 2021 12:40:52 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:ac1a])
        by smtp.gmail.com with ESMTPSA id x14sm8366800pfm.207.2021.03.07.12.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 12:40:51 -0800 (PST)
Date:   Sun, 7 Mar 2021 12:40:49 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH blktests v2] rdma: Use rdma link instead of
 /sys/class/infiniband/*/parent
Message-ID: <YEU6Uf6cY+TAWfxW@relinquished.localdomain>
References: <20210228223403.21685-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210228223403.21685-1-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Feb 28, 2021 at 02:34:03PM -0800, Bart Van Assche wrote:
> The approach of verifying whether or not an RDMA interface is associated
> with the rdma_rxe interface by looking up its parent device is deprecated
> and will be removed soon from the Linux kernel. Hence this patch that uses
> the rdma link command instead.
> 
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
> v2: Added a _have_program check for 'rdma' as requested by Omar.
> ---
>  common/multipath-over-rdma | 111 +++++++++++--------------------------
>  tests/nvmeof-mp/rc         |   2 +-
>  tests/srp/rc               |  12 +---
>  3 files changed, 35 insertions(+), 90 deletions(-)

Thanks, applied.
