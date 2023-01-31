Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9B2C636D4
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 17:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjAaRJL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 12:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjAaRJE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 12:09:04 -0500
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1A62A150;
        Tue, 31 Jan 2023 09:09:03 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so19804759pjq.0;
        Tue, 31 Jan 2023 09:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDzPWgoV39PuI2zsVUHpuZ+LlLjcbOcfzijWPXUhDbA=;
        b=jWYe9bi7+YU9c8P82w6e3b1aXMGDbrxDmL8tZUenFfMEnhuCU1vPDJAIx6gyKiWI4X
         59lNzXBQmyHN38FHwMXCmrl3IBkDjnmCfvqj8Twp6uMsoE+zTGNF69+UMjHqryQb7DOw
         Y2c5kSVv69sue6nmEdluX3J2zXritBsLazCXW6N+igiVbyh0A9TZYKO5rqBicGOvkdeC
         XBEZgRr4TPpDj0jfgcrGYdrTHdbr4u1JSmfXSXQMuKp2Dk0sd+vi/tIqjiaFcUsRVI7S
         XPfbF6e3lKdU+I1Eqad3EDN6KuJF7BbTnJ0ChnByAzdAqjyhCsNNqlvm2Ovs9SX0nprX
         rRsA==
X-Gm-Message-State: AO0yUKWk4oehxtD2kO1hsBlpLwfNWVbm1ejjlCP9QlgxOeTSJvxuuRmJ
        7C3I44/ArTGlH4sIu/+A6iA=
X-Google-Smtp-Source: AK7set9TCTh4wUIRfAPtnFk5yCKafQHgCadPmFMQf598lpAiU+UXG/3e92qRZ+mc2gSYoMV8hd3k9w==
X-Received: by 2002:a17:902:f283:b0:196:6c8c:289a with SMTP id k3-20020a170902f28300b001966c8c289amr9795926plc.20.1675184943255;
        Tue, 31 Jan 2023 09:09:03 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:7e97:ee02:2248:2471? ([2620:15c:211:201:7e97:ee02:2248:2471])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902edd100b001960d05991asm10079442plk.37.2023.01.31.09.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 09:09:02 -0800 (PST)
Message-ID: <51de158c-65f1-6506-1303-9d4bfa90e3e3@acm.org>
Date:   Tue, 31 Jan 2023 09:09:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] memstick: core: Imply IOSCHED_BFQ
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Christoph Hellwig <hch@lst.de>
References: <20230131085220.1038241-1-linus.walleij@linaro.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230131085220.1038241-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/31/23 00:52, Linus Walleij wrote:
> If we enable the memory stick block layer, use Kconfig to imply
> the BFQ I/O scheduler.
> 
> As all memstick devices are single-queue, this is the scheduler that
> users want so let's be helpful and make sure it gets
> default-selected into a manual kernel configuration. It will still
> need to be enabled at runtime (usually with udev scripts).

Do users really want the BFQ scheduler? Has performance of BFQ been 
compared with iocost (CONFIG_BLK_CGROUP_IOCOST)? My colleagues are using 
iocost instead of BFQ in resource-constrained environments.

Bart.

