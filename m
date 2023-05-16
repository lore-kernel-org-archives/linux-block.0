Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D93EC77B7F
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 20:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjEPUoG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 16:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjEPUoF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 16:44:05 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBE4102
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 13:44:01 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-76c304efb8fso199839f.1
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 13:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684269840; x=1686861840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nrZEu6iwnQyn+KxP4uyp4iT7rrOB0VN2HrKcthZ1/Y=;
        b=s2Ohpg6AW0o8RSCY7t5zeAy8tqyWBAhE/6SpjICp7T0W2hYuEkIvlvouAXcEkZD4Pr
         XcFNqJeVxLhxNUJaxSyu4R920VVSqlt2trPErJ6ZIG+Ml2AunMjCHWGq2kNl7HPaxaLz
         Yin/hygb039AcHRs19Q13R0dWdlEIZh45UJsc5S9jISiaGYBHOydxwOYM+hHwyJXyJ31
         Nj6uJgn0X0fBXaHUVK1NHz4xNcgEehzW+3ROxXqPzRNorcMm/sOcOSgcWgZM3x0w/4wi
         1xRUZ0QL/2/wvVTVfI3onlUMZf8YU4f9ggRePmNOA/erQVhpsT6MgSfpH7enyB5C8AEG
         tYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684269840; x=1686861840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nrZEu6iwnQyn+KxP4uyp4iT7rrOB0VN2HrKcthZ1/Y=;
        b=OeiE29LH7t4xE/zxvuWKC2v0BKmJQgFMb5j4oAOZOEOHsjCf20R7QqqbtUBLo3sRIC
         jRDbmVAcPG99UxG23zl9LfnVZxq97Ia8VO+ioAMb4hXx/8MqR3/C1/o2azbtI5mNYzdB
         SFGjuo5tJ224maX+sYeAQiZvyibGIfnnSv7kGSW667MaK6ZHAct8luBe1m63XtfQJl3S
         K9P3niPswBBKGbiO5GspwXExu9I16LpLiqphiGw6emhCXRBtH7UqbUKfUZIv4Br6d2/s
         lnBHV5gqBciomgxiUGN+3hhDW70XZBkQgMbahxYNVotByI8Kfh64ictosxvS8dIgA+Ya
         V9WQ==
X-Gm-Message-State: AC+VfDwId4wTzk5+uh6HqaeVGBdTTr6maySIryoraRErLe4J3ZxgWX4i
        3d9LgO5ixsLz1QDI9q6PYH+fKg==
X-Google-Smtp-Source: ACHHUZ4GUpb4G771dEXdC/+NnEROUaamPBHRZCOrY+049roJi8yZbCnR+oGj6xIw79/vBYwBGW8B1A==
X-Received: by 2002:a05:6602:1547:b0:76c:87c7:a574 with SMTP id h7-20020a056602154700b0076c87c7a574mr312198iow.1.1684269840534;
        Tue, 16 May 2023 13:44:00 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id w9-20020a056638138900b0041698357280sm5659546jad.59.2023.05.16.13.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 13:43:59 -0700 (PDT)
Message-ID: <11a13228-85f9-ce97-379a-b161e8efb298@kernel.dk>
Date:   Tue, 16 May 2023 14:43:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] zram: allow user to set QUEUE_FLAG_NOWAIT
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20230512082958.6550-1-kch@nvidia.com>
 <20230512082958.6550-2-kch@nvidia.com> <ZF5NssjIVNUU9oIA@infradead.org>
 <8a661736-2c79-9330-1371-b6f539a9a695@kernel.dk>
 <b55b03ca-7967-faac-20c9-5c1ca6dc171b@nvidia.com>
 <2e6864ef-394d-f43e-9175-a4f3da65c755@nvidia.com>
 <20230516130850.GA298930@google.com>
 <706d4933-20f8-05b4-110c-30ba39b8a023@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <706d4933-20f8-05b4-110c-30ba39b8a023@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/16/23 2:41 PM, Chaitanya Kulkarni wrote:
> On 5/16/23 06:08, Sergey Senozhatsky wrote:
>> On (23/05/16 05:51), Chaitanya Kulkarni wrote:
>>> Removed modparam v2 is ready to send, but I've few  concerns enabling
>>> nowait unconditionally for zram :-
>>>
>>>   From brd data [1] and zram data [2] from my setup :-
>>>
>>>           IOPs  (old->new)    | sys cpu% (old->new)
>>> --------------------------------------------------
>>> brd  | 1.5x (3919 -> 5874) | 3x (29 -> 87)
>>> zram | 1.09x ( 29 ->   87) | 9x (11 -> 97)
>>>
>>> brd:-
>>> IOPs increased by               ~1.5  times (50% up)
>>> sys CPU percentage increased by ~3.0  times (200% up)
>>>
>>> zram:-
>>> IOPs increased by               ~1.09 times (  9% up)
>>> sys CPU percentage increased by ~8.81 times (781% up)
>>>
>>> This comparison clearly demonstrates that zram experiences a much more
>>> substantial CPU load relative to the increase in IOPs compared to brd.
>>> Such a significant difference might suggest a potential CPU regression
>>> in zram ?
>>>
>>> Especially for zram, if applications are not expecting this high cpu
>>> usage then they we'll get regression reports with default nowait
>>> approach. How about we avoid something like this with one of the
>>> following options ?
>> Well, zram performs decompression/compression on the CPU (per-CPU
>> crypto streams) for each IO operation, so zram IO is CPU intensive.
> 
> and that is exactly I've raised this issue, are you okay with that ?
> I'll send V2 with nowait enabled by default ..

Did you check that it's actually nowait sane to begin with? I spent
literally 30 seconds on that when you sent the first patch, and the
partial/sync path does not look kosher.

-- 
Jens Axboe


