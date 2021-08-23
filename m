Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEA4C4338F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 19:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B023613D0
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 19:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhHWTu7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 15:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhHWTu6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 15:50:58 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044E9C061575
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 12:50:16 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id z2so18266427iln.0
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 12:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b7XwfOWdtBX4U3UiGXZyhJZdJW2tYXyDIOgmFUinee8=;
        b=sY/4vhIiTBz5rZqIvs7AJ7Zzu6G7W6k0UiUhKql3o6eVy1OY1bwwbLH7fukzhsweGO
         Q8dMryWor48D2kh1hUVFiDz0IdbGKT8TtlAekOcV9P3o+76YTNafw0SW5+uD5pzbjaHu
         mmZ9bwsrWzbnqVdBW8NE30JX5dzinxJYGK/Swyx/RvF5WFzaTrJjSuErpYN99ExAQMMu
         qrTirYPl1FwHTq9xf0D6BXFGOgIp3CHF/AGA0xQfyLAYkDjlBlSdjrBcw9q1FB/dkRmA
         AaQRb9ak6eRTN7eDKMFxBhjGgui8P3t5YHzzjXwCc368QbO6WAapn8mFR1LRLlQbaR7W
         p6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b7XwfOWdtBX4U3UiGXZyhJZdJW2tYXyDIOgmFUinee8=;
        b=gnqOG5JFKkGIN9VctmHCsXD2dQbDI25xe2ty2u8kDvzazKHWoAMcMfSmVyRE+CA8jM
         5fUHcsfjVdFcHhJNu9sFrXkWnDjWeRKKRqo/aNI/z1Ob2bFgWNK+EYQEmjxy0RJvmqrw
         zLsuG7t58VkNwFfjrpq96cdCy51KGDgMmRyJMeASgBR60f9RALMVZMuOq+Wp35V51TMh
         nAMeDdPAmZdhiLI4a5CDG+dBxwwL1neXx6xCf4itw9u3AXBtTSK/F2uEg2Mmvfzb+v1D
         TROrrFXbcBFLUdeY2xWoIjUoJufFsiP40goztI7facwAqVTY9STE9I1+ZnRryBQ2xQJp
         OyVg==
X-Gm-Message-State: AOAM532aIlnU7q46R20qKMr3sYJ+2Rh3du449vmLcms0VvWtmIIQeqxv
        QKm1GOkJZ6YlsUOXt3ukLDBURoA45P/Cag==
X-Google-Smtp-Source: ABdhPJzpLEkIAuoS8D8YCDkDFuEySRo22U4PGajM1Y2vYlsWYCA0mbjRATQ3C2rymkrMlr6BSt07vA==
X-Received: by 2002:a92:ab0c:: with SMTP id v12mr9746457ilh.292.1629748215252;
        Mon, 23 Aug 2021 12:50:15 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id m5sm9232583ila.10.2021.08.23.12.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 12:50:14 -0700 (PDT)
Subject: Re: add error handling to add_disk / device_add_disk
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org
References: <20210818144542.19305-1-hch@lst.de>
 <21685c1f-5fde-cb85-3bd7-4396c6042e11@kernel.dk>
 <YSP6uZOYQ6kX+B+3@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9345b22b-b8b8-6e2d-4ebb-2cd96bbd52f7@kernel.dk>
Date:   Mon, 23 Aug 2021 13:50:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YSP6uZOYQ6kX+B+3@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/23/21 1:44 PM, Luis Chamberlain wrote:
> On Mon, Aug 23, 2021 at 12:57:41PM -0600, Jens Axboe wrote:
>> On 8/18/21 8:45 AM, Christoph Hellwig wrote:
>>> Hi Jens,
>>>
>>> this series does some refactoring and then adds support to return errors
>>> from add_disk (rebasing a patch from Luis).  I think that alone is a huge
>>> improvement as it leaves a disk for which add_disk failed in a defined
>>> status, but the real improvement will be actually handling the errors in
>>> the drivers.  This series contains two trivial conversions.  Luis has
>>> a tree with conversions for all drivers in the tree, which will be fed
>>> incrementally once this goes in.  Hopefully we can convert all the
>>> commonly used drivers in this merge window.
>>
>> Applied, thanks.
> 
> Do you have a branch published which has this by any chance? I checked
> but can't see anything obvious.

It's in the core branch, just hadn't been pushed out yet. Now it is,
find it in for-5.15/block

-- 
Jens Axboe

