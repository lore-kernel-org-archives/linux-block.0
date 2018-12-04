Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28EDC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6262E2082F
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="szpMTxp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6262E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbeLDPZX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:25:23 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46491 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeLDPZX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 10:25:23 -0500
Received: by mail-io1-f65.google.com with SMTP id v10so13866370ios.13
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 07:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lvpgZO1UgT6Q3AH5GoGsYBSqvzosw1xaX6rYfnJji7c=;
        b=szpMTxp/vvdQLu96wUESMkuqp9Wbszjf2ugRRGiz2NzsFxmNDTc5ZZpKTnP5zbwfrZ
         dt8a+eBusz5R68nzkMybWZYoyp4TDfiWy18cCLarqQ3hTuC4J5QN7wLSTv1zO4h2DhRp
         vZl/lOpim0aKNMAnUyn9YAxGCMGhCqk9g3IDJzP1I/wJFZOksnLklY5O28gfoBR/SNWi
         QZifionGWl42IRJRCU7lx2f8x2YsTVpbutDDpOoidr474aQEjGov9kVcvin6Ga97ppKm
         9ijHI8WvfhqcjP8kzFFcJIiFTmU0B6ma3tAZA+pqy2STm3JO2vVM+xRGswoV6PYeXr9F
         HH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lvpgZO1UgT6Q3AH5GoGsYBSqvzosw1xaX6rYfnJji7c=;
        b=o3GOIfFBJNCoUJmQQoXmjU+krG2jHBRAEVxhrZx4dbmx2XLG9NmAdset+DYrlHX/5/
         bDniLon5yk8BY8Lq93DVGATPNwzDx6AoHfew0TzoBYDopsyicNvAlKeOqKuQjVcrYqyu
         pcy+qO4obXxqjYlzmA7m+FtxujBqhbnATWFwntdLIJ8kw3VtjURxGYJHxdRlzqS0EwZa
         QiG+qVYvIJkYRZFs8EBe3cxDX2VbZtoCcU/HtJpP/hTCJVJvwMrizNeOPZCmayFhyNM+
         kaZIzLDnSR9sWAghrrhj7mfhxhNE1MahefZepMozvdBFhkR0yiIaXvGHdMxWqqLHRxpl
         3DYQ==
X-Gm-Message-State: AA+aEWYo/TFWWth/HT9rlPur1zxFHzrZabsMEODMgwlJzDyUhtj+95TM
        U9hfOJN2dJ7u8xXDONRzxMRFRVTJjMg=
X-Google-Smtp-Source: AFSGD/WXUxswA3l7nKg/NdE90Pt+hSWgzmql6ErDNk7aJzXvwUVQWyMSwkymX5Pz5LYXvyusCCwVOQ==
X-Received: by 2002:a5d:9aca:: with SMTP id x10mr17445302ion.19.1543937122049;
        Tue, 04 Dec 2018 07:25:22 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u18sm7010494iom.15.2018.12.04.07.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 07:25:21 -0800 (PST)
Subject: Re: [PATCH 24/27] block: implement bio helper to add iter kvec pages
 to bio
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
References: <20181130165646.27341-1-axboe@kernel.dk>
 <20181130165646.27341-25-axboe@kernel.dk>
 <20181130192102.GP2217@ZenIV.linux.org.uk> <20181204145513.GH3180@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0cc73c45-c75c-dde2-3354-d1ccfd554688@kernel.dk>
Date:   Tue, 4 Dec 2018 08:25:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204145513.GH3180@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/4/18 7:55 AM, Christoph Hellwig wrote:
> On Fri, Nov 30, 2018 at 07:21:02PM +0000, Al Viro wrote:
>> On Fri, Nov 30, 2018 at 09:56:43AM -0700, Jens Axboe wrote:
>>> For an ITER_KVEC, we can just iterate the iov and add the pages
>>> to the bio directly.
>>
>>> +		page = virt_to_page(kv->iov_base);
>>> +		size = bio_add_page(bio, page, kv->iov_len,
>>> +					offset_in_page(kv->iov_base));
>>
>> Who said that you *can* do virt_to_page() on those?  E.g. vmalloc()'ed
>> addresses are fine for ITER_KVEC, etc.
> 
> In this particular case the caller it seems the callers knows what kind
> of pages we have, but we need to properly document this at the very least.
> 
> Note that in the completely generic case iov_base could also point to
> memory without a struct page at all (e.g. ioremap()ed memory).

That's why I went to ITER_BVEC instead, that's much saner for this
use case.

-- 
Jens Axboe

