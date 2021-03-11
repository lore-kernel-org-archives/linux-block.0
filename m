Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A61C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 18:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA49064FE0
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 18:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhCKStx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 13:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhCKStu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 13:49:50 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F37DC061574
        for <linux-block@vger.kernel.org>; Thu, 11 Mar 2021 10:49:50 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id p10so248718ils.9
        for <linux-block@vger.kernel.org>; Thu, 11 Mar 2021 10:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SR/K1SCB2ahRjUI01f7yqd0PaiNzw4Ak6BDEiKjZTEM=;
        b=IIeROJPknOEH8MbJ/sEtfxXqCzjWaEvenzFjPibE89ipMq82UEd2mfaEUqDoLetrjp
         xkbxbTLJFmrijJdH0A6u1uvW/tQxlxuqArA+Ip3pZQ70mxPzqg1ewqxAKwMOq7UoJHGp
         xU+ALG/YJfe05OzSf7wl0bg3SKfV4IF004ahR0ZshNUawOGrPAvvgApXwRthdh5RTQaT
         BrWdLIXVLKGpXz6qYfKD2i7PVaXMbaxIUFY9WHWeuP4MIiCW1ygMpLODg8kvtFicEk3s
         Fhtw2Fl18bmhlEVOdQiprH2BwGwOnt9e9LEjZi3Mqy98UUKo136jPRv+rLF51f8stQKF
         pWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SR/K1SCB2ahRjUI01f7yqd0PaiNzw4Ak6BDEiKjZTEM=;
        b=XQnEB0Dm3aJn1hDbahfI8rnOQHNLjBdC5LIRHldH4o5uLC4nF7gXbnB0N/XkGjAimH
         xxemYAJEJ3uNYi46mf6kBmQAzUl5pStlF8LBHYoa/ECfaHg4qac74ZN7FSSp5eRhX87q
         7fmbm/XWDx7GqfLeGPz65Cfq3VqiTCn8rBqfGszk75lpg3+KhtnGW8wJpVvb5TU4EiZh
         I6HHxadJczNFfxACeisr6GiKpO26WydNDuIVou3fY4rkbJQV2C83S8ddSEbUNZGr0NDa
         iuo4FI/LWGYrSjOdD1KvHkiJYHmbEr5ksUYpPaQfT5FdbSmVRhXR3PpreK50gmtm8h7S
         VT6g==
X-Gm-Message-State: AOAM531P1QF6dXdLt+N7oqI4Ug2FcExnh+tARLZmb9z/wu5y/vH8wvik
        45mbhTlprx5KA1Q0VQR0ySS6TA==
X-Google-Smtp-Source: ABdhPJyckJWegb9iuD3pQSSFuX/uoYBAsxnmRz2QFlHUPee0rowvDfYLn+GDK63SmDJ+yeC51fdnzQ==
X-Received: by 2002:a05:6e02:18c9:: with SMTP id s9mr8295504ilu.265.1615488589883;
        Thu, 11 Mar 2021 10:49:49 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k12sm1688396ilo.8.2021.03.11.10.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 10:49:49 -0800 (PST)
Subject: Re: [PATCH v3] block: Discard page cache of zone reset target range
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Jan Kara <jack@suse.cz>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20210311072546.678999-1-shinichiro.kawasaki@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <684410f6-2b4f-ad61-79a0-461a5604b6c5@kernel.dk>
Date:   Thu, 11 Mar 2021 11:49:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210311072546.678999-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/11/21 12:25 AM, Shin'ichiro Kawasaki wrote:
> When zone reset ioctl and data read race for a same zone on zoned block
> devices, the data read leaves stale page cache even though the zone
> reset ioctl zero clears all the zone data on the device. To avoid
> non-zero data read from the stale page cache after zone reset, discard
> page cache of reset target zones in blkdev_zone_mgmt_ioctl(). Introduce
> the helper function blkdev_truncate_zone_range() to discard the page
> cache. Ensure the page cache discarded by calling the helper function
> before and after zone reset in same manner as fallocate does.
> 
> This patch can be applied back to the stable kernel version v5.10.y.
> Rework is needed for older stable kernels.

Applied, thanks.

-- 
Jens Axboe

