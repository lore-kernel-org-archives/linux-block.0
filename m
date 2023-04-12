Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649D5C7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 12:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjDLMan (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 08:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjDLMak (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 08:30:40 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2870D869F
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 05:30:25 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 21so3019049plg.12
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 05:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681302624; x=1683894624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iQEC66YTGNRICg+kLYd8/Kkqb+x186tPb4gRDqBWeXQ=;
        b=j3EQQfLU4iXe1dGzm2kTJsddmnZbW5PGfTw51IfsIMUY+kaBKfpF+yw0I7e0U4vLay
         EKW0iP3BYVwhZX48eEzmgCHGnsf6Rl+qqp9GVmzAs/LlWW7nfiI5NU1hyPMlVF6OBEp3
         VFvgY/HW8fzxDhDBiVJypfCbPS+FxwIMnYDro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302624; x=1683894624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQEC66YTGNRICg+kLYd8/Kkqb+x186tPb4gRDqBWeXQ=;
        b=PJi8oZYhSHwoQW0hYpjp0BYB1wOrL1H5aEaJWmeMQ/OibpjJe0UAY8afhBkxXTKMne
         RscH8mR11iUIcXa1I/YXFSlvbS3PExSQcE2B2ybCp2v3/6cLDUdjpHZUJeqvisLENkOc
         NIpOKwYH7g2sBO/ZrinWub/039EQFfHOxW5Gypx/CUqNiyJSymIMqwiGxE3ng7Z4JHvY
         BSojDpiiD73siUseyGN0JACzGgnGZN38CZ2YlHSHLGl2zAZWzX0t8M54qCMI4X7SYAv8
         lLJ1q4/z6Ytw9S/iwZZjsj6VlAntwPtYS1uGM7Kk+DlNXizEofc5qP7gZI1HWesZyg3T
         CmeQ==
X-Gm-Message-State: AAQBX9ciI3+cioZ6gT6pC4Tk7W2U0tSM+JPz4RbCmDPr2VasbJy4n7Sw
        E7fOoHZzQ+7/5a2gGxhaYx1FsQ==
X-Google-Smtp-Source: AKy350Zi3c8aaa9oYEXIt0rXA0GZfbVg0i/e/Pq/Jq3yGlz9tw7McdeCDfpZKKRWaEckXuT0DHndOg==
X-Received: by 2002:a17:902:fb07:b0:1a5:2e19:bc40 with SMTP id le7-20020a170902fb0700b001a52e19bc40mr14207222plb.26.1681302624365;
        Wed, 12 Apr 2023 05:30:24 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id t14-20020a170902b20e00b001a507d9f836sm10601027plr.290.2023.04.12.05.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 05:30:24 -0700 (PDT)
Date:   Wed, 12 Apr 2023 21:30:19 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 07/17] zram: refactor highlevel read and write handling
Message-ID: <20230412123019.GG25053@google.com>
References: <20230411171459.567614-1-hch@lst.de>
 <20230411171459.567614-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411171459.567614-8-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/11 19:14), Christoph Hellwig wrote:
> Instead of having an outer loop in __zram_make_request and then branch
> out for reads vs writes for each loop iteration in zram_bvec_rw, split
> the main handler into separat zram_bio_read and zram_bio_write handlers
> that also include the functionality formerly in zram_bvec_rw.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Minchan Kim <minchan@kernel.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
