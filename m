Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D400C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 19:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20F42171F
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 19:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pkT72aJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfA1TcM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:32:12 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54272 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbfA1TcM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 14:32:12 -0500
Received: by mail-it1-f193.google.com with SMTP id i145so277251ita.4
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 11:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tMDms07Wrs7ALD1Hv6qBJ0IdyZg3V5YTY/5VLY2vv1o=;
        b=pkT72aJds3x7nLz97Ro7h2kG+KvdeSxV2nvqn0pbXX7Gotu524p2zm2MoYL4dwSc8k
         hRmI036/j8jFInav68wmQNADjI6xsUQTXqF90FhOPX8gFh6HXWWC7VLpBkbCXxxq0PR4
         PLaEU9TM6WItz31dFAAVPHuz5FHouqw7Z5aZpnalouVKiAVCH4h/KQyAxcrBLZ55C7H2
         gugRUs1aGfYItZlmzdrpdXQ6MAh+tXT1RVeRXdJa6FEfJU8KJ8HURgNqh0QmzCD+/LhS
         NN6Wh4HZjbb0xqP3qCimLjNYFKkM3liuRzbrg966agC9VrrKIvfAcviYCloZdkKSIBJi
         DX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tMDms07Wrs7ALD1Hv6qBJ0IdyZg3V5YTY/5VLY2vv1o=;
        b=nsTx8jGwrsWqqm4NIOw1wuluUBoY1q4E/1vLI+CP/mt+kIvyd2Mu/VYXy4D4KfYqFQ
         V7QxgZuHlbvD1SpPMRVM8GI6fM3DZ2LHpdnzUETgoz2/aAotOQDo6cAbe5xw+wB/nzw+
         pnMp3NBY42iouPkIWDruHFkaV2zhJhpxJr/plDcnsNqaYgpWM4G3OmV44pLbMgo2HHP/
         Z9o5nneESuB1CU0YXCsLJF+YKIybjvHQFJw8IZZy9T91riG/N2ZwAHND+7w11q8Xb7zO
         RG2258eNnkHbMN97UncrbVS/Ah1ItZJhOz+QeDKP0DvoBiROOlWC0jmtFSmaS5PAwTOq
         fWxg==
X-Gm-Message-State: AJcUukdtAkJ33eKX7miNBx9UBKXMln3cvrOTotDj4XsNf6wiqu6njoxs
        7vN90d8JHgg7WeCoaIinsnjH6g==
X-Google-Smtp-Source: ALg8bN5cFRPrqn0rj5f3rBBIGDHEcc79Zaq/H2GdK9fbUZwrZcscgzY1G/99VZJ86Mj0RHAmLKxIvg==
X-Received: by 2002:a24:fa04:: with SMTP id v4mr9620777ith.175.1548703931076;
        Mon, 28 Jan 2019 11:32:11 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id n129sm216713itb.20.2019.01.28.11.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 11:32:10 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org
References: <20190123153536.7081-1-axboe@kernel.dk>
 <20190123153536.7081-6-axboe@kernel.dk> <20190128145700.GA9795@lst.de>
 <42a5b12b-8d3a-2495-ad53-6a6fdd4504c6@kernel.dk>
 <20190128163436.GA12427@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7a076774-f099-521c-8bf5-dc8c7c763bc4@kernel.dk>
Date:   Mon, 28 Jan 2019 12:32:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128163436.GA12427@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 9:34 AM, Christoph Hellwig wrote:
> On Mon, Jan 28, 2019 at 09:26:42AM -0700, Jens Axboe wrote:
>>>> +static void io_free_scq_urings(struct io_ring_ctx *ctx)
>>>> +{
>>>> +	if (ctx->sq_ring) {
>>>> +		page_frag_free(ctx->sq_ring);
>>>> +		ctx->sq_ring = NULL;
>>>> +	}
>>>> +	if (ctx->sq_sqes) {
>>>> +		page_frag_free(ctx->sq_sqes);
>>>> +		ctx->sq_sqes = NULL;
>>>> +	}
>>>> +	if (ctx->cq_ring) {
>>>> +		page_frag_free(ctx->cq_ring);
>>>> +		ctx->cq_ring = NULL;
>>>> +	}
>>>
>>> Why is this using the page_frag helpers?  Also the callers just free
>>> these ctx structure, so there isn't much of a point zeroing them out.
>>
>> Why not use the page frag helpers? No point in open-coding it. I can
>> kill the zeroing, double call would be a bug anyway.
> 
> Because they are at a different level of abstraction, and someone
> might change the implementation, and is unlikely to catch the io_uring
> mix of interfaces.  If you think this is really useful we should also
> export the helpers under a different name and with documentation.
> (and add a __get_free_pages version that returns a pointer..)

Fair enough, I'll avoid using the page_frag_free().

-- 
Jens Axboe

