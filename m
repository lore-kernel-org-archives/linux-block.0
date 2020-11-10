Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1442C2D0A3
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 02:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FF9C207D3
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 02:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgKJC5F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 21:57:05 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43184 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJC5F (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 21:57:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id z3so10043108pfb.10
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2020 18:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Qn46a/o139iUfbGZTnrrDwFAe/ia+1+hk/Cbk3G+q4=;
        b=Cqm7U+roQw1FsKKVMJ0wSwdMo0pXDbq6l3TNismP2kkDUHYJBW2mKb+bupTAEXHkcF
         lv2Njnbcuq1rZjcX5qNwnQ/cXtZ3H8rV+zuKG9/beeLF2gIIt6mgfXnZDljIR2OwPS8k
         rvRxu6AVC2BC5GQbDuTTEyFyWYPYgaYpZ1qQYBNKwPO9AnyZSQzXUGWwSZYcB+ukhjgb
         b9rV0D57nrL2TYaiAoS7QtI+j6PTaO5DLLsVOTCpZFyh6/NzlvRhBB2E6iIciOXSS4gb
         jcnuNbyFgEAG1IAybNpvOx2cnW8TyFeH5XAsdjZVdVwImncVQWCppaisigpIASxjnk4G
         RPgw==
X-Gm-Message-State: AOAM5309Vp1q/HnYrHmTvbR/BT2yFecIy63QSxyuO5fJzJK2M+IJGuG0
        D7FI0EfCjAB7NcZtnmnHYLM=
X-Google-Smtp-Source: ABdhPJwPiRPzhhNq1ITV0MylVw5svC+f0foScZlN8VU9TCOkb0T/aDQkCARj7CRO2jLD1CXrK0PmSQ==
X-Received: by 2002:a63:4912:: with SMTP id w18mr15774547pga.131.1604977024953;
        Mon, 09 Nov 2020 18:57:04 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id l62sm11957965pga.63.2020.11.09.18.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 18:57:04 -0800 (PST)
Subject: Re: [PATCH 6/6] null_blk: Move driver into its own directory
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20201109125105.551734-1-damien.lemoal@wdc.com>
 <20201109125105.551734-7-damien.lemoal@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <afdd6a5c-310f-7287-5eb4-d101a531cd6e@acm.org>
Date:   Mon, 9 Nov 2020 18:57:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201109125105.551734-7-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/9/20 4:51 AM, Damien Le Moal wrote:
> Move null_blk driver code into the new sub-directory
> drivers/block/null_blk.

Is this perhaps something that has been proposed before (see also
https://lore.kernel.org/linux-block/20200621204257.16006-1-bvanassche@acm.org/)?

Please address the following review comment that was posted by Jens:
"I'm all for this since, but why not name them null_blk/main.c etc?  A
bit annoying/redundant to have them be drivers/block/null_blk/null_main.c
and so forth.

Probably have null_blk.h be the exception."

Thanks,

Bart.
