Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AE0C4332F
	for <linux-block@archiver.kernel.org>; Wed, 24 Nov 2021 15:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241458AbhKXPhu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241419AbhKXPhg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Nov 2021 10:37:36 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D480C061574
        for <linux-block@vger.kernel.org>; Wed, 24 Nov 2021 07:34:27 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id v23so3686889iom.12
        for <linux-block@vger.kernel.org>; Wed, 24 Nov 2021 07:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=O0pPz6NORKVpJQI94b+zF3BM6FFKjxZhA45X8ge6u1o=;
        b=EMnpSn2m7arKw4ROmXBJjA30k+dTLG2cl/3ZxrPwiVq1CN4UBb0KoP0l5y6dwLl2vh
         M6voIoF8NaErNeb2dWBfdSkEJpmx4FEil4tFOUJjZaSEUfiqBQfXvlRC8JZSW2IcpJPv
         9JeOb+tHE6c8vT06oAFbANiT7hR93O/0KytoG7oaGm7uZeUmYRnUc/JTmgHAgS4gEdiF
         rZCAzFdO5koM80aZdKBSz5l5mTR1Vey59zbV8x49UNxFhO1igKK8hPsCW6t2yGS3iDrK
         sG7X3STM+szYVlJLqogWwrQ3Rhmxz32Z1wazsN/vyUo01xEGntjOmjK1SgOcnWKysvBh
         7bcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=O0pPz6NORKVpJQI94b+zF3BM6FFKjxZhA45X8ge6u1o=;
        b=dbTCUVuQeU4udDmHkt7/2QV/YOHgeuIycUvfImTSfJz1K9ja16kHpQZeZGKeB9TBx0
         DVDT7wxAsBryao45xMkkCGyiensYbGphT0eq/5oKrNGPZi8SvtDJt+cZ9K9T9yTJyl8W
         0aKBryQE80lgsQuA7cjt41N+l1Jv+iYdsJ68JeNxuXHXMQOAyKGrnBaEuKxiqgH+zUIv
         JCmsaFERr2u5pgXNow3t5O6cKNE0wTO7KnCrAbbLFtu9thUyVpaMsyrUiD7s9/ZHLkUc
         zQKDxg++ADhj0a9JlFajn4iNAplO1MMSBY5hk4Ly3QhPAjWYgTjOmKcdoszsm22CrVlT
         +UWA==
X-Gm-Message-State: AOAM530t1g6ndmNhSORB7m0U1hq85ox9R/sYsAh6cifcpUXczN8761Aa
        1qQ7oJDa9K+xn4nIQhfHfZ3FSU0VM19Wp2Vc
X-Google-Smtp-Source: ABdhPJzXrE12fS9k7ji59SazQ8hvsITzwbvYb1SRwKu24iOo3muFI2n0TDbHd0yFmqYV4Uiq168y/w==
X-Received: by 2002:a05:6602:2cce:: with SMTP id j14mr15983071iow.111.1637768066191;
        Wed, 24 Nov 2021 07:34:26 -0800 (PST)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n39sm133139ioz.7.2021.11.24.07.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 07:34:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20211124062856.1444266-1-hch@lst.de>
References: <20211124062856.1444266-1-hch@lst.de>
Subject: Re: [PATCH v2] blk-mq: cleanup request allocation
Message-Id: <163776806560.461052.8476926440614820663.b4-ty@kernel.dk>
Date:   Wed, 24 Nov 2021 08:34:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 24 Nov 2021 07:28:56 +0100, Christoph Hellwig wrote:
> Refactor the request alloction so that blk_mq_get_cached_request tries
> to find a cached request first, and the entirely separate and now
> self contained blk_mq_get_new_requests allocates one or more requests
> if that is not possible.
> 
> There is a small change in behavior as submit_bio_checks is called
> twice now if a cached request is present but can't be used, but that
> is a small price to pay for unwinding this code.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: cleanup request allocation
      commit: f1880d26e517a3fe2fd0c32bcbe05e9230a441cf

Best regards,
-- 
Jens Axboe


