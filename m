Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDE9C4338F
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 01:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784CD60F23
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 01:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbhG1Bj4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 21:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbhG1Bjz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 21:39:55 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53906C061757
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 18:39:55 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so1891514pji.5
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 18:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=svIq3M8HhmjOQFHJQVWbDLjaKokejNdfgbcRMVtQl6I=;
        b=OkeYqPnbSWWqVhkH3XroWcXMPLjvBpzL07PshovmwhHsgpcjHE/dwBaIT57dE6cguD
         wfacScli3WcozLzcK7oOWYp1cr/cauCMt5zOXwYqVRt/eld6koC6z6wzTDj39ILXyPCS
         u23uNSRCr3BshpsazezRbAAOpEcuTo8HlCD56SiPr0Udvm6yJpoh2jxr+RZqZ4gVGrqy
         1vBIFStGTKz6wxYTBJ2r6H3qoqNNCw0z9s03i+NhcuItRBiexi9mFZR1JGLFD5Ja/uhq
         2zgF/R88YiIs7q+GTZojmm1iimQe8VX81QQiSrtBWxMuc6KPQQ0HvH88ow1NF18cMW+z
         FPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=svIq3M8HhmjOQFHJQVWbDLjaKokejNdfgbcRMVtQl6I=;
        b=VBy45KjvR4sasyOJ1YAJyNxDGZS8ebs4i5gg90eBxykufRg4PPWb0m8dQAeCGocM7P
         Fshf+SJ6Z2yUZzX+Imx2VtRs6mxVDqMCfl2WWwmN9BcqpW/PC5SuxgCU7+gNFJ7/puQ6
         r8ZMaZS2tOZUmcQXoxQ/IMu+enOkImUJilBKp8z57h6zREU3NxLP6nkFsmfX0aLT35Ib
         i/34OWHcnlanmKwXJLqzkbfhvF5M4cre83n9+Exc/2BMbAxwG0tmHkP9UNxwLsn7y0Ko
         4ASezOgmM/UROVPXwMjJ2hCkJhh8x6qSCPfjEixFgYh+znRdZdz2V2iTczyz7gcv9CfJ
         Lpvg==
X-Gm-Message-State: AOAM532wEAP4ULFw7GlFr1dOdtY8X4/wDqUnbUfzK0RBS+Hdp3DKL7kQ
        cQx6Yr92GIFYdlz96aTYwHFyVg==
X-Google-Smtp-Source: ABdhPJyJLwNyRctObcxyK4toXEaF7zEJrs1ztdt1iDwWMOxEFMftiOxaVnTlS6RBmwQHMU92F/6ihA==
X-Received: by 2002:a17:902:a587:b029:12c:3265:26a with SMTP id az7-20020a170902a587b029012c3265026amr8666756plb.34.1627436394755;
        Tue, 27 Jul 2021 18:39:54 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id p11sm4131248pju.20.2021.07.27.18.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 18:39:53 -0700 (PDT)
Subject: Re: fixes and cleanups for block_device refcounting v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20210722075402.983367-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <23d8cafb-413a-8feb-a2c7-601783d18706@kernel.dk>
Date:   Tue, 27 Jul 2021 19:39:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210722075402.983367-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/22/21 1:53 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series fixes up a possible race with the block_device lookup
> changes, and the finishes off the conversion to stop using the inode
> refcount for block devices.

Dropped the btrfs patch since it's in -git, and applied #1 to block-5.14,
rest for 5.15.

-- 
Jens Axboe

