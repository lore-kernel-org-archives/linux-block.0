Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872A6C4332F
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 18:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKASTE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 14:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKASTD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 14:19:03 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361FA272C
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 11:19:01 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id n191so13014337iod.13
        for <linux-block@vger.kernel.org>; Tue, 01 Nov 2022 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2yIMEyIdM9BFDMzy8xupZjUmRK55OQN/jxJjTBfmY5U=;
        b=byGLyGcJKLOMhhsYAQFyqJgNnvmQuTaMJQnsrFQK//IAZfxxe+xgXEs+28NOOOYHHH
         P3N1E7F8M5Qg1/BsI4pmCP49cuq6ySdvXOMOHoWE1E5wS81OUbvo9uRZyL31R2zHRHp4
         lqh1Se/P+OPv+OlJ8BHfH3YNvIi/j6Yj0GfMA2/pY1j28kb0EbyxGQNfr9LCP0gIx/i4
         6GAXOXVkQssZuJ7+Fd4EKtfhXm4HKZz6uTB4zGzozInOGnx6fM4lxvbDbTBnXu6qrJlo
         0HcGlZI2DmfGX3Pfi8+9F39NPJFrRbvbKlfztyNk60Ng5aE1Ex0uyLrVrYignOIwK6VA
         Mv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yIMEyIdM9BFDMzy8xupZjUmRK55OQN/jxJjTBfmY5U=;
        b=dmrf/aedmnNyBnMeE5N9e17MVeGIMXR9y/fEYv1wg7moVhEpjY04u8xglPIqXWu/S3
         h0CcXywEcGL5PelSv4bAqZ+bVeZMwl2hETt+X6MH7zna4MStrxGOWOTUg8yF5zf+Adbu
         HIWx5ic9UTldqDo47Y2Fhhe8MtHcd9NndxAqyuG+KwNkrXi313BMXiXpT42n7gZXYEEO
         M8gulUJ8/HNFvEWMhBLGixudl6wKtVC3n6DMg4UXBPqLhpo2FleS0fBOfoJwA4BBlJfj
         WZedgKEM+faVrhOYIB3UUrtcAVxnJ5D7wf4bverafVzHTitFDNrKHakpiw0aRVQxtqBZ
         H+6w==
X-Gm-Message-State: ACrzQf3nK+AP7Y6RYG/UMAHWKU3BJt6qqNyLY9wC3MMyqBZKonpZ2ClQ
        Ol0y9jD4TvVmwL5DA569e8WlDYd3iD6DXNlk
X-Google-Smtp-Source: AMsMyM5iqTn0JiWuPyYF+ArhsuAQdoP0+FUNeulzs4XTkBmK6csGrqZ0zEZNaXySRPU5rceoVtrAog==
X-Received: by 2002:a6b:ba8a:0:b0:6d3:c907:63c3 with SMTP id k132-20020a6bba8a000000b006d3c90763c3mr1750723iof.15.1667326740519;
        Tue, 01 Nov 2022 11:19:00 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id bg3-20020a0566383c4300b00375217ea9b6sm4108469jab.45.2022.11.01.11.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 11:18:59 -0700 (PDT)
Message-ID: <37138d05-c2b2-a106-416c-6be134d94046@kernel.dk>
Date:   Tue, 1 Nov 2022 12:18:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/4] blk-mq: improve error handling in
 blk_mq_alloc_rq_map()
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1667314759.git.nickyc975@zju.edu.cn>
 <992db53bdeaba35d37de3784fe6f80879c9bbb35.1667314759.git.nickyc975@zju.edu.cn>
 <20221101173401.GA20690@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221101173401.GA20690@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/1/22 11:34 AM, Christoph Hellwig wrote:
>>  	if (!tags)
>> -		return NULL;
>> +		goto err_out;
> 
> Using a label just for the direct error return here is a bit silly.

Plus that's not idiomatic code for cleanup, just keep the NULL
return if there's no cleanup to be done.

-- 
Jens Axboe


