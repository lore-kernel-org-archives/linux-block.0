Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E62C77B70
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDKRye (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjDKRye (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:54:34 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A360E5241
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:54:33 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id y6so7537209plp.2
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235673; x=1683827673;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GczZP1XZW2hjTLSS+lC6WvoGtkquJAgUI33PhjM7Axk=;
        b=SkYaUVRQ0FzBfqxpCP4u3euQFZGGhJVIwMxvVmprWbGdXFMJ+4V9bLguVR7vDe20GB
         YCBYLoabZtxHq6oZuAtdK9Iz8fGINQmTKTPuSrYpiknc7g2Np3Sm4Lx2pdi49ZhUYmLT
         iTpk0hIPDrmZB2HPUYLgJ5nvZyGURi0KKc95d53YkVh8KCjJ4gHgzuJLugYPFqxnGlUl
         hjSPtQRmK5TmlQYAV14K0kpsJL7dQaVDUbpWMzz2WQN6UkRDQ3xedPECVd4rOy/aokgz
         vlcO3DkRM2pOFL21IJUII1SRPZdqlaTjfjCw2kTC4JlOVJdojFHKP8t/B0BwvmICDOLc
         C6gg==
X-Gm-Message-State: AAQBX9eKj2q57dP6hM/+AZv7OD2CHI5oy7UVIIlPV+WSXayjHkabS+pi
        drtAae4BSwQTDNoeM+ZW8BkmAAWhYPU=
X-Google-Smtp-Source: AKy350b5HuD0jFIEZRBgKyI4q/xwmFZo/KWPYMtXieoC5k6j7+SGshJiGelPROG1wYnExv7xlhiWnA==
X-Received: by 2002:a17:90b:4a86:b0:23f:b35a:534e with SMTP id lp6-20020a17090b4a8600b0023fb35a534emr20150513pjb.29.1681235672978;
        Tue, 11 Apr 2023 10:54:32 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:646f:c9f7:828a:8b03? ([2620:15c:211:201:646f:c9f7:828a:8b03])
        by smtp.gmail.com with ESMTPSA id y1-20020a63de41000000b00513092bdca1sm9172554pgi.73.2023.04.11.10.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 10:54:32 -0700 (PDT)
Message-ID: <9ecdc2c3-2536-f0ae-b756-074d4ee5282c@acm.org>
Date:   Tue, 11 Apr 2023 10:54:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 08/16] blk-mq: refactor passthrough vs flush handling in
 blk_mq_insert_request
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230411133329.554624-1-hch@lst.de>
 <20230411133329.554624-9-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230411133329.554624-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 06:33, Christoph Hellwig wrote:
> While both passthrough and flush requests call directly into
> blk_mq_request_bypass_insert, the parameters aren't the same.
> Split the handling into two separate conditionals and turn the whole
> function into an if/elif/elif/else flow instead of the gotos.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
