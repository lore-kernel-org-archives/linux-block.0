Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D3AC7619A
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 05:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDKF33 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 01:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDKF32 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 01:29:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FFF1BF7
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 22:29:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58D2C62119
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 05:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6017AC433EF;
        Tue, 11 Apr 2023 05:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681190966;
        bh=DWpA9+T3NKafsJPmzDgvdwYHjXFoXj4T95ILroe8PNo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PsPQMq8J1WL1KhSpHuq6kXcwg7lVc6XWbianUCSVE3Ap1p3g4PNfRgl9PCNLdQ6mx
         iGvqXXbzu3Bc7JXpg8CWYI0jUQZcCn+8MI6i2WY8eUVpuUk2VY+Eiz5rQzfzuFVuti
         lnZpkFQxZRy3srPtAV6xCcUNB1Wvi4aJl8/3codPoaWxwUGOCEEzmezm2oTx40CAyV
         Pb2GLv9XrS5+81rq9HF38ZyA3J8R2A2deWiXOTJ1S/U05GDS4l8vyRXMJdUtgWNRIn
         UjiF6S2t0wxMA8OQtbHF0U1nCtQBeJM+pF8ojENdM591GZ7a0TUNUSFiLxX06+noWp
         9LJ7AgOTuR/bQ==
Message-ID: <92bce410-8a0f-5580-94d9-8952ebbab2d7@kernel.org>
Date:   Tue, 11 Apr 2023 14:29:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 1/1] null_blk: add moddule parameter check
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        johannes.thumshirn@wdc.com, ming.lei@redhat.com,
        bvanassche@acm.org, shinichiro.kawasaki@wdc.com,
        vincent.fu@samsung.com
References: <20230410051352.36856-1-kch@nvidia.com>
 <20230410051352.36856-2-kch@nvidia.com>
 <CGME20230410174800epcas5p3177f199ec973ba5e8e44a0a688a072e8@epcas5p3.samsung.com>
 <20230410174708.pv6xm4pwaszyabte@green5>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230410174708.pv6xm4pwaszyabte@green5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 02:47, Nitesh Shetty wrote:
>> static int g_gb = 250;
>> -module_param_named(gb, g_gb, int, 0444);
>> +NULL_PARAM(gb, 1, INT_MAX);
> 
> This value gets converted to mb, for dev->size calculation in
> null_alloc_dev. I think either there should be a type conversion or
> this module parameter max value can be reduced to smaller value.

Yeah, good catch. it is multiplied by 1024, and assigned to dev->size which is
an unsigned long. So that could overflow on 32-bits arch. So this needs some fixing.

I would still allow a very large value as possible though, to allow testing for
overflows.

> 
>> +device_param_cb(gb, &null_gb_param_ops, &g_gb, 0444);
>> MODULE_PARM_DESC(gb, "Size in GB");

Chaitanya,

Another thing: did you check if setting all these arguments through configfs
also gets the same min/max value treatment ? Ideally, we want both configuration
interfaces (module args and configfs) to be equivalent.

(Note: please use dlemoal@kernel.org. wdc.com addresses do not work right now)
