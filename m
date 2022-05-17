Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A91C433F5
	for <linux-block@archiver.kernel.org>; Tue, 17 May 2022 01:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbiEQBkk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 21:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiEQBkk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 21:40:40 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A370427D0
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 18:40:37 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x52so15572649pfu.11
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 18:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pDVzTuq1/SzeqmY81K4QwNMoqKh0Q+6eYN0rYywPrGg=;
        b=hk4Kp+/TbZw1WemFXykuFUK3XCfLW62sVOWtH8hFKd8S/ZKtMfwWNDLY/aZeOPX1od
         tNqI82W3wqaLtWoHFxeWvo5sTxzNdsGf76Jmz699fcSWOwLPbNpWeysyFmVpwUIYMfUN
         Tr/M0R665VtQBKVk3iCVrRVlYgccZ+xIdup39BMtjNtfQf7VhL9lZdK6o1LhRK7y93Sl
         WHyoMybo7haTVf/9Qz9WyNdxCMg0b+9OTBgcmin96sfq/F0xhAWbpahDqVJgSe28pxXe
         XPkZLrS0VTK/AEi+8+FeknVUZVvSfRjq7oCSoQdZCsNQl6+oyEauz9iUjmnHt9kws3nA
         tW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pDVzTuq1/SzeqmY81K4QwNMoqKh0Q+6eYN0rYywPrGg=;
        b=2ciXg5XvNm6cY9uHPrYyIC45sVNhu6AU6TYuz3afwXI/fvJxJ1iMz792vGgEIWRFcO
         0lChyVkd3th413CDYGI/4Kf90shuqU6DMnib0OjReGg5I4El+zlnBaHI1uHmduXJFy0Q
         LRXPM0gBOh7XM0Uhw2OwDay2lJlxBmtCxBl77TWZ0Ll5z7o9i0tJecOHlKuRjux51GOD
         9XzL+i/EXAc1Pd6rOzkfvyyFvU9hQ8ltnWzBCKoRv5TfEXSO9ceoKQwZPvZrgLQgnfhE
         TQIJMEBvLAsv/CrREYVj8LjZr2eRMxGZaNLLDRIhC7BVDJkUabUhP68jKajr5sIdETIy
         SkJA==
X-Gm-Message-State: AOAM531Rym+QJh1CrgOfpgU34Xj9YUQabLBQLIiIAn/lfGWr/z/yZvTr
        dFZzKn8oUD9r6s0jjWm8+WmAAw==
X-Google-Smtp-Source: ABdhPJzmZSe635ly0+vqqRrp2JZMKf7C+CYajifUBm0JR7lxq4b5pcfAzRqCWYwGoOVeaJEYrbA30A==
X-Received: by 2002:aa7:8757:0:b0:50d:48a9:f021 with SMTP id g23-20020aa78757000000b0050d48a9f021mr20027027pfo.24.1652751636829;
        Mon, 16 May 2022 18:40:36 -0700 (PDT)
Received: from [10.254.192.228] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id h1-20020a62de01000000b0050dc762816bsm7523839pfg.69.2022.05.16.18.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 18:40:36 -0700 (PDT)
Message-ID: <1b0d20fb-ec92-6282-b8c3-4c0441ba4f8a@bytedance.com>
Date:   Tue, 17 May 2022 09:39:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [Phishing Risk] Re: [Phishing Risk] [External] Re: [PATCH]
 blk-iocost: fix very large vtime when iocg activate
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com
References: <20220516084045.96004-1-zhouchengming@bytedance.com>
 <YoKb7wpkz3xoCS6s@slm.duckdns.org>
 <bcd0956a-9aa0-3211-801b-1f1eace6de79@bytedance.com>
 <YoL0RHmU4tbS2f/F@slm.duckdns.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YoL0RHmU4tbS2f/F@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/5/17 09:03, Tejun Heo wrote:
> On Tue, May 17, 2022 at 08:57:55AM +0800, Chengming Zhou wrote:
>> #define time_after64(a,b)	\
>> 	(typecheck(__u64, a) &&	\
>> 	 typecheck(__u64, b) && \
>> 	 ((__s64)((b) - (a)) < 0))
>> #define time_before64(a,b)	time_after64(b,a)
>>
>> I still don't get why my changes are wrong. :-)
> 
> It's a wrapping timestamp where a lower value doesn't necessarily mean
> earlier. The before/after relationship is defined only in relation to each
> other. Imagine a cirle representing the whole value range and picking two
> spots in the circle, if one is in the clockwise half from the other, the
> former is said to be earlier than the latter and vice-versa. vtime runs way
> faster than nanosecs and wraps regularly, so we can't use absolute values to
> compare before/after.

Please ignore my previous reply, you are right. I should fix the tracing
analysis tools to test again.

Thanks.

> 
> Thanks.
> 
