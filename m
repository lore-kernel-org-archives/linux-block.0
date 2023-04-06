Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4133C7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 21:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239362AbjDFVQp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjDFVQo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 17:16:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4AF83DC
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 14:16:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so44107299pjp.1
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3n/5XSAqR2ZLfuTFZ8pQtR2avKLFotD5XNuJnm7B0Jg=;
        b=X6KIaYVyE5cqmMrdbzzVUHp0pegqMR/YPxUucrfTsV/RJ6zoz7Flt9UibqJQUPpt3X
         hLtmyEr76+majahfmSJBFFYYxftb8yUIbtER1qdkSg+89Bq0yIwlsB2xZp6ADD15QhBv
         D4wYJtnd1JeB2yRZwDrTbdBHWHvnRc58lgtHbeKm1kEj1RbNys9IakWt4JTCquHbCi2B
         /00wWRNefKjh0Ro0swcuRIXuyld1ZZ7JUblWC4epXTnRdH9uiICddhUMuOJE/7VBuGtg
         xO9WKhEHd+PqlScBUP9vstuApvy34D2/B2+Ugabd/3wgfidLWrOWpzVsOX2fO1V0nWTu
         rnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3n/5XSAqR2ZLfuTFZ8pQtR2avKLFotD5XNuJnm7B0Jg=;
        b=qO7Ka49s9dDfj9eGFD6T3o3GX1G9uzTRxfSswpYG6ld9kXfNGlWhvkyvN+jJoYJwpg
         gEgohBqohWu91pnhVSYycZaBh+f5g6OoQJWJellVx2aDbIBvl+E3H9OaldHaAOO93UF+
         2/EwVafq1U+OanCE2ZvWaTI7M1KKwp95U/FfF542QznhnMKoVUjedtgu2r4dG2hEwemG
         xnCDfKiNJlTdEmqpGSpKC4VCj1CbAUoz0mvLWi0AFyqlPRR7OQLffLv227USp5o/X1LL
         o/cbRsZwcZPBGyYoLapDFQFnIGFCCZvWU6nNID27ADqSxOtaPj2zIuOCTpWBZRg4iJt9
         HHDg==
X-Gm-Message-State: AAQBX9dLBceSL5ITr/t2ncEtlVqo6n8zb/BsgAW+56J7A6sk/3u0CXBm
        eaRHtCHDV0S2ZkYTzQCIaso=
X-Google-Smtp-Source: AKy350bGinZQhcdOmU9q3l9rKO1o2rlly0SbR9owdHiy9XPyzkIujqoJ32aUDFVgvDduV0jwS4Ujvw==
X-Received: by 2002:a17:903:4308:b0:1a1:c746:7d6f with SMTP id jz8-20020a170903430800b001a1c7467d6fmr421888plb.53.1680815803197;
        Thu, 06 Apr 2023 14:16:43 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a8d:6a82:8d0e:6dc8])
        by smtp.gmail.com with ESMTPSA id t143-20020a635f95000000b0051324e710d0sm1550721pgb.59.2023.04.06.14.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:16:42 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Apr 2023 14:16:40 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 07/16] zram: don't use highmem for the bounce buffer in
 zram_bvec_{read,write}
Message-ID: <ZC82uKfQhi/FrCFL@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406144102.149231-8-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 04:40:53PM +0200, Christoph Hellwig wrote:
> There is no point in allocation a highmem page when we instantly need
> to copy from it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
