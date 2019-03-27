Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307DAC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 15:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A42206B8
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 15:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nmssiUp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfC0PoY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:44:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45064 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfC0PoY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 11:44:24 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so14432589iom.12
        for <linux-block@vger.kernel.org>; Wed, 27 Mar 2019 08:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=55L26UrdizISDDMKio3IKsRWGI4nYZglciiOKMWh9L8=;
        b=nmssiUp2GGU2IrPk09YY42yP5iapVfhY5F/u9ePI9xyJhAoBVZdZZnXW2GRdZN3W/u
         tYSnQAJjW6rM7JVhqqxvmK7pvC39lzeMHJpHTBYnMeFtPHqSWQMeE+1XA+eGPasZ9iGc
         +59jqvUCm4NL+LrYQMpavNwYHXxFfirV5TT8lo6/WAlq4qOMSZY34at0nCqNYry3S5BT
         dPQRs19Vw2p84xxA4cV+T3FWIlN96tytSdrHJE8uXb5G8SQn96b7ZKquaalyaLCQJ2s1
         FLpSXOjbT8SG8lujnfdafdcPzYkhWu7uOxE0XCA8bx2GKU+OeovaYfQ5aEdFFZCqoBpy
         jLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=55L26UrdizISDDMKio3IKsRWGI4nYZglciiOKMWh9L8=;
        b=c7/yviT+Q+hao8sKOBoUlXZEX1N8hZH47OMBHW0sAtyVbz/5dtlwUj8asncQwzP0n1
         dth6MHthpP2Z7gvxR8taxV41Q0RJqluq3UVCvMkqRupN/7EoJ6kdR6w4YxjeNr9KAtDA
         cuDNLarAje8NEhs0ZnY8w42ciOEE4f9PsqCMwCm8MTgY73oxKPjgPur3G/6Pk6x8Egvm
         sLLj93CBxZRVZs/3JPvVRScxzbol+F819SxGtdSkvNhnQsJtYE2kqIvgbgMJPFdTkC3n
         JZaIhL0gIjDHA/wXhQlRoijuYsqUqfksO7RaNfScbBJUmeCJqUQYBOSUYpwsoWGwNGaP
         z6mw==
X-Gm-Message-State: APjAAAV3ye0n30uKlAVkb7rzQP/jy0wVSYu+HKFk8AN0tSsrWGlxgrZL
        /5D1wp5MMrngNU13IF03PLJAJg==
X-Google-Smtp-Source: APXvYqxpvO80rpQexuX2RsCQO3OJilN6Ahrfkyu7x7vw6VtCMtc9ORChqlGH832YMje9jaUgGuXlag==
X-Received: by 2002:a6b:8b06:: with SMTP id n6mr3726365iod.72.1553701463257;
        Wed, 27 Mar 2019 08:44:23 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f14sm5986933ion.46.2019.03.27.08.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 08:44:22 -0700 (PDT)
Subject: Re: [PATCH V2 00/10] block: enable multi-page bvec for passthrough IO
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        ris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190317100112.8106-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e15258e5-6869-7dc1-5ea2-31c86a6aaa24@kernel.dk>
Date:   Wed, 27 Mar 2019 09:44:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190317100112.8106-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/17/19 4:01 AM, Ming Lei wrote:
> Hi,
> 
> Now the whole IO stack is capable of handling multi-page bvec, and it has
> been enabled in the normal FS IO path. However, it isn't done for
> passthrough IO.
> 
> Without enabling multi-bvec for passthough IO, we won't go ahead for
> optimizing related IO paths, such as bvec merging, bio_add_pc_page
> simplification.
> 
> This patch enables multi-page bvec for passthrough IO. Turns out
> bio_add_pc_page() is simpliefied a lot, especially the physical segment
> number of passthrough bio is always same with bio.bi_vcnt. Also the
> bvec merging inside bio is killed.
> 
> blktests(block/029) is added for covering passthough IO path, and this
> patchset does pass the new block/029 test.
> 
> 	https://marc.info/?l=linux-block&m=155175063417139&w=2

Merged for 5.2, thanks Ming.

-- 
Jens Axboe

