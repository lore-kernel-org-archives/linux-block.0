Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E717C7EE2E
	for <linux-block@archiver.kernel.org>; Wed,  7 Jun 2023 20:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjFGUXF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jun 2023 16:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjFGUXB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jun 2023 16:23:01 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C056C2122
        for <linux-block@vger.kernel.org>; Wed,  7 Jun 2023 13:22:20 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b0338fac5dso8523405ad.0
        for <linux-block@vger.kernel.org>; Wed, 07 Jun 2023 13:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686169322; x=1688761322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LfCmBNg3+Uy1inUmOxVLBDjLR39fkV9eWgE4s9E2L1M=;
        b=3iAfZ8xyjx1cuFNM+HY9k/R83T8jW44DMw/mRj3/KeCerY6N9MDC0PloVp3rsod/+R
         quRP8zyOmkpSZSkkiswlaP/r3xPuIZkdrQWMqDgk3HuD3fF/suRQhpAnHuwJNBULjLIU
         /aU+0MdNfHxgpi04n/Tv09ZUvnJ3FhzISWpOoe8I5FOGDs9rnuctIkZbcEQVaESRvCdk
         3p9TWd4Y3d6hdOdQfBRXQJ8ah7Yqai9HxdVqvOYjbMDy3U+ox4rpM0JEA6A6s+f1jUGF
         63c2l4BunZaAeQ35qn4rb281naqGC47L1Ovj7UXnYxQrV2zzje10Yz9tF3AcvfeROL0n
         TYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686169322; x=1688761322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfCmBNg3+Uy1inUmOxVLBDjLR39fkV9eWgE4s9E2L1M=;
        b=f/QUoX50GziIN22Pr5XUK4QH5D9zXHNreKEoavVd3QovdGKyTZelKc5UVlZKTGIXYb
         YMSOA4dVJuu9uR7IopiHJWa98TsMV/Zijzx8VUK1PiZo1100d0fTD7qNcRN9G2uH0288
         0ACz+ShlaP06Eul9DY/G1myLOQAL6puNPM9Q0fM6+SXHZSH7skLHBAyeABQkRpWmmHlX
         vHFBeAH4Scf0CrXqzy1RT2jHs+0w7j/SIqFt6VH0pNAv65H0TTbM4lklonJb/IxfqFFi
         XMY1kPgnybVK6pwCqc4chZBCd/39TAUDnDjjTNQ4C6kl124ZWzuBk26vyblQwW7fwlgy
         IZYQ==
X-Gm-Message-State: AC+VfDxxla78QN3887Owo0pD1pSn61QTZi+Apmh5Ykhhfwc37nl+1Qgx
        78V6jWQph2mXpchEZlUozHOdsQ==
X-Google-Smtp-Source: ACHHUZ6Cd+UehTWRW7DGE4Pn67++NdA2EmMZGXqex/Wr+tqQoHXFeTtZUV7Hn8eH6V4VkTapVI6P1g==
X-Received: by 2002:a17:903:41cf:b0:1ae:4567:2737 with SMTP id u15-20020a17090341cf00b001ae45672737mr6982746ple.2.1686169322124;
        Wed, 07 Jun 2023 13:22:02 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:122::1:6343? ([2620:10d:c090:600::2:9b70])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d2c100b001a67759f9f8sm10870339plc.106.2023.06.07.13.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 13:22:00 -0700 (PDT)
Message-ID: <b8e954f3-bd03-9264-5abb-f887448c5f3e@kernel.dk>
Date:   Wed, 7 Jun 2023 14:21:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/9] pktdvd: Clean up the driver
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230310164549.22133-1-andriy.shevchenko@linux.intel.com>
 <ZH9JnPAL8x2GPSV3@smile.fi.intel.com>
 <c00870f9-9ae4-27b1-3362-444aa76d7671@kernel.dk>
 <ZIDjwjRbX+YkA5J1@smile.fi.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZIDjwjRbX+YkA5J1@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/7/23 2:08 PM, Andy Shevchenko wrote:
> On Tue, Jun 06, 2023 at 02:23:03PM -0600, Jens Axboe wrote:
>> On 6/6/23 8:58 AM, Andy Shevchenko wrote:
>>> On Fri, Mar 10, 2023 at 06:45:40PM +0200, Andy Shevchenko wrote:
>>>> Some cleanups to the recently resurrected driver.
>>>
>>> Anybody to pick this up, please?
>>
>> I can pick it up, I'm assuming this is all untested?
> 
> Compile tested only. So I assume the answer is yes, untested.

I'd be surprised if you said you actually ran it. Series looks sane,
I'll get it applied. Thanks.

-- 
Jens Axboe


