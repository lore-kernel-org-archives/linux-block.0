Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBF9C43334
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 16:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiFXQfW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 12:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiFXQfV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 12:35:21 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABE547545
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 09:35:21 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id n10so2612744plp.0
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 09:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xkR/LABGJMSU6SzI+f7tKVnznvOxB9V1vhgRTbgP2mQ=;
        b=Sxm1Mr6lW21rjDxxZ98WZAPYCF2r2Eui10sAqThp6ETo0XkeYGqREM7cWW5S4n+OAg
         982MsLemYYr1tioCY9zoQ7gis4Z30Ew46ggpv6FVll2wCc7oBKh+Iw1iQliImnXY7566
         CsacwtaJqnO7j0qHT3mcb6w+/fP8WCPnfXmEswEM73Mm+KHRLDX1eAUJjaCUv9J2fAt6
         3/H30GCaT4ZqmhFBIOy8LP/LYiPOiukBr5T/Puuck2PLf92EwwylJ8kEM1Zsd02FPbkY
         AhYswuiWFkbRSco8uqlJNkfv8OzeDLLtqcI0EowbQqhDyy4xOr2sf1q1pkccm0sOqbQt
         AR2Q==
X-Gm-Message-State: AJIora8Bn06Agjvo3DdpasR5/dWk4rp8i9MvfpoqY7Hy7CXndamBt7by
        JnFdNRWB+aTiGvQa2r3vWnk=
X-Google-Smtp-Source: AGRyM1ujclv1WLueBDmh7fNFYnMbCVD/H0RlM4paqdTNxJxnGPUJG0UZmyK9mUMmq86TInzXy03Ecw==
X-Received: by 2002:a17:903:41c7:b0:16a:2dcf:c4a0 with SMTP id u7-20020a17090341c700b0016a2dcfc4a0mr23043973ple.83.1656088520612;
        Fri, 24 Jun 2022 09:35:20 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:85b2:5fa3:f71e:1b43? ([2620:15c:211:201:85b2:5fa3:f71e:1b43])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709027c0a00b0016a6caacaefsm1549063pll.103.2022.06.24.09.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 09:35:19 -0700 (PDT)
Message-ID: <5a084007-0972-14df-e530-87e294f1c8e6@acm.org>
Date:   Fri, 24 Jun 2022 09:35:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/6] block: Introduce the blk_rq_is_zoned_seq_write()
 function
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20220623232603.3751912-1-bvanassche@acm.org>
 <20220623232603.3751912-3-bvanassche@acm.org> <20220624060753.GB6494@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220624060753.GB6494@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/22 23:07, Christoph Hellwig wrote:
> On Thu, Jun 23, 2022 at 04:25:59PM -0700, Bart Van Assche wrote:
>> +/**
>> + * blk_rq_is_zoned_seq_write() - Whether @rq is a write request for a sequential zone.
> 
> This doesn't parse and is overly long at the same time.

Hi Christoph,

It is not clear to me why you wrote that "this doesn't parse"? Are you 
referring to the function name or to the function description? I think 
the text at the right side of the hyphen is grammatically correct.

Although I'm in favor of respecting the 80 column limit, I haven't found 
any explanation in Documentation/doc-guide/kernel-doc.rst about whether 
or not splitting the brief description across multiple lines is supported.

Thanks,

Bart.
