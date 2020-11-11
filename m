Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D8EC388F7
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 03:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94BFA207BB
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 03:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgKKDOz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Nov 2020 22:14:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44766 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgKKDOy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Nov 2020 22:14:54 -0500
Received: by mail-pf1-f196.google.com with SMTP id y7so721431pfq.11
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2020 19:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9tPwAhbnkjt8FH6TQ9fgo69kxGjoToLjSgUZRQONTPQ=;
        b=PRTbXKl39oXGPI3So3Xo1yHgCQzee0Q4hHmGbVSeHAAY1plMBFRvEmmQtuJBaEY2fD
         h8FhRUwIB75+GcrKvr3hbwM47ZP/uSz5lToa+txRMpWIR1YFmTfjnkaM2SoWvdUfOXao
         yJknu2amfeL8uVz5cE3Q0FOdUzbCbJK1yULiMzRfULw0vjI+KeikjTBcYkCzT8a9XD+z
         g1kuPoLVPX5Rdbrc6MjO4wsoCff8A8RyKAhk9tTZPU7URv5ro7DXDVZfkXhd4RR8xZwD
         9gZHor1rO2ZrCylTl703oBA9cOBoRvBTP/edhiANiEm98N9pCJnFVgRbVb/Knfgv9dko
         Duiw==
X-Gm-Message-State: AOAM530IU7x0Zc2XPfhit6ehPmFfbpdNyrmloLrmdMV2G5cTzYEKCNHl
        K503ucAGoy5i81yTk9gLux4=
X-Google-Smtp-Source: ABdhPJzkAXCaoeAbySCJ7/zywjBl18kpYaHWlXn/4ZmqpQac4EGY1JKNWp0dwknsCoLTWKL7FfAXGA==
X-Received: by 2002:a62:f846:0:b029:15f:f897:7647 with SMTP id c6-20020a62f8460000b029015ff8977647mr21281604pfm.75.1605064494112;
        Tue, 10 Nov 2020 19:14:54 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id 82sm525268pfy.24.2020.11.10.19.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 19:14:53 -0800 (PST)
Subject: Re: [PATCH 6/6] null_blk: Move driver into its own directory
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20201109125105.551734-1-damien.lemoal@wdc.com>
 <20201109125105.551734-7-damien.lemoal@wdc.com>
 <afdd6a5c-310f-7287-5eb4-d101a531cd6e@acm.org>
 <BL0PR04MB651412E090C15573E07CADB2E7E90@BL0PR04MB6514.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b439dcea-a473-5823-8fb2-7a5be96f5490@acm.org>
Date:   Tue, 10 Nov 2020 19:14:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <BL0PR04MB651412E090C15573E07CADB2E7E90@BL0PR04MB6514.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/9/20 8:57 PM, Damien Le Moal wrote:
> Can I add a "Suggested-by" tag with your name ?

Sure, that would be welcome.

Thanks,

Bart.
