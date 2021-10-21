Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E53EC433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 16:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA3A610C8
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 16:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJUQuS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhJUQuM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 12:50:12 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4D7C061764;
        Thu, 21 Oct 2021 09:47:56 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s19so45878ljj.11;
        Thu, 21 Oct 2021 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=teoHzi6Hmm/OVFrA0e8JXtWu9N4wtV6Jv4Y9vx/yxR0=;
        b=Ke7CiYkPNKFISeqO2ZhVh8+k0kvSAIk683PKPVHhtsHDtLhVwn2f+0hQSJJ7r6orGa
         B7BfSVZoqpWcB5YqNDCuDGJER0BOzTnlUMKZa9tsTfEfZEHCcfLce7MCivrazcR5Tnd3
         SMS4TH7DYlBA7ePK8tge9BjdQon1+5LLQHE17eN7i5JbEC9zfejp+6wbwSCyDBv2C43r
         z7fYucPtrEa1/61dIb/hM86y0hhxKSbbpEsVuOT3+9gNpfGUIxkSyjANFOwaH2SIQwq0
         DGdt/pm2SEMvQZJ7YthPL5Je99dXF8sOqm4+IMv+79hL6yaHt8Kmst0GGoPAlL+bA+AV
         ouDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=teoHzi6Hmm/OVFrA0e8JXtWu9N4wtV6Jv4Y9vx/yxR0=;
        b=Cf3QPf+H3Q36dP/MoM0PZ3ASnHNOynNKt31whHxrSYLwTOCAXKJAcgE7WDiOqDtOtw
         YfxFiIAhRyzNvoAztF8UMEvgMzum6ZnliPZq0sKIjI/dwHbO/T1rfXP1HXMs70yymEKo
         oIjpdzDUO3EI1D9OhWHg/sfdhtXrKJ6pEb7Mh04N2NW9uO5YbVfU8Y96Qwd8Xlihg1TJ
         i6vCvNQNxiCxNsulNCe7EWeoHkMfCS/Gb4bu9lyNQogv7GAGh8yXVP9qUCAc49s8D4cP
         rDnOYDGaAS2gifRD2s71re03bhbQOnEkKJgpkW+ON1ZbHR1zQ1QySRC0sthaHI55osVC
         i+5Q==
X-Gm-Message-State: AOAM533kNVKYaEylmDK6Y8clXO0EMZE9hvilJGmwo64bV4Sx76xz0az8
        TV/ClX7REP096QNYnO5Gfq0fetdTEYM=
X-Google-Smtp-Source: ABdhPJxytDT9pDTb/bTC5dE5btSmvHObDmj7vUPhohHmYJletZw2VYtYZK0DWFzBUGXcNRT8AnkTrA==
X-Received: by 2002:a05:651c:32f:: with SMTP id b15mr6862293ljp.318.1634834874386;
        Thu, 21 Oct 2021 09:47:54 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.235.181])
        by smtp.gmail.com with ESMTPSA id o6sm507091lfr.19.2021.10.21.09.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 09:47:53 -0700 (PDT)
Message-ID: <8f6f738b-2d74-1778-648a-dc62603319d0@gmail.com>
Date:   Thu, 21 Oct 2021 19:47:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 0/2] nbd: fix sanity check for first_minor
Content-Language: en-US
To:     "yukuai (C)" <yukuai3@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        luomeng12@huawei.com, Christoph Hellwig <hch@lst.de>
References: <20211021122936.758221-1-yukuai3@huawei.com>
 <72fb140d-609b-c035-bdd6-d2b8639c116b@gmail.com>
 <17182476-e5bf-f493-9d9b-fedb2d9c8e1a@huawei.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <17182476-e5bf-f493-9d9b-fedb2d9c8e1a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/21 16:13, yukuai (C) wrote:
> On 2021/10/21 20:35, Pavel Skripkin wrote:
>> On 10/21/21 15:29, Yu Kuai wrote:
>>> Yu Kuai (2):
>>>    nbd: fix max value for 'first_minor'
>>>    nbd: fix possible overflow for 'first_minor' in nbd_dev_add()
>>>
>>>   drivers/block/nbd.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>> 
>> Hi, Yu!
>> 
>> Thank you for the fix, but this wrong check should be just removed, 
>> since root case of wrong sysfs file creation was fixed, as Christoph 
>> said [1]
> 
> Hi, Pavel
> 
> Thanks for your response, with the root cause fixed, patch 1 is not
> needed anymore. However, the overflow case in patch 2 is still
> possible.
> 
> Does anyone plan to remove the checking?
> 


Hm, I thought it was already removed, but I was wrong, I guess. Let's 
see what Christoph thinks about this check.

Maybe add_disk() error handling is still not in Linus tree, I haven't 
checked yet. Sysfs warnings _should_ be fixed by proper error handling, 
but maybe there is another problem somewhere...




With regards,
Pavel Skripkin
