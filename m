Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BFFC4338F
	for <linux-block@archiver.kernel.org>; Sat,  7 Aug 2021 16:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBEDD606A5
	for <linux-block@archiver.kernel.org>; Sat,  7 Aug 2021 16:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhHGQRA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 7 Aug 2021 12:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhHGQQ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 7 Aug 2021 12:16:59 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D93C0613CF
        for <linux-block@vger.kernel.org>; Sat,  7 Aug 2021 09:16:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u5-20020a17090ae005b029017842fe8f82so13514794pjy.0
        for <linux-block@vger.kernel.org>; Sat, 07 Aug 2021 09:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hSiQWcxOeb6H8lVeRKmlUrfbadCZCq/IN0zGwt6aOMU=;
        b=h+IjOjM/QHRahEtxOtPJ0luI2z0uupCF+/HWgHixl7GEsjmqkgXiYb0lVuGjoGHmSn
         A6GBt7YlD5bXTnNAqOwjdCBMYGDzIDpfLeju7oarB224Dr5mjaVT1kHrXRbHYZ4oVTNu
         VIj380LDnV1DJop+wNJSa3SgL8w3rdGPLgsoFGxQAzO3ynf6XsVRGYCo2Z70HNe+85MH
         PC2ejeJKOh9b2b0IA1NBN36IujdtaEr3VO/Pwt8f0reYNIaPe5XtbhPz3IuRYptEIOxc
         OhUduZI8FQzGAoKvhqgm7jinPuehwTGTcVc4NdyjU1HYLYIVDnOyYzmJEoBr15D6+RH7
         reHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hSiQWcxOeb6H8lVeRKmlUrfbadCZCq/IN0zGwt6aOMU=;
        b=feM2JQhQPrgvc3SKWazOtywX/Ubvoma2S7St5kcu9jbUsPR+qEcAAzzUPRuSa9Kxpb
         1f3Hr8wsbPezT+Gl2vuLBpaL7ZpKgKzxEqZrV19wJXb0nTACCDgNegcSslJ12Bke375f
         hnOD/bazSvWZdSmAeAzSGxcN9AV4VDErW0XR54JtTPE5Qv0znQ7aYQpvkvHkPQMceVSR
         Sh2cPJ20KL4dBxGUbI26xxNrOiNl5wPhDcZDaeOuqEdZlwEFlpsoTbNyywkxvjOq/Uk9
         kPHqL9KucyTarJl4KbtfsiLNeUc0xCpoiorrgKReRGcSHa+U2HvejGo1SGXd5GjAqk3V
         f7bA==
X-Gm-Message-State: AOAM533JWFOljBdQys3pybwJPJQ5EDC/gHaZOmWzSljwL567kd5V9Udt
        Dh6xyJZXmLFP8Orxx2so5tRrUQ==
X-Google-Smtp-Source: ABdhPJyAiu0tJuRJYapivcu+TujecpU4eiJWcmiXFrpgW71PZtm6W1SstJsz9a57oqvzz880JnqWVg==
X-Received: by 2002:a17:902:a406:b029:12b:c50a:4289 with SMTP id p6-20020a170902a406b029012bc50a4289mr13472963plq.56.1628353001915;
        Sat, 07 Aug 2021 09:16:41 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id c23sm14578792pfn.140.2021.08.07.09.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Aug 2021 09:16:41 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] block: rename IOPRIO_BE_NR
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
References: <20210806111857.488705-1-damien.lemoal@wdc.com>
 <20210806111857.488705-4-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5f2640c5-0712-b822-9ac7-3daa974c0c30@kernel.dk>
Date:   Sat, 7 Aug 2021 10:16:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210806111857.488705-4-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/6/21 5:18 AM, Damien Le Moal wrote:
> diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
> index abc40965aa96..99d37d4807b8 100644
> --- a/include/uapi/linux/ioprio.h
> +++ b/include/uapi/linux/ioprio.h
> @@ -31,9 +31,9 @@ enum {
>  };
>  
>  /*
> - * 8 best effort priority levels are supported
> + * The RT and BE priority classes both support up to 8 priority levels.
>   */
> -#define IOPRIO_BE_NR	8
> +#define IOPRIO_NR_LEVELS	8

That might not be a good idea, if an application already uses
IOPRIO_BE_NR...

-- 
Jens Axboe

