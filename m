Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51808C38A2D
	for <linux-block@archiver.kernel.org>; Mon, 24 Oct 2022 15:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiJXPCM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 11:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiJXPBx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 11:01:53 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDF41366A4
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 06:38:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g62so4956467pfb.10
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 06:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vie4dh+louXoUQMxLwJz2RE5N7M8k6YAevG4uZHlAM=;
        b=ZeklBEM++ZyiB9531bxr/Scj9q9MWVpJsuyTPhMoekTv+rbo5Vyvc70nqbVFwwN3M/
         Uwk1qBUFWdyVDZu179Y2T66TNiOWC1+Q47wDFrHBYchJXHANXEftyXtqlE9bGWeUoNlm
         SFGcQ/rUvH9Zbt/iWyA8ui399qtsDFU5bOKb6UlOJ4njJZZDmxG218rWnfQp5HdXDw+T
         HpS9UbjbVIIncMtoJPw5hB6O2kgM+XwmYlMfzQG2jc+vBD/trbB1XR4Wjgo/QK9OQ+lK
         iRmVpvkJM1cZBTXpS3NCv1LC3kClFnH1ME9R3pKS8udDJ1zo7csnVVDE2N+PVkpAi95b
         +4Rg==
X-Gm-Message-State: ACrzQf3gaZGyFD52UHh/QQgRv9jQs0RGHAW5ttbAJ745S0ak2+0nCEN0
        YR/XuvpsK3uNAWn9/29fdOg=
X-Google-Smtp-Source: AMsMyM6ckg/oHhCgaWHmli0CaXhP/8VL4mNEVYUHYL8F3rk1ClcrEraBR6UfQF3YnlCK0f+GKELy9w==
X-Received: by 2002:a05:6a00:2303:b0:56b:cd7e:6cb with SMTP id h3-20020a056a00230300b0056bcd7e06cbmr5528386pfh.77.1666618524742;
        Mon, 24 Oct 2022 06:35:24 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id cx10-20020a17090afd8a00b002132adb61ccsm432730pjb.48.2022.10.24.06.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 06:35:23 -0700 (PDT)
Message-ID: <77784776-4e58-47d9-abde-a782f5ca7d3a@acm.org>
Date:   Mon, 24 Oct 2022 06:35:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 5/8] blk-mq: add tagset quiesce interface
Content-Language: en-US
To:     Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-6-hch@lst.de>
 <01e45c37-5db8-b1a5-33c6-251da2637fb5@acm.org>
 <e092e8b6-66d5-b191-805d-f49ffdafc8a8@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e092e8b6-66d5-b191-805d-f49ffdafc8a8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/23/22 18:57, Chao Leng wrote:
> blk_mq_quiesce_tagset() support concurrency. blk_mq_quiesce_tagset() just
> check the flag(QUEUE_FLAG_SKIP_TAGSET_QUIESCE), it has no impact on 
> concurrency.

Hi Chao,

I think it depends on how the QUEUE_FLAG_SKIP_TAGSET_QUIESCE flag is 
set. I agree if that flag is set once and never modified that there is 
no race. What I'm wondering about is whether there could be a need for 
block drivers to set the QUEUE_FLAG_SKIP_TAGSET_QUIESCE flag just before 
blk_mq_quiesce_tagset() is called and cleared immediately after 
blk_mq_quiesce_tagset() returns? In that case I think there is a race 
condition.

Thanks,

Bart.
