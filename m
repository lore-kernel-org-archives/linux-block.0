Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF518C77B7A
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 14:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjEQOYg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 10:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjEQOYf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 10:24:35 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8233A4EE4
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 07:24:34 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-643ac91c51fso633351b3a.1
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 07:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684333474; x=1686925474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQF/CPa1a8c3c+hk+6C3g03rxPRyiUcRLFPp0bTUpo8=;
        b=E6fuZCjtT20JXf+ycczzSh1p92vGBHNL7VruxOaQqmCphRZQn1zAzh1AItXBrefaug
         pWP9dWIuX6hJWaq5i0T2eQls3mSdEwovoMvcOuixRq41YKAvnK2nr0vOoJUvtkjCRmgp
         MpmVkK55eOsZjloV8vcvRdmftrz8JesI2coIv4qv0pMjzSpcre/FW0orVFZgsNd6GwpZ
         Ak3Y1WftNJ38JTPQEXECVaEiMs5oOgGdD480M/FccCbnAcIiJWbd6N+DDEUVJgU6sWWZ
         K2+AUebYDPGPKFV8fy2Em9lPZkKnD6xFGfftfkHR/yX8oKeW0fK+70PIO81SUwwi/BQL
         quQw==
X-Gm-Message-State: AC+VfDxBG9DQsTqyDr/vmPUzHyxSOle2l8C9HVfgPizWbJquPDmPOUy1
        mGwzhqDm++7LfwxW69vamSw=
X-Google-Smtp-Source: ACHHUZ7EfXeuuL0/d9rJVEOifACpoY7lF9SsWLzLanZLx8+r0y74waCwRTE+uit9vNEbuTzKBjwEoA==
X-Received: by 2002:a05:6a20:144d:b0:103:73a6:5cc1 with SMTP id a13-20020a056a20144d00b0010373a65cc1mr31349249pzi.4.1684333473664;
        Wed, 17 May 2023 07:24:33 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id o5-20020a635d45000000b0051b4a163ccdsm15184075pgm.11.2023.05.17.07.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 07:24:33 -0700 (PDT)
Message-ID: <090f0916-6bb0-8b65-b4f3-fef0ef649069@acm.org>
Date:   Wed, 17 May 2023 07:24:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] block: BFQ: Add several invariant checks
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Paolo Valente <paolo.valente@linaro.org>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230516223853.1385255-1-bvanassche@acm.org>
 <47edc92d-129d-10d2-8a2e-9870d8748be4@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <47edc92d-129d-10d2-8a2e-9870d8748be4@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/16/23 18:26, Yu Kuai wrote:
> 在 2023/05/17 6:38, Bart Van Assche 写道:
>> If anything goes wrong with the counters that track the number of
>> requests, I/O locks up. Make such scenarios easier to debug by adding
>> invariant checks for the request counters. Additionally, check that
>> BFQ queues are empty before these are freed.
> 
> Is there any real problems related to those counters?

No, but I encountered an I/O lockup in BFQ while modifying the block 
layer core. This code was helpful while analyzing the lockup. All that 
is needed to reproduce the lockup is to call bfq_dispatch_request() and 
bfq_insert_requests() without calling bfq_finish_requeue_request() 
between these two calls.

Bart.

