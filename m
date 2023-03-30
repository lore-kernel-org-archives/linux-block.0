Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90454C7619A
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 23:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjC3XAw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 19:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjC3XAv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 19:00:51 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0767D33C
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 16:00:50 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso23593904pjb.0
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 16:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680217250; x=1682809250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YVIXTaCFfskAMnWBS8a4CAhSN1gf9fuFsdPAhIKsTLg=;
        b=BztmSnaQcH2Q82OsHozGlm3V1MeypFG5UipmZsgiIz31ufQkkGnK/zGGq1EvwRt/jr
         XCI2+4HgBIkylGyRtx17CmHvFbLy9WnEi2oRXLe/7zkDAEWm7TOqhVOUwtztUqsCNzm5
         5G8vvvC4IpWjRfZcLZ2g1qvPdF7w2noDHuvNgq32eFTUxaud2IKhquQZrVs3//If9IYj
         m/bjCsfw2p46zoinjzhB2Bg45BsZmaLjctqttX3TorPoW7O0fOuLdoO/CnRagpC9seoX
         PZz+kAdlee6VttAbHO9nQMGpHWeMa2MbRQQ7nROS8WVf1JeOHj2kBW91T+GTD6jhqCDX
         luQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680217250; x=1682809250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVIXTaCFfskAMnWBS8a4CAhSN1gf9fuFsdPAhIKsTLg=;
        b=v3CDCHn7uWvRJ9L7s2LDBBZ3TdQoqlb0ey10urP24yFAypFvBVrBKCba1mnkXkaJZ0
         gW5Lqov0AlSluv5PsKUHH1FpZUUayB/kB8XJXrlWe36RlH/q/AuU86737jLHSM5X6Q2H
         D/LxEaQdAmOiUXi/Qb/phZbCjZi+oFdg89yweLlrNNoJCIq6cux+iHl2r86Zwp4avarX
         5uD9nOWzT6RT8G8LTYpj6yRHi0jLhk5rW9cR+yfvUE0b5D3gCI+FZ17u6hCQAATkPziu
         GnhvuqjrNMffkLL/qaohWX5rlGyvGwFRqwZAkf4qJgnqSycfeVKLlereTEnpHpOTJqT3
         5AtQ==
X-Gm-Message-State: AAQBX9fmmi/E0sBIYffHWk92xIggYFldm8CaZHK3ZQFQWL5eAMZBM/GD
        Qc9+y/1EYS/P9mvMKsm9jnAgdQ==
X-Google-Smtp-Source: AKy350bz590baqQ+wgVaTq/Mnbnrve4q4R+4oWQwwmGtV6KXZv1zJusV3SKJ6wmM0f5Uw6hL0MVmLQ==
X-Received: by 2002:a17:902:c94c:b0:1a2:6092:2193 with SMTP id i12-20020a170902c94c00b001a260922193mr3996457pla.4.1680217250129;
        Thu, 30 Mar 2023 16:00:50 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a19-20020a1709027d9300b0019cb534a824sm224303plm.172.2023.03.30.16.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 16:00:49 -0700 (PDT)
Message-ID: <b14876d0-8ca1-4a7e-e228-aebc0d2b243c@kernel.dk>
Date:   Thu, 30 Mar 2023 17:00:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/4] null_blk: usr memcpy_[to|from]_page()
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "error27@gmail.com" <error27@gmail.com>
References: <20230329204652.52785-1-kch@nvidia.com>
 <8f759010-cd5e-3ace-9b6e-ea4f896ee789@kernel.dk>
 <02b39d4a-821b-0b86-5a64-7d4a706b79b8@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <02b39d4a-821b-0b86-5a64-7d4a706b79b8@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/23 12:56?PM, Chaitanya Kulkarni wrote:
> On 3/29/23 15:48, Jens Axboe wrote:
>> On 3/29/23 2:46?PM, Chaitanya Kulkarni wrote:
>>> Hi,
>>>
>>>  From :include/linux/highmem.h:
>>> "kmap_atomic - Atomically map a page for temporary usage - Deprecated!"
>>>
>>> Use memcpy_from_page() since does the same job of mapping, copying, and
>>> unmaping except it uses non deprecated kmap_local_page() and
>>> kunmap_local(). Following are the differences between kmal_local_page()
>>> and kmap_atomic() :-
>> Looks fine to me, but I'd fold patches 1-3 rather than split them up.
>>
> 
> Sent V2 with above comment, first three patches are from
> different code path and they are doing unrelated changes:-
> 
> 1. WRITE :- copy_to_nullb() only use memcpy_page().
> 2. READ :- copy_from_nullb() only use memcapy_page() and zero_user().
> 3. I guess zoned read beyond write pointer null_fill_pattern()
>     memset_page().
> 
> if anything goes wrong in any of 3 code paths we will have to
> entire change which we shouldn't, that's why kept it separate,
> I'm fine with whatever you decide ...

It doesn't matter... It's not like this is a hugely complicated thing.
It's just a straight forward conversion. They all just switch to using a
helper, which is the right thing to do as it reduces the stuff we have
to do in there. Only reason why I excluded patch 4 is that it is a bit
different than the others. But it really could just be one patch.

-- 
Jens Axboe

