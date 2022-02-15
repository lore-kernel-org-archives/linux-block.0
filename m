Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F46EC433FE
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 14:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239463AbiBOOwr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 09:52:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiBOOwB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 09:52:01 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BF6E8F
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 06:51:27 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso3129131pjg.0
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 06:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=PiaexTOVj1kI0uL6ZsvyzNlPj9ZuaDgmSrk+RgXrs9g=;
        b=cW7uP6TcoJVFoj2ICvdlMKpKbTkU2PYO16L5UOx+wDT5i9Gvg6kR4Jy80AM/I4bg7T
         RZsqA7Bzeqfm4N+ApkpubDQ1BOhEjyLYmhwgfiqMe5AaEsHPEvYTiciT5i2Bvjys/JnQ
         TmWXkO5VtCyYdccUv7G5UK17rsII924N8wss/Yn4Y66ZPnO33krKbkw8Ycgt9dDQI+/N
         wu2/xkUEv2mO9cOIdO2L4JhILmFP3N2rwQg5K7f4jIkz7zzufXr6IY0JWokO9m57+wMo
         RpR9sRWDl18UJPmWbVzfykzqwnhWL9uLoShYmctMwB7o4C0wkL9Nk9EssLjsd+ySsSRa
         3APg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=PiaexTOVj1kI0uL6ZsvyzNlPj9ZuaDgmSrk+RgXrs9g=;
        b=thBWKMzSbzuRartXCMjc0HVMKXFLR/m1+Jcq+4CKYIzpLbBrJn6agq9ootwksROKqY
         DBju7vHFBz5aOf2mRW7iSvri3vmFIsbo6E8JWJVKLjhvMPYuQQqyHIUpDZG917BktYd6
         AHDdiFJgHmD22tYaeYhRubkG39uJsDhBk5ClOAU9u8ebQIMRGsdhtsqI2sS/CSHZwN92
         ABZIG9Mf/HEcCg3q/+dJ04fcWmsQS8OmkN1DC/kzeIUvQbVckBh/1TcXgHvNm61dp7Qw
         HI0SXbDn3sobfyBCV+rA0YcxCWPdxtHoD1++Uv6y9jeMQRGMFJD+HxQmbeDz3BBEnmQA
         DyZw==
X-Gm-Message-State: AOAM531kLiqA4WFR1Epp+i6pUoSjWeqMtq2M39+E5N8J+0hPHbqcUI/r
        62GnIxmunNmvVUN29bO9TcCsc+GvJ5Lbbg==
X-Google-Smtp-Source: ABdhPJwxVKNxkFav9IaTkwC4tkMi0Vh8pyZki8Up1GuV7RXnawTJQZZl36EAlmv1uYha/WRhoOqFig==
X-Received: by 2002:a17:90b:4b49:: with SMTP id mi9mr4799019pjb.110.1644936686147;
        Tue, 15 Feb 2022 06:51:26 -0800 (PST)
Received: from [192.168.1.116] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g6sm20205666pfv.158.2022.02.15.06.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 06:51:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
In-Reply-To: <20220215081047.3693582-1-hch@lst.de>
References: <20220215081047.3693582-1-hch@lst.de>
Subject: Re: [PATCH] block: remove biodoc.rst
Message-Id: <164493668337.128173.14057134922082895389.b4-ty@kernel.dk>
Date:   Tue, 15 Feb 2022 07:51:23 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 15 Feb 2022 09:10:47 +0100, Christoph Hellwig wrote:
> This document is completely out of data and extremely misleading.  In
> general the existing kerneldoc comment serve as a much better
> documentation of the still existing functionality, while the history
> blurbs are pretty much irrelevant today.
> 
> 

Applied, thanks!

[1/1] block: remove biodoc.rst
      (no commit info)

Best regards,
-- 
Jens Axboe


