Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD07CC433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 13:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C162961074
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 13:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbhJSNs1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 09:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbhJSNs0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 09:48:26 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1662EC06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 06:46:14 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so1703386otk.3
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ucIWtET5JrdeSqqJuLCzHbELJKdBfUKzDRkTlrBAWuk=;
        b=aDoTmOUos+hDwCphQVxpgeIEGFEHS416tKwSHtoE6W4oTLc7oNpgqVsZMjpFgMYozZ
         u4Dxmw523wrckTOEJ3aTQZwIvmGLWX3y30CzvgZiknAgZc9wezObmXCp7RlJQnl5whJ9
         xGOZ+UNTcqeDs/ANM7r6WphtrNdGM8pK8vkI0Utm+OA3Yn5EEQa2ZhGhoLamBU+eeG7H
         acNS7/5XvU0RcA+xu/HCIbSc4MWm8L/pZkEYSy57NYvmeH0SILzgUYWqcVb2nj0PL54n
         tXXIwUP21uTbAEYydMbQ94+5NH5GBhURNcvSnUl7uXnHFEdCoCOSt7OlzUJ7hokQmdUY
         DhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ucIWtET5JrdeSqqJuLCzHbELJKdBfUKzDRkTlrBAWuk=;
        b=K3HzFvTAIbLxTG/2VMSJ9cBemfSvfyuSqjME6Q1z1z6uYz6DdIp/17308/1bBKJvwj
         QRUtbrzYScnmy6xVyy533lMduZichoPeXLJUKCSEv+D7V+oh8Ehpuf45l4opqX1Bg79L
         V6FTaGQNhpFlPFlur/NowcPRxn4JadFp8I+hDoBJp2V6e3h3Agm9xos4ye9aWtqtebTQ
         L+TsG6FkjC9QyUbuY3YvrzYiVHD0MkaShwa9U2iiOVoWofppTt+jWbJbP1tfgBZdWlqG
         N1W8t6MQGcoQfH4EdXvNz5BbZgSgDIWw5jdE94Q3V9jTzCRt53jMKc+OIo+3S/H7T9S5
         nF/w==
X-Gm-Message-State: AOAM530XWadkVL8A3OWAcAeeyot3rrSzJBzTABLvzITdLsMGdtGWGHEE
        sZUM/jL9iAht9xTZOfCW+GgNowN+Qf2uhw==
X-Google-Smtp-Source: ABdhPJxWND25ZkymfS7YGCPx1f0aKAJcXLvxxuiq8RJsquLgNJKKjb8b7A4CpxtYYiwPanhv+hf7Ig==
X-Received: by 2002:a05:6830:1f2a:: with SMTP id e10mr5435207oth.118.1634651173225;
        Tue, 19 Oct 2021 06:46:13 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y123sm3621818oie.0.2021.10.19.06.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 06:46:13 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: remove the RQF_ELVPRIV check in
 blk_mq_free_request
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20211019133944.2500822-1-hch@lst.de>
 <20211019133944.2500822-2-hch@lst.de>
 <6393ab57-3a9a-e5ee-6428-c1a4f0bee1f6@kernel.dk>
 <20211019134457.GA20622@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <52b0f155-b7dd-c14e-8273-ff76ec22b169@kernel.dk>
Date:   Tue, 19 Oct 2021 07:46:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211019134457.GA20622@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/21 7:44 AM, Christoph Hellwig wrote:
> On Tue, Oct 19, 2021 at 07:43:04AM -0600, Jens Axboe wrote:
>> On 10/19/21 7:39 AM, Christoph Hellwig wrote:
>>> If RQF_ELVPRIV is set RQF_ELV is by definition set as well.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> ---
>>>  block/blk-mq.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 428e0e0fd5504..34392c439d2a8 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -580,7 +580,7 @@ void blk_mq_free_request(struct request *rq)
>>>  	struct request_queue *q = rq->q;
>>>  	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>>>  
>>> -	if (rq->rq_flags & (RQF_ELVPRIV | RQF_ELV)) {
>>> +	if (rq->rq_flags & RQF_ELV) {
>>
>> Actually just fixed a bug there. RQF_ELV means "we have an IO
>> scheduler", and RQF_ELVPRIV means that plus "we have rq private data".
>> The above shouldn't check RQF_ELV at all, just PRIV.
> 
> Well, in that case RQF_ELVPRIV can be replaced with
> RQF_ELV && !op_is_flush as in the next patch.  But I can resend once I
> see the fix in a tree somewhere.

That'd be great. It's in for-5.16/block

-- 
Jens Axboe

