Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6251BC61DA4
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 18:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjBBSEf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 13:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBBSEe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 13:04:34 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45718A45
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 10:04:33 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id i17so1079300ils.11
        for <linux-block@vger.kernel.org>; Thu, 02 Feb 2023 10:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6qLMz+qMXqMm4lW5hZAYRDQhlxm5agYKUAS7pclvdZs=;
        b=EtBx4IPcuMyu0JbrEH8H0l3y4rd4ZgArOs6BwRj+KFnBrozeuhe70SBpFBCltqBjiS
         yPgODyKT0kkexlEPaLBInukQgRXU2ZY9iZqGm7HqJo+nDXC+KNrRK6jvrbc1QmlMVtG2
         Be7m+yXW5/5jaA5ASe8+jIkhGbGjDCYlXOhJIEf+yQb7ZOwGr3qUc0I4MEDNnXSXuCOx
         +eoFBjtJHAjy2SlK97ue4Wy4pStStjM3sW+QRU9UHV1PS0b4PhPIOZQ/iLbF02QmaL9J
         KM6+v84AqsQJjgK+ZbQoq6U3YQVLpEWC7euOlpMv1zhOXRrt8Pc3fOddxaQMTHhTaJVR
         0XNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qLMz+qMXqMm4lW5hZAYRDQhlxm5agYKUAS7pclvdZs=;
        b=ydeqKdkldG/ldDgfsA8G3n2Tm3SfcKNrlH+wb1AokgJjY6iKmgaPiWdc7dcwyHWFzJ
         Cr/fOmjP1HCJyuanRARK7ohovJ/LRZx7zBjoOibQkKvi3xItqKqAdR+CSekMcN7noOKU
         byfvKD60yQu6+tYKBWV9ldqWKVLG3DQQIDjBB/KyZ7ARByz8dJ2s7uqY44lJY9Jn3FWt
         42qk/BOc667Zef4KrkEaIqqcOmujoWRElEZbE+xo//JgNmyN18F253ktqs/YHuRYFU8S
         M2XyJiRrZP+P4HcdtW8w5zXjfgbpPR2GBu3S0hf5UF4e7vvgSbZ8JMshKggPfDIRDMOa
         Kqnw==
X-Gm-Message-State: AO0yUKUyrom2GNozf4ZfiKcWQL8G4GsOpm8LGy8LQJlCwUTcG7ievQvl
        FqdESrkEfMTlFpVz+cG+9LQI0w==
X-Google-Smtp-Source: AK7set8zuxW2dctQgNgIGxeyWkcUIsZDjWjef9Vfvjyzi5BaHMyVum7f0R5cPDPC+sOe47s2hFEFsQ==
X-Received: by 2002:a92:c5b2:0:b0:310:9adc:e1bb with SMTP id r18-20020a92c5b2000000b003109adce1bbmr4306337ilt.0.1675361073181;
        Thu, 02 Feb 2023 10:04:33 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j11-20020a056e02218b00b0030bf2476c5fsm100884ila.25.2023.02.02.10.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 10:04:32 -0800 (PST)
Message-ID: <f6fcf969-7f66-17dd-f9e5-df68786e229f@kernel.dk>
Date:   Thu, 2 Feb 2023 11:04:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] memstick: core: Imply IOSCHED_BFQ
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
References: <20230131085220.1038241-1-linus.walleij@linaro.org>
 <CAPDyKFqCMZLOte6Fd6oJgTMXaMYMTiRsZKSJu-YJE+nWYTpQ6g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAPDyKFqCMZLOte6Fd6oJgTMXaMYMTiRsZKSJu-YJE+nWYTpQ6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/2/23 8:22 AM, Ulf Hansson wrote:
> On Tue, 31 Jan 2023 at 09:52, Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> If we enable the memory stick block layer, use Kconfig to imply
>> the BFQ I/O scheduler.
>>
>> As all memstick devices are single-queue, this is the scheduler that
>> users want so let's be helpful and make sure it gets
>> default-selected into a manual kernel configuration. It will still
>> need to be enabled at runtime (usually with udev scripts).
>>
>> Cc: linux-block@vger.kernel.org
>> Cc: Paolo Valente <paolo.valente@linaro.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> For the similar reasons to why I applied the MMC patch, applied for
> next, thanks!

And a bad idea, for the exact same reasons...

-- 
Jens Axboe


