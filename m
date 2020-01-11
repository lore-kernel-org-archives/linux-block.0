Return-Path: <SRS0=o2oO=3A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80721C282DD
	for <linux-block@archiver.kernel.org>; Sat, 11 Jan 2020 15:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9A6206ED
	for <linux-block@archiver.kernel.org>; Sat, 11 Jan 2020 15:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="2NllUw1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgAKPve (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Jan 2020 10:51:34 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45020 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbgAKPve (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Jan 2020 10:51:34 -0500
Received: by mail-pg1-f194.google.com with SMTP id x7so2481885pgl.11
        for <linux-block@vger.kernel.org>; Sat, 11 Jan 2020 07:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=grHu2akLruyKuUODnoBeOnklyP6V4dvz6oYhnaEv/LY=;
        b=2NllUw1RKohT6mVJzfHdP2kw1ZgnPeXnqhMBLPcBamfirfICuBJa9j1WteduyOg1jl
         J17fK76wNZt9kZOWAJ+1QWziTCSn6WJzZYGvsaqmjZii3weMu/hBRpSuTfE+ZYuOgfiA
         Y0iu1YSKzImqysFk0WSHP8tBoFl/kO+NmB/t+vMFQswoSo95IHkKtxTYiRbSrnAz/aQs
         VB3pAVfMJTXyi+UaMLgLtwH5vwa+lR5w7tNu01GGxsHU+1NX7uSS+5XtzjuroVYooarw
         /bF2wR5Swx9HaPJGMojtT7NPWlFqg9ywCEWG+9UTTbZZM26rNbLe/jULbOGv29a3ntPT
         WDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=grHu2akLruyKuUODnoBeOnklyP6V4dvz6oYhnaEv/LY=;
        b=Ri5/aT1YaVcndXDPPcyDn7kVVDHZgdbCXfbVP/IIB6Jc7ZXb8t/5H05twNZN848fTH
         NAHqtV4bfNkggeilWX0tNG0HvDrp1LUFsr7YSH2FtWXtEX3TKWjDOAH2ra4LlAg2Ke2z
         aBMpBKVGy/5oSveKp3FntCs+tQeCzCjp+L8w8c7+G8RnBOdC9kbYi0ZjUCDbDqwPHoaH
         WWAxMgpInf3UdM+rlYmK+yqvv2V53W72tZKIVE81EW4useE/a2Jp6brOv4l46t7hp/Rs
         ilEYmZNQbTpdoXG1Gc4lOr1R2laGgcJJenPBEF4UOrzYpdrfxKDOIzqTK4YbP33s1wk5
         +jyA==
X-Gm-Message-State: APjAAAX/+jG1FXOT9mCeeHwhCrCxfVbX2aeohpCKs7ByugObSn9LEL7I
        Kr9sy0ZGO5UXFrw4nN6y4sQgmw==
X-Google-Smtp-Source: APXvYqw3VLxm8HwnUMCOQDYc38eABguHAIQwHvpwv3WV5me4SF7WNbpINrP7xmK4FQ92igYC3QdQGA==
X-Received: by 2002:aa7:8191:: with SMTP id g17mr11160582pfi.25.1578757893178;
        Sat, 11 Jan 2020 07:51:33 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id z11sm7636745pfk.96.2020.01.11.07.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2020 07:51:32 -0800 (PST)
Subject: Re: [PATCH V2] block: fix get_max_segment_size() overflow on 32bit
 arch
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>
References: <20200111125743.4222-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <62d41f31-a50b-8416-fcf5-abcbb675176f@kernel.dk>
Date:   Sat, 11 Jan 2020 08:51:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200111125743.4222-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/20 5:57 AM, Ming Lei wrote:
> Commit 429120f3df2d starts to take account of segment's start dma address
> when computing max segment size, and data type of 'unsigned long'
> is used to do that. However, the segment mask may be 0xffffffff, so
> the figured out segment size may be overflowed in case of zero physical
> address on 32bit arch.
> 
> Fix the issue by returning queue_max_segment_size() directly when that
> happens.

I still think this should use phys_addr_t, just in case the mask is
ever not 32-bit. The current types are a bit weird, tbh.

-- 
Jens Axboe

