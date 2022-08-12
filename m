Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6030C00140
	for <linux-block@archiver.kernel.org>; Fri, 12 Aug 2022 14:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbiHLOs1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Aug 2022 10:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237763AbiHLOs1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Aug 2022 10:48:27 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB8DAB4E9
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 07:48:25 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id l64so1002896pge.0
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 07:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=tmJm+SpCPyDqJ1lshIA1ETszu0sVt5hUjFD5g/2kg50=;
        b=aJ+9o9HQcipIlVWgIit02PLYCSWZQby4S9kcexl1KVoRbd5IYGKzIN29a15kXcl3tH
         kQLYYNSlzNAl1v02d7rPkfua47JAO3GOBNKFzUxavCTsZEeK1OYRR3BdVs4jJNmVoAoH
         kNPqKF4KotAOzRhuCPRWLuFYoYVXZBp8OpCvop4KzhGmsXmUsZJNDBb316UO1IPRE2PV
         o9sLm46JHvpK9rCWnkoSbovI/tG5xatcI24KnR2pt8q6nKRhLBxTbVHhauUr4NBYONjI
         LI3kHQ//6JXOfOrrskh9QahS+X8WZUrfsr3TJ76YFK3ff1+5HijxA00HyJ/6XB/wd4ut
         gYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=tmJm+SpCPyDqJ1lshIA1ETszu0sVt5hUjFD5g/2kg50=;
        b=DD26B8b7aUt/gjhO/YWy9gqkjwCuTVTCELk87OhWYNeH1DaLrlLpfEH14DXH27vgUV
         8p87W9/ywG5c0f8ocIz6/LI/FPgWbDMxJ10fwv4yUQiP2iLIZrdEsujBllHN9vxl+JEx
         2bBOkvOcJg7E1uAqah2US+KLaw9YEQhxpFHX4DPs7ufIaGzYZgIBspRa6jLzlZmomqjf
         BMIVGzjrmjGmfphjunZCxcXnWTXbQLq/MUmzrTELFSqFXvBPefx8Fuhc/movkHOFMpMH
         sg0qPhTS8/Axn4JhXX6ZxIMLIooRX8leLIF9AQzPwvyUvb6SrIi/1YU2G7CIdaXYVlNi
         ABtA==
X-Gm-Message-State: ACgBeo38VVaeE538jd55N/SVLlPmBgFsfsuDZvHF3rsBux5k2lO1By0j
        APNKrS1QPygm3B/NhrYiaKC1aQ==
X-Google-Smtp-Source: AA6agR6GZCf3r5KmUJM1S3uTXeEKj1oUGGU+qcmom++g7ekrhliqaeUv0A+Xqdt1Ba4yqQaLzwQyZw==
X-Received: by 2002:a63:2dc5:0:b0:423:1abf:d0b3 with SMTP id t188-20020a632dc5000000b004231abfd0b3mr28018pgt.211.1660315704696;
        Fri, 12 Aug 2022 07:48:24 -0700 (PDT)
Received: from [10.4.217.209] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id u13-20020a170903124d00b0016db6bd77f4sm1898601plh.117.2022.08.12.07.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 07:48:24 -0700 (PDT)
Message-ID: <686b645c-c4e1-357f-7c57-b961a1feeda0@bytedance.com>
Date:   Fri, 12 Aug 2022 22:48:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH] blk-mq: move bio merge attempt to blk_mq_submit_bio()
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220812083944.79616-1-zhouchengming@bytedance.com>
 <330468da-a778-6cfc-ce46-a62566d71c8d@kernel.dk>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <330468da-a778-6cfc-ce46-a62566d71c8d@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/8/12 20:40, Jens Axboe wrote:
> On 8/12/22 2:39 AM, Chengming Zhou wrote:
>> We will try to get request from cache before alloc request, in
>> both cases will first attempt bio merge.
>>
>> This patch move this common part to blk_mq_submit_bio(), which
>> simplify the code and avoid passing in the pointer of bio.
> 
> I don't think this will work. If we get a cached request, then we
> know we have a reference to the queue. If you swap these around,
> then that's no longer the case and we can have a use-after-free if
> the queue goes away.
> 

Sorry, thanks for your reply!
