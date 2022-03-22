Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D94C433FE
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 19:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiCVT6Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 15:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbiCVT6M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 15:58:12 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F124DF52
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 12:56:44 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id kc20so10719697qvb.3
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 12:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r2M2JOuLYpG55p64DBgWICTYUX9XKVk0kcqlFHGoMDA=;
        b=BdWEzZD7a6xIaBVHFRdbNox7zM+3KtB/l4ApXiKA7sGoF+WeADSfxdtd0xQpwC8hWa
         g6JeG2Z80/19FNjGpr4iiMwWvDON7GmjioGpoElp8r39GvnBromObz72SKhKAZu9y6Rd
         m+dAPibCOIOE0jKp+03ksFpp18ymbJ7bod6FEaum7QZ7/Zp4aQH72I+Lac2VsUGtLFT3
         MG1UlrMTQvWzA3y94/hngQ66uZ9kNZTLLCpEQC5yqqZt23Xnrp0CObSpj7aTdv8U/DQr
         tiC9225gAzIWMrhCJUMH3fla4+j+naVl+7/zxFjFk5zTe3IsAIquFNX4ba58ybm/dJ5Z
         uEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r2M2JOuLYpG55p64DBgWICTYUX9XKVk0kcqlFHGoMDA=;
        b=WI6JE69mToZdoeMwj2ySx+UuncGL3tfQc7U1vToalil78An0iNKRQKVS2XyrcqPg+h
         TMXb/t+mCq2OWsbXfRHQUifJ0tnYR8bcvHrX8NxEjz/nAuvwIZMo9+kNUUJ6Ki8kOWvK
         wiRmVowrkyz9SP6zn7mOe2X6zES5o5TdRuUolR6Eolo35f43GQvKJ3JameseDFA7OpXa
         O9pPgcIr0RMjOJ8KXUWIEg5paLGH271QSHBuzcLPy/oaw4tlcXzs/2Srd2/SD82h0iKq
         YJnrFrcS5T4ARfJ6zx2rUzRYe8ZRCw78rPq0A2lABMmIfwk2xtR8X0+Fw1kV5rrMCC1E
         +aQw==
X-Gm-Message-State: AOAM532VJVD8NUhuOSqC0WrYJ/8+0HqvMoVrdHKaI76EI7/WH4lZzxvg
        N0ejF9x/wLe2+nKWeiKTGowc/opSY2QeRg==
X-Google-Smtp-Source: ABdhPJzlHTjaGE8oOc1ZZY3SXA8xCNSRPWhxCVpIl/OzVXEZg7DtqPppTUjBDOPrYOpJH5O0xRAaVw==
X-Received: by 2002:ad4:5ec7:0:b0:42d:7892:c5fe with SMTP id jm7-20020ad45ec7000000b0042d7892c5femr21117429qvb.100.1647979003218;
        Tue, 22 Mar 2022 12:56:43 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g21-20020ac85815000000b002e06e2623a7sm14672786qtg.0.2022.03.22.12.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 12:56:42 -0700 (PDT)
Date:   Tue, 22 Mar 2022 15:56:41 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        zero.xu@bytedance.com
Subject: Re: [PATCH] nbd: Fix hung on disconnect request if socket is closed
 before
Message-ID: <Yjop+VdZi5xbHe+b@localhost.localdomain>
References: <20220322080639.142-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322080639.142-1-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 22, 2022 at 04:06:39PM +0800, Xie Yongji wrote:
> When userspace closes the socket before sending a disconnect
> request, the following I/O requests will be blocked in
> wait_for_reconnect() until dead timeout. This will cause the
> following disconnect request also hung on blk_mq_quiesce_queue().
> That means we have no way to disconnect a nbd device if there
> are some I/O requests waiting for reconnecting until dead timeout.
> It's not expected. So let's wake up the thread waiting for
> reconnecting directly when a disconnect request is sent.
> 
> Reported-by: Xu Jianhai <zero.xu@bytedance.com>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
