Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F936C001B0
	for <linux-block@archiver.kernel.org>; Tue, 15 Aug 2023 15:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbjHOPws (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Aug 2023 11:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238329AbjHOPwU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2023 11:52:20 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551B910FF
        for <linux-block@vger.kernel.org>; Tue, 15 Aug 2023 08:52:19 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1bdcb800594so16882305ad.1
        for <linux-block@vger.kernel.org>; Tue, 15 Aug 2023 08:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692114739; x=1692719539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qo4PfR9xbM1AK5b4OTAfeynTIR1TdGolbHLR7+Oaxa4=;
        b=ESBsWnqH6Ag3voYKPodYI+6xmvX/bfQFEirAnKdwQQmxl/ilPXrHWyoQmbfiFq2Kec
         rWbExE+z05SDS5XqARLJ5z1qErrufU2c00zgRhlSdlwXAjhUK4PbDEhWkZZ75exRPNcD
         zyxTwPDcnkbjnoWWBAq7qjius3lcD1r7iebCNPr1LsCr0YhQQ00s1yvl53BUr9Ub5O0v
         QPeQTt1kJV8l7tAmTRfQ14F3ZtCkjA4vJCnLaRPFyIKVdedJL+JB64PfDh8xi/+KEx1X
         X0zWe+NzYNpY8Bsi1HPX0vvq5tuzJnaI7TYCCBXXKcq+lJ99FRJWghYH6X78aseyUS95
         JZ6Q==
X-Gm-Message-State: AOJu0YyhmtLpwQr7iNw+mSmSYJ3FsTuAvSmno8qLi23pKYYa0Og0vWJu
        BmMucWqsm9Jp38oJFu0S1BoovF9OsGs=
X-Google-Smtp-Source: AGHT+IFpsHHFG+SqjPVFAJqDm/lmOR4PmdOcBFhKuPuGngY9j4EI4ikhwexDU8JZ9BTLta6qP8rBmg==
X-Received: by 2002:a17:903:2448:b0:1b8:9f6a:39de with SMTP id l8-20020a170903244800b001b89f6a39demr6458885pls.65.1692114738568;
        Tue, 15 Aug 2023 08:52:18 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a40d:28ad:b5b9:2ae2? ([2620:15c:211:201:a40d:28ad:b5b9:2ae2])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902d70600b001bbb7d8fff2sm11163457ply.116.2023.08.15.08.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 08:52:17 -0700 (PDT)
Message-ID: <33f405a9-931b-117f-2b19-27269b2c4450@acm.org>
Date:   Tue, 15 Aug 2023 08:52:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] block: uapi: Fix compilation errors using ioprio.h with
 C++
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc:     Igor Pylypiv <ipylypiv@google.com>
References: <20230814215833.259286-1-dlemoal@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230814215833.259286-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/14/23 14:58, Damien Le Moal wrote:
> The use of the "class" argument name in the ioprio_value() inline
> function in include/uapi/linux/ioprio.h confuses C++ compilers
> resulting in compilation errors such as:
> 
> /usr/include/linux/ioprio.h:110:43: error: expected primary-expression before ‘int’
>    110 | static __always_inline __u16 ioprio_value(int class, int level, int hint)
>        |                                           ^~~
> 
> for user C++ programs including linux/ioprio.h.
> 
> Avoid these errors by renaming the arguments of the ioprio_value()
> function to prioclass, priolevel and priohint. For consistency, the
> arguments of the IOPRIO_PRIO_VALUE() and IOPRIO_PRIO_VALUE_HINT() macros
> are also renamed in the same manner.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
