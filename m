Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941ACC433F5
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 15:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiI2PCJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 11:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiI2PCG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 11:02:06 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2571E61D8C
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 08:02:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id z3so540790plb.10
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hhi+oVEJiWIGl0XmkX85fNYxt8vQMFlqyBNbKz3hsOk=;
        b=7PcDTSQraM9qqbnmfUrqMeFfUMelJPXlF0oQJpmCf/V2xLopbESMTZ1zIhkFaZpHwi
         1LKEMr493cjzsvxxzFc5HOnHdHwvYINTFp9X53kJh1q4Gz4wM4xjsJcvGFB/TmXQkmm/
         DRiQ6RO+wU5ogRM2Pj4YQJuJR0xKyOE7aBBxMJ0ggwoafGyRATMm4hma2x1oWJskOhne
         8APA7mFkMYmdOaT21zI2cD5zedyDVklboXFczSl1MLMz2G9k3jhbuLtI3foYe2HF1/rA
         SHTRmSPiXeK7AkCuWhENHPwzfAonE9psK8d6famwiWlstNDuRUW0GveN94P7U/2AZSp/
         qJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hhi+oVEJiWIGl0XmkX85fNYxt8vQMFlqyBNbKz3hsOk=;
        b=6rlw1tc0cMduZt3zTJQzEmGYz+DntRFDs9ZgEI+JAdWKvSIpLYjXiqWwC/0zBnYdby
         odbPiGjvXfaObEKJUx1Dxd4XTP8kFHPPhPFLNamxWoljmnPtrf5EcRsdmj3zvLzjn4OE
         POmnbr1OQQ55zDmP6aKp0ZmyfsYAnkXo6QKqNVuvkoWOGSLLzhwFdieC2BDC/ySX6QTi
         5ykKkhYUJbjW9UM1Lpry84/xvYvdOWW8KjToVs6Idd47QaFOvy0ArBJSNFeJUaq4DnpB
         bgZguVsxQqwAGeAupnhGJFmCsqNQswA57neLjrErgU0k9tOwo9EkXUeyxy1ndc1aMwFq
         nrxQ==
X-Gm-Message-State: ACrzQf35Nq5GLT2hlOUt884wWUC1eO/pFU0MQ8uR2Jts5umEZ10SavQ6
        fBR0K2p4yThhym3tBB3qhSMZfg==
X-Google-Smtp-Source: AMsMyM5WlmGh5rqcQAxaSKU1lTDKwv4Hl4dbuzR7bS1dGALnHzRJV+Mgu7ENyjl8+BrAEbYdydOKnQ==
X-Received: by 2002:a17:902:da83:b0:17a:111:ebdf with SMTP id j3-20020a170902da8300b0017a0111ebdfmr3834643plx.149.1664463724546;
        Thu, 29 Sep 2022 08:02:04 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 26-20020a630e5a000000b004393f60db36sm5672394pgo.32.2022.09.29.08.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 08:02:03 -0700 (PDT)
Message-ID: <1e6a094e-c2f7-a352-d91a-ac5169afeb58@kernel.dk>
Date:   Thu, 29 Sep 2022 09:02:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] block: add rationale for not using blk_mq_plug() when
 applicable
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de
Cc:     gost.dev@samsung.com, damien.lemoal@opensource.wdc.com,
        linux-block@vger.kernel.org
References: <CGME20220929144143eucas1p2a68d7cb3f5e347954e3a5a5e335cf620@eucas1p2.samsung.com>
 <20220929144141.140077-1-p.raghav@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220929144141.140077-1-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/29/22 8:41 AM, Pankaj Raghav wrote:
> There are two places in the block layer at the moment where
> blk_mq_plug() helper could be used instead of directly accessing the
> plug from struct current. In both these cases, directly accessing the plug
> should not have any consequences for zoned devices.
> 
> Make the intent explicit by adding comments instead of introducing unwanted
> checks with blk_mq_plug() helper.[1]
> 
> [1] https://lore.kernel.org/linux-block/f6e54907-1035-2b2c-6387-ed178be05ccb@kernel.dk/
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Suggested-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-core.c | 5 +++++
>  block/blk-mq.c   | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 203be672da52..c19d084b2a74 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -850,6 +850,11 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
>  	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
>  		return 0;
>  
> +	/* As the requests that require a zone lock are not plugged in the
> +	 * first place, directly accessing the plug instead of using
> +	 * blk_mq_plug() should not have any consequences during flushing for
> +	 * zoned devices.
> +	 */
>  	blk_flush_plug(current->plug, false);

Multi-line comments should follow the style of:

/*
 * This is a multi
 * line comment
 */

I can fix that up while applying.

-- 
Jens Axboe


