Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EA0C4332F
	for <linux-block@archiver.kernel.org>; Thu, 15 Dec 2022 15:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiLOPOR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Dec 2022 10:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiLOPNo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Dec 2022 10:13:44 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F6A31347
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2022 07:13:01 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id i25so8318444ila.8
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2022 07:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ettxvkoo48TgHt23PLScA7ThZLMXBN9lSxI8bDks3GA=;
        b=CulseMnsxDDcu8UWrwKdLaRzFiQJFVqNRgNAVYLhYWUp7xvEt1TgkJ4h8loklcSQTM
         40S36jyd6ZZrNueS7BOXSe3V3xYQtHbCCtlkuEwCiy3DWvcYPcbQ1uEyBTzsF3Bw6vWJ
         h6MrvpEetQT+I9d/6opAFfslyfGAO1egF5f1mNaAC+zoELw3bZYu5HgM814i8X3K4IKK
         hQgmDjFFN9+oGQO5asivEqFqvGX+7dRlVcp3W553xizk7fHddDOZajEIo8KTydVO4hHH
         HNYF2fzXmnnMFhOtdthDyClZCA/+C3ujsQMmsScQvbMNRUIdfU0crH8atjRmAxQcvhqL
         +bFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ettxvkoo48TgHt23PLScA7ThZLMXBN9lSxI8bDks3GA=;
        b=RIdB84Hu8x7TQl50rgxJBEPVve5ZtMbpvSFsX3zWc4d71pMivVL5bLSIti1SKC+kaW
         WREd/k69cFPm6fYOC0qbYNkphXTSWaIUYv9JERk7N1mT1D7ApeQm0NlUuW/1YxDmNmMM
         0Y3RJ8GAjSivY1lM/tPHQQVw61w+b7MrcBiSMvVO9T03jBcnIJOr3InG5A4hkJESuHeZ
         JGqp8wLb950sm/zJ/Sr43b+jf1WWXVcYeIyn8C4llISx1mASNE/3m25joYGFoAqvqr+d
         UC5p7lG4YHOY2/CsPgttDCeMqPdAXctj0S6KqvI/lN7DGI7VINJSGb/T3FyTpS3Y96Jw
         no7w==
X-Gm-Message-State: ANoB5pnKOAZV/QK+0gMaYiFLrsrLE2j80oSuFkDQD4AhUgfkS59qI4rD
        BXy6XAkMSJc5VUXlF6X9jyVTSA==
X-Google-Smtp-Source: AA0mqf7t5P4vPE4+oG1T9TGNc1CuX5DMzYvNEzYOz7NFAqNIUQPsrFjObobrYq6/3fi2KebfEyP9mA==
X-Received: by 2002:a05:6e02:ed0:b0:304:ac4f:a79b with SMTP id i16-20020a056e020ed000b00304ac4fa79bmr2343674ilk.3.1671117180838;
        Thu, 15 Dec 2022 07:13:00 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id bv23-20020a056638449700b0038a6d03db70sm2612714jab.34.2022.12.15.07.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 07:13:00 -0800 (PST)
Message-ID: <2a413c11-5e5f-7aa2-4734-78cabf393ba2@kernel.dk>
Date:   Thu, 15 Dec 2022 08:12:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH V10 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rory Chen <rory.c.chen@seagate.com>,
        Glen Valante <glen.valante@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20221209094442.36896-1-paolo.valente@linaro.org>
 <A0328388-7C6B-46A4-A05E-DCD6D91334AE@linaro.org>
 <0bcf7776-59d7-53ef-bfd0-449940a05161@kernel.dk>
 <PH7PR20MB50589A941F3F5A50C872E264F1E39@PH7PR20MB5058.namprd20.prod.outlook.com>
 <7125ff61-bf11-6f8c-8496-f2603371c214@kernel.dk>
 <3479E7A6-8CAD-4A32-A0BB-00A851883EA7@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3479E7A6-8CAD-4A32-A0BB-00A851883EA7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/15/22 8:04 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 13 dic 2022, alle ore 18:17, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> Please don't top post...
>>
>> On 12/13/22 10:10?AM, Arie van der Hoeven wrote:
>>> We understand being conservative but the code paths only impact on a
>>> product that is not yet in market.  This is version 10 spanning months
>>> with many gaps waiting on review.  It's an interesting case study.
>>
>> That's a nice theory, but that's not how code works. As mentioned, the
>> last version was posted 1-2 weeks later than would've been appropriate
>> for inclusion.
>>
> 
> So, what's the plan?

Looks like 1/8 and 8/8 still need Damien to review it, then queue up for
6.3 when ready. Not sure why this is even a question, it just means that
inclusion is pushed a release out as it missed the current merge window.

-- 
Jens Axboe


