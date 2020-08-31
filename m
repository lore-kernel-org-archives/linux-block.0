Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EA3C433E2
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 14:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265FD208A9
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 14:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pq+cgcMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgHaOSw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgHaOSv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 10:18:51 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5451C061573
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 07:18:50 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id y2so1197211ilp.7
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 07:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dcBn95hQJ2UoUYzqmHsBAJVvbvKhZDwu6OkJdsTclEA=;
        b=pq+cgcMZJwfi/6GGBoLJDe2lIxTZKkWf/n7icy5HuwrD68cwIKTMQ/yDuW01cHkbcV
         umOC+J0KsEp9tXQkiN1Pjy5Lx9FK9WYflXi4mMEZ/ZbCLgCn6fU9sa7XE0gd/qTb9X7I
         pSOfvoeMvMmZTZ8hvY+bW8gngNPRz+agO9ceZzG6/m8wSneflXf/il54Z9g3TJpu8TEq
         Gef47S2m+CgyzvjIbLqw0icqQquH/wCbrKsba0Iz9OGoCQJxfEIDhoZHtOZU9nhKTne1
         hxW6vAVPVgqAMO0aXJWDcMCypmbCafF6D0DgrxGU7lQ13knjzw053qR1faMQIab9xe0T
         flew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dcBn95hQJ2UoUYzqmHsBAJVvbvKhZDwu6OkJdsTclEA=;
        b=CkxqdnJvR+rU5g9p1YBJcdoJD7zmLiPfDB1xPC1gAVBfajhAstcuvPltJepz7gl8RT
         nPofWrddgCYCjuNnAXfg3wUQ7xOZcV4wdSHzLNdoIBkhoEBChK056BBPqYH+w37wapBZ
         E+XhtnPoiSGb24MRQi462fM8CxgiLYpQEioJXeh9Qj/i/s2Zj6ENTg5o8GfwPA7OFsTr
         Bg6cRG0vo8z1/7PY294z+VMK7MrnORu8wyWdFqEBxCzCZBE9KqA5yMwG4B0ks/N82A0z
         7bEPfzi0yqMH4XCewYeBlxwNPSqDnG9HfSQhoyQdbBMLaIPI6tUwbhOcKBUvf7ZKJko8
         b8MQ==
X-Gm-Message-State: AOAM531Zv1ols5tw4XgMY5D1ntv0kDltsSq/eLe2lmxfYq5OEEuGzcNK
        wA5dI5Yu8Sc0Q+F/3RO8/UDaw3QWRJiIwLba
X-Google-Smtp-Source: ABdhPJy+9iVpC4cW6r49EJQjpLrjQpsGTQ9ytqkGXqOsuI+TGsKDjTCzezK7EOdwoJT3FBOwlRpEBQ==
X-Received: by 2002:a92:498a:: with SMTP id k10mr1416300ilg.246.1598883529711;
        Mon, 31 Aug 2020 07:18:49 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z9sm4091521ioq.52.2020.08.31.07.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 07:18:49 -0700 (PDT)
Subject: Re: [PATCH] block: fix -EAGAIN IOPOLL task/vm accounting
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <d27ff6f0-9347-e880-fa9d-514e993014dc@kernel.dk>
 <20200830062624.GA8972@infradead.org>
 <9681be4b-298d-7fcd-ed72-9599e08a26a9@kernel.dk>
 <20200830152800.GA16467@infradead.org>
 <ebdb0929-782c-fb66-e3e9-86c077e3b710@kernel.dk>
 <20200831141237.GA13231@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <57807438-3ba0-e320-b6a5-0ad3f46d8335@kernel.dk>
Date:   Mon, 31 Aug 2020 08:18:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831141237.GA13231@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/31/20 8:12 AM, Christoph Hellwig wrote:
> On Mon, Aug 31, 2020 at 08:02:43AM -0600, Jens Axboe wrote:
>>>> The use case is async submissions, going through ->read_iter() again.
>>>> Or ->write_iter().
>>>
>>> But how does a bio flag help there?  If we go through the file ops
>>> again the next submission will be a new bio structure.
>>
>> Yeah the patch is garbage, can't work. The previous suggestion is here:
>>
>> https://lore.kernel.org/linux-block/395b4c19-cc80-eebb-f6ab-04687110c84a@kernel.dk/T/
>>
>> which isn't super pretty either, but at least it works. Not sure there's
>> a better solution, outside of marking the iocb as retry and then
>> carrying that flag forward for the bio as well. And that seems a bit
>> much for this case.
> 
> We'll still need a flag with the above to skip the submit_bio_noacct
> bios.  But I think it is the right way to go.  Eventually we'll also
> need to push the accounting down into the individual bio based drivers.

For the iocb propagation, we'd really need the caller to mark the iocb
as IOCB_ACCOUNTED (or whatever) if BIO_ACCOUNTED is set, since we can't
do that further down the stack as we really don't know if we hit -EAGAIN
before or after the bio was accounted... Which kind of sucks, as it'll
be hard to contain in a generic fashion.

-- 
Jens Axboe

