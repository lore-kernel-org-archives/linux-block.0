Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E76C433F5
	for <linux-block@archiver.kernel.org>; Mon, 23 May 2022 14:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbiEWOQT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 May 2022 10:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237038AbiEWOQS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 May 2022 10:16:18 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDCC5995C
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 07:16:17 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id x7so9401954qta.6
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 07:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H767C2i0qpntP2Hc25tbjn02oMYnv32wuUYy29Xv2ng=;
        b=VKeQ6xPhdr+J56IKqkCNNphoFA9/Dp/YQhSmkGwfWDKX1rbeX8HmFE31UJPFRkHOFx
         uEhxIkgD8DHNx4OWFSVU1Nqh6ZQwz7m/4I5ANeTsgKMLiKJLRkc35PzktklEcXUTAWp1
         MMPXycGF/aRmwO5QdDU2rJ1O32iAeffGYuTnGw2LAmGa4n1yzj5y+FLvaTbCp676rYBH
         //o4NKTmMCRpfHL/yl5hNQvqG5opsemec2n3ZTxWXnYwr0ITu1IO6e/47ZJIXEIt22+u
         jtmbKxyXVxT2hxvIl6MDdYWeJe5FeELdljLp9cAYp8viRD9ZX1IEroTJZ41CkKrDo+zN
         qx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H767C2i0qpntP2Hc25tbjn02oMYnv32wuUYy29Xv2ng=;
        b=t8MQlnG/1QP1cvOGkPxURxX/fGDizrIu6WnSonnhM0bOTSiCWJQFFTNE3xIXwLSQue
         mPtz/i2usKLfsKnC0rh7AsGndXamxtyepMZRHTzopizuHcDzvhWz7jnE7QuIBLrBjBtq
         KuenrcllNk4wC9syJbatrDbg7EejamFuPsuRRcoj2QsvqOiqbn0NS+KJ96JVqCS+w890
         bItldjujKHurJZ+SUrfBAYyQdAuLhpMn1iI8Lny8759SQSpdfPN1JRKrJJOfmqCLhTdk
         UUMpOqGqxduHB23uKQ4ysW8fMHiVqqg5uL3NVSOIqw6rp78UWQzC5nSb9eUlieDI3O8g
         A9rg==
X-Gm-Message-State: AOAM532Z1nILiGUuR7Zq8H1zIv1jooyfwu0pcdLVxQtftGQyHgQdyXg+
        hgX2dwj8XullCGhulLLgGEPpOA==
X-Google-Smtp-Source: ABdhPJyWvmxgvwQh77GvbLiPrvty8oAChia/sMMFwbpgZEYfGVYSwOCRw3DbsadOlhmz2+uVGVAMsQ==
X-Received: by 2002:ac8:5889:0:b0:2f3:bb3f:b0d2 with SMTP id t9-20020ac85889000000b002f3bb3fb0d2mr16130738qta.593.1653315376387;
        Mon, 23 May 2022 07:16:16 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c19-20020a05620a165300b0069fc13ce1e5sm4348806qko.22.2022.05.23.07.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:16:15 -0700 (PDT)
Date:   Mon, 23 May 2022 10:16:14 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v3 6/6] nbd: use pr_err to output error message
Message-ID: <YouXLg33YEIuV2aO@localhost.localdomain>
References: <20220521073749.3146892-1-yukuai3@huawei.com>
 <20220521073749.3146892-7-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521073749.3146892-7-yukuai3@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 21, 2022 at 03:37:49PM +0800, Yu Kuai wrote:
> Instead of using the long printk(KERN_ERR "nbd: ...") to
> output error message, defining pr_fmt and using
> the short pr_err("") to do that. The replacemen is done
> by using the following command:
> 
>   sed -i 's/printk(KERN_ERR "nbd: /pr_err("/g' \
> 		  drivers/block/nbd.c
> 
> This patch also rewrap to 80 columns where possible.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
