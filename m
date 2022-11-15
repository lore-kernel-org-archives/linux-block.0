Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575EDC433FE
	for <linux-block@archiver.kernel.org>; Tue, 15 Nov 2022 00:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiKOAka (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Nov 2022 19:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiKOAk2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2022 19:40:28 -0500
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603921AD95;
        Mon, 14 Nov 2022 16:40:28 -0800 (PST)
Received: by mail-pl1-f176.google.com with SMTP id 4so11720007pli.0;
        Mon, 14 Nov 2022 16:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oW03ME2CmBCFzSfXvUxvGBCWn7rXzi6KHiwAsFA8YYI=;
        b=sL8bv2XyXPlrARcrzSBzLxgwnJTSWyvVP9At2CXWPTsfGyYjZPv0VFAtV1gsuZTD2t
         egkC7gxcwPoGV0+7K6ZOzEDuQtrIsFMDk+cXksSavQKtsXj69WOgG/3PD8GxhFEPASyr
         WaO/rSLuHkrH7htfwXFCexonUNZpA2HPr91xKS+WuMrg9biTLo0tUoJ62qghzuTTpKXu
         BHuCTkZFSdrr4mFZlWNlT6X+VItZWqscnHkh1kEQ8lUKPcYyVJHPEoAqqI2jSDbRr3qa
         GEqSKaaxKayox3XM04PV1SfB7yd99nbdrpAnkooG3PpU5YJB7Q9b693MfFD5eQI+c8Kx
         EBjA==
X-Gm-Message-State: ANoB5pm1z2jntl6oOruacoL62oG2lyDeNIcwTB4hRN+fUlaiI4QsVkhb
        Ava5QFQjNhGoTGlBvWDlpv0=
X-Google-Smtp-Source: AA0mqf7TM3r3CqkJcrmgPztfsNy+RTmFkJy8mLnO/2ZhefQzQI+z2dGv0nFPXeyKG+xpSxY35hJl5g==
X-Received: by 2002:a17:902:ec91:b0:188:5dbc:96b2 with SMTP id x17-20020a170902ec9100b001885dbc96b2mr1568781plg.92.1668472827667;
        Mon, 14 Nov 2022 16:40:27 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:637b:9535:5168:c84f? ([2620:15c:211:201:637b:9535:5168:c84f])
        by smtp.gmail.com with ESMTPSA id g17-20020aa79f11000000b0056da2bf607csm7269868pfr.214.2022.11.14.16.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 16:40:26 -0800 (PST)
Message-ID: <475fba10-c471-4922-91d5-3b84c4cce149@acm.org>
Date:   Mon, 14 Nov 2022 16:40:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V2 4/7] null_blk: don't use magic numbers in the code
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        johannes.thumshirn@wdc.com, ming.lei@redhat.com,
        shinichiro.kawasaki@wdc.com, vincent.fu@samsung.com,
        yukuai3@huawei.com
References: <20221006031829.37741-1-kch@nvidia.com>
 <20221006031829.37741-5-kch@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221006031829.37741-5-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/5/22 20:18, Chaitanya Kulkarni wrote:
> Insteasd of using the hardcoded value use meaningful macro for tag

Insteasd -> Instead?

> available value of -1U in get_tag() and __alloc_cmd().
> 
> While at it return early on error to get rid of the extra indentation
> in __alloc_cmd().

Thanks,

Bart.

