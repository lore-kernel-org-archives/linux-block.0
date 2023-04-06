Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC46AC77B6C
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 21:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbjDFVTy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240066AbjDFVTw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 17:19:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C687A26C
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 14:19:51 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q2so2538019pll.7
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 14:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4q2yZUDY9+DAqNExO05l5NIqw4IFLcHgMroHz7eXEg=;
        b=o5uyserpBqBSAFKxCKAOHHmqzLxUc0PoeQXJCpUH8laSCAKK7ojCYMjBkzcLPWt8Md
         Li0IA0NYVD0gh21szZUW+NQB41lKaEQD/Pkzl9uQDRTyU1Q/vUheLLs+dWvUriVjuHug
         7ZtuZupyY2jK10/bw5SBG71Iz5AgVqsK45PkOQPT2VuGjD1LFpL6yX7Gge/++mnXITTG
         TCcKPgMYm1OCzPv3kzmJvRDAhFY4Kli2mthve67Y15YbMhdGMl+Cgv7LH5fgw93kwmRM
         vx2JHhu21oEyUqJO4N1cLHLRJOxZQC9tdpVjYMTRXYWIXyYLm+EuohJarmBkPpoS7GVu
         kSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4q2yZUDY9+DAqNExO05l5NIqw4IFLcHgMroHz7eXEg=;
        b=3IERKsqQnyZHYAH2FQGhNi8C+zcQcBZi8X6YAou6dO/lparVmCGfAkq2m6nxS+d91q
         sewVRmgJmNVE63hr+Oy0CsAzHerEZsoTDdZ9brtV9QeEGHUDlwp4rOLowFHy/zcVYuEr
         c6B/xcjBkf6dTUX7tkHJTRh9u4NsYfuPTrqFNt1Reqk7++d9BrdpwmFiI5XYf7ap7Yf+
         t9ZFIQPtePQobOfKqJv8df9JKkGG7kVznAgsbKxc6ujKgCFvtGMLGxuXXk+x8H4wurrp
         xlxqDH/sr7SLlEYxYEUmA5oOOjqp/ViB8Bl8ER5ZyntnsCeFlHphQg6hpGm2LDCKjd00
         tyuA==
X-Gm-Message-State: AAQBX9fxvUUWfY/OEP+d4jEHUOeQikqhZix1n3+FiKwPvADGwfAuEJzb
        b1pLhTHBQSMfPgY8DxTZjFqHvQgEP6k=
X-Google-Smtp-Source: AKy350apEokeNKx0NPatu6pOjfWuXr7TfyeghA0U7LjK+GzUliBGULp8FE1InhM2YRkw1I8+D0a2gA==
X-Received: by 2002:a17:90b:33c8:b0:23f:35c8:895 with SMTP id lk8-20020a17090b33c800b0023f35c80895mr12806068pjb.32.1680815990723;
        Thu, 06 Apr 2023 14:19:50 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a8d:6a82:8d0e:6dc8])
        by smtp.gmail.com with ESMTPSA id s12-20020a170902a50c00b0019aaab3f9d7sm1781844plq.113.2023.04.06.14.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:19:50 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Apr 2023 14:19:48 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 09/16] zram: directly call zram_read_page in
 writeback_store
Message-ID: <ZC83dNGzQm2oHiql@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406144102.149231-10-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 04:40:55PM +0200, Christoph Hellwig wrote:
> writeback_store always reads a full page, so just call zram_read_page
> directly and bypass the boune buffer handling.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
