Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFB3C433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 07:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5319760F44
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 07:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240597AbhINHUa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Sep 2021 03:20:30 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:42934 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbhINHU3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 03:20:29 -0400
Received: by mail-wr1-f45.google.com with SMTP id q11so18509482wrr.9
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 00:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=LMfkzU7BNoFQxEWJF9BNog0oLM7MdnEPplz73JQTOQO02vHpn0poyV3tuiIpZN4vYZ
         rR1Sz/5fDDRdclsXBLRjA9hf+QtW1AXp2PhgrhMAKRqCd0rmBZMNfoXVodYWLlX1yQNl
         8voyinTUItEzrQfEQH/vZRagW8bPp2mPurESOGsJRiDjL+waGkiGk3tgtpTT+Sw9kV3U
         81eOcwEjfWXNvQzQIsa4C3KQgh56BkaoiHOwxxkRAopefsrL0tS/JR4vMM6WbC5UHBxo
         omZkPp3DjRL/vUnxGKvNdR71vk3F49SvqAWVlqEh9yPfw8nbh/DWgRkqAP9FJFt1RUid
         zuUw==
X-Gm-Message-State: AOAM533XnuXAnyZ/FgAoeR48hIADOU0NPI9A1M57AEXxhI3ggkh/CTx2
        Mhbz4vx3X3pEh+EQ7nMT+ds=
X-Google-Smtp-Source: ABdhPJxR799W7iZRWsnn/gvqBdGPd4O8oQj1ua+YcV6wiwAcLEmqUJdizidlrmz1Tsb2uOZU2cGpxQ==
X-Received: by 2002:adf:9e4d:: with SMTP id v13mr17055511wre.419.1631603952058;
        Tue, 14 Sep 2021 00:19:12 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o26sm261015wmc.17.2021.09.14.00.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:19:11 -0700 (PDT)
Subject: Re: [PATCH 2/3] block: flush the integrity workqueue in
 blk_integrity_unregister
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        martin.petersen@oracle.com
Cc:     Lihong Kou <koulihong@huawei.com>, kbusch@kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210914070657.87677-1-hch@lst.de>
 <20210914070657.87677-3-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0057deed-40b0-b86b-e4c4-fbd77b45bbbb@grimberg.me>
Date:   Tue, 14 Sep 2021 10:19:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914070657.87677-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
