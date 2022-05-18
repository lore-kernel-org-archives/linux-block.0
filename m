Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FC7C433EF
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 11:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbiERL5P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 07:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbiERL5O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 07:57:14 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61A09FFD
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 04:57:10 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id n13so1460798ejv.1
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 04:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ElQAKyjQFa361iQ5iFu5WKH/Z6KV4gAN90eFfU58mt4=;
        b=H+020fn242MCnYxckPJizGvYGIyDO2UafYbgpMTkBY55ukKqOs5mLOV5cZ4KJmcwGu
         vdI+L2xBsHk6dAO6SSAGG66nr8BGHF9TRI6KRavmb+sVEzooDPL+v0Ib7T8cNbOtF/AY
         boiPGrD32c3vMQD3pnnbWZECYcxwfvfKnHePZPdb5I73xoCoHOlb+UG+gBTAD0QdbSrb
         MMohOfOZnOqJjI1vZZpV/lzB4jCbZMBdXhf2i/b19lnDxIiJ4pGoyJvoiGJYcwgCQP3k
         qsoif0jvZpjunp4ipOXZGkR0N6Q8yE8LF+m8VCWO+XyendbRkkmisdl6gPiX3TqO+FxL
         +M1Q==
X-Gm-Message-State: AOAM532A9gCDFLcyGEXzZQ8iOfbJ2dzNEdW2KuidPJxEVbzySltlliY2
        orKr+J6GBiHl1XhOceYY80lqyt21svSX/0BE
X-Google-Smtp-Source: ABdhPJy0TtxrnVsP4iwuo+DNj4eHXk8kP44KUOS8kx/zQlkflUHMc6Lzt7npYOGAqWM0tIeti6jegg==
X-Received: by 2002:a17:907:1622:b0:6fe:22bb:7f8 with SMTP id hb34-20020a170907162200b006fe22bb07f8mr16984462ejc.767.1652875029296;
        Wed, 18 May 2022 04:57:09 -0700 (PDT)
Received: from [192.168.50.14] (178-117-55-239.access.telenet.be. [178.117.55.239])
        by smtp.gmail.com with ESMTPSA id 28-20020a170906015c00b006f3ef214da8sm911028ejh.14.2022.05.18.04.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 04:57:08 -0700 (PDT)
Message-ID: <606e9f86-b546-960e-5005-7a7827e1b1e6@acm.org>
Date:   Wed, 18 May 2022 13:57:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH blktests] srp/011: Avoid $dev becoming invalid during test
Content-Language: en-US
To:     Xiao Yang <yangx.jy@fujitsu.com>, osandov@fb.com,
        yi.zhang@redhat.com
Cc:     linux-block@vger.kernel.org
References: <20220518064417.47473-1-yangx.jy@fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220518064417.47473-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/22 08:44, Xiao Yang wrote:
> $dev will become invalid when log_out has been done
> and fio doesn't run yet. In this case subsequent fio
> throws the following error:
> -------------------------------------
>      From diff -u 011.out 011.out.bad
>      Configured SRP target driver
>      -Passed
> 
>      From 011.full:
>      fio: looks like your file system does not support direct=1/buffered=0
>      fio: destination does not support O_DIRECT
>      run_fio exit code: 1
> -------------------------------------
> This issue happens randomly.
> 
> Try to fix the issue by holding $dev before test.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
