Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03310C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2735611BD
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhJMQGm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhJMQGl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 12:06:41 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06ECC061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:04:38 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h10so258215ilq.3
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AQfaTYufa+wAXbeazyntW3jwrFuT52R0IxyFGEDon1o=;
        b=v2VYFtTQ8Kx9gOrdLlR6Y+hzY1vJOCWRcofqNo4I/AvEo05vknc80GtBpIgZ51Jzh+
         CbDoc92ow6G2JaWRUnRN1K8KQ3B8ZIb14RcutJ4/JMWLwnz//+a5F55aFlMhewPP3kuL
         8AhpXykcw+s1Ii7F8WvRR/7XOFJMzebcyhG7SXDOy8UU3Fvo/y8S326UDlKGzujv9zlV
         gxqS0mT144OEo/JnLFQbwtStIKIa8tFx7WgFxaO+W1Uv5Fa4XbUmOIYiubmFdHEN7zfj
         7Dbb1789GIWutBz8je14BDJra/N3j/twEeYxw7SK1TD2GIg1NTSppsHbG1FNiLHoRJXL
         84ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AQfaTYufa+wAXbeazyntW3jwrFuT52R0IxyFGEDon1o=;
        b=F0ZxwheQk0+kyIS6LtBa2HY4aHGUiA42PT4kektXkf9NGg7Urjvwdd4Kw7vuPxKJuT
         6tsRfECfUo4O01YmwEUu1Juy1MYgsSXgdFH2qERQ+2SaU3zUCukMw1v3Oz/pPfZeRjlN
         77f1NE9Vwz3m+i7CAJsRXYWcMcrWU4X/cB66zenMg+ZOrkst5ItlNN0qksuIzVhgTr0Z
         IyiuozkEbjFJGGQLsabF13hmzf2JifBuGwdPtedvJaP3V+zhUl+7DR/6meYaQQA+LUAG
         3BNL/pIG5iM+xqBTxaXMBsVCRcLnUwk16VTY/ZceDEGYeGHEN/Co8SUGOEEIgZPLmiTM
         FZ1A==
X-Gm-Message-State: AOAM532swy5FZjJAEmRw9RQ1hBGMMAsmgwPtVYahIAaAEbZm6RHLuLEe
        GpD294yr6vwnD3JZ+MuZi/GMaYRciHIo2g==
X-Google-Smtp-Source: ABdhPJxjdmqHZ+1RfWfs8t66KV5ltB3UyVY+WwBsgZ0RuxQN33GWV+C8ks1igcIHF8j1oQeQSz6dxA==
X-Received: by 2002:a05:6e02:15c9:: with SMTP id q9mr287575ilu.298.1634141077565;
        Wed, 13 Oct 2021 09:04:37 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u7sm5400705ilg.22.2021.10.13.09.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 09:04:37 -0700 (PDT)
Subject: Re: [PATCH 6/9] nvme: add support for batched completion of polled IO
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-7-axboe@kernel.dk> <YWaGB/798mw3kt9O@infradead.org>
 <03bccee7-de50-0118-994d-4c1a23ce384a@kernel.dk>
 <YWb4SqWFQinePqzj@infradead.org>
 <e3b138c8-49bd-2dba-b7a0-878d5c857167@kernel.dk>
 <YWcAK5D+M6406e7w@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9456daa7-bf40-ee85-65b5-a58b9e704706@kernel.dk>
Date:   Wed, 13 Oct 2021 10:04:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWcAK5D+M6406e7w@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 9:50 AM, Christoph Hellwig wrote:
> On Wed, Oct 13, 2021 at 09:42:23AM -0600, Jens Axboe wrote:
>> Something like this?
> 
> Something like that.  Although without making the new function inline
> this will generate an indirect call.

It will, but I don't see how we can have it both ways...

-- 
Jens Axboe

