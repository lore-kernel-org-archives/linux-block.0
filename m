Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEB0C433DB
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 20:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E3A64F86
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 20:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhCLUBc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 15:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbhCLUBV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 15:01:21 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9B2C061574
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 12:01:21 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id t18so5669636pjs.3
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 12:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v/UNWIhoMbNZ2UJ0E/ZPfqJfvT9+60zw5SGiKePJ9P4=;
        b=tR4EvNUStAuDoH0p5DW9uLKts2Vr+kbFqtfq1b924wIlp2vsh65kX96+bmNOP6ATsv
         9fhaB7YNCJPPBZl0r7kNL3dcnClaHeODnpUREZFbHKhvvX72HeYliAvlMFCF34SxOM2+
         IpuxavzDW4CIHWCN80nRAqY6Xf3FpeXEmnD5J2h/gGfdmalVZ/Kr5seUQzYUmpdySTVm
         Gc6NcKdU5G6+RkuxLBJ48Csl6uoGfgL4QYUQ+VHo28oM7wGiKaj35Sxgzks9Wml+w8DY
         aG2wPr/2jUHA5/oZ4cHn+JtyzOjrezlV1H3l6uyVV0BEhmgcUzDcxTCEuhZvZ3BzG86t
         wgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v/UNWIhoMbNZ2UJ0E/ZPfqJfvT9+60zw5SGiKePJ9P4=;
        b=YRc5WnxA7kaEKzgKXw4t7PaUgJ03oTrID/mbxLT/nhtKfiU1zYKf8DzbE3ua0ugg6C
         s1/WmaTmpplw8O0jcE1v0WeF3w4wYmvhliVyQ1pAB/28WJmuPjVes6dKz5BBe/eJD5Rs
         BT2HhDtCn66fMRSRoC/Gd65gQTvfEuWOHUWED+SM3qylaUGNCtUXxdSqu1mJHjB0gFwK
         fpLV4HqXalgQrFfXVWqe3Jb4kr4PM6dzrdCB9lY6n8VFnEJufQp6jagHScXKe9IVjGbR
         tBL1YFuvJaXSqwHa8HGlDAbBo96366fpldHh5MohdADav/aS2YPNdwI6So3DHgHTUH1n
         uQVA==
X-Gm-Message-State: AOAM533S1nLEVOZgJwBFyIaOmxiX7nMneWkO41OLml9BeDUZ5/1ZQhwn
        EwO01Q4clJRnvPrOaeKkJ8k9TLz4y1nzcg==
X-Google-Smtp-Source: ABdhPJwNAeGOkGbc1Usxrnpb7ZPM8m7wt+fqXqNzM9fEAdLRRKmXLi2c1R97H64SSacE9F5tshbBMg==
X-Received: by 2002:a17:90a:5889:: with SMTP id j9mr3709168pji.69.1615579280612;
        Fri, 12 Mar 2021 12:01:20 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 2sm6173752pfi.116.2021.03.12.12.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 12:01:19 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.12
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YEszeMEAQyfTPgHH@infradead.org>
 <2a34717a-b5c5-0a3c-02b0-eb8a144aba15@kernel.dk>
 <20210312195932.GA2766489@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7d7e0f1d-649f-e977-f65a-e0a6ae69d327@kernel.dk>
Date:   Fri, 12 Mar 2021 13:01:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210312195932.GA2766489@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/12/21 12:59 PM, Christoph Hellwig wrote:
> On Fri, Mar 12, 2021 at 07:21:39AM -0700, Jens Axboe wrote:
>> On 3/12/21 2:25 AM, Christoph Hellwig wrote:
>>> The following changes since commit df66617bfe87487190a60783d26175b65d2502ce:
>>>
>>>   block: rsxx: fix error return code of rsxx_pci_probe() (2021-03-10 08:25:37 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://git.infradead.org/nvme.git tags/nvme-5.12-2021-03-12
>>
>> Pulled, thanks.
> 
> I just sent you another one liner fixup on top of this directly.

Where? I didn't receive any.

-- 
Jens Axboe

