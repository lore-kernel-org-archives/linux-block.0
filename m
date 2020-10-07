Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEE5C47095
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 15:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2440A215A4
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 15:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="y1it3yQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgJGPen (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgJGPen (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Oct 2020 11:34:43 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0435C061755
        for <linux-block@vger.kernel.org>; Wed,  7 Oct 2020 08:34:41 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id 67so2782175iob.8
        for <linux-block@vger.kernel.org>; Wed, 07 Oct 2020 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ya7VWW85tr07dUTeRZTezqwQZIwntrhwkmNOB9LGjRw=;
        b=y1it3yQwwu+6/Q7iVX+3YIAgjmbQvFbL8X5O/fMg0DJ9tn6j9aI42HIpH/ufPPwLm2
         1C2qBNhTyjnvWbFbI7Xw3//PQSOrZjeMdrhap3y0GY+WMupRqKYYIIP1DZfqajopN9Id
         TQRqpOukGXGpYSkrjNpCgV2ic5YVS1Nu0VNUmxKqczot6ucPPfoEFpP1MBwKxjcMnt1F
         dbDoxMevsRqI6bJ32DsNUwHQRCBhcIyW1MoTPBBOi+pup8ED46YkDA3bMn3RRpgm8oSo
         7Luiqqejczur58QZgL/QJSZUKSQHQNfGjMO0AgzXMdVIqU0CO/dH1nsCVXDC3UMGWaXy
         irNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ya7VWW85tr07dUTeRZTezqwQZIwntrhwkmNOB9LGjRw=;
        b=JUXidkkq0D4/Po0z4Gjh6rXncfDqslzkBjhQvt69N0/MxGS9CYkr0+0+XXrvUjQWM2
         1Z/XGTljB2TjicovUkMqwL7cJT2BscIrPRbgZS8B1noyqNtIb8KcvAqfB/fo8ii20fa3
         z81kpQ8xCwZqqTTwCBSTqZZYuDTAS5JpMoEzOqjpW4fry0VAo1IQuIhv/L+FepRf72gP
         38ptiDjYtZLSXC0DpnvZw6uzv3YAQPo99cHQR/Mxis3o2jrZH9HhxzXdyjHxhFdXn9iG
         ABcbjYs3/BAV7/jo/t/IP5xzDwjnRSpEkSatuSuuA/2roIgbab5zyg4ZCFiX7kNznrQU
         A1Lw==
X-Gm-Message-State: AOAM53258AtJcbTt5bp7SZU407jUnhROgobvcdAIaVHAxn9mDElsRXoj
        g20nTQOZ1vVu3VAP+/hMqaTW2Q==
X-Google-Smtp-Source: ABdhPJyKFvzczFsef+5fwv+Ry0OVFkulUT/UILsWQHUOH/WuZS4OS4UdGvRuqGf2GscMXJAr4Mw3nA==
X-Received: by 2002:a6b:610c:: with SMTP id v12mr2788528iob.101.1602084880944;
        Wed, 07 Oct 2020 08:34:40 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x13sm1012910iox.31.2020.10.07.08.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 08:34:40 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] io_uring: Fix async workqueue is not canceled on
 some corner case
To:     Muchun Song <songmuchun@bytedance.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com
References: <20201007031635.65295-1-songmuchun@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e3333abd-6e06-60ee-a8f9-7b7c586484f0@kernel.dk>
Date:   Wed, 7 Oct 2020 09:34:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007031635.65295-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/6/20 9:16 PM, Muchun Song wrote:
> We should make sure that async workqueue is canceled on exit, but on
> some corner case, we found that the async workqueue is not canceled
> on exit in the linux-5.4. So we started an in-depth investigation.
> Fortunately, we finally found the problem. The commit:
> 
>   1c4404efcf2c ("io_uring: make sure async workqueue is canceled on exit")
> 
> did not completely solve this problem. This patch series to solve this
> problem completely. And there's no upstream variant of this commit, so
> this patch series is just fix the linux-5.4.y stable branch.

Thanks, I'll review/test these and pass them on if good.

-- 
Jens Axboe

