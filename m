Return-Path: <SRS0=bR5W=TJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268BDC04AB1
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 14:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71D221479
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 14:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="grrJQz5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfEIOKg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 May 2019 10:10:36 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:40029 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfEIOKg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 May 2019 10:10:36 -0400
Received: by mail-it1-f193.google.com with SMTP id g71so3538259ita.5
        for <linux-block@vger.kernel.org>; Thu, 09 May 2019 07:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2MvD8DryLIpLwVzTpnmpOzWgcT82OOPN0LI9RI8QX0s=;
        b=grrJQz5juTNtlPRDDmOfM+aeVXtfqHebWe8z32utvg+8/3PPqjenzAmcaE58Fxom24
         iscPBei9O7ViuAgOmi8QyvMYf1dGFOpGoTMLmfRFTOHtSIGLTZhCyV8QwjMwxqqcPuV/
         //EsN337NeeBtIO3Of2tkADIxF49Cucc5y5OZkUNX7J667VaIC+tmbJBcfEGTli2sfVc
         3bIcyaS0FUvrsLpSXRv1rZhI7dlMO3VVzA9JO6fWnkWjOJRWMif2cTbr4/+LZaOuFxSq
         4bFtEOu7cYinZD7vWGXIUZsDVLQbjI4G17W6nShdd5Rh75e1uAjp4OgxYme02IG0g9I4
         hdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2MvD8DryLIpLwVzTpnmpOzWgcT82OOPN0LI9RI8QX0s=;
        b=hZ5boXAHKCbtqxPfXORoWzi2nK9pv9nHxc1CPBV/49CnmT4MMOeTYfjIm98n2hPPmM
         /gT13LUj2GrUzNudG4GFJvhBUlrxchmp46Ye+lBX6IUlTpIShkmIn4WRUEAtjcuFfGwZ
         is6iyquKIk+4NVV96VVBGhT2LVW72ij31vBzhVmgfwEZGG7w1RFICFkxZ6YESKJzi91O
         VQf22z07WNqhG1B9mSJhK9aK3zHZJwP7CpVYOFu5YHDrWeNrLuEijTUW+pYGvQ2w1WRb
         /lP+u+TAwKr5pn4p09BdrDsMqkucWqrfsAUhFc4727By54u152uTHxoDejUYKUxwtUcC
         6XGA==
X-Gm-Message-State: APjAAAVu36hKZE46/siy8DqXYlXQZOnlr6atxp5Emn/yi4E7QqcelWl0
        lRAWcXkbqHRgCYOkkfxWmo/mAA==
X-Google-Smtp-Source: APXvYqw7M1dZQzp6R3dXST4qEq3rSCHFv5ZyprN64n1607YrgbcjC+SHHfxkkDvp8FUJT/oKSuSeCQ==
X-Received: by 2002:a24:8602:: with SMTP id u2mr3526731itd.101.1557411035140;
        Thu, 09 May 2019 07:10:35 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j8sm939892itk.0.2019.05.09.07.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 07:10:33 -0700 (PDT)
Subject: Re: [PATCH] s390/dasd: fix build warning in dasd_eckd_build_cp_raw
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-s390@vger.kernel.org
References: <20190509100314.19152-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <37bda439-1c86-0fb7-31c5-cf6be6625546@kernel.dk>
Date:   Thu, 9 May 2019 08:10:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509100314.19152-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/9/19 4:03 AM, Ming Lei wrote:
> Commit 72deb455b5ec619f ("block: remove CONFIG_LBDAF") changes
> sector_t to u64 unconditionaly, so apply '%llu' for print
> sector_t variable.

Applied, thanks Ming.

-- 
Jens Axboe

