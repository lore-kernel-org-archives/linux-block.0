Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7583CC4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 02:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiKBCLg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 22:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiKBCL1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 22:11:27 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B891D1F607
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 19:11:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so631899pjk.1
        for <linux-block@vger.kernel.org>; Tue, 01 Nov 2022 19:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SbmauVFQEmSan6s50E+MhbGNKyCBU02VL+TZxUeQNvc=;
        b=M+6ltjJ5juYg7+NGiSDbW3SJhCoF8ZcirhbqZgwnqfhdeVdnq1FE+jcF+gAUmbEzgT
         rSuyovaIt3fTj8NcAmCIK5xfoVJayD2gnhiSf16hf8Li+Yc1NjQLumbPCWcHZYqO+XdF
         70JydiNX8/oytfjKZu1L1vVAXNsT1GblP7RBnsquWb6JEJ2uSh8myzViPJp7DhRZy3ZV
         TxmKZNGoWjnhXzLaCiXtsslVCxYantmR2eF/MVu4y7AiwLx5cqdBlg9dpCvwYUybOBn9
         +6mkJWhTbD5eIIJ/sFblBn1EfXpJ5DdDvKWFIydo7dKhU1Jw5licT8E5O8COV9cSsU9Z
         OGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SbmauVFQEmSan6s50E+MhbGNKyCBU02VL+TZxUeQNvc=;
        b=NSLqf6tnl453NOH7TeW70eroqlZrrHDvXa1+p3rgYtBz9ewTP2z31tfeyunWmcQlK8
         7Xn+KbMRSg/dfLBYc1Whn5MX530pX+5tVt+g9R8QBROzSGOvCl8GV291+VX1atiWLYcO
         BngNHKYKwBdDBFHW7oH9UaEshYKOSOzCxhEGN86i65YVgaTKnwgRKYa6Bq8i2Q515NVd
         ZRCHwF3I/ypc8Fe9f6t70YlYh3cNVdpsWqlqigsXtWu8hMQ68Xhq2lExo1jrb/WAKAH/
         UySZZYxXHTnt0XsplVxo2HQg8YGQpLHVAx0lDcYaVH2EcRF2VuytTN8V0h9brGmFr/xY
         PXdw==
X-Gm-Message-State: ACrzQf3cYC+hUBJCNAW3eJyznFiOWimd1EHyjjBunx0X94kgOYRd6ta2
        PapnknCUWCF2iPSOHolzMeWMPQ==
X-Google-Smtp-Source: AMsMyM6wYADM1GOKososBsPffvmpio0j6uQg8CrGRaj0/JMxGsBOTUyfq1SQu+pxwjJSoGf+mb3a2Q==
X-Received: by 2002:a17:902:8212:b0:186:a260:50a0 with SMTP id x18-20020a170902821200b00186a26050a0mr22157997pln.157.1667355085207;
        Tue, 01 Nov 2022 19:11:25 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902e54100b00177ff4019d9sm7010977plf.274.2022.11.01.19.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 19:11:24 -0700 (PDT)
Message-ID: <ee543096-ae21-99d3-f3a5-483deab03a5f@kernel.dk>
Date:   Tue, 1 Nov 2022 20:11:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH -next v4 1/5] block, bfq: remove set but not used variable
 in __bfq_entity_update_weight_prio
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz,
        paolo.valente@linaro.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
References: <20221102022542.3621219-1-yukuai1@huaweicloud.com>
 <20221102022542.3621219-2-yukuai1@huaweicloud.com>
 <7f7e59cb-e0b8-0db5-7c46-11aea963bcfa@kernel.dk>
In-Reply-To: <7f7e59cb-e0b8-0db5-7c46-11aea963bcfa@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/1/22 8:09 PM, Jens Axboe wrote:
> On 11/1/22 8:25 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> After the patch "block, bfq: cleanup bfq_weights_tree add/remove apis"),
>> the local variable 'bfqd' is not used anymore, thus remove it.
> 
> Please add a Fixes tag.

Looks like the rest were good to go, so I added it myself.

-- 
Jens Axboe


