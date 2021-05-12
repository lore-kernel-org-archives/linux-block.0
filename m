Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AB2C43460
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 22:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB99613E6
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 22:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbhELW7V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 18:59:21 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:37504 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442267AbhELV5o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 17:57:44 -0400
Received: by mail-qt1-f176.google.com with SMTP id g13so18410129qts.4;
        Wed, 12 May 2021 14:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Aqe/+Ev93J3bz7j74bYa9qlhFPCmfHP+1ifgC+bG3u7GLwN5zrzZYABXweCGA5G2pT
         liZKFZFxPmbBEEfJyu8w0ZVj7D5/AgBezLMWEWO8aTf5rgGuH2avXjzIuyYsuAWAQONf
         Yd/o3ClDNK8JTJqAIk5lwMDKrOQNSde3TWHF/eWy/eSDByhJJeFydoKk/CA3WSbKjKnU
         gIVDYJB59MPfjfChW2qL1JiMLXqKBXwinh3n2rILAK8pcpZvdlpHQ59nSE9fD0Xd+zj6
         VoSnQefjkojc76F/CEhHBIm2v+b1Z2TPYciV0f0a4K67CHXMF7dr6oTOzq3diXX1p2L8
         kAOw==
X-Gm-Message-State: AOAM532jAUXloodHny4z463mOy2rurFwzUeOvrtW1W4YBj1g8yV9eYre
        0lVf5b1XN15QDjl43DZInZA=
X-Google-Smtp-Source: ABdhPJwYPpqcLmh1APgGWbVUiV8sQc+3QfAra0qNQgr2jBSjvP1PggUkq5ZH6t3A+NBeDVWpyNSa6Q==
X-Received: by 2002:ac8:5850:: with SMTP id h16mr23621157qth.355.1620856594575;
        Wed, 12 May 2021 14:56:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848? ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
        by smtp.gmail.com with ESMTPSA id v11sm854434qtx.79.2021.05.12.14.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 14:56:34 -0700 (PDT)
Subject: Re: [PATCH 09/15] block: rename REQ_HIPRI to REQ_POLLED
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-10-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c687ee05-da4d-5f61-32ea-7a7292c3cf01@grimberg.me>
Date:   Wed, 12 May 2021 14:56:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
