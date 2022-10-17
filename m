Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA39C433FE
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 18:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJQSVB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Oct 2022 14:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJQSU7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Oct 2022 14:20:59 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D9F66876
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 11:20:57 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id x13so7168056qkg.11
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ASJnvbXdmbENnmELYX21Km/XI3pCAL3HYWqBCGT72Y=;
        b=py5hnISP+vNcRCvrzlR6VM021OOidZOopS8YOp2I/MYSkjn/IXbXq0MP760tCiZIeq
         vhIF88sffbaI+QdDO9hXnsYiLNdQxr6FM26NE9RI9fTeivzUL6c9JzGZRWa9vsihF9Yw
         83YT6UGOE+sWnm+cGaWoaY+t4C1LG7cAhD89p0aMTwfru10b9bUWNUqzrvPIq2zfXtve
         1Rsu2RgKer9QZavQfj+9tBWtkiwI5XzORJ+z9ZIOrfb/KrVyuHUFmTpfqpw0i57nDRhl
         7xDiqRzZ1M9LmFgZltEn9XDDX/t8sJvwZ/9FS/cIXqw5nbJe4M4B8Zm55xIwBJ8wb1i3
         n4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ASJnvbXdmbENnmELYX21Km/XI3pCAL3HYWqBCGT72Y=;
        b=g9l5YJ13D52+JwL6TvUsopNhmGlAEhlgp3tOl53wCZLr5ZgweWWJRze6zyvDQTBMDP
         iL/04GPOIBKfn1qhI1OkXGY/73W78804xpYPAGf+nNr0mVSyKTJElunY9mOL0tCBK3f6
         vSl0yRxbLUQ1+Se17cnoUvxV8cwdfxaWgqdIQQzZJlY12idjrBQFPs9RWworhCkJ1hb1
         WaZK5iVfJYTtdlUymUsikPmeu1mWLUcro7y1Rip+pX65Pfg1sX+sj09WMk0ykc/a6O0f
         5p+jccQwc20M1PZjs6BxD0nkMx/g+HSnFAwGa1NrTWCpQ/LFg1xgfguI6o0iVE7r2IkK
         x1bA==
X-Gm-Message-State: ACrzQf1RKfQmrqOuDdxMtSJnKSV3JVx0fdQnVLFMSIQcFEM/tRK/7tGX
        CknAm5mS62cgiGQg6NB2K2FJVQ==
X-Google-Smtp-Source: AMsMyM6J6Dor4LjaeQvdKkX1FJT68wOSGUH5+/u7d4t1++RTN5ctc8WvL//DY4qpdoDWEqpjcWItaQ==
X-Received: by 2002:a05:620a:4114:b0:6ee:dfb7:1584 with SMTP id j20-20020a05620a411400b006eedfb71584mr5776200qko.262.1666030856659;
        Mon, 17 Oct 2022 11:20:56 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id cf17-20020a05622a401100b0039c7b9522ecsm336321qtb.35.2022.10.17.11.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:20:56 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:20:55 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] block: Correct comment for scale_cookie_change
Message-ID: <Y02dBx/nNwMLUxXm@localhost.localdomain>
References: <20220929074055.30080-1-shikemeng@huawei.com>
 <20220929074055.30080-3-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929074055.30080-3-shikemeng@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 29, 2022 at 03:40:54PM +0800, Kemeng Shi wrote:
> Default queue depth of iolatency_grp is unlimited, so we scale down
> quickly(once by half) in scale_cookie_change. Remove the "subtract
> 1/16th" part which is not the truth.
>

Ok sure, but at least update the comment to indicate what we actually do when
scaling down.  Thanks,

Josef 
