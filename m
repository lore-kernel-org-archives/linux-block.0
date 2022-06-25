Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1640C433EF
	for <linux-block@archiver.kernel.org>; Sat, 25 Jun 2022 00:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiFYAC0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 20:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFYACY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 20:02:24 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A758BEF2
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 17:02:20 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so7115616pjm.4
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 17:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Lf03RjqGuq6g3C7TbckjuIYKCNhKQOgqkScZcfknxbw=;
        b=reHWZZG1cYIuWPQu4P0yNBEBWje06yw5gj41Mwy0iVLYlNZWVicQbgXthAasT+ZTWO
         Aep3eprbzYwY+stsxDvdtAxdQUpjtGU/69l+xwd5f5Jkw+AAFl4P4PDy4smbR9BbeVGk
         G1Bma6uygl8EEoIijxSTGilOsDkVg5EWuPhEoLGvc67hDih2qjtv0M/GXLPyaLGmdi0Z
         +JirHrjGhEyShCN+b97I1b1Y2EB8b0XiSbRVBsHojKEado2kR+sA1o0FvIR1tZDP24aQ
         4KyCPsqsSY+JPgFGDZwv6ao7Oyr4HXFzjSYpkpWUcZd6PORtstviwSdyulbkSS/DSl/H
         trRg==
X-Gm-Message-State: AJIora9MCuOv2+llmbJlz9OuG/0fWKTZrgWJKdYg2Zb48m8Otpyr7ZME
        WKR6g5kCMZMOpv2+tmmE37DaPesW54k=
X-Google-Smtp-Source: AGRyM1s8pHnn0bw+QtMbDb+pEl0Z47+c1gZpmAfsfLxJ4ROkmVta7cgoBzlhX+7mpKnl0fqF6s9TCA==
X-Received: by 2002:a17:902:c2c6:b0:168:d8ce:90b2 with SMTP id c6-20020a170902c2c600b00168d8ce90b2mr1640137pla.110.1656115340062;
        Fri, 24 Jun 2022 17:02:20 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:4e1:3e2c:e2fe:b5e0? ([2620:15c:211:201:4e1:3e2c:e2fe:b5e0])
        by smtp.gmail.com with ESMTPSA id je20-20020a170903265400b00161f9e72233sm2341297plb.261.2022.06.24.17.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 17:02:19 -0700 (PDT)
Message-ID: <d6ce8f96-18af-e5b2-6ce4-3ef24b084a81@acm.org>
Date:   Fri, 24 Jun 2022 17:02:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 46/51] fs/nilfs: Use the enum req_op and blk_opf_t types
Content-Language: en-US
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20220623180528.3595304-1-bvanassche@acm.org>
 <20220623180528.3595304-47-bvanassche@acm.org>
 <CAKFNMonCrSpx0RMdPfMXfAvfe3ZQeVae=QYbgi1iO3pTRUnD-w@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAKFNMonCrSpx0RMdPfMXfAvfe3ZQeVae=QYbgi1iO3pTRUnD-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/22 20:43, Ryusuke Konishi wrote:
> On Fri, Jun 24, 2022 at 3:06 AM Bart Van Assche wrote:
>>
>> Improve static type checking by using the enum req_op type for variables
>> that represent a request operation and the new blk_opf_t type for
>> variables that represent request flags.
>>
>> Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   fs/nilfs2/btnode.c            | 4 ++--
>>   fs/nilfs2/btnode.h            | 5 +++--
>>   fs/nilfs2/mdt.c               | 3 ++-
>>   include/trace/events/nilfs2.h | 4 ++--
>>   4 files changed, 9 insertions(+), 7 deletions(-)
> 
> Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> 
> I've checked this patch, picking up some of the block layer patches needed
> to understand this conversion from the list of linux-block.

Hi Ryusuke,

Thank you for the quick review.

Does "picking up" perhaps mean that you plan to send a subset of this 
patch series to Linus yourself? I prefer that the entire patch series is 
sent to Linus by a single kernel maintainer.

Thanks,

Bart.
