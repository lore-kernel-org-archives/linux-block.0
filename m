Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0271EC5479D
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 00:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjAJA4n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 19:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbjAJA4h (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 19:56:37 -0500
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773533FCAB
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 16:56:36 -0800 (PST)
Received: by mail-pf1-f179.google.com with SMTP id y5so7560849pfe.2
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 16:56:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2GzPXvXVNc1uhHhKlv21pQs6Bt6LyEhaqQ1kWPjeavk=;
        b=j3Mqh23AGlRJFZHOAj8fyVozn7HrpZcys8zQWtHwQbtZ/2H6O4w0JPS19WkbpfsqNE
         hoILo9dKdTasr9HZf7oAqp6oztHzyej+gtnacmnEfCDFOmm/nBExi46jkFb7GZOUbQg1
         lAFmufm8wTINtd3hX7X7ilosOJ73DVEWnOA9hfl/Xz/fzCqvAjE1wIzAiy7J1/NQhEl0
         ggvhMeCAwG6qdmiy0HeN30p9O5cR4SWv4UGTs4XXj8BQUfWq2mvhNR4goAn+tmaxhRFP
         FdKyIxeETb8K55K7Ngos3NnZo4nuS+xdONBQ758rVDNAxs+E7NxvPWR3jLKxqrmCNXZy
         qy3Q==
X-Gm-Message-State: AFqh2ko4muCWrRGDETmHv8Y1ADcES6HQMXlA5jtZSl1wBENdQWlfhwmy
        5LgnJiIqNKFH0VYcRlWGnNs=
X-Google-Smtp-Source: AMrXdXvz7fU+IhZWvKy7tY/jJJ1B5vdpSZlxiaVi3twpJIExsKLXtb7e0WEVGa2PwirwCNJRKNkfOQ==
X-Received: by 2002:a05:6a00:1d1f:b0:581:ad48:d480 with SMTP id a31-20020a056a001d1f00b00581ad48d480mr40718222pfx.34.1673312195829;
        Mon, 09 Jan 2023 16:56:35 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:9f06:14dd:484f:e55c? ([2620:15c:211:201:9f06:14dd:484f:e55c])
        by smtp.gmail.com with ESMTPSA id 189-20020a6217c6000000b00580f630a05csm6627784pfx.180.2023.01.09.16.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 16:56:34 -0800 (PST)
Message-ID: <31d32f69-4c14-c9be-494f-7071112073f9@acm.org>
Date:   Mon, 9 Jan 2023 16:56:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/8] block/mq-deadline: Only use zone locking if necessary
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
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
 <49a9fd49-c9dd-8e5d-368a-ac182f7165ca@kernel.dk>
 <07084f70-00a7-d142-479c-52c75af28246@acm.org>
 <72092951-3de8-35a3-9e50-74cdcc9ee772@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <72092951-3de8-35a3-9e50-74cdcc9ee772@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/23 16:48, Jens Axboe wrote:
> On 1/9/23 5:44?PM, Bart Van Assche wrote:
>> On 1/9/23 16:41, Jens Axboe wrote:
>>> Or, probably better, a stacked scheduler where the bottom one can be zone
>>> away. Then we can get rid of littering the entire stack and IO schedulers
>>> with silly blk_queue_pipeline_zoned_writes() or blk_is_zoned_write() etc.
>>
>> Hi Jens,
>>
>> Isn't one of Damien's viewpoints that an I/O scheduler should not do
>> the reordering of write requests since reordering of write requests
>> may involve waiting for write requests, write request that will never
>> be received if all tags have been allocated?
> 
> It should be work conservering, it should not wait for anything. If
> there are holes or gaps, then there's nothing the scheduler can do.
> 
> My point is that the strict ordering was pretty hacky when it went in,
> and rather than get better, it's proliferating. That's not a good
> direction.

Hi Jens,

As you know one of the deeply embedded design choices in the blk-mq code 
is that reordering can happen at any time between submission of a 
request to the blk-mq code and request completion. I agree with that 
design choice.

For the use cases I'm looking at the sequential write required zone type 
works best. This zone type works best since it guarantees that data on 
the storage medium is sequential. This results in optimal sequential 
read performance.

Combining these two approaches is not ideal and I agree that the 
combination of these two approaches adds some complexity. Personally I 
prefer to add a limited amount of complexity rather than implementing a 
new block layer from scratch.

Thanks,

Bart.


