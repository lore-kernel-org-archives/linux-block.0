Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9985AC4332F
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 17:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8178861056
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 17:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbhKDRjx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 13:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbhKDRjw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 13:39:52 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C08C061208
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 10:37:14 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id l7-20020a0568302b0700b0055ae988dcc8so6131739otv.12
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 10:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rfe6+/I6+36ChCKIx9DmXPjKz2GPCqoF3OEa62raWEQ=;
        b=2T1h/N6eQRH8c78ZD8DnZkaS5FgYwYoYCu2F+Cj3rT89SwbHR2bTqg8GH5jK668Dv5
         aTFprnfpc3wGT9jPv+uABzWLVZYlrX+f/TaelO3LmeNPpwzLspumyY1QraIC8sAhFJ/s
         UUalPrCU+OBGDRuTneK1ZSnX8kpXEIa3xDlOBVF6LWQ2icv+2EX+Z5QiOIwpEBS9o3Ya
         7XEtyzxfwMcWu+cHzssQT7H2mQkqvCMTU/tY7XQ1ykQ/XhXJMNUahL2ADEeBwyVE6HLb
         DWRzZV+9PQU2UlnmEgb59s9t7rBghpOSH7+UB4un56JeeODmIqBbRWspToA+LI4OQb4J
         ToOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rfe6+/I6+36ChCKIx9DmXPjKz2GPCqoF3OEa62raWEQ=;
        b=ORUbyRF9AtsLjCgVRG0AdshonpkaVZcXDIAN7sZ21mlV+GHZvtsBOnah2ovAUP/B0j
         xdYxlhKB24W/4BWusZwwCE4fMa6bFTc8NA5ny2RCOGGyZDh83L2PsGS9zpcJxI5EoXL9
         U3ktwKbnTQcAMeBckwy0BIsfmIPE7LqgufBMbIuG0LO1m8+F+0DjXlkxUIUZRMmsVyZ+
         DKpGOTYxyajGg/RURcL2GENEdVFQ8yqIuy7rms4utNgree48IESUVn611lyfMxLZapdG
         02kFnPE7MInEFkzvVbqfHxeD0vu5ZB75h9L+slR7dKdJxMRmt8AbA1bZTdCN0iJE5ITD
         CCMQ==
X-Gm-Message-State: AOAM531anR0fN+bRfdYV0fzljU2osWuKvCmFcSMaGhiO+xxPsOmn5pU9
        rifGnZqGqNvgqOrZDvXCSBEmoyx15FULmQ==
X-Google-Smtp-Source: ABdhPJyDKnAO/RZOiNS3vfl59HJvzKsrWI2w1tDG4yZQFu95QmIMVZed1xaHlhDlyZRW5zS96RxEmg==
X-Received: by 2002:a9d:5610:: with SMTP id e16mr41965919oti.324.1636047433329;
        Thu, 04 Nov 2021 10:37:13 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e21sm1587641oth.23.2021.11.04.10.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 10:37:13 -0700 (PDT)
Subject: Re: [PATCH 4/4] block: move plug rq alloc into helper and ensure
 queue match
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211103183222.180268-1-axboe@kernel.dk>
 <20211103183222.180268-5-axboe@kernel.dk> <YYOlIGsSHN0+YrjK@infradead.org>
 <e211fa74-1b69-c2f6-ecc5-a2e5139b684e@kernel.dk>
 <YYQZYfI/rmH5RshU@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dfe03d35-dce5-4ecb-e9bd-4cc38e318b1d@kernel.dk>
Date:   Thu, 4 Nov 2021 11:37:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YYQZYfI/rmH5RshU@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/21 11:33 AM, Christoph Hellwig wrote:
> On Thu, Nov 04, 2021 at 05:35:10AM -0600, Jens Axboe wrote:
>> I tend to prefer having logic flow from the expected conditions. And
>> since we need to check if the plug is valid anyway, I prefer the current
>> logic.
> 
> Well, for 99% of the I/O not using a cached request is the expected
> condition.

That may very well be the case right now, but as more things plug into
propagating expected number of requests, that's likely to change.

That said, I did reflow it for you in the updated version.

-- 
Jens Axboe

