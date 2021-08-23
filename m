Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE67C4338F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 17:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E58C961501
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 17:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhHWRTQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:19:16 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:43667 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhHWRTQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 13:19:16 -0400
Received: by mail-ej1-f46.google.com with SMTP id ia27so16316781ejc.10
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 10:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=hFH0WYNetKA/LoXeQ91CW+oblB6BF148098WoV/y/iXKYJaLkVoZECl8bVESsFdUp7
         fa5QEWWVun6lcIUqyvUWlRnZJowUULGe8dh01UD8Sk56u/Em8NYNkNE1tUwrpb788fHx
         J/wGujXE3Y1gL7tM1FP5ozBT6LmTt1Zogu81qSIjF1ayZVuYG9X1T8nNXn545qb8bNcv
         DTdhie6BgSHSrNZyk4dAAAqneI1ZLFZugHM9zsos48hlMWsoUvl8apA8WhgI9JAYb1hl
         pUINDbwOV5I6UMmm3vfSIL1mxvL+R3Up+fQbRQe+6HQ8Lt/Cu/p7uqRuldajE8A1YyLn
         nPFw==
X-Gm-Message-State: AOAM533YMKRvQ7L8m/uYzvXlcY9s5GfRFtAxHrAtqeEwbChx7Q6f/slx
        9fmPUEBmlzFrcKEc1gE5fD4=
X-Google-Smtp-Source: ABdhPJzlO+9cPtA0AELFM5ulAgN/CiMYDgmcZuoC36myTb4FygpFEmtOWxfuGni94I4qasJ5kc410A==
X-Received: by 2002:a17:906:b18e:: with SMTP id w14mr36706129ejy.63.1629739112414;
        Mon, 23 Aug 2021 10:18:32 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il. [109.186.228.184])
        by smtp.gmail.com with ESMTPSA id s2sm588972ejx.23.2021.08.23.10.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 10:18:32 -0700 (PDT)
Subject: Re: [PATCH V7 3/3] blk-mq: don't deactivate hctx if managed irq isn't
 used
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     John Garry <john.garry@huawei.com>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>
References: <20210818144428.896216-1-ming.lei@redhat.com>
 <20210818144428.896216-4-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4a3918bf-6cf4-684c-47d6-5f466750dfcd@grimberg.me>
Date:   Mon, 23 Aug 2021 10:18:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818144428.896216-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
