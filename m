Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9CDC433EF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 08:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiFBIGU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jun 2022 04:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiFBIGU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 04:06:20 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E0D12099
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 01:06:19 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r129so2171706wmr.3
        for <linux-block@vger.kernel.org>; Thu, 02 Jun 2022 01:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=2lMhFbk+SdxLunWWYyO18vtZNhNfr1j57Vw9Dh2CY0Q=;
        b=C1nqFUbUznbngP3CiwRfGdD8/i57RqSmZ14UryXx71Tj8Soiiv8pZUCjQbVwOANBqB
         NY3PK4Ays/Q+xYi5QrJOsKCZOJ7hxj3x8ydqeOHZ6mItxOiyGB/Y/8mwvJ8spnkojadG
         5epWh9UOh5kmN/IIHdW5Z7QgMTK57bzbGtnLbm8tquFV5TmPuG3GQuwXRHrZj6RBHMLt
         Z47Rj4h0heeODzofvpcfIAwAO/0MI+Y3/a5DauH4WCZZ/puQSSrKanMs600gZ4TaWUfM
         4YXTuKkvxu8Lt2HRoStQxHiLtT1sDziqX0L0CBUMB1VxQMqW2j/pOKfKDqRyu8sPYziY
         n4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=2lMhFbk+SdxLunWWYyO18vtZNhNfr1j57Vw9Dh2CY0Q=;
        b=zdJn6LDcanG6aFb0Nv0Hlm0vOuf1RZYIl9YNzP3MiWq/bFhUnWb9E1Lw4gBj3WUEMx
         RF6/FCgYZAAOv0BmPVvtrMVwxczINYSEKztSAgkKpY4WJVvNEz+43XCEjMZdvBHGcfJy
         nY0h8ZyKqNsFNUgyMVN0G/APzVR+WxEyhPSQcgE2ISLTeuPl84DNGApTsNdeH0Zn2jIf
         yTh3T0+whBqWH3O2ZqPJ3Bkcj5jLPhZMX1pc8lJiqAQJDOJSoM3Phj28v4X64s/IH4wu
         xyJYeGGbmAGLJp4ifjs7S4jFCHO2XWmSINsBervfLXs4fhryPL/vunTtkF8y1E6GJXpD
         8Nhw==
X-Gm-Message-State: AOAM531bVQBXolh5eQK99HHqTb4cUxREwiFBPATLcQ8ikII6s3s6H1Vg
        8LVZ0USnpQt2+Qb7QDjcNGz+3edz3+cSFeFB
X-Google-Smtp-Source: ABdhPJzL3xsgYs/PdoNT5InIYHNwCu+nWtWGLl9y9BbP99jG66yUp2VpdXg2vY8WkxUSWU6SjAYQuw==
X-Received: by 2002:a05:600c:3843:b0:397:476f:ceb8 with SMTP id s3-20020a05600c384300b00397476fceb8mr31813470wmr.200.1654157177501;
        Thu, 02 Jun 2022 01:06:17 -0700 (PDT)
Received: from [127.0.1.1] ([193.52.24.5])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c4e8600b0039466988f6csm9819636wmq.31.2022.06.02.01.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 01:06:16 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     damien.lemoal@opensource.wdc.com, linux-block@vger.kernel.org
In-Reply-To: <20220602075159.1273366-1-damien.lemoal@opensource.wdc.com>
References: <20220602075159.1273366-1-damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] block: remove useless BUG_ON() in blk_mq_put_tag()
Message-Id: <165415717661.52400.6392351041659666381.b4-ty@kernel.dk>
Date:   Thu, 02 Jun 2022 02:06:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2 Jun 2022 16:51:59 +0900, Damien Le Moal wrote:
> Since the if condition in blk_mq_put_tag() checks that the tag to put is
> not a reserved one, the BUG_ON() check in the else branch checking if
> the tag is indeed a reserved one is useless. Remove it.
> 
> 

Applied, thanks!

[1/1] block: remove useless BUG_ON() in blk_mq_put_tag()
      commit: ff47dbd18b8db251fe1fd013a8fa067d381ecd5b

Best regards,
-- 
Jens Axboe


