Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AE5C4338F
	for <linux-block@archiver.kernel.org>; Sat, 21 Aug 2021 03:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840BA61178
	for <linux-block@archiver.kernel.org>; Sat, 21 Aug 2021 03:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhHUDPj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Aug 2021 23:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhHUDPi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 23:15:38 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BE8C061575
        for <linux-block@vger.kernel.org>; Fri, 20 Aug 2021 20:14:59 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id i7so14747101iow.1
        for <linux-block@vger.kernel.org>; Fri, 20 Aug 2021 20:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CxUCvmjcBRFq4m4dqLAxpbGmHPHIelGpMmv1fs6RFQI=;
        b=Hm6notkOzdrGazAxfSApq1eWmnoMDuhiH64VhYtuosajG8fnEDzJUOWWsM8nShTw+7
         BJLiyuoPxi0jETPlqccE2q8n+1V0MbKnwr5TtOGOirLnzxWnKTnvIPG6Isf29A7OU2uK
         KM7bzH59gnz1TcY7RFGOCZ2EuRbghAJ2tCl2fKP0uvsg6pizwZslHrd0vJ0YhDXZDY3T
         TcMBMH4aTLHdrLibfUSyZzbzqQrQvvjgttWeK3r+ZDmJw4vqeFkr0WYa71i6DyiNTxRY
         7Z4EJK2JQ2BcHC0Ish/WOd6iEOMaj9w0bU+XJeeiGNtGOEpxFKNSPLKPBfWLpmf1bPs+
         M5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CxUCvmjcBRFq4m4dqLAxpbGmHPHIelGpMmv1fs6RFQI=;
        b=lZhvfWCqJy6CV5iF8+k4KfEGnYxNV0lkkBFp+WrmpvIlkTBGj4D6RCHPgxUQV2EI+N
         LLD3rW+Gr3kBZmsdRmNHNvdcs/vyXhLQe1t248ewZmo4utKWzGcnry4MSKqtcxjN+drx
         m5cru7QjJXPpt2iFjWSat7PFUwPf36DmMGxWriml+3GFPHsksOv/ZhjLUY6HgVgJINCh
         GZmTtq6+3nm+i/KPQwMQQSp1rxhOgni7R9yCbSA2rUFHzWR7PsApXrVaRtt0FNxSw43m
         9UPYs0I1BEw55mIUsTVlOhGCwj05WXlu19gEFK/UkovuYJBZMbFHj+Sxb0c30uxWF1FS
         w1QQ==
X-Gm-Message-State: AOAM531g0ESOVsUuDiJ6oiUxl73+rm6AilYKXEuUFAAJGRMJs/Ylqm7q
        Kz/T6HE1tHblbVGuZAODAjqQjA==
X-Google-Smtp-Source: ABdhPJzQtvXO2c651dfie5D6MxeCtD2vEpi+4+KSF18A2i1wUjVuxOR7Vz8d1X0yUXAvhWTDC/VcqQ==
X-Received: by 2002:a5e:dc02:: with SMTP id b2mr17660736iok.197.1629515699335;
        Fri, 20 Aug 2021 20:14:59 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id a17sm4739903ilm.27.2021.08.20.20.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 20:14:58 -0700 (PDT)
Subject: Re: block: add back the bd_holder_dir reference in
 bd_link_disk_holder
To:     Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, tusharsu@linux.microsoft.com
References: <20210820094929.444848-1-hch@lst.de> <YR/kdG/J0odIzGsF@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <86e6cbfc-997b-10b1-2547-0ec243d1ee1d@kernel.dk>
Date:   Fri, 20 Aug 2021 21:14:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YR/kdG/J0odIzGsF@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/20/21 11:20 AM, Mike Snitzer wrote:
> On Fri, Aug 20 2021 at  5:49P -0400,
> Christoph Hellwig <hch@lst.de> wrote:
> 
>> This essentially reverts "block: remove the extra kobject reference in
>> bd_link_disk_holder".  That commit dropped the extra reference because
>> the condition in the comment can't be true.  But it turns out that
>> comment did not actually describe the problematic situation, so add
>> back the extra reference and document it properly.
>>
>> Fixes: fbd9a39542ec ("block: remove the extra kobject reference in bd_link_disk_holder")
>> Reported-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Looks good, thanks.
> (btw, your linux-block cc had a typo, Jens are you able to pick this fix up regardless?)

Yep, just did it manually.

-- 
Jens Axboe

