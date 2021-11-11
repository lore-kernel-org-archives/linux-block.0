Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748F3C433EF
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 00:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C85D61251
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 00:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhKKA33 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Nov 2021 19:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbhKKA3Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Nov 2021 19:29:25 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D5EC06127A
        for <linux-block@vger.kernel.org>; Wed, 10 Nov 2021 16:26:36 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id x10so4915158ioj.9
        for <linux-block@vger.kernel.org>; Wed, 10 Nov 2021 16:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NyY8bek2WvSGjibqw1QUPQDNaQc/2Apt9v2sF1q2Sv4=;
        b=jl8dCUt7BkCW8ACewdF5osqNI3RRnyRBlDQP+bydLnpGYyQGl6gpUQLfxoxQoh5i6V
         MZBsAXng179VNrfxCM39UGTAJvAJ4/yuK9LxptVUGrVjXh3EuNxWp9CPHDp5/qxXAbUK
         AudU9T1bq4PRSE2Xwcu3+vNRsTRrmfqH8pR7ojn4yKH28l7o9Ysq8/kenSprv+E4r+tD
         hQUx6HWhvEGAk2z+k4uH1bSjsGBesfOspT7wG/rmpTeAvbpPyEVeGUSveLIw56fx3Ifo
         saZYwZiQsc5w+jWXEoA7zR3Kg8fblBc4BMesHGNlJs+5LBQVWbMdqOH4gO1jHXW8FIoB
         t+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NyY8bek2WvSGjibqw1QUPQDNaQc/2Apt9v2sF1q2Sv4=;
        b=X2/hRU4FX8rc0+kZS4bOaGFrBP/tvXVPa+07/4BjFBHAgFQAtvQ7RJT6ERsMHn+tjB
         9E+YRUMMkuqi6I8HXfkKmkCm4BLS0+DkK7Z9/3ZXfTR/VW7rmwcpug7F6qV4Uxrta3BT
         LcZrFAsnSAs9MNaayzEXreBqe0Z9TvHIL7ql4Qv10JNMpILyC11afZzbUhqRQczCmQfi
         9fHz1Gm3/JM8oP0dPMWlzS4v5ffQmy5gmD43+L0Vg4uf4ji0W6Ap32PO4b/KsoxsGRRe
         1TDCT9v19exCpKZXw+6ovrL0+R9WmHhMhY0V+XJeL1LyDHeQ5pxWkdRjgS6HkeSd2a6k
         B4GQ==
X-Gm-Message-State: AOAM5321r23gTp1YrvpxRjLRBBRnWxYvSNUk3qM21XB8gW7OmuaurtBK
        NyraXXVa2AaPWN33+6VIFfKgUw==
X-Google-Smtp-Source: ABdhPJxopWi9rf1i9qBVVWTcqIkAhArpHV5fNVB3eoBbngZouc4tphuIfKJZ6Q5OY/IaBbXy3Iy8rw==
X-Received: by 2002:a5d:8903:: with SMTP id b3mr2207722ion.44.1636590396221;
        Wed, 10 Nov 2021 16:26:36 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id s15sm1139630ilu.16.2021.11.10.16.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 16:26:35 -0800 (PST)
Subject: Re: [PATCH] f2fs: provide a way to attach HIPRI for Direct IO
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20211109021336.3796538-1-jaegeuk@kernel.org>
 <YYqkWWZZsMW49/xu@infradead.org>
 <042997ce-8382-40fe-4840-25f40a84c4bf@kernel.dk>
 <YYwYxv4s1ZzBZRtC@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a309f240-e99c-5049-fc67-007a50eb56b3@kernel.dk>
Date:   Wed, 10 Nov 2021 17:26:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YYwYxv4s1ZzBZRtC@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/10/21 12:08 PM, Jaegeuk Kim wrote:
> On 11/09, Jens Axboe wrote:
>> On 11/9/21 9:39 AM, Christoph Hellwig wrote:
>>> On Mon, Nov 08, 2021 at 06:13:36PM -0800, Jaegeuk Kim wrote:
>>>> This patch adds a way to attach HIPRI by expanding the existing sysfs's
>>>> data_io_flag. User can measure IO performance by enabling it.
>>>
>>> NAK.  This flag should only be used when explicitly specified by
>>> the submitter of the I/O.
>>
>> Yes, this cannot be set in the middle for a multitude of reasons. I wonder
>> if we should add a comment to that effect near the definition of it.
> 
> Not surprising. I was wondering we can add this for testing purpose only.
> Btw, is there a reasonable way that filesystem can use IO polling?

Whether an IO is polled or not belongs to the issuer of the IO, as it
comes with certain obligations like "I will actively poll for the
completion of this request", and it incurs certain restrictions in the
block layer in terms of whether or not you can ever sleep for requests.

You could certainly use in in an fs, but only IFF you are the original
issuer of the request, which then also means that you are the one that
needs to poll for completion of it.

It's not a drive-by "let's set this flag to speed things up" kind of
flag, there are a lot more moving parts than that.

I don't think it will be useful for you.

-- 
Jens Axboe

