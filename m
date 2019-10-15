Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF81ECE588
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 14:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7272D20640
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 14:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IZFDK2qt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733150AbfJOOwQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:52:16 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44760 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733028AbfJOOwP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 10:52:15 -0400
Received: by mail-io1-f67.google.com with SMTP id w12so46435485iol.11
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2019 07:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tlcKAfjO9zxaTc91HQ3HX1OXiVJLekecU1OTYhDm5ds=;
        b=IZFDK2qtCtgL/IvDwrLM5g4txRkRdHjoCvGlGBi78/If6CaZ5nwScUKVi46bufCXJz
         YhXc80GyYi3zbEvQH+BBg3H5JCJtPzzqQJdDKVsx0n9+mPg2+CMHdIRFkLR38ao5U5Vi
         +f3nlK0osjGBp1huCgLFIZFKfFzI86HSGJ0BGx8kfYD3bWcKbHi2bhECfAm7ekFVJr5r
         QQ9WX0cZ1qWrnivS6iDecF4xUKoC8udgomMqtNjIWDpK0lL4jf0xmZ56fAPIEdSBciy5
         QuLfREwX2/xoo5owX5jVoLj5lNXwX74KExlNpyKnkocewippPUNva6bCvqc1mP3b5QpB
         fF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tlcKAfjO9zxaTc91HQ3HX1OXiVJLekecU1OTYhDm5ds=;
        b=UjIiqQjatgh7OiFTCdn4/mZ2wnWhD2oLqTpOH4rrCg2aQuB3qFkVsef/dsDrbAZflg
         oYEKwg4QOba69gRN1trOAqjwZIL1LqxZeOHFelMkK1qgCMqYASwJKmhy+3sbQmW0nKTM
         x91UlJWEbC+OvlLCq08Q5hYshqiRI+Q3M1emrADh2NtZiRintep3eZcxFk/S0b37+9PG
         KsI6/HscOEHFp3pEvK0yAPvYcmAP/oSaaAD5gdkwevcmnbbMqK5vH/zy5au7pz3p6GOG
         JlnPnqnvdnLhAM82iUw2YhrwhJ1LTrj9M7Jrkznv7PoXznjPbh3n6EI8pBGX3rOtg03Q
         8cGg==
X-Gm-Message-State: APjAAAVvdmaPYqlOrJS4oP2UfLSqrJD9uj4kJ3EWwKDBsbLMhCFtq8Cf
        //NiodY8N/1wpcyq0ZwE8svzJQ==
X-Google-Smtp-Source: APXvYqwwSS62kdbBj7gKvJMB2WnKIA3tGhwxAW0H9eeJKOGL/S4naJYSl236pOAPRUSOvXwirXOWYQ==
X-Received: by 2002:a02:5846:: with SMTP id f67mr42423839jab.43.1571151133711;
        Tue, 15 Oct 2019 07:52:13 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r138sm19655789iod.59.2019.10.15.07.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 07:52:12 -0700 (PDT)
Subject: Re: [PATCH V3] io_uring: consider the overflow of sequence for
 timeout req
To:     yangerkun <yangerkun@huawei.com>, linux-block@vger.kernel.org
Cc:     yi.zhang@huawei.com, houtao1@huawei.com
References: <20191015135929.30912-1-yangerkun@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d0561a29-14aa-c915-c99d-8bbb2f7740e0@kernel.dk>
Date:   Tue, 15 Oct 2019 08:52:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015135929.30912-1-yangerkun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/15/19 7:59 AM, yangerkun wrote:
> Now we recalculate the sequence of timeout with 'req->sequence =
> ctx->cached_sq_head + count - 1', judge the right place to insert
> for timeout_list by compare the number of request we still expected for
> completion. But we have not consider about the situation of overflow:
> 
> 1. ctx->cached_sq_head + count - 1 may overflow. And a bigger count for
> the new timeout req can have a small req->sequence.
> 
> 2. cached_sq_head of now may overflow compare with before req. And it
> will lead the timeout req with small req->sequence.
> 
> This overflow will lead to the misorder of timeout_list, which can lead
> to the wrong order of the completion of timeout_list. Fix it by reuse
> req->submit.sequence to store the count, and change the logic of
> inserting sort in io_timeout.

Thanks, this looks great. Applied for 5.4.

-- 
Jens Axboe

