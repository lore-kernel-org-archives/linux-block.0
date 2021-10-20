Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776DDC433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 12:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C7B61354
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 12:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhJTMV3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhJTMV3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 08:21:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A61C06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 05:19:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b15-20020a1c800f000000b0030d60716239so1151475wmd.4
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dnL+iGfdRffxZQqHPOM65cfCNkB2ozysb9HCyXLFHas=;
        b=ZvNcQb9orTaCuVOIH68eX/HHZbbkuYCd3ZilDlQh4xjUzqe38xkayWGOWLaVRTlcXh
         mOzgqJCpnq0iOJc5kpSVhgRDuJQnAzL5e3EL1YNEsiBw82JNmr2HsXOb4MrSVZ2d/76r
         Vx8pCWNij3SvpkkG8L5YhQ8Uos/Yf+PNcB/iLz4azmGnbqjEUpsmJVD4RGFgNUOTHjaZ
         dIQ3UpA4xqL6mWNrfEadspCPCFd3NNSbJyY2iXqnZu7f0PDmT95M2VYbW4I+uZRhS3gP
         zfUy+6ZhNX7V2E3L1eaP2sCNnX41boy5DgLjeWUGvw3xFEBdWXMZcxvjCzl1sdB1IAO7
         vQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dnL+iGfdRffxZQqHPOM65cfCNkB2ozysb9HCyXLFHas=;
        b=ahG5ETfTNGlf1+jETT9SSU0H5bOCLhrVfbSkaFB9o12dStejbkRqa3ilI/ScBR9CwP
         MODH1VxPVEWLRb0AU1RIpLVc5ogQuYYCP4wHK4U3DXQfXBnpij/v3iyEuIsAJQaXNsTz
         S2TArO68GBQP3dc+1cPB/usp/gEHmvQYs2gAv2QKh0qHuYnhwxFSXjvZzujSwmx8SFvA
         C36kth3SjR5fQspHD+qJ7hb04FYcrP3ilb4dD16pG5aFlf7VPvndjJkxS68GRS518Hqv
         qZIDANxzqweX4GzUrZuyMm0dp9f/u1ncRF+xbLWQkh5ZxZxHATJiu47peK8xRq6rTWEY
         rUVw==
X-Gm-Message-State: AOAM533ZD0ihZbCdkucrmSZzNTiPF52T4rCwfC0q30Pfsw6ew7aMDnDa
        h/FD5eSvOz4M2agHDsOMdmNeDoSd20Y=
X-Google-Smtp-Source: ABdhPJyrUC3SXAQlrKWOeEEnJYGBdFl47zVtMHU8WiqyJ3Lg86XYhuM3VOfvq0b9zXN5d1dnlnA+IA==
X-Received: by 2002:a7b:c057:: with SMTP id u23mr13590001wmc.3.1634732353470;
        Wed, 20 Oct 2021 05:19:13 -0700 (PDT)
Received: from [192.168.43.77] (82-132-229-137.dab.02.net. [82.132.229.137])
        by smtp.gmail.com with ESMTPSA id a2sm2091713wrq.9.2021.10.20.05.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 05:19:13 -0700 (PDT)
Message-ID: <6d433282-7bd2-d45d-d3e8-6eed12660144@gmail.com>
Date:   Wed, 20 Oct 2021 13:19:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 05/16] block: inline a part of bio_release_pages()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <c01c0d2c4d626eb1b63b196d98375a7e89d50db3.1634676157.git.asml.silence@gmail.com>
 <YW+zdYMG2FUlzXWA@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <YW+zdYMG2FUlzXWA@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/21 07:13, Christoph Hellwig wrote:
> On Tue, Oct 19, 2021 at 10:24:14PM +0100, Pavel Begunkov wrote:
>> Inline BIO_NO_PAGE_REF check of bio_release_pages() to avoid function
>> call.
> 
> Fine with me, but it seems like we're really getting into benchmarketing
> at some point..

Well, certainly don't want to get to that point, but at least this one
is in io_uring's hot path, i.e. fixed buffers.

-- 
Pavel Begunkov
