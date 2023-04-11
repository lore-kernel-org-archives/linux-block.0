Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0CAC7619A
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 18:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjDKSKK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 14:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjDKSKG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 14:10:06 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A930524D
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 11:10:01 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1a526890eeeso5178355ad.1
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 11:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681236601; x=1683828601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzGbtVW/6SHmm4BoWTYkvjSHxE3QO0d8V5cEa6xWAm8=;
        b=wpFD9F7TJuGSvrCDMNWUVZRrXj/gpSUJ82jMQGnxjYrqnBB+Z9ubdf3QJ2Pl7hMD+G
         PDR877hdYvOQJn8wRA3YXDn48kvvqyyvKP+cT+jtpSO/buLtXMb671TADS9VKoF+3CmK
         HsJIK+U+jSU71CEa+V5VT7KLznbwhkvgLifyPmttfPuuOkMsSvWyi759Fu3aaEXBpON4
         ohz9gPmtnxz6PC9MuYCumJwpT2k+R6LyOSJBZbYddSIbwAb47x+RzNhcOaV9YvynmkDw
         NaKSKhndnO7wcr44Ni7UsRwtOjYGgFHl5SsDTPceNHVLIAhMNt0reIH0vhiPdFaL6CsI
         njHQ==
X-Gm-Message-State: AAQBX9cClTm+/eGP0q6mbcdw38odg7mTziNvE67zCAtoJuWC1mrEeCmR
        zBv3UF2CClGh/FkGPaHGQnD0iThVP5Y=
X-Google-Smtp-Source: AKy350bPKhKWTnCVsqckV4Ur395k01b/Nn44K2m8lERTYMbvwUTdDWhYGVJfyzHiJuC577NndKWqCQ==
X-Received: by 2002:a62:1d8c:0:b0:62a:63e6:3282 with SMTP id d134-20020a621d8c000000b0062a63e63282mr14598566pfd.11.1681236600618;
        Tue, 11 Apr 2023 11:10:00 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:646f:c9f7:828a:8b03? ([2620:15c:211:201:646f:c9f7:828a:8b03])
        by smtp.gmail.com with ESMTPSA id y10-20020aa7854a000000b005ded4825201sm10123877pfn.112.2023.04.11.11.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 11:10:00 -0700 (PDT)
Message-ID: <28e48eeb-caf4-fe83-baec-6ed1cd154daf@acm.org>
Date:   Tue, 11 Apr 2023 11:09:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 13/16] blk-mq: don't run the hw_queue from
 blk_mq_request_bypass_insert
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230411133329.554624-1-hch@lst.de>
 <20230411133329.554624-14-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230411133329.554624-14-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 06:33, Christoph Hellwig wrote:
>   	if ((policy & REQ_FSEQ_DATA) &&
>   	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
> -		blk_mq_request_bypass_insert(rq, false, true);
> +		blk_mq_request_bypass_insert(rq, false);
>   		return;
>   	}

Did you perhaps want to add a blk_mq_run_hw_queue() call in this 
blk_insert_flush() code path?

Thanks,

Bart.
