Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08073C77B61
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 17:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjDJREx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 13:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjDJREv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 13:04:51 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436E61FC3
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 10:04:50 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id c3so5931743pjg.1
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 10:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681146290; x=1683738290;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1qLwadZhVjTEWw4IP7NKEAlXr/ka6xk/p4jUsMp7Lc=;
        b=WKzgqYhF/ZNzGKkn88U+m9seqmd6T+3XvGJj96CnglgoyWEVgyhicIP2AnjdvH30v2
         cPqbi9XmF3Zx51KEKFvaxKwxrlO9ovmmT7RouPt7FUp6jVLMyUmnV74eNG0fbxmyNyms
         3fwU4umoB8pBqvl3fH7/rxQ7+6U3LxaFFPUVMhh4skBAwgsdRivRI+A34Gz40UlIQBhQ
         xdLKlxCvPGuMnROgXSqGAa+j/Sa5TLmrHlGW5TfI/5ABlLQum4YIdES6BfCcQ68xBhhV
         UOWX4BRA7N/W57NaPTo1g0yESNTMFCBApAvZYjemm/BY0Mc2CdytO8pSZgvSydj8EODF
         JXcQ==
X-Gm-Message-State: AAQBX9d3Bc8/HGsKTsOHOKAkvQGucR/qMsiyNeBbppVVqaJ19MqwP/KW
        4EwEwJLft+c6+QkWsX50pdA=
X-Google-Smtp-Source: AKy350awopHfmvWuj3j9h1tUEhFWz6NU9pMIdPkBJTp7S52+yAFHGgeXWgAxphGT8LWnY2IvR01Yrg==
X-Received: by 2002:a05:6a20:7b1d:b0:d9:b59c:d09e with SMTP id s29-20020a056a207b1d00b000d9b59cd09emr11937762pzh.11.1681146289698;
        Mon, 10 Apr 2023 10:04:49 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:11fd:f446:f156:c8? ([2620:15c:211:201:11fd:f446:f156:c8])
        by smtp.gmail.com with ESMTPSA id f9-20020a63de09000000b00502e6bfedc0sm7259447pgg.0.2023.04.10.10.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 10:04:49 -0700 (PDT)
Message-ID: <5b4cb669-af85-563d-3c57-04aecce36f87@acm.org>
Date:   Mon, 10 Apr 2023 10:04:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 05/12] block: One requeue list per hctx
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-6-bvanassche@acm.org>
 <ea4d2bd5-573e-7ef5-45e4-d1bdf717fb69@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ea4d2bd5-573e-7ef5-45e4-d1bdf717fb69@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/10/23 00:58, Damien Le Moal wrote:
> On 4/8/23 08:58, Bart Van Assche wrote:
>> Prepare for processing the requeue list from inside __blk_mq_run_hw_queue().
> 
> With such short comment, it is hard to see exactly what this patch is trying to
> do. The first part seems to be adding debugfs stuff, which I think is fine, but
> should be its own patch. The second part move the requeue work from per qeue to
> per hctx as I understand it. Why ? Can you explain that here ?

Hi Damien,

This patch splits the request queue requeue list into one requeue list 
per hardware queue. I split the requeue list because I do not want that 
the next patch in this series would affect performance negatively if no 
I/O scheduler has been attached. I will double check whether this patch 
is really necessary.

Thanks,

Bart.

