Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6340C4338F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 17:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BF4561529
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 17:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhHWRSn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:18:43 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:35802 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhHWRSm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 13:18:42 -0400
Received: by mail-ej1-f41.google.com with SMTP id w5so38520970ejq.2
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 10:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=WjrzYK1AzcPbmxc/TElW5RKgzuE8yuLpHCSgiGBr5CF7YTdoQF4LjfEvwxAOiSHXC4
         nDmwe0Rzj8ZtkyDUInPN6cvYGll2SpShSUEwgflVOcs6KKTwEI6WObkirXKeovcUeTgM
         vbHN83BsTRwVLOs1q/latYRKO8a8cI6YFl6/dfK2cFYTtSOHmHtRzqmYlCETpRw7SR74
         X6jUWk8jNGsJj+cNnxqTSvl/A8nXBxN37JXmhP77yX7tkYCcvyrHuyAEiT4EK8Be4HME
         TvfgO2Yt5clF3Zas81sV/geASbJ+dVA35sbqoNL/+ozBuFNe4GAytFc/mPwFKLHnSzhg
         i8Lw==
X-Gm-Message-State: AOAM530CFOXqzQ1tSMlhkDtFjwlcVx9oiENFXEjtGiNs51qWzQDUW2La
        VgM3JtRDjdTe46JzJCsgGVE=
X-Google-Smtp-Source: ABdhPJzvsbCzuUb3zDv7kCuXecI0ykk6pl7KGZIEYJEqC2O8mgwnYTjCLn9v/uq/uLHkuPdWTHYmCQ==
X-Received: by 2002:a17:907:12d5:: with SMTP id vp21mr13649671ejb.144.1629739079299;
        Mon, 23 Aug 2021 10:17:59 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il. [109.186.228.184])
        by smtp.gmail.com with ESMTPSA id t17sm9680452edw.13.2021.08.23.10.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 10:17:58 -0700 (PDT)
Subject: Re: [PATCH V7 2/3] blk-mq: mark if one queue map uses managed irq
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     John Garry <john.garry@huawei.com>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>
References: <20210818144428.896216-1-ming.lei@redhat.com>
 <20210818144428.896216-3-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d66dc974-52ca-8869-5ad8-f56fc4f39389@grimberg.me>
Date:   Mon, 23 Aug 2021 10:17:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818144428.896216-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
