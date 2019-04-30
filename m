Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A5DC04AA8
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 16:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BA621670
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 16:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pmXYskxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfD3QVI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:21:08 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36869 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfD3QVH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 12:21:07 -0400
Received: by mail-io1-f66.google.com with SMTP id a23so12757137iot.4
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2019 09:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BJ/Szi3F8e7NtlTHUjW71joUshnEhSvTTq7CNPbfAFM=;
        b=pmXYskxn//lXkmPtU0nKHsepkH35YTlpXRbi3z1GPYRPvLxbJy0szBBpr4wsdKWdqD
         WzkQV3inBVHiv5/eCljE8Sy8Wp3igwctGaYx5A+tBS7L/3vNeOqopXFTpO++bQeTEZtp
         fn46rDkxgYWOd969ztK/LXdMUveJ9dP6q9tQ+JzpBkYl3WjHP/TxLfwituIjjUBaVE/n
         Q4WjNhxp5e84/fkOvc+r9tCrsI1rc79FRdw0qDWRE06QyQx/5TfnImsCxeErm0FUn5I+
         8ETmxQ7uFqF0YEbtSXaePDNF9MomgkLLC8sPJ8CesbvKa2IywcVknjsL3Jmg7I+3LVLP
         E2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BJ/Szi3F8e7NtlTHUjW71joUshnEhSvTTq7CNPbfAFM=;
        b=J+MwX49cbgxc1MPKdEo2nHS5yXWTwlYsw6vBq5Mm28iRYuXGRYLRKRCj+SFSGfP7FO
         lCBV0FPaKZsMaGyUTSnXveY8UMkHJBLyKV1qSdmjkbIpsHcg9AYhjojHHVzC5G3VePq0
         RMbtnw68YVBnizlwv2/6yReRgShFmMMdTAqw+ywTeR9dJ//yT02x5njqrltZ1FXp/Dei
         tVGZl/erWRa/NqcXnb8dRvVrKK3EhEcXA7kiEq8NhRia1gMYY453z0qBxa4jrZ1CV2iH
         kCoeKnHyqqkdAo+lI+DNm+jMlUUGTlndD7i3tyIeg4ojbt/MqNrdC0fnL8D6Dui7PpW8
         xjEA==
X-Gm-Message-State: APjAAAV23QSs78fERfD8QJvQBI3X3Su34ddIBgaBlW98vlYlelTm5+xK
        CbV4NH9j9PRSg5dTshElpEd3UkvOrsJcHA==
X-Google-Smtp-Source: APXvYqyHZi7/MmV4crDAK1sMzOh4W3n6P74pMbz7VcG+gVYbeLL54dIXcDiH7I1X1/zLjUqxJ1SdEw==
X-Received: by 2002:a5e:d702:: with SMTP id v2mr5547885iom.236.1556641266170;
        Tue, 30 Apr 2019 09:21:06 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w81sm1602623itf.23.2019.04.30.09.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 09:21:04 -0700 (PDT)
Subject: Re: [PATCH] io_uring: avoid page allocation warnings
To:     Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
References: <20190430132405.8268-1-mark.rutland@arm.com>
 <20190430141810.GF13796@bombadil.infradead.org>
 <20190430145938.GA8314@lakrids.cambridge.arm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a1af3017-6572-e828-dc8a-a5c8458e6b5a@kernel.dk>
Date:   Tue, 30 Apr 2019 10:21:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430145938.GA8314@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/30/19 8:59 AM, Mark Rutland wrote:
> On Tue, Apr 30, 2019 at 07:18:10AM -0700, Matthew Wilcox wrote:
>> On Tue, Apr 30, 2019 at 02:24:05PM +0100, Mark Rutland wrote:
>>> In io_sqe_buffer_register() we allocate a number of arrays based on the
>>> iov_len from the user-provided iov. While we limit iov_len to SZ_1G,
>>> we can still attempt to allocate arrays exceeding MAX_ORDER.
>>>
>>> On a 64-bit system with 4KiB pages, for an iov where iov_base = 0x10 and
>>> iov_len = SZ_1G, we'll calculate that nr_pages = 262145. When we try to
>>> allocate a corresponding array of (16-byte) bio_vecs, requiring 4194320
>>> bytes, which is greater than 4MiB. This results in SLUB warning that
>>> we're trying to allocate greater than MAX_ORDER, and failing the
>>> allocation.
>>>
>>> Avoid this by passing __GFP_NOWARN when allocating arrays for the
>>> user-provided iov_len. We'll gracefully handle the failed allocation,
>>> returning -ENOMEM to userspace.
>>>
>>> We should probably consider lowering the limit below SZ_1G, or reworking
>>> the array allocations.
>>
>> I'd suggest that kvmalloc is probably our friend here ... we don't really
>> want to return -ENOMEM to userspace for this case, I don't think.
> 
> Sure. I'll go verify that the uring code doesn't assume this memory is
> physically contiguous.
> 
> I also guess we should be passing GFP_KERNEL_ACCOUNT rateh than a plain
> GFP_KERNEL.

kvmalloc() is fine, the io_uring code doesn't care about the layout of
the memory, it just uses it as an index.

-- 
Jens Axboe

