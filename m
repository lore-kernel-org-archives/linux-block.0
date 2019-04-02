Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F73C4360F
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 14:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0EE204EC
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 14:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OKHjYswT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfDBO5W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:57:22 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54068 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbfDBO5W (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 10:57:22 -0400
Received: by mail-it1-f194.google.com with SMTP id y204so5589974itf.3
        for <linux-block@vger.kernel.org>; Tue, 02 Apr 2019 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jebTAHP08RfH4DmgaplFZlGFtTmfTM7aVQG7/0I24CM=;
        b=OKHjYswTU6QEH/dXf26BIphpjJv8LOaYRH0fWjUWmqFU1reCdKtgvdg3LPRfm1mZ1r
         92zX3+1FBRQzRB/81OUWYHvN3rmtRL0lgEAltUNQgJUlARU1qR5DZ/dJuIHAFCTiTSpI
         61f8+1utJMI0jC+oTebxxD+X+SMbGfA0kFYvffj/QuU8eEyyvz762ZHNz90rSrD5ml9t
         XGNuAWHunDrsFnRzgYiJATtYk+EelJ9vZrXwgMrJQi3FJOdyGYGqr+dkcq7Mc55+m2ig
         HkAlMCTmKS/6byaKNCByxIYHOBh8GN/GVjwJJ6e5Ctw8bx+e1eOHkV2AsQBl3/6aPiKL
         n4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jebTAHP08RfH4DmgaplFZlGFtTmfTM7aVQG7/0I24CM=;
        b=KD7SpXaY3O/7FJ8Nm1IyyjKGJ+Hb6ayenl5N+N1jCYwt9NvIrbABzo/vYafymmht42
         1DWIiOfrwj/tksUkPq/1hgs3i3Hh8zfrA/VAKEDhyoBgu5sth5527RhtJ64yGoq3fNwb
         brcBe4r3lAUfgutUXbsmAt4+apSoc3q577EffBe4gGLzKVbZCUO1/hasg0zj4Fs3pGv8
         lPIcwztP1Mfd+TO1tPn//3BjqYWToEUe5oai6InSEAUR4uwmLanouYkJhBRWI+rQ5cLG
         +JvfNidEcEEHbc/kuktyICz3uILQfZ5DAwZJOVo7/coNddjGN/NsPeQPR2Jb0M39sL2Z
         GIzg==
X-Gm-Message-State: APjAAAVb7t7X5K31c6296SJt5avQ2g/j3Hd/ZGMGBWqowyZSqNUpStev
        a5VYM9ZD8XzytfWCH0WoTnilpg==
X-Google-Smtp-Source: APXvYqxZRPh/Ic3PImpUOlcd1kIOrr94lmS0jdazp6uaqI2kArfOMhqxUbRUIlzS9c6aUtR2Zzc1zQ==
X-Received: by 2002:a24:160d:: with SMTP id a13mr3431319ita.4.1554217041358;
        Tue, 02 Apr 2019 07:57:21 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x187sm7182830itb.39.2019.04.02.07.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 07:57:20 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: add trace block plug and unplug for multiple
 queues
To:     Yufen Yu <yuyufen@huawei.com>, linux-block@vger.kernel.org
Cc:     hch@lst.de, osandov@fb.com, ming.lei@redhat.com
References: <20190326131925.60255-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <19214e29-b153-0a9a-a381-4418c391ef12@kernel.dk>
Date:   Tue, 2 Apr 2019 08:57:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190326131925.60255-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/26/19 7:19 AM, Yufen Yu wrote:
> For now, we just trace plug for single queue device or drivers
> provide .commit_rqs, and have not trace plug for multiple queues
> device. But, unplug events will be recorded when call
> blk_mq_flush_plug_list(). Then, trace events will be asymmetrical,
> just have unplug and without plug.
> 
> This patch add trace plug and unplug for multiple queues device in
> blk_mq_make_request(). After that, we can accurately trace plug and
> unplug for multiple queues.

Applied, thanks.

-- 
Jens Axboe

