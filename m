Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244B8C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 12:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039A160ED5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 12:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhJTM2V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhJTM2V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 08:28:21 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A88C06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 05:26:06 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g79-20020a1c2052000000b00323023159e1so1263610wmg.2
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 05:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KaTn1QxS0Y/OaUF2sZYicU2m6MdPew9Mq+u8J3ddb9I=;
        b=CgYD8NOfT1MakKunwTWuyKWCfJORmj2aihm1vcsP3fuA/j8aspd3beCsdy7C83bmAY
         hWioFmhYAsfsYSt2ckRifXzvAII63PUhkBSay8+qVYx38Bj7VBXA46pw2DfrQPBtyW0o
         GGY/2MfNnuzvXgheRx7FyAlqbWGpvub6TMsE0BQjRLHwD3UjGp8yn8KohMvslNpV7Y1/
         CX90im7YTFnVv6m+JoMRe+FjTLLLc/lySmlpS1qGPyeXeEeDSN9nfuxtTEqCoJNNpu89
         3UBU4icSd0SPEdho8lp8rOCSTiVrUbK8+a/rap366ZU+FaOYEwJslLTJUFxFNfvqZkZi
         VFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KaTn1QxS0Y/OaUF2sZYicU2m6MdPew9Mq+u8J3ddb9I=;
        b=BT5ZeVpTrH/0PsID5eDfeXXvtKfp0mUNRS/cdz0c5W6fXDOTY1DOva9TZnFIHVFlwC
         +Wi19gkljC8Oqxdiycq+NWra5iTVSZO2UdsOJkjOYhgcPCYX1klwAD5P3+APUWvBHM9p
         UhX6K3PKWFAmSsjaTV7zjsb/Z5JRQMgQ/WlF/vvGnilebxEeA8BSyH0l7Bibedb1AkaJ
         ReniNG32SsnIvC3SoT6vsyNAf8YM5etlHDuESgfzzw0ugxs++hc4JkiyaNN+6dC++IJt
         ceDPWm8F4D57ix6WBNofB7aCzlCEZs49/aVVSQ9JfI2sNguPMdN5OAk376b7WSILgOYl
         rKIQ==
X-Gm-Message-State: AOAM532wlREmbBhhGmz/FGcENrcjypjlrKOeoXEbus3WLjn78Qb7kVAB
        shoerMAyRSJwHHStGsCUW48RSaPwLnk=
X-Google-Smtp-Source: ABdhPJzu+UowuZOt84UqBkJcKMGzJ0Et+vVo8rxuuUUlw2R7yWLRX0Djd4IGFNnLqO8PSUtl3f5gbw==
X-Received: by 2002:a05:600c:ac1:: with SMTP id c1mr13083867wmr.99.1634732765129;
        Wed, 20 Oct 2021 05:26:05 -0700 (PDT)
Received: from [192.168.43.77] (82-132-229-137.dab.02.net. [82.132.229.137])
        by smtp.gmail.com with ESMTPSA id 186sm5098198wmc.20.2021.10.20.05.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 05:26:04 -0700 (PDT)
Message-ID: <096454c7-7400-ceff-a7d9-32e5074b6561@gmail.com>
Date:   Wed, 20 Oct 2021 13:26:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 08/16] block: optimise blk_flush_plug_list
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <a9127996b15a859a0041245b4a9507f97f155f7f.1634676157.git.asml.silence@gmail.com>
 <YW+3Rx5Rv/hIgvhU@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <YW+3Rx5Rv/hIgvhU@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/21 07:29, Christoph Hellwig wrote:
> On Tue, Oct 19, 2021 at 10:24:17PM +0100, Pavel Begunkov wrote:
>> First, don't init a callback list if there are no plug callbacks. Also,
>> replace internals of the function with do-while.
> 
> So the check to not call into the callback code when there are none,
> which is the usual case, totally makes sense.  But what is the point of
> the rest?

I don't care much about that part, can leave it alone, especially if
blk_flush_plug_list() stays in blk-core.c. I'll likely squash this
patch into the previous one.

-- 
Pavel Begunkov
