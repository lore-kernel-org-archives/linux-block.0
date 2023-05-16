Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520C6C77B7A
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 22:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjEPWDT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 18:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjEPWDS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 18:03:18 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7385AB4
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:03:16 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-76c6ba5fafaso562339f.1
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684274596; x=1686866596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ANNseLyiYgTBjLSmRxW4DXuFWu+xeGqn9797EHfPRg=;
        b=bFPtBcxh0ESKJmHJGUWOpH4wgBtHdzagoDYV5XFFEfcEjmoTFsLpnXjk0r8IP0WZeY
         3RGB8mJv15mY3emOU1i5SS/2h1BPYoLZM7Fvk5682ZZaj5gwGUPHNWpSpaVTlgx5E0El
         pQZ5X7IXkV4rT1bdYE3gMVe6RU70IXkMzVtR7CGmRwNqacuT8hEjEO5jjT8jeLh+2aeP
         bM00Dmx8FKW9h4X7ZQADruJClkTuY246jA+FUK8bSd0zar7y4PcqHw29mpYt+gn4SVnb
         1QUP0+EBLTz9Fkx/UP/hi2Rv5wJ+LAZ2IVB058dMQzBQwLZ3eJFMxhyHCEBjbcwTJEN8
         iHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684274596; x=1686866596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ANNseLyiYgTBjLSmRxW4DXuFWu+xeGqn9797EHfPRg=;
        b=VsQrWH3VRxSDrSecWgx9vzGsjwKowHJt3jyQcto2LAdDt1iWbn6Gdi4KizXJwyjey2
         aljKzKQcHRi25XZJrlUneBFcOHrEgBRK03cftM6f5lNkcfw0Tbokq9ZA/4trP/iiN66i
         5+R0ldTpVMOz1UMVAw307kio53o/DcuInZKb0TDNSTy6dC5QQnZE7MBsWxzlDnI5CJED
         Xfs0B5KGrfDeXy14AkzyKwridvNO6u9SI9YOJolA8id+jW5qFQ221RqRuBrnOyl91YhF
         MsbGzGojevW3CaxH8xLdN8KW5S91H3vdk78ABaALaM5fy1d9IybNf5iPntKd/AfxOOpf
         GeIA==
X-Gm-Message-State: AC+VfDx+jXpzsl1Uzkmmdn8HEjqjokk5kVFOzjBMcn/XUgPHdIFLmBOT
        2x0Jqfox9x7tkq0TVpTZppPVqw==
X-Google-Smtp-Source: ACHHUZ7hrvrgp5L6eNaBFpEBDITtqDqgMHs5p/cL/SO+nFVwb2c7OW45N7SFxmccF4mPUdEJTDdyaQ==
X-Received: by 2002:a6b:144f:0:b0:770:4bd:34b9 with SMTP id 76-20020a6b144f000000b0077004bd34b9mr344859iou.2.1684274595799;
        Tue, 16 May 2023 15:03:15 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b1-20020a5ea701000000b0076c6ba49a3dsm4802429iod.48.2023.05.16.15.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 15:03:15 -0700 (PDT)
Message-ID: <2ea2dcb1-0850-f3a1-dab6-61917472d7a0@kernel.dk>
Date:   Tue, 16 May 2023 16:03:14 -0600
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
 <11a13228-85f9-ce97-379a-b161e8efb298@kernel.dk>
 <3f46e368-710e-47e1-bbd7-bbea6d043666@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3f46e368-710e-47e1-bbd7-bbea6d043666@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/16/23 3:32?PM, Chaitanya Kulkarni wrote:
> On 5/16/23 13:43, Jens Axboe wrote:
>> On 5/16/23 2:41?PM, Chaitanya Kulkarni wrote:
>>> On 5/16/23 06:08, Sergey Senozhatsky wrote:
>>>> On (23/05/16 05:51), Chaitanya Kulkarni wrote:
>>>>> Removed modparam v2 is ready to send, but I've few  concerns enabling
>>>>> nowait unconditionally for zram :-
>>>>>
>>>>>    From brd data [1] and zram data [2] from my setup :-
>>>>>
>>>>>            IOPs  (old->new)    | sys cpu% (old->new)
>>>>> --------------------------------------------------
>>>>> brd  | 1.5x (3919 -> 5874) | 3x (29 -> 87)
>>>>> zram | 1.09x ( 29 ->   87) | 9x (11 -> 97)
>>>>>
>>>>> brd:-
>>>>> IOPs increased by               ~1.5  times (50% up)
>>>>> sys CPU percentage increased by ~3.0  times (200% up)
>>>>>
>>>>> zram:-
>>>>> IOPs increased by               ~1.09 times (  9% up)
>>>>> sys CPU percentage increased by ~8.81 times (781% up)
>>>>>
>>>>> This comparison clearly demonstrates that zram experiences a much more
>>>>> substantial CPU load relative to the increase in IOPs compared to brd.
>>>>> Such a significant difference might suggest a potential CPU regression
>>>>> in zram ?
>>>>>
>>>>> Especially for zram, if applications are not expecting this high cpu
>>>>> usage then they we'll get regression reports with default nowait
>>>>> approach. How about we avoid something like this with one of the
>>>>> following options ?
>>>> Well, zram performs decompression/compression on the CPU (per-CPU
>>>> crypto streams) for each IO operation, so zram IO is CPU intensive.
>>> and that is exactly I've raised this issue, are you okay with that ?
>>> I'll send V2 with nowait enabled by default ..
>> Did you check that it's actually nowait sane to begin with? I spent
>> literally 30 seconds on that when you sent the first patch, and the
>> partial/sync path does not look kosher.
>>
> 
> I did check for it and it needs a nowait sane preparation in V2 with
> something like this [1] plus returning error with bio_wouldblock_error()

That looks pretty awful... Things like:

> @@ -779,8 +780,9 @@ static void zram_sync_read(struct work_struct *work)
>       struct zram_work *zw = container_of(work, struct zram_work, work);
>       struct bio_vec bv;
>       struct bio bio;
> +    blk_opf_t_nowait = zw->nowait ? REQ_NOWAIT : 0;
> 
> -    bio_init(&bio, zw->zram->bdev, &bv, 1, REQ_OP_READ);
> +    bio_init(&bio, zw->zram->bdev, &bv, 1, REQ_OP_READ | nowait);
>       bio.bi_iter.bi_sector = zw->entry * (PAGE_SIZE >> 9);
>       __bio_add_page(&bio, zw->page, PAGE_SIZE, 0);
>       zw->error = submit_bio_wait(&bio);
>

make absolutely no sense, setting REQ_NOWAIT and then waiting on IO
completion.

> when we end up in read_from_bdev_sync() when it is not called from
> writeback_store(). (rough changes [1])

writeback_store() will never have nowait set. Outside of that, pushing
the nowait handling to the workqueue makes no sense, that flag only
applies for inline issue.

> But after taking performance numbers repeatedly, the main concern I
> failed to resolve is above numbers & default enabling nowait for
> zram ...

It's a choice you make if you do nowait IO, normal block IO would not
change at all. So I think it's fine, but the driver needs to be in a
sane state to support nowait to begin with.

-- 
Jens Axboe

