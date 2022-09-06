Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F66C54EE9
	for <linux-block@archiver.kernel.org>; Tue,  6 Sep 2022 00:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiIFAS6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Sep 2022 20:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIFAS5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Sep 2022 20:18:57 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AA75B043
        for <linux-block@vger.kernel.org>; Mon,  5 Sep 2022 17:18:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fs14so4827660pjb.5
        for <linux-block@vger.kernel.org>; Mon, 05 Sep 2022 17:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QfYqb6Pfw/hN4JPJ05FBEV50HBSGkGyPNi9iiQG7nRw=;
        b=ld4zch2mgovaLAdB8N98ih+6dYvI8qBpwLRLtjNUDXeImKkqFWB254xBhy80F0U90A
         J+yZQRYLuP0Jo0Mk4yML1TKUKTk4jEDPAOUEP0c5+yqaqhTQ7+gOhuufyatvIfqzg0BU
         d51A5BQHmMl/s8AQIKgv1IR+4ol+H/BXs6JEZtb4Swr9u9DXePXU/BvNKH7l3CIBjpu3
         /8dasrmmcoD2uYWsFEenjdP0uA9ZA4SxjaxZhym5FeSGQJkADFqbpqEmWC82AjcP9iKc
         1NfcpSGj9hkQFNFfw2zrIOCfADCzsT/D3pikpqUQo60TyPiILNt9xpxLMpKu3gGjb8Lt
         Rc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QfYqb6Pfw/hN4JPJ05FBEV50HBSGkGyPNi9iiQG7nRw=;
        b=uNQ2YZqyKwCY6Q7xskPR9Te5qPBagT8/T9k2+PwAtkNnLMHecvp8zgSdMRFTeKW7ws
         6h2k7y+KD7KEzG1rZ85oN7lAnHnJoqvRXMr42XMJz8K+4j6xr0cAKopoP2JqXj1AsQqc
         Q02Rtv6cSrhGGK1EzfuNEmBFRxmakqSX5ZmR0P7IKmQuGDIiYvRJFloAUUql60CGpPjR
         e5AjCEK0lX5kKjMQcprpG0JJ9WNDAfkcMxNSKXojv8GrYfYsnzfyHJJ6CJUA3DgqH3yB
         i5+nycVJmyF3d0Cq+IYpc8bMIgFd5Wk/gJ4FXFqAue4l0+m6EQlkJNDfpXJ+7iYUplAv
         ej9A==
X-Gm-Message-State: ACgBeo0MxaXpOV09KoeSxezBjgZAkpg1DzF+dGbUM12gJZia6ViM/t1q
        Xr2s+jh0LhwiS/XcpZYGBNrMpQ==
X-Google-Smtp-Source: AA6agR6jxIENBgUBR97NH/krn8jJvwlo5786QKZ2UpSO6xuS9EB3TrYsrTPQOCKgXQVdaJ7TxrILOA==
X-Received: by 2002:a17:90a:7e87:b0:1fe:4d96:f6f6 with SMTP id j7-20020a17090a7e8700b001fe4d96f6f6mr21348991pjl.142.1662423535323;
        Mon, 05 Sep 2022 17:18:55 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c24500b0016dc78d0153sm219209plg.296.2022.09.05.17.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 17:18:54 -0700 (PDT)
Message-ID: <55a2d67f-9a12-9fe6-d73b-8c3f5eb36f31@kernel.dk>
Date:   Mon, 5 Sep 2022 18:18:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: New topic branch for block + gup work?
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <86266dcc-d475-7cd4-77dc-a8ba6f11620b@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <86266dcc-d475-7cd4-77dc-a8ba6f11620b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/5/22 5:16 PM, John Hubbard wrote:
> Hi Jens,
> 
> After you suggested a topic branch [1] as a way to address the recent
> bio_map_user_iov() conflict in linux-next, I've reviewed a few more
> patchsets in mm, and am now starting to suspect that a topic branch
> would be ideal here.
> 
> Logan's "Userspace P2PDMA with O_DIRECT NVMe devices" series [2], my
> "convert most filesystems to pin_user_pages_fast()" series [3], and the
> block layer change from [1], all conflict in iov_iter*, and in
> bio_map_user_iov().
> 
> Less of an issue but still worth considering, Dan's "Fix the DAX-gup
> mistake" series [4] conflicts in gup.c, too.
> 
> Maybe:
> 
>     gup_bio
> 
> , or something like that, as a topic branch?
> 
> Everyone: thoughts, preferences here?

My suggestion would be to branch from for-6.1/block, then we can
apply the gup patches on top of that. I'd probably just call it
for-6.1/block-gup.

-- 
Jens Axboe


