Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB58C433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Dec 2021 18:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbhLMS34 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Dec 2021 13:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbhLMS34 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Dec 2021 13:29:56 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEA1C061574
        for <linux-block@vger.kernel.org>; Mon, 13 Dec 2021 10:29:55 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id g11-20020a4a754b000000b002c679a02b18so4389368oof.3
        for <linux-block@vger.kernel.org>; Mon, 13 Dec 2021 10:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=OQfqfHBorkemQg3Op3Fr065r8thOOBchLEx3yZjs8gw=;
        b=eppyazYyeeG0dxlq6Av2wm32ZOw1r7xUru1BvvwSZQfn+CV6ZueZGKZd9DddVWK8RE
         cIRDwc36ocMdWeHrnX2Nsnagm8w1qHzbuIjVOmI/JibBvfWFL6hgmtJtwoe/8s7yyt9U
         Pl9TdhkH/Stn29Td/G6xzHJgbG6pKOvtLBNql5eNlmTdjcLe4hrZpILWSDwTFeU7BS9n
         fyj8ASz4JwPdfIBFjyJxKUdHabLWCZRdaKJY2JK8h9SbBXbqAkUt/W3zdIl488ktsa5Y
         Sc0R7yagfKHRPF6Gdees+j4lhcUqdbpXJBNFeFOxf1nQjxkb3Gzh+gt7CoyhR2FTtOTY
         LqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=OQfqfHBorkemQg3Op3Fr065r8thOOBchLEx3yZjs8gw=;
        b=MDyk2GHO5WPiFOPN2En9Vrmt2cmTMnvT+I2ryhFqBVzg6HIofPjUEQMZu7a36ttCVk
         XzBUAybn4MvuduM+CiDkHxrTSjdhCt5AZ5Np1sw0cIN5sx+4Zcs4PynmrusBjBkbn6rZ
         ZQ5raOYTls3fLvyjb+wvh/bLF5tZndzKUKl2meAfz047gSUeunBWGB9wRe1oAt5jJfUY
         OEeGRNo4ajgWq731d9n5PzMhBV3gAeMlqfhTJBsGqJ+JEB6hQBHZON86/YDpr4Vhc0Wp
         mMxc6UfhIbTh0q/kG15IJMcy9W+3kcYlkIt23OoGIXTSKTzuQ7gga6b1oMvnUvrE4zH5
         j3+A==
X-Gm-Message-State: AOAM530/xUTTeE7P+FHLYi0IcclueMbJp4We8rx9su4JWw3KZ1Pa/c9q
        9puG6kSKwPixMQRyMtXQmKZp1qluhvHt4Q==
X-Google-Smtp-Source: ABdhPJxRBOMJQoCkLvvd574qdhJ5TzRITs5KJJo1hxOfobBDtnYjuf9olqyCWGEQlLxKXUdUx07S1A==
X-Received: by 2002:a4a:da1a:: with SMTP id e26mr61107oou.79.1639420195134;
        Mon, 13 Dec 2021 10:29:55 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u28sm2383977oth.52.2021.12.13.10.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 10:29:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20211213171113.3097631-1-willy@infradead.org>
References: <20211213171113.3097631-1-willy@infradead.org>
Subject: Re: [PATCH] bdev: Improve lookup_bdev documentation
Message-Id: <163942019456.141755.15623248313352598180.b4-ty@kernel.dk>
Date:   Mon, 13 Dec 2021 11:29:54 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 13 Dec 2021 17:11:13 +0000, Matthew Wilcox (Oracle) wrote:
> Add a Context section and rewrite the rest to be clearer.
> 
> 

Applied, thanks!

[1/1] bdev: Improve lookup_bdev documentation
      commit: 0ba4566cd8a4e645b542e6ddbe3dd26c85ad2408

Best regards,
-- 
Jens Axboe


