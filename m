Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF87C7EE23
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 17:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjERR6T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 13:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjERR6O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 13:58:14 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFBA131
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 10:58:12 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ae4e49727eso23798355ad.1
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 10:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684432692; x=1687024692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/AeFmmQ2Y0ADzUb9FWpLCND9DUgH3BfRZCkCfa0Y1Og=;
        b=afgp9tzmqNclTxBCVZnMtw8A4X4JEun9dgFje/rWsD75DkADmc62gZ2Q/ZKEFpbl6o
         wPDG/uOQeBrI+PlhEzMvxKGpFxCfGPJtXTPEmuKlROE1GeKWhF/RA/k2vcLDjWklIgwN
         ehVykALlIv/qgPM0CbS+MK67970u7YeBNi8iHEoI0IoxGbqejqgLpxMtlgUHuLoY2Qx+
         k6oY4WOuTMZ5MOEy+Hxyhzx0ux6giP/ENysJZYPol+ywjiL80F7TPcobghO1UNM/mM4a
         YAOfEVcB6CaMWFiXX0VQftk8clZ9gDn6QwWxLRzD2TVEaWGCY0y2RRvdZd714y8peBQU
         z16A==
X-Gm-Message-State: AC+VfDwk3M6MMiyJPz7cMRdzEi9zvM5HK256SquEnKN/tRFRmXIWzJzL
        NHIp7kIoU18teUBUjLMxewf9nMq6E2s=
X-Google-Smtp-Source: ACHHUZ4TZZEpdwC44AS2nLkgBrtl6CVDJaFQfpxd2t4XvMCUh1nUqKOWIrLhZS8n8ErA3idiRKp1Yg==
X-Received: by 2002:a17:903:26d3:b0:1a9:b8c3:c2c2 with SMTP id jg19-20020a17090326d300b001a9b8c3c2c2mr3537331plb.37.1684432691901;
        Thu, 18 May 2023 10:58:11 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902d3c900b001ae2b94701fsm1760565plb.21.2023.05.18.10.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 10:58:11 -0700 (PDT)
Message-ID: <e2f62a6b-dc8e-cdf7-8405-e3af1f51ae77@acm.org>
Date:   Thu, 18 May 2023 10:58:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] blk-mq: make sure elevator callbacks aren't called
 for passthrough request
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20230518053101.760632-1-hch@lst.de>
 <20230518053101.760632-4-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230518053101.760632-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 22:31, Christoph Hellwig wrote:
> In case of q->elevator, passthrought request can still be marked as

passthrought -> passthrough

> +/* use hctx->sched_tags */
> +#define RQF_SCHED_TAGS		((__force req_flags_t)(1 << 8))
> +/* use and I/O scheduler for this request */
> +#define RQF_USE_SCHED		((__force req_flags_t)(1 << 9))

and -> an

Otherwise this patch looks good to me.

Thanks,

Bart.
