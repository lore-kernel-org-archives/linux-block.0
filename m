Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1D3C433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Dec 2021 03:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhLODdF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Dec 2021 22:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbhLODdF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Dec 2021 22:33:05 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F832C061574
        for <linux-block@vger.kernel.org>; Tue, 14 Dec 2021 19:33:05 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id i13so7923379ilk.13
        for <linux-block@vger.kernel.org>; Tue, 14 Dec 2021 19:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Uwm/hlzmnNXIPFT+EQgKwvN9+qm6zMRjD06gitahOQI=;
        b=4Udac/HnuW3NMh1q8GSYjyWaQ5sCCmgmguKGKwB99nzUaxxgda+bz4hvZlMHOPQK5I
         n1WfiumVeOMF5xk9Cp1oBe5pCC9xmowIZqF0tcfj/m2P7rZPpM1Ign1oXwNj1Q8khJVh
         Sc1Y9atQC8yPlEYbbz5DYdTZKTjH5F/Ry8x0ZW5zxLCnHqgyr5ekB6zHn0mbUPvD1d5P
         hoQ4DGV76taxQTIF4J8KTFTTu0Br9pdnkacPYbSbjkLyBYIeqXLxlK6j6iKzYFEo9xa0
         P2TguPBuU9kXKB3T05KNQpiqbXIO9vcyCa/T2zZY0Ht5xiXjt7R9ZAsOX7lGCHgvWmkM
         X/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Uwm/hlzmnNXIPFT+EQgKwvN9+qm6zMRjD06gitahOQI=;
        b=xhKrOBYedTXgA1rEjGxRfOVonFhtFba1OGo7TEWbkYnDgy8W5lic592OiD9EuRd616
         Lg8/no5Q6jvqBvxs7WiZe4HxEsb39rlGKNHf2aAb0LF0nHrytGKAIrWGmspAzU7iH26x
         4ymH3NXm9bZFtilRdZLPPOakO/t53bGzOAsHSuZln3FvN/MQ3mV8mdndKYKu1oDYf5V3
         me574ZERQZ5bmifKGwPMGWfhUJhJSXmKnvC6schivIbbrtd31l3xq1AngMRPwl6y7QFI
         usX4i/dKWXNLiL/uCbBBcnIGhcs0jJo806lCd1oow6YN1rKUCjVZfK5o+ikcUXfk2mKi
         Hhfw==
X-Gm-Message-State: AOAM530W7Oq4ysxdoOjSKnG8WRUbOsGTQnwEgdNko4Z1IAme3wydz0s5
        M8OD2aCJ7O80U+dCHGkdDAkm2A==
X-Google-Smtp-Source: ABdhPJzeRTk7nWudQe+d99R3a0qB3itFJaduKBXWja7krAdAyYc15N2vyw1KguL16J0Mts+nIXtRiQ==
X-Received: by 2002:a05:6e02:1bee:: with SMTP id y14mr5536778ilv.250.1639539183806;
        Tue, 14 Dec 2021 19:33:03 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j6sm405050ilc.8.2021.12.14.19.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 19:33:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20211112053629.3437-1-colyli@suse.de>
References: <20211112053629.3437-1-colyli@suse.de>
Subject: Re: [PATCH 0/1] bcache patche for Linux v5.16-rc1
Message-Id: <163953918150.250218.18311693877074536456.b4-ty@kernel.dk>
Date:   Tue, 14 Dec 2021 20:33:01 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 12 Nov 2021 13:36:28 +0800, Coly Li wrote:
> Here we have 1 patch from Lin Feng, which is a fix for his previous
> patch which already picked in Linux v5.16 merge window.
> 
> Please take it, and thank you in advance.
> 
> Coly Li
> 
> [...]

Applied, thanks!

[1/1] bcache: fix NULL pointer reference in cached_dev_detach_finish
      commit: aa97f6cdb7e92909e17c8ca63e622fcb81d57a57

Best regards,
-- 
Jens Axboe


