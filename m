Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CB8C31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277EA2063F
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BEOrvrAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbfFMPwj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:52:39 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35646 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731637AbfFMJJd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 05:09:33 -0400
Received: by mail-yw1-f67.google.com with SMTP id k128so8045768ywf.2
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 02:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I2G6Z61Jyoq4eHQAlfAivrsm4bPEBXSycU3PSdmKD3c=;
        b=BEOrvrAllJlgLye4RFRyp82Ry/5b12FiLvgvqeLjUP0OeyMbkVjphwIi0hjfkSn3K9
         xjgNkqPSyCd1txp9qiMymZUR2TA03nbvNZtcZnYPHZipPejHYF3ESYKCb9+jjqBzsyl5
         poPWiJPd3tu6tDKpEURh0slrlhpdM1Phx4eUvJeHSUa0JkRp9JfZRc16PrDXoOfKYCQH
         svUTAUZLdoi1f+wOidpMtjFeZ5txG4c4APi+jAsN5lj0NZJGhk8WDmhnRS53/JCVWmj2
         YG6YdmF6agcVK+/l+GzAwpT5jiaWcTs6xfxWD/1kcYELMkpdx6lypsLxySlU9rPUmX/B
         P9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I2G6Z61Jyoq4eHQAlfAivrsm4bPEBXSycU3PSdmKD3c=;
        b=b7peuxw5nWC0b2vquRuzxqXAA/P9d922yBVBJiTfwl4XiRsmp5VS5i3Sbv1ab+wDnm
         4903xRnJAsgmOL5VS+ixWygIgzyS0CtkoWrCWjEVEvYfy1bQ/mL+dpu/fccl9wYWNTMN
         WYBOhJFcPDCEijiCWEzht6qwUztGBhPsKJldirZ/Wx5jbrFf+zGZ4RwSzX4c3bHQj9gj
         gPrqgcl1aeXyZ6T0s+qyaAbi6Z2FGEbMbolhumhm69BAO9ZLS6eJSj/t3QNCf7bC0iDA
         5TeHfRd9znbEGZ09UTA2iYfoVCkr5uSvydoi5Rl82SvWRg7c+Z8R4Fgcaila/rbTKlSQ
         m4zw==
X-Gm-Message-State: APjAAAWidaZ+sA++6kqdkb8eOTr61OvhxOzd33SuYYQPbjHIsmcMCZPk
        3nL4OkJZqpQKy9RGr56q5JMnOg==
X-Google-Smtp-Source: APXvYqwSHFGr3kSToQZDrgRpOoOeojYZKZNmb5DDY0s4RCXOutEi7OxzS9r8u5+ecnrWkLOfV4LiBg==
X-Received: by 2002:a81:a18b:: with SMTP id y133mr34060650ywg.239.1560416973175;
        Thu, 13 Jun 2019 02:09:33 -0700 (PDT)
Received: from [172.20.10.3] (mobile-166-172-57-221.mycingular.net. [166.172.57.221])
        by smtp.gmail.com with ESMTPSA id x85sm1123231ywx.63.2019.06.13.02.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 02:09:32 -0700 (PDT)
Subject: Re: [PATCH 0/2] bcache: two emergent fixes for Linux v5.2-rc5
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        rolf@rolffokkens.nl, pierre.juhen@orange.fr
References: <20190609221335.24616-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d90c5b6a-f55a-abeb-fa2f-19e3d0e3b42e@kernel.dk>
Date:   Thu, 13 Jun 2019 03:09:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190609221335.24616-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/19 4:13 PM, Coly Li wrote:
> Hi Jens,
> 
> Here are two emergent fixes that we should have in Linux v5.2-rc5.
> 
> - bcache: fix stack corruption by PRECEDING_KEY()
>    This patch fixes a GCC9 compiled bcache panic problem, which is
>    reported by Fedora Core, Arch Linux and SUSE Leap Linux users whose
>    kernels are combiled with GCC9. This bug hides for long time since
>    v4.13 and triggered by the new GCC9.
>    When people upgrade their kernel to a GCC9 compiled kernel, this
>    bug may cause the metadata corruption. So we should have this fix
>    in upstream ASAP.
> 
> - bcache: only set BCACHE_DEV_WB_RUNNING when cached device attached
>    There are 2 users report bcache panic after changing writeback
>    percentage of an non-attached bcache device. Therefore I suggest
>    to have this fix upstream in this run.
> 
> Thank you in advance for taking care of these two fixes.

Applied, thanks.

-- 
Jens Axboe

