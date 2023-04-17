Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEE8C77B72
	for <linux-block@archiver.kernel.org>; Mon, 17 Apr 2023 19:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjDQTsF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Apr 2023 15:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjDQTsF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 15:48:05 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577D94224
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 12:48:04 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id s23-20020a17090aba1700b00247a8f0dd50so3063020pjr.1
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 12:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681760884; x=1684352884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ2CIntb1hvk5OnTqGtdPxT+4B3zvvye42O1AGXlKNs=;
        b=Rq97LLPsPK4KevclOmBPE34q0DSlje0INIHd35Ug4sCFl//Kwwj/3swHk7zDYzs+vS
         Js8GFQvQ2UC2QtaFr0rox8yUtnSQrPowe6VwbmVe6lnSF05qvZ2nkZhhEeiRJM2bHWdS
         Z68irQ4fUnLxsK558/ThutsVWDwdlOd8Ed/sm6wAdCLue94P4akXvSV3rowIfoj7GsNS
         EZh7b0C4mERiy9CqBt1phxGX6akvMYyHPR1ZATMG0fXnwdOdwD1BdZ60KgG3aXnR5Mhn
         LS7PXX3TjQHtp/sQoKcS16Obu1/VTFKYclJQwtvVaWHvWg0I4mwqpxJUACjY9ldp0h3r
         UYsw==
X-Gm-Message-State: AAQBX9cFdbChmh9XU596oP0iOYOGW01rX7GgSMifepo9A6DD24aLfI2y
        LHSqTfEushAbG/AaT4E8SNo=
X-Google-Smtp-Source: AKy350YIBPiA9v4N1U6tV1UYWf1GXMTRxAH4Frwvk4bnvX8TmqtosjgiUfRD7/JU2jR1il12Y38gkw==
X-Received: by 2002:a17:90a:d591:b0:247:6c32:37e5 with SMTP id v17-20020a17090ad59100b002476c3237e5mr7240115pju.13.1681760883707;
        Mon, 17 Apr 2023 12:48:03 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:2cdd:e77:b589:1518? ([2620:15c:211:201:2cdd:e77:b589:1518])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090a530600b0024749e7321bsm5087696pjh.6.2023.04.17.12.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 12:48:03 -0700 (PDT)
Message-ID: <8db01734-6614-7db6-58a6-7faa45ef0509@acm.org>
Date:   Mon, 17 Apr 2023 12:48:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/7] blk-mq: defer to the normal submission path for
 non-flush flush commands
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20230416200930.29542-1-hch@lst.de>
 <20230416200930.29542-4-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230416200930.29542-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/23 13:09, Christoph Hellwig wrote:
> If blk_insert_flush decides that a command does not need to use the
> flush state machine, return false and let blk_mq_submit_bio handle
> it the normal way (including using an I/O scheduler) instead of doing
> a bypass insert.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
