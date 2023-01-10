Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F06DC54EBD
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 00:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbjAJAlY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 19:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbjAJAlV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 19:41:21 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927EC27B
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 16:41:20 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9so11458455pll.9
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 16:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JbLntlw2niyP8mO7NNrFbbWl6hHtew401p8efPBbgCA=;
        b=S4bR6VGTB+ObMUfimUz0GFUeWiHA0HGxUA2k6DtiBIf/jR2/wVqYntpPOBtJSXvFxZ
         2M/xXxQowrAoN4p5gwPowqO4iLqqOWrXCtbKH/gyXMIKPz8An/SO37XjXyvS9Qq7cJJ+
         UiGqmes8JnxVjvusExtuplAySV7o09bMJZuc0hQt8tLK+bYjePDEWSa5Ksmdc6sZRCCb
         w9GoxD+gXXH6zQ5mWRazlGu6T+QVe3aZK6g2IpFTkHmORuHJnfRcYdcXLa2J55Ekocgz
         hDnYO2d6Ma4zVVH/P8eLTYydnxzXN6ZMzC4mJWbFfpd9cDlX8fuykFN9nbs3cyPf04TK
         izbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbLntlw2niyP8mO7NNrFbbWl6hHtew401p8efPBbgCA=;
        b=zNwMSWnaowhLLQPO1qwEYXYNhq7gt/3ffHrVFUpstAH6PXdMYSipsvmt/x7ei/lO3q
         gMm7Ags83UC/YbaBzkzuZp6SPLzrxSAECLrr0CrRi4BW6f0Af2NSmyQErxrxnfMVm4ab
         9NMMJbHD/HG3VvV8o4bMNRkuWoUNY7X3AteZhzwIOhW8Wjh60TQ6ApCJmbTz0OqMn4f7
         ecv6YwhxKTb7aCVfiwXn1yfL53Cg6AUruXpJ/WS/7l0jLtQaUI9WBBWs9T/R/AuTQk6J
         S/DITGo1TJaWRqeJ1FNCyc3nwjluRszJR9QJ+YDsVQKUH0MVtUsKRZMkIxgw/SnZ53hY
         eJrA==
X-Gm-Message-State: AFqh2krqZKfOwdxfichEqqkb6MzRm2+BJ+R5pxVTi4VfdPiH16SaNOFn
        vQXzlzeu9s/Q60aW6gApxhTmPrR+kexoUhG9
X-Google-Smtp-Source: AMrXdXt/42xV7gqNGO8dPFbWK7rhmtPwF43/9hhSRgQe1CXFVl4kYXsqRCfnHgC+X36KxtwVkHJWKg==
X-Received: by 2002:a17:90a:f104:b0:227:c6c:bdb3 with SMTP id cc4-20020a17090af10400b002270c6cbdb3mr1442674pjb.4.1673311280065;
        Mon, 09 Jan 2023 16:41:20 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090a2e0300b0020ae09e9724sm5865753pjd.53.2023.01.09.16.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 16:41:19 -0800 (PST)
Message-ID: <49a9fd49-c9dd-8e5d-368a-ac182f7165ca@kernel.dk>
Date:   Mon, 9 Jan 2023 17:41:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/8] block/mq-deadline: Only use zone locking if necessary
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-5-bvanassche@acm.org>
 <92096c6d-fe0a-7b5b-222f-c532286c0c8b@opensource.wdc.com>
 <7bf28b7e-7301-29b5-c610-dff04ad6337f@acm.org>
 <a4f42abc-08dd-9a2e-3e6d-371e3ed695d2@opensource.wdc.com>
 <b72e484c-2985-a755-b0e1-e9ccd93cfc3b@acm.org>
 <681a991f-e09a-eeb6-805a-ee807250c399@opensource.wdc.com>
 <2f0f4f28-4096-ab76-5be3-56c44231fed3@kernel.dk>
In-Reply-To: <2f0f4f28-4096-ab76-5be3-56c44231fed3@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/23 5:38 PM, Jens Axboe wrote:
> On 1/9/23 5:32?PM, Damien Le Moal wrote:
>> It may be way simpler to rely on:
>> 1) none scheduler
>> 2) some light re-ordering of write requests in the driver itself to avoid
>> any requeue to higher level (essentially, handle requeueing in the driver
>> itself).
> 
> Let's not start adding requeueing back into the drivers, that was a
> giant mess that we tried to get out of for a while.
> 
> And all of this strict ordering mess really makes me think that we
> should just have a special scheduler mandated for devices that have that
> kind of stupid constraints...

Or, probably better, a stacked scheduler where the bottom one can be zone
away. Then we can get rid of littering the entire stack and IO schedulers
with silly blk_queue_pipeline_zoned_writes() or blk_is_zoned_write() etc.

It really is a mess right now...

-- 
Jens Axboe


