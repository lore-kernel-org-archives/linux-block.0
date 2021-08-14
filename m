Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBFAC41537
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 21:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA83860F4B
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 21:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhHNV43 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Aug 2021 17:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhHNV43 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Aug 2021 17:56:29 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B89DC061764
        for <linux-block@vger.kernel.org>; Sat, 14 Aug 2021 14:56:00 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e186so17988223iof.12
        for <linux-block@vger.kernel.org>; Sat, 14 Aug 2021 14:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cik4PkWz8KNI5fSNeM1dfyf7wBI4o71vCpQKBD/3bM4=;
        b=V79e6sQSa+d46un2tOeLkh6YC1seloppBq3gfU6j9L58ecC+q1OiPSnlKCWbLXSD8X
         Pa9ceGt5Y0wTDqdk30r2bWKQYPlVf7ddHyl4rARu+527eJOWv/LyhQ5nGic57g36Q7J2
         HgfgeSO76t2r4RRQDbTziJsuuZPiPjw/hMf56/PrILYhDScESdrlfBl4N/QqLrinZ0wP
         qHDcj0Jl6+XM+oh9pdQX2DlnPvNHe5P+YPni9ZvND4VTfAqdKFh3Qa6PI/f8UT5gZG5K
         Hhom2uogZYbPy+AHKSlpo/HLP99EpF5HagY2ri+5zxsOe8brahhDWpprETnPGSn1lVPK
         SRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cik4PkWz8KNI5fSNeM1dfyf7wBI4o71vCpQKBD/3bM4=;
        b=RPSQWdKlKNEPLUPwMZ2snvLTFAAED+LDDgFZj76iLhPOHW7VHv+Rp8uromjNrzsDfe
         khWt6uImcgGrhaatkfeUJpGPpJ0nQ1V1CR/mH5xwRmm+ZjSvUG9aX9/hYO/zHFt+tPMa
         4yUkCjiJHyyqGbAAa9BVUNWeqeYUGqtPHjoPewIBldeFaZSjPiPx/IkUfpo/BVchQf6C
         HjlRRpo88GIdrH0E9tLDn6wI53XUY+WRf/qak1kIx7POhwRTHL+OOdlBdjBN5Gv5vXI3
         Lmy+3rXJJrEn7rJMOR9kFsVjUtftOv2/zwofNAthrbNY0o3KouhAC2TRTc4VUAZneMXq
         O1IA==
X-Gm-Message-State: AOAM532jbq4vTp+iVr/Z2GTUSv9nRnH0j67nAvZ1PMZkbmrO4RaIMkFv
        LNX5lUvVdBxcZh/yczxHoPPy9SESZAaqmTAU
X-Google-Smtp-Source: ABdhPJzQjZj/g63qfDqlcuAIXlpV0ehzDqzSQ3CekblgpP5Y2V2+sS96ePnaoo2w91dSJZoNLVxMvQ==
X-Received: by 2002:a05:6602:198:: with SMTP id m24mr6675828ioo.144.1628978159572;
        Sat, 14 Aug 2021 14:55:59 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l5sm2997740ion.44.2021.08.14.14.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 14:55:58 -0700 (PDT)
Subject: Re: [PATCH] remove the lightnvm subsystem
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <512bf4a4-fc60-36d0-adae-93caaf0441d2@kernel.dk>
 <52C4BBAD-21CE-4CD2-8B21-90ACEB4E4B01@javigon.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4d41d177-4178-7275-53c0-bfcf0e399a95@kernel.dk>
Date:   Sat, 14 Aug 2021 15:55:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <52C4BBAD-21CE-4CD2-8B21-90ACEB4E4B01@javigon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/14/21 2:42 PM, Javier González wrote:
> 
>> On 14 Aug 2021, at 21.30, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> ﻿On 8/14/21 1:01 PM, Matias Bjørling wrote:
>>> Thanks, Christoph.
>>>
>>> Reviewed-by: Matias Bjørling <mb@lightnvm.io>
>>>
>>> Javier, if you agree to the removal of the subsystem, would you like to 
>>> provide your reviewed-by as well? Thanks!
>>
>> Side bar - please don't quote 400k of text, this reply really didn't
>> need any of it.
>>
>> Pet peeve of mine, and it happens way too often on reviews as well.
>> Don't quote the whole email just to add Reviewed/Acked-by, it's just
>> wasteful.
>>
>> -- 
>> Jens Axboe
> 
> Looks good to me. 
> 
> Reviewed-by: Javier González <javier@javigon.com>

Thanks, applied.

Christoph, looks like at least the NVME_NS_* enums can go as well.

-- 
Jens Axboe

