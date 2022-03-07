Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9107EC433F5
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 02:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbiCGC0I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Mar 2022 21:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbiCGC0H (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Mar 2022 21:26:07 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374E85DE75
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 18:25:14 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id cx5so11997866pjb.1
        for <linux-block@vger.kernel.org>; Sun, 06 Mar 2022 18:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hmPhMTI7t3TVVpPhw5nNW52OuQD8LGJ91mhG7z/hh1o=;
        b=iR73YohWSGNZhYUvffMwREF+qAplYYZGbqy+iVE06V0qnhVOJgglmnYIROzZw6+aCw
         DTRRs2Ubf7xq3ofoQNjGWfeUxhg2/0xONYt0Kt5Hfqf0iEvg5vVtPHSiVNSRpVLrJeW1
         CwVeb/B2/pi/mIyt3kuBTpFogHdsifBkwU6zmCbX7dxIsF2uyNLrOnn7NCoo/NCAGrP1
         TLnTVFWZCBZ12SGjdXv4qjtqb8jAH5A6i9r/xbVy5wg45A92/YQd2HZ19fGFXBqEaTkF
         HJ4q451DQ6fd11WxoghAPiSc/Yax+q+mBsIQ41UazxcHiTyYBHYU12xTLIO0zqNPdnrS
         cutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hmPhMTI7t3TVVpPhw5nNW52OuQD8LGJ91mhG7z/hh1o=;
        b=MAFZsgV/FX/6FSujeC/ab1IqYp0wlnkMtFqmxG8pMv/89iCu7VZqfz/tqhGKR2Q2dL
         daxRgMjZsKX/IHqack3nd4PUG4n8VVQV0xCdXKQZHd/exi6poUr/RGdcsL29TRKhYAC3
         HCY0A2H4qHyNSIGJVPaJJIrkPo8ibzSnG+VOrmjszjiAFVtm73gLE3AYjW3vltra8yf9
         JAlePqxAyDOcvc6YtlTFKH4T34La7Hi+lgT3M+tONNs6QxXqY5kUi4NpyILbm7RC+z5w
         MwEbfnkFU2m/qxx6FHrwMPETsDvJif0degGYxjZqd1vk+rtorK5QnQJZjCG14XJsuACx
         gdLA==
X-Gm-Message-State: AOAM532rZuSeVGa1VINZBZRtLKMT6e75pmq+ht/RyL9vvT65N+Fkdeef
        1UBlNsT4BXXRS7iXqAqpjCARnTuIMy/xe+Ol
X-Google-Smtp-Source: ABdhPJygOhhaNp5HmmASiVr9p7LuiTuRC0JsENfLW4mS+UdTHuYZwnoYl5YbttBI/tzkKOCfCvb1yA==
X-Received: by 2002:a17:902:b589:b0:14f:3f88:15e2 with SMTP id a9-20020a170902b58900b0014f3f8815e2mr9958915pls.171.1646619913733;
        Sun, 06 Mar 2022 18:25:13 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d11-20020a056a00198b00b004dfc6b023b2sm13100022pfl.41.2022.03.06.18.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 18:25:13 -0800 (PST)
Message-ID: <89612542-0040-65bd-23bc-5bf8cac71f61@kernel.dk>
Date:   Sun, 6 Mar 2022 19:25:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 2/2] dm: support bio polling
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
References: <20220305020804.54010-1-snitzer@redhat.com>
 <20220305020804.54010-3-snitzer@redhat.com> <20220306092937.GC22883@lst.de>
 <2ced53d5-d87b-95db-a612-6896f73ce895@kernel.dk> <YiVr4rna9DG0Oyng@T590>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YiVr4rna9DG0Oyng@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/6/22 7:20 PM, Ming Lei wrote:
> On Sun, Mar 06, 2022 at 06:48:15PM -0700, Jens Axboe wrote:
>> On 3/6/22 2:29 AM, Christoph Hellwig wrote:
>>>> +/*
>>>> + * Reuse ->bi_end_io as hlist head for storing all dm_io instances
>>>> + * associated with this bio, and this bio's bi_end_io has to be
>>>> + * stored in one of 'dm_io' instance first.
>>>> + */
>>>> +static inline struct hlist_head *dm_get_bio_hlist_head(struct bio *bio)
>>>> +{
>>>> +	WARN_ON_ONCE(!(bio->bi_opf & REQ_DM_POLL_LIST));
>>>> +
>>>> +	return (struct hlist_head *)&bio->bi_end_io;
>>>> +}
>>>
>>> So this reuse is what I really hated.  I still think we should be able
>>> to find space in the bio by creatively shifting fields around to just
>>> add the hlist there directly, which would remove the need for this
>>> override and more importantly the quite cumbersome saving and restoring
>>> of the end_io handler.
>>
>> If it's possible, then that would be preferable. But I don't think
>> that's going to be easy to do...
> 
> I agree, now basically there isn't gap inside bio, so either adding one
> new field or reusing one existed field...

There'd no amount of re-arranging that'll free up 8 bytes, that's just
not happening. I'm not a huge fan of growing struct bio for that, and
the oddity here is mostly (to me) that ->bi_end_io is the one overlayed.
That would usually belong to the owner of the bio.

Maybe some commenting would help? Is bi_next available at this point?

-- 
Jens Axboe

