Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A50C433E6
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 14:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09E5B20936
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 14:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pOOCJo0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgHaOCq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgHaOCp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 10:02:45 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BF1C061573
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 07:02:45 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q14so1139940ilm.2
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 07:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jc/6JYBlPQhSxVwnMfTjcltvbxJ9rUsX0ZJT2cP9F0Q=;
        b=pOOCJo0LG/Q5Gb7gq0oQ0SF8FOF7/upXZkMY1n19UyqjcabJlGLZKZu8ogldqCyVjg
         s6pUhhbNuS+M0TkS0GYKWoiF06H0Ygppo18brt6zHnZbxvGXSGDP8PPo+6U7s7powl4M
         e8f/0b3gMGDDyAEUfDCp9fVAx6XHI0uVygD9P4iQnvAB2FtCMAWDK87rwE8RiLnXBJrz
         9A+/NqZjHuS4JmQbfl32P+Cecn0nvxAJjqNVd1nVzeXjP26xxgBo2ABLjajOqrnm8ghr
         sisgCE2OpOl4h5YP8+BJ0NrhQgyiS4mOAE6teUIAxZDBSLRnABQZ+lwbordA2Mg8vzOB
         OXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jc/6JYBlPQhSxVwnMfTjcltvbxJ9rUsX0ZJT2cP9F0Q=;
        b=YCd3gmCgX1xwb2s1iXE8+LnoBFbTNpxr1WH5bxiHT/UCl/IU8MvIn32Z4P32ly4gmY
         nyx6sS1htbnh7JdfLuSZu7r+TAirQZyTxd62vbdxZika2G8fyjUX0lVC1Fo78eMwoNDZ
         JclvES/y3P8KMnqc8oKUzvtOk9TSXqOk13QgjIURxaJjb5fiHoiFQHDYH9zVOqVVmW6M
         yikX5asavj38HrAdE0eRHX5IssayRv2abEUL4/NsaV+CcrKvNcX7IzRsfUkBVpViOXSs
         j1JWqEGNfQ0Q4x9unFp4aERJpCEY5794bP2OVYMEoUA2nAz3d2mPX1ASMKRIIZX/aznD
         YiLQ==
X-Gm-Message-State: AOAM532RovkU29bESzHQZl4MEf8PyqLx5enUoX47mzvDHszYjPbN9lQj
        icw7MrYfhYVP290Ttdy+CLwenDcbMw5IbFhh
X-Google-Smtp-Source: ABdhPJyR+MPZ3yWZkgCbbB/AUyLAN0wHyyzOFmvJ+5KdGz3lnaGiI3zOWCDBpq0lHArQNBOfqei5zw==
X-Received: by 2002:a92:6a03:: with SMTP id f3mr1396265ilc.217.1598882564654;
        Mon, 31 Aug 2020 07:02:44 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r2sm4544306ila.22.2020.08.31.07.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 07:02:44 -0700 (PDT)
Subject: Re: [PATCH] block: fix -EAGAIN IOPOLL task/vm accounting
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <d27ff6f0-9347-e880-fa9d-514e993014dc@kernel.dk>
 <20200830062624.GA8972@infradead.org>
 <9681be4b-298d-7fcd-ed72-9599e08a26a9@kernel.dk>
 <20200830152800.GA16467@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ebdb0929-782c-fb66-e3e9-86c077e3b710@kernel.dk>
Date:   Mon, 31 Aug 2020 08:02:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200830152800.GA16467@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/30/20 9:28 AM, Christoph Hellwig wrote:
> On Sun, Aug 30, 2020 at 09:09:02AM -0600, Jens Axboe wrote:
>> On 8/30/20 12:26 AM, Christoph Hellwig wrote:
>>> On Sat, Aug 29, 2020 at 10:51:11AM -0600, Jens Axboe wrote:
>>>> We currently increment the task/vm counts when we first attempt to queue a
>>>> bio. But this isn't necessarily correct - if the request allocation fails
>>>> with -EAGAIN, for example, and the caller retries, then we'll over-account
>>>> by as many retries as are done.
>>>>
>>>> This can happen for polled IO, where we cannot wait for requests. Hence
>>>> retries can get aggressive, if we're running out of requests. If this
>>>> happens, then watching the IO rates in vmstat are incorrect as they count
>>>> every issue attempt as successful and hence the stats are inflated by
>>>> quite a lot potentially.
>>>>
>>>> Add a bio flag to know if we've done accounting or not. This prevents
>>>> the same bio from being accounted potentially many times, when retried.
>>>
>>> Can't the resubmitter just use submit_bio_noacct?  What is the call
>>> stack here?
>>
>> The resubmitter is way higher than that. You could potentially have that
>> done in the block layer, but not higher up.
>>
>> The use case is async submissions, going through ->read_iter() again.
>> Or ->write_iter().
> 
> But how does a bio flag help there?  If we go through the file ops
> again the next submission will be a new bio structure.

Yeah the patch is garbage, can't work. The previous suggestion is here:

https://lore.kernel.org/linux-block/395b4c19-cc80-eebb-f6ab-04687110c84a@kernel.dk/T/

which isn't super pretty either, but at least it works. Not sure there's
a better solution, outside of marking the iocb as retry and then
carrying that flag forward for the bio as well. And that seems a bit
much for this case.

-- 
Jens Axboe

