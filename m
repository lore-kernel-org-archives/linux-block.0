Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB97C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 15:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DE6218D4
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 15:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uOI0Npeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfCVPV0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:21:26 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42483 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfCVPV0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 11:21:26 -0400
Received: by mail-io1-f68.google.com with SMTP id c4so1984956ioh.9
        for <linux-block@vger.kernel.org>; Fri, 22 Mar 2019 08:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ff2BBJ8h4T+h5snV2MAbeQw4xTUjCCSQD6mdrS/yQ/g=;
        b=uOI0NpeoXhoofor/XoWI8NoN1NMsfBTYBnjUm/qWwpJVM2TluwX0lq47O/ETXkIFmH
         WbVry/Qc7894og9fcKTLcNvv0Tda/ujY8ztk/W8eW+dajgUbtZBtmiVtMFpz+E95Ox4r
         RRuJq6U8JBYqnb5ebnqc514zRnksmm5CRZXK2TO+FfOvOtqTC75R9uoNdHNdPKVRgdLA
         gPzMRh2DGxvxiIGSHECYFof3V59x6/RESoidjArkcS7Da5HJ5Z0tT1iy5toquQeeiCVa
         JUbNR9e6bZapP5Yp9y+yBLhGUg8YijU1IJkRR7JXkBifnuIzVs5c6eIVJV6uUowABPE7
         6UJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ff2BBJ8h4T+h5snV2MAbeQw4xTUjCCSQD6mdrS/yQ/g=;
        b=KWZKsl0U9xyJvsejX0rgPnSsumo60ZGadvzkeGtRDbzYwcFrSkNs6QECk62JXcW4Lu
         GNjnmv2hZZdoLBrVPT0vmdYWnLvWpfzXLrFhRbio8caAQO47csQcLbjO+m5ge3qAI9Vb
         g1nlFgzDK/4V+t2GjNPzHHZlIxKdWT7RBrUvz077LkpM8Mvu7/IsTAnw3n4uSJYmSfet
         Sb3QcQSwfrLPA5MG6UVoudBW7CnvuADS1xB5dRiy3aHp8Zjff0efF0wYX7YRkmZgGYoK
         A7wJT8QYFvIEKgXjBq8GhL+bvSzyKtm2n7ZQ2XaMPoGBC14w/jM7wOZeD638UcdrGg3G
         zzzA==
X-Gm-Message-State: APjAAAWTg0yZ4SBDfa0KP54LrIFAjtW8Q35Mp2GcF47lbhcZU17Ofs+3
        vQ5BwUTNgw3EPvavBwGIb8D2Wre1wGIhPifc
X-Google-Smtp-Source: APXvYqwx+mSiR6/HjdcIEQQL6IeicIU7C98bof6Q2gKxk/Jh5eVTLb5+2WuNMw1ZkRiovELlGplgEw==
X-Received: by 2002:a5e:9e46:: with SMTP id j6mr6667523ioq.270.1553268085313;
        Fri, 22 Mar 2019 08:21:25 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x17sm3299893ior.81.2019.03.22.08.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 08:21:24 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: convert hctx.nr_active to refcount_t
To:     Peter Zijlstra <peterz@infradead.org>,
        Yufen Yu <yuyufen@huawei.com>
Cc:     dwindsor@gmail.com, linux-block@vger.kernel.org
References: <20190322144818.987-1-yuyufen@huawei.com>
 <20190322144818.987-2-yuyufen@huawei.com>
 <20190322150116.GZ6058@hirez.programming.kicks-ass.net>
 <20190322150429.GO6521@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <43a089cb-8124-b159-6263-b986f8ef8781@kernel.dk>
Date:   Fri, 22 Mar 2019 09:21:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322150429.GO6521@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/19 9:04 AM, Peter Zijlstra wrote:
> On Fri, Mar 22, 2019 at 04:01:16PM +0100, Peter Zijlstra wrote:
>> On Fri, Mar 22, 2019 at 10:48:17PM +0800, Yufen Yu wrote:
>>> @@ -2710,7 +2710,7 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
>>>  		return NULL;
>>>  	}
>>>  
>>> -	atomic_set(&hctx->nr_active, 0);
>>> +	refcount_set(&hctx->nr_active, 0);
>>>  	hctx->numa_node = node;
>>>  	hctx->queue_num = hctx_idx;
>>>  
>>
>> That looks bogus, refcount_t cannot inc-from-zero.
> 
> I also don't see a single dec_and_test in that patch, which leads me to
> believe nr_active is not in fact a refcount.

It isn't a refcount at all, it's just a count of how many queues are
active in a shared tag map scenario.

-- 
Jens Axboe

