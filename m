Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8B9C7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 17:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjDLR5Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 13:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjDLR5W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 13:57:22 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07CD5586
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 10:57:19 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id y6so11121559plp.2
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 10:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681322239; x=1683914239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VH6TwZHh3KCPSQhCAOcYikBPwaBuz6dYIovxlnyVxNY=;
        b=AaRbDtrdMoPJVZJknrpr2mfVlujP207g7XSQ4He5L5sGG63bbtEutIOpMapiRqESBl
         gDOjMfKNLMAeWXVI7X8hAUbts5uXWaT9lM6HsoFxdN4IlsHaBZhmwqXzMCiVnMSFBHt1
         y+EpfZkSrqK5mVM8lbHjhvgS9Gx8ALXu2VN5lNkR4cvPlmkP8FrGVac6P3P5i3rcMR/W
         mspGPO5lUqI5fDTVTqqF+VCCHEIXLdrS39MGmrcIc120iUbwzxwppslmJJy3pUq4JHrD
         7mercD44Y7Yviw6VuxRbnPVdbFiHhIFgY3Z6ux6mG2uzGIJ+gFJEW+x7GTHUOB4NYpAQ
         nBig==
X-Gm-Message-State: AAQBX9dJkFvArO1ZEEpMb7TFnDp4t4kyHljgpmnVUC3/5C5GLLyu084o
        GnP1IHWQmmYF/MItlC7/8rQ=
X-Google-Smtp-Source: AKy350ZW4K/uCc9a+vkn7u14X9OkfI3QBKzk6OGgFMp4SrlW3K+unPYEjdAmtsMnUzBflxI11AYo6A==
X-Received: by 2002:a17:903:185:b0:19f:a694:6d3c with SMTP id z5-20020a170903018500b0019fa6946d3cmr8612892plg.55.1681322239058;
        Wed, 12 Apr 2023 10:57:19 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:d89d:35dd:5938:1993? ([2620:15c:211:201:d89d:35dd:5938:1993])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902b68a00b001a50ede5086sm10403466pls.51.2023.04.12.10.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 10:57:18 -0700 (PDT)
Message-ID: <36a39ead-203d-dbbe-9391-f2877d84cbb4@acm.org>
Date:   Wed, 12 Apr 2023 10:57:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] blk-mq: call blk_mq_hctx_stopped in
 __blk_mq_run_hw_queue
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20230412063743.618957-1-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230412063743.618957-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 23:37, Christoph Hellwig wrote:
> Instead of calling blk_mq_hctx_stopped in both callers, move it right
> next to the dispatching.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
