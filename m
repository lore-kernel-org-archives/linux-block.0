Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808A1C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 15:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C16206B8
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 15:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="f/8yDMAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbfB1PKe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:10:34 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42773 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387753AbfB1PKe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 10:10:34 -0500
Received: by mail-io1-f67.google.com with SMTP id p196so16795372iod.9
        for <linux-block@vger.kernel.org>; Thu, 28 Feb 2019 07:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b2O4liK5rWuRITrmRHBGs5lGUYC5NYLywTq/Tl3WjLo=;
        b=f/8yDMAahZ4wqYDa59ixiKd8DKzId8bVBH5NPMy6N9iPipbu8meaKeJ6riA20VRTCy
         QswSOKRJAGSg0FFOxYlRv1qy8k+XjxT7K01Oke79HC9vYiSTraa0NuWmaAIBhUmx1iPx
         zA8iDWgsYcLfud39ddUj01ULWBF2v15cp3X063NXzLdgvhkdXr6K9pBf4p1V1jkGGJBm
         IU+S+ytG+VWvEfQTbSryPghme0nY8R91JvInoni5EQv1MzJJohZR1EGObT8UXM7Yc/B/
         5jBxhHnnBFipvFNVnS/MWJCxD+8mfmPPHo3/YwclrNrYHr/QAjSj0WMv0u6NKliyu8uz
         NCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b2O4liK5rWuRITrmRHBGs5lGUYC5NYLywTq/Tl3WjLo=;
        b=S+9xeuxb9jEv4G6KbfmjwDnFcoZunduLWlsoQXFaGVRMEaQndYvZfFJ5Kr5V0sMAbk
         B9ajGS399QFJK2Nggd5q2PkA9cod4EpcPBEtDauSx91mxaI8jHS5r13zJM3jgzB6XKJh
         NZ8w9PaIzBOYFMnaRElShxZvVCs/WPr4eJvG2bmwCwvWhlhIWe40b5A4XBYiB73GJj3N
         /HYKv5Qr2MeOiMLS82nr1nvAoHnuZl3z/K+OP/QsVPCFZuaOgkAEpZZaH1vlQQ8aMjeY
         nf4AJkyk64XratXRvgi+ioMaNt14FCT9ZOmJ9OIvhD8kEJ6kPS6mORB7RDxusLruomaj
         iD8w==
X-Gm-Message-State: APjAAAV0ZJ4EKqR+c737DxYjs4Z0o+xOwzcPWeTJskvLCS5yXBP0NrGC
        MAzk78Br4ze93Gszjq0sIVQNshnoh/Fzbw==
X-Google-Smtp-Source: APXvYqxcSHn/X4JJONlTqgv5NbKxXwaIc9h0EMRUbb0pWclYWQaAPDqm5PSWye9FeYY99m7Bb1lEUw==
X-Received: by 2002:a5d:97c8:: with SMTP id k8mr5654460ios.267.1551366632575;
        Thu, 28 Feb 2019 07:10:32 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f12sm7896005ioj.81.2019.02.28.07.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 07:10:31 -0800 (PST)
Subject: Re: [PATCH 4/4] block: introduce mp_bvec_for_each_page() for
 iterating over page
To:     Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20190227124013.4828-1-ming.lei@redhat.com>
 <20190227124013.4828-5-ming.lei@redhat.com>
 <20190228141319.GA18069@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <01975ec9-5a0a-0bb2-b08b-01f0cbf15acd@kernel.dk>
Date:   Thu, 28 Feb 2019 08:10:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190228141319.GA18069@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/28/19 7:13 AM, Christoph Hellwig wrote:
> On Wed, Feb 27, 2019 at 08:40:13PM +0800, Ming Lei wrote:
>> mp_bvec_for_each_segment() is a bit big for the iteration, so introduce
>> a light-weight helper for iterating over pages, then 32bytes stack
>> space can be saved.
> 
> The version in Jens' tree seems to add this helper, but no actual
> users..

io_uring uses it, which is based on the block branch.

But hopefully that too can go away, if the iov/bio no-ref stuff is
reviewed + merged...

-- 
Jens Axboe

