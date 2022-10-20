Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2536C4321E
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 13:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiJTNYW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 09:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiJTNYF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 09:24:05 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2B318E2B5
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 06:23:58 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso2332091wma.1
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 06:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=wn6A08+GgO0+Y5DVjAUjPJDNKM+A35ocxeq0Zau+kNEGNqU3GyPvOwYnR67DWRKi6J
         CINwR/+lbFHbxqhPoEonEjWm1TtZ8Rmp/SLFan1oD11agkvAeA9Manvs+a+amyVHjtnu
         m8/wTas15VXuRMvzxtP7KTlYt3icdxmK6ZZf8wdMpxn0ns2QE1S/sZ+0LjCm3Nol04GN
         3gaBAmh2nMQkUy8g9iINx1fHbSYQccOqx5zsh5xxVgD4G/omMSCO5XNfKXbWzPgSnwCe
         MIT2SMmcJMp+2hLYYCHaiops0NiAyIXkRkT81H+XIK6dcjOGPetfuo2h2jRMlWtxzbl+
         aBxQ==
X-Gm-Message-State: ACrzQf1IqNk4VHkijZKJQbeca6X9iUg5le+cRfYMNzRQdVFY60HVa+lm
        EL2IxU3W8h+mcoOiT/cpILk=
X-Google-Smtp-Source: AMsMyM7K5WQPPB1FDyFXOQr28xu12GlQmwYpYnkorVNl0FM4LrMpfMZJ7ZSzoMz4I7K7yB7Kc03c2A==
X-Received: by 2002:a05:600c:4e8b:b0:3b4:c8ce:be87 with SMTP id f11-20020a05600c4e8b00b003b4c8cebe87mr31938678wmq.157.1666272229300;
        Thu, 20 Oct 2022 06:23:49 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4f08000000b0023538fb27c1sm2523871wru.85.2022.10.20.06.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:23:48 -0700 (PDT)
Message-ID: <a9d28250-e231-00aa-c104-5e14b9631a02@grimberg.me>
Date:   Thu, 20 Oct 2022 16:23:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/8] blk-mq: pass a tagset to blk_mq_wait_quiesce_done
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-5-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020105608.1581940-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
