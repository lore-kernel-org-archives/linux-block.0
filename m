Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E9EC433F5
	for <linux-block@archiver.kernel.org>; Fri, 24 Dec 2021 00:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350461AbhLXAzf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 19:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350445AbhLXAze (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 19:55:34 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB6FC061401
        for <linux-block@vger.kernel.org>; Thu, 23 Dec 2021 16:55:34 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id b187so9158360iof.11
        for <linux-block@vger.kernel.org>; Thu, 23 Dec 2021 16:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S/bUBMGyS87hIhz1yDVLMVnif3yIPsXTuqHAs6Zb//Q=;
        b=CHbYhHYgqmVNp3xuJVyaeCyoFlIfB6sHY+uNaIDoB6zgzf18jiee3Lf/Uo5VQWwJtq
         BYvCXVDXJUfO2S+JLyoo8Rw3Vce3AuQs/1Vk0AmpIbF8nlbYZo8j0c7DtRlUUExjDu/+
         g0rota+I5TBL0Vgy3NKUt0kUBUXS2ZDmzkQig3WKIcp5f3N3V+Gey9TLQ2ufehzFTgDd
         R2CjBPSfNe+jD6lzJaEI0ROgTD0wK9VdR2QrC+/RxpHwH0jekUhRv+QsHrePy3Mdyyjs
         /mp/Tvd7lsy5fNP6EUnRnHxCnFidPBrn3vSd+1T+NO+lD5tvbZ6pF3Rqgm67X8Z9Sqgi
         XQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S/bUBMGyS87hIhz1yDVLMVnif3yIPsXTuqHAs6Zb//Q=;
        b=Vd/CxdLIlGDPfoWm+qg4QAEO8Qm6VtM6WtR8IJpQuUHf1Y3Vr8XYiWqWX6ZdFSMUnD
         VPpJJV8LkOKMI21PDoS27hmXuU8L7BaEukghgXL9D5Cse/Ih7AAc0kfsR6xR6lVix1vE
         OexTOESAIEFFxKupFWN8S7xqior7ZNLhOWgBU6GCflSxzsCiI1+bIShKcmo313FoVXLQ
         s+qQ115JNOwtkEO16OPlmu3+pPkog7dRTLGGvpNoVc584AR59wp0XZ2lb6BqgZY4Y4ZH
         1etYbceV5rxr0VSa8qy8wJ+0QN/Qt4Pkpho7K+26aAqt1MCVTbcxAfKdDyXjYQFA3P6D
         WqYA==
X-Gm-Message-State: AOAM531XtPgh1kp8+ixZSUXNgEFk8PfOEVrlPLCftlZYzYm+cRYNPNOJ
        MGVV+DanysxdtJagSwCnAbmubYffBPFJAg==
X-Google-Smtp-Source: ABdhPJxvF4iQ6fb0XhN880yhLwq1lkxo57Qu/phG8pLb4thwTg+xAc51NhDyGkf3/ITI3A0UOTKwWg==
X-Received: by 2002:a05:6602:1495:: with SMTP id a21mr2303954iow.79.1640307333417;
        Thu, 23 Dec 2021 16:55:33 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g20sm5006412iov.35.2021.12.23.16.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 16:55:33 -0800 (PST)
Subject: Re: [PATCH V2] null_blk: allow zero poll queues
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20211203130907.3667775-1-ming.lei@redhat.com>
 <20211224005237.ryuyjrrn63t7y7sa@shindev>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8b1f05d7-c741-24e3-be67-bf3616ff1931@kernel.dk>
Date:   Thu, 23 Dec 2021 17:55:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211224005237.ryuyjrrn63t7y7sa@shindev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/23/21 5:52 PM, Shinichiro Kawasaki wrote:
> On Dec 03, 2021 / 21:09, Ming Lei wrote:
>> There isn't any reason to not allow zero poll queues from user
>> viewpoint.
>>
>> Also sometimes we need to compare io poll between poll mode and irq
>> mode, so not allowing poll queues is bad.
>>
>> Fixes: 15dfc662ef31 ("null_blk: Fix handling of submit_queues and poll_queues attributes")
>> Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> ---
>> V2:
>> 	- fix divide zero fault as reported by Shin'ichiro
> 
> Jens, Ming,
> 
> I find the V1 was applied to the for/5.17-drivers branch, and the additional fix
> in the V2 does not look applied to the branch. Do we need another small patch to
> cover the delta between V1 and V2?

Yes, please send an incremental, thanks.

-- 
Jens Axboe

