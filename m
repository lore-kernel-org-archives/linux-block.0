Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130D4C61DA4
	for <linux-block@archiver.kernel.org>; Wed, 22 Feb 2023 15:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjBVP1o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Feb 2023 10:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBVP1o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2023 10:27:44 -0500
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428E237717
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 07:27:30 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id bh1so9129993plb.11
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 07:27:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/Hj2JkNxLki+MfYsl0L4vYUE4nlrZHQmmoTmGq3XXQ=;
        b=hgb8az6yxgJ0Ei3WFf+atGwPMLrdyNYKxCNxDwyo8FpZt882/qqTNiw5/wshbv+sQ3
         VwZ4SNQ1VUg7yU0tvReC7IlEqo2qIq5Sv+KxREeKuwXbk7Pest7M5WK/vqC3lIlADksr
         kvJS6Izs5elnxBegomRsbhgGVeQYncv1HIjNjthShc9rWsWoGm9QXsvAdNiG8MdyZdhb
         u5p4EDrYj53WFRZbMet8xI/bOI+6bPu1JCvh/UK/hX+Oygii3qxjHkW9pU5GHY/shIuO
         XkrrTBSNpzM0VPN/C4RU9f1nqhbotnj515KUf+6PjyhVEapFaxCIWOsmDxxZ5GRmLyfl
         yfzg==
X-Gm-Message-State: AO0yUKVXHvFRRkKedIz6ybU2jAYO/DtMxNMNVg+ujQhOPxeddkyTU7Dj
        1FmghdDfY/CUNSLdHuXYAWy7Tdx791E=
X-Google-Smtp-Source: AK7set/3BcjvSacclIVYWjnR3dQxln6mfnberNOoV1aM6x/u0GZLUWAOnSEhwLwL3yUTq6zR93nZEQ==
X-Received: by 2002:a17:903:192:b0:19a:924f:e509 with SMTP id z18-20020a170903019200b0019a924fe509mr12555814plg.57.1677079649441;
        Wed, 22 Feb 2023 07:27:29 -0800 (PST)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id p7-20020a1709028a8700b001947ba0ac8fsm6922722plo.236.2023.02.22.07.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 07:27:28 -0800 (PST)
Message-ID: <4686cf1d-d618-d7b0-48f2-26ab94bf3985@acm.org>
Date:   Wed, 22 Feb 2023 07:27:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] block: shift with PAGE_SHIFT instead of dividing with
 PAGE_SIZE
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc:     hch@lst.de, gost.dev@samsung.com, linux-block@vger.kernel.org
References: <CGME20230222143450eucas1p1a63ff021e0aba16184197ac386c5a3c5@eucas1p1.samsung.com>
 <20230222143443.69599-1-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230222143443.69599-1-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/23 06:34, Pankaj Raghav wrote:
> No functional change. Division will be costly, especially in the hot
> path (page_is_mergeable() and bio_copy_user_iov())

Although the change looks fine to me, is there any compiler for which 
this patch makes a difference? I would expect that a compiler performs 
this optimization even without this patch.

Thanks,

Bart.

