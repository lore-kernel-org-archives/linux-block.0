Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37994C433B4
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 17:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F176B6113E
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 17:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbhDBRTS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Apr 2021 13:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbhDBRTR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Apr 2021 13:19:17 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB86C0613E6
        for <linux-block@vger.kernel.org>; Fri,  2 Apr 2021 10:19:16 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h7so5139584ilj.8
        for <linux-block@vger.kernel.org>; Fri, 02 Apr 2021 10:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n9t3wl+aIaIAZECVmkEuegnBg3eSPluOx0fOhXaANUc=;
        b=075Mj1LD5FUW0P2tnosCFysgXh6iyGYeaGX9KsF1nThmxjgnpR0NJdwC+pi9fVzAdG
         zCyT2KL1Mom4d4dYw7XYNfprHG3dKCLlyUJWZ1B3M6rlwgi/KE3cUEcec4POyWxg427N
         M0/2ibjwrnWVCkBkINQDkzYtWT/sfGKpO8WBXb7bPZPZi6WLW8n2gJ/fwZhcGognqrhi
         lR2Kp4x64tKFf15Web4OGTxD6u+RlG4qLS1NATb4O+65E4A2TAeVeD9UTb1hFKL+1HxP
         G5owDJGZOd+aZwiuJCTR6KbTcowOFHSLDGFY9WAlj+xUEWV9xNnZN0C8cA6YAQxBYiQh
         ozpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n9t3wl+aIaIAZECVmkEuegnBg3eSPluOx0fOhXaANUc=;
        b=pHxo9dQfEooZeIxQUNqw8nIz7gnNODtm5yKET6VnaDA4rbOXJeeuxJioMfNy5VmmSs
         La0JtMWDWFapz/j9reoSzLosL7p5S2UIgtQacD9+sIH0cZfcv9kZLLrvi3MngV62YZQE
         XKFICJZlEV5vCjo51rZb+3oebtvpi6bgRLD/xxPFIt3Ajfw2AdHYMwWbnFNXUZ/aAzuW
         nb9SGUU57O8wXpBrLtWjwrkF47uRzsZjLKpzUoEiEUJoq70H8FTgtRsyqv3BHIXdqis7
         v28VkfMj/3A5IndyvYAc3P3y04Cai481+Po3ZnQCkIHxpNRbkX+2gv0P5GUxR+LIl+rg
         ewdw==
X-Gm-Message-State: AOAM5338/fcN72UGRrytCLY0QBFPzPsuGFot5Kg6N6TR3/RVJWE6Tdm3
        2jJuPI9//15znIzQOG323aCI42Ka/o5RGw==
X-Google-Smtp-Source: ABdhPJzCmZnWmL4zeG9GHzsuqsLVA1jlbCAiGIP6xC9a250RVVFPtzz5jLwj1qvmPtUcNtwFYHbRug==
X-Received: by 2002:a05:6e02:20cd:: with SMTP id 13mr11573112ilq.126.1617383955564;
        Fri, 02 Apr 2021 10:19:15 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s1sm524872ilt.3.2021.04.02.10.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 10:19:15 -0700 (PDT)
Subject: Re: [PATCH] block: update a few comments in uapi/linux/blkpg.h
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210402171731.389733-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <acfa92d1-b8f0-51db-0de1-b47cba74d7e6@kernel.dk>
Date:   Fri, 2 Apr 2021 11:19:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210402171731.389733-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/2/21 11:17 AM, Christoph Hellwig wrote:
> The big top of the file comment talk about grand plans that never
> happened, so remove them to not confuse the readers.  Also mark the
> devname and volname fields as ignored as they were never used by the
> kernel.

22 years later... Thanks, applied.

-- 
Jens Axboe

