Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9B9C433E0
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 03:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2E9236F9
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 03:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbhAHD71 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jan 2021 22:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbhAHD71 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jan 2021 22:59:27 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439BCC0612F4
        for <linux-block@vger.kernel.org>; Thu,  7 Jan 2021 19:58:47 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id g15so6802805pgu.9
        for <linux-block@vger.kernel.org>; Thu, 07 Jan 2021 19:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8vphs6ol0uPk1wmTyhEAtpxZuQ+ephElSyljoTv7G+k=;
        b=pqxH26gCqouERd4Og4eBEn/19Ii6L3J2TOTZrNYDwr/oCJ3rhvM8on9cAdQjCzU6/j
         2qrvS6pk8ybypxzRvGIcWznGiJKP74lA2IfKotMVucy5eGfmGrd7S/tuXMoghX2d0uIW
         yKYuPA1J4G3lrtNsMdKd5IuEq4470iZAQTiosfqz0yQHlwcKQT3MPRRXSCt/WQuEW2wz
         Y6quOIvnGyNyjZS7MzVaU/J8bZ/1TZwlpLqqL3eRxWpX+9u4xAiMUj6zo5LC+ovMqJpN
         osfwFH+TJAc2Vgbi0okpF/RX703CctqrvGwR/wcIvgftTEdYEl77CCU4+C/44aLgDM9n
         4Wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8vphs6ol0uPk1wmTyhEAtpxZuQ+ephElSyljoTv7G+k=;
        b=NxUbGSlSF8PnV+sg50HLiJ/IWuU1nXh4mhRwwxkb01jHx7tXjdkrg957QZn6FI2CB+
         HqB4Wq+ovDiHBCAxBURcBwyaznBTEzY94Ql8aTYNcJSAkQIo59jyVSHOinY6goxQ0Sjn
         LwtRB4C7Jm3BZzArbaRY0cKs4ScAzpXAnwX5gR8cNuLYM6PONDZdwxhNzzJPp7dZxKiu
         4dL9l+nuHiw7E5szdEd5bkPp6X6K8AGwWvaf05qB95jE4i2WJm5knUyX04djRKfNcfg5
         OwMD7Dh4DwIg81CU6DDpHZWawhFp/mTFrgT6VdMYhMAAjik3rv/u9uvr86oK5oaIPEk7
         ji5A==
X-Gm-Message-State: AOAM533qcL15KFFx7I7DtVnBfJjQ3RLjWCxact7VGGeNvV1R9DbgXVDV
        4l1HMmfUXoGnEVYb2aiOXHSgeY10RLyw0A==
X-Google-Smtp-Source: ABdhPJwjXNhJBZmcunsQ0dxt6yGXWHWI3v3mii3f+yk2B/4/RMeu1caaLQiH58Xq8XSi3pEiAKpcAw==
X-Received: by 2002:a62:7a43:0:b029:19e:c33b:c498 with SMTP id v64-20020a627a430000b029019ec33bc498mr5184238pfc.20.1610078326809;
        Thu, 07 Jan 2021 19:58:46 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id f193sm7563021pfa.81.2021.01.07.19.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 19:58:46 -0800 (PST)
Subject: Re: [PATCH] block: pre-initialize struct block_device in
 bdev_alloc_inode
To:     Christoph Hellwig <hch@lst.de>
Cc:     aik@ozlabs.ru, linux-block@vger.kernel.org, jack@suse.cz
References: <20210107183640.849336-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d512bb0f-4e91-393d-0b2a-39a7e4f728c8@kernel.dk>
Date:   Thu, 7 Jan 2021 20:58:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210107183640.849336-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/7/21 11:36 AM, Christoph Hellwig wrote:
> bdev_evict_inode and bdev_free_inode are also called for the root inode
> of bdevfs, for which bdev_alloc is never called.  Move the zeroing o
> f struct block_device and the initialization of the bd_bdi field into
> bdev_alloc_inode to make sure they are initialized for the root inode
> as well.

Applied, thanks.

-- 
Jens Axboe

