Return-Path: <SRS0=jyL6=AO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02083C433E0
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 14:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D324720884
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 14:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZLr3yWEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgGCOVD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgGCOVD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jul 2020 10:21:03 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFCEC08C5C1
        for <linux-block@vger.kernel.org>; Fri,  3 Jul 2020 07:21:02 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j19so8304680pgm.11
        for <linux-block@vger.kernel.org>; Fri, 03 Jul 2020 07:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vAD2zJiUB8aWDvbEyukXx75nzHQlka5Iu4C7LRPaszw=;
        b=ZLr3yWEyTY8rEO1gRNK7qUPmXtVkd/RuG5r14+YR+vr2PIoSgLACD9MmijZedzMG+O
         Me7tZw4prKv1pRVVaPuhkyxR6jaKzzxGN4irzKqerqDIj6nUyXY772wo+jHrGwQFKsBi
         KevFU9oEsruHOB8d6EbBUvyH1URRoWi4BSUpuUlXITT2kvxMpGsezJc33E9uYeZ/+tsv
         fErW7DnFaOE7YTKuwInk7rEUgsYW0QNLjX5Ve8RAfXxHX66L6CmG9wOz6TVrmDQqUGot
         tyHgruWMYonEidx3mpqrIbbJA07HL7xQjcQ/w3RNS6eIdS1wNLTAxMfOkdQNva9kOoRK
         lTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vAD2zJiUB8aWDvbEyukXx75nzHQlka5Iu4C7LRPaszw=;
        b=FZRrkCUoZ3NOgM6qZ0SqT5ggCN0djDJ9m8SoA7CbLbGOj503rxyK7kf30zdS9ZKJO1
         enWmcmLcXqfEnEq8Ip9EXaMoD/iZyYioqrJ3/R5U8IWjAfHj5ziqI08pJq9op7+jB377
         k9UoR4LXnDGTiug2n5Vc3CuM/cHiZk4dpZLHqSm2Jy77tfvwsdJrV805IBXuTxDbb4hg
         uc2WzYqFW50ZP4f1JIdnnjWFvjvwyLBwLKTWzKERHXuWysAZAW1m94KNSOdhgn3QguD/
         rjvHnpW9P0Qj8717gzOWvnBxqMrJpPP7ydfst35tWIeqNXb81gyTsVv9cWD4+SAqPahR
         ItUw==
X-Gm-Message-State: AOAM530n0iVqyzPS5h2DhD5zic/MLHc69FAVRJMhdfsvK1/xV+ILYWWr
        KLgBQMLtpR1NZ5dfUY5nqNCRDMP1NYr8Yg==
X-Google-Smtp-Source: ABdhPJybji4zjDFGaImVj2lcYMGn0dyNs61ApXeRUV6GU10xXAHr1TMDxQKDMGenuxO8I+tkuzPz+A==
X-Received: by 2002:a63:ee48:: with SMTP id n8mr29368104pgk.292.1593786062339;
        Fri, 03 Jul 2020 07:21:02 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x1sm11498491pju.3.2020.07.03.07.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 07:21:01 -0700 (PDT)
Subject: Re: [PATCH V2] null_blk: add helper for deleting the nullb_list
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200703013130.18712-1-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <af504f32-c8a8-c13e-580e-27dc915a0c07@kernel.dk>
Date:   Fri, 3 Jul 2020 08:21:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200703013130.18712-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/2/20 7:31 PM, Chaitanya Kulkarni wrote:
> The nullb_list is destroyed when error occurs in the null_init() and
> when removing the module in null_exit(). The identical code is repeated
> in those functions which can be a part of helper function. This also
> removes the extra variable struct nullb *nullb in the both functions.

Applied, thanks.

-- 
Jens Axboe

