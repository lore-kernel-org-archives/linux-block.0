Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C28C001B1
	for <linux-block@archiver.kernel.org>; Wed,  5 Jul 2023 00:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjGEAwV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jul 2023 20:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjGEAwU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jul 2023 20:52:20 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217C710E0
        for <linux-block@vger.kernel.org>; Tue,  4 Jul 2023 17:52:19 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a37909a64eso3998167b6e.1
        for <linux-block@vger.kernel.org>; Tue, 04 Jul 2023 17:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688518338; x=1691110338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xCkzZ7pNqHs6SfNWx54nXU3O/GrqA2EtHMcutv2usrA=;
        b=br2NjzGGG4yn6FD1RRXAtTlQUAzuhkQaOLTSAfhxUKM0ZqXN3vxPSUIu08auE4QHun
         Ci9DhC0YX6k7hzS8i6/uYcao/N9K6o5SJ0+t4CTlRot8Jafz3X6d/h6Kv9xOdbeJk52t
         NKzaQOj6GzGgRc5SRo3bjX+bHIK3X5cJ9tT/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688518338; x=1691110338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCkzZ7pNqHs6SfNWx54nXU3O/GrqA2EtHMcutv2usrA=;
        b=VB/Cw0oC10Ylepl4LB9XJDHdATxYm8RWVcfwDUzRQmHtODFaoVmlLBnPiba/fAv/k4
         xiDw2fue+c84zcKAV7VY8ljXe82ZRtRI8lEabunBLS1iIoLzlM1kZMnhUP5vD8b965Iw
         e3dRNJv88sAHAkd1Ifvdz/GeDlyhptbK3SAscUMs6NqeprCFWTW0afHEZWCX1rsriWBJ
         xm1DdBZpBAMd1L5iYpbGVnnafnOS6/A9KO7zyTowZDiweGhYUdoIrLuC70+BhFrAUv7z
         Mh8HMdIOtVe2k09Jg9yxzsxNPwmhXjj0VJO9lzhxTMDFG1tG1wV/fth8oiJ/Pd8qfR7R
         M6uA==
X-Gm-Message-State: AC+VfDyxV9M/iTWPBxK5AZydFOmyXdzSjXvr8sWBpywkKUJ9mR/gq+Lj
        sJYgiK+8xafCVKVCvRCAX3hYBJsqar5JJRkr+D0=
X-Google-Smtp-Source: ACHHUZ6hpbnHy56T5xz/ZPxeKzJBrTDRy0kcHBkGMdzOMsJA0CevdsSJ5IJ2bGLftPs4NfoIts24ZA==
X-Received: by 2002:a05:6808:1895:b0:3a1:e796:d961 with SMTP id bi21-20020a056808189500b003a1e796d961mr17420567oib.2.1688518338483;
        Tue, 04 Jul 2023 17:52:18 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902b18e00b001b03c225c0asm17640763plr.221.2023.07.04.17.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 17:52:17 -0700 (PDT)
Date:   Wed, 5 Jul 2023 09:52:13 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 09/32] zram: Convert to use blkdev_get_handle_by_dev()
Message-ID: <20230705005213.GD283328@google.com>
References: <20230629165206.383-1-jack@suse.cz>
 <20230704122224.16257-9-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704122224.16257-9-jack@suse.cz>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/07/04 14:21), Jan Kara wrote:
> 
> Convert zram to use blkdev_get_handle_by_dev() and pass the handle
> around.
> 
> CC: Minchan Kim <minchan@kernel.org>
> CC: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Jan Kara <jack@suse.cz>

FWIW,
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
