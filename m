Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A21C76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 21:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDFVWM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjDFVWL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 17:22:11 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4536A26C
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 14:22:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j14-20020a17090a7e8e00b002448c0a8813so2511913pjl.0
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 14:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680816130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZA0BdPl1q+ppnZw1kRKd2aosoOl3sA4W9g6MiQm4s0=;
        b=OUOkfFMzCYf6/VfPvtolBfsHffyve7PKuXfPkewwh+zXV6JN9VLSD+9vlBYXeE6QZ2
         WNEVkcErU3R5YIkX0iuKH0dqWfgdXNmvQVJlcXJzVyLsga1XVLiPYD0UYPjPE+WgFocy
         30tBdMZHBUNjxMBkludrBQDcxAWfuw/QIgQuheSlkTsUCAUPXxHRzN8dDkB1kbIngTvb
         ENKx6LtKYvlHW1zCEZCTvz6lVzEMUqXyFzadxNRs+vQE9K1IsVZf49vdREuXxMI5FwRm
         QwMmS5IPZb2Ad8yfplZSvp9pCs7V2cqB1X0QsBuFHEAUiujjpth+Adz9XExOzgHOxR4K
         bw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680816130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZA0BdPl1q+ppnZw1kRKd2aosoOl3sA4W9g6MiQm4s0=;
        b=Gq9jyNlHh6aRP9v5H6OlTWav6yeavNHWj2THtwkmqwWjAQyiN7VJQ7WOw82X4PnBoc
         5tHeNVHrg+u67NNCTKoEabTgbbe3Zit0xqinALFPDn0K+SiXDhJOIt8TelLQH54SIEbq
         so2qDRXR6lBlLyJaLChj6NLNq17tuydPpsjFrzMHYLgNSIH4Aty/x/E0LfmMRNKDaeTV
         Z9P9l88JotWEFikoWdkVJRCDERr/1bcPbrh3awx3XDr4Kibr9uFCjHTms9zjYqLuKB0s
         8RCh1u/d6Gpc5EhUdKLhinxW612w++4FLUAvSxXxXr/p+tmoB0O4mL27FCrsuL437D4M
         Xfkw==
X-Gm-Message-State: AAQBX9eZ0IOosYlK+GKnRX9uxkTowa4hEuZw64Hs3gWajCmQE+hjmKdA
        uUj4t0fUJ4Ix7gMQyHxwQek=
X-Google-Smtp-Source: AKy350bgS4hsxixkibfP2zwogQYYZH8brSqLVQIY+pVRuhU4soOErwJQWZ1I0kn25cc4KQayzin/ZQ==
X-Received: by 2002:a17:90a:1a46:b0:233:e305:f617 with SMTP id 6-20020a17090a1a4600b00233e305f617mr13183272pjl.32.1680816130208;
        Thu, 06 Apr 2023 14:22:10 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a8d:6a82:8d0e:6dc8])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090276c800b0019908d2c85dsm1785939plt.52.2023.04.06.14.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:22:09 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Apr 2023 14:22:07 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 11/16] zram: don't pass a bvec to __zram_bvec_write
Message-ID: <ZC83/5E+JTpUUlPr@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406144102.149231-12-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 04:40:57PM +0200, Christoph Hellwig wrote:
> __zram_bvec_write only extracts the page from __zram_bvec_write and
> always expects a full page of input.  Pass the page directly instead
> of the bvec and rename the function to zram_write_page.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
