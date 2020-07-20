Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E66C433DF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 21:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91CEC207FC
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 21:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="l8FDkzqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgGTVfr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgGTVfq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 17:35:46 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AAEC061794
        for <linux-block@vger.kernel.org>; Mon, 20 Jul 2020 14:35:46 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id a11so14661205ilk.0
        for <linux-block@vger.kernel.org>; Mon, 20 Jul 2020 14:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y4WvrFF4oT60WCYFzoEKcEPOboTCnMH1fSK6qyG/Ly4=;
        b=l8FDkzqvqY6XDitCTANqZJqam+Me0W3VxU8H50jZXASL9c9dKhuySoSJVmWOsnL1Sm
         GlzJtEkdqGAwZRlgavRwLugcX7++0gOi2/uOOHfnW3IAIKSNscSZYuD34vb8MjPxNlFW
         ADt9xoQxuGfdLIHSJmMbwBiE/u2DZlN1DwqXOtTHrVvn0mrOrALURftJuLNIaF+zKAGY
         ej4uDgU49kC0Oc72dRGmmtjeu92URIATJJn3Pu1UOAOcHZjJ35/yfjkkR1yXoZN1PbSd
         tSliN/a50XAwAX3U92GiJ2PJUMSvkDDvx7o1P10d5l/qPsV2nlFlY4osP0kqbpSRje5A
         sfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y4WvrFF4oT60WCYFzoEKcEPOboTCnMH1fSK6qyG/Ly4=;
        b=nGGQxAkcT41+3SHZK5j2v6/bv7JywkR14F4Uqvx91pMja0OQ1pL3aDd6HlM7+ctgTf
         8LEK2PA1eRyCCzAYm6ZqbnN+D3o2J+2NFnIrhC8+0lsUGu3hOtq0/NNSjbymf9OAk8SB
         rTDhC+ndyVhKDDo0clD6LLyqm2e0WIe1jr+lJAPWP/Z83OVmfL/dzoapLCYuGvCvTni/
         e7pyF61w+xxHNqkpSP10oRfWfxTtoFsmL3LaotG75/qlDCGXaBkzA1wn9hzHbDCZZSKh
         SuE/72wUkdsjmKOOks1encIknofDGCPqPKzyyOAKmwE82onQcjuoMA2OIodtDYjnz+cD
         5d4w==
X-Gm-Message-State: AOAM533qImUCrOrm8RthnguehN7e55FicVy2t8foL613/eDdjovo5mSj
        W7M+wkdkFx18KgeTNL+SLo7CgQ==
X-Google-Smtp-Source: ABdhPJzfbtVS2ywymY14m6Uc8uJPxy+acgbORpzyzeKQBWPDwVaDILjxcWyHjBgsOE25AY9kZzSQtA==
X-Received: by 2002:a05:6e02:4ca:: with SMTP id f10mr25177577ils.291.1595280945704;
        Mon, 20 Jul 2020 14:35:45 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c77sm9628425ill.13.2020.07.20.14.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 14:35:45 -0700 (PDT)
Subject: Re: a fix and two cleanups around blk_stack_limits
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien.LeMoal@wdc.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com
References: <20200720061251.652457-1-hch@lst.de>
 <dfe56cf2-db3d-3461-9834-be314f4080ef@kernel.dk>
 <20200720173530.GA21442@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ab942c19-68c3-2a76-b3b2-136a2bf3ca54@kernel.dk>
Date:   Mon, 20 Jul 2020 15:35:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720173530.GA21442@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/20/20 11:35 AM, Christoph Hellwig wrote:
> On Mon, Jul 20, 2020 at 10:56:23AM -0600, Jens Axboe wrote:
>> On 7/20/20 12:12 AM, Christoph Hellwig wrote:
>>> Hi Jens,
>>>
>>> this series ensures that the zoned device limitations are properly
>>> inherited in blk_stack_limits, and then cleanups up two rather
>>> pointless wrappers around it.
>>
>> We should probably make this against for-5.9/drivers instead, to avoid
>> an unnecessary conflict when merging.
> 
> Then we'd also need a merge as my next series depends on this, and it
> clearly is core material.  Not sure which one is more important.

Hmm, might make more sense to kick off a branch topic for this and just
merge it after the other ones.

-- 
Jens Axboe

