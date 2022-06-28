Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3253DC433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 18:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiF1SN0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 14:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbiF1SNL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 14:13:11 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31521705C
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 11:13:09 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id go6so13405999pjb.0
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eRV2mthXWzua5Vvg+is/lVt+ATZoNwT5SgUu9s9+sz4=;
        b=jM4Q1hFPyhUGI1Wiu6bJXNxKmPFroVgrBvoy7oghEA/UDxiO61jjxm7H1UekW3tdPZ
         c/FPebmUH5UxVqzMDmy0q8nsq7gwQH+Bt9En6LQCC/k9VqegibVNfebcjUETZhKMRu9J
         ryp//hc94QAu/dTjMFS2dv0+8oluMY7WzZtgQFhYVgFv5w/WyNeL/8dnADFb3ZbtNy6x
         bQzHngxO8P7sCynBl2KgXdQVG0amugNOfAvcQZ7j1Zo07gDrfBPiQQe/EDX4SYJaruj0
         lX4RiWvAFsdJkS6jzaGQIoa+AuoHlEZwCe9JdhxfnlhM4Q5oEjmJvakuB1NSCimXOh/r
         X3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eRV2mthXWzua5Vvg+is/lVt+ATZoNwT5SgUu9s9+sz4=;
        b=Xu5iZEFGwelZU1ZMIICDosHzwihBOrc3jporgJgcNcv6XAg65Qo6bb3UQV+u0pM9Ga
         f1tQrVK5PNUvKB2KyZTXZ4sYqdqtPnFAeJ+86HSmxByFldcCEGE77YOCQmhhdfL99/JS
         0fC26Pe/6AP1MBd53W5bCqj1jEylfOI2QZTP7el4to59dgWH/16v9s9wAD3k+GY7A/6V
         CwCMOBOZDlvXaJ4TZivthjvV74uWT/Oc0LOP/L0u+bmvLqsc2JacKoEH6t0OrUxstduh
         /zilQgKQ/BiWboGnem6SQKmlrmMZHV+MhKybx705CU+vFrYo7aP4yOjI/Nx7ne2C739E
         V/pA==
X-Gm-Message-State: AJIora9TZokaUofiQLqnnUxVdgrhW8Xb7fSVWezt0q3ly1ipAA32RKZ2
        rxGMGGD2/WtanZNMWKgCgZtxZQ==
X-Google-Smtp-Source: AGRyM1uMZ7NdVAghHFmlAGmUdbYwRNP14auAsN1XpcUfbuFSizOFZf0OcSnGAdprQG95gZ6W2OMkqQ==
X-Received: by 2002:a17:902:ce83:b0:16a:4a3e:4f8b with SMTP id f3-20020a170902ce8300b0016a4a3e4f8bmr6382849plg.41.1656439989081;
        Tue, 28 Jun 2022 11:13:09 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e1::165b? ([2620:10d:c090:400::5:f46f])
        by smtp.gmail.com with ESMTPSA id v2-20020a056a00148200b00525343b5047sm9717910pfu.76.2022.06.28.11.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 11:13:08 -0700 (PDT)
Message-ID: <3ad782c3-4425-9ae6-e61b-9f62f76ce9f4@kernel.dk>
Date:   Tue, 28 Jun 2022 12:13:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
 <20220624141255.2461148-2-ming.lei@redhat.com>
 <20220626201458.ytn4mrix2pobm2mb@moria.home.lan> <Yrld9rLPY6L3MhlZ@T590>
 <20220628042016.wd65amvhbjuduqou@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220628042016.wd65amvhbjuduqou@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/27/22 10:20 PM, Kent Overstreet wrote:
> On Mon, Jun 27, 2022 at 03:36:22PM +0800, Ming Lei wrote:
>> On Sun, Jun 26, 2022 at 04:14:58PM -0400, Kent Overstreet wrote:
>>> On Fri, Jun 24, 2022 at 10:12:52PM +0800, Ming Lei wrote:
>>>> Commit 7759eb23fd98 ("block: remove bio_rewind_iter()") removes
>>>> the similar API because the following reasons:
>>>>
>>>>     ```
>>>>     It is pointed that bio_rewind_iter() is one very bad API[1]:
>>>>
>>>>     1) bio size may not be restored after rewinding
>>>>
>>>>     2) it causes some bogus change, such as 5151842b9d8732 (block: reset
>>>>     bi_iter.bi_done after splitting bio)
>>>>
>>>>     3) rewinding really makes things complicated wrt. bio splitting
>>>>
>>>>     4) unnecessary updating of .bi_done in fast path
>>>>
>>>>     [1] https://marc.info/?t=153549924200005&r=1&w=2
>>>>
>>>>     So this patch takes Kent's suggestion to restore one bio into its original
>>>>     state via saving bio iterator(struct bvec_iter) in bio_integrity_prep(),
>>>>     given now bio_rewind_iter() is only used by bio integrity code.
>>>>     ```
>>>>
>>>> However, it isn't easy to restore bio by saving 32 bytes bio->bi_iter, and saving
>>>> it only can't restore crypto and integrity info.
>>>>
>>>> Add bio_rewind() back for some use cases which may not be same with
>>>> previous generic case:
>>>>
>>>> 1) most of bio has fixed end sector since bio split is done from front of the bio,
>>>> if driver just records how many sectors between current bio's start sector and
>>>> the bio's end sector, the original position can be restored
>>>>
>>>> 2) if one bio's end sector won't change, usually bio_trim() isn't called, user can
>>>> restore original position by storing sectors from current ->bi_iter.bi_sector to
>>>> bio's end sector; together by saving bio size, 8 bytes can restore to
>>>> original bio.
>>>>
>>>> 3) dm's requeue use case: when BLK_STS_DM_REQUEUE happens, dm core needs to
>>>> restore to the original bio which represents current dm io to be requeued.
>>>> By storing sectors to the bio's end sector and dm io's size,
>>>> bio_rewind() can restore such original bio, then dm core code needn't to
>>>> allocate one bio beforehand just for handling BLK_STS_DM_REQUEUE which
>>>> is actually one unusual event.
>>>>
>>>> 4) Not like original rewind API, this one needn't to add .bi_done, and no any
>>>> effect on fast path
>>>
>>> It seems like perhaps the real issue here is that we need a real bio_iter,
>>> separate from bvec_iter, that also encapsulates iterating over integrity &
>>> fscrypt. 
>>
>> Not mention bio_iter, bvec_iter has been 32 bytes, which is too big to
>> hold in per-io data structure. With this patch, 8bytes is enough
>> to rewind one bio if the end sector is fixed.
> 
> Hold on though, does that check out? Why is that too big for per IO data
> structures?
> 
> By definition these structures are only for IOs in flight, and we don't _want_
> there to ever be very many of these or we're going to run into latency issues
> due to queue depth.

It's much less about using whatever amount of memory for inflight IO,
and much more about not bloating fast path structures (of which the bio
is certainly one). All of this gunk has to be initialized for each IO,
and that's the real issue.

Just look at the recent work for iov_iter and why ITER_UBUF makes sense
to do.

This is not a commentary on this patchset, just a general observation.
Sizes of hot data structures DO matter, and quite a bit so.

-- 
Jens Axboe

