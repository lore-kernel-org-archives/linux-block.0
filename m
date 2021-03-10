Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E92C433E9
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 15:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8953F64F6A
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 15:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhCJP0r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 10:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhCJP0W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 10:26:22 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1E7C061760
        for <linux-block@vger.kernel.org>; Wed, 10 Mar 2021 07:26:10 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id v14so15878789ilj.11
        for <linux-block@vger.kernel.org>; Wed, 10 Mar 2021 07:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0j+bHu3iXH8HjnjVM83afjyL/KXBL2oPI3bv48YdxXw=;
        b=ZQiRmhgRiDJM1ExEBOq9yi4Apm/6NTwVfFVloNORnQ2cRtlhBji3yuxdvhH5TxZYYf
         nlbz12Ei6H6RjF9X5prZwHq86Jy3vrJxnLP2GweM4GLocgAJGFJwaI1ic47udFXS0NqP
         wHxm0UojBmGq8cA73wvCz3HTnI4972hf0pjuPprCeIyF9/Z6vt7kb+TglvIc+x72TJuH
         Ihjz8Ud+/v/zOZaDcIfGLj0heCW8t9l0sMcb79dgaiobwOdwNtLDui70g5EB8DK7aiwD
         qDUht7Opqwv7chiRUL2mmGw8vyxqOgjxGkP1dnyzZGgBcc55MqFE20RB5EASQb64kKNU
         d3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0j+bHu3iXH8HjnjVM83afjyL/KXBL2oPI3bv48YdxXw=;
        b=QCKCCtsNw95X1gwbxE/TZ3lYdQ51LWZLYZCGVQttMMWKgRRYOqxJ/6hPLfW96U0dK+
         ZfgDE/zYb+xWeEi32UUsf7KRIdCvK65N71lOi10rI/u4sKPWICYaL8vLE+0PY50TIvfI
         f84gPRBDSXkXZ8x3WH7ONxysza81WFCPQX7aFjtSomxjGOrF4qn8hQXbFlxRxJ28gEp3
         FWVkpfkrIvr+KLi0ZPjTKmv1sctE1N5SalD8BO7OhJPT7Y3BFstoXXkTgDWPmqpx3cQU
         iPzj8b7/Y7+7AgGyxTD2/kaqpz34drWWn5A8Q4quACNG1/LuejfY8oEkSwy+41XhPY3j
         Gq2w==
X-Gm-Message-State: AOAM532svtu3cHDts9rAlFJ7dYIKBsKd54T7I9/3hflwd+2HwgQASLTb
        3sb9vkgHtc1xJMXGtUTPcqg1Fg==
X-Google-Smtp-Source: ABdhPJxpUkLNtdjCX87kdRLr6TBMJO2ghMIEJX8R88HRRF8L5KciBAuoui/STuMaqArpTkHC5a5EEw==
X-Received: by 2002:a05:6e02:18c9:: with SMTP id s9mr3075571ilu.265.1615389970003;
        Wed, 10 Mar 2021 07:26:10 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n7sm8971398ili.79.2021.03.10.07.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 07:26:09 -0800 (PST)
Subject: Re: [PATCH v2] block: rsxx: fix error return code of rsxx_pci_probe()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, josh.h.morris@us.ibm.com,
        pjk1939@linux.ibm.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210310033017.4023-1-baijiaju1990@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <746df289-a8d9-9b73-d37d-cffe44b36bc9@kernel.dk>
Date:   Wed, 10 Mar 2021 08:26:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210310033017.4023-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/9/21 8:30 PM, Jia-Ju Bai wrote:
> When create_singlethread_workqueue returns NULL to card->event_wq, no
> error return code of rsxx_pci_probe() is assigned.
> 
> To fix this bug, st is assigned with -ENOMEM in this case.

Thanks, this looks much better. Applied.

-- 
Jens Axboe

