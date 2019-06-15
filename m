Return-Path: <SRS0=HzVw=UO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE60C31E47
	for <linux-block@archiver.kernel.org>; Sat, 15 Jun 2019 07:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEBF2184D
	for <linux-block@archiver.kernel.org>; Sat, 15 Jun 2019 07:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TtlfghLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfFOHq6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Jun 2019 03:46:58 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:54568 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfFOHq5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Jun 2019 03:46:57 -0400
Received: by mail-wm1-f48.google.com with SMTP id g135so4453081wme.4
        for <linux-block@vger.kernel.org>; Sat, 15 Jun 2019 00:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sa6UnnA/U84OFA6hrhWdVHqFPfLzbLKoXVimXehYFE4=;
        b=TtlfghLvaw3bkTQc8btWmwE+eW5HioLBPwuumJkr4MUQnBiwwLZq6HHulRBD6d2KSj
         +OyvCVDc6DnG0rMxkZAkRHnQSx8mVj6w4613RHXDwAKwVjWzUlTxl0qSrjPDoKsa4rRw
         VQq4mtebO7peHi8uHnhbggwDrHTrVX/0I1YDDvuiMl2r9foow3/flcxtvylfpamNAtS7
         AeGTjN18lB4/+xktjcUMqWJWT6h44gZmDyOWXY/LrvGkr2KlyS3psPQsQxmHrqanrug7
         S2L5iyA8P6AQYcAjqyiQqONbsJ66iazw1eA6lrA1mIDyHmQeKHPhDJNUpBR41/H3pCql
         cV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sa6UnnA/U84OFA6hrhWdVHqFPfLzbLKoXVimXehYFE4=;
        b=EOCUCoWCLmKtmOvFDAMlCYNvynnUfPuwQ/vaaxpM3J9PzhY9gMEZ0V0eiqnRdHioix
         LjD/Lq1ttHNlRKVI5OK+vxf1qT3muUXnx7UVasEAz58B9+Wg6Fvq6gPR0VLKhC5Ozk7d
         +WhshTfFtqTgoW07qfEOolsRNXnIAHAtMk+s8Yef+5pzrLtvaQFXYuXoFsqXGrq7qyAy
         5g8vQZx5uS/ffx325WI0VpcngvTPVYJ+wT9dG5DJ7ygQhOM2+vM0pBJltabSyZnlmY94
         KevlolL44kdSuXP8mt63e7lFAODGr5MCmpOgy+RPikSxa/EIrn7AN2PErJLQgUOLLLcP
         V5Yg==
X-Gm-Message-State: APjAAAUIp0WZLIbV6zV3JBLi6KyN507q4eurHLQigHPvKEAj5Wphf7mn
        rRHxnq88ZEOwpQBVotYrr10UxA==
X-Google-Smtp-Source: APXvYqzuwBXBhQ+5KslugzKdfR+CxtJ7cA7mO5un/KisvV8H5UV3/KDzQ1j649g+v2RrgMi9hczMNA==
X-Received: by 2002:a1c:1947:: with SMTP id 68mr10754093wmz.171.1560584815596;
        Sat, 15 Jun 2019 00:46:55 -0700 (PDT)
Received: from [192.168.88.149] ([62.170.2.124])
        by smtp.gmail.com with ESMTPSA id f21sm4477839wmb.2.2019.06.15.00.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 00:46:54 -0700 (PDT)
Subject: Re: [PATCH] block: genhd: Use struct_size() helper
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190531184754.GA26040@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7cc1ada7-52eb-eb18-c56b-0b1e47cf1530@kernel.dk>
Date:   Sat, 15 Jun 2019 01:46:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531184754.GA26040@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/31/19 12:47 PM, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes, in particular in the
> context in which this code is being used.
> 
> So, replace the following form:
> 
> sizeof(*new_ptbl) + target * sizeof(new_ptbl->part[0])
> 
> with:
> 
> struct_size(new_ptbl, part, target)
> 
> Also, notice that variable size is unnecessary, hence it is removed.
> 
> This code was detected with the help of Coccinelle.

Applied, thanks.

-- 
Jens Axboe

