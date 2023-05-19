Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD35C7EE26
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 19:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjESTmc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 15:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjESTmb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 15:42:31 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E48186
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 12:42:30 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-64d30ab1f89so844967b3a.3
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 12:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684525350; x=1687117350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqbYxAZvfHGYCedJFHOtCZSCOuObkcNB1k9Xi/oaJAs=;
        b=SNDtcE75TwuEwlpVTnOXprgo+cjj6eOUrihPTdy7bjTOZDp6Bbxn3Uxh9fedLJnEZX
         nsTQboGzsx29fPr+PbIvIL46hvd8qFE5EZGGZfAVIbCQDU7MvcQ6D12ATKhm3CBBSyDb
         iofHu9N/L2cwmh6A+mlC0EhCckpNymel4BuBScgtd4/kGjDiVHS487Hgp7PJvGVfDOVF
         a7N1HKRX9GyR7Fz854fgs3vQJz9kJEyHKRGlYGb6ghTj9xoDG1kfINpQOR04Tw4psiqG
         1EFeRYE4kz1bIpB4YLaa6YASGqWJrwkNPKjerUiXCgkvgAknquRuIB79AEHI5StOLE3O
         vbxw==
X-Gm-Message-State: AC+VfDxkDWRm8E2+jT/5tXcntcNkY0k51upxU3yrceMlncSH+Xci/Use
        j9RMAK7kcfBdqHOcICCjWAZApjbuawI=
X-Google-Smtp-Source: ACHHUZ5znyhBP2zoK+UmGWHhEFKrowFfkzGgEf3FHGQH6QwsW/vFtIxKTRx0gp0rNunQVQtxGjW5SQ==
X-Received: by 2002:a05:6a00:804:b0:63b:8423:9e31 with SMTP id m4-20020a056a00080400b0063b84239e31mr4277668pfk.11.1684525349942;
        Fri, 19 May 2023 12:42:29 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:102a:f960:4ec2:663d? ([2620:15c:211:201:102a:f960:4ec2:663d])
        by smtp.gmail.com with ESMTPSA id 23-20020a630017000000b0052863112065sm100561pga.35.2023.05.19.12.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 12:42:29 -0700 (PDT)
Message-ID: <c8d56cc8-aa8f-7076-672d-6b6586729a1e@acm.org>
Date:   Fri, 19 May 2023 12:42:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5/7] blk-mq: defer to the normal submission path for
 post-flush requests
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20230519044050.107790-1-hch@lst.de>
 <20230519044050.107790-6-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230519044050.107790-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/23 21:40, Christoph Hellwig wrote:
> Requests with the FUA bit on hardware without FUA support need a post
> flush before returning to the caller, but they can still be sent using
> the normal I/O path after initializing the flush-related fields and
> end I/O handler.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

