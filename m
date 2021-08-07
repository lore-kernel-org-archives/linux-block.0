Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11871C4338F
	for <linux-block@archiver.kernel.org>; Sat,  7 Aug 2021 16:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4DEC6101D
	for <linux-block@archiver.kernel.org>; Sat,  7 Aug 2021 16:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhHGQU7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 7 Aug 2021 12:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhHGQUh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 7 Aug 2021 12:20:37 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78375C0613CF
        for <linux-block@vger.kernel.org>; Sat,  7 Aug 2021 09:19:52 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b1-20020a17090a8001b029017700de3903so15106912pjn.1
        for <linux-block@vger.kernel.org>; Sat, 07 Aug 2021 09:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sE4J/KNRIhq4Qq1TJTV7nxoeSBjq593vfcTRyIoqZB8=;
        b=F8bJc5ayOa1NQ/0OLvIq7fauc1tSb4zx9pEU23QZ03TiiHbDjRvGxkf4tZiV/xmwuw
         qXJBY04ip1ae+q8XRoAgpltiT/vwxOfzHD1FSKvNBAAOdC0MgORNTxsnWjF/H1Oo90Ys
         6E0jDg5fXZm/Tyhqi5xSbdJJefUZme4h1sR2G8NoGw5zfX2rEWHwu4moCjzi22X1sGt0
         Qt7/cxoAwgTwUaxfr1M8NIcx1iCOsCaMSUG239oKtOTnqvhJBUzmo7nfgYynFwFe/OqQ
         eV2pkrza5d5MrVkNZ/JJrxRer+hTlanySw3H7TR9VqkpgIRbAYnHI61HYrA+x9AT+NFm
         2NcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sE4J/KNRIhq4Qq1TJTV7nxoeSBjq593vfcTRyIoqZB8=;
        b=f+fwMQ7bjRd0DUN+abi8VfEyLD1QPMdKOz3m5VDDwllhaY2sdUsUEaFU1FDe4EcH4Y
         jCKgqNVs2q3HG+6p3wMgkV04gL2FRpX5aLasJd8HEbiya8JXlpTcd+YArCNq6oLaywAf
         Ob9WWONOGECJG20mJD/qLHeigfMofd39QNhG8gC1hYF5gz2cIh8Jr6VBxid7SMdQlNSQ
         2PDLXPCvNwCRnrmWRzEBZ8Xx72Gpato7CAvRuiXcOFmIWK5Lgh/NtjpPxWT5oaYgauxT
         2ADhjYXnPDw8Jo509iyeX4+Nh3lYzW6CGrMy/bp3Q3cw0Wcrn52tz9EvjOR1D4ekkPx6
         QjlA==
X-Gm-Message-State: AOAM5312yA6sGp9vTPLLV4DzdXHn95GqqiwN6w3OwACXfZjaRnjBKbH+
        rxyjbO2TiRuJIhOD/DihilX81g==
X-Google-Smtp-Source: ABdhPJzk4/8bmVQ2Nl31owua5k69ZyxSZipU5YOIY/m7LVvU8DIehftrExiEXUCenqHaKirRIpmZYQ==
X-Received: by 2002:a63:cc0e:: with SMTP id x14mr1332919pgf.352.1628353192079;
        Sat, 07 Aug 2021 09:19:52 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id jz24sm12842797pjb.9.2021.08.07.09.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Aug 2021 09:19:51 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] block: fix default IO priority handling
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
References: <20210806111857.488705-1-damien.lemoal@wdc.com>
 <20210806111857.488705-5-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4bfdceb3-36a7-c224-c1cc-ab273ab15589@kernel.dk>
Date:   Sat, 7 Aug 2021 10:19:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210806111857.488705-5-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/6/21 5:18 AM, Damien Le Moal wrote:
> diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
> index 99d37d4807b8..5b4a39c2f623 100644
> --- a/include/uapi/linux/ioprio.h
> +++ b/include/uapi/linux/ioprio.h
> @@ -42,8 +42,8 @@ enum {
>  };
>  
>  /*
> - * Fallback BE priority
> + * Fallback BE priority level.
>   */
> -#define IOPRIO_NORM	4
> +#define IOPRIO_BE_NORM	4

This again seems like a very poor idea.

-- 
Jens Axboe

