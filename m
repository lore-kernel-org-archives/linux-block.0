Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8895BC433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 11:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 664DC611F2
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 11:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhKDLhv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 07:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKDLhu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 07:37:50 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF69C061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 04:35:12 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id c206so4983695iof.2
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 04:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sjvI3JmU6GmecRTvKr1vVa+DLj/A99mNyYw8EjZN+Tw=;
        b=qk3RBgocGZJS4wMhgYC7vlpo4hPoPXoEr7IYSA58MVsgHl5aDa/N4HaisWa2SGo7KP
         +yDHGbmXrVxPqprW/tTP2beHfr3edZOG5A3Ws8t1dT4mBntOS2JpcIqC0vu9RzcTL7Kz
         dWoZXJH32/DwxuADjW0t8egTtzmLRT866NS3xZeUgirqrZ46cdlYglCw4E+7bcASS1aa
         kM4aSonNOMMppXNY+C2H7e2OfBAhk/T1WXsMzIVrr8V+CaHiMjkAW6rqboGd2w4bHrv2
         Cl/uXPwGwgXML3eVkkr7ePfov0jdsehVc4184oP1xEnwZiBeIBxuEpTtOOZp8dIbmjGy
         kSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sjvI3JmU6GmecRTvKr1vVa+DLj/A99mNyYw8EjZN+Tw=;
        b=XIN2K2Rr2KzkAkpG4lLDeC899+1lTJlXhmIKgv9dsT0yHu9LfnE/v2pjoQQLEKG3KP
         qGXu7EzZXYsw5oh8PNdNcxPg5KBIoyT2p1O7CVxipc+nevn5czpcysYsI4kntIhPhrEi
         7VEhzYEyUXp1H10b+/4VEsBL0AJQvcCTNqmQZ9pWaTNDCXUCitetmHRcJolpzc3ADBDR
         HwOcZN8X3YpUJlU03yZrVGVqtA2uJNT3DHne1jEjwKnrHbmWXwWuDE67rBcr1Dvez6af
         V8p994+VsWwtI3tIUC+mCNYUVADmTvBp7XOiZTthw3gc7wx+AYNcmueldqAN65v5/LTr
         t0NA==
X-Gm-Message-State: AOAM531Zoa1WyTtZSTonq9yjDkzTmWO1wcnPWcIAOqtIGA5WEC4ocV7Q
        J/PMTfS1OuJmHA/p1XkthTPy9gO9n4Mtvg==
X-Google-Smtp-Source: ABdhPJwpSh28ro/oqrEwr/kUoNYqmk2NPeZO/dkZ9S/OBpmpDcV2XD9RSQiiS8ObPHapz8MFIPH8UQ==
X-Received: by 2002:a5d:8b94:: with SMTP id p20mr34853014iol.146.1636025711599;
        Thu, 04 Nov 2021 04:35:11 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j3sm1207267ilu.64.2021.11.04.04.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 04:35:11 -0700 (PDT)
Subject: Re: [PATCH 4/4] block: move plug rq alloc into helper and ensure
 queue match
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211103183222.180268-1-axboe@kernel.dk>
 <20211103183222.180268-5-axboe@kernel.dk> <YYOlIGsSHN0+YrjK@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e211fa74-1b69-c2f6-ecc5-a2e5139b684e@kernel.dk>
Date:   Thu, 4 Nov 2021 05:35:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YYOlIGsSHN0+YrjK@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/21 3:17 AM, Christoph Hellwig wrote:
> On Wed, Nov 03, 2021 at 12:32:22PM -0600, Jens Axboe wrote:
>> +	if (plug && !rq_list_empty(plug->cached_rq)) {
>> +		rq = rq_list_peek(&plug->cached_rq);
> 
> No need for the empty check plus peek.  This could be simplified
> down to:
> 
> 	if (!plug)
> 		return NULL;
> 	rq = rq_list_peek(&plug->cached_rq);
> 	if (!rq || rq->q != q)
> 		return NULL;
> 
> 	rq_qos_throttle(q, bio);
> 	plug->cached_rq = rq_list_next(rq);
> 	INIT_LIST_HEAD(&rq->queuelist);
> 	return rq;

I tend to prefer having logic flow from the expected conditions. And
since we need to check if the plug is valid anyway, I prefer the current
logic.

-- 
Jens Axboe

