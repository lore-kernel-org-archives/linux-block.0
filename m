Return-Path: <SRS0=bHvQ=DU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DC2C433E7
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 19:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C92720BED
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 19:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ISBkvlYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgJMT3B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 15:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgJMT3B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 15:29:01 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3457AC0613D0
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 12:29:01 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u3so563774pjr.3
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wJkUIlK6yHS5spEVsLyHE0CYvuoA8ZWwU2FFYP4wVSo=;
        b=ISBkvlYXU9euHIKP7zQvzWUUphUkNW/b1pGsd3eOZhcyFtRun6ixdJaIWbYGynU0vY
         9lqLsQaAGz2vkE6mDcJlLq2NhrvpJESxQCLXHB8Yz4I4FMLrUW0Z+rgcCzHmdt+UIK3Q
         +eAfcSEM/r1203XndcUMpYPMo3b2SHfLQdvWLs8OYIX6BIfW+IyzAtvnFeSKLne5siB4
         aW8L/0E2HIBQ+6+/mYFZhxpVRsrLDlfLL+v8M7IOobCHwBLg5yEto3cQUUiIcVqmvHi9
         aJPUzz1VJa//TsLGxWr43sm9IDGYfGdJ75Z/1ldSXsZ4GpaTu8Iy6cCoJTF3L0Ij973V
         arlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wJkUIlK6yHS5spEVsLyHE0CYvuoA8ZWwU2FFYP4wVSo=;
        b=IlczqzkrrkYwx+9H6GtykcpkI/JMbbK9K0BmOVbLN+qFKqDEwKDI4EWqU05eXYrFWA
         9COGOu2ORTOMvIG8lhOUUnAPSkCv18galpJDaUtaCIkWxwe12gZIF551dC2sv1d0RbHJ
         S4cOzvr1S8h1jkL4b55FqOS/D5D4g5yZbMiHyBRUGCMeF7Ceyu8L/qsBPW0zhmSQ2LD9
         HDFo9Zol8DVKB236Oso1nvuxmdvhHk9bGWBUgXhGltNKIrhpBXl0u6ZVqYqMOEW4trVy
         hD3J0Se5R/FM6iYFVfthjIqYXIpDvVQkSZ+EF7W7K4sn86JndqWYcGbSw5wtwI0pZEm1
         6k+g==
X-Gm-Message-State: AOAM532OQgPIgeyb2+5o3PWvWPwZyix3W/HAZoZVRJ8+lScIQMF0Fi3d
        3kUM5R4xRC4Q75VxPNZ1NKi0yQNkF2+FyZGE
X-Google-Smtp-Source: ABdhPJzo3+l1V7XT73t7XohGERB+u0MdyzBSQXVgqjKbHL77sAV5wLA4mzPS0tND3qXK+yc+I52mRw==
X-Received: by 2002:a17:90b:388b:: with SMTP id mu11mr1240420pjb.204.1602617340710;
        Tue, 13 Oct 2020 12:29:00 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y5sm454302pgo.5.2020.10.13.12.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 12:29:00 -0700 (PDT)
Subject: Re: [PATCH] block: set NOWAIT for sync polling
To:     Ming Lei <ming.lei@redhat.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com,
        xiaoguang.wang@linux.alibaba.com
References: <20201013084051.27255-1-jefflexu@linux.alibaba.com>
 <20201013120913.GA614668@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9ab6bda9-2009-f8e8-5bff-5d26873bc6c9@kernel.dk>
Date:   Tue, 13 Oct 2020 13:28:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201013120913.GA614668@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/20 6:09 AM, Ming Lei wrote:
> On Tue, Oct 13, 2020 at 04:40:51PM +0800, Jeffle Xu wrote:
>> Sync polling also needs REQ_NOWAIT flag. One sync read/write may be
>> split into several bios (and thus several requests), and can used up the
>> queue depth sometimes. Thus the following bio in the same sync
>> read/write will wait for usable request if REQ_NOWAIT flag not set, in
>> which case the following sync polling will cause a deadlock.
>>
>> One case (maybe the only case) for above situation is preadv2/pwritev2
>> + direct + highpri. Two conditions need to be satisfied to trigger the
>> deadlock.
>>
>> 1. HIPRI IO in sync routine. Normal read(2)/pread(2)/readv(2)/preadv(2)
>> and corresponding write family syscalls don't support high-priority IO and
>> thus won't trigger polling routine. Only preadv2(2)/pwritev2(2) supports
>> high-priority IO by RWF_HIPRI flag of @flags parameter.
>>
>> 2. Polling support in sync routine. Currently both the blkdev and
>> iomap-based fs (ext4/xfs, etc) support polling in direct IO routine. The
>> general routine is described as follows.
>>
>> submit_bio
>>   wait for blk_mq_get_tag(), waiting for requests completion, which
>>   should be done by the following polling, thus causing a deadlock.
> 
> Another blocking point is rq_qos_throttle(), so I guess falling back to
> REQ_NOWAIT may not fix the issue completely.
> 
> Given iopoll isn't supposed to in case of big IO, another solution
> may be to disable iopoll when bio splitting is needed, something
> like the following change:

I kind of like that better, especially since polling for split bio's is
somewhat of a weird thing. Needs a better comment though, not just on
size, but also why multiple bio polling isn't really something that
works.

-- 
Jens Axboe

