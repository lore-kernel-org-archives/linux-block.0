Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FF9C47247
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 16:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B79208D5
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 16:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="llVhiT3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgD3Q0N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726336AbgD3Q0M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 12:26:12 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A69C035494
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2020 09:26:11 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y26so2120385ioj.2
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2020 09:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jUJ3QDX1EKapBMNpqnE+k5isQzU8JnV6lw5xLL5DTC8=;
        b=llVhiT3HoTM3Z9CBI8BOwBCp4ox0zSyrVf9qMzTz6TXgj4cAPewe4Y66mt8JZhhl06
         7zb8pq3Jtm6Ddpw806yL0hcKcqNNLh0/N4GLueIk4LIeOrGN4nDidkHNHwGRmEYjUKWS
         4VHDKR1I4Zj8NaPwKRQ9uzOL6xYx4pRjVcb9lWFQ71cgc0Jmdh4rm8c+B2vklWYySdQY
         eOgWZTrRW2Mpbh38bERnWPxrpjoSWwHIzzbyrPjq9aeqJ/2GMeeO3who0S2tIGwQhQMA
         UeP9AZR3vq9UQoaBYy5DAqsUXk8oq1PX/KlNfc6FhbZ3gQlezSaWx4m/+6sH9FB1xHza
         lOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jUJ3QDX1EKapBMNpqnE+k5isQzU8JnV6lw5xLL5DTC8=;
        b=U6rQiSDjk+DxACPXBqE32j0hsyL2eqG3TmnYJxHguGK4X9L+9D9lX+VYJUAJy7HnXr
         kztEKr/uOs6pwAuBwbHzjuVwYkcQldVImKAxTOPwQyMAVE1mZ3LpoCT2mUTmW6pAiD3L
         vQUyX/IPRLc1fAw2rliCuNPZH6fnApQCxUSIbGJLt1Wj44E/BhUgCuxiW8t/JlPEQXxM
         N4qgHORJ/Gs8pGk23IGUkd/pGBo8h2e84EHcu9H8x2RYoiZ1SPaF+dZjnL3QKUhrSNZp
         L3U0kx5ZohedqpB/ONAG7hy94rTH+wrSMgRTUjSo3YapRNMBLnjPk5f/b+zjQN/M1jF9
         f4VQ==
X-Gm-Message-State: AGi0PuYv8LRSTTTxEG6ZRlGeD0Chs5pk3FpVv/mhgBVUue7c8lD5v3ob
        Z8xyZTQwJkzlkF1dr8pTAK6rPg==
X-Google-Smtp-Source: APiQypLgDALh01yIUl3IS1obQt2cDMoWKTFJ1ogUlTywVw00cxI9amOr9GQLTFbR5TvgN9JVEwWzUw==
X-Received: by 2002:a5e:8e44:: with SMTP id r4mr2650949ioo.47.1588263971055;
        Thu, 30 Apr 2020 09:26:11 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b11sm112190ile.3.2020.04.30.09.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 09:26:10 -0700 (PDT)
Subject: Re: [PATCH] block: remove the bd_openers checks in
 blk_drop_partitions
To:     Christoph Hellwig <hch@lst.de>
Cc:     sandeen@sandeen.net, linux-block@vger.kernel.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Yang Xu <xuyang2018.jy@cn.fujitsu.com>
References: <20200428085203.1852494-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5452acd0-96d0-e3ec-f0e4-a322d540dc0e@kernel.dk>
Date:   Thu, 30 Apr 2020 10:26:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428085203.1852494-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/28/20 2:52 AM, Christoph Hellwig wrote:
> When replacing the bd_super check with a bd_openers I followed a logical
> conclusion, which turns out to be utterly wrong.  When a block device has
> bd_super sets it has a mount file system on it (although not every
> mounted file system sets bd_super), but that also implies it doesn't even
> have partitions to start with.
> 
> So instead of trying to come up with a logical check for all openers,
> just remove the check entirely.

Applied, thanks.

-- 
Jens Axboe

