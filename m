Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E85EC63777
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 11:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4F04206C0
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 11:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVy3/Lj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgKYLeK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 06:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgKYLeJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 06:34:09 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D7DC0613D4;
        Wed, 25 Nov 2020 03:34:09 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id u21so1771662iol.12;
        Wed, 25 Nov 2020 03:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XEVAGgc1H8aZ7MF4cFynboZTtpjAI/xfJxofgXBhcV8=;
        b=fVy3/Lj5IgzYjeT1ItrRJNcDqXCJk6601IRAVCG4oegjDGExpYR5ot6zRK2swOtHAJ
         J0490qm5feyprosfJJrxvUNwYCj3xLh1ffPrUqRMw/8OncDgweIfix6uhNzlOMGY9/JO
         AyXP8mYP5jwAk9BeFFlXcWGK/wRyc3KlSSK1vl06u7rDt+QEGamRjGIsHEq+JI+ZZ0Fr
         NDBJSPheIG1YidJN0sUKaREUZ9yhqNFC4cm66H5prR+NX7LZDRGw95jD69EokbZjseQA
         7XVmFLy+75jY+ZDawNZHsjnJQQkX1FkbfWTvpBWKAT74uOW13bfD0yQG5tSEwzvC+Ipx
         WYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XEVAGgc1H8aZ7MF4cFynboZTtpjAI/xfJxofgXBhcV8=;
        b=MDRHGL8eggfsR6o9tjaJRnxK0r73f+QNt2upk6siIuegluce5RcdJHWpJIr9yR4WpO
         R6RzHY0nnNRO4V+NgIsbScm7Kks7JaVCGQ+cl70JPpXOvZYdQDfBVU6plN0A1M3hH6s5
         /SO7CvM2DhCwWwXnmfmDmIaLWvkjiV7FBZFSS/WHP79U2GhspUVNFNSugbDLlOJ+3rY7
         Dt1Lbw5JcUstExdH1GCUmSzWSsLJ1M1TT1mjkcKJ/kwy5CHCKeDD5+2pg3HL6Uu6DgyV
         eFjefdFRDC9rgXwcyHMcTvdBor8PoHuXffTtUke/cgtUKlYUYcBocucF5B5rRTXp9y+W
         gjZA==
X-Gm-Message-State: AOAM531FtFdH2KV7dTo2r/a0utY8hZ15CMg4ep61Sbm/qwbbEXu/ZgJH
        RNhvH8o/6gPvJhUUG6XJQ1k=
X-Google-Smtp-Source: ABdhPJxHStYcrgcSEqgjYtKsRYxaUG5a7oJDHGMz456/mXbmfm/zrrwvIg/mILkVbXSATM3M/SDb+A==
X-Received: by 2002:a5d:858b:: with SMTP id f11mr2220240ioj.0.1606304048946;
        Wed, 25 Nov 2020 03:34:08 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id n10sm1026771ioh.22.2020.11.25.03.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 03:34:08 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 Nov 2020 06:33:46 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] blk-iocost: Just open code the q_name()
Message-ID: <X75BGjo8B1fgKwui@mtj.duckdns.org>
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
 <3bdc9526ac839a6952db8cd50cf0e75280614b1d.1606186717.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bdc9526ac839a6952db8cd50cf0e75280614b1d.1606186717.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 24, 2020 at 11:33:32AM +0800, Baolin Wang wrote:
> The simple q_name() function is only called from ioc_name(),
> just open code it to make code more readable.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

I'm not sure this is an improvement. Either way seems fine to me. So, why
change?

Thanks.

-- 
tejun
