Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFECFC54FCB
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 15:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AAB1206D7
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 15:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Klbfv0Hc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgDXPQt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726698AbgDXPQs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 11:16:48 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DEBC09B045
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2020 08:16:48 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id s10so9566131iln.11
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2020 08:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ii84ODBLOlg7R0dv0d5rn+zaUzVvfR8wyPfdA1xejXs=;
        b=Klbfv0HcHJWYASgkcLN4EuljsY9jczaziUlf39Lg2NTiLxl/ftYWNMUmWwCa9FyeWf
         g/iToqV/G333SaUZwgnFYrRS/vy9IqM//tWP7Uj9EUoTs8SUi5o99xeYCfy3jH7pLYsU
         Yvc6gaIQvbkpXRthRhF16weOX+d6ulY1zlF4wTQ5CLKcFJp1eHWD1tOJIvv3dIJ/4l8h
         BsMEk4qx+u0WaXDFbV/xpAwhjse7smnHIr8MxE/9wouEg1ivb28xhyeOrNcbkRgd+goO
         3O4e3V97aopjNJbSKXzR4cdyvfCUsAd/x2NNCj/QNwHqGsPgOOBx/hG48+78HwDZtAqp
         +Wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ii84ODBLOlg7R0dv0d5rn+zaUzVvfR8wyPfdA1xejXs=;
        b=uSlrTGjH84sBZJV1mD/vpUzzgKmVbgARZxBdnedekvsOrm58Di+xXxXkh3g+YD5Bu5
         5HZ9Hd5VZtuR6yM9VImMdNcLH44jHUG8QeQRsGBpt2Ur3uPX7X1YZx3gQyI2GaWRxRL7
         bKRV+f2kuGNywzR5/aaR+ffpzyDnjeyc8xEVhlXwVJfsNTbZ1aUJTtmZSBZP1CTsenYF
         npn7aHBjWHTekVEkVuYkLfAORf2ILjmvuu+syqlfV9vYVMGbmcl6vphD1sbOU76KxfnZ
         gG5W/0z3P94qGl2Lt/vCoAEz/mE7oabuPYDydk+iHLTCzhe5deGJVMCryCC1enOEjk+W
         aTAQ==
X-Gm-Message-State: AGi0PubVFXptpkX/etNjZyW9hyRg6x7YbAp7jITfYjaS64xir1vcWtEs
        ZVXHt+QW/yS6JlHmEWGNX6r48eDgrvzY/A==
X-Google-Smtp-Source: APiQypIKwgV4GSml18zRPUai3BGf+KZ9FZOLyEDgjrYXvSBZ8F7qZ0DbaRUU9SzDOZZ7v4e1in8MDw==
X-Received: by 2002:a92:d44e:: with SMTP id r14mr8876940ilm.244.1587741407603;
        Fri, 24 Apr 2020 08:16:47 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j5sm1902253iom.22.2020.04.24.08.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:16:46 -0700 (PDT)
Subject: Re: [PATCH] block: unexport bdev_read_page and bdev_write_page
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20200424105634.570597-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <73eb83e6-e7e3-784e-c316-2f2fe3f7ad40@kernel.dk>
Date:   Fri, 24 Apr 2020 09:16:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424105634.570597-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/20 4:56 AM, Christoph Hellwig wrote:
> Each one just has two calles, both in always built-in code.

Applied for 5.8, with typo fixed.

-- 
Jens Axboe

