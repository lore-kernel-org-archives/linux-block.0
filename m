Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226AAC433E6
	for <linux-block@archiver.kernel.org>; Sun, 21 Feb 2021 13:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBBB761494
	for <linux-block@archiver.kernel.org>; Sun, 21 Feb 2021 13:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhBUNOx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Feb 2021 08:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhBUNOc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Feb 2021 08:14:32 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29862C061574
        for <linux-block@vger.kernel.org>; Sun, 21 Feb 2021 05:13:52 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id m2so8403406pgq.5
        for <linux-block@vger.kernel.org>; Sun, 21 Feb 2021 05:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZzhsAzI+WwVZdpOkDos1+vbKvp69jC1HTeXXKiCZqmo=;
        b=wX9aoRjkttXuVHotMvkxJlXH4a6/x1WTC0NIBNRcbPP/ZJiB/Qw8xMFCw838fEyLR+
         huUhbIPkPz8FAk7ECfSHYxa3Z+045Ufvos5mOaI4D1OOeqYwOFwAGjLpCFUYeWh9zENQ
         12M8gsCTfYKYbpHmcDbNx9ACPNV5rHyMgfYu7MVVoNGq4wpuYejME9cbPBEQQNG+ren+
         BIx07LplzByJ9c4xR9fc7V4+Si8MEBuWXOw8igK0sRuxz1lLl5gyY22GDYrl/EZXyJoi
         OARvftvTs2tOVkqt/C7EIyx9bHfrhDaAn+xivMEfdJ13RQan58cxlSu9+5eEU2uUvWqu
         V2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZzhsAzI+WwVZdpOkDos1+vbKvp69jC1HTeXXKiCZqmo=;
        b=CGth1OQmKSqccF62nxqWXkst5Z6XedCic8i0vlhopFtdlzhekmkcFGogT6JaURuscY
         Cl6brtbXPv4wSRxAlfuZ/OxaAXXW7KCh2XgnR79FkxE5VsvUNAON90XLvzAtMFUbXXJF
         qSYwvLvKlK1j/15/aKh34uDUker2tWTXdHLyCzcVj2YLjmIFSyoUijkxZCygUiRevWGS
         /X2x6BjYVPaoQoRAeSbzqgW8WGWJG74Sg5m0ZMdkSbM4BDXQ5HdMsOzjK9yVsHSe/jkJ
         2RrGQ8KDwpKFijTu0NaYDhtbIhQG6oZw8Qa7llKvU8ZFTfgTGU+nlr3Lvg51CuadPdCp
         VUfg==
X-Gm-Message-State: AOAM531DM09lm6qWc05CjbKFKn5xKONKOmxMVFaut/sktXI6/vjVhAsC
        U+F8QeFF3/fKo0EQZ+xa/o68jQ==
X-Google-Smtp-Source: ABdhPJwN4Xl8Yqv5LLznbNU+sXyTh+ABxiKKbIL7xelk4+AbJDaScYfDIWMOLxmQA0uZVs0m1EpTOQ==
X-Received: by 2002:aa7:9356:0:b029:1dd:644a:d904 with SMTP id 22-20020aa793560000b02901dd644ad904mr17697411pfn.18.1613913231729;
        Sun, 21 Feb 2021 05:13:51 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id fz24sm14966856pjb.35.2021.02.21.05.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Feb 2021 05:13:50 -0800 (PST)
Subject: Re: [PATCH v11] block: Add n64 cart driver
To:     Lauri Kasanen <cand@gmx.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mips@vger.kernel.org,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20210123095327.58e5ab6c05f38e9080a79bd3@gmx.com>
 <20210123124210.GB458363@infradead.org>
 <20210206192837.5ecec54cc5ac120ade1d5060@gmx.com>
 <20210211102314.GD7985@alpha.franken.de>
 <20210221085421.882c8f0b8b51f44272beb471@gmx.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6c003ea4-2d4e-c50a-25de-00f3ed55b0c2@kernel.dk>
Date:   Sun, 21 Feb 2021 06:13:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210221085421.882c8f0b8b51f44272beb471@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/20/21 11:54 PM, Lauri Kasanen wrote:
> On Thu, 11 Feb 2021 11:23:14 +0100
> Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:
> 
>> On Sat, Feb 06, 2021 at 07:28:37PM +0200, Lauri Kasanen wrote:
>>> On Sat, 23 Jan 2021 12:42:10 +0000
>>> Christoph Hellwig <hch@infradead.org> wrote:
>>>
>>>> Looks good,
>>>>
>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>
>>> Hi,
>>>
>>> Ping on this patch. Thomas, do you want to pick it up?
>>
>> well that's up to the block maintainer. I'm open to take it
>> trhough mips-next, but then I need an acked-by for it.
> 
> Hi,
> 
> Ping 2. Jens, I know you're busy, but just a mention this is on your
> TODO list would be fine.

That's fine, you can add my acked-by to the driver.

-- 
Jens Axboe

