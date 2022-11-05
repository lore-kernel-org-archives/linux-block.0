Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A75C4332F
	for <linux-block@archiver.kernel.org>; Sat,  5 Nov 2022 15:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiKEPcn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Nov 2022 11:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKEPcn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Nov 2022 11:32:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6869FCC
        for <linux-block@vger.kernel.org>; Sat,  5 Nov 2022 08:32:42 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b185so6956738pfb.9
        for <linux-block@vger.kernel.org>; Sat, 05 Nov 2022 08:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u6m1xWl0cTcngqkPkHG892As2RQXCoWAPr6dzQ1sZGM=;
        b=JTyaoj59H4cWDZL3KXPYpdeVR+b9LmS5fPyBQxtXXgLQnh+yZydPbWsiDlJ1Kt22mv
         HBSimvFze4TC9nv2jtbMXHvE0QxUoGBTyQj70IM958/D47+aq3rBMYq74yIeQ9z3wTFE
         GW728FRB+T6IIxYWMAxaQ83aIeq2T6PPN/ysAaEJbvM//jODZK06egDXkO7C5mpo1gX+
         SbMAMqNv9X4BsNNOleo9oV0JAazkXqj4b2jEIF4IJptT6Rg2fFcwI9zDrqmdqvcxAunV
         5AJaUywTcTjPdszriz++tKDHe21nECoXtKDf859UkZ465COCIesGG7yykTtybsicRJYS
         FrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6m1xWl0cTcngqkPkHG892As2RQXCoWAPr6dzQ1sZGM=;
        b=CTBgs9xXwuacRM6Zfvc9UqukOY7cPW5soPvSYwf+5YklWfnX2aUCIjLsuyyCQvRaKr
         LWGvgiMhvrfEFUgNkSgCMBXLSquytu8/tYtroKY6ZJI08wCOBaASkeQNVeApdbV0SUCY
         U0uERUaPVe5zGIsAJ4WdQgE3Dqesj0VLB7SXj//L92lE7nBkzyJJJYwwI9i2bnO+r/7R
         2HD0dhcOQaXtvPdNI6Cb2aXva/nB5Tx68cMoxEMkeOY7u/vMNcWKMK9GfSTrlxT93Lab
         JaJ9y2sTi9WMYSHOa/2YGn1u+g6a7dhuDB+JCzfp1ubxmr9Tpl32qSZAy5j5NZHoDM8U
         rYSw==
X-Gm-Message-State: ACrzQf0rboYXUsbWK+nPVo7NB/agp4GOfjpPHojkJxcTMmmz1+ELRz1L
        6sUWQIWQfzxbQ94O5uFZt66Kig==
X-Google-Smtp-Source: AMsMyM43iwI3AlHrekdzk0svmfJr8ErR3FtBgJcfpu1Sdgg00NRTf0wngRydK/o6jUUnIvc9qwYXLA==
X-Received: by 2002:aa7:959d:0:b0:56d:27ac:778 with SMTP id z29-20020aa7959d000000b0056d27ac0778mr38035147pfj.29.1667662361826;
        Sat, 05 Nov 2022 08:32:41 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b0017f9021ddc6sm1798353plx.289.2022.11.05.08.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 08:32:41 -0700 (PDT)
Message-ID: <e2e297a5-b25f-dba2-bac9-dcb2342faeb5@kernel.dk>
Date:   Sat, 5 Nov 2022 09:32:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 1/7] block: Prevent the use of REQ_FUA with read
 operations
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
References: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
 <20221031022642.352794-2-damien.lemoal@opensource.wdc.com>
 <Y2E2wFnbeUzAPjo0@infradead.org>
 <3af6895b-b776-cf0d-fe1e-866ce5e6b0b0@opensource.wdc.com>
 <Y2IXjzWL5eHA3Co9@infradead.org>
 <8125e422-7bc8-46a1-792a-f31cee7a91a3@kernel.dk>
 <Y2NylejsWVvOeZuL@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y2NylejsWVvOeZuL@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/3/22 1:49 AM, Christoph Hellwig wrote:
> On Wed, Nov 02, 2022 at 09:17:54AM -0600, Jens Axboe wrote:
>>
>> This looks fine, but if we're never expecting this to happen, I do think
>> it should just go into libata instead as that's the only user that
>> cares about it. Yes, that'll lose the backtrace for who submitted it
>> potentially, but you can debug it pretty easily at that point if you
>> run into it.
> 
> FUA and PREFLUSH are bits only defined for writes.  libata might be the
> first thing blowing up, but it really is a block layer constraint.
> So validity checking what is being sent to the block layer at the
> highest possible lyer is a good thing to ensure we don't get us in
> trouble by someone accidentally sending one down or even expecting it
> to work.  Especially as at least SCSI actually defines semantics for FUA
> on reads, but they are completely bogus and useless.

OK, fair enough. I guess we can stick it in the block layer.

-- 
Jens Axboe


