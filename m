Return-Path: <SRS0=T+5Q=ZA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D1DC5DF60
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 16:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8293C21882
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 16:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yiW23nuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfKHQ1u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:27:50 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44000 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfKHQ1t (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Nov 2019 11:27:49 -0500
Received: by mail-io1-f66.google.com with SMTP id c11so6962531iom.10
        for <linux-block@vger.kernel.org>; Fri, 08 Nov 2019 08:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RiIe/nW+9AsCJyMreIOc9BvirXBLZtzkTWUj49kdOWI=;
        b=yiW23nuA8TdhuuIrPqsnDodwAfZlz7kLEuj1pDzBF778A3B5Pri8hlJ+VYcC16b6z7
         0hfXRCpRdcfNrWPLjHrAaxZ2qEDn8qMMaIvQ/5fOfR48fHI2qUnwlD0zX1ctDcmo30Kg
         bFz8oQrg3pL89wBAb0enYPVHRJ/klENw/8POBBLGoFPn2sv8ZPfTTlwg685l8ZGN2XLt
         WaHIJJmzPx/q5QKVcZSFYQd0fRgY03/ZuEZ6c+/Ev3Ks7ELhbvgbFeNrMjrlmBN7AEKu
         NIz3ipy6kdnoXPn3akIMnGDjNXhlht2ZIIEK7C34P/dKZafL+iwwLw5OaL0En/vaR7Xw
         xqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RiIe/nW+9AsCJyMreIOc9BvirXBLZtzkTWUj49kdOWI=;
        b=VxWd52XLDM9EVrXIodIzG/ouJTrgDuqZniRRHASouqLI2Pr5fD8YweZ1bb2OEE6j0I
         N8ZKJpgXjdshXQbupHIj/LGcfvFJWf+H3Z7tqTK/B79Qf/iaoflNtyyE8FHI5yzTeZsZ
         VmSWhcRJfOaX8J2PIqc7tHxPy3XHnqncwVKrt9Lbrm2H37OjrTOeU+8i0D1AXpb6AUio
         1y2Kk3UfKVFNNmLsWYP+ghdjhCgKCxLfG0fBg9yd62QolnYPZZz0q2wXUPjRiG2+1sh1
         W1qGfWYhykLgNJuz9TwcPxSZpAKaX5/fwtfjhIr0BJh1iuPOp9V5YgvgH6mJxc2/nGNl
         NZow==
X-Gm-Message-State: APjAAAVBzH16v5Yh2vHr4hFOtm2O6lcOxdhs7glPs/2rWS3Opk2Q2+mS
        oU6Rt19nb/PMmolhQ9isjc9CXg==
X-Google-Smtp-Source: APXvYqzFoIhq86iW74zmJxBejj+zma0nFYlI3I/P9W/xmwZlaX3LhI2wzB6oG6o03ZgY2UPVKy6hIw==
X-Received: by 2002:a02:9f12:: with SMTP id z18mr12194050jal.10.1573230468826;
        Fri, 08 Nov 2019 08:27:48 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u21sm827186ila.41.2019.11.08.08.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 08:27:47 -0800 (PST)
Subject: Re: [PATCH] block: drbd: remove a stay unlock in
 __drbd_send_protocol()
To:     Bart Van Assche <bvanassche@acm.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Philipp Reisner <philipp.reisner@linbit.com>
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@tron.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20191107074847.GA11695@mwanda>
 <3a2d491f-3d24-3673-07f3-f601d5fafc97@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <26822f67-1cd7-eeda-2caa-2bc7d420f173@kernel.dk>
Date:   Fri, 8 Nov 2019 09:27:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3a2d491f-3d24-3673-07f3-f601d5fafc97@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/8/19 9:26 AM, Bart Van Assche wrote:
> On 11/6/19 11:48 PM, Dan Carpenter wrote:
>> There are two callers of this function and they both unlock the mutex so
>> this ends up being a double unlock.
> 
> Is there a typo in the patch subject (stay -> stray)?

I fixed that up while applying, fwiw.

-- 
Jens Axboe

