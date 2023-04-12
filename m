Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9AAC7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 12:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDLM2n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 08:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLM2M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 08:28:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98DD527E
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 05:27:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id c3so12243166pjg.1
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 05:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681302479; x=1683894479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OHwgQCls7OE6cS2UfNvW73dQ95kWKhGiDSKnfNbHZ/Y=;
        b=HofAAUHXgpsogYvO2rbKmkX0Io7XVwrCueShJ7XbLiv+wF9nyDV62NxINyrjH0C1Wp
         zAZG2NtXKhi7VyhuOePrHHb4r6uFvKNi6BkpHy2x2mF4+qN6FNl9RrZ4EQrpcPVoCokv
         YO//0XbbodnIEy/rKxHnagB5PkMvJ7ApohRWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302479; x=1683894479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHwgQCls7OE6cS2UfNvW73dQ95kWKhGiDSKnfNbHZ/Y=;
        b=wwmXNs18ynEv9mB8VT691dx0sDi2oJxTrYywRdKzxr1V2ZVmKWVCGyvJTDCpPR8kAL
         7DLCRLKejowzl1e8jAPzBjrhA1pMR+p9XUj7hjBxALDEyhX6x9oVx03SG3CGAvQQ6zOC
         wVZ8QjES4ps8RqwNh7/iR2BQHWaJwYf9yOm9siZTadgIg/oi8lzyzuRuxrjhclYa7Y1M
         f3t+Uoss79R+8xndMPa6LuRDULb/uS/E2RF4PLtvycgF6YLyg/ncIijxcnWLyzNhCRfY
         h9jAUnS8qgu8CwdMKPUjkThAYTITVPTgPOqrpY2qG6P55it0hs+gorIpmMokCFtO1ORe
         3hcg==
X-Gm-Message-State: AAQBX9dCOF2AWD3LElR9bPk5QGJ1lguGCht73+X4S5DxJ4oD2Mztl7xP
        yQ7XrZmUn93GoO49VaLHLWk8uQ==
X-Google-Smtp-Source: AKy350b8YGmFD1GUj9zj5kbbs6UzM4ROLQpBOv1iOU8bB3Ptgu8Bz2sPQWEpMNBAqWVy3jbPaRjRgA==
X-Received: by 2002:a17:90a:d583:b0:23b:569d:fe41 with SMTP id v3-20020a17090ad58300b0023b569dfe41mr18682475pju.7.1681302479290;
        Wed, 12 Apr 2023 05:27:59 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id me18-20020a17090b17d200b00244991b3f7asm4554883pjb.1.2023.04.12.05.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 05:27:58 -0700 (PDT)
Date:   Wed, 12 Apr 2023 21:27:54 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 01/17] zram: always compile read_from_bdev_sync
Message-ID: <20230412122754.GE25053@google.com>
References: <20230411171459.567614-1-hch@lst.de>
 <20230411171459.567614-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411171459.567614-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/11 19:14), Christoph Hellwig wrote:
> read_from_bdev_sync is currently only compiled for non-4k PAGE_SIZE,
> which means it won't be built with the most common configurations.
> 
> Replace the ifdef with a check for the PAGE_SIZE in an if instead.
> The check uses an extra symbol and IS_ENABLED to allow the compiler
> to eliminate the dead code, leading to the same generated code size:
> 
>    text	   data	    bss	    dec	    hex	filename
>   16709	   1428	     12	  18149	   46e5	drivers/block/zram/zram_drv.o.old
>   16709	   1428	     12	  18149	   46e5	drivers/block/zram/zram_drv.o.new
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
