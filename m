Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07016C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 20:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C727E214C6
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 20:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="C2/iqom0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfAIUIV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:08:21 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40081 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfAIUIU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 15:08:20 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so12917744ita.5
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 12:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ckGbLXy5DYCjJFEqXZAqDD8gp104p4g66g0Ex87iOho=;
        b=C2/iqom0nHp4m/FSpbBOcq7MalckGDSxYXuXaFI1bc3ohNXrYwpvKFArDlRnvELvdU
         uZ0kP6ASZrZJiClW3uFASDNUH8OvZwJw2RT23eGGaiza8Qo2JpHxKLhHSLLkz/trKuId
         OjqZZXBtxr6KHAY21Ol4HIGIJz+soVbVYA8v+lsl/5EGVRM6aBeYMTmvM+wzkZ2kbLG0
         bja4oI2x/3Z/cQkOdwwZ/YlM4BH2NcY9gM9K9x66pnxncBcKbFFlBF6P9cUXZU3YSCpz
         5T60buGQfmJvFdJ+qYYgb8BJV1UQrHwB4QujML9zCVHgUWUnMtuFne6PY4Aji/L92tm6
         JCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ckGbLXy5DYCjJFEqXZAqDD8gp104p4g66g0Ex87iOho=;
        b=doTqDbbTZrRPIi6GQEe4CymEn454K0AI/UdM6yk1UmfmwqEgYo+vyVd7tHwKK01b10
         uC9W7jToyoF0o2/PvtsxYFl743/2j0gAUYLGoSfeYujcC7GlrXr7JRvqwl1BzJr79Nid
         8yddlFMwpKvrdSRiTNeMKzNRUIZnTNfaXjXvRpLcep1dzaz047esvRrhOH1Q1HatAkRc
         S2JrXCxp6/tZSTFNKB4LhxAKTTiBV3wu6LgvlVz9DHpbZLCjXdfllqUtBJYkWBfIhQyH
         hKzOTZNU6pWFKHi4UYUTTOs3y+vtwYK2w7Rm6LKNe7PUNflozqlGVw2P9Rs0dYQe1tmI
         EMwQ==
X-Gm-Message-State: AJcUukfCxjS5LyeY1MJhFYMJCgwVTiF0WpqAyPTcaK6ipdCPmQYbKhz9
        GUvribXMTK8cwjp2kBu6doAoVA==
X-Google-Smtp-Source: ALg8bN6CowxHpkkNIpODxH7NJrtVvE3nPa1U99lPJ5aXNzFn8k0Rs0Iq1W5OiqX7rgkE32J+NNWt/w==
X-Received: by 2002:a24:e44:: with SMTP id 65mr4507849ite.154.1547064500166;
        Wed, 09 Jan 2019 12:08:20 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m45sm7938999iti.10.2019.01.09.12.08.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 12:08:19 -0800 (PST)
Subject: Re: [PATCH 11/16] io_uring: batch io_kiocb allocation
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        jmoyer@redhat.com, avi@scylladb.com
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-12-axboe@kernel.dk> <20190109121340.GD13779@lst.de>
 <0a91dd38-69b8-84ab-f96a-225f09a54ec9@kernel.dk>
 <20190109190321.GA22645@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <68c5faf6-913b-e94f-ccf7-a1fe158091f7@kernel.dk>
Date:   Wed, 9 Jan 2019 13:08:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109190321.GA22645@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/19 12:03 PM, Christoph Hellwig wrote:
> On Wed, Jan 09, 2019 at 09:57:59AM -0700, Jens Axboe wrote:
>> On 1/9/19 5:13 AM, Christoph Hellwig wrote:
>>>> +	if (!state)
>>>> +		req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
>>>
>>> Just return an error here if kmem_cache_alloc fails.
>>>
>>>> +	if (req)
>>>> +		io_req_init(ctx, req);
>>>
>>> Because all the other ones can't reached this with a NULL req.
>>
>> This is different in the current tree, since I properly fixed the
>> ctx ref issue.
> 
> Your tree does a percpu_ref_tryget very first, and then leaks that if
> kmem_cache_alloc_bulk fails, and also is inconsistent for NULL vs
> ERR_PTR returns.  I think you want something like this on top:

I fixed it up while doing the rebase already. Just haven't pushed anything
out until I've had a chance to run it through testing.

-- 
Jens Axboe

