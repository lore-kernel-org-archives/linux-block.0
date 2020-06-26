Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35F6C433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 10:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5BFA214F1
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 10:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="eff8vhG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgFZKDe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFZKDd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 06:03:33 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4C8C08C5C1
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2020 03:03:33 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ga4so8755624ejb.11
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2020 03:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b9fA6cDuLKUl6r1JDk9GTL32fQwgnX5oPJIohbeJ4ew=;
        b=eff8vhG3tzimaUuyj2AvlVKfej3ITvGf2noj+At1SLQDM9K2Ej3gVxysb1vhjJ7GvI
         8ECtUApYQSdvfXIRNzZpB5Jc1/8FCluk/miHneqdOlM64FOLW/Yt9mEHxDgh++QUt1I2
         mXoJqtk47YMelP1z5ffnR5sl0w2qNzFikCWltgyKg3vEVEI7adMjfzxAzuawpSGnHbbI
         9r396j4HqTJ52i2CD54x5hdkNWieZIW9SmNqdWao/29h37QXOoDk9gj4fgDfFNzHjWKK
         9X/qLgkclR46IMS8wvbfzJcoN1UgmYHg7D7tdxeiwd2TDfmkIgdcsWi11bg62Lvd6l9f
         crgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b9fA6cDuLKUl6r1JDk9GTL32fQwgnX5oPJIohbeJ4ew=;
        b=N2WhKNbUuMiDjGG46tH5hAizAuTLYFcUMVWyR/3K9ZDavnR2Oj9zDo3+uFjcKAeA/v
         fqz6RcxutQ3Y0zbRnVbBmQy0kUK+MgJTjSodD5zW34nN0Hrjk1QX0MeYhvbln9zGDPvS
         aUA2WY/QeWuTygKI7AbbmciRfXau8rqVPC6+ozQzz7SthXQW7DAYqo7SOiACaBPh82hs
         M8fzKkjjYjvpuysr4Wsq8yjZpwNFRn750D67rQ2LCVfHWNBPgAN6jdkgfowwQsaz3pfn
         j6mWDcmEbSToHv5mA3WmSyuxL4s84ZlmhZG75agaI/RhS8J/nBXCBB0FyKvwT7MVn/P/
         MnHg==
X-Gm-Message-State: AOAM530txhkHEqGotMAlcDOF/fbXFoe8i+L+m1NtzlV7sABw7AIq4OEF
        5i5Xz6M1Hw1oyI4YMQ8KfBh47g==
X-Google-Smtp-Source: ABdhPJwjA0HKtW5RnAhXG2FNgUUlpUw/qdy8sps0dvxv//ta2VkfUp1OsYXy7XpvrQigkWOMocasnA==
X-Received: by 2002:a17:906:355b:: with SMTP id s27mr1962213eja.368.1593165812420;
        Fri, 26 Jun 2020 03:03:32 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id b11sm12032075edw.76.2020.06.26.03.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 03:03:31 -0700 (PDT)
Date:   Fri, 26 Jun 2020 12:03:31 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 6/6] nvme: Add consistency check for zone count
Message-ID: <20200626100331.x75kegnxutfogdoi@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-7-javier@javigon.com>
 <20200626091652.GD26616@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200626091652.GD26616@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26.06.2020 11:16, Christoph Hellwig wrote:
>As a bunch of folks noticed I don't zone_idx does what you think it
>does.  That being said I'm very happy about any kind of validation
>(except maybe in a supper hot path).  So if we want to validate the
>zone number we can do, just not as in this patch.

Ok. I will send a proper implementation of it and then we see if it
fits.

