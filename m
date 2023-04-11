Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF423C7619A
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 18:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjDKSMY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 14:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDKSMY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 14:12:24 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5DDE51
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 11:12:23 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nh20-20020a17090b365400b0024496d637e1so14164429pjb.5
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 11:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681236442; x=1683828442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TD5CwNguqZ2K1/dZ8k4oHWH0VcyzAjtJBoVS/NZYT7s=;
        b=Xmay0W+tA8Z0Ff+YDWZSIRxVUdEv5EBflQa5cBQkyRpmXVi4k06DkEMMn1AvRFkEYW
         D48+IzHvwUm2KqdBLhO6UOLnF/gCwwhoEB5BUOfrToNb+rgofHsRSPkE85tS6nC0x50A
         laXcPNhwA+/H7O9vqjj7bO2eOHAq5xh8kn5O6CS9Odbmh4kTI8VaPQuhxAgCDLyLsxwv
         xBfBJUkHTpPhohFg6gvHCFe0lJKFifH3EgHYre1/+bc469BrQyoW9kGtYJiWxzgTr8bm
         a3T9FTt0zP2KAaRQlUsFoe+tPPWyRmWY4cV43u/3+dcHOOhcBHz4Kl9LzQxz/yV6nqHJ
         f/yw==
X-Gm-Message-State: AAQBX9fVEv8Q9f3MNzyWNjvVquzV3SrkZBsUYWaKkeLUkwiT3jAgeTL7
        y556lzXJnqSO5++1J2AEqhI=
X-Google-Smtp-Source: AKy350bFDGBakvFZWSeR1HucVAAHwSnTBghkvoMl/h8ML4RtjCePZ51EmDW1kb0lA4pqS+t15+0F6g==
X-Received: by 2002:a17:903:2302:b0:1a1:d774:a3d7 with SMTP id d2-20020a170903230200b001a1d774a3d7mr25184179plh.25.1681236441991;
        Tue, 11 Apr 2023 11:07:21 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:646f:c9f7:828a:8b03? ([2620:15c:211:201:646f:c9f7:828a:8b03])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ab8f00b0019a97a4324dsm10037164plr.5.2023.04.11.11.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 11:07:21 -0700 (PDT)
Message-ID: <30c30fea-4cd2-78f7-cd94-dcc35fd5d2ec@acm.org>
Date:   Tue, 11 Apr 2023 11:07:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 12/16] blk-mq: don't run the hw_queue from
 blk_mq_insert_request
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230411133329.554624-1-hch@lst.de>
 <20230411133329.554624-13-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230411133329.554624-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 06:33, Christoph Hellwig wrote:
> blk_mq_insert_request takes two bool parameters to control how to run
> the queue at the end of the function.  Move the blk_mq_run_hw_queue call
> to the callers that want it instead.

I like this patch!

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
