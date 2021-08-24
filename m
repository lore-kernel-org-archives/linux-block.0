Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5BAC4338F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 17:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F88E61165
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 17:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhHXRx7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 13:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhHXRxy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 13:53:54 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6F6C033888
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 10:18:38 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d17so12608814plr.12
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 10:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QrRd5xVLA01AMyAhg/bjoi6q9MF0Gvz/hi+qc4bki7Q=;
        b=CYcH5dEel/s1cyMoNJOXIuOXBAW7xpcfIChc+7Ekdo4sc+RPZVlGQVmR55q92F4Lzp
         YoM4cypdz+xnVQ8SnVrVwKHGQjQtKRg0H7Bmt+UeYAMpXeTnlY+H8ypItfcHMpUVLvWB
         5qBw/WxzzCeLS0Y++SQfR/cIQwhH8c6g3csd3f5rtAKNJ1KzCtgsMugNihKX9z3yGN2I
         xT8EyH/dY6xLPxYp/8TWV14xaA0fHzzCMOVrWleFZ2Bx5faaxlCF+iZ+Y5OQp748hUnf
         beQRkgRGqXd4X0ap7q2XBQVLl819/7pn2VsvAHLSJMTFjgJT0G57Uvql78inp+doVZy/
         kXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QrRd5xVLA01AMyAhg/bjoi6q9MF0Gvz/hi+qc4bki7Q=;
        b=Y584/4du34sPR55Nsg4BHybG0B4GvYyWMFw7M7OrgtVmtkBIOWSTEuV93OSwQj2YcQ
         kxA8iW5FMeK3x9pww9/VLqUBcuzvDabjXTfzuXyFFfiLS/ebjKGq3Xk+SuCtSqyP15K0
         Uf5fe6mDGN9MGjXHziLRLMDum8v5UfqnikUdU0xFrjo7hsQTUkCfEDqIE19mWbR3CntD
         REUIAxoMWnZ8P/TBN5P0UQveWANfjmBFNT63Wy0mQxmSkxHZCm23zNmFp5/jIXLOIhZD
         EnwD2g0HKryGzctdme7HtY4mpCZ7MdKk8ZccLlMziMKF/u0Agpdm/txGMOesxCjurViO
         TPVw==
X-Gm-Message-State: AOAM530ii99EuTS3kBofGy5JLitR1kEz9GWLBq8paYscFw8M94Et7nxZ
        +sgZtA/1QkSJn2g1AI8tBGCMMA==
X-Google-Smtp-Source: ABdhPJynnh56TZhYxtnJQu3guaVURRk2kxVuM0qqIaz+dI9gvZz5MlW29zmeG6GPamuAQ3F0VXhzvQ==
X-Received: by 2002:a17:90b:3b92:: with SMTP id pc18mr5311437pjb.149.1629825517818;
        Tue, 24 Aug 2021 10:18:37 -0700 (PDT)
Received: from ?IPv6:2600:380:4960:2a4d:1b63:8a6c:25bc:6edc? ([2600:380:4960:2a4d:1b63:8a6c:25bc:6edc])
        by smtp.gmail.com with ESMTPSA id t5sm20290919pfd.133.2021.08.24.10.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:18:37 -0700 (PDT)
Subject: Re: [PATCH] mq-deadline: Fix request accounting
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>
References: <20210824170520.1659173-1-bvanassche@acm.org>
 <412b4df5-aa1c-c95b-7b71-c0fc61ae3d06@kernel.dk>
 <349f4277-4370-482d-ab4d-a1ed652e1c29@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <efca9ae1-0a5e-3eda-7003-3ede651da856@kernel.dk>
Date:   Tue, 24 Aug 2021 11:18:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <349f4277-4370-482d-ab4d-a1ed652e1c29@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/24/21 11:13 AM, Bart Van Assche wrote:
> On 8/24/21 10:09 AM, Jens Axboe wrote:
>> Shouldn't it be:
>>
>> Fixes: 38ba64d12d4c ("block/mq-deadline: Track I/O statistics")
> 
> Right, that's what the Fixes line should look like. Do you want me to
> resend this patch?

Nah that's fine, I'll just correct it.

-- 
Jens Axboe

